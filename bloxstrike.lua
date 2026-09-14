
local GlobalScope = (getgenv and getgenv()) or _G or shared

if type(GlobalScope.BS_Cleanup) == "function" then
    pcall(GlobalScope.BS_Cleanup)
end

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local Lighting          = game:GetService("Lighting")
local HttpService       = game:GetService("HttpService")
local StarterGui        = game:GetService("StarterGui")
local CollectionService = game:GetService("CollectionService")
local SoundService      = game:GetService("SoundService")

local LocalPlayer = Players.LocalPlayer
local Camera      = Workspace.CurrentCamera

local S = {

    SilentAim          = false,
    SilentAimPart      = "Head",
    SilentAimFOV       = 180,
    SilentAimShowFOV   = false,
    SilentAimWallCheck = false,
    SilentAimPriority  = "Crosshair",
    NoSpread           = false,
    NoRecoil           = false,
    RapidFire          = false,
    RapidFireRate      = 0.04,
    AutoPistol         = false,

    Aimbot             = false,
    AimAlways          = false,
    AimKey             = "LeftAlt",
    AimPart            = "Head",
    AimFOV             = 150,
    ShowAimFOV         = false,
    Smoothness         = 4,
    AimVisibleOnly     = true,
    AimPriority        = "Crosshair",

    AimAutowall        = false,

    Triggerbot         = false,
    TriggerAlways      = false,
    TriggerKey         = "LeftAlt",
    TriggerDelay       = 0.05,
    TriggerAutowall    = false,

    ESP                = false,
    ESPBox             = true,
    ESPBoxOutline      = true,
    ESPName            = true,
    ESPWeapon          = true,
    ESPHealth          = true,
    ESPDistance        = true,
    ESPTracer          = false,
    ESPChams           = false,
    ESPHeadDot         = false,
    ESPTeammates       = false,
    ESPBoxType         = "Corner",
    ESPBoxThickness    = 1.5,
    ESPSkeleton        = true,
    ESPSkeletonThickness = 1.2,
    ESPHealthSide      = "Left",
    ESPTracerOrigin    = "Bottom",
    ESPMaxDistance     = 2500,
    ESPLastSeen        = true,
    LastSeenTime       = 3.5,
    SoundESP           = true,
    SoundESPTime       = 2.0,
    ESPLoadout         = false,
    ESPMoney           = false,
    ESPBombCarrier     = true,
    ESPVisibleColors   = false,
    EnemyVisibleColor  = Color3.fromRGB(80, 255, 120),

    BulletTracers      = false,
    TracerColor        = Color3.fromRGB(120, 200, 255),
    TracerHitColor     = Color3.fromRGB(255, 70, 70),
    TracerTime         = 1.5,
    TracerThickness    = 1.5,
    TracerImpacts      = true,
    ImpactSize         = 5,

    Watermark          = true,
    KeybindList        = true,

    Radar              = false,
    RadarCorner        = "Top Right",
    RadarSize          = 180,
    RadarRange         = 160,
    RadarTeammates     = true,
    RadarGhosts        = true,
    OffscreenArrows    = false,
    ArrowRadius        = 160,
    ArrowSize          = 14,
    ArrowDistance      = true,
    SpectatorHUD       = true,
    SpectatorAlert     = true,

    AntiFlash          = false,
    AntiSmoke          = false,
    NadePreview        = false,
    NadePrediction     = false,
    NadeColor          = Color3.fromRGB(120, 220, 255),

    BombESP            = true,
    BombTimerHUD       = true,
    DroppedWeaponESP   = false,
    GrenadeESP         = false,
    Fullbright         = false,
    NoFog              = false,
    CustomFOVEnabled   = false,
    CustomFOV          = 90,
    Stretch            = 1,

    CustomLighting     = false,
    LightClock         = 14,
    LightBrightness    = 2,
    LightExposure      = 0,
    LightShadows       = true,
    LightAmbient       = Color3.fromRGB(120, 120, 130),
    LightOutdoor       = Color3.fromRGB(140, 140, 150),
    LightShiftTop      = Color3.fromRGB(0, 0, 0),
    CustomFog          = false,
    FogEnd             = 600,
    FogColor           = Color3.fromRGB(190, 200, 215),

    CustomAtmosphere   = false,
    AtmoDensity        = 0.3,
    AtmoOffset         = 0.25,
    AtmoGlare          = 0,
    AtmoHaze           = 1,
    AtmoColor          = Color3.fromRGB(199, 199, 199),
    AtmoDecay          = Color3.fromRGB(106, 112, 125),

    MapMaterial        = "Off",
    MapRecolor         = false,
    MapColor           = Color3.fromRGB(150, 150, 160),
    MapNoTextures      = false,
    SkyPreset          = "Game Default",
    SkyCustomId        = "",
    SkyTweaks          = false,
    SkyCelestial       = true,
    SkyStars           = 3000,
    NoPostFX           = false,
    CCEnabled          = false,
    CCTint             = Color3.fromRGB(255, 255, 255),
    CCSaturation       = 0.15,
    CCContrast         = 0.1,
    CCBrightness       = 0,
    BloomEnabled       = false,
    BloomIntensity     = 0.8,
    BloomSize          = 24,
    BloomThreshold     = 1.5,
    SunRaysEnabled     = false,
    SunRaysIntensity   = 0.12,
    SunRaysSpread      = 0.8,

    ArmChams           = false,
    ArmChamsMaterial   = "ForceField",
    ArmChamsColor      = Color3.fromRGB(255, 140, 40),
    ArmChamsTransparency = 0,
    WeaponChams        = false,
    WeaponChamsMaterial = "ForceField",
    WeaponChamsColor   = Color3.fromRGB(120, 200, 255),
    WeaponChamsTransparency = 0,
    ChamsHideTextures  = true,
    ViewmodelGlow      = false,
    ViewmodelGlowFill  = Color3.fromRGB(255, 140, 40),
    ViewmodelGlowOutline = Color3.fromRGB(255, 255, 255),
    ViewmodelGlowFillT = 0.7,
    ViewmodelGlowOutlineT = 0.2,
    SelfBodyChams      = false,
    SelfBodyFill       = Color3.fromRGB(170, 85, 235),
    SelfBodyOutline    = Color3.fromRGB(255, 255, 255),
    SelfBodyFillT      = 0.5,

    ChamsFillT         = 0.6,
    ChamsOutlineT      = 0,
    ChamsOutlineWhite  = false,
    ChamsVisibleOnly   = false,

    Crosshair          = false,
    CrosshairStyle     = "Cross",
    CrosshairColor     = Color3.fromRGB(0, 255, 140),
    CrosshairSize      = 7,
    CrosshairGap       = 4,
    CrosshairThickness = 2,
    CrosshairOutline   = true,
    CrosshairDot       = false,
    CrosshairSpin      = false,
    CrosshairSpinSpeed = 3,
    CrosshairSpinMode  = "Constant",
    CrosshairSpinDirection = "Clockwise",
    CrosshairSwingAngle = 45,
    CrosshairRotation  = 0,
    CrosshairOutlineThickness = 1,
    CrosshairOutlineColor = Color3.fromRGB(0, 0, 0),
    CrosshairOpacity   = 1,
    CrosshairDotSize   = 3,
    CrosshairPulse     = false,
    CrosshairPulseSpeed = 4,
    CrosshairPulseAmount = 4,
    CrosshairDynamic   = false,
    CrosshairDynamicAmount = 8,
    CrosshairRainbow   = false,
    CrosshairRainbowSpeed = 0.25,
    HideGameCrosshair  = true,
    Hitmarker          = false,
    HitmarkerColor     = Color3.fromRGB(255, 255, 255),
    HitmarkerHeadColor = Color3.fromRGB(255, 60, 60),

    AutoDefuse         = false,
    AutoPlant          = false,

    SkinOverrides      = {},
    GloveOverride      = nil,
    KnifeModel         = nil,

    HitSounds          = true,
    HitSoundChoice     = "Neverlose",
    HeadshotSound      = true,

    EnemyColor         = Color3.fromRGB(255, 65, 65),
    TeamColor          = Color3.fromRGB(75, 150, 255),
    GhostColor         = Color3.fromRGB(255, 200, 60),
    SkeletonColor      = Color3.fromRGB(255, 255, 255),
    SoundColor         = Color3.fromRGB(255, 130, 0),
    BombColor          = Color3.fromRGB(255, 30, 30),
    WeaponColor        = Color3.fromRGB(80, 220, 150),
    GrenadeColor       = Color3.fromRGB(255, 180, 40),
    FOVColor           = Color3.fromRGB(255, 255, 255),

    InfiniteAmmo       = false,
    MagicBullet        = false,
    MagicBulletKey     = "NONE",
    MagicBulletHitbox  = "Head",
    MagicBulletMaxDist = 1500,
    Notifications      = true,
    ToggleKey          = Enum.KeyCode.RightShift,
}

local R = {
    Connections        = {},
    ESP                = {},
    GhostCache         = {},
    SoundEvents        = {},
    EquipCache         = {},
    MeleeCache         = {},
    LastTrigger        = 0,
    ActivePlantedBomb  = nil,
    Unloading          = false,
    OrigBulletRaycast  = nil,
    OrigSetRecoil      = nil,
    OrigWeaponKick     = nil,
    OrigWeaponShoot    = nil,
    SkinOrig           = nil,
    OrigVIPAmmo        = nil,
    Loadout            = {},
    NadePredictions    = {},
    NadePhysics        = {},
    NadePath           = nil,
    NadePathAt         = 0,
    NadeBaseDrop       = nil,
    LastNadeHeld       = 0,
    LastNadeMode       = "Far",
    CamVel             = Vector3.zero,
    LastCamPos         = nil,
    LastSpectators     = 0,
    RootTrack          = setmetatable({}, { __mode = "k" }),
    LastAutoFire       = 0,
    PenCache           = {},
    LastHitAt          = -10,
    LastHitHead        = false,
    LastAttackInput    = -10,
    LastMagicBullet    = 0,
}

local function Track(conn)

    if type(conn) == "function" then conn = { Disconnect = conn } end
    if conn then table.insert(R.Connections, conn) end
    return conn
end

local Identity = {}
do
    local get = getthreadidentity or getidentity or getthreadcontext
    local set = setthreadidentity or setidentity or setthreadcontext
    if type(get) == "function" then
        local ok, level = pcall(get)
        if ok and type(level) == "number" then Identity.Base = level end
    end
    Identity.Set = type(set) == "function" and set or nil
end

function Identity.Restore()
    if Identity.Set and Identity.Base then pcall(Identity.Set, Identity.Base) end
end

local function SafeDestroy(inst)
    if inst then pcall(function() inst:Destroy() end) end
end

local function Loop(interval, cond, fn)
    task.spawn(function()
        while not R.Unloading do
            if cond() then
                local ok, err = pcall(fn)
                if not ok and not R.Unloading then
                    warn("[BS] loop error: " .. tostring(err))
                end
            end
            task.wait(interval)
        end
    end)
end

local UI = { Lib = nil }

local function Notify(title, content, duration)
    if not S.Notifications then return end
    if UI.Lib and type(UI.Lib.Notify) == "function" then
        pcall(function()
            UI.Lib:Notify(title or "BloxStrike", content or "", tonumber(duration) or 3)
        end)
    else
        pcall(function()
            StarterGui:SetCore("SendNotification", {
                Title = title or "BloxStrike",
                Text = content or "",
                Duration = duration or 3,
            })
        end)
    end
end

local function EnumFrom(enumType, name)
    local ok, item = pcall(function() return enumType[name] end)
    return ok and item or nil
end

local function KeyName(key)
    local name = tostring(key or "")
    name = name:gsub("^Enum%.%w+%.", "")
    return name
end

local function KeyHeld(name)
    if not name or name == "" or name == "NONE" then return false end
    local kc = EnumFrom(Enum.KeyCode, name)
    if kc then return UserInputService:IsKeyDown(kc) end
    local uit = EnumFrom(Enum.UserInputType, name)
    if uit then return UserInputService:IsMouseButtonPressed(uit) end
    return false
end

local function Click(button)
    local click = (button == 1) and mouse1click or mouse2click
    if type(click) == "function" then
        pcall(click)
        return true
    end

    local press = (button == 1) and mouse1press or mouse2press
    local release = (button == 1) and mouse1release or mouse2release
    if type(press) == "function" and type(release) == "function" then
        pcall(press)
        task.wait(0.02)
        pcall(release)
        return true
    end

    return pcall(function()
        local vim = game:GetService("VirtualInputManager")
        local c = Camera.ViewportSize / 2
        vim:SendMouseButtonEvent(c.X, c.Y, button - 1, true, game, 0)
        task.wait(0.02)
        vim:SendMouseButtonEvent(c.X, c.Y, button - 1, false, game, 0)
    end)
end

local SoundAssets = {
    Neverlose = "rbxassetid://6534947240",
    Skeet     = "rbxassetid://4817809188",
    Rust      = "rbxassetid://1255040462",
    Bameware  = "rbxassetid://3124331820",
    Bell      = "rbxassetid://1053297581",
    Headshot  = "rbxassetid://6534947240",
}

local function PlayHitSound(isHeadshot)
    if not S.HitSounds then return end
    task.spawn(function()
        local soundId = (isHeadshot and S.HeadshotSound) and SoundAssets.Headshot or (SoundAssets[S.HitSoundChoice] or SoundAssets.Neverlose)
        local sound = Instance.new("Sound")
        sound.SoundId = soundId
        sound.Volume = 1.5
        sound.Parent = SoundService
        sound:Play()
        sound.Ended:Connect(function()
            sound:Destroy()
        end)
        task.delay(2, function()
            SafeDestroy(sound)
        end)
    end)
end

local Modules = {}

local function IsolatedRequire(inst)
    local done, ok, result = false, false, nil
    task.spawn(function()
        ok, result = pcall(require, inst)
        done = true
    end)

    local deadline = os.clock() + 10
    while not done and os.clock() < deadline do task.wait() end
    Identity.Restore()
    if not done then error("require timed out: " .. inst:GetFullName(), 0) end
    if not ok then error(result, 0) end
    return result
end

local function GetModule(key, path)
    if Modules[key] == nil then
        local ok, mod = pcall(function()
            local inst = ReplicatedStorage
            for _, name in ipairs(path) do
                inst = inst:WaitForChild(name, 4)
                if not inst then error("missing " .. name) end
            end
            return IsolatedRequire(inst)
        end)
        Modules[key] = ok and mod or false
    end
    return Modules[key] or nil
end

local function GetSkins()
    return GetModule("Skins", { "Database", "Components", "Libraries", "Skins" })
end

local function GetWeaponProperties()
    return GetModule("WeaponProps", { "Components", "Common", "GetWeaponProperties" })
end

local function GetRemotes()
    return GetModule("Remotes", { "Database", "Security", "Remotes" })
end

local function GetRouter()
    return GetModule("Router", { "Database", "Security", "Router" })
end

local function GetCharacterResolver()
    return GetModule("CharacterResolver", { "Components", "Common", "CharacterResolver" })
end

local function GetRayIgnoreModule()
    return GetModule("GetRayIgnore", { "Components", "Common", "GetRayIgnore" })
end

local function GetRaycastModule()
    return GetModule("Raycast", { "Shared", "Raycast" })
end

local function GetCharacterController()
    return GetModule("CharacterController", { "Controllers", "CharacterController" })
end

local function GetCameraController()
    return GetModule("CameraController", { "Controllers", "CameraController" })
end

local function GetWeaponClass()
    return GetModule("WeaponClass", { "Components", "Weapon" })
end

local function GetBulletClass()
    return GetModule("BulletClass", { "Components", "Weapon", "Classes", "Bullet" })
end

local function EquippedName(plr)
    if not plr then return nil end
    local raw = plr:GetAttribute("CurrentEquipped")
    local cache = R.EquipCache[plr]
    if cache and cache.Raw == raw then return cache.Name end

    local name
    if type(raw) == "string" and raw ~= "" then
        local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
        if ok and type(data) == "table" and type(data.Name) == "string" then
            name = data.Name
        end
    end
    R.EquipCache[plr] = { Raw = raw, Name = name }
    return name
end

local function EquippedIdentifier(plr)
    if not plr then return nil end
    local raw = plr:GetAttribute("CurrentEquipped")
    if type(raw) == "string" and raw ~= "" then
        local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
        if ok and type(data) == "table" and type(data.Identifier) == "string" then
            return data.Identifier
        end
    end
    return nil
end

local function IsEnemy(plr)
    if plr == LocalPlayer then return false end
    if Workspace:GetAttribute("Gamemode") == "Deathmatch" then return true end
    local theirs = plr:GetAttribute("Team")
    if theirs ~= "Terrorists" and theirs ~= "Counter-Terrorists" then return false end
    return theirs ~= LocalPlayer:GetAttribute("Team")
end

local function IsAliveChar(char)
    return char ~= nil
        and char:IsDescendantOf(Workspace)
        and char:GetAttribute("Dead") == false
        and (tonumber(char:GetAttribute("Health")) or 0) > 0
end

local function IsPresented(char)
    if not char or not char:IsDescendantOf(Workspace) then return false end
    local head = char:FindFirstChild("Head")
    if not (head and head:IsA("BasePart")) then return false end
    if head.LocalTransparencyModifier > 0.85 then return false end
    local root = char:FindFirstChild("HumanoidRootPart") or head
    if root.Position.Y > 1500 or root.Position.Y < -500 then return false end
    return true
end

local RealChars = {}

local function LocalAliveNow()
    if RealChars.LocalAlive then return RealChars.LocalAlive() end
    return IsAliveChar(LocalPlayer.Character)
end

local function GetAimPart(char, partName)
    partName = partName or S.AimPart
    if partName == "Closest" then
        local parts = { char:FindFirstChild("Head"), char:FindFirstChild("UpperTorso"), char:FindFirstChild("HumanoidRootPart") }
        local best, bestDist = nil, math.huge
        local center = Camera.ViewportSize / 2
        for _, p in ipairs(parts) do
            if p and p:IsA("BasePart") then
                local sp, onScreen = Camera:WorldToViewportPoint(p.Position)
                if onScreen then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d < bestDist then best, bestDist = p, d end
                end
            end
        end
        return best or char:FindFirstChild("Head") or char:FindFirstChild("HumanoidRootPart")
    end
    return char:FindFirstChild(partName)
        or char:FindFirstChild("Head")
        or char:FindFirstChild("UpperTorso")
        or char:FindFirstChild("HumanoidRootPart")
end

local function GetAimPartReal(char, partName)
    local get = RealChars.Part
    if not get then return GetAimPart(char, partName) end
    partName = partName or S.AimPart
    if partName == "Closest" then
        local best, bestDist = nil, math.huge
        local center = Camera.ViewportSize / 2
        for _, name in ipairs({ "Head", "UpperTorso", "HumanoidRootPart" }) do
            local p = get(char, name)
            if p then
                local sp, onScreen = Camera:WorldToViewportPoint(p.Position)
                if onScreen then
                    local d = (Vector2.new(sp.X, sp.Y) - center).Magnitude
                    if d < bestDist then best, bestDist = p, d end
                end
            end
        end
        return best or get(char, "Head") or get(char, "HumanoidRootPart")
    end
    return get(char, partName) or get(char, "Head") or get(char, "UpperTorso") or get(char, "HumanoidRootPart")
end

local function BuildRayParams(useReal)
    local ignore = { Camera }
    local debris = Workspace:FindFirstChild("Debris")
    if debris then table.insert(ignore, debris) end

    local map = Workspace:FindFirstChild("Map")
    if map then
        for _, n in ipairs({ "Cameras", "Barriers", "Ambience" }) do
            local x = map:FindFirstChild(n)
            if x then table.insert(ignore, x) end
        end
        local zones = map:FindFirstChild("Zones")
        if zones then
            for _, n in ipairs({ "Spawns", "Sites" }) do
                local x = zones:FindFirstChild(n)
                if x then table.insert(ignore, x) end
            end
        end
    end

    useReal = useReal and RealChars.Get ~= nil
    for _, plr in ipairs(Players:GetPlayers()) do
        local char = plr.Character
        if char and plr == LocalPlayer then
            table.insert(ignore, char)
        elseif char and useReal then
            if char ~= RealChars.Get(plr) then table.insert(ignore, char) end
        elseif char and not IsPresented(char) then
            table.insert(ignore, char)
        end
    end
    if useReal then

        for _, folder in ipairs(RealChars.Folders()) do
            for _, model in ipairs(folder:GetChildren()) do
                if model:IsA("Model") and RealChars.Part(model, "Head")
                    and (model.Name == LocalPlayer.Name or not RealChars.IsReal(model)) then
                    table.insert(ignore, model)
                end
            end
        end
    end

    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = ignore
    params.IgnoreWater = true
    return params
end

local function BuildRayIgnoreList()
    local gri = GetRayIgnoreModule()
    if gri then
        local ok, list = pcall(gri)
        if ok and type(list) == "table" then

            for _, plr in ipairs(Players:GetPlayers()) do
                local char = plr.Character
                if char and plr ~= LocalPlayer and not IsPresented(char) then
                    table.insert(list, char)
                end
            end
            return list
        end
    end

    local p = BuildRayParams()
    return p.FilterDescendantsInstances
end

local function IsVisible(part, char, params)
    if not part or not char then return false end
    params = params or BuildRayParams()
    local origin = Camera.CFrame.Position
    local hit = Workspace:Raycast(origin, part.Position - origin, params)
    return hit == nil or hit.Instance:IsDescendantOf(char)
end

local function WeaponPenetration()
    local name = EquippedName(LocalPlayer)
    if not name then return 0 end
    if R.PenCache[name] then return R.PenCache[name] end
    local pen = 0
    local gwp = GetWeaponProperties()
    if gwp then
        local ok, props = pcall(gwp, name)
        if ok and type(props) == "table" then pen = tonumber(props.Penetration) or 0 end
    end
    R.PenCache[name] = pen
    return pen
end

local function CanWallbang(part, char, params, pen)
    if not (part and char) or (pen or 0) <= 0 then return false end
    local origin = Camera.CFrame.Position
    local dir = part.Position - origin
    local first = Workspace:Raycast(origin, dir, params)
    if not first or first.Instance:IsDescendantOf(char) then return true end
    return dir.Magnitude - first.Distance <= pen
end

local function OwnerOf(inst)
    if not inst then return nil end
    local model = inst:IsA("Model") and inst or inst:FindFirstAncestorOfClass("Model")
    if not model then return nil end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr.Character == model then return plr end
    end

    if RealChars.Get then
        for _, plr in ipairs(Players:GetPlayers()) do
            if RealChars.Get(plr) == model then return plr end
        end
    end

    local resolver = GetCharacterResolver()
    if resolver and type(resolver.getPlayerFromCharacter) == "function" then
        local ok, plr = pcall(resolver.getPlayerFromCharacter, model)
        if ok and plr then return plr end
    end

    local attrPlr = model:GetAttribute("Player") or model:GetAttribute("Username")
    if type(attrPlr) == "string" then
        local plr = Players:FindFirstChild(attrPlr)
        if plr then return plr end
    end

    return nil
end

local function IsTargetEnemy(inst)
    if not inst then return false end
    local owner = OwnerOf(inst)
    if owner then return IsEnemy(owner) end

    if RealChars.EnemyTargets then
        for _, target in ipairs(RealChars.EnemyTargets()) do
            if inst:IsDescendantOf(target.Char) or inst == target.Char then
                return true
            end
        end
    end

    local resolver = GetCharacterResolver()
    if resolver and type(resolver.isPlayerCharacter) == "function" then
        local model = inst:IsA("Model") and inst or inst:FindFirstAncestorOfClass("Model")
        if model and resolver.isPlayerCharacter(model) then
            local myChar = LocalPlayer.Character or (RealChars.Get and RealChars.Get(LocalPlayer))
            if model ~= myChar then
                return true
            end
        end
    end
    return false
end

local function EnemyTargets(useReal)
    if useReal and RealChars.EnemyTargets then return RealChars.EnemyTargets() end
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if IsEnemy(plr) then
            local char = plr.Character
            if IsAliveChar(char) and IsPresented(char) then
                table.insert(list, { Player = plr, Char = char })
            end
        end
    end
    return list
end

local function IsMeleeWeapon(name)
    if not name then return false end
    if R.MeleeCache[name] ~= nil then return R.MeleeCache[name] end

    local melee = false
    local skins = GetSkins()
    if skins then
        local ok, info = pcall(skins.GetSkinInformation, name, "Stock")
        if ok and type(info) == "table" and info.type == "Melee" then melee = true end
    end
    if not melee then
        local n = name:lower()
        melee = n:find("knife") ~= nil or n:find("karambit") ~= nil or n:find("bayonet") ~= nil
            or n:find("dagger") ~= nil or n:find("butterfly") ~= nil or n:find("machete") ~= nil
            or n:find("lightsaber") ~= nil or n:find("stiletto") ~= nil or n:find("skeleton") ~= nil
    end
    R.MeleeCache[name] = melee
    return melee
end

local FireInput = { UserInputType = Enum.UserInputType.MouseButton1, KeyCode = Enum.KeyCode.Unknown }

local function GetFireAction()
    local act = GetModule("FireAction", { "Controllers", "InputController", "Actions", "Fire" })
    return (type(act) == "table" and type(act.Callback) == "function") and act or nil
end

local function GetEquippedWeapon()
    local inv = GetModule("InventoryController", { "Controllers", "InventoryController" })
    if not (inv and type(inv.getCurrentEquipped) == "function") then return nil end
    local ok, w = pcall(inv.getCurrentEquipped)
    return (ok and type(w) == "table" and type(w.Properties) == "table") and w or nil
end

local function FireTap()
    R.LastAttackInput = os.clock()
    local act = GetFireAction()
    if not act then return Click(1) end
    pcall(act.Callback, Enum.UserInputState.Begin, FireInput)
    task.defer(function()

        if not UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) then
            pcall(act.Callback, Enum.UserInputState.End, FireInput)
        end
    end)
    return true
end

local function AutoFireStep()
    if not ((S.AutoPistol or S.RapidFire) and UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)) then return end
    if UserInputService:GetFocusedTextBox() then return end
    if UI.Lib and UI.Lib.IsOpen and UI.Lib:IsOpen() then return end
    if not LocalAliveNow() then return end

    local weapon = GetEquippedWeapon()
    if not weapon then return end
    local props = weapon.Properties
    if not props or props.Class ~= "Weapon" then return end
    if type(weapon.Rounds) == "number" and weapon.Rounds <= 0 then return end

    local rate
    if S.RapidFire then
        rate = S.RapidFireRate or 0.04
    else
        if props.Automatic or props.ShootingOptions == "Revolver" then return end
        if weapon.AlternativeShootingOption == "Burst" then return end
        rate = (tonumber(props.FireRate) or 0.15) + 0.02
    end

    if os.clock() - R.LastAutoFire < rate then return end
    R.LastAutoFire = os.clock()

    if S.RapidFire then
        local remotes = GetRemotes()
        local shootRemote = remotes and remotes.Inventory and remotes.Inventory.ShootWeapon
        if shootRemote and type(shootRemote.Send) == "function" then
            local ident = EquippedIdentifier(LocalPlayer) or weapon.Identifier or weapon.Name or ""
            local camCF = Camera.CFrame
            local dir = camCF.LookVector
            R.RapidShotSeq = (R.RapidShotSeq or 0) + 1
            pcall(function()
                shootRemote.Send({
                    IsSniperScoped = weapon.IsSniperScoped or false,
                    ShootingHand = weapon.ShootingHand or "Right",
                    Identifier = ident,
                    Seq = R.RapidShotSeq,
                    Bullets = {
                        {
                            Direction = dir,
                            Origin = camCF.Position,
                            Hits = {}
                        }
                    }
                })
            end)
            R.LastShotFiredTime = os.clock()
        end
        return
    else
        local act = GetFireAction()
        if act and type(act.Callback) == "function" then
            pcall(act.Callback, Enum.UserInputState.End, FireInput)
            pcall(act.Callback, Enum.UserInputState.Begin, FireInput)
        else
            pcall(weapon.shoot, weapon)
        end
    end
end

local function AimAt(worldPos, smooth)
    local screen, onScreen = Camera:WorldToViewportPoint(worldPos)
    if not onScreen then return false end

    local center = Camera.ViewportSize / 2
    local dx, dy = screen.X - center.X, screen.Y - center.Y
    smooth = math.max(1, smooth or 1)

    if type(mousemoverel) == "function" then
        mousemoverel(dx / smooth, dy / smooth)
    else
        local cf = Camera.CFrame
        Camera.CFrame = cf:Lerp(CFrame.lookAt(cf.Position, worldPos), 1 / smooth)
    end
    return math.abs(dx) < 6 and math.abs(dy) < 6
end

