local GlobalScope = (getgenv and getgenv()) or _G or shared

if type(GlobalScope.MM2_Cleanup) == "function" then
    pcall(GlobalScope.MM2_Cleanup)
end

local Players            = game:GetService("Players")
local RunService         = game:GetService("RunService")
local UserInputService    = game:GetService("UserInputService")
local ReplicatedStorage  = game:GetService("ReplicatedStorage")
local Workspace          = game:GetService("Workspace")
local Lighting           = game:GetService("Lighting")
local TweenService       = game:GetService("TweenService")
local TeleportService     = game:GetService("TeleportService")
local HttpService        = game:GetService("HttpService")
local VirtualUser        = game:GetService("VirtualUser")
local CollectionService  = game:GetService("CollectionService")
local StarterGui         = game:GetService("StarterGui")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera

local S = {
    SilentAim          = false,
    SilentAimTargets   = "Enemy Role",
    SilentAimPart      = "Head",
    SilentAimFOV       = 250,
    SilentAimUseFOV    = true,
    SilentAimShowFOV   = false,
    SilentAimVisible   = false,
    SilentAimSelected  = nil,

    KillAura           = false,
    KillAuraRadius     = 18,
    KillAuraDelay      = 0.25,
    HideSwing          = true,
    SwingWindow        = 0.35,

    GodMode            = false,
    AutoDodge          = false,
    EvadeMode          = "Launch Upward",
    DodgeDistance      = 12,
    DodgeJump          = 30,

    AutoKillMurderer   = false,
    AutoKillSheriff    = false,
    AutoKillAll        = false,
    KillMethod         = "Teleport + Attack",
    KillReturn         = true,
    KillHoldTime       = 0.16,
    KillCooldown       = 0.45,

    AutoEquip          = false,
    AutoGrabGun        = false,
    GrabReturn         = true,
    GunTeleportShot    = true,
    Triggerbot         = false,
    TriggerKey         = Enum.KeyCode.V,
    RemoteKill         = false,

    AutoCoins          = false,
    CoinMode           = "Smooth Glide",
    GlideSpeed         = 25,
    TouchRange         = 12,
    StopWhenFull       = true,
    CoinDelay          = 0.08,
    CoinRadius         = 0,
    CoinReturn         = true,
    CoinRoundOnly      = true,
    CoinsCollected     = 0,

    ESP                = false,
    ESPBox             = true,
    ESPName            = true,
    ESPDistance        = true,
    ESPHealth          = false,
    ESPRole            = true,
    ESPTracer          = false,
    ESPChams           = false,
    ESPTeamCheck       = false,
    CoinESP            = false,
    CoinESPTracer      = false,
    Fullbright         = false,
    NoFog              = false,
    Ambient            = 150,

    ColorMurderer      = Color3.fromRGB(255, 60, 60),
    ColorSheriff       = Color3.fromRGB(60, 140, 255),
    ColorInnocent      = Color3.fromRGB(120, 255, 120),
    ColorDead          = Color3.fromRGB(120, 120, 120),
    ColorCoin          = Color3.fromRGB(255, 215, 0),

    WalkSpeed          = 16,
    WalkSpeedOn        = false,
    JumpPower          = 50,
    JumpPowerOn        = false,
    InfiniteJump       = false,
    Fly                = false,
    FlySpeed           = 60,
    Noclip             = false,
    Glide              = false,
    GlideGravity       = 40,
    AntiVoid           = false,

    Hitbox             = false,
    HitboxSize         = 12,
    HitboxTransparency = 0.7,
    HitboxTarget       = "Murderer",
    FlingPower         = 9000,
    FlingDuration      = 0.5,
    FlingAllDelay      = 0.35,
    FlingAll           = false,
    SpinFling          = false,

    AntiAFK            = true,
    Notifications      = true,
    ToggleKey          = Enum.KeyCode.RightShift,
}

local Connections   = {}
local Threads       = {}
local ESPObjects    = {}
local CoinESPObjects = {}
local HitboxCache   = {}
local Unloading     = false

local function Track(conn)
    if conn then table.insert(Connections, conn) end
    return conn
end

local function Spawn(fn)
    local thread = task.spawn(function()
        local ok, err = pcall(fn)
        if not ok and not Unloading then
            warn("[MM2] thread error: " .. tostring(err))
        end
    end)
    table.insert(Threads, thread)
    return thread
end

local function Loop(interval, cond, fn)
    return Spawn(function()
        while not Unloading do
            if cond() then
                local ok, err = pcall(fn)
                if not ok then warn("[MM2] loop error: " .. tostring(err)) end
            end
            task.wait(interval)
        end
    end)
end

local Notifier

local function Notify(title, content, duration)
    if not S.Notifications then return end
    if Notifier then
        Notifier:Notify({ Title = title or "MM2", Content = content or "", Duration = duration or 3 })
    else
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = title or "MM2", Text = content or "", Duration = duration or 3,
            })
        end)
    end
end

local function GetCharacter(plr)
    plr = plr or LocalPlayer
    return plr and plr.Character
end

local function GetHumanoid(plr)
    local char = GetCharacter(plr)
    return char and char:FindFirstChildOfClass("Humanoid")
end

local function GetRoot(plr)
    local char = GetCharacter(plr)
    return char and (char:FindFirstChild("HumanoidRootPart") or char.PrimaryPart)
end

local function IsAlive(plr)
    local hum = GetHumanoid(plr)
    return hum ~= nil and hum.Health > 0
end

local function DistanceTo(part)
    local root = GetRoot(LocalPlayer)
    if not root or not part then return math.huge end
    return (root.Position - part.Position).Magnitude
end

local function WorldToScreen(pos)
    local screenPos, onScreen = Camera:WorldToViewportPoint(pos)
    return Vector2.new(screenPos.X, screenPos.Y), onScreen, screenPos.Z
end

local function SafeDestroy(inst)
    if inst then pcall(function() inst:Destroy() end) end
end

local Remotes            = ReplicatedStorage:FindFirstChild("Remotes")
local GameplayRemotes    = Remotes and Remotes:FindFirstChild("Gameplay")
local InventoryRemotes   = Remotes and Remotes:FindFirstChild("Inventory")

local CurrentRoundClient, WeaponService, SpectateService

pcall(function()
    local modules = ReplicatedStorage:WaitForChild("Modules", 5)
    if modules then
        local crc = modules:FindFirstChild("CurrentRoundClient")
        if crc then CurrentRoundClient = require(crc) end
        local spec = modules:FindFirstChild("SpectateService")
        if spec then SpectateService = require(spec) end
    end
end)

pcall(function()
    local services = ReplicatedStorage:FindFirstChild("ClientServices")
    local ws = services and services:FindFirstChild("WeaponService")
    if ws then WeaponService = require(ws) end
end)

local function GetRoundData(plr)
    if not plr then return nil end
    if CurrentRoundClient and type(CurrentRoundClient.PlayerData) == "table" then
        return CurrentRoundClient.PlayerData[plr.Name]
    end
    return nil
end

local function WeaponKind(tool)
    if not (tool and tool:IsA("Tool")) then return nil end
    if tool:HasTag("Weapon_Knife") then return "Knife" end
    if tool:HasTag("Weapon_Gun") then return "Gun" end
    local name = tool.Name:lower()
    if name:find("knife") then return "Knife" end
    if name:find("gun") or name:find("revolver") then return "Gun" end
    return nil
end

local function InferRole(plr)
    local char, backpack = GetCharacter(plr), plr:FindFirstChildOfClass("Backpack")
    local function scan(container)
        if not container then return nil end
        for _, tool in ipairs(container:GetChildren()) do
            local kind = WeaponKind(tool)
            if kind == "Knife" then return "Murderer" end
            if kind == "Gun" then return "Sheriff" end
        end
        return nil
    end
    return scan(char) or scan(backpack) or "Innocent"
end

local function GetRole(plr)
    local data = GetRoundData(plr)
    if data and data.Role then return data.Role end
    return InferRole(plr)
end

local function IsDeadInRound(plr)
    local data = GetRoundData(plr)
    if data then return data.Dead == true end
    return not IsAlive(plr)
end

local function IsRoundActive()
    if CurrentRoundClient and type(CurrentRoundClient.PlayerData) == "table" then
        for _, data in pairs(CurrentRoundClient.PlayerData) do
            if type(data) == "table" and data.Role then return true end
        end
    end
    return false
end

local function GetPlayerWithRole(role)
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and GetRole(plr) == role and not IsDeadInRound(plr) then
            return plr
        end
    end
    return nil
end

local function GetMurderer() return GetPlayerWithRole("Murderer") end
local function GetSheriff()
    return GetPlayerWithRole("Sheriff") or GetPlayerWithRole("Hero")
end

local function MyRole() return GetRole(LocalPlayer) end
local function AmMurderer() return MyRole() == "Murderer" end
local function AmSheriff()
    local r = MyRole()
    return r == "Sheriff" or r == "Hero"
end

local function GetHeldWeapon()
    local char = GetCharacter(LocalPlayer)
    if not char then return nil end
    for _, tool in ipairs(char:GetChildren()) do
        if WeaponKind(tool) then return tool end
    end
    return nil
end

local function EquipWeapon()
    local char = GetCharacter(LocalPlayer)
    local hum  = GetHumanoid(LocalPlayer)
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if not (char and hum and backpack) then return GetHeldWeapon() end

    local held = GetHeldWeapon()
    if held then return held end

    for _, tool in ipairs(backpack:GetChildren()) do
        if WeaponKind(tool) then
            pcall(function() hum:EquipTool(tool) end)
            return tool
        end
    end
    return nil
end

local function ValidTarget(plr)
    if not plr or plr == LocalPlayer then return false end
    if not IsAlive(plr) then return false end
    if IsDeadInRound(plr) then return false end
    if not GetRoot(plr) then return false end
    return true
end

local function GetAimPart(plr)
    local char = GetCharacter(plr)
    if not char then return nil end
    return char:FindFirstChild(S.SilentAimPart)
        or char:FindFirstChild("Head")
        or char:FindFirstChild("HumanoidRootPart")
        or char.PrimaryPart
end

local function IsVisible(part)
    if not (part and part.Parent) then return false end
    local origin = Camera.CFrame.Position
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = { GetCharacter(LocalPlayer), Camera }
    local dir = part.Position - origin
    local result = Workspace:Raycast(origin, dir, params)
    if not result then return true end
    return result.Instance:IsDescendantOf(part.Parent)
end

local function WithinFOV(part)
    if not S.SilentAimUseFOV then return true end
    if not part then return false end
    local screen, onScreen = WorldToScreen(part.Position)
    if not onScreen then return false end
    local mouse = UserInputService:GetMouseLocation()
    return (screen - Vector2.new(mouse.X, mouse.Y)).Magnitude <= S.SilentAimFOV
end

local function PassesFilters(plr)
    if not ValidTarget(plr) then return false end
    local part = GetAimPart(plr)
    if not WithinFOV(part) then return false end
    if S.SilentAimVisible and not IsVisible(part) then return false end
    return true
end

local function ResolveTarget()
    local mode = S.SilentAimTargets

    if mode == "Selected" then
        local plr = S.SilentAimSelected and Players:FindFirstChild(S.SilentAimSelected)
        return PassesFilters(plr) and plr or nil
    end

    if mode == "Murderer" then
        local m = GetMurderer()
        return PassesFilters(m) and m or nil
    end

    if mode == "Sheriff" then
        local s = GetSheriff()
        return PassesFilters(s) and s or nil
    end

    if mode == "Enemy Role" then
        if AmSheriff() then
            local m = GetMurderer()
            if PassesFilters(m) then return m end
        elseif AmMurderer() then
            local s = GetSheriff()
            if PassesFilters(s) then return s end
        end
    end

    local best, bestDist = nil, math.huge
    local mouse = UserInputService:GetMouseLocation()
    for _, plr in ipairs(Players:GetPlayers()) do
        if ValidTarget(plr) then
            local part = GetAimPart(plr)
            if part then
                local screen, onScreen = WorldToScreen(part.Position)
                if onScreen then
                    local dist = (screen - Vector2.new(mouse.X, mouse.Y)).Magnitude
                    if dist <= S.SilentAimFOV and dist < bestDist then
                        if not S.SilentAimVisible or IsVisible(part) then
                            best, bestDist = plr, dist
                        end
                    end
                end
            end
        end
    end
    return best
end

local OriginalGetMouseTargetCFrame, OriginalGetTargetPosition

local ForcedAimTarget = nil

local function InstallAimHooks()
    if not WeaponService then
        Notify("MM2", "WeaponService not found — silent aim unavailable.", 5)
        return false
    end
    if OriginalGetMouseTargetCFrame then return true end

    OriginalGetMouseTargetCFrame = WeaponService.GetMouseTargetCFrame
    OriginalGetTargetPosition    = WeaponService.GetTargetPosition

    local function ResolveAimCFrame()
        local ok, result = pcall(function()
            if ForcedAimTarget then
                local part = GetAimPart(ForcedAimTarget)
                if part then return CFrame.new(part.Position) end
            end
            if not S.SilentAim then return nil end
            local target = ResolveTarget()
            local part = target and GetAimPart(target)
            return part and CFrame.new(part.Position) or nil
        end)
        return ok and result or nil
    end

    WeaponService.GetMouseTargetCFrame = function(...)
        local aim = ResolveAimCFrame()
        if aim then return aim end
        return OriginalGetMouseTargetCFrame(...)
    end

    WeaponService.GetTargetPosition = function(...)
        local aim = ResolveAimCFrame()
        if aim then return aim end
        return OriginalGetTargetPosition(...)
    end

    return true
end

local function RemoveAimHooks()
    if not WeaponService then return end
    if OriginalGetMouseTargetCFrame then
        WeaponService.GetMouseTargetCFrame = OriginalGetMouseTargetCFrame
        OriginalGetMouseTargetCFrame = nil
    end
    if OriginalGetTargetPosition then
        WeaponService.GetTargetPosition = OriginalGetTargetPosition
        OriginalGetTargetPosition = nil
    end
end

local function FindShootingSpot(targetRoot)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Blacklist
    params.FilterDescendantsInstances = { GetCharacter(LocalPlayer), targetRoot.Parent, Camera }

    local offsets = {
        CFrame.new(0, 6, 8), CFrame.new(0, 6, -8), CFrame.new(8, 6, 0), CFrame.new(-8, 6, 0),
        CFrame.new(0, 3, 5), CFrame.new(0, 12, 0),
    }
    for _, offset in ipairs(offsets) do
        local spot = (targetRoot.CFrame * offset).Position
        if not Workspace:Raycast(spot, targetRoot.Position - spot, params) then
            return CFrame.lookAt(spot, targetRoot.Position)
        end
    end

    local close = (targetRoot.CFrame * CFrame.new(0, 0, 3)).Position
    return CFrame.lookAt(close, targetRoot.Position)
end

local LastKillAttempt = 0

local FireTouch = firetouchinterest

local function TouchAllParts(tool, targetChar)
    if not (tool and targetChar) then return false end
    local fti = FireTouch
    if type(fti) ~= "function" then return false end

    local handle = tool:FindFirstChild("Handle") or tool:FindFirstChildWhichIsA("BasePart")
    if not handle then return false end

    local touched = false
    for _, part in ipairs(targetChar:GetDescendants()) do
        if part:IsA("BasePart") then
            pcall(fti, handle, part, 0)
            pcall(fti, handle, part, 1)
            touched = true
        end
    end
    return touched
end

local function SnapshotTracks(hum)
    local seen = {}
    local animator = hum and hum:FindFirstChildOfClass("Animator")
    if animator then
        for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
            seen[track] = true
        end
    end
    return seen, animator
end

local function StopNewTracks(seen, animator)
    if not animator then return end
    for _, track in ipairs(animator:GetPlayingAnimationTracks()) do
        if not seen[track] then
            pcall(function() track:Stop(0) end)
        end
    end
end

local function SwingAndTouch(tool, targetChar)
    if not (tool and targetChar) then return end
    local hum = GetHumanoid(LocalPlayer)
    local seen, animator = SnapshotTracks(hum)

    pcall(function() tool:Activate() end)

    local deadline = tick() + S.SwingWindow
    repeat
        TouchAllParts(tool, targetChar)
        if S.HideSwing then StopNewTracks(seen, animator) end
        task.wait(0.03)
    until tick() >= deadline or Unloading
end

local function TryRemoteKill(target)
    if not (S.RemoteKill and GameplayRemotes and target) then return end
    local char = GetCharacter(target)
    if not char then return end
    for _, remoteName in ipairs({ "KnifeKill", "GunKill", "KillEvent", "EliminatePlayer" }) do
        local remote = GameplayRemotes:FindFirstChild(remoteName)
        if remote and remote:IsA("RemoteEvent") then
            pcall(function() remote:FireServer(target) end)
            pcall(function() remote:FireServer(char) end)
            pcall(function() remote:FireServer(target.Name) end)
        end
    end
end

local function KillPlayer(target)
    if not ValidTarget(target) then return false end
    if tick() - LastKillAttempt < S.KillCooldown then return false end
    LastKillAttempt = tick()

    local myRoot = GetRoot(LocalPlayer)
    local theirRoot = GetRoot(target)
    if not (myRoot and theirRoot) then return false end

    local tool = EquipWeapon()
    if not tool then return false end

    local origin = myRoot.CFrame
    local method = S.KillMethod

    local usingGun = WeaponKind(tool) == "Gun"

    if usingGun then
        InstallAimHooks()

        local moved = false
        if S.GunTeleportShot then
            pcall(function() myRoot.CFrame = FindShootingSpot(theirRoot) end)
            moved = true
            task.wait(S.KillHoldTime)
        end

        ForcedAimTarget = target
        for _ = 1, 2 do
            pcall(function() tool:Activate() end)
            task.wait(S.KillHoldTime)
        end
        ForcedAimTarget = nil
        TryRemoteKill(target)

        if moved and S.KillReturn then
            pcall(function()
                local root = GetRoot(LocalPlayer)
                if root then root.CFrame = origin end
            end)
        end
        return true
    end

    if method == "Teleport + Attack" or method == "Both" then
        pcall(function()
            myRoot.CFrame = theirRoot.CFrame * CFrame.new(0, 0, 1.6)
        end)
        task.wait()
        pcall(function() tool:Activate() end)
        task.wait(S.KillHoldTime)
        pcall(function() tool:Activate() end)
    end

    if method == "Touch Interest" or method == "Both" then
        SwingAndTouch(tool, GetCharacter(target))
    end

    TryRemoteKill(target)

    if S.KillReturn and (method == "Teleport + Attack" or method == "Both") then
        task.wait(S.KillHoldTime)
        pcall(function()
            local root = GetRoot(LocalPlayer)
            if root then root.CFrame = origin end
        end)
    end

    return true
end

Loop(0.05, function() return S.KillAura and IsAlive(LocalPlayer) end, function()
    local tool = GetHeldWeapon() or (S.AutoEquip and EquipWeapon())
    if not tool then return end
    local myRoot = GetRoot(LocalPlayer)
    if not myRoot then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if ValidTarget(plr) then
            local root = GetRoot(plr)
            if root and (root.Position - myRoot.Position).Magnitude <= S.KillAuraRadius then
                SwingAndTouch(tool, GetCharacter(plr))
                TryRemoteKill(plr)
                task.wait(S.KillAuraDelay)
            end
        end
    end
end)

Loop(0.25, function() return S.AutoKillMurderer and IsAlive(LocalPlayer) end, function()
    local murderer = GetMurderer()
    if ValidTarget(murderer) then KillPlayer(murderer) end
end)

Loop(0.25, function() return S.AutoKillSheriff and IsAlive(LocalPlayer) end, function()
    local sheriff = GetSheriff()
    if ValidTarget(sheriff) then KillPlayer(sheriff) end
end)

Loop(0.15, function() return S.AutoKillAll and IsAlive(LocalPlayer) end, function()
    for _, plr in ipairs(Players:GetPlayers()) do
        if not S.AutoKillAll then break end
        if ValidTarget(plr) then
            KillPlayer(plr)
            task.wait(S.KillCooldown)
        end
    end
end)

Loop(0.5, function() return S.AutoEquip and IsAlive(LocalPlayer) end, function()
    EquipWeapon()
end)

local function LooksLikeDroppedGun(inst)
    if not (inst:IsA("Tool") or inst:IsA("Model")) then return false end

    local name = inst.Name:lower()
    if not (name:find("gun") or name:find("revolver") or name:find("drop")) then
        return false
    end

    if inst:FindFirstAncestorOfClass("Backpack") then return false end
    if inst.Parent and Players:GetPlayerFromCharacter(inst.Parent) then return false end

    return inst:FindFirstChild("Handle") ~= nil
        or inst:FindFirstChildWhichIsA("BasePart", true) ~= nil
end

local function IHaveAGun()
    if WeaponKind(GetHeldWeapon()) == "Gun" then return true end
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")
    if backpack then
        for _, tool in ipairs(backpack:GetChildren()) do
            if WeaponKind(tool) == "Gun" then return true end
        end
    end
    return false
end

local Grabbing = false

local function GrabGun(inst)
    if Grabbing or not S.AutoGrabGun then return false end
    if IHaveAGun() then return false end

    local handle = inst:FindFirstChild("Handle") or inst:FindFirstChildWhichIsA("BasePart", true)
    local myRoot = GetRoot(LocalPlayer)
    local char   = GetCharacter(LocalPlayer)
    if not (handle and myRoot and char) then return false end

    Grabbing = true
    local origin = myRoot.CFrame

    if type(FireTouch) == "function" then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("BasePart") then
                pcall(FireTouch, part, handle, 0)
                pcall(FireTouch, part, handle, 1)
            end
        end
        task.wait(0.3)
    end

    if not IHaveAGun() and handle.Parent then
        pcall(function() myRoot.CFrame = handle.CFrame end)
        task.wait(0.4)
        if S.GrabReturn then
            pcall(function()
                local root = GetRoot(LocalPlayer)
                if root then root.CFrame = origin end
            end)
        end
    end

    Grabbing = false
    return IHaveAGun()
end

Track(Workspace.DescendantAdded:Connect(function(inst)
    if not S.AutoGrabGun or Unloading then return end
    if not IsAlive(LocalPlayer) then return end
    if LooksLikeDroppedGun(inst) then
        task.wait(0.15)
        Spawn(function() GrabGun(inst) end)
    end
end))

Loop(1, function() return S.AutoGrabGun and IsAlive(LocalPlayer) and not IHaveAGun() end, function()
    for _, inst in ipairs(Workspace:GetDescendants()) do
        if LooksLikeDroppedGun(inst) then
            GrabGun(inst)
            return
        end
    end
end)

Track(UserInputService.InputBegan:Connect(function(input, processed)
    if processed or not S.Triggerbot then return end
    if input.KeyCode ~= S.TriggerKey then return end
    Spawn(function()
        while S.Triggerbot and UserInputService:IsKeyDown(S.TriggerKey) and not Unloading do
            local tool = GetHeldWeapon()
            local target = ResolveTarget()
            if tool and target then
                pcall(function() tool:Activate() end)
            end
            task.wait(0.12)
        end
    end)
end))

local CoinContainerCache = nil
local LastContainerScan  = 0
local LastFullScan       = 0
local FullScanCache      = {}

local function GetCoinContainer()
    if CoinContainerCache and CoinContainerCache.Parent then
        return CoinContainerCache
    end
    if tick() - LastContainerScan < 2 then return nil end
    LastContainerScan = tick()

    for _, name in ipairs({ "CoinObjects", "CoinContainer", "Coins" }) do
        local found = Workspace:FindFirstChild(name, true)
        if found then
            CoinContainerCache = found
            return found
        end
    end
    return nil
end

local function LooksLikeCoin(part)
    if not part:IsA("BasePart") then return false end
    local parent = part.Parent
    if not parent then return false end
    return part.Name == "MainCoin"
        or part.Name == "Coin"
        or parent.Name == "Coin"
        or parent.Name:match("^Coin") ~= nil
end

local CollectedCoinIDs = {}
local BagCount, BagMax = nil, nil
local CoinEventHooked = false

if GameplayRemotes then
    local coinCollected = GameplayRemotes:FindFirstChild("CoinCollected")
    if coinCollected and coinCollected:IsA("RemoteEvent") then
        CoinEventHooked = true
        Track(coinCollected.OnClientEvent:Connect(function(coinId, max, count)
            if coinId ~= nil then CollectedCoinIDs[coinId] = true end
            if type(max) == "number" and type(count) == "number" then
                BagMax, BagCount = max, count
                if count <= max then
                    S.CoinsCollected = S.CoinsCollected + 1
                end
            end
        end))
    end

    local coinsStarted = GameplayRemotes:FindFirstChild("CoinsStarted")
    if coinsStarted and coinsStarted:IsA("RemoteEvent") then
        Track(coinsStarted.OnClientEvent:Connect(function()
            table.clear(CollectedCoinIDs)
            BagCount = 0
        end))
    end
end

local function BagIsFull()
    return BagMax ~= nil and BagCount ~= nil and BagMax > 0 and BagCount >= BagMax
end

local function GetCoins()
    local coins, seen = {}, {}

    for _, part in ipairs(CollectionService:GetTagged("CoinVisual")) do
        if part:IsA("BasePart") and part.Parent
            and not part:GetAttribute("Collected")
            and not part:GetAttribute("Delete")
            and not CollectedCoinIDs[part:GetAttribute("CoinID") or false] then
            table.insert(coins, part)
        end
    end
    if #coins > 0 then return coins end

    local function consider(part)
        if not LooksLikeCoin(part) then return end
        local model = part.Parent
        if seen[model] then return end
        seen[model] = true
        table.insert(coins, part)
    end

    local container = GetCoinContainer()
    if container then
        for _, inst in ipairs(container:GetDescendants()) do
            consider(inst)
        end
    end

    if #coins == 0 and tick() - LastFullScan > 1 then
        LastFullScan = tick()
        for _, inst in ipairs(Workspace:GetDescendants()) do
            consider(inst)
        end
        FullScanCache = coins
    elseif #coins == 0 then
        for _, part in ipairs(FullScanCache) do
            if part.Parent then table.insert(coins, part) end
        end
    end

    return coins
end

local function TouchCoin(part)
    local root = GetRoot(LocalPlayer)
    if not (root and part and part.Parent) then return false end
    local fti = FireTouch
    if type(fti) ~= "function" then return false end

    local targets = { part }
    for _, d in ipairs(part:GetDescendants()) do
        if d:IsA("BasePart") then table.insert(targets, d) end
    end
    for _, t in ipairs(targets) do
        pcall(fti, root, t, 0)
        pcall(fti, root, t, 1)
    end
    return true
end

local function CollectCoinRemote(part)
    if not GameplayRemotes then return false end
    local model = part.Parent
    for _, name in ipairs({ "GetCoin", "CoinCollected" }) do
        local remote = GameplayRemotes:FindFirstChild(name)
        if remote and remote:IsA("RemoteEvent") then
            pcall(function() remote:FireServer(model) end)
            pcall(function() remote:FireServer(part) end)
        end
    end
    return true
end

local function CollectCoin(part, homeCFrame)
    local mode = S.CoinMode
    local root = GetRoot(LocalPlayer)
    if not root then return end

    if mode == "Silent Touch" then
        if (root.Position - part.Position).Magnitude > S.TouchRange then
            return false
        end
        if not TouchCoin(part) then return false end

    elseif mode == "Teleport" then
        pcall(function() root.CFrame = part.CFrame end)
        task.wait(0.06)

    elseif mode == "Smooth Glide" then
        local dist = (root.Position - part.Position).Magnitude
        local tween = TweenService:Create(
            root,
            TweenInfo.new(math.max(dist / S.GlideSpeed, 0.05), Enum.EasingStyle.Linear),
            { CFrame = CFrame.new(part.Position) * (root.CFrame - root.CFrame.Position) }
        )
        tween:Play()

        while tween.PlaybackState == Enum.PlaybackState.Playing do
            if not S.AutoCoins or Unloading or not part.Parent then
                tween:Cancel()
                break
            end
            task.wait()
        end

        TouchCoin(part)

    elseif mode == "Remote" then
        CollectCoinRemote(part)
        TouchCoin(part)
    end

    if not CoinEventHooked then
        S.CoinsCollected = S.CoinsCollected + 1
    end
    return true