local function ResolveAimTarget(params, partName, fov, wallCheck, priority, useReal, autowall)
    local center = Camera.ViewportSize / 2
    local bestPart, bestMetric = nil, math.huge
    fov = fov or S.AimFOV
    local pen = (wallCheck and autowall) and WeaponPenetration() or 0

    for _, t in ipairs(EnemyTargets(useReal)) do
        local part = useReal and GetAimPartReal(t.Char, partName) or GetAimPart(t.Char, partName)
        if part then
            local screen, onScreen = Camera:WorldToViewportPoint(part.Position)
            if onScreen then
                local dist2D = (Vector2.new(screen.X, screen.Y) - center).Magnitude
                if dist2D <= fov then
                    if not wallCheck or IsVisible(part, t.Char, params)
                        or (pen > 0 and CanWallbang(part, t.Char, params, pen)) then
                        local metric = dist2D
                        if priority == "Distance" then
                            metric = (Camera.CFrame.Position - part.Position).Magnitude
                        elseif priority == "LowestHealth" then
                            metric = (useReal and RealChars.Health and RealChars.Health(t.Char))
                                or tonumber(t.Char:GetAttribute("Health")) or 100
                        end
                        if metric < bestMetric then
                            bestPart, bestMetric = part, metric
                        end
                    end
                end
            end
        end
    end
    return bestPart
end

local function ResolveSilentAimTarget()
    if not S.SilentAim then return nil end
    local wallCheck = S.SilentAimWallCheck and not S.MagicBullet
    local params = wallCheck and BuildRayParams() or nil
    return ResolveAimTarget(params, S.SilentAimPart, S.SilentAimFOV, wallCheck, S.SilentAimPriority)
end

local function InstallCombatHooks()

    local bulletMod = GetBulletClass()
    if bulletMod and type(bulletMod._performRaycast) == "function" and not R.OrigBulletRaycast then
        R.OrigBulletRaycast = bulletMod._performRaycast
        bulletMod._performRaycast = function(self, spread)
            R.LastShotFiredTime = os.clock()
            if S.SilentAim then
                local targetPart = ResolveSilentAimTarget()
                if targetPart then
                    local camPos = Camera.CFrame.Position
                    local targetPos = targetPart.Position
                    local dir = (targetPos - camPos).Unit
                    local range = (self.Properties and tonumber(self.Properties.Range)) or 600
                    local penetration = S.MagicBullet and 9999 or ((self.Properties and tonumber(self.Properties.Penetration)) or 0)
                    local ignore = BuildRayIgnoreList()

                    local lookVec = dir
                    if not S.NoSpread and spread and spread > 0 then
                        local v33 = math.min(spread, 69)
                        local r = Random.new()
                        local theta = r:NextNumber(-math.pi, math.pi)
                        local phi = r:NextNumber(0, math.rad(v33 * 0.5))
                        local v36 = lookVec.Magnitude > 0 and lookVec.Unit or Vector3.new(0, 0, 1)
                        local v37 = math.abs(v36.Y) > 0.9999 and Vector3.new(1, 0, 0) or Vector3.new(0, 1, 0)
                        local cfLook = CFrame.lookAlong(Vector3.zero, v36, v37)
                        lookVec = (cfLook * CFrame.Angles(0, 0, theta) * CFrame.Angles(phi, 0, 0)).LookVector
                    end

                    local raycastMod = GetRaycastModule()
                    local castFn = raycastMod and raycastMod.cast
                    local castThroughFn = raycastMod and raycastMod.castThrough

                    local v40 = {
                        Distance = 0,
                        Origin = camPos,
                        Direction = lookVec,
                        Hits = {}
                    }

                    if castFn then
                        local v41 = castFn(camPos, lookVec * range, nil, ignore)
                        if v41 and v41.instance then
                            v40.Distance = (v41.position - camPos).Magnitude
                            if castThroughFn and penetration > 0 then
                                local v42 = castThroughFn(v41.position + lookVec * -0.001, lookVec * (penetration + 0.001), penetration, ignore)
                                for i = 1, #v42 do
                                    local hit = v42[i]
                                    if hit.instance and hit.material then
                                        table.insert(v40.Hits, {
                                            Position = hit.position,
                                            Instance = hit.instance,
                                            Material = hit.material.Name or "Concrete",
                                            Normal = hit.normal or Vector3.zero,
                                            Exit = (i % 2 == 0)
                                        })
                                    end
                                end
                            else
                                table.insert(v40.Hits, {
                                    Position = v41.position,
                                    Instance = v41.instance,
                                    Material = (v41.material and v41.material.Name) or "Concrete",
                                    Normal = v41.normal or Vector3.zero,
                                    Exit = false
                                })
                            end
                        end
                    end

                    table.insert(v40.Hits, {
                        Position = targetPos,
                        Instance = targetPart,
                        Material = "Flesh",
                        Normal = -lookVec,
                        Exit = false
                    })
                    v40.Distance = (targetPos - camPos).Magnitude
                    return v40
                end
            end
            return R.OrigBulletRaycast(self, S.NoSpread and 0 or spread)
        end
    end

    local camCtrl = GetCameraController()
    if camCtrl and type(camCtrl.setWeaponRecoil) == "function" and not R.OrigSetRecoil then
        R.OrigSetRecoil = camCtrl.setWeaponRecoil
        camCtrl.setWeaponRecoil = function(tbl, mult)
            if S.NoRecoil then
                if type(camCtrl.resetWeaponRecoil) == "function" then
                    pcall(camCtrl.resetWeaponRecoil)
                end
                return
            end
            return R.OrigSetRecoil(tbl, mult)
        end
    end

    if camCtrl and type(camCtrl.weaponKick) == "function" and not R.OrigWeaponKick then
        R.OrigWeaponKick = camCtrl.weaponKick
        camCtrl.weaponKick = function(tbl, mult)
            if S.NoRecoil then return end
            return R.OrigWeaponKick(tbl, mult)
        end
    end

end

local function RemoveCombatHooks()
    local bulletMod = GetBulletClass()
    if bulletMod and R.OrigBulletRaycast then
        pcall(function() bulletMod._performRaycast = R.OrigBulletRaycast end)
    end
    R.OrigBulletRaycast = nil

    local camCtrl = GetCameraController()
    if camCtrl and R.OrigSetRecoil then
        pcall(function() camCtrl.setWeaponRecoil = R.OrigSetRecoil end)
    end
    R.OrigSetRecoil = nil

    if camCtrl and R.OrigWeaponKick then
        pcall(function() camCtrl.weaponKick = R.OrigWeaponKick end)
    end
    R.OrigWeaponKick = nil

end

local function SetInfiniteAmmo(on)
    if R.OrigVIPAmmo == nil then
        R.OrigVIPAmmo = Workspace:GetAttribute("VIPInfiniteAmmoEnabled") == true
    end
    pcall(function()
        Workspace:SetAttribute("VIPInfiniteAmmoEnabled", on and true or R.OrigVIPAmmo)
    end)
end

local function DispatchMagicBullet(targetPart, targetChar)
    if not (targetPart and targetChar) then return false end
    local camPos = Camera.CFrame.Position
    local targetPos = targetPart.Position
    local dir = (targetPos - camPos).Unit
    local dist = (targetPos - camPos).Magnitude

    local remotes = GetRemotes()
    local shootRemote = remotes and remotes.Inventory and remotes.Inventory.ShootWeapon
    if shootRemote and type(shootRemote.Send) == "function" then
        local weapon = GetEquippedWeapon()
        local ident = EquippedIdentifier(LocalPlayer) or (weapon and (weapon.Identifier or weapon.Name)) or ""

        if ident ~= "" then
            SetInfiniteAmmo(true)
            R.LastShotFiredTime = os.clock()
            local shotSeq = (weapon and weapon.ShotSeq or 0) + 1
            if weapon then weapon.ShotSeq = shotSeq end

            local hits = {}
            local raycastMod = GetRaycastModule()
            local castFn = raycastMod and rawget(raycastMod, "cast")
            local ignore = BuildRayIgnoreList()
            local pen = (weapon and weapon.Properties and tonumber(weapon.Properties.Penetration)) or 10

            if type(castFn) == "function" then
                local ok41, v41 = pcall(castFn, camPos, dir * math.min(dist, 1000), nil, ignore)
                if ok41 and v41 and v41.instance and not v41.instance:IsDescendantOf(targetChar) then
                    table.insert(hits, {
                        Position = v41.position,
                        Instance = v41.instance,
                        Material = (v41.material and v41.material.Name) or "Concrete",
                        Normal = v41.normal or Vector3.zero,
                        Distance = (v41.position - camPos).Magnitude,
                        Exit = false
                    })
                    local castThroughFn = rawget(raycastMod, "castThrough")
                    if type(castThroughFn) == "function" then
                        local ok42, v42 = pcall(castThroughFn, v41.position + dir * -0.001, dir * (pen + 0.001), pen, ignore)
                        if ok42 and v42 then
                            for i = 1, #v42 do
                                local hit = v42[i]
                                if hit.instance and not hit.instance:IsDescendantOf(targetChar) then
                                    table.insert(hits, {
                                        Position = hit.position,
                                        Instance = hit.instance,
                                        Material = (hit.material and hit.material.Name) or "Concrete",
                                        Normal = hit.normal or Vector3.zero,
                                        Distance = (hit.position - camPos).Magnitude,
                                        Exit = (i % 2 == 0)
                                    })
                                end
                            end
                        end
                    end
                end
            end

            table.insert(hits, {
                Position = targetPos,
                Instance = targetPart,
                Material = "Flesh",
                Normal = -dir,
                Distance = dist,
                Exit = false
            })

            pcall(function()
                shootRemote.Send({
                    IsSniperScoped = weapon and weapon.IsSniperScoped or false,
                    ShootingHand = weapon and weapon.ShootingHand or "Right",
                    Identifier = ident,
                    Seq = shotSeq,
                    Bullets = {
                        {
                            Direction = dir,
                            Origin = camPos,
                            Hits = hits
                        }
                    }
                })
            end)

            if not S.InfiniteAmmo then
                SetInfiniteAmmo(false)
            end

            PlayHitSound(true)
            return true
        end
    end
    return false
end

local function FireMagicBulletNearest()
    if not LocalAliveNow() then return false end
    local targets = EnemyTargets(true)
    if #targets == 0 then return false end

    local camPos = Camera.CFrame.Position
    local bestPart, bestChar, bestDist = nil, nil, math.huge
    local get = RealChars.Part or function(char, name) return char:FindFirstChild(name) end

    for _, t in ipairs(targets) do
        if t.Char then
            local part = get(t.Char, S.MagicBulletHitbox) or get(t.Char, "Head") or get(t.Char, "UpperTorso")
            if part then
                local d = (part.Position - camPos).Magnitude
                if d < bestDist and d <= (S.MagicBulletMaxDist or 1500) then
                    bestDist = d
                    bestPart = part
                    bestChar = t.Char
                end
            end
        end
    end

    if bestPart and bestChar then
        return DispatchMagicBullet(bestPart, bestChar)
    end
    return false
end

local function ObjectiveStep()

    if S.AutoDefuse and LocalAliveNow() and R.ActivePlantedBomb then
        local bombModel = R.ActivePlantedBomb.Model
        if bombModel and bombModel.PrimaryPart then
            local myRoot = LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if myRoot and (myRoot.Position - bombModel.PrimaryPart.Position).Magnitude <= 8 then
                local remotes = GetRemotes()
                local c4Defuse = remotes and remotes.C4 and remotes.C4.StartDefuse
                if c4Defuse and type(c4Defuse.Send) == "function" then
                    pcall(function() c4Defuse.Send({ SessionId = 1 }) end)
                end
            end
        end
    end

    if S.AutoPlant and LocalAliveNow() then
        local weapon = EquippedName(LocalPlayer)
        if weapon == "C4" then
            local charCtrl = GetCharacterController()
            if charCtrl and type(charCtrl.PlantBomb) == "function" then
                pcall(charCtrl.PlantBomb)
            end
        end
    end
end

local function HookGameEvents()

    local remotes = GetRemotes()
    if remotes and remotes.Character and remotes.Character.CharacterDamaged then
        local dmgPacket = remotes.Character.CharacterDamaged
        if type(dmgPacket.Listen) == "function" then
            Track(dmgPacket.Listen(function(data)
                if type(data) ~= "table" or data.VictimUserId == LocalPlayer.UserId then return end

                if os.clock() - R.LastAttackInput > 0.6 then return end
                R.LastHitAt, R.LastHitHead = os.clock(), data.Headshot == true
                if S.HitSounds then PlayHitSound(data.Headshot == true) end
            end))
        end
    end

    local router = GetRouter()
    if router and type(router.observerRouter) == "function" then
        pcall(function()
            router.observerRouter("UpdatePlayerNoiseCone", function(channel, kind, pos, range)
                if S.SoundESP and typeof(pos) == "Vector3" then
                    table.insert(R.SoundEvents, {
                        Pos = pos,
                        Time = os.clock(),
                        Kind = tostring(kind or "Noise"),
                    })
                end
            end)
        end)
    end
end

Loop(0.5, function() return #R.SoundEvents > 0 end, function()
    local now = os.clock()
    for i = #R.SoundEvents, 1, -1 do
        if now - R.SoundEvents[i].Time > S.SoundESPTime then
            table.remove(R.SoundEvents, i)
        end
    end
end)

local function AssetsFolder(name)
    local assets = ReplicatedStorage:FindFirstChild("Assets") or ReplicatedStorage:WaitForChild("Assets", 3)
    if not assets then return nil end
    return assets:FindFirstChild(name) or assets:WaitForChild(name, 3)
end

local function WeaponNames()
    local names = {}
    local folder = AssetsFolder("Weapons")
    if folder then
        for _, f in ipairs(folder:GetChildren()) do
            if f:IsA("Folder") and f:FindFirstChild("Camera") then table.insert(names, f.Name) end
        end
    end
    table.sort(names)
    if #names == 0 then names = { "(no weapons found)" } end
    return names
end

local function KnifeNames()
    local names = {}
    for _, n in ipairs(WeaponNames()) do
        if IsMeleeWeapon(n) then table.insert(names, n) end
    end
    table.sort(names)
    if #names == 0 then names = { "(no knives found)" } end
    return names
end

local function GloveNames()
    local names = {}
    local folder = AssetsFolder("Weapons")
    if folder then
        for _, f in ipairs(folder:GetChildren()) do
            if f:IsA("Folder") and not f:FindFirstChild("Camera") and f:FindFirstChildWhichIsA("BasePart") then
                table.insert(names, f.Name)
            end
        end
    end
    table.sort(names)
    if #names == 0 then names = { "(no gloves found)" } end
    return names
end

local function SkinNames(weapon)
    local names = {}
    if not weapon or weapon == "" or weapon:sub(1, 1) == "(" then
        return { "(pick a weapon)" }
    end
    local root = AssetsFolder("Skins")
    local folder = root and root:FindFirstChild(weapon)
    if folder then
        for _, child in ipairs(folder:GetChildren()) do
            if child:IsA("Folder") then
                table.insert(names, child.Name)
            end
        end
    end
    table.sort(names)
    if #names == 0 then
        if IsMeleeWeapon(weapon) then
            names = { "Vanilla" }
        else
            names = { "Stock" }
        end
    end
    return names
end

local function InstallSkinHooks()
    if R.SkinOrig then return true end
    local lib = GetSkins()
    if not lib then return false, "Skins library not found" end

    local origCamera = lib.GetCameraModel
    local origCharacter = lib.GetCharacterModel
    local origGloves = lib.GetGloves
    local origGetSkinInfo = lib.GetSkinInformation

    if type(origCamera) ~= "function" then return false, "GetCameraModel not found" end

    local ok, err = pcall(function()

        if type(origGetSkinInfo) == "function" then
            lib.GetSkinInformation = function(weapon, skin)
                local info = origGetSkinInfo(weapon, skin)
                if info then return info end

                return {
                    name = skin or "Stock",
                    type = IsMeleeWeapon(weapon) and "Melee" or (weapon and (weapon:find("Glove") or weapon:find("Wraps"))) and "Glove" or "Weapon",
                    floatRange = { min = 0, max = 1 },
                    wearImages = {},
                }
            end
        end

        lib.GetCameraModel = function(weapon, skin, float, statTrack, nameTag, charm, stickers, pattern)
            local useWeapon = weapon
            if S.KnifeModel and IsMeleeWeapon(weapon) then
                useWeapon = S.KnifeModel
            end
            local o = S.SkinOverrides[useWeapon]

            if useWeapon ~= weapon or o then
                local chosenSkin = (o and o.Skin) or skin
                local chosenFloat = (o and o.Float) or float
                if useWeapon ~= weapon and not (o and o.Skin) then
                    chosenSkin = IsMeleeWeapon(useWeapon) and "Vanilla" or "Stock"
                end

                local okModel, model = pcall(origCamera, useWeapon,
                    chosenSkin, chosenFloat,
                    statTrack, nameTag, charm, stickers, pattern)
                if okModel and model then
                    return model
                end
            end
            return origCamera(weapon, skin, float, statTrack, nameTag, charm, stickers, pattern)
        end

        if type(origCharacter) == "function" then
            lib.GetCharacterModel = function(weapon, skin, float, statTrack, nameTag, charm, stickers, pattern)
                local useWeapon = weapon
                if S.KnifeModel and IsMeleeWeapon(weapon) then
                    useWeapon = S.KnifeModel
                end
                local o = S.SkinOverrides[useWeapon]

                if useWeapon ~= weapon or o then
                    local chosenSkin = (o and o.Skin) or skin
                    local chosenFloat = (o and o.Float) or float
                    if useWeapon ~= weapon and not (o and o.Skin) then
                        chosenSkin = IsMeleeWeapon(useWeapon) and "Vanilla" or "Stock"
                    end

                    local okModel, model = pcall(origCharacter, useWeapon,
                        chosenSkin, chosenFloat,
                        statTrack, nameTag, charm, stickers, pattern)
                    if okModel and model then
                        return model
                    end
                end
                return origCharacter(weapon, skin, float, statTrack, nameTag, charm, stickers, pattern)
            end
        end

        if type(origGloves) == "function" then
            lib.GetGloves = function(name, skin, float)
                local o = S.GloveOverride
                if o then
                    local okGloves, gloves = pcall(origGloves, o.Name or name, o.Skin or skin, o.Float or float)
                    if okGloves and gloves then return gloves end
                end
                return origGloves(name, skin, float)
            end
        end
    end)
    if not ok then return false, "Skins library hook failed (" .. tostring(err) .. ")" end

    R.SkinOrig = {
        Lib = lib,
        Camera = origCamera,
        Character = origCharacter,
        Gloves = origGloves,
        SkinInfo = origGetSkinInfo,
    }
    return true
end

local function RemoveSkinHooks()
    local orig = R.SkinOrig
    if not orig then return end
    pcall(function()
        if orig.Camera then orig.Lib.GetCameraModel = orig.Camera end
        if orig.Character then orig.Lib.GetCharacterModel = orig.Character end
        if orig.Gloves then orig.Lib.GetGloves = orig.Gloves end
        if orig.SkinInfo then orig.Lib.GetSkinInformation = orig.SkinInfo end
    end)
    R.SkinOrig = nil
end

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = "BS_ESP"
pcall(function() ESPFolder.Parent = (gethui and gethui()) or game:GetService("CoreGui") end)
if not ESPFolder.Parent then ESPFolder.Parent = LocalPlayer:WaitForChild("PlayerGui") end

local HasDrawing = type(Drawing) == "table" or typeof(Drawing) == "table"

local function NewDraw(class, props)
    if not HasDrawing then return nil end
    local ok, obj = pcall(function() return Drawing.new(class) end)
    if not ok or not obj then return nil end
    for k, v in pairs(props or {}) do pcall(function() obj[k] = v end) end
    return obj
end

local ESP_BONES_R15 = {
    { "Head", "UpperTorso" }, { "UpperTorso", "LowerTorso" },
    { "UpperTorso", "LeftUpperArm" }, { "LeftUpperArm", "LeftLowerArm" }, { "LeftLowerArm", "LeftHand" },
    { "UpperTorso", "RightUpperArm" }, { "RightUpperArm", "RightLowerArm" }, { "RightLowerArm", "RightHand" },
    { "LowerTorso", "LeftUpperLeg" }, { "LeftUpperLeg", "LeftLowerLeg" }, { "LeftLowerLeg", "LeftFoot" },
    { "LowerTorso", "RightUpperLeg" }, { "RightUpperLeg", "RightLowerLeg" }, { "RightLowerLeg", "RightFoot" },
}

local ESP_BONES_R6 = {
    { "Head", "Torso" }, { "Torso", "Left Arm" }, { "Torso", "Right Arm" },
    { "Torso", "Left Leg" }, { "Torso", "Right Leg" },
}

local function GetRealPart(char, name)
    if not char then return nil end
    local part = char:FindFirstChild(name)
    if part and part:IsA("BasePart") then return part end
    local sub = char:FindFirstChild("Hitbox") or char:FindFirstChild("Body") or char:FindFirstChild("Bones")
    if sub then
        local inner = sub:FindFirstChild(name)
        if inner and inner:IsA("BasePart") then return inner end
    end
    return nil
end

local function GetRealRoot(char)
    return GetRealPart(char, "HumanoidRootPart") or GetRealPart(char, "Torso") or GetRealPart(char, "UpperTorso")
end

local function GetHealth(char)
    local hp, maxHp = tonumber(char:GetAttribute("Health")), tonumber(char:GetAttribute("MaxHealth"))
    local hum = char:FindFirstChildOfClass("Humanoid")
    if not hp and hum then hp = hum.Health end
    if not maxHp and hum and hum.MaxHealth > 0 then maxHp = hum.MaxHealth end
    maxHp = (maxHp and maxHp > 0) and maxHp or 100
    return math.clamp(hp or maxHp, 0, maxHp), maxHp
end

local function IsStaleShell(char, root)
    local now, pos = os.clock(), root.Position
    local track = R.RootTrack[char]
    if not track then
        R.RootTrack[char] = { Pos = pos, Moved = now }
        return false
    end
    if (pos - track.Pos).Magnitude > 0.01 then
        track.Pos, track.Moved = pos, now
        return false
    end
    if now - track.Moved < 0.35 then return false end
    local kin = GetModule("RuntimeKinematics", { "MovementV2", "RuntimeKinematics" })
    local ok, rec = pcall(function() return kin and kin.read(char) end)
    return ok and type(rec) == "table" and typeof(rec.Velocity) == "Vector3" and rec.Velocity.Magnitude > 2
end

local function IsRealCharacter(char)
    if not (char and char:IsA("Model")) then return false end

    if char:GetAttribute("Dead") == true or char:GetAttribute("Alive") == false or char:GetAttribute("Decoy") == true then
        return false
    end
    if char:FindFirstChild("Dead") or char:FindFirstChild("Decoy") then return false end
    if GetHealth(char) <= 0 then return false end

    local head, root = GetRealPart(char, "Head"), GetRealRoot(char)
    if not (head and root) then return false end

    if (head.Position - root.Position).Magnitude > 12 or math.abs(root.Position.Y) > 1200 then
        return false
    end

    local torso = GetRealPart(char, "UpperTorso") or GetRealPart(char, "Torso") or root
    if head.LocalTransparencyModifier >= 0.99 and torso.LocalTransparencyModifier >= 0.99 then
        return false
    end
    if IsStaleShell(char, root) then return false end

    for _, part in ipairs(char:GetChildren()) do
        if part:IsA("BasePart") and part.Transparency < 0.85 and part.Name ~= "HumanoidRootPart" then
            return true
        end
    end
    return char:FindFirstChild("Hitbox") ~= nil
end

local function CharacterFolders()
    local folders = {}
    for _, name in ipairs({ "Characters", "Players", "PlayerModels", "Entities" }) do
        local f = Workspace:FindFirstChild(name)
        if f then table.insert(folders, f) end
    end
    local map = Workspace:FindFirstChild("Map")
    if map then
        for _, name in ipairs({ "Characters", "Players" }) do
            local f = map:FindFirstChild(name)
            if f then table.insert(folders, f) end
        end
    end
    return folders
end

local function GetRealCharacter(plr)
    if plr:GetAttribute("Dead") == true or plr:GetAttribute("Alive") == false then return nil end
    for _, folder in ipairs(CharacterFolders()) do
        local c = folder:FindFirstChild(plr.Name)
        if c and IsRealCharacter(c) then return c end
    end
    local char = plr.Character
    if char and IsRealCharacter(char) then return char end
    return nil
end

local function IsKnownDead(plr)
    if plr:GetAttribute("Dead") == true or plr:GetAttribute("Alive") == false then return true end
    local char = plr.Character
    return char ~= nil and char:GetAttribute("Dead") == true
end

local function ESPIsEnemy(plr)
    if plr == LocalPlayer then return false end
    if Workspace:GetAttribute("Gamemode") == "Deathmatch" then return true end
    local theirs, mine = plr:GetAttribute("Team"), LocalPlayer:GetAttribute("Team")
    if theirs ~= nil or mine ~= nil then return theirs ~= mine end
    if plr.Team and LocalPlayer.Team then return plr.Team ~= LocalPlayer.Team end
    return true
end

local function LocalCharacter()
    for _, folder in ipairs(CharacterFolders()) do
        local c = folder:FindFirstChild(LocalPlayer.Name)
        if c and c:IsA("Model") then return c end
    end
    return LocalPlayer.Character
end

RealChars.Get = GetRealCharacter
RealChars.Part = GetRealPart
RealChars.IsReal = IsRealCharacter
RealChars.Folders = CharacterFolders
RealChars.Health = function(char) return (GetHealth(char)) end

RealChars.LocalAlive = function()
    if LocalPlayer:GetAttribute("Dead") == true or LocalPlayer:GetAttribute("Alive") == false then return false end
    local char = LocalCharacter()
    if not (char and char:IsDescendantOf(Workspace)) then return false end
    if char:GetAttribute("Dead") == true then return false end
    return GetHealth(char) > 0
end

RealChars.EnemyTargets = function()
    local list = {}
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer and ESPIsEnemy(plr) then
            local char = GetRealCharacter(plr)
            if char then table.insert(list, { Player = plr, Char = char }) end
        end
    end
    return list
end

local function Get2DBoundingBox(char, root)
    local cframe, size = char:GetBoundingBox()
    if size.Y > 20 or size.X > 15 or size.Z > 15 or (cframe.Position - root.Position).Magnitude > 8 then
        cframe, size = root.CFrame, Vector3.new(4, 5.5, 3)
    end

    local half = size * 0.5
    local minX, minY, maxX, maxY = math.huge, math.huge, -math.huge, -math.huge
    local anyOnScreen = false

    for _, sx in ipairs({ -1, 1 }) do
        for _, sy in ipairs({ -1, 1 }) do
            for _, sz in ipairs({ -1, 1 }) do
                local scr, onScreen = Camera:WorldToViewportPoint(cframe * Vector3.new(half.X * sx, half.Y * sy, half.Z * sz))
                if scr.Z > 0 then
                    minX, minY = math.min(minX, scr.X), math.min(minY, scr.Y)
                    maxX, maxY = math.max(maxX, scr.X), math.max(maxY, scr.Y)
                    anyOnScreen = anyOnScreen or onScreen
                end
            end
        end
    end

    if not anyOnScreen or minX == math.huge then return nil end
    return { X = minX, Y = minY, W = maxX - minX, H = maxY - minY, CenterX = (minX + maxX) * 0.5, TopY = minY, BottomY = maxY }
end

local ESP_SINGLE_KEYS = {
    "FullBox", "FullBoxOutline", "Tracer", "Name", "Weapon",
    "HealthBarOutline", "HealthBar", "HealthText", "HeadDot", "Ghost",
    "Loadout", "BombTag",
}
local ESP_ARRAY_KEYS = { "Corners", "CornerOutlines", "Skeleton" }

local function GetESP(plr)
    local e = R.ESP[plr]
    if e then return e end

    e = {
        FullBox          = NewDraw("Square", { Filled = false, Transparency = 1 }),
        FullBoxOutline   = NewDraw("Square", { Filled = false, Transparency = 1, Color = Color3.new(0, 0, 0) }),
        Tracer           = NewDraw("Line", { Transparency = 1 }),
        Name             = NewDraw("Text", { Size = 13, Center = true, Outline = true, Font = 2, Color = Color3.new(1, 1, 1) }),
        Weapon           = NewDraw("Text", { Size = 12, Center = true, Outline = true, Font = 2, Color = Color3.fromRGB(220, 220, 220) }),
        HealthBarOutline = NewDraw("Line", { Thickness = 4, Transparency = 1, Color = Color3.new(0, 0, 0) }),
        HealthBar        = NewDraw("Line", { Thickness = 2, Transparency = 1 }),
        HealthText       = NewDraw("Text", { Size = 11, Center = false, Outline = true, Font = 2 }),
        HeadDot          = NewDraw("Circle", { Radius = 3, Filled = true, NumSides = 16, Transparency = 1 }),
        Ghost            = NewDraw("Text", { Size = 12, Center = true, Outline = true, Font = 2 }),
        Loadout          = NewDraw("Text", { Size = 11, Center = true, Outline = true, Font = 2, Color = Color3.fromRGB(190, 190, 190) }),
        BombTag          = NewDraw("Text", { Size = 13, Center = true, Outline = true, Font = 2, Text = "[C4]" }),
        Corners          = {},
        CornerOutlines   = {},
        Skeleton         = {},
    }
    for i = 1, 8 do
        e.Corners[i] = NewDraw("Line", { Transparency = 1 })
        e.CornerOutlines[i] = NewDraw("Line", { Thickness = 3.5, Transparency = 1, Color = Color3.new(0, 0, 0) })
    end
    for i = 1, 15 do
        e.Skeleton[i] = NewDraw("Line", { Transparency = 1 })
    end

    local hl = Instance.new("Highlight")
    hl.FillTransparency = 0.6
    hl.OutlineTransparency = 0
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
    hl.Enabled = false
    hl.Parent = ESPFolder
    e.Highlight = hl

    R.ESP[plr] = e
    return e
end

local function SetVisible(obj, visible)
    if obj then obj.Visible = visible end
end

local function HideESP(e, keepGhost)
    for _, key in ipairs(ESP_SINGLE_KEYS) do
        if not (keepGhost and key == "Ghost") then SetVisible(e[key], false) end
    end
    for _, key in ipairs(ESP_ARRAY_KEYS) do
        for _, obj in ipairs(e[key]) do SetVisible(obj, false) end
    end
    e.Highlight.Enabled = false
end

local function DestroyESP(plr)
    local e = R.ESP[plr]
    if not e then return end
    for _, key in ipairs(ESP_SINGLE_KEYS) do
        if e[key] then pcall(function() e[key]:Remove() end) end
    end
    for _, key in ipairs(ESP_ARRAY_KEYS) do
        for _, obj in ipairs(e[key]) do pcall(function() obj:Remove() end) end
    end
    SafeDestroy(e.Highlight)
    R.ESP[plr] = nil
    R.GhostCache[plr] = nil
    R.EquipCache[plr] = nil
    R.Loadout[plr] = nil
end

Track(Players.PlayerRemoving:Connect(DestroyESP))

local function DrawGhost(e, plr)
    local seen = R.GhostCache[plr]
    if not (S.ESPLastSeen and seen and e.Ghost) then
        SetVisible(e.Ghost, false)
        return
    end
    local age = os.clock() - seen.Time
    local screen, onScreen = Camera:WorldToViewportPoint(seen.Pos)
    if age > S.LastSeenTime or not onScreen then
        e.Ghost.Visible = false
        return
    end
    e.Ghost.Text = string.format("? %s [%.1fs]", plr.Name, age)
    e.Ghost.Position = Vector2.new(screen.X, screen.Y)
    e.Ghost.Color = S.GhostColor
    e.Ghost.Transparency = math.clamp(1 - age / S.LastSeenTime, 0.15, 1)
    e.Ghost.Visible = true
end

local function DrawBox(e, box, color)
    local showFull = S.ESPBox and S.ESPBoxType == "Full"
    local showCorner = S.ESPBox and S.ESPBoxType ~= "Full"
    local thickness = S.ESPBoxThickness

    SetVisible(e.FullBox, showFull)
    SetVisible(e.FullBoxOutline, showFull and S.ESPBoxOutline)
    if showFull and e.FullBox then
        e.FullBox.Size, e.FullBox.Position = Vector2.new(box.W, box.H), Vector2.new(box.X, box.Y)
        e.FullBox.Color, e.FullBox.Thickness = color, thickness
        if e.FullBoxOutline then
            e.FullBoxOutline.Size, e.FullBoxOutline.Position = e.FullBox.Size, e.FullBox.Position
            e.FullBoxOutline.Thickness = thickness + 2
        end
    end

    if not showCorner then
        for i = 1, 8 do
            SetVisible(e.Corners[i], false)
            SetVisible(e.CornerOutlines[i], false)
        end
        return
    end

    local lenX = math.clamp(box.W * 0.25, 4, 18)
    local lenY = math.clamp(box.H * 0.20, 4, 18)
    local l, t, r, b = box.X, box.Y, box.X + box.W, box.Y + box.H
    local segments = {
        { Vector2.new(l, t), Vector2.new(l + lenX, t) }, { Vector2.new(l, t), Vector2.new(l, t + lenY) },
        { Vector2.new(r, t), Vector2.new(r - lenX, t) }, { Vector2.new(r, t), Vector2.new(r, t + lenY) },
        { Vector2.new(l, b), Vector2.new(l + lenX, b) }, { Vector2.new(l, b), Vector2.new(l, b - lenY) },

        { Vector2.new(r, b), Vector2.new(r - lenX, b) }, { Vector2.new(r, b), Vector2.new(r, b - lenY) },
    }

    for i, seg in ipairs(segments) do
        local line, outline = e.Corners[i], e.CornerOutlines[i]
        if outline then
            outline.Visible = S.ESPBoxOutline
            outline.From, outline.To = seg[1], seg[2]
            outline.Thickness = thickness + 2
        end
        if line then
            line.Visible = true
            line.From, line.To = seg[1], seg[2]
            line.Color, line.Thickness = color, thickness
        end
    end
end

local function DrawTracer(e, box, color)
    if not (S.ESPTracer and e.Tracer) then
        SetVisible(e.Tracer, false)
        return
    end
    local vp = Camera.ViewportSize
    local originY = (S.ESPTracerOrigin == "Middle" and vp.Y * 0.5) or (S.ESPTracerOrigin == "Top" and 0) or vp.Y
    e.Tracer.From = Vector2.new(vp.X * 0.5, originY)
    e.Tracer.To = Vector2.new(box.CenterX, box.BottomY)
    e.Tracer.Color = color
    e.Tracer.Visible = true
end

local function DrawLabels(e, plr, box, dist)
    if e.Name then
        local tag = plr.DisplayName
        if S.ESPDistance then tag = string.format("%s [%d m]", tag, math.floor(dist * 0.28)) end
        e.Name.Text = tag
        e.Name.Position = Vector2.new(box.CenterX, box.TopY - 16)
        e.Name.Visible = S.ESPName
    end
    if e.Weapon then
        local weapon = EquippedName(plr) or ""
        e.Weapon.Text = weapon
        e.Weapon.Position = Vector2.new(box.CenterX, box.BottomY + 2)
        e.Weapon.Visible = S.ESPWeapon and weapon ~= ""
    end
end

local function DrawHealth(e, char, box)
    if not (S.ESPHealth and e.HealthBar) then
        SetVisible(e.HealthBar, false)
        SetVisible(e.HealthBarOutline, false)
        SetVisible(e.HealthText, false)
        return
    end

    local hp, maxHp = GetHealth(char)
    local pct = hp / maxHp
    local barX = (S.ESPHealthSide == "Right") and (box.X + box.W + 5) or (box.X - 5)
    local barHeight = box.H * pct
    local hpColor = Color3.fromRGB(255, 50, 50):Lerp(Color3.fromRGB(0, 255, 128), pct)

    if e.HealthBarOutline then
        e.HealthBarOutline.From = Vector2.new(barX, box.Y)
        e.HealthBarOutline.To = Vector2.new(barX, box.Y + box.H)
        e.HealthBarOutline.Visible = true
    end
    e.HealthBar.From = Vector2.new(barX, box.Y + box.H)
    e.HealthBar.To = Vector2.new(barX, box.Y + box.H - barHeight)
    e.HealthBar.Color = hpColor
    e.HealthBar.Visible = true

    if e.HealthText then
        e.HealthText.Visible = pct < 1
        if pct < 1 then
            e.HealthText.Text = tostring(math.floor(hp))
            e.HealthText.Color = hpColor
            e.HealthText.Position = Vector2.new(barX - 18, box.Y + box.H - barHeight - 6)
        end
    end
end

local function DrawHeadDot(e, head, color)
    if not (S.ESPHeadDot and e.HeadDot) then
        SetVisible(e.HeadDot, false)
        return
    end
    local scr, onScreen = Camera:WorldToViewportPoint(head.Position)
    e.HeadDot.Position = Vector2.new(scr.X, scr.Y)
    e.HeadDot.Color = color
    e.HeadDot.Visible = onScreen
end

local function DrawSkeleton(e, char)
    local used = 0
    if S.ESPSkeleton then
        local hum = char:FindFirstChildOfClass("Humanoid")
        local isR6 = (hum and hum.RigType == Enum.HumanoidRigType.R6)
            or (GetRealPart(char, "Torso") ~= nil and GetRealPart(char, "UpperTorso") == nil)
        for _, pair in ipairs(isR6 and ESP_BONES_R6 or ESP_BONES_R15) do
            local p1, p2 = GetRealPart(char, pair[1]), GetRealPart(char, pair[2])
            if p1 and p2 then
                local s1, v1 = Camera:WorldToViewportPoint(p1.Position)
                local s2, v2 = Camera:WorldToViewportPoint(p2.Position)
                local line = e.Skeleton[used + 1]
                if v1 and v2 and line then
                    used = used + 1
                    line.From, line.To = Vector2.new(s1.X, s1.Y), Vector2.new(s2.X, s2.Y)
                    line.Color, line.Thickness = S.SkeletonColor, S.ESPSkeletonThickness
                    line.Visible = true
                end
            end
        end
    end
    for i = used + 1, #e.Skeleton do SetVisible(e.Skeleton[i], false) end
end

local GRENADE_SHORT = {
    ["HE Grenade"] = "HE", Flashbang = "Flash", ["Smoke Grenade"] = "Smoke",
    Molotov = "Molotov", ["Incendiary Grenade"] = "Incendiary", ["Decoy Grenade"] = "Decoy",
}

local function DecodeJSON(raw)
    if type(raw) ~= "string" or raw == "" then return nil end
    local ok, data = pcall(HttpService.JSONDecode, HttpService, raw)
    return ok and type(data) == "table" and data or nil
end

local function GetLoadout(plr)
    local raws = {}
    for i = 1, 6 do raws[i] = tostring(plr:GetAttribute("Slot" .. i)) end
    raws[7] = tostring(plr:GetAttribute("Armor"))
    raws[8] = tostring(plr:GetAttribute("Money"))
    local key = table.concat(raws, "\1")
    local cached = R.Loadout[plr]
    if cached and cached.Key == key then return cached end

    local guns, nades, hasC4 = {}, {}, false
    local function add(name)
        if type(name) ~= "string" or name == "" then return end
        if name == "C4" then
            hasC4 = true
        elseif GRENADE_SHORT[name] then
            table.insert(nades, GRENADE_SHORT[name])
        elseif not IsMeleeWeapon(name) then
            table.insert(guns, name)
        end
    end
    for i = 1, 6 do
        local data = DecodeJSON(plr:GetAttribute("Slot" .. i))
        if data then
            if data.Weapon ~= nil then
                add(data.Weapon)
            else

                for _, entry in ipairs(data) do
                    if type(entry) == "table" then add(entry.Weapon or entry.Name) end
                end
            end
        end
    end

    local armor = DecodeJSON(plr:GetAttribute("Armor"))
    local armorText = (armor and (tonumber(armor.Health) or 0) > 0 and armor.Type ~= nil) and tostring(armor.Type) or nil

    cached = { Key = key, Guns = guns, Nades = nades, HasC4 = hasC4, Armor = armorText, Money = tonumber(plr:GetAttribute("Money")) }
    R.Loadout[plr] = cached
    return cached
end

local function DrawLoadout(e, plr, box)
    local info = (S.ESPLoadout or S.ESPBombCarrier) and GetLoadout(plr) or nil
    if e.Loadout then
        local parts = {}
        if info and S.ESPLoadout then
            if #info.Guns > 0 then table.insert(parts, table.concat(info.Guns, " / ")) end
            if #info.Nades > 0 then table.insert(parts, table.concat(info.Nades, " ")) end
            if info.Armor then table.insert(parts, info.Armor) end
            if S.ESPMoney and info.Money then table.insert(parts, "$" .. info.Money) end
        end
        local text = table.concat(parts, "  |  ")
        e.Loadout.Text = text
        local below = (e.Weapon and e.Weapon.Visible) and 15 or 2
        e.Loadout.Position = Vector2.new(box.CenterX, box.BottomY + below)
        e.Loadout.Visible = text ~= ""
    end
    if e.BombTag then
        local show = info ~= nil and S.ESPBombCarrier and info.HasC4
        if show then
            e.BombTag.Color = S.BombColor
            e.BombTag.Position = Vector2.new(box.CenterX, box.TopY - ((e.Name and e.Name.Visible) and 30 or 16))
        end
        e.BombTag.Visible = show and true or false
    end
end

local function RenderPlayerESP(plr, e, params)
    if not S.ESP then
        HideESP(e)
        return
    end

    local enemy = ESPIsEnemy(plr)
    if not enemy and not S.ESPTeammates then
        HideESP(e)
        return
    end
    local color = enemy and S.EnemyColor or S.TeamColor

    local char = GetRealCharacter(plr)
    if not char then

        HideESP(e, true)
        if IsKnownDead(plr) then R.GhostCache[plr] = nil end
        DrawGhost(e, plr)
        return
    end

    local head, root = GetRealPart(char, "Head"), GetRealRoot(char)
    local dist = (Camera.CFrame.Position - root.Position).Magnitude

    local subject = Camera.CameraSubject
    if dist > S.ESPMaxDistance or (subject and subject:IsDescendantOf(char)) then
        HideESP(e)
        return
    end

    R.GhostCache[plr] = { Pos = head.Position, Time = os.clock() }
    SetVisible(e.Ghost, false)

    if enemy and params and (IsVisible(head, char, params) or IsVisible(root, char, params)) then
        color = S.EnemyVisibleColor
    end

    e.Highlight.Adornee = char
    e.Highlight.FillColor = color
    e.Highlight.OutlineColor = S.ChamsOutlineWhite and Color3.new(1, 1, 1) or color
    e.Highlight.FillTransparency = S.ChamsFillT
    e.Highlight.OutlineTransparency = S.ChamsOutlineT
    e.Highlight.DepthMode = S.ChamsVisibleOnly and Enum.HighlightDepthMode.Occluded or Enum.HighlightDepthMode.AlwaysOnTop
    e.Highlight.Enabled = S.ESPChams

    if not HasDrawing then return end

    local box = Get2DBoundingBox(char, root)
    if not box then
        HideESP(e)
        e.Highlight.Enabled = S.ESPChams
        return
    end

    DrawBox(e, box, color)
    DrawTracer(e, box, color)
    DrawLabels(e, plr, box, dist)
    DrawHealth(e, char, box)
    DrawHeadDot(e, head, color)
    DrawSkeleton(e, char)
    DrawLoadout(e, plr, box)
end

local function UpdateESP()

    local params = (S.ESP and S.ESPVisibleColors) and BuildRayParams(true) or nil
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local e = GetESP(plr)
            local ok = pcall(RenderPlayerESP, plr, e, params)
            if not ok then HideESP(e) end
        end
    end
end

local AimFOVCircle    = NewDraw("Circle", { Thickness = 1, NumSides = 64, Filled = false, Transparency = 1 })
local SilentFOVCircle = NewDraw("Circle", { Thickness = 1, NumSides = 64, Filled = false, Transparency = 1 })

local SoundDrawings = {}
for i = 1, 16 do
    SoundDrawings[i] = NewDraw("Text", { Size = 12, Center = true, Outline = true, Font = 2, Color = S.SoundColor })
end

local function UpdateSoundESP()
    local count = 0
    if S.SoundESP then
        local now = os.clock()
        for _, ev in ipairs(R.SoundEvents) do
            local age = now - ev.Time
            if age <= S.SoundESPTime and count < #SoundDrawings then
                local screen, onScreen = Camera:WorldToViewportPoint(ev.Pos)
                if onScreen then
                    count = count + 1
                    local d = SoundDrawings[count]
                    d.Text = string.format("(( %s ))", ev.Kind)
                    d.Position = Vector2.new(screen.X, screen.Y)
                    d.Transparency = math.clamp(1 - age / S.SoundESPTime, 0.2, 1)
                    d.Visible = true
                end
            end
        end
    end
    for i = count + 1, #SoundDrawings do
        SoundDrawings[i].Visible = false
    end
end

local WorldDrawings = {}
local function GetWorldDraw(id)
    if not WorldDrawings[id] then
        WorldDrawings[id] = NewDraw("Text", { Size = 12, Center = true, Outline = true, Font = 2 })
    end
    return WorldDrawings[id]
end

local function UpdateWorldESP()
    local used = 0

    if S.DroppedWeaponESP then
        for _, item in ipairs(CollectionService:GetTagged("WeaponDropped")) do
            if item and item:IsA("Model") and item.PrimaryPart then
                local pos = item.PrimaryPart.Position
                local screen, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    used = used + 1
                    local draw = GetWorldDraw("W_" .. used)
                    local dist = math.floor((Camera.CFrame.Position - pos).Magnitude)
                    draw.Text = string.format("[%s] %dm", item.Name, math.floor(dist * 0.28))
                    draw.Position = Vector2.new(screen.X, screen.Y)
                    draw.Color = S.WeaponColor
                    draw.Visible = true
                end
            end
        end
    end

    if S.GrenadeESP then
        for _, gren in ipairs(CollectionService:GetTagged("Grenade")) do
            if gren and gren:IsA("Model") then

                local pos = gren.PrimaryPart and gren.PrimaryPart.Position or gren:GetPivot().Position
                local screen, onScreen = Camera:WorldToViewportPoint(pos)
                if onScreen then
                    used = used + 1
                    local draw = GetWorldDraw("G_" .. used)
                    local dist = math.floor((Camera.CFrame.Position - pos).Magnitude)
                    draw.Text = string.format("[%s] %dm", tostring(gren:GetAttribute("GrenadeName") or "Grenade"), math.floor(dist * 0.28))
                    draw.Position = Vector2.new(screen.X, screen.Y)
                    draw.Color = S.GrenadeColor
                    draw.Visible = true
                end
            end
        end
    end

    if S.BombESP and R.ActivePlantedBomb and R.ActivePlantedBomb.Model then
        local bombModel = R.ActivePlantedBomb.Model
        if bombModel.PrimaryPart then
            local pos = bombModel.PrimaryPart.Position
            local screen, onScreen = Camera:WorldToViewportPoint(pos)
            if onScreen then
                used = used + 1
                local draw = GetWorldDraw("BombMarker")
                local dist = math.floor((Camera.CFrame.Position - pos).Magnitude)
                local timeRem = math.max(0, R.ActivePlantedBomb.ExplodeAt - Workspace:GetServerTimeNow())

                draw.Text = string.format("C4 [%s] %.1fs  %dm", tostring(R.ActivePlantedBomb.Site or "?"), timeRem, math.floor(dist * 0.28))
                draw.Position = Vector2.new(screen.X, screen.Y)
                draw.Color = S.BombColor
                draw.Visible = true
            end
        end
    end

    for id, draw in pairs(WorldDrawings) do
        if not id:find("BombMarker") and (id:find("W_") or id:find("G_")) then
            local num = tonumber(id:sub(3)) or 0
            if num > used then draw.Visible = false end
        end
    end
end

Track(CollectionService:GetInstanceAddedSignal("Bomb"):Connect(function(inst)
    if inst:IsA("Model") then
        local dataRaw = inst:GetAttribute("BombPlanted")
        local data = {}
        if type(dataRaw) == "string" and dataRaw ~= "" then
            pcall(function() data = HttpService:JSONDecode(dataRaw) end)
        end
        local timePlanted = type(data.Time) == "number" and data.Time or Workspace:GetServerTimeNow()
        local timeToExplode = type(data.TimeUntilExplode) == "number" and data.TimeUntilExplode or 40
        R.ActivePlantedBomb = {
            Model = inst,
            TimePlanted = timePlanted,
            ExplodeAt = timePlanted + timeToExplode,
            Site = inst:GetAttribute("Site") or "Planted",
        }
    end
end))

Track(CollectionService:GetInstanceRemovedSignal("Bomb"):Connect(function(inst)
    if R.ActivePlantedBomb and R.ActivePlantedBomb.Model == inst then
        R.ActivePlantedBomb = nil
    end
end))

for _, b in ipairs(CollectionService:GetTagged("Bomb")) do
    if b:IsA("Model") then
        local dataRaw = b:GetAttribute("BombPlanted")
        local data = {}
        if type(dataRaw) == "string" and dataRaw ~= "" then
            pcall(function() data = HttpService:JSONDecode(dataRaw) end)
        end
        local timePlanted = type(data.Time) == "number" and data.Time or Workspace:GetServerTimeNow()
        local timeToExplode = type(data.TimeUntilExplode) == "number" and data.TimeUntilExplode or 40
        R.ActivePlantedBomb = {
            Model = b,
            TimePlanted = timePlanted,
            ExplodeAt = timePlanted + timeToExplode,
            Site = b:GetAttribute("Site") or "Planted",
        }
        break
    end
end

local Overlay = { All = {}, Dots = {}, Arrows = {}, ArrowText = {}, Lines = {}, NadeLabels = {}, LinesUsed = 0 }

local function OverlayNew(class, props)
    local d = NewDraw(class, props)
    if d then table.insert(Overlay.All, d) end
    return d
end

local function OverlayDraw(key, class, props)
    local d = Overlay[key]
    if d == nil then
        d = OverlayNew(class, props) or false
        Overlay[key] = d
    end
    return d or nil
end

local function PoolGet(pool, i, class, props)
    local d = pool[i]
    if d == nil then
        d = OverlayNew(class, props) or false
        pool[i] = d
    end
    return d or nil
end

local function PoolHide(pool, from)
    for i = from, #pool do
        local d = pool[i]
        if d then d.Visible = false end
    end
end

local function FrameLine(from, to, color, thickness, alpha)
    Overlay.LinesUsed = Overlay.LinesUsed + 1
    local l = PoolGet(Overlay.Lines, Overlay.LinesUsed, "Line", { Transparency = 1, ZIndex = 2 })
    if l then
        l.From, l.To, l.Color = from, to, color
        l.Thickness, l.Transparency = thickness or 1.5, alpha or 1
        l.Visible = true
    end
end

local function WorldLine(a, b, color, thickness, alpha)
    local sa = Camera:WorldToViewportPoint(a)
    local sb = Camera:WorldToViewportPoint(b)
    if sa.Z <= 0.1 or sb.Z <= 0.1 then return end
    FrameLine(Vector2.new(sa.X, sa.Y), Vector2.new(sb.X, sb.Y), color, thickness, alpha)
end

local function WorldRing(center, radius, color, segments)
    segments = segments or 16
    local prev
    for i = 0, segments do
        local a = (i / segments) * math.pi * 2
        local p = center + Vector3.new(math.cos(a) * radius, 0.15, math.sin(a) * radius)
        if prev then WorldLine(prev, p, color, 1.5, 0.9) end
        prev = p
    end
end

function Overlay.Destroy()
    for _, d in ipairs(Overlay.All) do pcall(function() d:Remove() end) end
    table.clear(Overlay.All)
end

Overlay.RadarKeys = { "RadarBg", "RadarBorder", "RadarH", "RadarV", "RadarSelf", "RadarBomb" }

local function UpdateRadar()
    if not (S.Radar and HasDrawing) then
        if Overlay.RadarShown then
            for _, key in ipairs(Overlay.RadarKeys) do
                if Overlay[key] then Overlay[key].Visible = false end
            end
            PoolHide(Overlay.Dots, 1)
            Overlay.RadarShown = false
        end
        return
    end
    Overlay.RadarShown = true

    local vp = Camera.ViewportSize
    local size = S.RadarSize
    local half = size / 2
    local left = S.RadarCorner == "Top Left" or S.RadarCorner == "Bottom Left"
    local top = S.RadarCorner == "Top Left" or S.RadarCorner == "Top Right"
    local x = left and 16 or (vp.X - size - 16)
    local y = top and 72 or (vp.Y - size - 16)
    local cx, cy = x + half, y + half

    local bg = OverlayDraw("RadarBg", "Square", { Filled = true, Color = Color3.fromRGB(12, 12, 12), Transparency = 0.55, ZIndex = 1 })
    local border = OverlayDraw("RadarBorder", "Square", { Filled = false, Thickness = 1, Color = Color3.fromRGB(255, 140, 40), Transparency = 1, ZIndex = 2 })
    local lineH = OverlayDraw("RadarH", "Line", { Thickness = 1, Color = Color3.fromRGB(70, 70, 70), Transparency = 0.8, ZIndex = 2 })
    local lineV = OverlayDraw("RadarV", "Line", { Thickness = 1, Color = Color3.fromRGB(70, 70, 70), Transparency = 0.8, ZIndex = 2 })
    local me = OverlayDraw("RadarSelf", "Triangle", { Filled = true, Color = Color3.new(1, 1, 1), Transparency = 1, ZIndex = 4 })
    if bg then bg.Position, bg.Size, bg.Visible = Vector2.new(x, y), Vector2.new(size, size), true end
    if border then border.Position, border.Size, border.Visible = Vector2.new(x, y), Vector2.new(size, size), true end
    if lineH then lineH.From, lineH.To, lineH.Visible = Vector2.new(x, cy), Vector2.new(x + size, cy), true end
    if lineV then lineV.From, lineV.To, lineV.Visible = Vector2.new(cx, y), Vector2.new(cx, y + size), true end
    if me then
        me.PointA, me.PointB, me.PointC = Vector2.new(cx, cy - 6), Vector2.new(cx - 4.5, cy + 5), Vector2.new(cx + 4.5, cy + 5)
        me.Visible = true
    end

    local cf = Camera.CFrame
    local look = Vector3.new(cf.LookVector.X, 0, cf.LookVector.Z)
    look = look.Magnitude > 1e-3 and look.Unit or Vector3.new(0, 0, -1)
    local right = Vector3.new(-look.Z, 0, look.X)
    local scale = half / math.max(S.RadarRange, 1)
    local limit = half - 4

    local function toRadar(pos)
        local d = pos - cf.Position
        local px, py = d:Dot(right) * scale, -d:Dot(look) * scale
        local m = math.max(math.abs(px), math.abs(py))
        if m > limit then

            px, py = px / m * limit, py / m * limit
        end
        return Vector2.new(cx + px, cy + py), m > limit
    end

    local used = 0
    local function dot(pos, color, radius, alpha)
        used = used + 1
        local d = PoolGet(Overlay.Dots, used, "Circle", { Filled = true, NumSides = 12, ZIndex = 3 })
        if not d then return end
        local p, pinned = toRadar(pos)
        d.Position, d.Color = p, color
        d.Radius = pinned and radius * 0.7 or radius
        d.Transparency = alpha or 1
        d.Visible = true
    end

    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local enemy = ESPIsEnemy(plr)
            if enemy or S.RadarTeammates then
                local char = GetRealCharacter(plr)
                local root = char and GetRealRoot(char)
                if root then
                    local carrier = GetLoadout(plr).HasC4
                    dot(root.Position, carrier and S.BombColor or (enemy and S.EnemyColor or S.TeamColor), carrier and 4.5 or 3.5)
                elseif enemy and S.RadarGhosts then
                    local seen = R.GhostCache[plr]
                    if seen and os.clock() - seen.Time <= S.LastSeenTime then
                        dot(seen.Pos, S.GhostColor, 3, 0.5)
                    end
                end
            end
        end
    end
    PoolHide(Overlay.Dots, used + 1)

    local bombMark = OverlayDraw("RadarBomb", "Square", { Filled = true, Size = Vector2.new(6, 6), Transparency = 1, ZIndex = 3 })
    if bombMark then
        local bomb = R.ActivePlantedBomb
        local part = bomb and bomb.Model and bomb.Model.PrimaryPart
        if part then
            bombMark.Position = toRadar(part.Position) - Vector2.new(3, 3)
            bombMark.Color = S.BombColor
        end
        bombMark.Visible = part ~= nil
    end
end

local function UpdateArrows()
    local used = 0
    if S.OffscreenArrows and HasDrawing then
        local cf = Camera.CFrame
        local center = Camera.ViewportSize / 2
        for _, plr in ipairs(Players:GetPlayers()) do
            if plr ~= LocalPlayer and ESPIsEnemy(plr) then
                local char = GetRealCharacter(plr)
                local root = char and GetRealRoot(char)
                if root then
                    local dist = (root.Position - cf.Position).Magnitude
                    local _, onScreen = Camera:WorldToViewportPoint(root.Position)
                    if not onScreen and dist <= S.ESPMaxDistance then

                        local rel = cf:PointToObjectSpace(root.Position)
                        local dir = Vector2.new(rel.X, rel.Z)
                        dir = dir.Magnitude > 1e-3 and dir.Unit or Vector2.new(0, 1)
                        local side = Vector2.new(-dir.Y, dir.X)
                        local tip = center + dir * S.ArrowRadius
                        local size = S.ArrowSize

                        used = used + 1
                        local tri = PoolGet(Overlay.Arrows, used, "Triangle", { Filled = true, Transparency = 1, ZIndex = 2 })
                        if tri then
                            tri.PointA = tip
                            tri.PointB = tip - dir * size + side * size * 0.55
                            tri.PointC = tip - dir * size - side * size * 0.55
                            tri.Color = S.EnemyColor
                            tri.Visible = true
                        end
                        local label = PoolGet(Overlay.ArrowText, used, "Text", { Size = 12, Center = true, Outline = true, Font = 2 })
                        if label then
                            label.Text = string.format("%dm", math.floor(dist * 0.28))
                            label.Position = tip - dir * (size + 12) - Vector2.new(0, 6)
                            label.Color = S.EnemyColor
                            label.Visible = S.ArrowDistance
                        end
                    end
                end
            end
        end
    end
    PoolHide(Overlay.Arrows, used + 1)
    PoolHide(Overlay.ArrowText, used + 1)
end