end

Loop(0.05, function() return S.AutoCoins and IsAlive(LocalPlayer) end, function()
    if S.CoinRoundOnly and not IsRoundActive() then return end
    if S.StopWhenFull and BagIsFull() then return end

    local root = GetRoot(LocalPlayer)
    if not root then return end

    local home = root.CFrame
    local coins = GetCoins()
    if #coins == 0 then return end

    local remaining = {}
    for _, part in ipairs(coins) do
        if S.CoinRadius <= 0 or (part.Position - home.Position).Magnitude <= S.CoinRadius then
            table.insert(remaining, part)
        end
    end

    while #remaining > 0 do
        if not S.AutoCoins or Unloading then break end
        local here = (GetRoot(LocalPlayer) or root).Position

        local bestIndex, bestDist = nil, math.huge
        for i, part in ipairs(remaining) do
            if part.Parent then
                local d = (part.Position - here).Magnitude
                if d < bestDist then bestIndex, bestDist = i, d end
            end
        end
        if not bestIndex then break end

        local part = table.remove(remaining, bestIndex)
        local collected = CollectCoin(part, home)

        if collected == false and S.CoinMode == "Silent Touch" then break end

        task.wait(S.CoinDelay)
    end

    if S.CoinReturn and S.CoinMode == "Teleport" then
        local currentRoot = GetRoot(LocalPlayer)
        if currentRoot then
            pcall(function() currentRoot.CFrame = home end)
        end
    end
end)

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "MM2_ESP"
pcall(function()
    ESPFolder.Parent = (gethui and gethui()) or game:GetService("CoreGui")
end)
if not ESPFolder.Parent then ESPFolder.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local function RoleColor(plr)
    if IsDeadInRound(plr) then return S.ColorDead end
    local role = GetRole(plr)
    if role == "Murderer" then return S.ColorMurderer end
    if role == "Sheriff" or role == "Hero" then return S.ColorSheriff end
    return S.ColorInnocent
end

local HasDrawing = (typeof(Drawing) == "table") or (type(Drawing) == "table")

local function NewDrawing(class, props)
    if not HasDrawing then return nil end
    local ok, obj = pcall(function() return Drawing.new(class) end)
    if not ok or not obj then return nil end
    for k, v in pairs(props or {}) do
        pcall(function() obj[k] = v end)
    end
    return obj
end

local function CreatePlayerESP(plr)
    if ESPObjects[plr] then return ESPObjects[plr] end

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "MM2_" .. plr.Name
    billboard.AlwaysOnTop = true
    billboard.Size = UDim2.new(0, 220, 0, 46)
    billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    billboard.Parent = ESPFolder

    local label = Instance.new("TextLabel")
    label.BackgroundTransparency = 1
    label.Size = UDim2.new(1, 0, 1, 0)
    label.Font = Enum.Font.GothamBold
    label.TextSize = 13
    label.TextStrokeTransparency = 0.4
    label.TextColor3 = Color3.new(1, 1, 1)
    label.Text = plr.Name
    label.Parent = billboard

    local highlight = Instance.new("Highlight")
    highlight.FillTransparency = 0.65
    highlight.OutlineTransparency = 0
    highlight.Enabled = false
    highlight.Parent = ESPFolder

    local data = {
        Billboard = billboard,
        Label     = label,
        Highlight = highlight,
        Box       = NewDrawing("Square", { Thickness = 1, Filled = false, Transparency = 1 }),
        Tracer    = NewDrawing("Line", { Thickness = 1, Transparency = 1 }),
    }
    ESPObjects[plr] = data
    return data
end

local function DestroyPlayerESP(plr)
    local data = ESPObjects[plr]
    if not data then return end
    SafeDestroy(data.Billboard)
    SafeDestroy(data.Highlight)
    if data.Box then pcall(function() data.Box:Remove() end) end
    if data.Tracer then pcall(function() data.Tracer:Remove() end) end
    ESPObjects[plr] = nil
end

local function HidePlayerESP(data)
    if not data then return end
    data.Billboard.Enabled = false
    data.Highlight.Enabled = false
    if data.Box then data.Box.Visible = false end
    if data.Tracer then data.Tracer.Visible = false end
end

Track(RunService.RenderStepped:Connect(function()
    if Unloading then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local data = ESPObjects[plr] or CreatePlayerESP(plr)
            local char = GetCharacter(plr)
            local root = GetRoot(plr)
            local head = char and char:FindFirstChild("Head")

            local show = S.ESP and root and IsAlive(plr)
            if show and S.ESPTeamCheck and GetRole(plr) == MyRole() then show = false end

            if not show then
                HidePlayerESP(data)
            else
                local color = RoleColor(plr)

                local parts = {}
                if S.ESPName then table.insert(parts, plr.Name) end
                if S.ESPRole then table.insert(parts, "[" .. GetRole(plr) .. "]") end
                if S.ESPDistance then
                    table.insert(parts, string.format("%dm", math.floor(DistanceTo(root))))
                end
                if S.ESPHealth then
                    local hum = GetHumanoid(plr)
                    if hum then
                        table.insert(parts, string.format("%d HP", math.floor(hum.Health)))
                    end
                end

                data.Billboard.Adornee = head or root
                data.Billboard.Enabled = #parts > 0
                data.Label.Text = table.concat(parts, "  ")
                data.Label.TextColor3 = color

                data.Highlight.Enabled = S.ESPChams
                if S.ESPChams then
                    data.Highlight.Adornee = char
                    data.Highlight.FillColor = color
                    data.Highlight.OutlineColor = color
                end

                local screen, onScreen, depth = WorldToScreen(root.Position)
                if data.Box then
                    if S.ESPBox and onScreen and depth > 0 then
                        local scale = 1 / (depth * math.tan(math.rad(Camera.FieldOfView * 0.5)) * 2) * 1000
                        local w, h = math.clamp(3 * scale, 6, 400), math.clamp(4.5 * scale, 10, 600)
                        data.Box.Size = Vector2.new(w, h)
                        data.Box.Position = Vector2.new(screen.X - w / 2, screen.Y - h / 2)
                        data.Box.Color = color
                        data.Box.Visible = true
                    else
                        data.Box.Visible = false
                    end
                end
                if data.Tracer then
                    if S.ESPTracer and onScreen and depth > 0 then
                        data.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                        data.Tracer.To = screen
                        data.Tracer.Color = color
                        data.Tracer.Visible = true
                    else
                        data.Tracer.Visible = false
                    end
                end
            end
        end
    end
end))

Loop(0.35, function() return true end, function()
    if not S.CoinESP then
        for part, data in pairs(CoinESPObjects) do
            SafeDestroy(data.Billboard)
            if data.Tracer then pcall(function() data.Tracer:Remove() end) end
            CoinESPObjects[part] = nil
        end
        return
    end

    local live = {}
    for _, part in ipairs(GetCoins()) do
        live[part] = true
        if not CoinESPObjects[part] then
            local billboard = Instance.new("BillboardGui")
            billboard.AlwaysOnTop = true
            billboard.Size = UDim2.new(0, 90, 0, 22)
            billboard.StudsOffset = Vector3.new(0, 1.6, 0)
            billboard.Adornee = part
            billboard.Parent = ESPFolder

            local label = Instance.new("TextLabel")
            label.BackgroundTransparency = 1
            label.Size = UDim2.new(1, 0, 1, 0)
            label.Font = Enum.Font.GothamBold
            label.TextSize = 12
            label.TextStrokeTransparency = 0.4
            label.TextColor3 = S.ColorCoin
            label.Text = "Coin"
            label.Parent = billboard

            CoinESPObjects[part] = {
                Billboard = billboard,
                Label = label,
                Tracer = NewDrawing("Line", { Thickness = 1, Transparency = 0.7 }),
            }
        end
    end

    for part, data in pairs(CoinESPObjects) do
        if not live[part] or not part.Parent then
            SafeDestroy(data.Billboard)
            if data.Tracer then pcall(function() data.Tracer:Remove() end) end
            CoinESPObjects[part] = nil
        else
            data.Label.TextColor3 = S.ColorCoin
            data.Label.Text = string.format("Coin  %dm", math.floor(DistanceTo(part)))
        end
    end
end)

Track(RunService.RenderStepped:Connect(function()
    if Unloading or not S.CoinESPTracer then
        for _, data in pairs(CoinESPObjects) do
            if data.Tracer then data.Tracer.Visible = false end
        end
        return
    end
    for part, data in pairs(CoinESPObjects) do
        if data.Tracer and part.Parent then
            local screen, onScreen = WorldToScreen(part.Position)
            if onScreen then
                data.Tracer.From = Vector2.new(Camera.ViewportSize.X / 2, Camera.ViewportSize.Y)
                data.Tracer.To = screen
                data.Tracer.Color = S.ColorCoin
                data.Tracer.Visible = true
            else
                data.Tracer.Visible = false
            end
        end
    end
end))

Track(Players.PlayerRemoving:Connect(DestroyPlayerESP))

local FOVCircle = NewDrawing("Circle", {
    Thickness = 1, NumSides = 64, Filled = false, Transparency = 1,
})

Track(RunService.RenderStepped:Connect(function()
    if not FOVCircle then return end
    if Unloading or not (S.SilentAimShowFOV and S.SilentAimUseFOV) then
        FOVCircle.Visible = false
        return
    end
    local mouse = UserInputService:GetMouseLocation()
    FOVCircle.Position = Vector2.new(mouse.X, mouse.Y)
    FOVCircle.Radius = S.SilentAimFOV
    FOVCircle.Color = S.ColorMurderer
    FOVCircle.Visible = true
end))

local LightingBackup = {
    Brightness   = Lighting.Brightness,
    ClockTime    = Lighting.ClockTime,
    FogEnd       = Lighting.FogEnd,
    FogStart     = Lighting.FogStart,
    GlobalShadows = Lighting.GlobalShadows,
    Ambient      = Lighting.Ambient,
    OutdoorAmbient = Lighting.OutdoorAmbient,
}

local function ApplyLighting()
    pcall(function()
        if S.Fullbright then
            Lighting.Brightness = 2
            Lighting.ClockTime = 14
            Lighting.GlobalShadows = false
            local a = Color3.fromRGB(S.Ambient, S.Ambient, S.Ambient)
            Lighting.Ambient = a
            Lighting.OutdoorAmbient = a
        else
            Lighting.Brightness = LightingBackup.Brightness
            Lighting.ClockTime = LightingBackup.ClockTime
            Lighting.GlobalShadows = LightingBackup.GlobalShadows
            Lighting.Ambient = LightingBackup.Ambient
            Lighting.OutdoorAmbient = LightingBackup.OutdoorAmbient
        end

        if S.NoFog then
            Lighting.FogEnd = 1e6
            Lighting.FogStart = 1e6
        else
            Lighting.FogEnd = LightingBackup.FogEnd
            Lighting.FogStart = LightingBackup.FogStart
        end
    end)
end

Loop(0.4, function() return S.WalkSpeedOn or S.JumpPowerOn end, function()
    local hum = GetHumanoid(LocalPlayer)
    if not hum then return end
    if S.WalkSpeedOn then hum.WalkSpeed = S.WalkSpeed end
    if S.JumpPowerOn then
        hum.UseJumpPower = true
        hum.JumpPower = S.JumpPower
    end
end)

Track(UserInputService.JumpRequest:Connect(function()
    if not S.InfiniteJump then return end
    local hum = GetHumanoid(LocalPlayer)
    if hum then
        pcall(function() hum:ChangeState(Enum.HumanoidStateType.Jumping) end)
    end
end))

Track(RunService.Stepped:Connect(function()
    if not S.Noclip or Unloading then return end
    local char = GetCharacter(LocalPlayer)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") and part.CanCollide then
            part.CanCollide = false
        end
    end
end))

local DefaultGravity = Workspace.Gravity
Loop(0.5, function() return true end, function()
    if S.Glide then
        Workspace.Gravity = S.GlideGravity
    elseif Workspace.Gravity ~= DefaultGravity and not S.Glide then
        Workspace.Gravity = DefaultGravity
    end
end)

local FlyVelocity, FlyGyro
local FlyKeys = { W = false, A = false, S = false, D = false, Space = false, Shift = false }

local function StopFly()
    SafeDestroy(FlyVelocity); FlyVelocity = nil
    SafeDestroy(FlyGyro);     FlyGyro = nil
    local hum = GetHumanoid(LocalPlayer)
    if hum then pcall(function() hum.PlatformStand = false end) end
end

local function StartFly()
    local root = GetRoot(LocalPlayer)
    if not root then return end
    StopFly()

    FlyVelocity = Instance.new("BodyVelocity")
    FlyVelocity.MaxForce = Vector3.new(9e9, 9e9, 9e9)
    FlyVelocity.Velocity = Vector3.zero
    FlyVelocity.Parent = root

    FlyGyro = Instance.new("BodyGyro")
    FlyGyro.MaxTorque = Vector3.new(9e9, 9e9, 9e9)
    FlyGyro.P = 9e4
    FlyGyro.CFrame = Camera.CFrame
    FlyGyro.Parent = root
end

Track(RunService.RenderStepped:Connect(function()
    if Unloading then return end
    if not S.Fly then
        if FlyVelocity then StopFly() end
        return
    end

    local root = GetRoot(LocalPlayer)
    if not root then return end
    if not FlyVelocity or FlyVelocity.Parent ~= root then StartFly() end
    if not FlyVelocity then return end

    local dir = Vector3.zero
    local cf = Camera.CFrame
    if FlyKeys.W then dir = dir + cf.LookVector end
    if FlyKeys.S then dir = dir - cf.LookVector end
    if FlyKeys.A then dir = dir - cf.RightVector end
    if FlyKeys.D then dir = dir + cf.RightVector end
    if FlyKeys.Space then dir = dir + Vector3.new(0, 1, 0) end
    if FlyKeys.Shift then dir = dir - Vector3.new(0, 1, 0) end

    if dir.Magnitude > 0 then dir = dir.Unit end
    FlyVelocity.Velocity = dir * S.FlySpeed
    FlyGyro.CFrame = cf
end))

local function SetFlyKey(input, down)
    local key = input.KeyCode
    if key == Enum.KeyCode.W then FlyKeys.W = down
    elseif key == Enum.KeyCode.A then FlyKeys.A = down
    elseif key == Enum.KeyCode.S then FlyKeys.S = down
    elseif key == Enum.KeyCode.D then FlyKeys.D = down
    elseif key == Enum.KeyCode.Space then FlyKeys.Space = down
    elseif key == Enum.KeyCode.LeftShift then FlyKeys.Shift = down end
end

Track(UserInputService.InputBegan:Connect(function(input, processed)
    if not processed then SetFlyKey(input, true) end
end))
Track(UserInputService.InputEnded:Connect(function(input)
    SetFlyKey(input, false)
end))

Loop(0.4, function() return S.AntiVoid end, function()
    local root = GetRoot(LocalPlayer)
    if root and root.Position.Y < -150 then
        pcall(function()
            root.CFrame = CFrame.new(root.Position.X, 40, root.Position.Z)
            root.AssemblyLinearVelocity = Vector3.zero
        end)
    end
end)

local function HitboxWanted(plr)
    if plr == LocalPlayer then return false end
    local mode = S.HitboxTarget
    if mode == "All" then return true end
    local role = GetRole(plr)
    if mode == "Murderer" then return role == "Murderer" end
    if mode == "Sheriff" then return role == "Sheriff" or role == "Hero" end
    if mode == "Innocents" then return role == "Innocent" end
    return false
end

local function RestoreHitbox(plr)
    local saved = HitboxCache[plr]
    if not saved then return end
    local root = GetRoot(plr)
    if root then
        pcall(function()
            root.Size = saved.Size
            root.Transparency = saved.Transparency
            root.LocalTransparencyModifier = saved.LTM or 1
            root.Material = saved.Material
            root.CanCollide = saved.CanCollide
            root.Massless = saved.Massless
        end)
    end
    HitboxCache[plr] = nil
end

Track(RunService.RenderStepped:Connect(function()
    if Unloading or not S.Hitbox then return end
    for plr in pairs(HitboxCache) do
        local root = GetRoot(plr)
        if root then
            root.LocalTransparencyModifier = 0
            root.Transparency = S.HitboxTransparency
        end
    end
end))

Loop(0.2, function() return true end, function()
    for _, plr in ipairs(Players:GetPlayers()) do
        local root = GetRoot(plr)
        if S.Hitbox and root and HitboxWanted(plr) and IsAlive(plr) then
            if not HitboxCache[plr] then
                HitboxCache[plr] = {
                    Size = root.Size,
                    Transparency = root.Transparency,
                    LTM = root.LocalTransparencyModifier,
                    Material = root.Material,
                    CanCollide = root.CanCollide,
                    Massless = root.Massless,
                }
            end
            pcall(function()
                root.Size = Vector3.new(S.HitboxSize, S.HitboxSize, S.HitboxSize)
                root.Transparency = S.HitboxTransparency
                root.LocalTransparencyModifier = 0
                root.Material = Enum.Material.ForceField
                root.CanCollide = false
                root.Massless = true
            end)
        elseif HitboxCache[plr] then
            RestoreHitbox(plr)
        end
    end
end)

local GodTouchCache = {}

local function ApplyGodMode(enable)
    local char = GetCharacter(LocalPlayer)
    if not char then return end
    for _, part in ipairs(char:GetDescendants()) do
        if part:IsA("BasePart") then
            if enable then
                if GodTouchCache[part] == nil then
                    GodTouchCache[part] = part.CanTouch
                end
                pcall(function() part.CanTouch = false end)
            elseif GodTouchCache[part] ~= nil then
                pcall(function() part.CanTouch = GodTouchCache[part] end)
                GodTouchCache[part] = nil
            end
        end
    end
    if not enable then table.clear(GodTouchCache) end
end

Loop(0.35, function() return S.GodMode end, function()
    ApplyGodMode(true)
end)

Loop(0.1, function() return S.AutoDodge and IsAlive(LocalPlayer) end, function()
    local myRoot = GetRoot(LocalPlayer)
    if not myRoot then return end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and GetRole(plr) == "Murderer" and not IsDeadInRound(plr) then
            local theirRoot = GetRoot(plr)
            if theirRoot then
                local offset = myRoot.Position - theirRoot.Position
                if offset.Magnitude <= S.DodgeDistance then
                    local away = offset.Magnitude > 0 and offset.Unit or Vector3.new(1, 0, 0)
                    local shift

                    if S.EvadeMode == "Launch Upward" then
                        shift = Vector3.new(0, S.DodgeJump, 0)
                    elseif S.EvadeMode == "Both" then
                        shift = (away * S.DodgeJump) + Vector3.new(0, S.DodgeJump * 0.6, 0)
                    else
                        shift = away * S.DodgeJump
                    end

                    pcall(function() myRoot.CFrame = myRoot.CFrame + shift end)
                    return
                end
            end
        end
    end
end)

local FlingHome = nil

local function FlingAt(target)
    if not ValidTarget(target) then return false end
    local myRoot    = GetRoot(LocalPlayer)
    local theirRoot = GetRoot(target)
    local hum       = GetHumanoid(LocalPlayer)
    if not (myRoot and theirRoot and hum) then return false end

    local home     = FlingHome or myRoot.CFrame
    local savedVel = myRoot.AssemblyLinearVelocity

    pcall(function() hum.PlatformStand = true end)

    local spin = RunService.Heartbeat:Connect(function()
        local root  = GetRoot(LocalPlayer)
        local tRoot = GetRoot(target)
        if not (root and tRoot) then return end
        root.CFrame = tRoot.CFrame
        root.AssemblyAngularVelocity = Vector3.new(0, S.FlingPower, 0)
    end)

    local started = tick()
    while tick() - started < S.FlingDuration and not Unloading do
        task.wait()
    end
    spin:Disconnect()

    pcall(function()
        local root = GetRoot(LocalPlayer)
        if root then
            root.AssemblyAngularVelocity = Vector3.zero
            root.AssemblyLinearVelocity  = savedVel
            root.CFrame = home
        end
        hum.PlatformStand = false
    end)

    return true
end

Loop(0.1, function() return S.FlingAll and IsAlive(LocalPlayer) end, function()
    local root = GetRoot(LocalPlayer)
    if not root then return end

    FlingHome = root.CFrame

    for _, plr in ipairs(Players:GetPlayers()) do
        if not S.FlingAll then break end
        if ValidTarget(plr) then
            FlingAt(plr)
            task.wait(S.FlingAllDelay)
        end
    end

    FlingHome = nil
end)

Loop(0.03, function() return S.SpinFling and IsAlive(LocalPlayer) end, function()
    local root = GetRoot(LocalPlayer)
    if root then
        root.AssemblyAngularVelocity = Vector3.new(0, S.FlingPower, 0)
    end
end)

local function TeleportTo(cframe)
    local root = GetRoot(LocalPlayer)
    if root and cframe then
        pcall(function() root.CFrame = cframe end)
        return true
    end
    return false
end

local function TeleportToPlayer(plr)
    local root = GetRoot(plr)
    if not root then
        Notify("MM2", "That player has no character right now.", 3)
        return false
    end
    return TeleportTo(root.CFrame * CFrame.new(0, 0, 3))
end

local function TeleportToNearestCoin()
    local coins = GetCoins()
    if #coins == 0 then
        Notify("MM2", "No coins spawned right now.", 3)
        return false
    end
    local best, bestDist = nil, math.huge
    for _, part in ipairs(coins) do
        local d = DistanceTo(part)
        if d < bestDist then best, bestDist = part, d end
    end
    return best and TeleportTo(best.CFrame)
end

local Spectating = nil
local function SpectatePlayer(plr)
    if not plr then
        Camera.CameraSubject = GetHumanoid(LocalPlayer)
        Spectating = nil
        return
    end
    local hum = GetHumanoid(plr)
    if hum then
        Camera.CameraSubject = hum
        Spectating = plr
    end
end

Track(LocalPlayer.Idled:Connect(function()
    if not S.AntiAFK then return end
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end))

local function Rejoin()
    pcall(function()
        TeleportService:Teleport(game.PlaceId, LocalPlayer)
    end)
end

local function ServerHop()
    Spawn(function()
        local ok, body = pcall(function()
            return game:HttpGet(
                "https://games.roblox.com/v1/games/" .. game.PlaceId ..
                "/servers/Public?sortOrder=Asc&limit=100"
            )
        end)
        if not ok then
            Notify("MM2", "Server list request failed.", 4)
            return
        end
        local decoded
        local decodeOk = pcall(function() decoded = HttpService:JSONDecode(body) end)
        if not decodeOk or not decoded or not decoded.data then
            Notify("MM2", "Could not parse the server list.", 4)
            return
        end
        for _, server in ipairs(decoded.data) do
            if server.playing and server.maxPlayers
                and server.playing < server.maxPlayers
                and server.id ~= game.JobId then
                Notify("MM2", "Hopping servers...", 3)
                pcall(function()
                    TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer)
                end)
                return
            end
        end
        Notify("MM2", "No other joinable servers found.", 4)
    end)
end

local ProfileData, InventoryModule, ItemModule, Sync

pcall(function()
    local modules = ReplicatedStorage:FindFirstChild("Modules")
    if modules then
        local pd = modules:FindFirstChild("ProfileData")
        if pd then ProfileData = require(pd) end
        local inv = modules:FindFirstChild("InventoryModule")
        if inv then InventoryModule = require(inv) end
        local item = modules:FindFirstChild("ItemModule")
        if item then ItemModule = require(item) end
    end
    local db = ReplicatedStorage:FindFirstChild("Database")
    local sync = db and db:FindFirstChild("Sync")
    if sync then Sync = require(sync) end
end)

local function DeepCopy(tbl)
    if type(tbl) ~= "table" then return tbl end
    local copy = {}
    for k, v in pairs(tbl) do
        copy[k] = (type(v) == "table") and DeepCopy(v) or v
    end
    return copy
end

local SpoofBackup = nil

local function BackupProfile()
    if SpoofBackup or not ProfileData then return end
    SpoofBackup = {
        Weapons   = DeepCopy(ProfileData.Weapons),
        Materials = DeepCopy(ProfileData.Materials),
        Pets      = DeepCopy(ProfileData.Pets),
        Effects   = DeepCopy(ProfileData.Effects),
    }
end

local function WeaponDB()
    if not Sync then return {} end
    return Sync.Weapons or Sync.Item or {}
end

local function ItemDisplayName(id, data)
    data = data or WeaponDB()[id]
    if not data then return tostring(id) end
    local name = data.ItemName or data.Name or tostring(id)
    local tags = {}
    if data.Rarity then table.insert(tags, data.Rarity) end
    if data.Chroma then table.insert(tags, "Chroma") end
    if data.ItemType then table.insert(tags, data.ItemType) end
    if #tags > 0 then
        return name .. " (" .. table.concat(tags, ", ") .. ")"
    end
    return name
end

local SpoofNameToId = {}

local function ItemsByRarity(rarity)
    local names = {}
    SpoofNameToId = {}
    for id, data in pairs(WeaponDB()) do
        if type(data) == "table" then
            local matches
            if rarity == "All" then
                matches = true
            elseif rarity == "Chroma" then
                matches = data.Chroma == true
            else
                matches = data.Rarity == rarity
            end
            if matches then
                local display = ItemDisplayName(id, data)
                if SpoofNameToId[display] then display = display .. " [" .. id .. "]" end
                SpoofNameToId[display] = id
                table.insert(names, display)
            end
        end
    end
    table.sort(names)
    if #names == 0 then names = { "(nothing found)" } end
    return names
end

local function FireInventoryRefresh()
    if not InventoryRemotes then return end
    for _, name in ipairs({ "InventoryDataChanged", "ProfileDataChanged" }) do
        local ev = InventoryRemotes:FindFirstChild(name)
        if ev and ev:IsA("BindableEvent") then
            pcall(function() ev:Fire("Weapons") end)
            pcall(function() ev:Fire() end)
        end
    end
end

local function RefreshInventoryUI()
    if not InventoryModule then
        Notify("MM2", "InventoryModule not found — open the inventory once, then retry.", 4)
        return false
    end

    local ok = pcall(function()
        local gui = InventoryModule.GUI and InventoryModule.GUI.MyInventory
        local data = InventoryModule.MyInventory
        if gui and data and data.Data then
            InventoryModule.UpdateInventory(gui, data)
            InventoryModule.ConnectEquipButtons()
            InventoryModule.UpdateMyEquip()
        end
    end)

    FireInventoryRefresh()

    if not ok then
        Notify("MM2", "Inventory UI not built yet. Open your inventory, then hit Refresh.", 4)
        return false
    end
    return true
end

local function SpoofAddItem(id, amount)
    if not ProfileData then return false end
    BackupProfile()
    amount = math.max(1, math.floor(tonumber(amount) or 1))
    ProfileData.Weapons = ProfileData.Weapons or { Owned = {}, Equipped = {} }
    ProfileData.Weapons.Owned = ProfileData.Weapons.Owned or {}
    ProfileData.Weapons.Owned[id] = (tonumber(ProfileData.Weapons.Owned[id]) or 0) + amount
    return true
end

local function SpoofBulkAdd(predicate, amount)
    if not ProfileData then
        Notify("MM2", "ProfileData not found.", 4)
        return 0
    end
    BackupProfile()
    local added = 0
    for id, data in pairs(WeaponDB()) do
        if type(data) == "table" and predicate(id, data) then
            if SpoofAddItem(id, amount or 1) then added = added + 1 end
        end
    end
    RefreshInventoryUI()
    return added
end

local SpoofedCurrency = {}

local function Commafy(n)
    local str = tostring(math.floor(tonumber(n) or 0))
    while true do
        local replaced
        str, replaced = str:gsub("^(-?%d+)(%d%d%d)", "%1,%2")
        if replaced == 0 then break end
    end
    return str
end

local function LabelIsCurrency(label, kind)
    local key = kind:lower()
    local node = label
    for _ = 1, 4 do
        if not node then break end
        if node.Name:lower():find(key) then return true end
        node = node.Parent
    end
    return false
end