local function UpdateHUD()
    local vp = Camera.ViewportSize

    local count = tonumber(LocalPlayer:GetAttribute("Spectators")) or 0
    if S.SpectatorAlert and count > R.LastSpectators then
        Notify("BloxStrike", string.format("%d %s spectating you.", count, count == 1 and "player is" or "players are"), 4)
    end
    R.LastSpectators = count

    local spec = HasDrawing and OverlayDraw("HudSpec", "Text", { Size = 15, Center = false, Outline = true, Font = 2, Color = Color3.fromRGB(255, 190, 60) }) or nil
    if spec then
        spec.Visible = S.SpectatorHUD and count > 0
        if spec.Visible then
            spec.Text = "spectators: " .. count
            spec.Position = Vector2.new(16, vp.Y * 0.42)
        end
    end

    local bombText = HasDrawing and OverlayDraw("HudBomb", "Text", { Size = 18, Center = true, Outline = true, Font = 2 }) or nil
    if bombText then
        local bomb = R.ActivePlantedBomb
        local left = (S.BombTimerHUD and bomb and bomb.Model and bomb.Model.Parent)
            and (bomb.ExplodeAt - Workspace:GetServerTimeNow()) or 0
        if left > 0 then
            bombText.Text = string.format("C4 [%s]  %.1fs", tostring(bomb.Site), left)
            bombText.Color = (left <= 5 and Color3.fromRGB(255, 60, 60))
                or (left <= 10 and Color3.fromRGB(255, 190, 60))
                or Color3.new(1, 1, 1)
            bombText.Position = Vector2.new(vp.X / 2, vp.Y * 0.16)
        end
        bombText.Visible = left > 0
    end
end

local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
Overlay.FlashGuis = { FlashbangEffect = true, FlashScreenshot = true }
Overlay.SmokeSaved = setmetatable({}, { __mode = "k" })

local function ApplyAntiFlash(inst)
    if (inst:IsA("ScreenGui") and Overlay.FlashGuis[inst.Name])
        or (inst:IsA("ColorCorrectionEffect") and inst.Name == "FlashbangColorCorrection") then
        inst.Enabled = not S.AntiFlash
    elseif S.AntiFlash and inst:IsA("Sound") and inst.Name == "Flashed" then
        task.defer(function() pcall(function() inst:Stop() end) end)
    end
end

local function ApplyAntiSmoke(inst)
    if not (inst:IsA("ParticleEmitter") and inst:FindFirstAncestor("SmokeVoxel")) then return end
    if S.AntiSmoke then
        if Overlay.SmokeSaved[inst] == nil then Overlay.SmokeSaved[inst] = inst.Transparency end
        inst.Transparency = NumberSequence.new(1)
        inst:Clear()
    elseif Overlay.SmokeSaved[inst] then
        inst.Transparency = Overlay.SmokeSaved[inst]
        Overlay.SmokeSaved[inst] = nil
    end
end

local function RefreshAntiFlash()
    for _, parent in ipairs({ PlayerGui, Lighting, Camera }) do
        for _, child in ipairs(parent:GetChildren()) do pcall(ApplyAntiFlash, child) end
    end
end

local function RefreshAntiSmoke()
    local debris = Workspace:FindFirstChild("Debris")
    if debris then
        for _, d in ipairs(debris:GetDescendants()) do pcall(ApplyAntiSmoke, d) end
    end
    if not S.AntiSmoke then
        for inst, seq in pairs(Overlay.SmokeSaved) do
            pcall(function() inst.Transparency = seq end)
            Overlay.SmokeSaved[inst] = nil
        end
    end
end

Track(PlayerGui.ChildAdded:Connect(function(c) pcall(ApplyAntiFlash, c) end))
Track(Lighting.ChildAdded:Connect(function(c) pcall(ApplyAntiFlash, c) end))
Track(Camera.ChildAdded:Connect(function(c) pcall(ApplyAntiFlash, c) end))
task.spawn(function()
    local debris = Workspace:WaitForChild("Debris", 30)
    if debris and not R.Unloading then
        Track(debris.DescendantAdded:Connect(function(d) pcall(ApplyAntiSmoke, d) end))
    end
end)

local Nade = {
    DT = 1 / 128,
    Gravity = 23.83333396911621,
    StopSq = 2.3341049382716053,
    Fire = { Molotov = true, ["Incendiary Grenade"] = true },
    Ring = { ["HE Grenade"] = 10, Flashbang = 3, ["Smoke Grenade"] = 9, Molotov = 7, ["Incendiary Grenade"] = 7, ["Decoy Grenade"] = 2 },

    FuseGuess = { ["HE Grenade"] = 1.6, Flashbang = 1.6 },
}

local function NadeConfig(weapon, physics)
    local fire = Nade.Fire[weapon] == true
    local fuse = (physics and tonumber(physics.FuseTime)) or Nade.FuseGuess[weapon] or 0
    return {
        maxBounces = (physics and tonumber(physics.MaxBounces)) or 20,
        fuseTime = fuse > 0 and fuse or nil,
        minimumFuseTime = fire and 0.1 or nil,
        explodeOnFloorImpact = fire or nil,
    }
end

local function NadeRayParams(group)
    local ignore = { Camera }
    local debris = Workspace:FindFirstChild("Debris")
    if debris then table.insert(ignore, debris) end
    if LocalPlayer.Character then table.insert(ignore, LocalPlayer.Character) end
    local mine = LocalCharacter()
    if mine then table.insert(ignore, mine) end
    local p = RaycastParams.new()
    p.FilterType = Enum.RaycastFilterType.Exclude
    p.FilterDescendantsInstances = ignore
    p.RespectCanCollide = false
    p.IgnoreWater = true
    if type(group) == "string" and group ~= "" then pcall(function() p.CollisionGroup = group end) end
    return p
end

local function NadeBounce(vel, normal, jump, isPlayer)
    local e = math.clamp((jump and 0.32 or 0.4) * (isPlayer and 0.3 or 1), 0, 0.9)
    local v = vel - normal * (vel:Dot(normal) * 2)
    v = Vector3.new(
        math.abs(v.X) < 0.0076388888888888895 and 0 or v.X,
        math.abs(v.Y) < 0.0076388888888888895 and 0 or v.Y,
        math.abs(v.Z) < 0.0076388888888888895 and 0 or v.Z
    ) * e
    if normal.Y > 0.7 and v:Dot(v) < Nade.StopSq then v = Vector3.zero end
    return v
end

local function SimulateNade(pos, vel, jump, cfg, params, maxTime, sampleEvery)
    local points = { pos }
    local t, steps, bounces, grounded, touched = 0, 0, 0, false, false
    while t < maxTime do
        t = t + Nade.DT
        steps = steps + 1
        if t >= 10 or (cfg.fuseTime and t >= cfg.fuseTime) or bounces >= cfg.maxBounces then break end

        local nextPos, nextVel
        if grounded then
            nextPos, nextVel = pos + vel * Nade.DT, vel
        else
            local vy = vel.Y - Nade.DT * Nade.Gravity
            nextPos = pos + Vector3.new(vel.X * Nade.DT, (vel.Y + vy) / 2 * Nade.DT, vel.Z * Nade.DT)
            nextVel = Vector3.new(vel.X, vy, vel.Z)
        end

        local delta = nextPos - pos
        local hit = delta.Magnitude > 0.001 and Workspace:Raycast(pos, delta, params) or nil
        if hit then
            local model = hit.Instance.Parent
            local isPlayer = model ~= nil and model:IsA("Model") and model:GetAttribute("CharacterType") == "PlayerCustomCharacter"
            vel = NadeBounce(nextVel, hit.Normal, jump, isPlayer)
            pos = hit.Position + hit.Normal * 0.05
            bounces = bounces + 1
            touched = true
            table.insert(points, pos)
            if cfg.explodeOnFloorImpact and hit.Normal.Y > 0.7 and (not cfg.minimumFuseTime or t >= cfg.minimumFuseTime) then break end
        else
            pos, vel = nextPos, nextVel
        end

        grounded = Workspace:Raycast(pos, Vector3.new(0, -0.2, 0), params) ~= nil
        if grounded and touched and vel:Dot(vel) < Nade.StopSq
            and not cfg.fuseTime and not (cfg.minimumFuseTime and t < cfg.minimumFuseTime) then
            break
        end
        if steps % sampleEvery == 0 then table.insert(points, pos) end
    end
    table.insert(points, pos)
    return points, pos, t
end

local function ThrowStart(mode, look, camPos, charVel)
    local near = mode == "Near"
    local bias = near and 0.12 or 0.06
    local fwd = near and 1.35 * 0.55 or 1.35
    local up = near and 2.4 * 0.8 or 2.5
    local flat = Vector3.new(look.X, 0, look.Z)
    flat = flat.Magnitude < 0.01 and Vector3.new(0, 0, -1) or flat.Unit

    local origin = camPos - Vector3.new(0, R.NadeBaseDrop or 2.4, 0) + flat * fwd + Vector3.new(0, up, 0)
    local dir = (look + Vector3.new(0, bias, 0)).Unit

    local jump = charVel.Y > 5
    local speed = (near and 0.3 or 1) * 57.29166666666667 * 0.58
    local v = dir * speed
        + (jump and Vector3.new(0, 20, 0) or Vector3.new(0, charVel.Y * 2 * 0.58, 0))
        + dir * speed * 0.15 + Vector3.new(0, 6.5 * 0.58, 0)
    local cap = jump and ((dir.Y - 0.4) * 20 + 62) or 50
    if v.Magnitude > cap then v = v.Unit * cap end
    return origin, v + Vector3.new(charVel.X, 0, charVel.Z) * 1.5, jump
end

local function TrackCameraVelocity(dt)
    local pos = Camera.CFrame.Position
    if R.LastCamPos and dt and dt > 0 then
        local v = (pos - R.LastCamPos) / dt
        if v.Magnitude < 80 then R.CamVel = R.CamVel:Lerp(v, math.clamp(dt * 12, 0, 1)) end
    end
    R.LastCamPos = pos
end

local function NadeLabel(i, pos, text, color)
    local label = PoolGet(Overlay.NadeLabels, i, "Text", { Size = 13, Center = true, Outline = true, Font = 2 })
    if not label then return end
    local sp, onScreen = Camera:WorldToViewportPoint(pos + Vector3.new(0, 1.2, 0))
    label.Visible = onScreen
    if onScreen then
        label.Text, label.Color = text, color
        label.Position = Vector2.new(sp.X, sp.Y)
    end
end

local function UpdateNades()
    local labels = 0

    local weapon = EquippedName(LocalPlayer)
    local holding = weapon ~= nil and GRENADE_SHORT[weapon] ~= nil
    if holding then
        R.LastNadeHeld = os.clock()
        local lmb = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        local rmb = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2)
        R.LastNadeMode = (rmb and not lmb) and "Near" or "Far"
    end
    if S.NadePreview and HasDrawing and holding and LocalAliveNow() then
        if os.clock() - R.NadePathAt >= 0.05 or not R.NadePath or R.NadePath.Weapon ~= weapon then
            R.NadePathAt = os.clock()
            local cf = Camera.CFrame
            local origin, vel, jump = ThrowStart(R.LastNadeMode, cf.LookVector, cf.Position, R.CamVel)
            local phys = R.NadePhysics[weapon]
            local points, landing, t = SimulateNade(origin, vel, jump, NadeConfig(weapon, phys), NadeRayParams(phys and phys.CollisionGroup), 5, 6)
            R.NadePath = { Points = points, Landing = landing, Time = t, Weapon = weapon }
        end
        local path = R.NadePath
        for i = 2, #path.Points do WorldLine(path.Points[i - 1], path.Points[i], S.NadeColor, 2, 0.95) end
        WorldRing(path.Landing, Nade.Ring[path.Weapon] or 3, S.NadeColor, 20)
        labels = labels + 1
        NadeLabel(labels, path.Landing, string.format("%s  %.1fs  [%s]", GRENADE_SHORT[path.Weapon], path.Time, R.LastNadeMode:lower()), S.NadeColor)
    else
        R.NadePath = nil
    end

    local now = os.clock()
    local debris = Workspace:FindFirstChild("Debris")
    for id, p in pairs(R.NadePredictions) do
        local model = debris and debris:FindFirstChild(id)
        if now > p.EndAt + 1.5 or (not model and now - p.Born > 0.75) then
            R.NadePredictions[id] = nil
        elseif S.NadePrediction and HasDrawing then
            for i = 2, #p.Points do WorldLine(p.Points[i - 1], p.Points[i], S.GrenadeColor, 1.5, 0.55) end
            WorldRing(p.Landing, Nade.Ring[p.Weapon] or 3, S.GrenadeColor, 20)
            labels = labels + 1
            NadeLabel(labels, p.Landing, string.format("%s  %.1fs", GRENADE_SHORT[p.Weapon] or p.Weapon, math.max(0, p.EndAt - now)), S.GrenadeColor)
        end
    end

    PoolHide(Overlay.NadeLabels, labels + 1)
end

local function OnProjectileSpawn(data)
    if type(data) ~= "table" or type(data.State) ~= "table" then return end
    local weapon, state, phys = tostring(data.Weapon), data.State, data.Physics
    if type(phys) == "table" then R.NadePhysics[weapon] = phys end
    if typeof(state.Position) ~= "Vector3" or typeof(state.Velocity) ~= "Vector3" then return end

    local cam = Camera.CFrame.Position
    if os.clock() - R.LastNadeHeld < 1.5 and (state.Position - cam).Magnitude < 10 then
        local up = R.LastNadeMode == "Near" and 1.92 or 2.5
        R.NadeBaseDrop = math.clamp(cam.Y - (state.Position.Y - up), 0, 6)
    end

    local lag = tonumber(state.StartTime) and math.max(0, Workspace:GetServerTimeNow() - state.StartTime) or 0
    local id = tostring(data.Id)
    task.spawn(function()
        local points, landing, t = SimulateNade(state.Position, state.Velocity, state.IsJumpThrow == true,
            NadeConfig(weapon, phys), NadeRayParams(type(phys) == "table" and phys.CollisionGroup or nil), 10, 8)
        R.NadePredictions[id] = { Weapon = weapon, Points = points, Landing = landing, EndAt = os.clock() + t - lag, Born = os.clock() }
    end)
end

task.spawn(function()
    local remotes = GetRemotes()
    local spawnPacket = remotes and remotes.Projectile and remotes.Projectile.Spawn
    if spawnPacket and type(spawnPacket.Listen) == "function" and not R.Unloading then
        Track(spawnPacket.Listen(function(data) pcall(OnProjectileSpawn, data) end))
    end
end)

Track(Players.PlayerRemoving:Connect(function(plr) R.Loadout[plr] = nil end))

local function UpdateOverlay(dt)
    Overlay.LinesUsed = 0
    TrackCameraVelocity(dt)
    UpdateNades()
    UpdateRadar()
    UpdateArrows()
    UpdateHUD()

    if Overlay.Extra then
        local ok, err = pcall(Overlay.Extra)
        if not ok and not Overlay.ExtraWarned then
            Overlay.ExtraWarned = true
            warn("[BS] overlay extra: " .. tostring(err))
        end
    end
    PoolHide(Overlay.Lines, Overlay.LinesUsed + 1)
end

local Look = {
    Saved = setmetatable({}, { __mode = "k" }),
    Parts = setmetatable({}, { __mode = "k" }),
    Version = 0,
    Held = {},
    FX = {},
    SkyPresets = {},
    Materials = { "ForceField", "Neon", "Glass", "Foil", "SmoothPlastic", "Plastic" },
    Cross = {}, CrossOutline = {}, Hit = {},
}

function Look.Set(inst, prop, value)
    local saved = Look.Saved[inst]
    if not saved then
        saved = {}
        Look.Saved[inst] = saved
    end
    if saved[prop] == nil then saved[prop] = inst[prop] end
    if inst[prop] ~= value then inst[prop] = value end
end

function Look.Reset(inst, prop)
    local saved = Look.Saved[inst]
    if saved and saved[prop] ~= nil then
        local original = saved[prop]
        saved[prop] = nil
        pcall(function() inst[prop] = original end)
    end
end

function Look.Effect(class, on, props)
    local fx = Look.FX[class]
    if not on then
        if fx then SafeDestroy(fx) end
        Look.FX[class] = nil
        return
    end
    if not (fx and fx.Parent) then
        fx = Instance.new(class)
        fx.Name = "BS_" .. class
        fx.Parent = Lighting
        Look.FX[class] = fx
    end
    for k, v in pairs(props) do
        if fx[k] ~= v then fx[k] = v end
    end
end

function Look.ApplyLightingProps()
    local L = Lighting
    if S.Fullbright then
        Look.Set(L, "Brightness", 2)
        Look.Set(L, "ClockTime", 14)
        Look.Set(L, "GlobalShadows", false)
        Look.Set(L, "Ambient", Color3.fromRGB(180, 180, 180))
        Look.Set(L, "OutdoorAmbient", Color3.fromRGB(180, 180, 180))
    elseif S.CustomLighting then
        Look.Set(L, "Brightness", S.LightBrightness)
        Look.Set(L, "ClockTime", S.LightClock)
        Look.Set(L, "GlobalShadows", S.LightShadows)
        Look.Set(L, "Ambient", S.LightAmbient)
        Look.Set(L, "OutdoorAmbient", S.LightOutdoor)
    else
        for _, p in ipairs({ "Brightness", "ClockTime", "GlobalShadows", "Ambient", "OutdoorAmbient" }) do Look.Reset(L, p) end
    end
    if S.CustomLighting then
        Look.Set(L, "ExposureCompensation", S.LightExposure)
        Look.Set(L, "ColorShift_Top", S.LightShiftTop)
    else
        Look.Reset(L, "ExposureCompensation")
        Look.Reset(L, "ColorShift_Top")
    end

    if S.NoFog then
        Look.Set(L, "FogStart", 1e6)
        Look.Set(L, "FogEnd", 1e6)
    elseif S.CustomFog then
        Look.Set(L, "FogStart", 0)
        Look.Set(L, "FogEnd", S.FogEnd)
    else
        Look.Reset(L, "FogStart")
        Look.Reset(L, "FogEnd")
    end
    if S.CustomFog and not S.NoFog then Look.Set(L, "FogColor", S.FogColor) else Look.Reset(L, "FogColor") end

    local atmos = {}
    for _, c in ipairs(L:GetChildren()) do
        if c:IsA("Atmosphere") and c ~= Look.Atmo then table.insert(atmos, c) end
    end
    if S.CustomAtmosphere and not S.NoFog and #atmos == 0 then
        if not (Look.Atmo and Look.Atmo.Parent) then
            Look.Atmo = Instance.new("Atmosphere")
            Look.Atmo.Name = "BS_Atmosphere"
            Look.Atmo.Parent = L
        end
        table.insert(atmos, Look.Atmo)
    elseif Look.Atmo then
        SafeDestroy(Look.Atmo)
        Look.Atmo = nil
    end
    for _, a in ipairs(atmos) do
        if S.NoFog then

            Look.Set(a, "Density", 0)
            Look.Set(a, "Haze", 0)
            Look.Set(a, "Glare", 0)
            for _, p in ipairs({ "Offset", "Color", "Decay" }) do Look.Reset(a, p) end
        elseif S.CustomAtmosphere then
            Look.Set(a, "Density", S.AtmoDensity)
            Look.Set(a, "Offset", S.AtmoOffset)
            Look.Set(a, "Glare", S.AtmoGlare)
            Look.Set(a, "Haze", S.AtmoHaze)
            Look.Set(a, "Color", S.AtmoColor)
            Look.Set(a, "Decay", S.AtmoDecay)
        else
            for _, p in ipairs({ "Density", "Offset", "Glare", "Haze", "Color", "Decay" }) do Look.Reset(a, p) end
        end
    end

    for _, c in ipairs(L:GetChildren()) do
        if c:IsA("PostEffect") and c.Name:sub(1, 3) ~= "BS_" and c.Name ~= "FlashbangColorCorrection" then
            if S.NoPostFX then Look.Set(c, "Enabled", false) else Look.Reset(c, "Enabled") end
        end
    end
    Look.Effect("ColorCorrectionEffect", S.CCEnabled, {
        TintColor = S.CCTint, Saturation = S.CCSaturation, Contrast = S.CCContrast, Brightness = S.CCBrightness,
    })
    Look.Effect("BloomEffect", S.BloomEnabled, { Intensity = S.BloomIntensity, Size = S.BloomSize, Threshold = S.BloomThreshold })
    Look.Effect("SunRaysEffect", S.SunRaysEnabled, { Intensity = S.SunRaysIntensity, Spread = S.SunRaysSpread })
end

function Look.CollectSkies()
    table.clear(Look.SkyPresets)
    local names, seen = {}, {}
    local assets = ReplicatedStorage:FindFirstChild("Assets")
    local sets = assets and assets:FindFirstChild("Lighting")
    for _, sky in ipairs(sets and sets:GetDescendants() or {}) do
        if sky:IsA("Sky") and not seen[sky.SkyboxBk] then
            seen[sky.SkyboxBk] = true
            local label = sky.Name
            if label == "Sky" or Look.SkyPresets[label] then label = sky.Parent.Name .. " " .. sky.Name end
            Look.SkyPresets[label] = sky
            table.insert(names, label)
        end
    end
    table.sort(names)
    table.insert(names, 1, "Game Default")
    table.insert(names, "Custom Asset ID")
    return names
end

function Look.WantedSky()
    if S.SkyPreset == "Custom Asset ID" then
        local id = tostring(S.SkyCustomId or ""):match("%d+")
        return id and ("id:" .. id) or nil
    end
    return Look.SkyPresets[S.SkyPreset] and S.SkyPreset or nil
end

function Look.ApplySky()
    local want = Look.WantedSky()
    if want then
        if Look.SkyKey ~= want or not (Look.Sky and Look.Sky.Parent) then
            SafeDestroy(Look.Sky)
            local sky
            if want:sub(1, 3) == "id:" then
                sky = Instance.new("Sky")
                local url = "rbxassetid://" .. want:sub(4)
                for _, face in ipairs({ "Bk", "Dn", "Ft", "Lf", "Rt", "Up" }) do sky["Skybox" .. face] = url end
            else
                sky = Look.SkyPresets[want]:Clone()
            end
            sky.Name = "BS_Sky"
            sky.Parent = Lighting
            Look.Sky, Look.SkyKey = sky, want
        end

        for _, c in ipairs(Lighting:GetChildren()) do
            if c:IsA("Sky") and c ~= Look.Sky then
                table.insert(Look.Held, c)
                c.Parent = nil
            end
        end
    elseif Look.Sky or #Look.Held > 0 then
        SafeDestroy(Look.Sky)
        Look.Sky, Look.SkyKey = nil, nil

        local last = Look.Held[#Look.Held]
        table.clear(Look.Held)
        if last and not Lighting:FindFirstChildOfClass("Sky") then
            pcall(function() last.Parent = Lighting end)
        end
    end

    local active = Look.Sky or Lighting:FindFirstChildOfClass("Sky")
    if active then
        if S.SkyTweaks then
            Look.Set(active, "CelestialBodiesShown", S.SkyCelestial)
            Look.Set(active, "StarCount", S.SkyStars)
        else
            Look.Reset(active, "CelestialBodiesShown")
            Look.Reset(active, "StarCount")
        end
    end
end

Look.MapParts = setmetatable({}, { __mode = "k" })
Look.MapVersion = 0
Look.MapMaterials = {
    "Off", "Clean", "SmoothPlastic", "Plastic", "ForceField", "Neon", "Glass", "Foil",
    "Ice", "Marble", "Granite", "Slate", "Concrete", "Brick", "Wood", "Metal", "DiamondPlate", "Sand",
}
Look.Variants = {}

function Look.MapWanted()
    return S.MapMaterial ~= "Off" or S.MapRecolor or S.MapNoTextures
end

function Look.CleanVariant(material)
    local v = Look.Variants[material]
    if v and v.Parent then return v.Name end
    local ok = pcall(function()
        v = Instance.new("MaterialVariant")
        v.Name = "BS_Clean_" .. material.Name
        v.BaseMaterial = material
        v.Parent = game:GetService("MaterialService")
    end)
    if not ok then return nil end
    Look.Variants[material] = v
    return v.Name
end

function Look.MapPart(part, want)
    local saved = Look.MapParts[part]
    if want then
        if not saved then
            if part.Transparency >= 0.95 then return end
            saved = { Material = part.Material, Color = part.Color, Variant = part.MaterialVariant, Hidden = {} }
            if part:IsA("MeshPart") then saved.TextureID = part.TextureID end
            Look.MapParts[part] = saved
        end
        if saved.Version == Look.MapVersion then return end
        saved.Version = Look.MapVersion

        local mode = S.MapMaterial
        if mode == "Clean" then
            part.Material = saved.Material
            part.MaterialVariant = Look.CleanVariant(saved.Material) or saved.Variant
        elseif mode ~= "Off" and Enum.Material[mode] then
            part.MaterialVariant = ""
            part.Material = Enum.Material[mode]
        else
            part.Material = saved.Material
            part.MaterialVariant = saved.Variant
        end
        part.Color = S.MapRecolor and S.MapColor or saved.Color

        if S.MapNoTextures then
            if saved.TextureID ~= nil then part.TextureID = "" end
            for _, c in ipairs(part:GetChildren()) do
                if c:IsA("SurfaceAppearance") or c:IsA("Decal") or c:IsA("Texture") then
                    table.insert(saved.Hidden, c)
                    c.Parent = nil
                end
            end
        else
            if saved.TextureID ~= nil then part.TextureID = saved.TextureID end
            for _, c in ipairs(saved.Hidden) do pcall(function() c.Parent = part end) end
            table.clear(saved.Hidden)
        end
    elseif saved then
        Look.MapParts[part] = nil
        pcall(function()
            part.Material, part.Color, part.MaterialVariant = saved.Material, saved.Color, saved.Variant
            if saved.TextureID ~= nil then part.TextureID = saved.TextureID end
        end)
        for _, c in ipairs(saved.Hidden) do pcall(function() c.Parent = part end) end
    end
end

function Look.MapSkip(part, map)

    for _, name in ipairs({ "Characters", "Players" }) do
        local f = map:FindFirstChild(name)
        if f and part:IsDescendantOf(f) then return true end
    end
    return false
end

function Look.RefreshMap()
    Look.MapVersion = Look.MapVersion + 1
    local version = Look.MapVersion

    task.delay(0.15, function()
        if Look.MapVersion ~= version then return end
        local want = Look.MapWanted()
        local list = {}
        if want then
            local map = Workspace:FindFirstChild("Map")
            if map then
                for _, d in ipairs(map:GetDescendants()) do
                    if d:IsA("BasePart") and not Look.MapSkip(d, map) then table.insert(list, d) end
                end
            end
        else
            for part in pairs(Look.MapParts) do table.insert(list, part) end
        end
        for i, part in ipairs(list) do

            if Look.MapVersion ~= version or (R.Unloading and want) then return end
            pcall(Look.MapPart, part, want)
            if i % 400 == 0 then task.wait() end
        end
    end)
end

function Look.WatchMap()
    local map = Workspace:FindFirstChild("Map")
    if map == Look.MapRoot then return end
    Look.MapRoot = map
    if Look.MapConn then pcall(function() Look.MapConn:Disconnect() end) end
    Look.MapConn = nil
    if map then
        Look.MapConn = map.DescendantAdded:Connect(function(d)
            if Look.MapWanted() and d:IsA("BasePart") and not Look.MapSkip(d, map) then
                task.defer(function() pcall(Look.MapPart, d, true) end)
            end
        end)
        Track(Look.MapConn)
        if Look.MapWanted() then Look.RefreshMap() end
    end
end

function Look.ApplyWorld()
    Look.ApplyLightingProps()
    Look.ApplySky()
    Look.WatchMap()
end

local function ApplyLighting()
    local ok, err = pcall(Look.ApplyWorld)
    if not ok then warn("[BS] look: " .. tostring(err)) end
end

Loop(0.25, function() return true end, Look.ApplyWorld)

function Look.Camera()

    if S.CustomFOVEnabled then
        local consts = GetModule("Constants", { "Database", "Custom", "Constants" })
        local base = (type(consts) == "table" and tonumber(consts.DEFAULT_CAMERA_FOV)) or 70
        local cam = GetCameraController()
        local locked = false
        if cam and type(cam.isFOVLocked) == "function" then
            local ok, v = pcall(cam.isFOVLocked)
            locked = ok and v == true
        end
        if not locked and Camera.FieldOfView >= base - 3 then
            Camera.FieldOfView = math.clamp(S.CustomFOV, 1, 120)
        end
    end

    if S.Stretch < 0.999 then
        Camera.CFrame = Camera.CFrame * CFrame.new(0, 0, 0, 1, 0, 0, 0, S.Stretch, 0, 0, 0, 1)
    end
end

function Look.IsArm(part)
    local node = part
    while node and node ~= Camera do
        local n = node.Name:lower()
        if n:find("arm") or n:find("hand") or n:find("glove") or n:find("sleeve") then return true end
        node = node.Parent
    end
    return false
end

function Look.ChamPart(part, on, material, color, transparency)
    local saved = Look.Parts[part]
    if on then
        if not saved then
            saved = { Material = part.Material, Color = part.Color, Transparency = part.Transparency, Hidden = {} }
            if part:IsA("MeshPart") then saved.TextureID = part.TextureID end
            Look.Parts[part] = saved
        end

        if saved.Transparency >= 0.95 or saved.Version == Look.Version then return saved end
        saved.Version = Look.Version
        part.Material = material
        part.Color = color
        part.Transparency = math.max(transparency, saved.Transparency)
        local hide = S.ChamsHideTextures
        if saved.TextureID ~= nil then part.TextureID = hide and "" or saved.TextureID end
        if hide then

            for _, c in ipairs(part:GetChildren()) do
                if c:IsA("SurfaceAppearance") or c:IsA("Decal") or c:IsA("Texture") then
                    table.insert(saved.Hidden, c)
                    c.Parent = nil
                end
            end
        else
            for _, c in ipairs(saved.Hidden) do pcall(function() c.Parent = part end) end
            table.clear(saved.Hidden)
        end
        return saved
    elseif saved then
        Look.Parts[part] = nil
        pcall(function()
            part.Material, part.Color, part.Transparency = saved.Material, saved.Color, saved.Transparency
            if saved.TextureID ~= nil then part.TextureID = saved.TextureID end
        end)
        for _, c in ipairs(saved.Hidden) do pcall(function() c.Parent = part end) end
    end
end

function Look.ViewmodelModel()
    local best, bestCount = nil, 0
    for _, m in ipairs(Camera:GetChildren()) do
        if m:IsA("Model") then
            local n = #m:GetDescendants()
            if n > bestCount then best, bestCount = m, n end
        end
    end
    return best
end

function Look.Highlight(key, adornee, fill, outline, fillT, outlineT)
    local hl = Look[key]
    if not adornee then
        if hl then hl.Enabled = false end
        return
    end
    if not (hl and hl.Parent) then
        hl = Instance.new("Highlight")
        hl.Name = "BS_" .. key
        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        hl.Parent = ESPFolder
        Look[key] = hl
    end
    hl.Adornee = adornee
    hl.FillColor, hl.OutlineColor = fill, outline
    hl.FillTransparency, hl.OutlineTransparency = fillT, outlineT
    hl.Enabled = true
end

function Look.Chams()
    if S.ArmChams or S.WeaponChams or next(Look.Parts) then
        local armMat = Enum.Material[S.ArmChamsMaterial] or Enum.Material.ForceField
        local wepMat = Enum.Material[S.WeaponChamsMaterial] or Enum.Material.ForceField
        for _, d in ipairs(Camera:GetDescendants()) do
            if d:IsA("BasePart") then
                local saved = Look.Parts[d]
                local arm = saved and saved.Arm
                if arm == nil then arm = Look.IsArm(d) end
                local on = (arm and S.ArmChams) or (not arm and S.WeaponChams)
                if on or saved then
                    local rec
                    if arm then
                        rec = Look.ChamPart(d, on, armMat, S.ArmChamsColor, S.ArmChamsTransparency)
                    else
                        rec = Look.ChamPart(d, on, wepMat, S.WeaponChamsColor, S.WeaponChamsTransparency)
                    end
                    if rec then rec.Arm = arm end
                end
            end
        end
    end

    Look.Highlight("ViewmodelGlow", S.ViewmodelGlow and Look.ViewmodelModel() or nil,
        S.ViewmodelGlowFill, S.ViewmodelGlowOutline, S.ViewmodelGlowFillT, S.ViewmodelGlowOutlineT)
    Look.Highlight("SelfBody", S.SelfBodyChams and LocalAliveNow() and LocalCharacter() or nil,
        S.SelfBodyFill, S.SelfBodyOutline, S.SelfBodyFillT, 0)
end

function Look.RestoreChams()
    for part in pairs(Look.Parts) do Look.ChamPart(part, false) end
end

function Look.GameCrosshair()
    local cached = Look.GameCrosshairFrame
    if cached and cached.Parent then return cached end

    if os.clock() - (Look.CrosshairScanAt or -10) < 2 then return nil end
    Look.CrosshairScanAt = os.clock()
    local main = PlayerGui:FindFirstChild("MainGui")
    if not main then return nil end
    for _, d in ipairs(main:GetDescendants()) do
        if d.Name == "Crosshair" and d:IsA("GuiObject") and (d:FindFirstChild("Dot") or d:FindFirstChild("Ticks")) then
            Look.GameCrosshairFrame = d
            return d
        end
    end
    return nil
end

function Look.Crosshair()
    local on = S.Crosshair and HasDrawing and LocalAliveNow()
    local native = Look.GameCrosshair()
    if native then
        if on and S.HideGameCrosshair then Look.Set(native, "Visible", false) else Look.Reset(native, "Visible") end
    end

    local now = os.clock()
    local dt = math.clamp(now - (Look.CrossClock or now), 0, 0.1)
    Look.CrossClock = now

    local style = S.CrosshairStyle
    local spinDir = S.CrosshairSpinDirection == "Counter-Clockwise" and -1 or 1
    Look.CrossSpin = (Look.CrossSpin or 0)
    if S.CrosshairSpin and S.CrosshairSpinMode == "Constant" then
        Look.CrossSpin = (Look.CrossSpin + dt * S.CrosshairSpinSpeed * spinDir) % (math.pi * 2)
    end
    local spin = 0
    if S.CrosshairSpin then
        spin = S.CrosshairSpinMode == "Swing"
            and math.sin(now * S.CrosshairSpinSpeed) * math.rad(S.CrosshairSwingAngle) * spinDir
            or Look.CrossSpin
    end
    local angle = math.rad(S.CrosshairRotation) + (style == "X" and math.rad(45) or 0) + spin

    local gap = S.CrosshairGap
    if S.CrosshairPulse then
        gap = gap + (math.sin(now * S.CrosshairPulseSpeed) + 1) / 2 * S.CrosshairPulseAmount
    end
    local target = 0
    if S.CrosshairDynamic then
        local flat = Vector3.new(R.CamVel.X, 0, R.CamVel.Z).Magnitude
        local moving = math.clamp(flat / 16, 0, 1)
        local firing = UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1) and 1 or 0
        target = math.max(moving, firing) * S.CrosshairDynamicAmount
    end
    Look.CrossDyn = (Look.CrossDyn or 0) + (target - (Look.CrossDyn or 0)) * math.clamp(dt * 12, 0, 1)
    gap = gap + Look.CrossDyn

    local color = S.CrosshairRainbow and Color3.fromHSV((now * S.CrosshairRainbowSpeed) % 1, 1, 1) or S.CrosshairColor
    local alpha = S.CrosshairOpacity
    local size, thick = S.CrosshairSize, S.CrosshairThickness
    local stroke = S.CrosshairOutline and S.CrosshairOutlineThickness or 0
    local strokeColor = S.CrosshairOutlineColor
    local center = Camera.ViewportSize / 2
    local lines = on and (style == "Cross" or style == "T" or style == "X" or style == "Cross + Circle")

    for i = 1, 4 do

        local a = angle + (i - 1) * math.pi / 2
        local dir = Vector2.new(math.cos(a), math.sin(a))
        local show = lines and not (style == "T" and i == 4)
        local from, to = center + dir * gap, center + dir * (gap + size)
        local outline = PoolGet(Look.CrossOutline, i, "Line", { Transparency = 1, ZIndex = 5 })
        if outline then
            outline.Visible = show and stroke > 0
            if outline.Visible then
                outline.From, outline.To = from - dir * stroke, to + dir * stroke
                outline.Thickness = thick + stroke * 2
                outline.Color, outline.Transparency = strokeColor, alpha
            end
        end
        local line = PoolGet(Look.Cross, i, "Line", { Transparency = 1, ZIndex = 6 })
        if line then
            line.Visible = show and true or false
            if show then
                line.From, line.To = from, to
                line.Color, line.Thickness, line.Transparency = color, thick, alpha
            end
        end
    end

    local dotSize = S.CrosshairDotSize
    local showDot = on and (style == "Dot" or S.CrosshairDot)
    local dotOutline = OverlayDraw("CrossDotOutline", "Square", { Filled = true, Transparency = 1, ZIndex = 5 })
    local dot = OverlayDraw("CrossDot", "Square", { Filled = true, Transparency = 1, ZIndex = 6 })
    if dotOutline then
        dotOutline.Visible = showDot and stroke > 0
        dotOutline.Size = Vector2.new(dotSize + stroke * 2, dotSize + stroke * 2)
        dotOutline.Position = center - dotOutline.Size / 2
        dotOutline.Color, dotOutline.Transparency = strokeColor, alpha
    end
    if dot then
        dot.Visible = showDot and true or false
        dot.Size = Vector2.new(dotSize, dotSize)
        dot.Position = center - dot.Size / 2
        dot.Color, dot.Transparency = color, alpha
    end

    local showRing = on and (style == "Circle" or style == "Cross + Circle")
    local radius = style == "Circle" and (gap + size) or (gap + size + 3)
    local ringOutline = OverlayDraw("CrossRingOutline", "Circle", { Filled = false, NumSides = 48, Transparency = 1, ZIndex = 5 })
    local ring = OverlayDraw("CrossRing", "Circle", { Filled = false, NumSides = 48, Transparency = 1, ZIndex = 6 })
    if ringOutline then
        ringOutline.Visible = showRing and stroke > 0
        if ringOutline.Visible then
            ringOutline.Position, ringOutline.Radius = center, radius
            ringOutline.Thickness = thick + stroke * 2
            ringOutline.Color, ringOutline.Transparency = strokeColor, alpha
        end
    end
    if ring then
        ring.Visible = showRing and true or false
        if showRing then
            ring.Position, ring.Radius = center, radius
            ring.Color, ring.Thickness, ring.Transparency = color, thick, alpha
        end
    end
end

function Look.Hitmarker()
    local age = os.clock() - R.LastHitAt
    local show = S.Hitmarker and HasDrawing and age < 0.35
    local center = Camera.ViewportSize / 2
    for i = 1, 4 do
        local line = PoolGet(Look.Hit, i, "Line", { Thickness = 2, Transparency = 1, ZIndex = 7 })
        if line then
            line.Visible = show
            if show then
                local a = math.rad(45 + 90 * (i - 1))
                local dir = Vector2.new(math.cos(a), math.sin(a))
                line.From, line.To = center + dir * 6, center + dir * 13
                line.Color = R.LastHitHead and S.HitmarkerHeadColor or S.HitmarkerColor
                line.Transparency = math.clamp(1 - age / 0.35, 0, 1)
            end
        end
    end
end

Look.Shots = {}
Look.ImpactDraws = {}
Look.TracerSeenAt = -10

function Look.MuzzlePosition()
    local vm = Look.ViewmodelModel()
    local inter = vm and vm:FindFirstChild("Interactables")
    local muzzle = inter and (inter:FindFirstChild("MuzzlePart", true) or inter:FindFirstChild("MuzzlePartR", true))
    if muzzle and muzzle:IsA("BasePart") then return muzzle.Position end
    return nil
end

function Look.AddShot(dir, from)
    if not S.BulletTracers then return end
    local cam = Camera.CFrame.Position
    dir = dir.Magnitude > 1e-3 and dir.Unit or Camera.CFrame.LookVector

    local hit = Workspace:Raycast(cam, dir * 1000, BuildRayParams(true))
    local to = hit and hit.Position or (cam + dir * 1000)
    local enemy = false
    if hit then
        for _, t in ipairs(EnemyTargets(true)) do
            if hit.Instance:IsDescendantOf(t.Char) then enemy = true break end
        end
    end
    table.insert(Look.Shots, { From = from or (cam + dir * 1.5), To = to, Hit = enemy, Impact = hit ~= nil, Born = os.clock() })
    while #Look.Shots > 48 do table.remove(Look.Shots, 1) end
end

function Look.OnDebrisChild(child)
    if not S.BulletTracers or child.Name ~= "Default" or not child:IsA("BasePart")
        or not child:FindFirstChild("TopAttachment") then
        return
    end
    local muzzle = Look.MuzzlePosition()

    if not muzzle or (child.Position - muzzle).Magnitude > 7 then return end
    Look.TracerSeenAt = os.clock()
    Look.AddShot(child.Position - muzzle, muzzle)
end

task.spawn(function()
    local debris = Workspace:WaitForChild("Debris", 30)
    if debris and not R.Unloading then
        Track(debris.ChildAdded:Connect(function(c) pcall(Look.OnDebrisChild, c) end))
    end
end)

function Look.CheckRounds()
    if not S.BulletTracers then return end
    local w = GetEquippedWeapon()
    local rounds = w and tonumber(w.Rounds)
    if not rounds then Look.LastWeapon = nil return end
    if Look.LastWeapon == w.Identifier and Look.LastRounds and rounds < Look.LastRounds
        and os.clock() - Look.TracerSeenAt > 0.1 then
        for _ = 1, math.min(Look.LastRounds - rounds, 3) do
            Look.AddShot(Camera.CFrame.LookVector, Look.MuzzlePosition())
        end
    end
    Look.LastWeapon, Look.LastRounds = w.Identifier, rounds
end

function Look.DrawTracers()
    local now, used = os.clock(), 0
    for i = #Look.Shots, 1, -1 do
        local shot = Look.Shots[i]
        local age = now - shot.Born
        if age > S.TracerTime then
            table.remove(Look.Shots, i)
        elseif S.BulletTracers and HasDrawing then
            local alpha = math.clamp(1 - age / S.TracerTime, 0, 1)
            local color = shot.Hit and S.TracerHitColor or S.TracerColor
            WorldLine(shot.From, shot.To, color, S.TracerThickness, alpha)
            if S.TracerImpacts and shot.Impact then
                local sp, onScreen = Camera:WorldToViewportPoint(shot.To)
                if onScreen then
                    used = used + 1
                    local box = PoolGet(Look.ImpactDraws, used, "Square", { Filled = false, Thickness = 1.5, ZIndex = 3 })
                    if box then
                        local size = S.ImpactSize
                        box.Size = Vector2.new(size * 2, size * 2)
                        box.Position = Vector2.new(sp.X - size, sp.Y - size)
                        box.Color, box.Transparency = color, alpha
                        box.Visible = true
                    end
                end
            end
        end
    end
    PoolHide(Look.ImpactDraws, used + 1)
end

Overlay.Extra = Look.DrawTracers

function Look.Frame()
    pcall(Look.CheckRounds)
    if UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        or UserInputService:IsMouseButtonPressed(Enum.UserInputType.MouseButton2) then
        R.LastAttackInput = os.clock()
    end
    for _, step in ipairs({ Look.Camera, Look.Chams, Look.Crosshair, Look.Hitmarker }) do
        local ok, err = pcall(step)
        if not ok and not Look.Warned then
            Look.Warned = true
            warn("[BS] look frame: " .. tostring(err))
        end
    end
end

function Look.Shutdown()
    S.Fullbright, S.NoFog, S.CustomLighting, S.CustomFog, S.CustomAtmosphere = false, false, false, false, false
    S.NoPostFX, S.CCEnabled, S.BloomEnabled, S.SunRaysEnabled, S.SkyTweaks = false, false, false, false, false
    S.SkyPreset, S.CustomFOVEnabled, S.Stretch, S.Crosshair = "Game Default", false, 1, false
    S.MapMaterial, S.MapRecolor, S.MapNoTextures = "Off", false, false
    pcall(Look.ApplyWorld)
    pcall(Look.RestoreChams)
    pcall(Look.RefreshMap)
    SafeDestroy(Look.ViewmodelGlow)
    SafeDestroy(Look.SelfBody)
    if Look.GameCrosshairFrame then Look.Reset(Look.GameCrosshairFrame, "Visible") end

    task.delay(5, function()
        for _, v in pairs(Look.Variants) do SafeDestroy(v) end
    end)
end

RunService:BindToRenderStep("BS_Frame", Enum.RenderPriority.Last.Value, function(dt)
    if R.Unloading then return end
    R.FrameCount = (R.FrameCount or 0) + 1

    local ok, err = pcall(function()

        Look.Frame()
        UpdateESP()
        UpdateSoundESP()
        UpdateWorldESP()
        UpdateOverlay(dt)

        local alive = LocalAliveNow()

        if AimFOVCircle then
            AimFOVCircle.Visible = alive and S.Aimbot and S.ShowAimFOV
            if AimFOVCircle.Visible then
                AimFOVCircle.Position = Camera.ViewportSize / 2
                AimFOVCircle.Radius = S.AimFOV
                AimFOVCircle.Color = S.FOVColor
            end
        end

        if SilentFOVCircle then
            SilentFOVCircle.Visible = alive and S.SilentAim and S.SilentAimShowFOV
            if SilentFOVCircle.Visible then
                SilentFOVCircle.Position = Camera.ViewportSize / 2
                SilentFOVCircle.Radius = S.SilentAimFOV
                SilentFOVCircle.Color = S.EnemyColor
            end
        end

        local needsRay = alive and ((S.Aimbot and (S.AimAlways or KeyHeld(S.AimKey)))
            or (S.Triggerbot and (S.TriggerAlways or KeyHeld(S.TriggerKey))))
        local params = needsRay and BuildRayParams(true) or nil

        if params and S.Aimbot and (S.AimAlways or KeyHeld(S.AimKey)) then
            local part = ResolveAimTarget(params, S.AimPart, S.AimFOV, S.AimVisibleOnly, S.AimPriority, true, S.AimAutowall)
            if part then AimAt(part.Position, S.Smoothness) end
        end

        if params and S.Triggerbot and (S.TriggerAlways or KeyHeld(S.TriggerKey))
            and os.clock() - R.LastTrigger >= S.TriggerDelay then
            local c = Camera.ViewportSize / 2
            local ray = Camera:ViewportPointToRay(c.X, c.Y)
            local hit = Workspace:Raycast(ray.Origin, ray.Direction * 2500, params)
            if hit then

                local targets = EnemyTargets(true)
                local shoot = false
                for _, t in ipairs(targets) do
                    if hit.Instance:IsDescendantOf(t.Char) then shoot = true break end
                end

                if not shoot and S.TriggerAutowall and #targets > 0 then
                    local pen = WeaponPenetration()
                    if pen > 0 then
                        local only = {}
                        for _, t in ipairs(targets) do table.insert(only, t.Char) end
                        local inc = RaycastParams.new()
                        inc.FilterType = Enum.RaycastFilterType.Include
                        inc.FilterDescendantsInstances = only
                        shoot = Workspace:Raycast(hit.Position + ray.Direction * 0.01, ray.Direction * pen, inc) ~= nil
                    end
                end
                if shoot then
                    R.LastTrigger = os.clock()
                    task.spawn(FireTap)
                end
            end
        end

        if S.MagicBullet and KeyHeld(S.MagicBulletKey) and (os.clock() - (R.LastMagicBullet or 0) >= 0.1) then
            R.LastMagicBullet = os.clock()
            FireMagicBulletNearest()
        end

        AutoFireStep()

        ObjectiveStep()
    end)
    if not ok and not R.Unloading then
        warn("[BS] render error: " .. tostring(err))
    end
end)
Track({ Disconnect = function() RunService:UnbindFromRenderStep("BS_Frame") end })