local function ApplyCurrencySpoof()
    local gui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
    if not gui then return end

    for _, inst in ipairs(gui:GetDescendants()) do
        if inst:IsA("TextLabel") or inst:IsA("TextButton") then
            for kind, value in pairs(SpoofedCurrency) do
                if inst.Text:match("^[%d,%.]+$") and LabelIsCurrency(inst, kind) then
                    local wanted = Commafy(value)
                    if inst.Text ~= wanted then inst.Text = wanted end
                end
            end
        end
    end
end

local function SpoofSetCurrency(kind, value)
    local amount = math.max(0, math.floor(tonumber(value) or 0))

    if ProfileData then
        BackupProfile()
        ProfileData.Materials = ProfileData.Materials or { Owned = {} }
        ProfileData.Materials.Owned = ProfileData.Materials.Owned or {}
        ProfileData.Materials.Owned[kind] = amount
    end

    SpoofedCurrency[kind] = amount
    FireInventoryRefresh()
    ApplyCurrencySpoof()
    return true
end

Loop(0.5, function() return next(SpoofedCurrency) ~= nil end, ApplyCurrencySpoof)

local function SpoofEquip(id)
    if not (ProfileData and Sync) then return false end
    BackupProfile()
    local data = WeaponDB()[id]
    if not data then return false end
    local slot = data.ItemType or "Knife"
    ProfileData.Weapons.Equipped = ProfileData.Weapons.Equipped or {}
    ProfileData.Weapons.Equipped[slot] = id
    pcall(function() InventoryModule.UpdateMyEquip() end)
    return true
end

local MeshBackup  = {}
local SkinMeshes  = { Knife = {}, Gun = {} }
local ActiveSkins = {}
local MeshCache   = {}

local function ReadMesh(inst)
    if inst:IsA("SpecialMesh") or inst:IsA("FileMesh") then
        return { MeshId = inst.MeshId, TextureId = inst.TextureId, Scale = inst.Scale }
    end
    if inst:IsA("MeshPart") then
        return { MeshId = inst.MeshId, TextureId = inst.TextureID }
    end
    return nil
end

local function FindMeshIn(root)
    if not root then return nil end
    local handle = root:FindFirstChild("Handle", true)
    for _, scope in ipairs({ handle, root }) do
        if scope then
            local info = ReadMesh(scope)
            if info and info.MeshId ~= "" then return info end
            for _, d in ipairs(scope:GetDescendants()) do
                info = ReadMesh(d)
                if info and info.MeshId ~= "" then return info end
            end
        end
    end
    return nil
end

local function ResolveItemMesh(itemId)
    if MeshCache[itemId] then return MeshCache[itemId] end

    local data = WeaponDB()[itemId]
    if not data then return nil, "unknown item" end
    local assetId = data.ItemID
    if not assetId then return nil, "the database has no ItemID for this item" end

    local ok, objects = pcall(function()
        return game:GetObjects("rbxassetid://" .. tostring(assetId))
    end)
    if not ok then
        return nil, "this executor doesn't support game:GetObjects — use Copy From Player instead"
    end
    if type(objects) ~= "table" or not objects[1] then
        return nil, "asset " .. tostring(assetId) .. " didn't load (probably private) — use Copy From Player"
    end

    local info
    for _, obj in ipairs(objects) do
        info = FindMeshIn(obj)
        if info then break end
    end
    for _, obj in ipairs(objects) do SafeDestroy(obj) end

    if not info then return nil, "asset " .. tostring(assetId) .. " contains no mesh" end
    info.Chroma = data.Chroma == true
    MeshCache[itemId] = info
    return info
end

local function GetDisplayOf(plr, kind)
    local char = GetCharacter(plr)
    if not char then return nil end

    local ref = char:FindFirstChild("DisplayRef" .. kind)
    if ref and ref:IsA("ObjectValue") and ref.Value and ref.Value.Parent then
        return ref.Value
    end

    local folder = Workspace:FindFirstChild("WeaponDisplays")
    if folder then
        for _, part in ipairs(folder:GetChildren()) do
            if part.Name == kind .. "Display" then
                local rc = part:FindFirstChildOfClass("RigidConstraint")
                local a0 = rc and rc.Attachment0
                if a0 and a0:IsDescendantOf(char) then return part end
            end
        end
    end
    return nil
end

local function GetToolVisualParts(kind)
    local parts = {}
    local char = GetCharacter(LocalPlayer)
    local backpack = LocalPlayer:FindFirstChildOfClass("Backpack")

    local tool
    for _, container in ipairs({ char, backpack }) do
        if container and not tool then
            for _, t in ipairs(container:GetChildren()) do
                if WeaponKind(t) == kind then tool = t break end
            end
        end
    end

    local handle = tool and tool:FindFirstChild("Handle")
    if not handle then return parts end
    table.insert(parts, handle)

    local places = { Workspace }
    local thv = LocalPlayer:FindFirstChild("ToolHandleVisuals", true)
        or (char and char:FindFirstChild("ToolHandleVisuals", true))
    if thv then table.insert(places, thv) end

    for _, place in ipairs(places) do
        for _, inst in ipairs(place:GetChildren()) do
            if inst:IsA("BasePart") then
                local vc = inst:FindFirstChild("VisualConstraint")
                if vc and vc.Attachment0 and vc.Attachment0.Parent == handle then
                    table.insert(parts, inst)
                end
            end
        end
    end
    return parts
end

local function ApplyMesh(part, info, kind)
    local mesh = part:FindFirstChildOfClass("SpecialMesh")
    if not mesh then return false end

    if not MeshBackup[mesh] then
        MeshBackup[mesh] = {
            MeshId = mesh.MeshId,
            TextureId = mesh.TextureId,
            Scale = mesh.Scale,
            VertexColor = mesh.VertexColor,
        }
    end
    SkinMeshes[kind][mesh] = true

    if mesh.MeshId ~= info.MeshId then mesh.MeshId = info.MeshId end
    local tex = info.TextureId or ""
    if mesh.TextureId ~= tex then mesh.TextureId = tex end
    if info.Scale and mesh.Scale ~= info.Scale then mesh.Scale = info.Scale end
    if not info.Chroma and mesh.VertexColor ~= MeshBackup[mesh].VertexColor then
        mesh.VertexColor = MeshBackup[mesh].VertexColor
    end
    return true
end

local function ApplySkin(kind)
    local info = ActiveSkins[kind]
    if not info then return 0 end
    local count = 0
    local display = GetDisplayOf(LocalPlayer, kind)
    if display and ApplyMesh(display, info, kind) then count = count + 1 end
    for _, part in ipairs(GetToolVisualParts(kind)) do
        if ApplyMesh(part, info, kind) then count = count + 1 end
    end
    return count
end

local function RestoreSkins()
    table.clear(ActiveSkins)
    for mesh, saved in pairs(MeshBackup) do
        if mesh.Parent then
            pcall(function()
                mesh.MeshId = saved.MeshId
                mesh.TextureId = saved.TextureId
                mesh.Scale = saved.Scale
                mesh.VertexColor = saved.VertexColor
            end)
        end
    end
    table.clear(MeshBackup)
    table.clear(SkinMeshes.Knife)
    table.clear(SkinMeshes.Gun)
end

local function SpoofSkinFromItem(itemId)
    local data = WeaponDB()[itemId]
    if not data then return false, "unknown item" end
    local kind = (data.ItemType == "Gun") and "Gun" or "Knife"

    local info, err = ResolveItemMesh(itemId)
    if not info then return false, err end

    ActiveSkins[kind] = info
    if ApplySkin(kind) == 0 then
        return true, "stored — it appears as soon as your " .. kind:lower() .. " display spawns"
    end
    return true
end

local function CopySkinFromPlayer(plr, kind)
    if not plr then return false, "pick a player first" end
    local display = GetDisplayOf(plr, kind)
    if not display then
        return false, plr.Name .. " has no " .. kind:lower() .. " display right now"
    end
    local mesh = display:FindFirstChildOfClass("SpecialMesh")
    if not mesh then return false, "their display has no mesh" end

    ActiveSkins[kind] = {
        MeshId = mesh.MeshId,
        TextureId = mesh.TextureId,
        Scale = mesh.Scale,
        Chroma = display:HasTag("ChromaPart"),
    }
    ApplySkin(kind)
    return true
end

Loop(0.5, function() return next(ActiveSkins) ~= nil end, function()
    for kind in pairs(ActiveSkins) do ApplySkin(kind) end
end)

Track(RunService.RenderStepped:Connect(function()
    if Unloading then return end
    local color = Color3.fromHSV((tick() * 0.25) % 1, 0.65, 1)
    local tint = Vector3.new(color.R, color.G, color.B)
    for kind, info in pairs(ActiveSkins) do
        if info.Chroma then
            for mesh in pairs(SkinMeshes[kind]) do
                if mesh.Parent then mesh.VertexColor = tint end
            end
        end
    end
end))

local function SpoofRestore()
    table.clear(SpoofedCurrency)
    if not (SpoofBackup and ProfileData) then
        Notify("MM2", "Nothing to restore — no spoof applied this session.", 3)
        return false
    end
    ProfileData.Weapons   = DeepCopy(SpoofBackup.Weapons)
    ProfileData.Materials = DeepCopy(SpoofBackup.Materials)
    if SpoofBackup.Pets then ProfileData.Pets = DeepCopy(SpoofBackup.Pets) end
    if SpoofBackup.Effects then ProfileData.Effects = DeepCopy(SpoofBackup.Effects) end
    SpoofBackup = nil
    FireInventoryRefresh()
    Notify("MM2", "Real inventory restored. Rejoin for a guaranteed clean UI.", 4)
    return true
end

local Bracket = nil

local function BracketColorToHSV(c)
    if typeof(c) ~= "Color3" then c = Color3.new(1, 1, 1) end
    local h, s, v = Color3.toHSV(c)
    return { h, s, v, 0, false }
end