local Obelus = {}
do
    local ACCENT      = Color3.fromRGB(170, 85, 235)
    local ACCENT_DARK = Color3.fromRGB(101, 51, 141)
    local TEXT        = Color3.fromRGB(180, 180, 180)
    local TEXT_DIM    = Color3.fromRGB(142, 142, 142)
    local OFF         = Color3.fromRGB(63, 63, 63)
    local FONT        = Enum.Font.Code
    local uis         = UserInputService

    local function Create(class, props)
        local inst = Instance.new(class)
        for k, v in pairs(props or {}) do inst[k] = v end
        return inst
    end

    local AccentReg, Repaints = {}, {}
    local function Accent(inst, prop, dark)
        inst[prop] = dark and ACCENT_DARK or ACCENT
        table.insert(AccentReg, { inst, prop, dark })
        return inst
    end

    function Obelus:SetAccent(color)
        ACCENT = color
        ACCENT_DARK = color:Lerp(Color3.new(0, 0, 0), 0.4)
        local keep = {}
        for _, r in ipairs(AccentReg) do
            if r[1].Parent then
                r[1][r[2]] = r[3] and ACCENT_DARK or ACCENT
                table.insert(keep, r)
            end
        end
        AccentReg = keep
        for _, fn in ipairs(Repaints) do pcall(fn) end
    end

    function Obelus:AccentHex() return ACCENT:ToHex() end

    local function Sheen(parent, dark)
        return Create("UIGradient", {
            Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), Color3.fromRGB(dark or 125, dark or 125, dark or 125)),
            Rotation = 90,
            Parent = parent,
        })
    end

    local function Text(props)
        local base = {
            BackgroundTransparency = 1, BorderSizePixel = 0, Font = FONT, RichText = true,
            TextColor3 = TEXT, TextStrokeTransparency = 0.5, TextSize = 13,
            TextXAlignment = Enum.TextXAlignment.Left,
        }
        for k, v in pairs(props) do base[k] = v end
        return Create("TextLabel", base)
    end

    local function StepDecimals(step)
        if not step or step >= 1 then return 0 end
        local str = string.format("%.6f", step):gsub("0+$", "")
        local dot = str:find("%.", 1)
        return dot and math.clamp(#str - dot, 0, 4) or 0
    end

    local function Writable(parent)
        return parent ~= nil and pcall(function() local f = Instance.new("Folder"); f.Parent = parent; f:Destroy() end)
    end

    local function GuiParent()
        local ok, hui = pcall(function() return gethui and gethui() end)
        if ok and Writable(hui) then return hui end
        local core = game:GetService("CoreGui")
        if Writable(core) then return core end
        return LocalPlayer:FindFirstChildOfClass("PlayerGui") or LocalPlayer:WaitForChild("PlayerGui")
    end

    local function IsClick(input)
        return input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch
    end

    function Obelus:Window(cfg)
        cfg = cfg or {}
        local window = { Pages = {}, Connections = {}, ToggleKey = cfg.ToggleKey or Enum.KeyCode.RightShift }

        local function conn(signal, fn)
            local c = signal:Connect(fn)
            table.insert(window.Connections, c)
            return c
        end

        local screen = Create("ScreenGui", {
            Name = "obelus", DisplayOrder = 8888, IgnoreGuiInset = true,
            ZIndexBehavior = Enum.ZIndexBehavior.Global, ResetOnSpawn = false,
        })
        screen.Parent = GuiParent()
        window.Screen = screen

        local main = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(51, 51, 51),
            BorderColor3 = Color3.new(0, 0, 0), BorderMode = Enum.BorderMode.Inset, BorderSizePixel = 1,
            Position = UDim2.fromScale(0.5, 0.5), Size = cfg.Size or UDim2.fromOffset(516, 563), Parent = screen,
        })
        local frame = Create("Frame", {
            AnchorPoint = Vector2.new(0.5, 0.5), BackgroundColor3 = Color3.fromRGB(12, 12, 12), BorderSizePixel = 0,
            Position = UDim2.fromScale(0.5, 0.5), Size = UDim2.new(1, -2, 1, -2), Parent = main,
        })
        local dragBar = Create("TextButton", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 24), Text = "", Parent = frame })
        Text({ Position = UDim2.fromOffset(9, 6), Size = UDim2.new(1, -16, 0, 15), Text = cfg.Name or "obelus", TextColor3 = TEXT_DIM, Parent = frame })

        local accent = Create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(8, 22), Size = UDim2.new(1, -16, 0, 2), Parent = frame })
        Accent(Create("Frame", { BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1), Parent = accent }), "BackgroundColor3")
        Accent(Create("Frame", { BorderSizePixel = 0, Position = UDim2.fromOffset(0, 1), Size = UDim2.new(1, 0, 0, 1), Parent = accent }), "BackgroundColor3", true)

        local tabs = Create("Frame", { BackgroundColor3 = Color3.fromRGB(1, 1, 1), BorderSizePixel = 0, Position = UDim2.fromOffset(8, 29), Size = UDim2.new(1, -16, 0, 30), Parent = frame })
        local tabsInline = Create("Frame", { BackgroundColor3 = Color3.fromRGB(1, 1, 1), BorderSizePixel = 0, Size = UDim2.new(1, -1, 1, 0), Parent = tabs })
        Create("UIListLayout", { FillDirection = Enum.FillDirection.Horizontal, SortOrder = Enum.SortOrder.LayoutOrder, Parent = tabsInline })

        local pagesHolder = Create("Frame", {
            BackgroundColor3 = Color3.fromRGB(51, 51, 51), BorderColor3 = Color3.new(0, 0, 0), BorderMode = Enum.BorderMode.Inset,
            BorderSizePixel = 1, Position = UDim2.fromOffset(8, 65), Size = UDim2.new(1, -16, 1, -76), Parent = frame,
        })
        local pagesFrame = Create("Frame", {
            BackgroundColor3 = Color3.fromRGB(13, 13, 13), BorderSizePixel = 0, ClipsDescendants = true,
            Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = pagesHolder,
        })

        local dragging, dragStart, startPos = false, nil, nil
        conn(dragBar.InputBegan, function(input)
            if IsClick(input) then dragging, dragStart, startPos = true, input.Position, main.Position end
        end)
        conn(uis.InputEnded, function(input) if IsClick(input) then dragging = false end end)
        conn(uis.InputChanged, function(input)
            if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
                local d = input.Position - dragStart
                main.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
            end
        end)

        window.Main = main

        conn(uis.InputBegan, function(input, processed)
            if processed then return end
            if input.KeyCode == window.ToggleKey then main.Visible = not main.Visible end
        end)

        local tip = Text({
            BackgroundTransparency = 0, BackgroundColor3 = Color3.fromRGB(19, 19, 19), BorderColor3 = ACCENT_DARK,
            BorderSizePixel = 1, TextSize = 12, TextWrapped = true, Visible = false, ZIndex = 60,
            AutomaticSize = Enum.AutomaticSize.Y, Size = UDim2.fromOffset(240, 0), Parent = screen,
        })
        Create("UIPadding", { PaddingLeft = UDim.new(0, 5), PaddingRight = UDim.new(0, 5), PaddingTop = UDim.new(0, 3), PaddingBottom = UDim.new(0, 3), Parent = tip })
        local function placeTip()
            local m = uis:GetMouseLocation()
            tip.Position = UDim2.fromOffset(m.X + 14, m.Y + 4)
        end
        conn(uis.InputChanged, function(input)
            if tip.Visible and input.UserInputType == Enum.UserInputType.MouseMovement then placeTip() end
        end)
        function window:BindTip(obj, text)
            if not text or text == "" then return end
            conn(obj.MouseEnter, function() tip.Text = text; placeTip(); tip.Visible = true end)
            conn(obj.MouseLeave, function() tip.Visible = false end)
        end

        local notifHolder = Create("Frame", {
            AnchorPoint = Vector2.new(1, 1), BackgroundTransparency = 1, Position = UDim2.new(1, -12, 1, -12),
            Size = UDim2.fromOffset(280, 500), Parent = screen,
        })
        Create("UIListLayout", { VerticalAlignment = Enum.VerticalAlignment.Bottom, Padding = UDim.new(0, 6), SortOrder = Enum.SortOrder.LayoutOrder, Parent = notifHolder })
        local notifCount = 0
        function window:Notify(title, body, duration)
            notifCount = notifCount + 1
            local box = Create("Frame", {
                BackgroundColor3 = Color3.fromRGB(19, 19, 19), BorderColor3 = ACCENT_DARK, BorderSizePixel = 1,
                Size = UDim2.fromOffset(280, 0), AutomaticSize = Enum.AutomaticSize.Y, LayoutOrder = notifCount, Parent = notifHolder,
            })
            Create("UIPadding", { PaddingLeft = UDim.new(0, 8), PaddingRight = UDim.new(0, 8), PaddingTop = UDim.new(0, 5), PaddingBottom = UDim.new(0, 6), Parent = box })
            Create("UIListLayout", { Padding = UDim.new(0, 2), SortOrder = Enum.SortOrder.LayoutOrder, Parent = box })
            Text({ Size = UDim2.new(1, 0, 0, 14), Text = tostring(title or ""), TextColor3 = ACCENT, LayoutOrder = 1, Parent = box })
            Text({ Size = UDim2.new(1, 0, 0, 0), AutomaticSize = Enum.AutomaticSize.Y, TextWrapped = true, TextSize = 12, Text = tostring(body or ""), LayoutOrder = 2, Parent = box })
            task.delay(duration or 3, function() pcall(function() box:Destroy() end) end)
        end

        function window:Watermark()
            local wm = {}
            local outer = Create("Frame", {
                BackgroundColor3 = Color3.fromRGB(51, 51, 51), BorderColor3 = Color3.new(0, 0, 0), BorderMode = Enum.BorderMode.Inset,
                BorderSizePixel = 1, Position = UDim2.fromOffset(12, 12), Size = UDim2.fromOffset(120, 24), Parent = screen,
            })
            local inner = Create("Frame", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = outer })
            Accent(Create("Frame", { BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, 1), Parent = inner }), "BackgroundColor3")
            Accent(Create("Frame", { BorderSizePixel = 0, Position = UDim2.fromOffset(0, 1), Size = UDim2.new(1, 0, 0, 1), Parent = inner }), "BackgroundColor3", true)
            local lbl = Text({ Position = UDim2.fromOffset(6, 4), Size = UDim2.new(1, -12, 1, -4), Text = "", Parent = inner })
            conn(lbl:GetPropertyChangedSignal("TextBounds"), function()
                outer.Size = UDim2.fromOffset(lbl.TextBounds.X + 16, 24)
            end)
            local grab = Create("TextButton", { BackgroundTransparency = 1, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 2, Parent = outer })
            local held, from, startPos = false, nil, nil
            conn(grab.InputBegan, function(input) if IsClick(input) then held, from, startPos = true, input.Position, outer.Position end end)
            conn(uis.InputEnded, function(input) if IsClick(input) then held = false end end)
            conn(uis.InputChanged, function(input)
                if held and input.UserInputType == Enum.UserInputType.MouseMovement then
                    local d = input.Position - from
                    outer.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + d.X, startPos.Y.Scale, startPos.Y.Offset + d.Y)
                end
            end)
            function wm:SetText(t) lbl.Text = t end
            function wm:SetVisible(v) outer.Visible = v and true or false end
            return wm
        end

        function window:ArrayList()
            local al = { rows = {} }
            local holder = Create("Frame", {
                AnchorPoint = Vector2.new(1, 0), BackgroundTransparency = 1, Position = UDim2.new(1, -12, 0, 12),
                Size = UDim2.fromOffset(220, 400), Parent = screen,
            })
            Create("UIListLayout", { HorizontalAlignment = Enum.HorizontalAlignment.Right, Padding = UDim.new(0, 1), SortOrder = Enum.SortOrder.LayoutOrder, Parent = holder })
            function al:SetItems(items)
                for i, text in ipairs(items) do
                    local row = al.rows[i]
                    if not row then
                        row = Create("Frame", { BackgroundColor3 = Color3.fromRGB(12, 12, 12), BackgroundTransparency = 0.2, BorderSizePixel = 0, Size = UDim2.fromOffset(10, 18), LayoutOrder = i, Parent = holder })
                        Accent(Create("Frame", { BorderSizePixel = 0, AnchorPoint = Vector2.new(1, 0), Position = UDim2.fromScale(1, 0), Size = UDim2.new(0, 2, 1, 0), Parent = row }), "BackgroundColor3")
                        local lbl = Text({ Position = UDim2.fromOffset(6, 0), Size = UDim2.new(1, -12, 1, 0), TextXAlignment = Enum.TextXAlignment.Right, Parent = row })
                        conn(lbl:GetPropertyChangedSignal("TextBounds"), function() row.Size = UDim2.fromOffset(lbl.TextBounds.X + 16, 18) end)
                        row:SetAttribute("i", i)
                        al.rows[i] = row
                    end
                    row.Visible = true
                    local lbl = row:FindFirstChildWhichIsA("TextLabel")
                    if lbl.Text ~= text then lbl.Text = text end
                end
                for i = #items + 1, #al.rows do al.rows[i].Visible = false end
            end
            function al:SetVisible(v) holder.Visible = v and true or false end
            return al
        end

        function window:RefreshTabs()
            for _, page in ipairs(window.Pages) do page.Tab.Size = UDim2.new(1 / #window.Pages, 0, 1, 0) end
        end

        function window:Destroy()
            for _, c in ipairs(window.Connections) do pcall(function() c:Disconnect() end) end
            table.clear(window.Connections)
            pcall(function() screen:Destroy() end)
        end

        function window:Page(pcfg)
            pcfg = pcfg or {}
            local page = { Open = false }

            local tab = Create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), LayoutOrder = #window.Pages + 1, Parent = tabsInline })
            local tabButton = Create("TextButton", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 3, Parent = tab })
            local tabInline = Create("Frame", { BackgroundColor3 = Color3.fromRGB(41, 41, 41), BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -1, 1, -2), Parent = tab })
            local tabFill = Create("Frame", { BackgroundColor3 = Color3.fromRGB(41, 41, 41), BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = tabInline })
            local tabGradient = Sheen(tabFill, 100)
            local tabTitle = Text({
                AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.new(0, 4, 0.5, 0), Size = UDim2.new(1, -8, 0, 15),
                Text = pcfg.Name or "tab", TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Center, Parent = tabFill,
            })

            local pageHolder = Create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(10, 4), Size = UDim2.new(1, -20, 1, -8), Visible = false, Parent = pagesFrame })
            local function column(right)
                local col = Create("ScrollingFrame", {
                    AnchorPoint = right and Vector2.new(1, 0) or Vector2.zero, BackgroundTransparency = 1, BorderSizePixel = 0,
                    Position = right and UDim2.fromScale(1, 0) or UDim2.new(), Size = UDim2.new(0.5, -5, 1, 0),
                    CanvasSize = UDim2.new(), AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3,
                    ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65), ScrollingDirection = Enum.ScrollingDirection.Y,
                    VerticalScrollBarInset = Enum.ScrollBarInset.ScrollBar, Parent = pageHolder,
                })
                Create("UIListLayout", { Padding = UDim.new(0, 16), SortOrder = Enum.SortOrder.LayoutOrder, Parent = col })
                Create("UIPadding", { PaddingTop = UDim.new(0, 10), PaddingBottom = UDim.new(0, 6), Parent = col })
                return col
            end
            page.Left, page.Right = column(false), column(true)
            local sectionCount = 0

            function page:Turn(state)
                tabTitle.TextColor3 = state and ACCENT or TEXT_DIM
                tabGradient.Color = ColorSequence.new(Color3.fromRGB(255, 255, 255), state and Color3.fromRGB(155, 155, 155) or Color3.fromRGB(100, 100, 100))
                pageHolder.Visible = state
                page.Open = state
            end

            conn(tabButton.MouseButton1Down, function()
                for _, other in ipairs(window.Pages) do
                    if other ~= page then other:Turn(false) end
                end
                page:Turn(true)
            end)
            table.insert(Repaints, function() page:Turn(page.Open) end)

            function page:Section(scfg)
                scfg = scfg or {}
                local section = { Count = 0 }
                sectionCount = sectionCount + 1
                local parentCol = (tostring(scfg.Side or ""):lower() == "right") and page.Right or page.Left

                local sectionMain = Create("Frame", {
                    BackgroundColor3 = Color3.fromRGB(45, 45, 45), BorderColor3 = Color3.fromRGB(13, 13, 13), BorderMode = Enum.BorderMode.Inset,
                    BorderSizePixel = 1, Size = UDim2.new(1, -4, 0, 30), LayoutOrder = sectionCount, Parent = parentCol,
                })
                local sectionFrame = Create("Frame", { BackgroundColor3 = Color3.fromRGB(19, 19, 19), BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = sectionMain })
                local sectionTitle = Text({
                    AnchorPoint = Vector2.new(0, 0.5), Position = UDim2.fromOffset(13, 0), Size = UDim2.new(1, -26, 0, 15),
                    Text = scfg.Name or "new section", TextColor3 = Color3.fromRGB(205, 205, 205), ZIndex = 3, Parent = sectionMain,
                })
                local titleLine = Create("Frame", { BackgroundColor3 = Color3.fromRGB(19, 19, 19), BorderSizePixel = 0, Position = UDim2.fromOffset(9, 0), Size = UDim2.fromOffset(0, 1), ZIndex = 2, Parent = sectionMain })
                local function fitTitle() titleLine.Size = UDim2.fromOffset(sectionTitle.TextBounds.X + 6, 1) end
                conn(sectionTitle:GetPropertyChangedSignal("TextBounds"), fitTitle)
                fitTitle()

                local content = Create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(0, 12), Size = UDim2.new(1, 0, 0, 0), Parent = sectionFrame })
                local layout = Create("UIListLayout", { Padding = UDim.new(0, 5), SortOrder = Enum.SortOrder.LayoutOrder, Parent = content })
                local function resize()
                    local h = layout.AbsoluteContentSize.Y
                    content.Size = UDim2.new(1, 0, 0, h)
                    sectionMain.Size = UDim2.new(1, -4, 0, h + 22)
                end
                conn(layout:GetPropertyChangedSignal("AbsoluteContentSize"), resize)
                resize()

                local function holder(h)
                    section.Count = section.Count + 1
                    section.Last = Create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, h), LayoutOrder = section.Count, Parent = content })
                    return section.Last
                end

                local function hitbox(parent)
                    return Create("TextButton", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.fromScale(1, 1), Text = "", ZIndex = 2, Parent = parent })
                end

                local function field(parent, y)
                    local outer = Create("Frame", {
                        BackgroundColor3 = Color3.fromRGB(45, 45, 45), BorderColor3 = Color3.fromRGB(1, 1, 1), BorderMode = Enum.BorderMode.Inset,
                        BorderSizePixel = 1, Position = UDim2.fromOffset(16, y), Size = UDim2.new(1, -32, 0, 20), Parent = parent,
                    })
                    local inner = Create("Frame", { BackgroundColor3 = Color3.fromRGB(25, 25, 25), BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = outer })
                    return outer, inner
                end

                function section:Label(lcfg)
                    lcfg = lcfg or {}
                    local h = holder(14)
                    local lbl = Text({ Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -32, 1, 0), TextWrapped = true, Text = tostring(lcfg.Text or lcfg.Name or ""), Parent = h })
                    local function fit() h.Size = UDim2.new(1, 0, 0, math.max(14, lbl.TextBounds.Y)) end
                    conn(lbl:GetPropertyChangedSignal("TextBounds"), fit)
                    fit()
                    return { Set = function(_, t) lbl.Text = tostring(t) end }
                end

                function section:Toggle(tcfg)
                    tcfg = tcfg or {}
                    local t = { state = tcfg.Default and true or false }
                    local h = holder(14)
                    local btn = hitbox(h)
                    Text({ Position = UDim2.fromOffset(36, 0), Size = UDim2.new(1, -36, 1, 0), Text = tcfg.Name or "new toggle", Parent = h })
                    local box = Create("Frame", { BackgroundColor3 = Color3.fromRGB(1, 1, 1), BorderSizePixel = 0, Position = UDim2.fromOffset(16, 2), Size = UDim2.fromOffset(10, 10), Parent = h })
                    local fill = Create("Frame", { BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = box })
                    Sheen(fill)
                    local function paint() fill.BackgroundColor3 = t.state and ACCENT or OFF end
                    function t:Set(v, silent)
                        t.state = v and true or false
                        paint()
                        if not silent and tcfg.Callback then task.spawn(tcfg.Callback, t.state) end
                    end
                    function t:Get() return t.state end
                    conn(btn.MouseButton1Down, function() t:Set(not t.state) end)
                    paint()
                    table.insert(Repaints, paint)
                    window:BindTip(btn, tcfg.Tip)
                    return t
                end

                function section:Button(bcfg)
                    bcfg = bcfg or {}
                    local h = holder(20)
                    local btn = hitbox(h)
                    field(h, 0)
                    local title = Text({ Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -32, 1, 0), Text = bcfg.Name or "new button", TextXAlignment = Enum.TextXAlignment.Center, ZIndex = 1, Parent = h })
                    conn(btn.MouseButton1Down, function()
                        title.TextColor3 = ACCENT
                        task.delay(0.15, function() title.TextColor3 = TEXT end)
                        if bcfg.Callback then task.spawn(bcfg.Callback) end
                    end)
                    window:BindTip(btn, bcfg.Tip)
                    return {}
                end

                function section:Slider(scfg2)
                    scfg2 = scfg2 or {}
                    local named = scfg2.Name ~= nil
                    local s = {
                        min = tonumber(scfg2.Min) or 0, max = tonumber(scfg2.Max) or 10,
                        step = tonumber(scfg2.Step) or 1, suffix = tostring(scfg2.Suffix or ""), holding = false,
                    }
                    local decimals = StepDecimals(s.step)
                    local h = holder(named and 24 or 10)
                    local btn = hitbox(h)
                    if named then Text({ Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -16, 0, 14), Text = scfg2.Name, Parent = h }) end
                    local bar = Create("Frame", { BackgroundColor3 = Color3.fromRGB(1, 1, 1), BorderSizePixel = 0, Position = UDim2.fromOffset(16, named and 14 or 0), Size = UDim2.new(1, -32, 0, 10), Parent = h })
                    local track = Create("Frame", { BackgroundColor3 = OFF, BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = bar })
                    Sheen(track)
                    local slide = Create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = bar })
                    local fill = Accent(Create("Frame", { BorderSizePixel = 0, Size = UDim2.fromScale(0.5, 1), Parent = slide }), "BackgroundColor3")
                    Sheen(fill)
                    local valueLbl = Text({ AnchorPoint = Vector2.new(0.5, 0.25), Position = UDim2.new(1, 0, 0.5, 0), Size = UDim2.fromOffset(10, 14), ZIndex = 3, Parent = fill })

                    function s:Set(v, silent)
                        v = tonumber(v) or s.min
                        v = math.clamp(s.min + math.floor((v - s.min) / s.step + 0.5) * s.step, s.min, s.max)
                        s.state = v
                        fill.Size = UDim2.fromScale((v - s.min) / math.max(s.max - s.min, 1e-9), 1)
                        valueLbl.Text = string.format("%." .. decimals .. "f", v) .. s.suffix
                        if not silent and scfg2.Callback then pcall(scfg2.Callback, v) end
                    end
                    function s:Get() return s.state end
                    local function follow()
                        local m = uis:GetMouseLocation()
                        local rel = math.clamp((m.X - slide.AbsolutePosition.X) / math.max(slide.AbsoluteSize.X, 1), 0, 1)
                        s:Set(s.min + (s.max - s.min) * rel)
                    end
                    conn(btn.MouseButton1Down, function() s.holding = true; follow() end)
                    conn(uis.InputEnded, function(input) if IsClick(input) then s.holding = false end end)
                    conn(uis.InputChanged, function(input)
                        if s.holding and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then follow() end
                    end)
                    s:Set(scfg2.Default or s.min, true)
                    window:BindTip(btn, scfg2.Tip)
                    return s
                end

                function section:Dropdown(dcfg)
                    dcfg = dcfg or {}
                    local d = { options = dcfg.Options or {}, value = dcfg.Default, open = false }
                    local ROW, MAXH = 18, 144
                    local h = holder(36)
                    Text({ Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -16, 0, 14), Text = dcfg.Name or "dropdown", Parent = h })
                    local outer, inner = field(h, 15)
                    local btn = hitbox(outer)
                    local valueLbl = Text({ Position = UDim2.fromOffset(6, 0), Size = UDim2.new(1, -24, 1, 0), TextTruncate = Enum.TextTruncate.AtEnd, Parent = inner })
                    local arrow = Text({ AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -6, 0, 0), Size = UDim2.new(0, 12, 1, 0), Text = "+", TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Right, Parent = inner })
                    local list = Create("ScrollingFrame", {
                        BackgroundColor3 = Color3.fromRGB(19, 19, 19), BorderColor3 = Color3.fromRGB(1, 1, 1), BorderSizePixel = 1,
                        Position = UDim2.fromOffset(16, 37), Size = UDim2.new(1, -32, 0, 0), CanvasSize = UDim2.new(),
                        AutomaticCanvasSize = Enum.AutomaticSize.Y, ScrollBarThickness = 3, ScrollBarImageColor3 = Color3.fromRGB(65, 65, 65),
                        Visible = false, ZIndex = 5, Parent = h,
                    })
                    Create("UIListLayout", { SortOrder = Enum.SortOrder.LayoutOrder, Parent = list })

                    local rows = {}
                    local function paintRows()
                        for opt, row in pairs(rows) do row.TextColor3 = (opt == tostring(d.value)) and ACCENT or TEXT end
                    end
                    local function rebuild()
                        for _, row in pairs(rows) do row:Destroy() end
                        table.clear(rows)
                        for i, opt in ipairs(d.options) do
                            local key = tostring(opt)
                            local row = Create("TextButton", {
                                BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, ROW), AutoButtonColor = false,
                                Font = FONT, Text = "  " .. key, TextColor3 = TEXT, TextSize = 13, TextStrokeTransparency = 0.5,
                                TextXAlignment = Enum.TextXAlignment.Left, TextTruncate = Enum.TextTruncate.AtEnd, LayoutOrder = i, ZIndex = 6, Parent = list,
                            })
                            row.MouseButton1Down:Connect(function()
                                d:Set(opt)
                                d:Toggle(false)
                                if dcfg.Callback then task.spawn(dcfg.Callback, opt) end
                            end)
                            rows[key] = row
                        end
                        paintRows()
                    end
                    function d:Toggle(state)
                        d.open = state and #d.options > 0
                        local listH = math.min(#d.options * ROW, MAXH)
                        list.Size = UDim2.new(1, -32, 0, listH)
                        list.Visible = d.open
                        arrow.Text = d.open and "-" or "+"
                        h.Size = UDim2.new(1, 0, 0, 36 + (d.open and (listH + 4) or 0))
                    end
                    function d:Set(v)
                        d.value = v
                        valueLbl.Text = v ~= nil and tostring(v) or "none"
                        paintRows()
                    end
                    function d:Get() return d.value end
                    function d:Refresh(opts)
                        d.options = opts or {}
                        local keep = false
                        for _, o in ipairs(d.options) do if tostring(o) == tostring(d.value) then keep = true break end end
                        rebuild()
                        d:Set(keep and d.value or d.options[1])
                        if d.open then d:Toggle(true) end
                    end
                    conn(btn.MouseButton1Down, function() d:Toggle(not d.open) end)
                    rebuild()
                    d:Set(d.value)
                    table.insert(Repaints, paintRows)
                    window:BindTip(btn, dcfg.Tip)
                    return d
                end

                function section:Colorpicker(ccfg)
                    ccfg = ccfg or {}
                    local c = { value = typeof(ccfg.Default) == "Color3" and ccfg.Default or Color3.new(1, 1, 1), open = false, ready = false }
                    local h = holder(14)
                    local btn = hitbox(h)
                    Text({ Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -60, 1, 0), Text = ccfg.Name or "color", Parent = h })
                    local swatchOuter = Create("Frame", { AnchorPoint = Vector2.new(1, 0), BackgroundColor3 = Color3.fromRGB(1, 1, 1), BorderSizePixel = 0, Position = UDim2.new(1, -16, 0, 1), Size = UDim2.fromOffset(26, 12), Parent = h })
                    local swatch = Create("Frame", { BackgroundColor3 = c.value, BorderSizePixel = 0, Position = UDim2.fromOffset(1, 1), Size = UDim2.new(1, -2, 1, -2), Parent = swatchOuter })
                    Sheen(swatch, 190)
                    local hue, sat, val = c.value:ToHSV()
                    local sliders, rows = {}, {}
                    local function apply()
                        if not c.ready then return end
                        c.value = Color3.fromHSV((sliders[1]:Get() or 0) / 360, (sliders[2]:Get() or 0) / 100, (sliders[3]:Get() or 0) / 100)
                        swatch.BackgroundColor3 = c.value
                        if ccfg.Callback then task.spawn(ccfg.Callback, c.value) end
                    end
                    for i, spec in ipairs({ { "hue", 360, hue * 360 }, { "saturation", 100, sat * 100 }, { "value", 100, val * 100 } }) do
                        sliders[i] = section:Slider({ Name = "  " .. spec[1], Min = 0, Max = spec[2], Step = 1, Default = spec[3], Callback = apply })
                        rows[i] = section.Last
                        rows[i].Visible = false
                    end
                    c.ready = true
                    function c:Toggle(state)
                        c.open = state and true or false
                        for _, r in ipairs(rows) do r.Visible = c.open end
                    end
                    function c:Set(color, silent)
                        if typeof(color) ~= "Color3" then return end
                        local hh, ss, vv = color:ToHSV()
                        c.ready = false
                        sliders[1]:Set(hh * 360, true)
                        sliders[2]:Set(ss * 100, true)
                        sliders[3]:Set(vv * 100, true)
                        c.ready = true
                        c.value = color
                        swatch.BackgroundColor3 = color
                        if not silent and ccfg.Callback then task.spawn(ccfg.Callback, color) end
                    end
                    function c:Get() return c.value end
                    conn(btn.MouseButton1Down, function() c:Toggle(not c.open) end)
                    window:BindTip(btn, ccfg.Tip)
                    return c
                end

                function section:Textbox(xcfg)
                    xcfg = xcfg or {}
                    local h = holder(36)
                    Text({ Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -16, 0, 14), Text = xcfg.Name or "textbox", Parent = h })
                    local _, inner = field(h, 15)
                    local box = Create("TextBox", {
                        BackgroundTransparency = 1, BorderSizePixel = 0, ClearTextOnFocus = false, ClipsDescendants = true,
                        Position = UDim2.fromOffset(6, 0), Size = UDim2.new(1, -12, 1, 0), Font = FONT, TextSize = 13,
                        Text = tostring(xcfg.Default or ""), PlaceholderText = tostring(xcfg.Placeholder or ""),
                        PlaceholderColor3 = Color3.fromRGB(90, 90, 90), TextColor3 = TEXT, TextXAlignment = Enum.TextXAlignment.Left, Parent = inner,
                    })
                    conn(box.FocusLost, function() if xcfg.Callback then task.spawn(xcfg.Callback, box.Text) end end)
                    return { Set = function(_, t) box.Text = tostring(t) end, Get = function() return box.Text end }
                end

                function section:Keybind(kcfg)
                    kcfg = kcfg or {}
                    local k = { key = kcfg.Default, binding = false }
                    local h = holder(14)
                    local btn = hitbox(h)
                    Text({ Position = UDim2.fromOffset(16, 0), Size = UDim2.new(1, -16, 1, 0), Text = kcfg.Name or "keybind", Parent = h })
                    local keyLbl = Text({ AnchorPoint = Vector2.new(1, 0), Position = UDim2.new(1, -16, 0, 0), Size = UDim2.new(0, 90, 1, 0), TextColor3 = TEXT_DIM, TextXAlignment = Enum.TextXAlignment.Right, Parent = h })
                    local function paint()
                        keyLbl.Text = k.binding and "[...]" or ("[" .. (typeof(k.key) == "EnumItem" and k.key.Name or "none") .. "]")
                    end
                    conn(btn.MouseButton1Down, function() k.binding = true; paint() end)
                    conn(uis.InputBegan, function(input)
                        if not k.binding then return end
                        local it = input.UserInputType
                        local isMouse = it == Enum.UserInputType.MouseButton2 or it == Enum.UserInputType.MouseButton3
                        if it ~= Enum.UserInputType.Keyboard and not isMouse then return end
                        k.binding = false
                        local key = isMouse and it or input.KeyCode
                        if key ~= Enum.KeyCode.Escape then
                            k.key = key
                            if kcfg.Callback then task.spawn(kcfg.Callback, key) end
                        end
                        paint()
                    end)
                    function k:Set(key)
                        k.key, k.binding = key, false
                        paint()
                    end
                    function k:Get() return k.key end
                    paint()
                    return k
                end

                return section
            end

            page.Tab = tab
            table.insert(window.Pages, page)
            window:RefreshTabs()
            return page
        end

        return window
    end
end

local function ResolveKeyName(key)
    if typeof(key) == "EnumItem" then return key.Name end
    return (tostring(key or ""):gsub("^Enum%.%w+%.", ""))
end

local function ResolveKeyEnum(key)
    if typeof(key) == "EnumItem" then return key end
    local name = ResolveKeyName(key)
    if name == "" or name == "NONE" then return nil end
    return EnumFrom(Enum.KeyCode, name) or EnumFrom(Enum.UserInputType, name)
end

local function InitCallback(cb, getValue)
    task.defer(function()
        local value = getValue()
        if value == nil then return end
        UI.Init = true
        cb(value)
        UI.Init = false
    end)
end

local function WrapObelusTab(page, tabName)
    local w = { Raw = page, NextSide = "Left", Current = nil, CurrentTitle = "general" }
    UI.Elements = UI.Elements or {}

    local function safe(cb, what)
        return function(...)
            if not cb then return end
            local ok, err = pcall(cb, ...)
            if not ok then warn("[BS] " .. what .. " callback error: " .. tostring(err)) end
        end
    end

    local counts = {}
    local function register(cfg, kind, get, set)
        if cfg.NoSave then return end
        local base = tostring(tabName) .. "/" .. w.CurrentTitle .. "/" .. tostring(cfg.Title or kind)
        counts[base] = (counts[base] or 0) + 1
        local key = counts[base] > 1 and (base .. "#" .. counts[base]) or base
        table.insert(UI.Elements, { Key = key, Kind = kind, Get = get, Set = set })
    end

    function w:Section(cfg)
        local title = type(cfg) == "string" and cfg or (cfg and (cfg.Title or cfg.Name)) or "section"
        local side = (type(cfg) == "table" and cfg.Side) or w.NextSide
        w.NextSide = (side == "Left") and "Right" or "Left"
        w.CurrentTitle = tostring(title):lower()
        w.Current = page:Section({ Name = w.CurrentTitle, Side = side })
        return w.Current
    end

    local function sec()
        if not w.Current then w:Section("general") end
        return w.Current
    end

    function w:Toggle(cfg)
        cfg = cfg or {}
        local def = cfg.Default
        if def == nil then def = cfg.Value end
        local cb = safe(cfg.Callback, "toggle")
        local el = sec():Toggle({ Name = tostring(cfg.Title or "toggle"), Default = def, Tip = cfg.Desc, Callback = cb })
        if def ~= nil then InitCallback(cb, function() return el:Get() end) end
        register(cfg, "toggle", function() return el:Get() end, function(v)
            if type(v) == "boolean" and v ~= el:Get() then el:Set(v) end
        end)
        return el
    end

    function w:Slider(cfg)
        cfg = cfg or {}
        local min, max = tonumber(cfg.Min) or 0, tonumber(cfg.Max) or 100
        local def = cfg.Default ~= nil and math.clamp(tonumber(cfg.Default) or min, min, max) or nil
        local cb = safe(cfg.Callback, "slider")
        local el = sec():Slider({
            Name = tostring(cfg.Title or "slider"), Min = min, Max = max, Default = def or min,
            Step = tonumber(cfg.Step) or 1, Suffix = cfg.Suffix, Tip = cfg.Desc, Callback = cb,
        })
        if def ~= nil then InitCallback(cb, function() return el:Get() end) end
        register(cfg, "slider", function() return el:Get() end, function(v)
            if type(v) == "number" then el:Set(math.clamp(v, min, max)) end
        end)
        return el
    end

    function w:Button(cfg)
        cfg = cfg or {}
        return sec():Button({ Name = tostring(cfg.Title or "button"), Tip = cfg.Desc, Callback = safe(cfg.Callback, "button") })
    end

    function w:Dropdown(cfg)
        cfg = cfg or {}
        local opts = cfg.Options or cfg.Values or {}
        local cb = safe(cfg.Callback, "dropdown")
        local d = sec():Dropdown({
            Name = tostring(cfg.Title or "dropdown"), Options = opts, Default = cfg.Default or opts[1],
            Tip = cfg.Desc, Callback = cb,
        })

        InitCallback(cb, function() return d:Get() end)
        local el = { Raw = d }

        function el:Refresh(newOpts, keepCurrent)
            local before = d:Get()
            d:Refresh(newOpts or {})
            if keepCurrent == false then d:Set((newOpts or {})[1]) end
            local now = d:Get()
            if now ~= nil and now ~= before then cb(now) end
        end
        function el:Set(v) d:Set(v) end
        el.GetValue = function() return d:Get() end
        register(cfg, "dropdown", function() return d:Get() end, function(v)

            for _, o in ipairs(d.options or {}) do
                if tostring(o) == tostring(v) then
                    if d:Get() ~= o then
                        d:Set(o)
                        cb(o)
                    end
                    return
                end
            end
        end)
        return el
    end

    function w:Keybind(cfg)
        cfg = cfg or {}
        local function fire(key)
            if cfg.Callback then
                local ok, err = pcall(cfg.Callback, key and ResolveKeyName(key) or "NONE")
                if not ok then warn("[BS] keybind callback error: " .. tostring(err)) end
            end
        end
        local k = sec():Keybind({
            Name = tostring(cfg.Title or "keybind"), Default = ResolveKeyEnum(cfg.Default),
            Callback = fire,
        })
        register(cfg, "keybind", function()
            local key = k:Get()
            return typeof(key) == "EnumItem" and key.Name or "NONE"
        end, function(v)
            local key = ResolveKeyEnum(v)
            k:Set(key)
            fire(key)
        end)
        return k
    end

    function w:Colorpicker(cfg)
        cfg = cfg or {}
        local c = sec():Colorpicker({
            Name = tostring(cfg.Title or "color"), Default = cfg.Default, Tip = cfg.Desc,
            Callback = safe(cfg.Callback, "color"),
        })

        register(cfg, "color", function()
            local col = c:Get()
            return { R = col.R, G = col.G, B = col.B }
        end, function(v)
            if type(v) == "table" and tonumber(v.R) and tonumber(v.G) and tonumber(v.B) then
                c:Set(Color3.new(v.R, v.G, v.B))
            end
        end)
        return c
    end
    w.ColorPicker = w.Colorpicker

    function w:Input(cfg)
        cfg = cfg or {}
        local cb = safe(cfg.Callback, "input")
        local box = sec():Textbox({ Name = tostring(cfg.Title or "input"), Default = cfg.Default, Placeholder = cfg.Placeholder, Callback = cb })
        register(cfg, "input", function() return box:Get() end, function(v)
            if type(v) == "string" then
                box:Set(v)
                cb(v)
            end
        end)
        return box
    end

    function w:Label(cfg)
        cfg = cfg or {}
        local text = (cfg.Title and (tostring(cfg.Title) .. ": ") or "") .. tostring(cfg.Desc or cfg.Content or "")
        local l = sec():Label({ Text = text })
        return { SetLabel = function(_, t) l:Set(t) end, Set = function(_, t) l:Set(t) end }
    end
    w.Paragraph = w.Label

    return w
end

local function WrapObelusWindow(win)
    local ww = { Raw = win }

    function ww:Tab(cfg)
        cfg = cfg or {}
        local name = tostring(cfg.Title or cfg.Name or "tab"):lower()
        local tab = WrapObelusTab(win:Page({ Name = name }), name)
        if #win.Pages == 1 then win.Pages[1]:Turn(true) end
        return tab
    end

    function ww:SetToggleKey(k)
        local kc = ResolveKeyEnum(k)
        if kc and kc.EnumType == Enum.KeyCode then
            win.ToggleKey = kc
            S.ToggleKey = kc
        end
    end

    function ww:Toggle(state)
        if state == nil then state = not win.Main.Visible end
        win.Main.Visible = state and true or false
    end

    function ww:Notify(title, body, duration) win:Notify(title, body, duration) end
    function ww:IsOpen() return win.Main ~= nil and win.Main.Visible end
    function ww:Destroy() win:Destroy() end

    return ww
end

local function BuildAimTab(Window)
    local Tab = Window:Tab({ Title = "Aim" })

    Tab:Section({ Title = "Silent Aim", Side = "Left" })
    Tab:Toggle({
        Title = "Silent Aim",
        Desc = "Redirects fired bullets directly onto the chosen enemy hitbox without rotating your camera.",
        Default = false,
        Callback = function(v)
            S.SilentAim = v
            if v then InstallCombatHooks() end
        end,
    })
    Tab:Dropdown({
        Title = "Silent Aim Part",
        Options = { "Head", "UpperTorso", "HumanoidRootPart", "Closest" },
        Default = S.SilentAimPart,
        Callback = function(v) S.SilentAimPart = v end,
    })
    Tab:Slider({
        Title = "Silent Aim FOV",
        Min = 20, Max = 800, Default = S.SilentAimFOV, Suffix = "px",
        Callback = function(v) S.SilentAimFOV = v end,
    })
    Tab:Toggle({ Title = "Draw Silent FOV Circle", Default = false, Callback = function(v) S.SilentAimShowFOV = v end })
    Tab:Toggle({ Title = "Wall Check (Visible Only)", Default = false, Callback = function(v) S.SilentAimWallCheck = v end })
    Tab:Dropdown({
        Title = "Target Priority",
        Options = { "Crosshair", "Distance", "LowestHealth" },
        Default = S.SilentAimPriority,
        Callback = function(v) S.SilentAimPriority = v end,
    })

    Tab:Section({ Title = "Weapon Modifiers", Side = "Left" })
    Tab:Toggle({
        Title = "No Spread (Laser)",
        Desc = "Completely removes weapon bullet spread deviation.",
        Default = false,
        Callback = function(v)
            S.NoSpread = v
            if v then InstallCombatHooks() end
        end,
    })
    Tab:Toggle({
        Title = "No Recoil",
        Desc = "Eliminates camera recoil punch and gun visual kick entirely.",
        Default = false,
        Callback = function(v)
            S.NoRecoil = v
            if v then InstallCombatHooks() end
        end,
    })
    Tab:Toggle({
        Title = "Rapid Fire (All Weapons)",
        Desc = "Eliminates all firing delays and shot cooldowns, turning ANY gun (AWP, Scout, Deagle, Shotguns) into an ultra-fast automatic weapon.",
        Default = S.RapidFire,
        Callback = function(v)
            S.RapidFire = v
            if v then InstallCombatHooks() end
        end,
    })
    Tab:Slider({
        Title = "Rapid Fire Speed",
        Min = 0.01, Max = 0.15, Default = S.RapidFireRate, Step = 0.005, Suffix = "s",
        Desc = "Delay between shots (0.04s = 25 shots/sec, 0.02s = 50 shots/sec).",
        Callback = function(v) S.RapidFireRate = v end,
    })
    Tab:Toggle({
        Title = "Hold To Fire (Semi-Auto)",
        Desc = "Hold left click with a pistol / semi-auto and it keeps shooting at the gun's own fire rate (replays the game's Fire input).",
        Default = false,
        Callback = function(v) S.AutoPistol = v end,
    })
    Tab:Toggle({
        Title = "Infinite Ammo (VIP Flag)",
        Desc = "Freezes client magazine counter using the game's VIP infinite-ammo attribute.",
        Default = false,
        Callback = function(v)
            S.InfiniteAmmo = v
            SetInfiniteAmmo(v)
        end,
    })

    Tab:Section({ Title = "Camera Aimbot", Side = "Right" })
    Tab:Toggle({
        Title = "Aimbot Enabled",
        Desc = "Turns your camera onto the nearest enemy inside FOV.",
        Default = false,
        Callback = function(v) S.Aimbot = v end,
    })
    Tab:Keybind({ Title = "Aim Key", Default = S.AimKey, Callback = function(k) S.AimKey = k end })
    Tab:Toggle({ Title = "Always On", Default = false, Callback = function(v) S.AimAlways = v end })
    Tab:Dropdown({
        Title = "Aimbot Target Part",
        Options = { "Head", "UpperTorso", "HumanoidRootPart", "Closest" },
        Default = S.AimPart,
        Callback = function(v) S.AimPart = v end,
    })
    Tab:Slider({ Title = "Aimbot FOV", Min = 20, Max = 600, Default = S.AimFOV, Suffix = "px", Callback = function(v) S.AimFOV = v end })
    Tab:Toggle({ Title = "Draw Aim FOV Circle", Default = false, Callback = function(v) S.ShowAimFOV = v end })
    Tab:Slider({
        Title = "Smoothness",
        Min = 1, Max = 20, Default = S.Smoothness, Step = 0.5,
        Desc = "1 = Instant snap. Higher = Humanized smooth movement.",
        Callback = function(v) S.Smoothness = v end,
    })
    Tab:Toggle({ Title = "Visible Only Check", Default = true, Callback = function(v) S.AimVisibleOnly = v end })
    Tab:Toggle({
        Title = "Autowall (Visible Only)",
        Desc = "Also accept targets behind a wall when they're within your gun's Penetration distance of the wall face.",
        Default = S.AimAutowall,
        Callback = function(v) S.AimAutowall = v end,
    })

    Tab:Section({ Title = "Triggerbot", Side = "Right" })
    Tab:Toggle({
        Title = "Triggerbot Enabled",
        Desc = "Automatically clicks when crosshair is hovering over a verified live enemy.",
        Default = false,
        Callback = function(v) S.Triggerbot = v end,
    })
    Tab:Keybind({ Title = "Trigger Key", Default = S.TriggerKey, Callback = function(k) S.TriggerKey = k end })
    Tab:Toggle({ Title = "Trigger Always On", Default = false, Callback = function(v) S.TriggerAlways = v end })
    Tab:Slider({
        Title = "Shot Delay",
        Min = 0.01, Max = 0.4, Default = S.TriggerDelay, Step = 0.01, Suffix = "s",
        Callback = function(v) S.TriggerDelay = v end,
    })
    Tab:Toggle({
        Title = "Trigger Autowall",
        Desc = "Fire when your crosshair is on a wall with an enemy within your gun's Penetration distance behind it.",
        Default = S.TriggerAutowall,
        Callback = function(v) S.TriggerAutowall = v end,
    })

end

local function BuildMagicBulletTab(Window)
    local Tab = Window:Tab({ Title = "Magic Bullet" })

    Tab:Section({ Title = "Magic Bullet (Wall Penetration)", Side = "Left" })
    Tab:Toggle({
        Title = "Magic Bullet Enabled",
        Desc = "Synthesizes wall penetration geometry so fired bullets pierce through walls and terrain to strike targets.",
        Default = S.MagicBullet,
        Callback = function(v)
            S.MagicBullet = v
            if v then InstallCombatHooks() end
        end,
    })
    Tab:Dropdown({
        Title = "Target Hitbox",
        Options = { "Head", "UpperTorso", "HumanoidRootPart" },
        Default = S.MagicBulletHitbox,
        Callback = function(v) S.MagicBulletHitbox = v end,
    })
    Tab:Slider({
        Title = "Max Range",
        Min = 100, Max = 3000, Default = S.MagicBulletMaxDist, Step = 50, Suffix = " studs",
        Desc = "Maximum distance to acquire and pierce targets.",
        Callback = function(v) S.MagicBulletMaxDist = v end,
    })

    Tab:Section({ Title = "Manual Dispatch", Side = "Right" })
    Tab:Keybind({
        Title = "Shoot Key",
        Default = S.MagicBulletKey,
        Callback = function(k) S.MagicBulletKey = k end,
    })
    Tab:Button({
        Title = "Shoot Nearest Target Now",
        Desc = "Sends an instant lethal magic bullet packet directly to the nearest enemy.",
        Callback = function()
            local hit = FireMagicBulletNearest()
            if hit then
                Notify("Magic Bullet", "Dispatched lethal shot to nearest target!", 2)
            else
                Notify("Magic Bullet", "No valid enemy target found in range.", 2)
            end
        end,
    })
end

local function BuildVisualsTab(Window)
    local Tab = Window:Tab({ Title = "Visuals" })

    Tab:Section({ Title = "Player ESP", Side = "Left" })
    Tab:Toggle({
        Title = "Master ESP",
        Desc = "Decoys are rejected by position: anything parked off-map (|Y| > 1200) or with its head detached from its body.",
        Default = false,
        Callback = function(v) S.ESP = v end,
    })
    Tab:Toggle({ Title = "Boxes", Default = true, Callback = function(v) S.ESPBox = v end })
    Tab:Dropdown({
        Title = "Box Style",
        Options = { "Corner", "Full" },
        Default = S.ESPBoxType,
        Callback = function(v) S.ESPBoxType = v end,
    })
    Tab:Toggle({ Title = "Box Outlines", Default = true, Callback = function(v) S.ESPBoxOutline = v end })
    Tab:Slider({
        Title = "Box Thickness",
        Min = 1, Max = 4, Default = S.ESPBoxThickness, Step = 0.5,
        Callback = function(v) S.ESPBoxThickness = v end,
    })
    Tab:Toggle({ Title = "Skeleton", Default = true, Callback = function(v) S.ESPSkeleton = v end })
    Tab:Toggle({ Title = "Names", Default = true, Callback = function(v) S.ESPName = v end })
    Tab:Toggle({ Title = "Distance (meters)", Default = true, Callback = function(v) S.ESPDistance = v end })
    Tab:Toggle({ Title = "Equipped Weapon", Default = true, Callback = function(v) S.ESPWeapon = v end })
    Tab:Toggle({ Title = "Health Bars", Default = true, Callback = function(v) S.ESPHealth = v end })
    Tab:Dropdown({
        Title = "Health Bar Side",
        Options = { "Left", "Right" },
        Default = S.ESPHealthSide,
        Callback = function(v) S.ESPHealthSide = v end,
    })
    Tab:Toggle({ Title = "Tracers", Default = false, Callback = function(v) S.ESPTracer = v end })
    Tab:Dropdown({
        Title = "Tracer Origin",
        Options = { "Bottom", "Middle", "Top" },
        Default = S.ESPTracerOrigin,
        Callback = function(v) S.ESPTracerOrigin = v end,
    })
    Tab:Toggle({ Title = "Head Dot", Default = false, Callback = function(v) S.ESPHeadDot = v end })
    Tab:Toggle({ Title = "Player Chams / Highlights", Default = false, Callback = function(v) S.ESPChams = v end })
    Tab:Toggle({ Title = "Show Teammates", Default = false, Callback = function(v) S.ESPTeammates = v end })
    Tab:Slider({
        Title = "Max Distance",
        Min = 100, Max = 5000, Default = S.ESPMaxDistance, Step = 100, Suffix = " studs",
        Callback = function(v) S.ESPMaxDistance = v end,
    })

    Tab:Section({ Title = "Decoy Filter & Ghosts", Side = "Right" })
    Tab:Toggle({
        Title = "Last Seen Ghost Markers",
        Desc = "When the server drops an enemy from replication (behind cover), leaves a fading ghost marker at their last confirmed coordinates.",
        Default = true,
        Callback = function(v) S.ESPLastSeen = v end,
    })
    Tab:Slider({
        Title = "Ghost Marker Lifetime",
        Min = 1, Max = 10, Default = S.LastSeenTime, Step = 0.5, Suffix = "s",
        Callback = function(v) S.LastSeenTime = v end,
    })
    Tab:Toggle({
        Title = "Sound ESP (Noise Cones)",
        Desc = "Renders real-time visual sound indicators where enemy gunshots, footsteps, or melee swings occur.",
        Default = true,
        Callback = function(v) S.SoundESP = v end,
    })
    Tab:Slider({
        Title = "Sound Ping Lifetime",
        Min = 0.5, Max = 5, Default = S.SoundESPTime, Step = 0.5, Suffix = "s",
        Callback = function(v) S.SoundESPTime = v end,
    })

    Tab:Section({ Title = "Visibility Colors", Side = "Left" })
    Tab:Toggle({
        Title = "Visible / Hidden Colors",
        Desc = "Enemies you have line of sight to (head or body) switch to the visible color; behind walls they keep the Enemy ESP Color (Color Palette). Boxes, tracers, head dot and chams follow it.",
        Default = S.ESPVisibleColors,
        Callback = function(v) S.ESPVisibleColors = v end,
    })
    Tab:Colorpicker({ Title = "Visible Color", Default = S.EnemyVisibleColor, Callback = function(c) S.EnemyVisibleColor = c end })

    Tab:Section({ Title = "Bullet Tracers", Side = "Left" })
    Tab:Toggle({
        Title = "Bullet Tracers",
        Desc = "A line from your gun to where each of your shots landed, red when it hit an enemy.",
        Default = S.BulletTracers,
        Callback = function(v) S.BulletTracers = v end,
    })
    Tab:Colorpicker({ Title = "Tracer Color", Default = S.TracerColor, Callback = function(c) S.TracerColor = c end })
    Tab:Colorpicker({ Title = "Tracer Hit Color", Default = S.TracerHitColor, Callback = function(c) S.TracerHitColor = c end })
    Tab:Slider({ Title = "Tracer Duration", Min = 0.2, Max = 5, Default = S.TracerTime, Step = 0.1, Suffix = "s", Callback = function(v) S.TracerTime = v end })
    Tab:Slider({ Title = "Tracer Thickness", Min = 0.5, Max = 5, Default = S.TracerThickness, Step = 0.5, Suffix = "px", Callback = function(v) S.TracerThickness = v end })
    Tab:Toggle({ Title = "Impact Markers", Default = S.TracerImpacts, Callback = function(v) S.TracerImpacts = v end })
    Tab:Slider({ Title = "Impact Size", Min = 2, Max = 12, Default = S.ImpactSize, Step = 1, Suffix = "px", Callback = function(v) S.ImpactSize = v end })

    Tab:Section({ Title = "Loadout & Carrier", Side = "Left" })
    Tab:Toggle({
        Title = "Loadout ESP",
        Desc = "Guns, grenades and armor under each box, read from the player's Slot1-6 / Armor attributes.",
        Default = S.ESPLoadout,
        Callback = function(v) S.ESPLoadout = v end,
    })
    Tab:Toggle({ Title = "Show Money", Default = S.ESPMoney, Callback = function(v) S.ESPMoney = v end })
    Tab:Toggle({
        Title = "Bomb Carrier Tag",
        Desc = "Puts [C4] over whoever has the bomb in Slot5, and colors them on the radar.",
        Default = S.ESPBombCarrier,
        Callback = function(v) S.ESPBombCarrier = v end,
    })

    Tab:Section({ Title = "Radar", Side = "Right" })
    Tab:Toggle({
        Title = "Radar",
        Desc = "Camera-relative 2D radar. Uses the same decoy filter as the ESP; out-of-range players are pinned to the edge.",
        Default = S.Radar,
        Callback = function(v) S.Radar = v end,
    })
    Tab:Dropdown({
        Title = "Radar Corner",
        Options = { "Top Left", "Top Right", "Bottom Left", "Bottom Right" },
        Default = S.RadarCorner,
        Callback = function(v) S.RadarCorner = v end,
    })
    Tab:Slider({ Title = "Radar Size", Min = 120, Max = 340, Default = S.RadarSize, Step = 10, Suffix = "px", Callback = function(v) S.RadarSize = v end })
    Tab:Slider({ Title = "Radar Range", Min = 40, Max = 600, Default = S.RadarRange, Step = 10, Suffix = " studs", Callback = function(v) S.RadarRange = v end })
    Tab:Toggle({ Title = "Radar Teammates", Default = S.RadarTeammates, Callback = function(v) S.RadarTeammates = v end })
    Tab:Toggle({
        Title = "Radar Ghosts",
        Desc = "Faded dots at last-seen positions (needs Master ESP + Last Seen Ghost Markers).",
        Default = S.RadarGhosts,
        Callback = function(v) S.RadarGhosts = v end,
    })

    Tab:Section({ Title = "Off-screen Arrows", Side = "Left" })
    Tab:Toggle({
        Title = "Off-screen Arrows",
        Desc = "Arrows around the crosshair pointing at enemies outside your view.",
        Default = S.OffscreenArrows,
        Callback = function(v) S.OffscreenArrows = v end,
    })
    Tab:Slider({ Title = "Arrow Radius", Min = 60, Max = 400, Default = S.ArrowRadius, Step = 10, Suffix = "px", Callback = function(v) S.ArrowRadius = v end })
    Tab:Slider({ Title = "Arrow Size", Min = 8, Max = 30, Default = S.ArrowSize, Step = 1, Suffix = "px", Callback = function(v) S.ArrowSize = v end })
    Tab:Toggle({ Title = "Arrow Distance", Default = S.ArrowDistance, Callback = function(v) S.ArrowDistance = v end })

    Tab:Section({ Title = "HUD", Side = "Right" })
    Tab:Toggle({
        Title = "Spectator Count",
        Desc = "The server only tells you how many people are spectating you, not who.",
        Default = S.SpectatorHUD,
        Callback = function(v) S.SpectatorHUD = v end,
    })
    Tab:Toggle({ Title = "Spectator Alert", Default = S.SpectatorAlert, Callback = function(v) S.SpectatorAlert = v end })
    Tab:Toggle({ Title = "Bomb Timer", Default = S.BombTimerHUD, Callback = function(v) S.BombTimerHUD = v end })

    Tab:Section({ Title = "Color Palette", Side = "Right" })
    Tab:Colorpicker({ Title = "Enemy ESP Color", Default = S.EnemyColor, Callback = function(c) S.EnemyColor = c end })
    Tab:Colorpicker({ Title = "Team ESP Color", Default = S.TeamColor, Callback = function(c) S.TeamColor = c end })
    Tab:Colorpicker({ Title = "Ghost / Last Seen Color", Default = S.GhostColor, Callback = function(c) S.GhostColor = c end })
    Tab:Colorpicker({ Title = "Skeleton Color", Default = S.SkeletonColor, Callback = function(c) S.SkeletonColor = c end })
    Tab:Colorpicker({ Title = "Sound Event Color", Default = S.SoundColor, Callback = function(c) S.SoundColor = c end })
    Tab:Colorpicker({ Title = "FOV Circle Color", Default = S.FOVColor, Callback = function(c) S.FOVColor = c end })
end

local function BuildWorldTab(Window)
    local Tab = Window:Tab({ Title = "World" })

    Tab:Section({ Title = "Bomb & Objective ESP", Side = "Left" })
    Tab:Toggle({
        Title = "Bomb ESP (Planted C4)",
        Desc = "Highlights the planted bomb with site, distance, and live decimal countdown to explosion.",
        Default = true,
        Callback = function(v) S.BombESP = v end,
    })
    Tab:Toggle({
        Title = "Dropped Weapons ESP",
        Desc = "Shows dropped weapons on the ground with names and distance.",
        Default = false,
        Callback = function(v) S.DroppedWeaponESP = v end,
    })
    Tab:Toggle({
        Title = "Grenades ESP",
        Desc = "Shows in-flight grenades (HE, Flash, Smoke, Molotov) with distance warnings.",
        Default = false,
        Callback = function(v) S.GrenadeESP = v end,
    })

    Tab:Section({ Title = "Objective Automation", Side = "Right" })
    Tab:Toggle({
        Title = "Auto Defuse",
        Desc = "Automatically initiates defusal when within reach of the planted C4.",
        Default = false,
        Callback = function(v) S.AutoDefuse = v end,
    })
    Tab:Toggle({
        Title = "Auto Plant",
        Desc = "Automatically starts planting the bomb when standing in a plant area with C4 equipped.",
        Default = false,
        Callback = function(v) S.AutoPlant = v end,
    })

    Tab:Section({ Title = "Flash & Smoke", Side = "Right" })
    Tab:Toggle({
        Title = "Anti-Flash",
        Desc = "Hides the white-out, the freeze-frame and the color wash, and stops the ringing. Local only.",
        Default = S.AntiFlash,
        Callback = function(v)
            S.AntiFlash = v
            RefreshAntiFlash()
        end,
    })
    Tab:Toggle({
        Title = "Anti-Smoke",
        Desc = "Makes smoke particles invisible. Fog of war still applies: enemies the server isn't sending you stay hidden.",
        Default = S.AntiSmoke,
        Callback = function(v)
            S.AntiSmoke = v
            RefreshAntiSmoke()
        end,
    })

    Tab:Section({ Title = "Grenade Helper", Side = "Right" })
    Tab:Toggle({
        Title = "Throw Trajectory",
        Desc = "While a grenade is out, draws where it will go and land. Left click = far throw, hold right = near.",
        Default = S.NadePreview,
        Callback = function(v) S.NadePreview = v end,
    })
    Tab:Toggle({
        Title = "Landing Prediction",
        Desc = "Every grenade thrown (yours and theirs) is simulated when it spawns: path, landing ring and fuse countdown.",
        Default = S.NadePrediction,
        Callback = function(v) S.NadePrediction = v end,
    })
    Tab:Colorpicker({ Title = "Trajectory Color", Default = S.NadeColor, Callback = function(c) S.NadeColor = c end })
    Tab:Colorpicker({ Title = "Grenade / Prediction Color", Default = S.GrenadeColor, Callback = function(c) S.GrenadeColor = c end })

end