local function BracketStepDecimals(step)
    if not step or step >= 1 then return 0 end
    local str = string.format("%.6f", step):gsub("0+$", "")
    local dot = str:find("%.", 1)
    if not dot then return 0 end
    return math.clamp(#str - dot, 0, 4)
end

local function WrapBracketTab(rawTab, tabName)
    local tabWrapper = {
        Raw = rawTab,
        CurrentSection = nil,
        NextSide = "Left",
        ElementCount = 0,
    }

    local function flagFor(title)
        tabWrapper.ElementCount = tabWrapper.ElementCount + 1
        return tostring(tabName) .. "/" .. tostring(title or "Element") .. "#" .. tostring(tabWrapper.ElementCount)
    end

    local function tip(el, desc)
        if el and desc and type(el.ToolTip) == "function" then
            pcall(function() el:ToolTip(tostring(desc)) end)
        end
    end

    function tabWrapper:Section(cfg)
        local title = type(cfg) == "string" and cfg or (cfg and (cfg.Title or cfg.Name)) or "Section"
        local side = (type(cfg) == "table" and cfg.Side) or tabWrapper.NextSide
        tabWrapper.NextSide = (side == "Left" and "Right" or "Left")
        local sec = rawTab:Section({ Name = tostring(title), Side = side })
        tabWrapper.CurrentSection = sec
        return sec
    end

    local function getSec()
        if not tabWrapper.CurrentSection then tabWrapper:Section("General") end
        return tabWrapper.CurrentSection
    end

    function tabWrapper:Toggle(cfg)
        cfg = cfg or {}
        local default = false
        if cfg.Default ~= nil then default = cfg.Default elseif cfg.Value ~= nil then default = cfg.Value end
        local el = getSec():Toggle({
            Name = tostring(cfg.Title or "Toggle"),
            Flag = flagFor(cfg.Title),
            Value = default and true or false,
            Callback = function(v)
                if cfg.Callback then
                    local ok, err = pcall(cfg.Callback, v)
                    if not ok then warn("[MM2] toggle callback error: " .. tostring(err)) end
                end
            end,
        })
        tip(el, cfg.Desc)
        el.Set = function(self, v) pcall(function() self:SetValue(v and true or false) end) end
        return el
    end

    function tabWrapper:Slider(cfg)
        cfg = cfg or {}
        local min = tonumber(cfg.Min) or 0
        local max = tonumber(cfg.Max) or 100
        local def = tonumber(cfg.Default) or min
        local step = tonumber(cfg.Step)
        local el = getSec():Slider({
            Name = tostring(cfg.Title or "Slider"),
            Flag = flagFor(cfg.Title),
            Min = min,
            Max = max,
            Value = math.clamp(def, min, max),
            Precise = BracketStepDecimals(step),
            Unit = tostring(cfg.Suffix or ""),
            Callback = function(v)
                v = tonumber(v) or min
                if step and step > 0 then
                    v = math.clamp(min + math.floor((v - min) / step + 0.5) * step, min, max)
                end
                if cfg.Callback then
                    local ok, err = pcall(cfg.Callback, v)
                    if not ok then warn("[MM2] slider callback error: " .. tostring(err)) end
                end
            end,
        })
        tip(el, cfg.Desc)
        el.Set = function(self, v) pcall(function() self:SetValue(tonumber(v) or min) end) end
        return el
    end

    function tabWrapper:Dropdown(cfg)
        cfg = cfg or {}
        local options = cfg.Options or cfg.Values or {}
        local def = cfg.Default or options[1]
        local ready = false
        local current = def

        local function makeList(opts, selected)
            local list = {}
            for _, name in ipairs(opts or {}) do
                local optName = tostring(name)
                table.insert(list, {
                    Name = optName,
                    Mode = "Button",
                    Value = (optName == tostring(selected)),
                    Callback = function(_, option)
                        current = (option and option.Name) or optName
                        if ready and cfg.Callback then
                            local ok, err = pcall(cfg.Callback, current)
                            if not ok then warn("[MM2] dropdown callback error: " .. tostring(err)) end
                        end
                    end,
                })
            end
            return list
        end

        local el = getSec():Dropdown({
            Name = tostring(cfg.Title or "Dropdown"),
            Flag = flagFor(cfg.Title),
            List = makeList(options, def),
        })
        ready = true
        tip(el, cfg.Desc)

        el.Refresh = function(self, newOpts, keepCurrent)
            ready = false
            pcall(function() self:Clear() end)
            newOpts = newOpts or {}
            local sel = newOpts[1]
            if keepCurrent ~= false and current then
                for _, n in ipairs(newOpts) do
                    if tostring(n) == tostring(current) then sel = current break end
                end
            end
            pcall(function() self:BulkAdd(makeList(newOpts, sel)) end)
            current = sel
            ready = true
        end
        el.Set = function(self, name)
            ready = false
            pcall(function() self:SetValue({ tostring(name) }) end)
            current = name
            ready = true
        end
        el.GetValue = function() return current end
        return el
    end

    function tabWrapper:Button(cfg)
        cfg = cfg or {}
        local el = getSec():Button({
            Name = tostring(cfg.Title or "Button"),
            Callback = function()
                if cfg.Callback then
                    task.spawn(function()
                        local ok, err = pcall(cfg.Callback)
                        if not ok then warn("[MM2] button callback error: " .. tostring(err)) end
                    end)
                end
            end,
        })
        tip(el, cfg.Desc)
        return el
    end

    function tabWrapper:Keybind(cfg)
        cfg = cfg or {}
        local def = cfg.Default or "NONE"
        if typeof(def) == "EnumItem" then def = def.Name end
        local el = getSec():Keybind({
            Name = tostring(cfg.Title or "Keybind"),
            Flag = flagFor(cfg.Title),
            Value = tostring(def),
            Callback = function(key, isPressed)
                if not isPressed and cfg.Callback then
                    pcall(cfg.Callback, tostring(key))
                end
            end,
        })
        tip(el, cfg.Desc)
        return el
    end

    function tabWrapper:Colorpicker(cfg)
        cfg = cfg or {}
        local def = cfg.Default or Color3.fromRGB(255, 255, 255)
        local ready = false
        local el = getSec():Colorpicker({
            Name = tostring(cfg.Title or "Color"),
            Flag = flagFor(cfg.Title),
            Value = BracketColorToHSV(def),
            Callback = function(tbl, color)
                if not ready or not cfg.Callback then return end
                local c = (typeof(color) == "Color3") and color
                    or (type(tbl) == "table" and Color3.fromHSV(tbl[1] or 0, tbl[2] or 0, tbl[3] or 1))
                    or def
                pcall(cfg.Callback, c)
            end,
        })
        ready = true
        tip(el, cfg.Desc)
        el.Set = function(self, c) pcall(function() self:SetValue(BracketColorToHSV(c)) end) end
        return el
    end
    tabWrapper.ColorPicker = tabWrapper.Colorpicker

    function tabWrapper:Input(cfg)
        cfg = cfg or {}
        local el = getSec():Textbox({
            Name = tostring(cfg.Title or "Input"),
            Flag = flagFor(cfg.Title),
            Value = tostring(cfg.Default or ""),
            Placeholder = tostring(cfg.Placeholder or "Enter value..."),
            Callback = function(txt)
                if cfg.Callback then
                    local ok, err = pcall(cfg.Callback, txt)
                    if not ok then warn("[MM2] input callback error: " .. tostring(err)) end
                end
            end,
        })
        tip(el, cfg.Desc)
        el.Set = function(self, txt) pcall(function() self:SetValue(tostring(txt or "")) end) end
        return el
    end

    function tabWrapper:Label(cfg)
        cfg = cfg or {}
        local text = (cfg.Title and (tostring(cfg.Title) .. ": ") or "") .. tostring(cfg.Desc or cfg.Content or "")
        local ok, el = pcall(function() return getSec():Label({ Text = text }) end)
        if not ok or type(el) ~= "table" then
            return { SetLabel = function() end }
        end
        el.SetLabel = function(self, newText)
            if not pcall(function() self:SetText(tostring(newText)) end) then
                pcall(function() self.Text = tostring(newText) end)
            end
        end
        return el
    end
    tabWrapper.Paragraph = tabWrapper.Label

    function tabWrapper:Divider(cfg)
        return getSec():Divider({ Text = tostring((type(cfg) == "table" and cfg.Text) or "") })
    end

    return setmetatable(tabWrapper, { __index = function(_, k) return rawTab[k] end })
end

local function WrapBracketWindow(rawWindow, bracketLib)
    local winWrapper = { Raw = rawWindow, ToggleKey = S.ToggleKey, Destroyed = false }

    function winWrapper:Tab(cfg)
        cfg = cfg or {}
        local name = tostring(cfg.Title or cfg.Name or "Tab")
        return WrapBracketTab(rawWindow:Tab({ Name = name }), name)
    end

    function winWrapper:SetToggleKey(k)
        if type(k) == "string" and Enum.KeyCode[k] then k = Enum.KeyCode[k] end
        if typeof(k) == "EnumItem" then
            winWrapper.ToggleKey = k
            S.ToggleKey = k
        end
    end

    function winWrapper:Toggle(state)
        if state == nil then state = not rawWindow.Enabled end
        pcall(function() rawWindow.Flags["UI/Blur"] = false end)
        pcall(function() rawWindow:Toggle(state) end)
    end

    function winWrapper:Destroy()
        winWrapper.Destroyed = true
        pcall(function() if winWrapper.KeyConn then winWrapper.KeyConn:Disconnect() end end)
        pcall(function() bracketLib.ScreenAsset:Destroy() end)
    end

    winWrapper.KeyConn = Track(UserInputService.InputBegan:Connect(function(input, processed)
        if processed or winWrapper.Destroyed then return end
        if input.UserInputType == Enum.UserInputType.Keyboard and input.KeyCode == winWrapper.ToggleKey then
            winWrapper:Toggle()
        end
    end))

    return setmetatable(winWrapper, { __index = function(_, k) return rawWindow[k] end })
end

local function MakeBracketNotifier(bracketLib)
    local notifier = {}
    function notifier:Notify(cfg)
        cfg = cfg or {}
        pcall(function()
            bracketLib:Notification({
                Title = tostring(cfg.Title or "MM2"),
                Description = tostring(cfg.Content or cfg.Desc or cfg.Description or ""),
                Duration = math.max(1, math.ceil(tonumber(cfg.Duration) or 3)),
            })
        end)
    end
    notifier.Notification = notifier.Notify
    return notifier
end

local PlayerDropdowns = {}

local function PlayerNames()
    local names = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then table.insert(names, plr.Name) end
    end
    table.sort(names)
    if #names == 0 then names = { "(no players)" } end
    return names
end

local function RefreshPlayerDropdowns()
    for _, dd in ipairs(PlayerDropdowns) do
        pcall(function() dd:Refresh(PlayerNames(), true) end)
    end
end

local function BuildCombatTab(Window)
    local Tab = Window:Tab({ Title = "Combat" })

    Tab:Section({ Title = "Silent Aim", Side = "Left" })
    Tab:Toggle({
        Title = "Silent Aim",
        Desc = "Redirects the revolver and thrown knife through WeaponService.",
        Default = false,
        Callback = function(v)
            if v and not InstallAimHooks() then return end
            S.SilentAim = v
        end,
    })
    Tab:Dropdown({
        Title = "Target Mode",
        Options = { "Enemy Role", "Closest", "Murderer", "Sheriff", "Selected" },
        Default = S.SilentAimTargets,
        Desc = "Enemy Role = sheriff aims at murderer, murderer aims at sheriff.",
        Callback = function(v) S.SilentAimTargets = v end,
    })
    Tab:Dropdown({
        Title = "Hit Part",
        Options = { "Head", "HumanoidRootPart", "UpperTorso", "Torso" },
        Default = S.SilentAimPart,
        Callback = function(v) S.SilentAimPart = v end,
    })
    local selDD = Tab:Dropdown({
        Title = "Selected Player",
        Options = PlayerNames(),
        Desc = "Used when Target Mode is Selected.",
        Callback = function(v) S.SilentAimSelected = v end,
    })
    table.insert(PlayerDropdowns, selDD)
    Tab:Toggle({
        Title = "Limit To FOV",
        Desc = "Applies the FOV circle to every target mode. Off = role modes lock on at any angle.",
        Default = true,
        Callback = function(v) S.SilentAimUseFOV = v end,
    })
    Tab:Slider({
        Title = "FOV",
        Min = 30, Max = 900, Default = S.SilentAimFOV, Suffix = "px",
        Callback = function(v) S.SilentAimFOV = v end,
    })
    Tab:Toggle({
        Title = "Draw FOV Circle",
        Default = false,
        Callback = function(v) S.SilentAimShowFOV = v end,
    })
    Tab:Toggle({
        Title = "Visible Check",
        Desc = "Only aim at targets that are not behind walls.",
        Default = false,
        Callback = function(v) S.SilentAimVisible = v end,
    })

    Tab:Section({ Title = "Auto Kill", Side = "Right" })
    Tab:Toggle({
        Title = "Auto Kill Murderer",
        Desc = "Hunts whoever CurrentRoundClient marks as Murderer.",
        Default = false,
        Callback = function(v) S.AutoKillMurderer = v end,
    })
    Tab:Toggle({
        Title = "Auto Kill Sheriff",
        Default = false,
        Callback = function(v) S.AutoKillSheriff = v end,
    })
    Tab:Toggle({
        Title = "Auto Kill All",
        Desc = "Cycles every living player. Only useful as the murderer.",
        Default = false,
        Callback = function(v) S.AutoKillAll = v end,
    })
    Tab:Dropdown({
        Title = "Kill Method",
        Options = { "Teleport + Attack", "Touch Interest", "Both" },
        Default = S.KillMethod,
        Desc = "Touch Interest needs firetouchinterest in your executor.",
        Callback = function(v) S.KillMethod = v end,
    })
    Tab:Slider({
        Title = "Attack Hold",
        Min = 0.05, Max = 1, Default = S.KillHoldTime, Step = 0.01, Suffix = "s",
        Callback = function(v) S.KillHoldTime = v end,
    })
    Tab:Slider({
        Title = "Kill Cooldown",
        Min = 0.1, Max = 3, Default = S.KillCooldown, Step = 0.05, Suffix = "s",
        Callback = function(v) S.KillCooldown = v end,
    })
    Tab:Toggle({
        Title = "Return To Position",
        Desc = "Teleport back after every swing so you don't visibly blink around.",
        Default = true,
        Callback = function(v) S.KillReturn = v end,
    })

    Tab:Section({ Title = "Kill Aura", Side = "Left" })
    Tab:Toggle({
        Title = "Kill Aura",
        Desc = "Swings at anyone inside the radius. No teleporting.",
        Default = false,
        Callback = function(v) S.KillAura = v end,
    })
    Tab:Slider({
        Title = "Aura Radius",
        Min = 5, Max = 100, Default = S.KillAuraRadius, Suffix = " studs",
        Callback = function(v) S.KillAuraRadius = v end,
    })
    Tab:Slider({
        Title = "Aura Delay",
        Min = 0.05, Max = 1.5, Default = S.KillAuraDelay, Step = 0.05, Suffix = "s",
        Callback = function(v) S.KillAuraDelay = v end,
    })
    Tab:Toggle({
        Title = "Hide Swing Animation",
        Desc = "The knife only kills during its swing window, so the aura has to swing. This stops the animation the instant it starts — others see a one-frame flicker at most.",
        Default = true,
        Callback = function(v) S.HideSwing = v end,
    })
    Tab:Slider({
        Title = "Swing Window",
        Min = 0.1, Max = 1, Default = S.SwingWindow, Step = 0.05, Suffix = "s",
        Desc = "How long to keep firing touches after each swing. Raise it if kills are inconsistent.",
        Callback = function(v) S.SwingWindow = v end,
    })

    Tab:Section({ Title = "Survival", Side = "Right" })
    Tab:Toggle({
        Title = "Auto Dodge Murderer",
        Desc = "The one that actually works. Moves your real replicated position out of knife range, so the server can't ignore it.",
        Default = false,
        Callback = function(v) S.AutoDodge = v end,
    })
    Tab:Dropdown({
        Title = "Evade Direction",
        Options = { "Launch Upward", "Push Away", "Both" },
        Default = S.EvadeMode,
        Desc = "Upward is strongest — a knife is melee, so altitude is unreachable.",
        Callback = function(v) S.EvadeMode = v end,
    })
    Tab:Toggle({
        Title = "Anti-Touch (usually fails)",
        Desc = "Sets CanTouch = false on your body. MM2 resolves kills server-side and ignores this client flag, so it's here for completeness only — Auto Dodge is what keeps you alive.",
        Default = false,
        Callback = function(v)
            S.GodMode = v
            ApplyGodMode(v)
        end,
    })
    Tab:Slider({
        Title = "Dodge Trigger Range",
        Min = 5, Max = 40, Default = S.DodgeDistance, Suffix = " studs",
        Callback = function(v) S.DodgeDistance = v end,
    })
    Tab:Slider({
        Title = "Dodge Distance",
        Min = 10, Max = 120, Default = S.DodgeJump, Suffix = " studs",
        Callback = function(v) S.DodgeJump = v end,
    })

    Tab:Section({ Title = "Weapon Handling", Side = "Right" })
    Tab:Toggle({
        Title = "Auto Equip Weapon",
        Default = false,
        Callback = function(v) S.AutoEquip = v end,
    })
    Tab:Toggle({
        Title = "Auto Grab Dropped Gun",
        Desc = "Fires a silent touch pickup the instant a gun drops, and teleports only if that fails.",
        Default = false,
        Callback = function(v) S.AutoGrabGun = v end,
    })
    Tab:Toggle({
        Title = "Return After Grabbing",
        Desc = "Only matters when the silent pickup fails and it has to teleport.",
        Default = true,
        Callback = function(v) S.GrabReturn = v end,
    })

    Tab:Section({ Title = "Through Walls", Side = "Left" })
    Tab:Toggle({
        Title = "Teleport Shot",
        Desc = "Auto-kill with a gun hops to a spot with a clear line to the target, fires, and returns. True wallbang is impossible: the server raycasts every bullet from your gun's real position.",
        Default = true,
        Callback = function(v) S.GunTeleportShot = v end,
    })
    Tab:Toggle({
        Title = "Triggerbot",
        Desc = "Hold the trigger key to fire whenever a target is resolved.",
        Default = false,
        Callback = function(v) S.Triggerbot = v end,
    })
    Tab:Keybind({
        Title = "Trigger Key",
        Default = "V",
        Callback = function(key)
            if Enum.KeyCode[key] then S.TriggerKey = Enum.KeyCode[key] end
        end,
    })
    Tab:Toggle({
        Title = "Remote Kill (experimental)",
        Desc = "Fires KnifeKill/GunKill/EliminatePlayer with guessed arguments. Off by default — signatures are unverified and it may do nothing.",
        Default = false,
        Callback = function(v) S.RemoteKill = v end,
    })
end

local function BuildFarmTab(Window)
    local Tab = Window:Tab({ Title = "Farm" })

    Tab:Section({ Title = "Coin Collection", Side = "Left" })
    Tab:Toggle({
        Title = "Auto Collect Coins",
        Default = false,
        Callback = function(v) S.AutoCoins = v end,
    })
    Tab:Dropdown({
        Title = "Collect Mode",
        Options = { "Smooth Glide", "Silent Touch", "Teleport", "Remote" },
        Default = S.CoinMode,
        Desc = "Smooth Glide: flies coin-to-coin at Glide Speed (safest). Silent Touch: magnet that grabs coins within Touch Range as you move — the server rejects it from further out. Teleport: fastest, most likely to trip the position check.",
        Callback = function(v) S.CoinMode = v end,
    })
    Tab:Slider({
        Title = "Glide Speed",
        Min = 10, Max = 80, Default = S.GlideSpeed, Suffix = " studs/s",
        Desc = "Walk speed is 16. Stay under ~30 to avoid the invalid-position kick; raise it slowly if you want to find the real limit.",
        Callback = function(v) S.GlideSpeed = v end,
    })
    Tab:Slider({
        Title = "Touch Range",
        Min = 4, Max = 40, Default = S.TouchRange, Suffix = " studs",
        Desc = "Silent Touch magnet radius. If coins in range still don't collect, lower this — the server's limit is tighter than you've set.",
        Callback = function(v) S.TouchRange = v end,
    })
    Tab:Slider({
        Title = "Delay Between Coins",
        Min = 0, Max = 1, Default = S.CoinDelay, Step = 0.01, Suffix = "s",
        Callback = function(v) S.CoinDelay = v end,
    })
    Tab:Slider({
        Title = "Max Radius",
        Min = 0, Max = 500, Default = S.CoinRadius, Suffix = " studs",
        Desc = "0 = no limit. Otherwise ignores coins further away than this.",
        Callback = function(v) S.CoinRadius = v end,
    })
    Tab:Toggle({
        Title = "Return To Start",
        Desc = "Teleport mode only. Glide deliberately doesn't snap back — an instant jump across the map is what the position check kicks for.",
        Default = true,
        Callback = function(v) S.CoinReturn = v end,
    })
    Tab:Toggle({
        Title = "Only During Rounds",
        Desc = "Skips the lobby, where coins don't count.",
        Default = true,
        Callback = function(v) S.CoinRoundOnly = v end,
    })
    Tab:Toggle({
        Title = "Stop When Bag Full",
        Desc = "Reads your bag count from the CoinCollected remote and pauses once it's full — nothing more can be picked up.",
        Default = true,
        Callback = function(v) S.StopWhenFull = v end,
    })

    Tab:Section({ Title = "Session", Side = "Right" })
    local counter = Tab:Label({ Desc = "Coins this session: 0" })
    local roundInfo = Tab:Label({ Desc = "Round: idle" })

    Tab:Button({
        Title = "Reset Counter",
        Callback = function() S.CoinsCollected = 0 end,
    })
    Tab:Button({
        Title = "Teleport To Nearest Coin",
        Callback = TeleportToNearestCoin,
    })

    Loop(0.5, function() return true end, function()
        pcall(function()
            local bag = (BagCount and BagMax) and (tostring(BagCount) .. "/" .. tostring(BagMax)) or "?"
            counter:SetLabel("Collected: " .. tostring(S.CoinsCollected)
                .. "  |  Bag: " .. bag
                .. "  |  On map: " .. tostring(#GetCoins()))
        end)
        pcall(function()
            local murderer = GetMurderer()
            local sheriff = GetSheriff()
            roundInfo:SetLabel(
                "You: " .. MyRole()
                .. "  |  Murderer: " .. (murderer and murderer.Name or "?")
                .. "  |  Sheriff: " .. (sheriff and sheriff.Name or "?")
            )
        end)
    end)
end

local function BuildVisualsTab(Window)
    local Tab = Window:Tab({ Title = "Visuals" })

    Tab:Section({ Title = "Player ESP", Side = "Left" })
    Tab:Toggle({ Title = "Enable ESP", Default = false, Callback = function(v) S.ESP = v end })
    Tab:Toggle({ Title = "Boxes", Default = true, Desc = "Needs a Drawing-capable executor.", Callback = function(v) S.ESPBox = v end })
    Tab:Toggle({ Title = "Names", Default = true, Callback = function(v) S.ESPName = v end })
    Tab:Toggle({ Title = "Role Tag", Default = true, Callback = function(v) S.ESPRole = v end })
    Tab:Toggle({ Title = "Distance", Default = true, Callback = function(v) S.ESPDistance = v end })
    Tab:Toggle({ Title = "Health", Default = false, Callback = function(v) S.ESPHealth = v end })
    Tab:Toggle({ Title = "Tracers", Default = false, Callback = function(v) S.ESPTracer = v end })
    Tab:Toggle({ Title = "Chams", Default = false, Callback = function(v) S.ESPChams = v end })
    Tab:Toggle({
        Title = "Hide Same Role",
        Desc = "Skips players who share your role.",
        Default = false,
        Callback = function(v) S.ESPTeamCheck = v end,
    })

    Tab:Section({ Title = "Colors", Side = "Right" })
    Tab:Colorpicker({ Title = "Murderer", Default = S.ColorMurderer, Callback = function(c) S.ColorMurderer = c end })
    Tab:Colorpicker({ Title = "Sheriff",  Default = S.ColorSheriff,  Callback = function(c) S.ColorSheriff = c end })
    Tab:Colorpicker({ Title = "Innocent", Default = S.ColorInnocent, Callback = function(c) S.ColorInnocent = c end })
    Tab:Colorpicker({ Title = "Dead",     Default = S.ColorDead,     Callback = function(c) S.ColorDead = c end })
    Tab:Colorpicker({ Title = "Coins",    Default = S.ColorCoin,     Callback = function(c) S.ColorCoin = c end })

    Tab:Section({ Title = "World", Side = "Left" })
    Tab:Toggle({ Title = "Coin ESP", Default = false, Callback = function(v) S.CoinESP = v end })
    Tab:Toggle({ Title = "Coin Tracers", Default = false, Callback = function(v) S.CoinESPTracer = v end })
    Tab:Toggle({
        Title = "Fullbright",
        Default = false,
        Callback = function(v)
            S.Fullbright = v
            ApplyLighting()
        end,
    })
    Tab:Toggle({
        Title = "No Fog",
        Default = false,
        Callback = function(v)
            S.NoFog = v
            ApplyLighting()
        end,
    })
    Tab:Slider({
        Title = "Ambient",
        Min = 0, Max = 255, Default = S.Ambient,
        Callback = function(v)
            S.Ambient = v
            ApplyLighting()
        end,
    })
    Tab:Button({
        Title = "Strip Effects (FPS Boost)",
        Desc = "Removes particles, trails and smoke from the map.",
        Callback = function()
            local removed = 0
            for _, inst in ipairs(Workspace:GetDescendants()) do
                if inst:IsA("ParticleEmitter") or inst:IsA("Trail")
                    or inst:IsA("Smoke") or inst:IsA("Fire") or inst:IsA("Sparkles") then
                    pcall(function() inst.Enabled = false end)
                    removed = removed + 1
                end
            end
            Notify("MM2", "Disabled " .. removed .. " effects.", 3)
        end,
    })
end

local function BuildMovementTab(Window)
    local Tab = Window:Tab({ Title = "Movement" })

    Tab:Section({ Title = "Speed & Jump", Side = "Left" })
    Tab:Toggle({ Title = "Custom WalkSpeed", Default = false, Callback = function(v)
        S.WalkSpeedOn = v
        if not v then
            local hum = GetHumanoid(LocalPlayer)
            if hum then hum.WalkSpeed = 16 end
        end
    end })
    Tab:Slider({
        Title = "WalkSpeed",
        Min = 16, Max = 250, Default = S.WalkSpeed,
        Callback = function(v) S.WalkSpeed = v end,
    })
    Tab:Toggle({ Title = "Custom JumpPower", Default = false, Callback = function(v)
        S.JumpPowerOn = v
        if not v then
            local hum = GetHumanoid(LocalPlayer)
            if hum then hum.JumpPower = 50 end
        end
    end })
    Tab:Slider({
        Title = "JumpPower",
        Min = 50, Max = 400, Default = S.JumpPower,
        Callback = function(v) S.JumpPower = v end,
    })
    Tab:Toggle({ Title = "Infinite Jump", Default = false, Callback = function(v) S.InfiniteJump = v end })

    Tab:Section({ Title = "Flight", Side = "Right" })
    Tab:Toggle({
        Title = "Fly",
        Desc = "WASD to move, Space up, Left Shift down.",
        Default = false,
        Callback = function(v)
            S.Fly = v
            if not v then StopFly() end
        end,
    })
    Tab:Slider({
        Title = "Fly Speed",
        Min = 10, Max = 400, Default = S.FlySpeed,
        Callback = function(v) S.FlySpeed = v end,
    })
    Tab:Toggle({
        Title = "Glide",
        Desc = "Lowers world gravity so falls turn into long glides.",
        Default = false,
        Callback = function(v)
            S.Glide = v
            if not v then Workspace.Gravity = DefaultGravity end
        end,
    })
    Tab:Slider({
        Title = "Glide Gravity",
        Min = 5, Max = 196, Default = S.GlideGravity,
        Callback = function(v)
            S.GlideGravity = v
            if S.Glide then Workspace.Gravity = v end
        end,
    })
    Tab:Toggle({
        Title = "Noclip",
        Default = false,
        Callback = function(v) S.Noclip = v end,
    })
    Tab:Toggle({
        Title = "Anti Void",
        Desc = "Catches you if you fall out of the map.",
        Default = false,
        Callback = function(v) S.AntiVoid = v end,
    })
end

local function BuildPlayerTab(Window)
    local Tab = Window:Tab({ Title = "Player" })

    Tab:Section({ Title = "Hitbox Expander", Side = "Left" })
    Tab:Toggle({
        Title = "Expand Hitboxes",
        Desc = "Grows the target's HumanoidRootPart so knives and bullets land easily.",
        Default = false,
        Callback = function(v)
            S.Hitbox = v
            if not v then
                for plr in pairs(HitboxCache) do RestoreHitbox(plr) end
            end
        end,
    })
    Tab:Dropdown({
        Title = "Apply To",
        Options = { "Murderer", "Sheriff", "Innocents", "All" },
        Default = S.HitboxTarget,
        Callback = function(v)
            for plr in pairs(HitboxCache) do RestoreHitbox(plr) end
            S.HitboxTarget = v
        end,
    })
    Tab:Slider({
        Title = "Hitbox Size",
        Min = 3, Max = 60, Default = S.HitboxSize, Suffix = " studs",
        Callback = function(v) S.HitboxSize = v end,
    })
    Tab:Slider({
        Title = "Hitbox Transparency",
        Min = 0, Max = 1, Default = S.HitboxTransparency, Step = 0.05,
        Callback = function(v) S.HitboxTransparency = v end,
    })

    Tab:Section({ Title = "Fling", Side = "Right" })
    local flingDD = Tab:Dropdown({
        Title = "Fling Target",
        Options = PlayerNames(),
        Callback = function(v) S.FlingSelected = v end,
    })
    table.insert(PlayerDropdowns, flingDD)
    Tab:Slider({
        Title = "Fling Power",
        Min = 1000, Max = 30000, Default = S.FlingPower, Step = 500,
        Callback = function(v) S.FlingPower = v end,
    })
    Tab:Slider({
        Title = "Fling Duration",
        Min = 0.1, Max = 2, Default = S.FlingDuration, Step = 0.05, Suffix = "s",
        Desc = "How long you stay latched to the target. Too short and the spin never builds up.",
        Callback = function(v) S.FlingDuration = v end,
    })
    Tab:Button({
        Title = "Fling Selected",
        Callback = function()
            local plr = S.FlingSelected and Players:FindFirstChild(S.FlingSelected)
            if plr then FlingAt(plr) else Notify("MM2", "Pick a player first.", 3) end
        end,
    })
    Tab:Toggle({
        Title = "Fling Everyone (loop)",
        Default = false,
        Callback = function(v) S.FlingAll = v end,
    })
    Tab:Slider({
        Title = "Fling All Delay",
        Min = 0.1, Max = 3, Default = S.FlingAllDelay, Step = 0.05, Suffix = "s",
        Callback = function(v) S.FlingAllDelay = v end,
    })
    Tab:Toggle({
        Title = "Spin (touch fling)",
        Desc = "Spins your root part so anyone who touches you gets launched.",
        Default = false,
        Callback = function(v)
            S.SpinFling = v
            if not v then
                local root = GetRoot(LocalPlayer)
                if root then root.AssemblyAngularVelocity = Vector3.zero end
            end
        end,
    })

    Tab:Section({ Title = "Teleports", Side = "Left" })
    Tab:Button({ Title = "To Murderer", Callback = function()
        local m = GetMurderer()
        if m then TeleportToPlayer(m) else Notify("MM2", "No murderer found.", 3) end
    end })
    Tab:Button({ Title = "To Sheriff", Callback = function()
        local s = GetSheriff()
        if s then TeleportToPlayer(s) else Notify("MM2", "No sheriff found.", 3) end
    end })
    Tab:Button({ Title = "To Nearest Coin", Callback = TeleportToNearestCoin })
    local tpDD = Tab:Dropdown({
        Title = "Teleport To Player",
        Options = PlayerNames(),
        Callback = function(v) S.TPSelected = v end,
    })
    table.insert(PlayerDropdowns, tpDD)
    Tab:Button({
        Title = "Teleport To Selected",
        Callback = function()
            local plr = S.TPSelected and Players:FindFirstChild(S.TPSelected)
            if plr then TeleportToPlayer(plr) else Notify("MM2", "Pick a player first.", 3) end
        end,
    })

    Tab:Section({ Title = "Spectate", Side = "Right" })
    local specDD = Tab:Dropdown({
        Title = "Spectate Player",
        Options = PlayerNames(),
        Callback = function(v) S.SpectateSelected = v end,
    })
    table.insert(PlayerDropdowns, specDD)
    Tab:Button({
        Title = "Spectate Selected",
        Callback = function()
            local plr = S.SpectateSelected and Players:FindFirstChild(S.SpectateSelected)
            if plr then SpectatePlayer(plr) else Notify("MM2", "Pick a player first.", 3) end
        end,
    })
    Tab:Button({ Title = "Spectate Murderer", Callback = function()
        local m = GetMurderer()
        if m then SpectatePlayer(m) else Notify("MM2", "No murderer found.", 3) end
    end })
    Tab:Button({ Title = "Stop Spectating", Callback = function() SpectatePlayer(nil) end })
    Tab:Button({ Title = "Refresh Player Lists", Callback = RefreshPlayerDropdowns })
end

local function BuildSpoofTab(Window)
    local Tab = Window:Tab({ Title = "Spoofer" })

    Tab:Section({ Title = "Read Me", Side = "Left" })
    Tab:Label({
        Desc = "Client-side only. This edits the ProfileData table your own UI "
            .. "renders from, so the fake items show up on your screen and nowhere else. "
            .. "Trade partners still see your real inventory (their client gets its own "
            .. "copy from the server) and the server ignores equips for items you don't own.",
    })

    Tab:Section({ Title = "Add Items", Side = "Right" })
    local rarity = "Godly"
    local itemDD

    Tab:Dropdown({
        Title = "Rarity Filter",
        Options = { "Godly", "Ancient", "Chroma", "Legendary", "Unique", "Rare", "Uncommon", "Common", "Classic", "All" },
        Default = "Godly",
        Callback = function(v)
            rarity = v
            if itemDD then pcall(function() itemDD:Refresh(ItemsByRarity(rarity), false) end) end
        end,
    })

    itemDD = Tab:Dropdown({
        Title = "Item",
        Options = ItemsByRarity("Godly"),
        Callback = function(v) S.SpoofSelected = v end,
    })

    local amount = 1
    Tab:Slider({
        Title = "Amount",
        Min = 1, Max = 100, Default = 1,
        Callback = function(v) amount = v end,
    })

    Tab:Button({
        Title = "Add Selected Item",
        Callback = function()
            local id = S.SpoofSelected and SpoofNameToId[S.SpoofSelected]
            if not id then
                Notify("MM2", "Pick an item first.", 3)
                return
            end
            if SpoofAddItem(id, amount) then
                RefreshInventoryUI()
                Notify("MM2", "Added " .. amount .. "x " .. tostring(id) .. " (local only).", 3)
            end
        end,
    })

    Tab:Button({
        Title = "Equip Selected (visual)",
        Desc = "Shows the item as equipped in your own UI. The server won't hand you the real weapon.",
        Callback = function()
            local id = S.SpoofSelected and SpoofNameToId[S.SpoofSelected]
            if id and SpoofEquip(id) then
                Notify("MM2", "Equipped " .. tostring(id) .. " locally.", 3)
            else
                Notify("MM2", "Pick an item first.", 3)
            end
        end,
    })
    Tab:Button({
        Title = "Wear Selected Skin",
        Desc = "Reskins your back/waist display AND the weapon in your hand. Loads the item's model by its ItemID — if your executor or the asset blocks that, use Copy From Player below.",
        Callback = function()
            local id = S.SpoofSelected and SpoofNameToId[S.SpoofSelected]
            if not id then
                Notify("MM2", "Pick an item first.", 3)
                return
            end
            local ok, msg = SpoofSkinFromItem(id)
            if ok then
                Notify("MM2", "Wearing " .. tostring(id) .. (msg and (" — " .. msg) or " (local only)."), 5)
            else
                Notify("MM2", "Couldn't load it: " .. tostring(msg), 7)
            end
        end,
    })

    Tab:Section({ Title = "Copy From Player", Side = "Right" })
    Tab:Label({
        Desc = "Always works: copies the mesh straight off another player's back/waist display. See someone with a godly, take their look.",
    })
    local copyDD = Tab:Dropdown({
        Title = "Player",
        Options = PlayerNames(),
        Callback = function(v) S.CopySkinFrom = v end,
    })
    table.insert(PlayerDropdowns, copyDD)
    Tab:Button({
        Title = "Copy Their Knife",
        Callback = function()
            local plr = S.CopySkinFrom and Players:FindFirstChild(S.CopySkinFrom)
            local ok, err = CopySkinFromPlayer(plr, "Knife")
            Notify("MM2", ok and ("Copied " .. plr.Name .. "'s knife.") or ("Couldn't copy: " .. tostring(err)), 4)
        end,
    })
    Tab:Button({
        Title = "Copy Their Gun",
        Callback = function()
            local plr = S.CopySkinFrom and Players:FindFirstChild(S.CopySkinFrom)
            local ok, err = CopySkinFromPlayer(plr, "Gun")
            Notify("MM2", ok and ("Copied " .. plr.Name .. "'s gun.") or ("Couldn't copy: " .. tostring(err)), 4)
        end,
    })
    Tab:Button({
        Title = "Restore Real Skins",
        Callback = function()
            RestoreSkins()
            Notify("MM2", "Your real weapons are showing again.", 3)
        end,
    })

    Tab:Section({ Title = "Bulk Fill", Side = "Left" })
    Tab:Button({
        Title = "Add All Godlies",
        Callback = function()
            local n = SpoofBulkAdd(function(_, d) return d.Rarity == "Godly" end, 1)
            Notify("MM2", "Added " .. n .. " godlies.", 3)
        end,
    })
    Tab:Button({
        Title = "Add All Ancients",
        Callback = function()
            local n = SpoofBulkAdd(function(_, d) return d.Rarity == "Ancient" end, 1)
            Notify("MM2", "Added " .. n .. " ancients.", 3)
        end,
    })
    Tab:Button({
        Title = "Add All Chromas",
        Callback = function()
            local n = SpoofBulkAdd(function(_, d) return d.Chroma == true end, 1)
            Notify("MM2", "Added " .. n .. " chromas.", 3)
        end,
    })
    Tab:Button({
        Title = "Add Every Item",
        Desc = "Dumps the whole weapon database into your local inventory. Can lag the UI for a second.",
        Callback = function()
            local n = SpoofBulkAdd(function() return true end, 1)
            Notify("MM2", "Added " .. n .. " items.", 4)
        end,
    })
    Tab:Button({
        Title = "Add 99x Of Everything",
        Callback = function()
            local n = SpoofBulkAdd(function() return true end, 99)
            Notify("MM2", "Added 99x of " .. n .. " items.", 4)
        end,
    })

    Tab:Section({ Title = "Currency", Side = "Right" })
    Tab:Input({
        Title = "Set Gems",
        Placeholder = "e.g. 999999",
        Callback = function(txt)
            if SpoofSetCurrency("Gems", txt) then
                Notify("MM2", "Gems display set to " .. tostring(txt) .. ".", 3)
            end
        end,
    })
    Tab:Input({
        Title = "Set Coins",
        Placeholder = "e.g. 999999",
        Callback = function(txt)
            if SpoofSetCurrency("Coins", txt) then
                Notify("MM2", "Coins display set to " .. tostring(txt) .. ".", 3)
            end
        end,
    })

    Tab:Section({ Title = "Control", Side = "Left" })
    Tab:Button({
        Title = "Refresh Inventory UI",
        Desc = "Run this after adding items, with the inventory open at least once.",
        Callback = function()
            if RefreshInventoryUI() then Notify("MM2", "Inventory UI refreshed.", 3) end
        end,
    })
    Tab:Button({
        Title = "Restore Real Inventory",
        Callback = SpoofRestore,
    })
end

local function BuildSettingsTab(Window)
    local Tab = Window:Tab({ Title = "Settings" })

    Tab:Section({ Title = "Interface", Side = "Left" })
    Tab:Keybind({
        Title = "Menu Toggle Key",
        Default = "RightShift",
        Callback = function(key) Window:SetToggleKey(key) end,
    })
    Tab:Toggle({
        Title = "Notifications",
        Default = true,
        Callback = function(v) S.Notifications = v end,
    })
    Tab:Toggle({
        Title = "Anti AFK",
        Default = true,
        Callback = function(v) S.AntiAFK = v end,
    })

    Tab:Section({ Title = "Server", Side = "Right" })
    Tab:Button({ Title = "Rejoin Server", Callback = Rejoin })
    Tab:Button({ Title = "Server Hop", Callback = ServerHop })
    Tab:Button({ Title = "Copy Job ID", Callback = function()
        if setclipboard then
            setclipboard(game.JobId)
            Notify("MM2", "Job ID copied.", 3)
        else
            Notify("MM2", "setclipboard is unavailable in this executor.", 3)
        end
    end })

    Tab:Section({ Title = "Session", Side = "Left" })
    local status = Tab:Label({ Desc = "Loading..." })
    Loop(1, function() return true end, function()
        pcall(function()
            status:SetLabel(
                "Role: " .. MyRole()
                .. "  |  Round: " .. (IsRoundActive() and "active" or "lobby")
                .. "  |  Coins: " .. tostring(S.CoinsCollected)
            )
        end)
    end)

    Tab:Button({
        Title = "Unload Script",
        Desc = "Disconnects everything and removes the menu.",
        Callback = function()
            if GlobalScope.MM2_Cleanup then GlobalScope.MM2_Cleanup() end
        end,
    })
end

local Window

local function BuildUI()
    pcall(function()
        if getgenv and not getgenv().sethiddenproperty then
            getgenv().sethiddenproperty = function() end
        end
    end)

    local src = game:HttpGet("https://raw.githubusercontent.com/AlexR32/Bracket/main/BracketV32.lua")
    local fn, err = loadstring(src)
    if not fn then error("Bracket loadstring failed: " .. tostring(err)) end
    Bracket = fn()
    if type(Bracket) ~= "table" or type(Bracket.Window) ~= "function" then
        error("Bracket did not return a library table")
    end

    Notifier = MakeBracketNotifier(Bracket)
    GlobalScope.MM2_Bracket = Bracket

    local rawWin = Bracket:Window({
        Name = "Murder Mystery 2",
        Enabled = true,
        Color = Color3.fromRGB(255, 60, 120),
        Size = UDim2.new(0, 640, 0, 560),
        Position = UDim2.new(0.5, -320, 0.5, -280),
    })
    Window = WrapBracketWindow(rawWin, Bracket)
    GlobalScope.MM2_Window = Window

    BuildCombatTab(Window)
    BuildFarmTab(Window)
    BuildVisualsTab(Window)
    BuildMovementTab(Window)
    BuildPlayerTab(Window)
    BuildSpoofTab(Window)
    BuildSettingsTab(Window)

    Notify("Murder Mystery 2", "Loaded on Bracket V32. Toggle menu: " .. S.ToggleKey.Name, 5)
end

GlobalScope.MM2_Cleanup = function()
    Unloading = true

    for _, conn in ipairs(Connections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(Connections)

    RemoveAimHooks()
    StopFly()

    pcall(RestoreSkins)
    pcall(function() ApplyGodMode(false) end)
    if SpoofBackup then pcall(SpoofRestore) end

    for plr in pairs(HitboxCache) do RestoreHitbox(plr) end
    table.clear(HitboxCache)

    for plr in pairs(ESPObjects) do DestroyPlayerESP(plr) end
    table.clear(ESPObjects)

    for part, data in pairs(CoinESPObjects) do
        SafeDestroy(data.Billboard)
        if data.Tracer then pcall(function() data.Tracer:Remove() end) end
        CoinESPObjects[part] = nil
    end

    SafeDestroy(ESPFolder)

    pcall(function()
        Workspace.Gravity = DefaultGravity
        Lighting.Brightness = LightingBackup.Brightness
        Lighting.ClockTime = LightingBackup.ClockTime
        Lighting.FogEnd = LightingBackup.FogEnd
        Lighting.FogStart = LightingBackup.FogStart
        Lighting.GlobalShadows = LightingBackup.GlobalShadows
        Lighting.Ambient = LightingBackup.Ambient
        Lighting.OutdoorAmbient = LightingBackup.OutdoorAmbient
    end)

    pcall(function()
        local hum = GetHumanoid(LocalPlayer)
        if hum then
            hum.WalkSpeed = 16
            hum.JumpPower = 50
            hum.PlatformStand = false
        end
        Camera.CameraSubject = hum
    end)

    pcall(function()
        if Window and Window.Destroy then Window:Destroy() end
    end)

    GlobalScope.MM2_Window = nil
    GlobalScope.MM2_Bracket = nil
    GlobalScope.MM2_Cleanup = nil

    warn("[MM2] unloaded.")
end

Track(Players.PlayerAdded:Connect(function()
    task.wait(0.5)
    RefreshPlayerDropdowns()
end))

Track(Players.PlayerRemoving:Connect(function()
    task.wait(0.5)
    RefreshPlayerDropdowns()
end))

if GameplayRemotes then
    local roundStart = GameplayRemotes:FindFirstChild("RoundStart")
    if roundStart and roundStart:IsA("RemoteEvent") then
        Track(roundStart.OnClientEvent:Connect(function()
            task.wait(1.5)
            local murderer = GetMurderer()
            local sheriff = GetSheriff()
            Notify(
                "Round Started",
                "You: " .. MyRole()
                .. "\nMurderer: " .. (murderer and murderer.Name or "unknown")
                .. "\nSheriff: " .. (sheriff and sheriff.Name or "unknown"),
                6
            )
        end))
    end
end

Track(LocalPlayer.CharacterAdded:Connect(function()
    task.wait(1)
    if S.WalkSpeedOn or S.JumpPowerOn then
        local hum = GetHumanoid(LocalPlayer)
        if hum then
            if S.WalkSpeedOn then hum.WalkSpeed = S.WalkSpeed end
            if S.JumpPowerOn then hum.JumpPower = S.JumpPower end
        end
    end
    if S.Fly then StartFly() end
end))

local ok, err = pcall(BuildUI)
if not ok then
    warn("[MM2] UI failed to build: " .. tostring(err))
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "MM2",
            Text = "UI failed: " .. tostring(err),
            Duration = 8,
        })
    end)
    if GlobalScope.MM2_Cleanup then GlobalScope.MM2_Cleanup() end
end