local function BuildSkinsTab(Window)
    local Tab = Window:Tab({ Title = "Skins" })

    local function ensureHooks()
        local ok, err = InstallSkinHooks()
        if not ok then Notify("BloxStrike", "Skin changer unavailable: " .. tostring(err), 5) end
        return ok
    end

    local function RefreshLocalViewmodel()
        local weapon = GetEquippedWeapon()
        if weapon and weapon.Viewmodel and type(weapon.Viewmodel.construct) == "function" then
            pcall(function() weapon.Viewmodel:construct() end)
        end
    end

    Tab:Section({ Title = "Weapon Skins", Side = "Left" })
    Tab:Label({ Desc = "Local-only viewmodel & third-person skins. Applies instantly." })

    local currentWeapon, currentSkin, currentFloat = nil, nil, 0.01
    local skinDropdown

    local wepList = WeaponNames()
    local initialWeapon = EquippedName(LocalPlayer) or wepList[1]
    if initialWeapon and initialWeapon:sub(1, 1) ~= "(" then
        currentWeapon = initialWeapon
    end

    local initialSkins = currentWeapon and SkinNames(currentWeapon) or { "(pick a weapon)" }
    currentSkin = initialSkins[1]

    local weaponDropdown = Tab:Dropdown({
        Title = "Weapon",
        Options = wepList,
        Default = currentWeapon,
        Callback = function(v)
            currentWeapon = v
            local skins = SkinNames(v)
            currentSkin = skins[1]
            if skinDropdown then pcall(function() skinDropdown:Refresh(skins, false) end) end
        end,
    })
    skinDropdown = Tab:Dropdown({
        Title = "Skin",
        Options = initialSkins,
        Default = currentSkin,
        Callback = function(v) currentSkin = v end,
    })
    Tab:Slider({
        Title = "Float (Wear)",
        Min = 0, Max = 1, Default = 0.01, Step = 0.01,
        Desc = "0.0 = Factory New, 1.0 = Battle-Scarred.",
        Callback = function(v) currentFloat = v end,
    })
    Tab:Button({
        Title = "Use My Equipped Weapon",
        Callback = function()
            local name = EquippedName(LocalPlayer)
            if not name then
                Notify("BloxStrike", "No weapon equipped right now.", 3)
                return
            end
            currentWeapon = name
            local skins = SkinNames(name)
            currentSkin = skins[1]
            pcall(function() weaponDropdown:Set(name) end)
            pcall(function() skinDropdown:Refresh(skins, false) end)
            Notify("BloxStrike", "Selected " .. name .. " (" .. #skins .. " skins found).", 3)
        end,
    })
    Tab:Button({
        Title = "Apply Weapon Skin",
        Callback = function()
            if not (currentWeapon and currentSkin) or currentSkin:sub(1, 1) == "(" then
                Notify("BloxStrike", "Pick a weapon and a skin first.", 3)
                return
            end
            if not ensureHooks() then return end
            S.SkinOverrides[currentWeapon] = { Skin = currentSkin, Float = currentFloat }
            RefreshLocalViewmodel()
            Notify("BloxStrike", currentWeapon .. " → " .. currentSkin .. " applied!", 4)
        end,
    })
    Tab:Button({
        Title = "Clear Weapon Override",
        Callback = function()
            if currentWeapon then S.SkinOverrides[currentWeapon] = nil end
            RefreshLocalViewmodel()
            Notify("BloxStrike", "Override cleared for " .. tostring(currentWeapon), 3)
        end,
    })

    Tab:Section({ Title = "Knife Model Swap", Side = "Right" })
    Tab:Label({ Desc = "Swaps your knife viewmodel model to any knife (Karambit, Butterfly, M9, etc.)." })
    local knifeList = KnifeNames()
    local selectedKnife = knifeList[1]
    Tab:Dropdown({
        Title = "Knife Model",
        Options = knifeList,
        Default = selectedKnife,
        Callback = function(v) selectedKnife = v end,
    })
    Tab:Button({
        Title = "Apply Knife Model",
        Callback = function()
            if not selectedKnife or selectedKnife:sub(1, 1) == "(" then
                Notify("BloxStrike", "Select a knife model first.", 3)
                return
            end
            if not ensureHooks() then return end
            S.KnifeModel = selectedKnife
            RefreshLocalViewmodel()
            Notify("BloxStrike", "Knife Model → " .. selectedKnife .. " applied!", 4)
        end,
    })
    Tab:Button({
        Title = "Clear Knife Model",
        Callback = function()
            S.KnifeModel = nil
            RefreshLocalViewmodel()
            Notify("BloxStrike", "Knife model cleared.", 3)
        end,
    })

    Tab:Section({ Title = "Gloves", Side = "Right" })
    local gloveList = GloveNames()
    local selectedGlove = gloveList[1]
    local initialGloveSkins = selectedGlove and SkinNames(selectedGlove) or { "(pick gloves)" }
    local selectedGloveSkin = initialGloveSkins[1]
    local gloveSkinDropdown

    Tab:Dropdown({
        Title = "Gloves",
        Options = gloveList,
        Default = selectedGlove,
        Callback = function(v)
            selectedGlove = v
            local skins = SkinNames(v)
            selectedGloveSkin = skins[1]
            if gloveSkinDropdown then pcall(function() gloveSkinDropdown:Refresh(skins, false) end) end
        end,
    })
    gloveSkinDropdown = Tab:Dropdown({
        Title = "Glove Skin",
        Options = initialGloveSkins,
        Default = selectedGloveSkin,
        Callback = function(v) selectedGloveSkin = v end,
    })
    Tab:Button({
        Title = "Apply Gloves",
        Callback = function()
            if not (selectedGlove and selectedGloveSkin) or selectedGloveSkin:sub(1, 1) == "(" then
                Notify("BloxStrike", "Pick gloves and a skin first.", 3)
                return
            end
            if not ensureHooks() then return end
            S.GloveOverride = { Name = selectedGlove, Skin = selectedGloveSkin, Float = currentFloat }
            RefreshLocalViewmodel()
            Notify("BloxStrike", "Gloves → " .. selectedGlove .. " | " .. selectedGloveSkin .. " applied!", 4)
        end,
    })

    Tab:Section({ Title = "Reset All", Side = "Left" })
    Tab:Button({
        Title = "Clear All Skin Overrides",
        Callback = function()
            table.clear(S.SkinOverrides)
            S.GloveOverride = nil
            S.KnifeModel = nil
            RefreshLocalViewmodel()
            Notify("BloxStrike", "All skin overrides cleared.", 3)
        end,
    })
end

local function BuildLookTab(Window)
    local Tab = Window:Tab({ Title = "Look" })

    local function world(key) return function(v) S[key] = v; ApplyLighting() end end
    local function chams(key) return function(v) S[key] = v; Look.Version = Look.Version + 1 end end
    local function map(key) return function(v) S[key] = v; Look.RefreshMap() end end
    local function set(key) return function(v) S[key] = v end end

    Tab:Section({ Title = "Self Chams", Side = "Left" })
    Tab:Toggle({ Title = "Arm Chams", Desc = "Recolors your first-person arms / gloves. Local only.", Default = S.ArmChams, Callback = chams("ArmChams") })
    Tab:Dropdown({ Title = "Arm Material", Options = Look.Materials, Default = S.ArmChamsMaterial, Callback = chams("ArmChamsMaterial") })
    Tab:Colorpicker({ Title = "Arm Color", Default = S.ArmChamsColor, Callback = chams("ArmChamsColor") })
    Tab:Slider({ Title = "Arm Transparency", Min = 0, Max = 0.9, Default = S.ArmChamsTransparency, Step = 0.05, Callback = chams("ArmChamsTransparency") })
    Tab:Toggle({ Title = "Weapon Chams", Desc = "Recolors the gun / knife in your hands.", Default = S.WeaponChams, Callback = chams("WeaponChams") })
    Tab:Dropdown({ Title = "Weapon Material", Options = Look.Materials, Default = S.WeaponChamsMaterial, Callback = chams("WeaponChamsMaterial") })
    Tab:Colorpicker({ Title = "Weapon Color", Default = S.WeaponChamsColor, Callback = chams("WeaponChamsColor") })
    Tab:Slider({ Title = "Weapon Transparency", Min = 0, Max = 0.9, Default = S.WeaponChamsTransparency, Step = 0.05, Callback = chams("WeaponChamsTransparency") })
    Tab:Toggle({
        Title = "Hide Skin Textures",
        Desc = "Skins paint over the color with textures; this parks them while chams are on so the color shows.",
        Default = S.ChamsHideTextures,
        Callback = chams("ChamsHideTextures"),
    })
    Tab:Toggle({ Title = "Viewmodel Glow", Desc = "Highlight outline + fill around your arms and gun.", Default = S.ViewmodelGlow, Callback = set("ViewmodelGlow") })
    Tab:Colorpicker({ Title = "Glow Fill", Default = S.ViewmodelGlowFill, Callback = set("ViewmodelGlowFill") })
    Tab:Colorpicker({ Title = "Glow Outline", Default = S.ViewmodelGlowOutline, Callback = set("ViewmodelGlowOutline") })
    Tab:Slider({ Title = "Glow Fill Transparency", Min = 0, Max = 1, Default = S.ViewmodelGlowFillT, Step = 0.05, Callback = set("ViewmodelGlowFillT") })
    Tab:Slider({ Title = "Glow Outline Transparency", Min = 0, Max = 1, Default = S.ViewmodelGlowOutlineT, Step = 0.05, Callback = set("ViewmodelGlowOutlineT") })

    Tab:Section({ Title = "Crosshair", Side = "Left" })
    Tab:Toggle({ Title = "Custom Crosshair", Default = S.Crosshair, Callback = set("Crosshair") })
    Tab:Toggle({ Title = "Hide Game Crosshair", Default = S.HideGameCrosshair, Callback = set("HideGameCrosshair") })
    Tab:Dropdown({
        Title = "Style",
        Options = { "Cross", "T", "X", "Cross + Circle", "Circle", "Dot" },
        Default = S.CrosshairStyle,
        Callback = set("CrosshairStyle"),
    })
    Tab:Colorpicker({ Title = "Crosshair Color", Default = S.CrosshairColor, Callback = set("CrosshairColor") })
    Tab:Toggle({ Title = "Rainbow", Default = S.CrosshairRainbow, Callback = set("CrosshairRainbow") })
    Tab:Slider({ Title = "Rainbow Speed", Min = 0.05, Max = 2, Default = S.CrosshairRainbowSpeed, Step = 0.05, Callback = set("CrosshairRainbowSpeed") })
    Tab:Slider({ Title = "Opacity", Min = 0.1, Max = 1, Default = S.CrosshairOpacity, Step = 0.05, Callback = set("CrosshairOpacity") })

    Tab:Section({ Title = "Crosshair Shape", Side = "Left" })
    Tab:Slider({ Title = "Length", Min = 1, Max = 40, Default = S.CrosshairSize, Step = 1, Suffix = "px", Callback = set("CrosshairSize") })
    Tab:Slider({ Title = "Gap", Min = 0, Max = 30, Default = S.CrosshairGap, Step = 1, Suffix = "px", Callback = set("CrosshairGap") })
    Tab:Slider({ Title = "Thickness", Min = 1, Max = 8, Default = S.CrosshairThickness, Step = 0.5, Suffix = "px", Callback = set("CrosshairThickness") })
    Tab:Slider({ Title = "Rotation", Min = 0, Max = 90, Default = S.CrosshairRotation, Step = 1, Suffix = "°", Callback = set("CrosshairRotation") })
    Tab:Toggle({ Title = "Center Dot", Default = S.CrosshairDot, Callback = set("CrosshairDot") })
    Tab:Slider({ Title = "Dot Size", Min = 1, Max = 10, Default = S.CrosshairDotSize, Step = 1, Suffix = "px", Callback = set("CrosshairDotSize") })

    Tab:Section({ Title = "Crosshair Stroke", Side = "Left" })
    Tab:Toggle({ Title = "Stroke (Outline)", Default = S.CrosshairOutline, Callback = set("CrosshairOutline") })
    Tab:Slider({ Title = "Stroke Thickness", Min = 0.5, Max = 4, Default = S.CrosshairOutlineThickness, Step = 0.5, Suffix = "px", Callback = set("CrosshairOutlineThickness") })
    Tab:Colorpicker({ Title = "Stroke Color", Default = S.CrosshairOutlineColor, Callback = set("CrosshairOutlineColor") })

    Tab:Section({ Title = "Crosshair Motion", Side = "Left" })
    Tab:Toggle({ Title = "Spin", Default = S.CrosshairSpin, Callback = set("CrosshairSpin") })
    Tab:Dropdown({
        Title = "Spin Mode",
        Desc = "Constant = keeps turning. Swing = rocks back and forth.",
        Options = { "Constant", "Swing" },
        Default = S.CrosshairSpinMode,
        Callback = set("CrosshairSpinMode"),
    })
    Tab:Dropdown({ Title = "Spin Direction", Options = { "Clockwise", "Counter-Clockwise" }, Default = S.CrosshairSpinDirection, Callback = set("CrosshairSpinDirection") })
    Tab:Slider({ Title = "Spin Speed", Min = 0.5, Max = 20, Default = S.CrosshairSpinSpeed, Step = 0.5, Callback = set("CrosshairSpinSpeed") })
    Tab:Slider({ Title = "Swing Angle", Min = 5, Max = 180, Default = S.CrosshairSwingAngle, Step = 5, Suffix = "°", Callback = set("CrosshairSwingAngle") })
    Tab:Toggle({ Title = "Gap Pulse", Desc = "The gap breathes in and out.", Default = S.CrosshairPulse, Callback = set("CrosshairPulse") })
    Tab:Slider({ Title = "Pulse Speed", Min = 0.5, Max = 15, Default = S.CrosshairPulseSpeed, Step = 0.5, Callback = set("CrosshairPulseSpeed") })
    Tab:Slider({ Title = "Pulse Amount", Min = 1, Max = 20, Default = S.CrosshairPulseAmount, Step = 1, Suffix = "px", Callback = set("CrosshairPulseAmount") })
    Tab:Toggle({ Title = "Dynamic Gap", Desc = "Opens up while you move or shoot, CS-style.", Default = S.CrosshairDynamic, Callback = set("CrosshairDynamic") })
    Tab:Slider({ Title = "Dynamic Amount", Min = 1, Max = 30, Default = S.CrosshairDynamicAmount, Step = 1, Suffix = "px", Callback = set("CrosshairDynamicAmount") })

    Tab:Section({ Title = "Hitmarker", Side = "Left" })
    Tab:Toggle({
        Title = "Hitmarker",
        Desc = "X at the crosshair when you land a hit (red on headshots).",
        Default = S.Hitmarker,
        Callback = set("Hitmarker"),
    })
    Tab:Colorpicker({ Title = "Hit Color", Default = S.HitmarkerColor, Callback = set("HitmarkerColor") })
    Tab:Colorpicker({ Title = "Headshot Color", Default = S.HitmarkerHeadColor, Callback = set("HitmarkerHeadColor") })

    Tab:Section({ Title = "Enemy Chams Style", Side = "Left" })
    Tab:Slider({ Title = "Fill Transparency", Min = 0, Max = 1, Default = S.ChamsFillT, Step = 0.05, Callback = set("ChamsFillT") })
    Tab:Slider({ Title = "Outline Transparency", Min = 0, Max = 1, Default = S.ChamsOutlineT, Step = 0.05, Callback = set("ChamsOutlineT") })
    Tab:Toggle({ Title = "White Outline", Default = S.ChamsOutlineWhite, Callback = set("ChamsOutlineWhite") })
    Tab:Toggle({ Title = "Visible Only", Desc = "Only highlight enemies you could see anyway (Occluded depth mode).", Default = S.ChamsVisibleOnly, Callback = set("ChamsVisibleOnly") })

    Tab:Section({ Title = "Camera", Side = "Right" })
    Tab:Toggle({
        Title = "Custom FOV",
        Desc = "Re-applied every frame after the game's camera (which clamps it to 80). Scopes still zoom.",
        Default = S.CustomFOVEnabled,
        Callback = set("CustomFOVEnabled"),
    })
    Tab:Slider({ Title = "Field Of View", Min = 60, Max = 120, Default = S.CustomFOV, Step = 1, Suffix = "°", Callback = set("CustomFOV") })
    Tab:Slider({
        Title = "Stretched Res",
        Desc = "Squashes the picture vertically like a stretched 4:3. 1 = off.",
        Min = 0.6, Max = 1, Default = S.Stretch, Step = 0.01,
        Callback = set("Stretch"),
    })

    Tab:Section({ Title = "Lighting", Side = "Right" })
    Tab:Toggle({ Title = "Fullbright", Desc = "No shadows, bright ambient. Overrides Custom Lighting.", Default = S.Fullbright, Callback = world("Fullbright") })
    Tab:Toggle({ Title = "No Fog", Desc = "Clears fog and the map's Atmosphere haze.", Default = S.NoFog, Callback = world("NoFog") })
    Tab:Toggle({ Title = "Custom Lighting", Default = S.CustomLighting, Callback = world("CustomLighting") })
    Tab:Slider({ Title = "Time Of Day", Min = 0, Max = 24, Default = S.LightClock, Step = 0.1, Suffix = "h", Callback = world("LightClock") })
    Tab:Slider({ Title = "Brightness", Min = 0, Max = 10, Default = S.LightBrightness, Step = 0.1, Callback = world("LightBrightness") })
    Tab:Slider({ Title = "Exposure", Min = -3, Max = 3, Default = S.LightExposure, Step = 0.1, Callback = world("LightExposure") })
    Tab:Toggle({ Title = "Shadows", Default = S.LightShadows, Callback = world("LightShadows") })
    Tab:Colorpicker({ Title = "Ambient", Default = S.LightAmbient, Callback = world("LightAmbient") })
    Tab:Colorpicker({ Title = "Outdoor Ambient", Default = S.LightOutdoor, Callback = world("LightOutdoor") })
    Tab:Colorpicker({ Title = "Color Shift (Top)", Default = S.LightShiftTop, Callback = world("LightShiftTop") })
    Tab:Toggle({ Title = "Custom Fog", Desc = "Plain fog only shows on maps without an Atmosphere (or with No Fog off and Custom Atmosphere density 0).", Default = S.CustomFog, Callback = world("CustomFog") })
    Tab:Slider({ Title = "Fog Distance", Min = 50, Max = 3000, Default = S.FogEnd, Step = 50, Suffix = " studs", Callback = world("FogEnd") })
    Tab:Colorpicker({ Title = "Fog Color", Default = S.FogColor, Callback = world("FogColor") })

    Tab:Section({ Title = "Atmosphere", Side = "Right" })
    Tab:Toggle({ Title = "Custom Atmosphere", Default = S.CustomAtmosphere, Callback = world("CustomAtmosphere") })
    Tab:Slider({ Title = "Density", Min = 0, Max = 1, Default = S.AtmoDensity, Step = 0.01, Callback = world("AtmoDensity") })
    Tab:Slider({ Title = "Offset", Min = 0, Max = 1, Default = S.AtmoOffset, Step = 0.01, Callback = world("AtmoOffset") })
    Tab:Slider({ Title = "Glare", Min = 0, Max = 10, Default = S.AtmoGlare, Step = 0.1, Callback = world("AtmoGlare") })
    Tab:Slider({ Title = "Haze", Min = 0, Max = 10, Default = S.AtmoHaze, Step = 0.1, Callback = world("AtmoHaze") })
    Tab:Colorpicker({ Title = "Atmosphere Color", Default = S.AtmoColor, Callback = world("AtmoColor") })
    Tab:Colorpicker({ Title = "Decay Color", Default = S.AtmoDecay, Callback = world("AtmoDecay") })

    Tab:Section({ Title = "Skybox", Side = "Right" })
    Tab:Dropdown({
        Title = "Skybox",
        Desc = "Presets are the skies the game ships for its maps (Assets.Lighting).",
        Options = Look.CollectSkies(),
        Default = S.SkyPreset,
        Callback = world("SkyPreset"),
    })
    Tab:Input({
        Title = "Custom Sky Image ID",
        Placeholder = "image asset id (not a decal id)",
        Callback = function(text)
            S.SkyCustomId = text
            ApplyLighting()
        end,
    })
    Tab:Toggle({ Title = "Sky Tweaks", Default = S.SkyTweaks, Callback = world("SkyTweaks") })
    Tab:Toggle({ Title = "Sun & Moon", Default = S.SkyCelestial, Callback = world("SkyCelestial") })
    Tab:Slider({ Title = "Stars", Min = 0, Max = 5000, Default = S.SkyStars, Step = 100, Callback = world("SkyStars") })

    Tab:Section({ Title = "Post Processing", Side = "Right" })
    Tab:Toggle({ Title = "Disable Map Effects", Desc = "Turns off the map's own bloom / color correction / sun rays.", Default = S.NoPostFX, Callback = world("NoPostFX") })
    Tab:Toggle({ Title = "Color Correction", Default = S.CCEnabled, Callback = world("CCEnabled") })
    Tab:Colorpicker({ Title = "Tint", Default = S.CCTint, Callback = world("CCTint") })
    Tab:Slider({ Title = "Saturation", Min = -1, Max = 1, Default = S.CCSaturation, Step = 0.05, Callback = world("CCSaturation") })
    Tab:Slider({ Title = "Contrast", Min = -1, Max = 1, Default = S.CCContrast, Step = 0.05, Callback = world("CCContrast") })
    Tab:Slider({ Title = "CC Brightness", Min = -0.5, Max = 0.5, Default = S.CCBrightness, Step = 0.01, Callback = world("CCBrightness") })
    Tab:Toggle({ Title = "Bloom", Default = S.BloomEnabled, Callback = world("BloomEnabled") })
    Tab:Slider({ Title = "Bloom Intensity", Min = 0, Max = 3, Default = S.BloomIntensity, Step = 0.05, Callback = world("BloomIntensity") })
    Tab:Slider({ Title = "Bloom Size", Min = 0, Max = 56, Default = S.BloomSize, Step = 1, Callback = world("BloomSize") })
    Tab:Slider({ Title = "Bloom Threshold", Min = 0, Max = 4, Default = S.BloomThreshold, Step = 0.05, Callback = world("BloomThreshold") })
    Tab:Toggle({ Title = "Sun Rays", Default = S.SunRaysEnabled, Callback = world("SunRaysEnabled") })
    Tab:Slider({ Title = "Rays Intensity", Min = 0, Max = 1, Default = S.SunRaysIntensity, Step = 0.01, Callback = world("SunRaysIntensity") })
    Tab:Slider({ Title = "Rays Spread", Min = 0, Max = 1, Default = S.SunRaysSpread, Step = 0.01, Callback = world("SunRaysSpread") })

    Tab:Section({ Title = "Map Materials", Side = "Right" })
    Tab:Dropdown({
        Title = "Material",
        Desc = "Clean = flat look, keeps the real material. Any other choice really swaps the material, and your bullets report the material they hit to the server.",
        Options = Look.MapMaterials,
        Default = S.MapMaterial,
        Callback = map("MapMaterial"),
    })
    Tab:Toggle({ Title = "Recolor Map", Default = S.MapRecolor, Callback = map("MapRecolor") })
    Tab:Colorpicker({ Title = "Map Color", Default = S.MapColor, Callback = map("MapColor") })
    Tab:Toggle({ Title = "Remove Map Textures", Desc = "Hides decals, textures and surface appearances on map parts.", Default = S.MapNoTextures, Callback = map("MapNoTextures") })
end

local function BuildSettingsTab(Window)
    local Tab = Window:Tab({ Title = "Settings" })

    Tab:Section({ Title = "Audio & Hitsounds", Side = "Left" })
    Tab:Toggle({
        Title = "Hit Sounds",
        Desc = "Plays an audio cue whenever you hit an enemy player.",
        Default = true,
        Callback = function(v) S.HitSounds = v end,
    })
    Tab:Dropdown({
        Title = "Sound Effect",
        Options = { "Neverlose", "Skeet", "Rust", "Bameware", "Bell" },
        Default = S.HitSoundChoice,
        Callback = function(v)
            S.HitSoundChoice = v
            if not UI.Init then PlayHitSound(false) end
        end,
    })
    Tab:Toggle({
        Title = "Headshot Dink Cue",
        Desc = "Plays a distinct high-pitch audio cue for headshot hits.",
        Default = true,
        Callback = function(v) S.HeadshotSound = v end,
    })

    Tab:Section({ Title = "Interface & Controls", Side = "Right" })
    Tab:Keybind({
        Title = "Menu Toggle Key",
        Default = "RightShift",
        Callback = function(k) Window:SetToggleKey(k) end,
    })
    Tab:Toggle({ Title = "Notifications", Default = true, Callback = function(v) S.Notifications = v end })
    Tab:Toggle({
        Title = "Watermark",
        Desc = "Draggable bar: fps, ping, time.",
        Default = S.Watermark,
        Callback = function(v)
            S.Watermark = v
            if UI.WatermarkObj then UI.WatermarkObj:SetVisible(v) end
        end,
    })
    Tab:Toggle({
        Title = "Keybind List",
        Desc = "Top-right list of everything that's switched on, with its key.",
        Default = S.KeybindList,
        Callback = function(v)
            S.KeybindList = v
            if UI.KeyListObj then UI.KeyListObj:SetVisible(v) end
        end,
    })

    Tab:Section({ Title = "Configs", Side = "Left" })
    local nameBox = Tab:Input({
        Title = "Config Name",
        Placeholder = "e.g. legit, rage, visuals",
        NoSave = true,
        Callback = function(t) UI.ConfigName = t end,
    })
    local listDrop
    local function refreshList()
        local names = UI.ListConfigs()
        if #names == 0 then names = { "(none saved)" } end
        if listDrop then pcall(function() listDrop:Refresh(names, true) end) end
        return names
    end
    listDrop = Tab:Dropdown({
        Title = "Saved Configs",
        Options = UI.ListConfigs()[1] and UI.ListConfigs() or { "(none saved)" },
        NoSave = true,
        Callback = function(v)
            if v ~= "(none saved)" and not UI.Init then
                UI.ConfigName = v
                pcall(function() nameBox:Set(v) end)
            end
        end,
    })
    Tab:Button({
        Title = "Save",
        Desc = "Saves the whole menu to workspace/BloxStrike/configs/<name>.json (overwrites).",
        Callback = function()
            local ok, err = UI.SaveConfig(UI.ConfigName)
            Notify("Configs", ok and ("Saved '" .. tostring(UI.ConfigName) .. "'.") or ("Save failed: " .. tostring(err)), 4)
            refreshList()
        end,
    })
    Tab:Button({
        Title = "Load",
        Callback = function()
            local ok, info = UI.LoadConfig(UI.ConfigName)
            Notify("Configs", ok and ("Loaded '" .. tostring(UI.ConfigName) .. "' (" .. info .. " settings).") or ("Load failed: " .. tostring(info)), 4)
        end,
    })
    Tab:Button({
        Title = "Delete",
        Callback = function()
            local ok, err = UI.DeleteConfig(UI.ConfigName)
            Notify("Configs", ok and ("Deleted '" .. tostring(UI.ConfigName) .. "'.") or ("Delete failed: " .. tostring(err)), 4)
            refreshList()
        end,
    })
    Tab:Button({ Title = "Refresh List", Callback = refreshList })
    Tab:Button({
        Title = "Load This On Inject",
        Desc = "Auto-loads the named config every time the script starts.",
        Callback = function()
            local ok, err = UI.SetAutoload(UI.ConfigName)
            Notify("Configs", ok and ("'" .. tostring(UI.ConfigName) .. "' will load on inject.") or ("Failed: " .. tostring(err)), 4)
        end,
    })
    Tab:Button({
        Title = "Clear Auto-Load",
        Callback = function()
            UI.SetAutoload(nil)
            Notify("Configs", "Auto-load cleared.", 3)
        end,
    })

    Tab:Section({ Title = "Script Management", Side = "Right" })
    Tab:Button({
        Title = "Unload Script",
        Desc = "Completely tears down all hooks, connections, visual drawings, and UI.",
        Callback = function()
            if GlobalScope.BS_Cleanup then GlobalScope.BS_Cleanup() end
        end,
    })
end

local Window = nil

UI.Root = "BloxStrike"
UI.ConfigDir = "BloxStrike/configs"
UI.AutoloadFile = "BloxStrike/autoload.txt"

function UI.HasFiles()
    return type(writefile) == "function" and type(readfile) == "function" and type(isfile) == "function"
end

function UI.CleanName(name)
    name = tostring(name or ""):gsub("[^%w%-_ ]", ""):gsub("^%s+", ""):gsub("%s+$", "")
    return name ~= "" and name or nil
end

function UI.EnsureDirs()
    if type(isfolder) ~= "function" or type(makefolder) ~= "function" then return end
    pcall(function()
        if not isfolder(UI.Root) then makefolder(UI.Root) end
        if not isfolder(UI.ConfigDir) then makefolder(UI.ConfigDir) end
    end)
end

function UI.ConfigPath(name) return UI.ConfigDir .. "/" .. name .. ".json" end

function UI.SaveConfig(name)
    name = UI.CleanName(name)
    if not name then return false, "type a config name first" end
    if not UI.HasFiles() then return false, "this executor has no writefile" end
    UI.EnsureDirs()
    local values, count = {}, 0
    for _, el in ipairs(UI.Elements or {}) do
        local ok, v = pcall(el.Get)
        if ok and v ~= nil then
            values[el.Key] = v
            count = count + 1
        end
    end
    local ok, err = pcall(function()
        writefile(UI.ConfigPath(name), HttpService:JSONEncode({ Game = "BloxStrike", Version = 1, Values = values }))
    end)
    return ok, ok and count or err
end

function UI.LoadConfig(name)
    name = UI.CleanName(name)
    if not name then return false, "pick or type a config name" end
    if not UI.HasFiles() then return false, "this executor has no readfile" end
    local path = UI.ConfigPath(name)
    if not isfile(path) then return false, "no config called '" .. name .. "'" end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok or type(data) ~= "table" or type(data.Values) ~= "table" then return false, "file is damaged" end

    local applied = 0
    for _, el in ipairs(UI.Elements or {}) do
        local v = data.Values[el.Key]
        if v ~= nil and pcall(el.Set, v) then applied = applied + 1 end
    end
    return true, applied
end

function UI.DeleteConfig(name)
    name = UI.CleanName(name)
    if not name then return false, "pick a config first" end
    if type(delfile) ~= "function" then return false, "this executor has no delfile" end
    local path = UI.ConfigPath(name)
    if not (isfile and isfile(path)) then return false, "no config called '" .. name .. "'" end
    return pcall(delfile, path)
end

function UI.ListConfigs()
    if type(listfiles) ~= "function" or not UI.HasFiles() then return {} end
    UI.EnsureDirs()
    local names = {}
    local ok, files = pcall(listfiles, UI.ConfigDir)
    for _, path in ipairs(ok and files or {}) do
        local n = tostring(path):match("([^/\\]+)%.json$")
        if n then table.insert(names, n) end
    end
    table.sort(names)
    return names
end

function UI.SetAutoload(name)
    if not UI.HasFiles() then return false, "this executor has no writefile" end
    UI.EnsureDirs()
    name = UI.CleanName(name)
    if name and not isfile(UI.ConfigPath(name)) then return false, "save it first" end
    return pcall(writefile, UI.AutoloadFile, name or "")
end

function UI.Autoload()
    if not UI.HasFiles() or not isfile(UI.AutoloadFile) then return end
    local ok, name = pcall(readfile, UI.AutoloadFile)
    name = ok and UI.CleanName(name) or nil
    if not name then return end
    local loaded, info = UI.LoadConfig(name)
    Notify("Configs", loaded and ("Auto-loaded '" .. name .. "'.") or ("Auto-load failed: " .. tostring(info)), 4)
end

UI.HudFeatures = {
    { "silent aim", "SilentAim" }, { "aimbot", "Aimbot", "AimKey", "AimAlways" },
    { "triggerbot", "Triggerbot", "TriggerKey", "TriggerAlways" }, { "autowall", "TriggerAutowall" },
    { "hold to fire", "AutoPistol" }, { "no recoil", "NoRecoil" }, { "no spread", "NoSpread" },
    { "esp", "ESP" }, { "chams", "ESPChams" }, { "radar", "Radar" }, { "arrows", "OffscreenArrows" },
    { "tracers", "BulletTracers" },
    { "anti-flash", "AntiFlash" }, { "anti-smoke", "AntiSmoke" }, { "nade helper", "NadePreview" },
    { "magic bullet", "MagicBullet", "MagicBulletKey" },
    { "crosshair", "Crosshair" }, { "self chams", "ArmChams" },
}

function UI.UpdateHud()
    local now = os.clock()
    local frames = R.FrameCount or 0
    if UI.HudClock then
        UI.Fps = math.floor((frames - (UI.HudFrames or 0)) / math.max(now - UI.HudClock, 1e-3) + 0.5)
    end
    UI.HudClock, UI.HudFrames = now, frames

    if UI.WatermarkObj then
        local ok, ping = pcall(function() return LocalPlayer:GetNetworkPing() * 1000 end)
        UI.WatermarkObj:SetText(string.format('<font color="#%s">bloxstrike</font> | %d fps | %d ms | %s',
            Obelus:AccentHex(), UI.Fps or 0, ok and math.floor(ping) or 0, os.date("%H:%M")))
    end
    if UI.KeyListObj then
        local items = {}
        for _, f in ipairs(UI.HudFeatures) do
            if S[f[2]] then
                local text = f[1]
                if f[4] and S[f[4]] then
                    text = text .. " [always]"
                elseif f[3] and type(S[f[3]]) == "string" and S[f[3]] ~= "" and S[f[3]] ~= "NONE" then
                    text = text .. " [" .. S[f[3]]:lower() .. "]"
                end
                table.insert(items, text)
            end
        end
        UI.KeyListObj:SetItems(items)
    end
end

local function BuildUI()
    Identity.Restore()
    Obelus:SetAccent(Color3.fromRGB(255, 140, 40))
    local win = Obelus:Window({
        Name = "bloxstrike",
        ToggleKey = S.ToggleKey,
        Size = UDim2.fromOffset(680, 580),
    })
    Window = WrapObelusWindow(win)
    UI.Lib = Window
    UI.Elements = {}
    UI.WatermarkObj = win:Watermark()
    UI.WatermarkObj:SetVisible(S.Watermark)
    UI.KeyListObj = win:ArrayList()
    UI.KeyListObj:SetVisible(S.KeybindList)
    Loop(0.5, function() return UI.WatermarkObj ~= nil end, UI.UpdateHud)

    for _, entry in ipairs({
        { "aim", BuildAimTab }, { "magic bullet", BuildMagicBulletTab }, { "visuals", BuildVisualsTab },
        { "world", BuildWorldTab }, { "look", BuildLookTab },
        { "skins", BuildSkinsTab }, { "settings", BuildSettingsTab },
    }) do
        Identity.Restore()
        local ok, err = pcall(entry[2], Window)
        if not ok then warn("[BS] " .. entry[1] .. " tab failed: " .. tostring(err)) end
    end
    Identity.Restore()

    InstallCombatHooks()
    HookGameEvents()

    Notify("BloxStrike", "Loaded successfully! Toggle menu with " .. S.ToggleKey.Name, 5)

    task.delay(1, function()
        if not R.Unloading then pcall(UI.Autoload) end
    end)
end

GlobalScope.BS_Cleanup = function()
    R.Unloading = true

    for _, conn in ipairs(R.Connections) do
        pcall(function() conn:Disconnect() end)
    end
    table.clear(R.Connections)

    for plr in pairs(R.ESP) do DestroyESP(plr) end
    if AimFOVCircle then pcall(function() AimFOVCircle:Remove() end) end
    if SilentFOVCircle then pcall(function() SilentFOVCircle:Remove() end) end
    for _, d in ipairs(SoundDrawings) do pcall(function() d:Remove() end) end
    for _, d in pairs(WorldDrawings) do pcall(function() d:Remove() end) end
    Overlay.Destroy()
    SafeDestroy(ESPFolder)

    S.AntiFlash, S.AntiSmoke = false, false
    pcall(RefreshAntiFlash)
    pcall(RefreshAntiSmoke)

    RemoveCombatHooks()
    RemoveSkinHooks()

    if R.OrigVIPAmmo ~= nil then
        pcall(function() Workspace:SetAttribute("VIPInfiniteAmmoEnabled", R.OrigVIPAmmo) end)
    end

    Look.Shutdown()

    pcall(function() if Window and Window.Destroy then Window:Destroy() end end)
    GlobalScope.BS_Cleanup = nil
    warn("[BS] Cleanly unloaded.")
end

local ok, err = pcall(BuildUI)
if not ok then
    warn("[BS] UI failed to build: " .. tostring(err))
    pcall(function()
        StarterGui:SetCore("SendNotification", {
            Title = "BloxStrike",
            Text = "UI failed: " .. tostring(err),
            Duration = 8
        })
    end)
    if GlobalScope.BS_Cleanup then GlobalScope.BS_Cleanup() end
end
