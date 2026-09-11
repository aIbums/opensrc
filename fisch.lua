local GlobalScope = (getgenv and getgenv()) or _G or shared

local __DECLARED = {}
for _, n in ipairs({
    "AccentColors", "AccentHex", "AccentOrder", "ActiveFeatures", "AddFakeFish", "ApplyAccent", "ApplyFullbright",
    "ApplyHazards", "ApplyLowGraphics", "ApplyState", "AppraiseHeld", "AppraiseHook", "AppraiseMatches", "AppraiseOnce",
    "AppraiseRunning", "ArrayListObj", "AutoAppraise", "AutoBaitTick", "AutoEnchant", "AutoFinish", "AutoTotemTick",
    "BackpackTools", "BaitFolder", "BaitLibrary", "BaitRarityOrder", "BestBait", "BuildExtrasTab", "BuildFishingTab",
    "BuildPlayerTab", "BuildProgressTab", "BuildSellTab", "BuildSettingsTab", "BuildSpoofTab", "BuildTeleportTab",
    "BuildUI", "BuildWorldTab", "BuildZonesTab", "BuyDailyShop", "CanUseFiles", "CastRF", "Caught", "ClaimAquarium",
    "ClaimCrabCages", "ClaimDaily", "ClaimGroupReward", "ClaimRodJournal", "ClearESP", "CollectMeteor", "CollectionService",
    "ConfigFolder", "ConfigList", "ConfigPath", "ConfigSkip", "Connections", "CurrentEnchant", "CurrentRodName",
    "DailyItems", "DeleteConfig", "DeleteWaypoint", "DiscoverAll", "ESPObjects", "EnchantMatches", "EnchantOnce",
    "EnchantRunning", "EnsureConfigFolder", "EquipBait", "EquipRod", "EventStatus", "Events", "FPS", "FakeFish",
    "FarmKeys", "FavouriteKeepers", "FindAltar", "FindMerchant", "FindMinigameControllers", "FindRelic", "FinishedMinigames",
    "FirePrompt", "FirstPart", "FishByRarity", "FishInfo", "FishLibrary", "FishRarity", "FlyGyro", "FlyVel",
    "FormatSpan", "FrameCount", "GetAutoload", "GetCharacter", "GetDataFolder", "GetEquippedRod", "GetHumanoid",
    "GetKeySignal", "GetPlayerDataRep", "GetReelController", "GetReplicator", "GetRodsKeySignal", "GetRoot",
    "GetShakeButton", "GetStatsFolder", "GoToFishZone", "GuiService", "HandleReel", "HandledReels", "HarpoonController",
    "HazardScripts", "HeldFishItem", "HoldTool", "HopFile", "HopToNext", "HttpRequest", "HttpService", "IsRodTool",
    "IslandList", "KnownZones", "LastMeteor", "LastSell", "LastShake", "LastTotem", "Lighting", "LightingBackup",
    "LoadConfig", "LoadWaypoints", "LocalPlayer", "Loop", "LootMarks", "LowGraphicsOn", "NPCList", "NameOriginals",
    "NameSpoof", "NearestRoamingFish", "NearestZone", "Net", "NextCast", "Notifier", "Notify", "Obelus", "OpenTreasures",
    "OwnedBaitNames", "OwnedBaits", "OwnedBoats", "OwnedRodNames", "PersistWaypoints", "PingMs", "Platform",
    "PlayerGui", "PlayerList", "Players", "QuestTick", "RarityLibrary", "RarityNames", "RarityOrder", "ReadHop",
    "RedeemCode", "RedeemCodes", "ReelController", "Rejoin", "Remote", "RemoveFakeFish", "ReplaceNames", "ReplicatedStorage",
    "Replicators", "RestoreNames", "RestoreRods", "RestoreStat", "RestoreStats", "ResumeEventHop", "RoamMarks",
    "RodLibrary", "RodNames", "RodState", "RodValues", "RunService", "S", "SaveConfig", "SaveWaypoint", "SellAll",
    "SellStorage", "SendWebhook", "ServerHop", "SetAutoFarm", "SetAutoload", "SetFly", "SetPlatform", "ShakeClickButton",
    "ShakeEnterKey", "ShakeRE", "ShakeUIOpen", "SkipSpawns", "Spawn", "SpawnBoat", "SpoofAllRods", "SpoofAnyStat",
    "SpoofConns", "SpoofLevelTag", "SpoofReal", "SpoofRod", "SpoofStat", "SpoofWant", "SpoofedRods", "StabController",
    "StartEventHop", "StarterGui", "StatNames", "Stats", "StopEventHop", "SwapRod", "TeleportService", "TeleportTo",
    "TeleportToZone", "TimeEvents", "TotemNames", "TpSpotList", "Track", "TreasureMaps", "TryCast", "TryShake",
    "TweenService", "UIGen", "UIRefs", "UncaughtFish", "Unloading", "UpdateESP", "UpdateLootESP", "UpdateRoamingESP",
    "Upvalues", "UseTotem", "UserInputService", "VIM", "Vessels", "VirtualUser", "WatchReel", "WatchZones",
    "WatermarkObj", "WaypointFile", "WaypointOrder", "Waypoints", "Window", "WindowTitle", "Workspace", "WrapTab",
    "WrapWindow", "WriteHop", "ZoneFolder", "ZoneList", "ZoneMatching", "err", "ok",
}) do __DECLARED[n] = true end
do
    local outer = getfenv(1)
    setfenv(1, setmetatable({}, {
        __index = function(_, k)
            if __DECLARED[k] then return nil end
            return outer[k]
        end,
    }))
end

if type(GlobalScope.Fisch_Cleanup) == "function" then
    pcall(GlobalScope.Fisch_Cleanup)
end

Players           = game:GetService("Players")
RunService        = game:GetService("RunService")
UserInputService  = game:GetService("UserInputService")
ReplicatedStorage = game:GetService("ReplicatedStorage")
Workspace         = game:GetService("Workspace")
Lighting          = game:GetService("Lighting")
VirtualUser       = game:GetService("VirtualUser")
StarterGui        = game:GetService("StarterGui")
GuiService        = game:GetService("GuiService")
TeleportService   = game:GetService("TeleportService")
HttpService       = game:GetService("HttpService")
VIM               = game:GetService("VirtualInputManager")
CollectionService = game:GetService("CollectionService")

LocalPlayer = Players.LocalPlayer
PlayerGui   = LocalPlayer:WaitForChild("PlayerGui")

S = {
    AutoEquip      = false,
    AutoCast       = false,
    PerfectCast    = true,
    CastPowerMin   = 85,
    CastDelay      = 0.6,
    AutoShake      = false,
    ShakeMethod    = "Enter Key",
    ShakeInterval  = 0,
    AutoReel       = false,
    ReelMode       = "Instant",
    InstantDelay   = 0,
    FollowSmooth   = 0,
    CatchLog       = {},
    HookNotify     = true,
    AnchorFishing  = false,
    RapidMode      = false,
    StopOnRare     = false,
    StopRarity     = "Mythical",

    AutoBait       = false,
    BaitChoice     = "Best Available",

    AutoCrab       = false,
    CrabTP         = true,
    MeteorNotify   = true,
    AutoMeteor     = false,
    MeteorReturn   = true,
    LootESP        = false,
    NoHazards      = false,
    EventNotify    = true,
    WebhookURL     = "",
    WebhookRarity  = "Mythical",

    ZoneNotify     = true,
    WaterPlatform  = false,

    AutoSell       = false,
    SellMethod     = "Direct (no teleport)",
    SellInterval   = 5,
    KeepRares      = true,
    KeepRarity     = "Legendary",
    NotifyRarity   = "Trash",
    AutoDaily      = false,

    ClickTP        = false,
    TPMode         = "Instant",
    TweenSpeed     = 250,
    AutoEventZone  = false,

    WalkSpeedOn    = false,
    WalkSpeed      = 32,
    InfiniteJump   = false,
    Noclip         = false,
    Fly            = false,
    FlySpeed       = 60,

    Fullbright     = false,
    PlayerESP      = false,

    EnchantMethod  = "Altar",
    EnchantTarget  = "",
    EnchantMaxTries = 50,
    AppraiseMethod = "Appraiser NPC",
    AppraiseMutation = "",
    AppraiseAnyMutation = true,
    AppraiseMinWeight = 0,
    AppraiseMaxTries = 30,
    AutoQuests     = false,
    AutoAcceptQuests = false,
    BestiaryRarity = "Rare",

    KeepMutated    = true,
    AutoDailyShop  = false,
    DailyMaxPrice  = 5000,
    AutoAquarium   = false,

    HopKeyword     = "",
    HopMax         = 25,
    HopStartFarm   = true,
    HopLoader      = 'loadstring(readfile("fisch.lua"))()',
    AutoTotem      = false,
    TotemChoice    = "",
    TotemWhen      = "When Night",
    TotemEvery     = 15,

    AutoSpear      = false,
    AutoHarpoon    = false,
    MinigameDelay  = 0,
    RoamingESP     = false,
    RoamingMinRarity = "Legendary",
    LowGraphics    = false,
    Accent         = "Purple",
    ArrayList      = true,

    Disable3D      = false,
    AutoRejoin     = false,
    Watermark      = true,
    StreamerMode   = false,
    FarmKey        = Enum.KeyCode.F6,
    PanicKey       = Enum.KeyCode.End,
    AntiAFK        = true,
    Notifications  = true,
    ToggleKey      = Enum.KeyCode.RightShift,
}

RodState = {
    Destroyed = 0, Unequipped = 1, Equipping = 2, Equipped = 3, Casting = 4,
    Searching = 5, Luring = 6, PreReel = 7, Reeling = 8, CatchFinished = 9,
}

Connections = {}
Unloading   = false
Stats       = { Casts = 0, Catches = 0, Shakes = 0, Started = tick(), ByRarity = {} }

function Track(conn)
    if conn then table.insert(Connections, conn) end
    return conn
end

function Spawn(fn)
    return task.spawn(function()
        local ok, err = pcall(fn)
        if not ok and not Unloading then warn("[Fisch] thread error: " .. tostring(err)) end
    end)
end

function Loop(interval, cond, fn)
    return Spawn(function()
        while not Unloading do
            if cond() then
                local ok, err = pcall(fn)
                if not ok then warn("[Fisch] loop error: " .. tostring(err)) end
            end
            task.wait(type(interval) == "function" and interval() or interval)
        end
    end)
end

Notifier = nil
SendWebhook = nil
SetAutoFarm = nil

function Notify(title, content, duration)
    if not S.Notifications then return end
    if Notifier then
        Notifier:Notify({ Title = title or "Fisch", Content = content or "", Duration = duration or 3 })
    else
        pcall(function()
            StarterGui:SetCore("SendNotification", { Title = title or "Fisch", Text = content or "", Duration = duration or 3 })
        end)
    end
end

function GetCharacter() return LocalPlayer.Character end
function GetHumanoid()
    local c = GetCharacter()
    return c and c:FindFirstChildOfClass("Humanoid")
end
function GetRoot()
    local c = GetCharacter()
    return c and c:FindFirstChild("HumanoidRootPart")
end

TweenService = game:GetService("TweenService")

function TeleportTo(cf)
    local root = GetRoot()
    if not root then return false end
    pcall(function() LocalPlayer:RequestStreamAroundAsync(cf.Position, 2) end)
    root.AssemblyLinearVelocity = Vector3.zero
    local dist = (root.Position - cf.Position).Magnitude
    if S.TPMode == "Tween" and dist > 15 then
        local wasAnchored = root.Anchored
        root.Anchored = true
        local tween = TweenService:Create(root, TweenInfo.new(dist / math.max(S.TweenSpeed, 1), Enum.EasingStyle.Linear), { CFrame = cf })
        tween:Play()
        tween.Completed:Wait()
        root.Anchored = wasAnchored
    else
        root.CFrame = cf
    end
    return true
end

Net    = ReplicatedStorage:WaitForChild("packages"):WaitForChild("Net")
Events = ReplicatedStorage:WaitForChild("events")

function Remote(path) return Net:FindFirstChild(path) end

CastRF  = Remote("RF/FishingRod/Cast")
ShakeRE = Remote("RE/LureShake/Shake")

FishLibrary = nil
pcall(function() FishLibrary = require(ReplicatedStorage.shared.modules.library.fish) end)

RodLibrary = nil
pcall(function() RodLibrary = require(ReplicatedStorage.shared.modules.library.rods) end)

RarityLibrary = nil
pcall(function() RarityLibrary = require(ReplicatedStorage.shared.modules.library.rarities).Rarities end)

function RarityOrder(name)
    local r = RarityLibrary and RarityLibrary[name]
    return r and r.Order or 0
end

function RarityNames()
    local out = {}
    if RarityLibrary then
        for name, def in pairs(RarityLibrary) do
            if type(name) == "string" and type(def) == "table" and def.Order then table.insert(out, name) end
        end
    end
    table.sort(out, function(a, b) return RarityOrder(a) < RarityOrder(b) end)
    if #out == 0 then out = { "Common", "Rare", "Legendary", "Mythical", "Exotic", "Secret" } end
    return out
end

FakeFish = {}

Replicators = {}
function GetReplicator(id)
    local rep = Replicators[id]
    if rep and type(rawget(rep, "Data")) == "table" then return rep end
    if not getgc then return nil end
    for _, v in ipairs(getgc(true)) do
        if type(v) == "table" and rawget(v, "Id") == id
            and type(rawget(v, "_signal_descendants")) == "table"
            and type(rawget(v, "Data")) == "table" then
            Replicators[id] = v
            return v
        end
    end
end

ReelController = nil
function GetReelController()
    if ReelController then return ReelController end
    if getgc then
        pcall(function()
            for _, v in ipairs(getgc(true)) do
                if type(v) == "table" and rawget(v, "type") == "reel"
                    and type(rawget(v, "StartReel")) == "function"
                    and type(rawget(v, "EndMinigame")) == "function" then
                    ReelController = v
                    break
                end
            end
        end)
    end
    if not ReelController then
        pcall(function()
            ReelController = require(ReplicatedStorage.client.legacyControllers.ReelController)
        end)
    end
    return ReelController
end

function IsRodTool(tool)
    if not (tool and tool:IsA("Tool")) then return false end
    local values = tool:FindFirstChild("values")
    if values and values:FindFirstChild("state") then return true end
    return RodLibrary ~= nil and RodLibrary[tool.Name] ~= nil
end

function GetEquippedRod()
    local char = GetCharacter()
    if not char then return nil end
    for _, t in ipairs(char:GetChildren()) do
        if IsRodTool(t) then return t end
    end
end

function EquipRod()
    local hum = GetHumanoid()
    local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
    if not (hum and bp) then return false end
    for _, t in ipairs(bp:GetChildren()) do
        if IsRodTool(t) then
            hum:EquipTool(t)
            return true
        end
    end
    return false
end

function RodValues(rod)
    local values = rod and rod:FindFirstChild("values")
    if not values then return nil end
    return values:FindFirstChild("state"), values:FindFirstChild("casted")
end

function ShakeUIOpen()
    return PlayerGui:FindFirstChild("shakeui") ~= nil
end

function FishRarity(name)
    local entry = FishLibrary and FishLibrary[name]
    return entry and entry.Rarity or "?"
end

NextCast = 0

function TryCast()
    local rod = GetEquippedRod()
    if not rod then
        if S.AutoEquip then EquipRod() end
        return
    end

    local state, casted = RodValues(rod)
    if not state then return end
    if state.Value ~= RodState.Equipped or (casted and casted.Value) then return end
    if tick() < NextCast or ShakeUIOpen() then return end

    local rc = GetReelController()
    if rc and rc.ActiveReel then return end

    local hum = GetHumanoid()
    if not hum or hum.Health <= 0 or hum:GetState() == Enum.HumanoidStateType.Swimming then return end
    if LocalPlayer:GetAttribute("BlockCast") or LocalPlayer:GetAttribute("RodEquipInProgress") then return end

    local power = S.PerfectCast and math.random(970, 1000) / 10 or math.random(S.CastPowerMin * 10, 1000) / 10
    local perfect = S.PerfectCast and power >= 93

    NextCast = tick() + (S.RapidMode and 0 or (S.CastDelay + math.random() * 0.4))
    GetCharacter():SetAttribute("Fishing", true)
    local ok, res = pcall(function() return CastRF:InvokeServer(power, perfect) end)
    if ok and res then
        Stats.Casts = Stats.Casts + 1
    else
        GetCharacter():SetAttribute("Fishing", nil)
    end
end

function GetShakeButton()
    local ui = PlayerGui:FindFirstChild("shakeui")
    local zone = ui and ui:FindFirstChild("safezone")
    return zone and zone:FindFirstChildWhichIsA("GuiButton")
end

function ShakeEnterKey()
    VIM:SendKeyEvent(true, Enum.KeyCode.Return, false, game)
    task.wait()
    VIM:SendKeyEvent(false, Enum.KeyCode.Return, false, game)
end

function ShakeClickButton()
    local btn = GetShakeButton()
    if not btn then return end
    if getconnections then
        local fired = false
        for _, c in ipairs(getconnections(btn.Activated)) do
            pcall(function() c:Fire() end)
            fired = true
        end
        if fired then return end
    end
    if firesignal then
        firesignal(btn.Activated)
        return
    end
    local pos = btn.AbsolutePosition + btn.AbsoluteSize / 2
    local ui = btn:FindFirstAncestorWhichIsA("ScreenGui")
    if ui and not ui.IgnoreGuiInset then pos = pos + GuiService:GetGuiInset() end
    VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, true, game, 0)
    task.wait()
    VIM:SendMouseButtonEvent(pos.X, pos.Y, 0, false, game, 0)
end

ShakeCooldownSlot = { fn = nil, index = nil, button = nil }

function FindShakeCooldown()
    local btn = GetShakeButton()
    if not btn then return nil end
    local slot = ShakeCooldownSlot
    if slot.button == btn and slot.fn then return slot end
    slot.button, slot.fn, slot.index = btn, nil, nil
    if not getconnections then return nil end
    for _, c in ipairs(getconnections(btn.Activated)) do
        local fn = c.Function
        if type(fn) == "function" then
            local now = tick()
            local ups = Upvalues(fn)
            for i, v in pairs(ups) do
                if type(v) == "number" and math.abs(now - v) < 120 then
                    slot.fn, slot.index = fn, i
                    local cd = type(i) == "number" and ups[i + 1]
                    slot.cooldown = (type(cd) == "number" and cd > 0.01 and cd < 3) and cd or nil
                    return slot
                end
            end
        end
    end
    return nil
end

function GameShakeCooldown()
    local slot = FindShakeCooldown()
    return (slot and slot.cooldown) or 0.25
end

function ShakeGateOpen()
    local get = (debug and debug.getupvalue) or getupvalue
    local slot = FindShakeCooldown()
    if not (get and slot and slot.fn and type(slot.index) == "number") then return nil end
    local ok, last = pcall(get, slot.fn, slot.index)
    if not (ok and type(last) == "number") then return nil end
    return tick() - last > (slot.cooldown or 0.25)
end

LastShake = 0
function TryShake()
    if not ShakeUIOpen() then return end
    if UserInputService:GetFocusedTextBox() then return end
    local gate = ShakeGateOpen()
    if gate == false then return end
    local interval = S.ShakeInterval
    if S.ShakeMethod == "Remote" then
        interval = math.max(interval, GameShakeCooldown() + 0.03)
    elseif gate == nil then
        interval = math.max(interval, 0.05)
    end
    if tick() - LastShake < interval then return end
    LastShake = tick()
    if S.ShakeMethod == "Enter Key" then
        ShakeEnterKey()
    elseif S.ShakeMethod == "Click Button" then
        ShakeClickButton()
    else
        ShakeRE:FireServer()
    end
    Stats.Shakes = Stats.Shakes + 1
end

HandledReels = setmetatable({}, { __mode = "k" })

function HandleReel(reel)
    if HandledReels[reel] then return end
    HandledReels[reel] = true

    local fishName = reel.fish and reel.fish.Name or "?"
    if S.HookNotify and RarityOrder(FishRarity(fishName)) >= RarityOrder(S.NotifyRarity) then
        Notify("Hooked", fishName .. "  [" .. tostring(FishRarity(fishName)) .. "]", 3)
    end

    table.insert(S.CatchLog, 1, ("%s [%s]"):format(fishName, tostring(FishRarity(fishName))))
    if #S.CatchLog > 8 then table.remove(S.CatchLog) end
    if SendWebhook then pcall(SendWebhook, fishName, tostring(FishRarity(fishName))) end

    local rarity = tostring(FishRarity(fishName))
    Stats.ByRarity[rarity] = (Stats.ByRarity[rarity] or 0) + 1
    if S.StopOnRare and RarityOrder(rarity) >= RarityOrder(S.StopRarity) and SetAutoFarm then
        Spawn(function()
            reel.Destroying:Wait()
            SetAutoFarm(false)
            Notify("Stopped", "Hooked " .. fishName .. " [" .. rarity .. "] — Auto Farm paused.", 8)
        end)
    end

    if S.RapidMode then reel.cleanup_delay = 0.05 end

    if not S.AutoReel then return end

    if S.ReelMode == "Follow Fish" then
        pcall(function()
            local rodCore = reel.core.rod
            local origTick = rodCore.Tick
            rodCore.Tick = function(self, dt)
                pcall(origTick, self, dt)
                local r = self.current
                if not (r and r.active) then return end
                local target = r.fishPosition
                if S.FollowSmooth > 0 then
                    local alpha = math.clamp(dt * (20 / S.FollowSmooth), 0, 1)
                    r.barPosition = r.barPosition + (target - r.barPosition) * alpha
                else
                    r.barPosition = target
                end
            end
        end)
    else
        pcall(function() reel:AddModifier("barSize", "force_final", 1) end)
    end

    if S.ReelMode == "Instant" then
        Spawn(function()
            local char = GetCharacter()
            local deadline = tick() + 5
            while char and not char:GetAttribute("Reeling") and tick() < deadline and not Unloading do
                task.wait()
            end
            if not reel.loaded and reel.OnLoad then reel.OnLoad:Wait() end
            if S.InstantDelay > 0 and not S.RapidMode then task.wait(S.InstantDelay) end
            if S.RapidMode then reel.cleanup_delay = 0.05 end
            local rc = GetReelController()
            if not Unloading and reel.reel and rc and rc.ActiveReel == reel then
                pcall(function() reel.core.minigame.Disabled = true end)
                reel:EndMinigame(true)
            end
        end)
    end

    Spawn(function()
        reel.Destroying:Wait()
        Stats.Catches = Stats.Catches + 1
    end)
end

function WatchReel()
    local rc = GetReelController()
    local reel = rc and rc.ActiveReel
    if reel and reel.active ~= nil then HandleReel(reel) end
end

function FindMerchant()
    local npcs = Workspace:FindFirstChild("world") and Workspace.world:FindFirstChild("npcs")
    if not npcs then return nil end
    local best = npcs:FindFirstChild("Marc Merchant")
    if best then return best end
    for _, m in ipairs(npcs:GetDescendants()) do
        if m:IsA("Model") and m.Name:lower():find("merchant") and not m.Name:lower():find("skin")
            and m:FindFirstChild("HumanoidRootPart") then
            return m
        end
    end
end

function FavouriteKeepers()
    local inv = GetReplicator("PlayerInventory")
    local items = inv and inv.Data and inv.Data.Inventory
    local fav = Remote("RE/Backpack/Favourite")
    if not (items and fav and FishLibrary) then return 0 end
    local minOrder = RarityOrder(S.KeepRarity)
    local n = 0
    for id, item in pairs(items) do
        local def = type(item) == "table" and item.name and FishLibrary[item.name]
        local keep = def and (RarityOrder(def.Rarity) >= minOrder or (S.KeepMutated and item.sub and item.sub.Mutation ~= nil))
        if keep and not FakeFish[id] and not (item.sub and item.sub.Favourited) then
            fav:FireServer(id, true)
            n = n + 1
            task.wait(0.05)
        end
    end
    return n
end

function SellAll()
    if S.KeepRares then
        local n = FavouriteKeepers()
        if n > 0 then Notify("Sell", "Protected " .. n .. " fish (" .. S.KeepRarity .. "+).", 3) task.wait(0.3) end
    end

    if S.SellMethod == "Sell Anywhere (gamepass)" then
        local ok, res = pcall(function() return Events.selleverything:InvokeServer() end)
        Notify("Sell", ok and res and "Sold everything." or "Nothing sold (need the Sell Anywhere pass).", 3)
        return
    end

    if S.SellMethod == "Direct (no teleport)" then
        local ok, res = pcall(function() return Events.SellAll:InvokeServer() end)
        if ok and res then
            Notify("Sell", "Sold. " .. (type(res) == "number" and ("+" .. res .. " C$") or ""), 3)
        else
            Notify("Sell", "Server refused a remote sell (" .. tostring(res) .. "). Use Merchant Teleport.", 5)
        end
        return
    end

    local merchant = FindMerchant()
    local root = GetRoot()
    local mroot = merchant and (merchant:FindFirstChild("HumanoidRootPart") or merchant.PrimaryPart)
    if not (root and mroot) then
        Notify("Sell", "Merchant not found.", 3)
        return
    end

    local back = root.CFrame
    TeleportTo(mroot.CFrame * CFrame.new(0, 0, -4) * CFrame.Angles(0, math.pi, 0))
    task.wait(0.6)
    local ok, res = pcall(function() return Events.SellAll:InvokeServer() end)
    task.wait(0.3)
    TeleportTo(back)
    Notify("Sell", ok and ("Sold. " .. (type(res) == "number" and ("+" .. res .. " C$") or "")) or ("Sell failed: " .. tostring(res)), 3)
end

function ClaimDaily()
    local re = Remote("RE/DailyReward/Claim")
    if re then re:FireServer() end
end

function ClaimGroupReward()
    local re = Events:FindFirstChild("claimGroupReward")
    if re then re:FireServer() end
end

function AppraiseHeld()
    local rf = Remote("RF/AppraiseAnywhere/Fire")
    if not rf then return end
    local ok, a, b = pcall(function() return rf:InvokeServer() end)
    Notify("Appraise", ok and tostring(b or a or "done") or ("failed: " .. tostring(a)), 4)
end

SkipSpawns = { loading = true, TeleportDelay = true, TpSpots = true }

function FirstPart(inst)
    if inst:IsA("BasePart") then return inst end
    if inst:IsA("Model") and inst.PrimaryPart then return inst.PrimaryPart end
    return inst:FindFirstChild("HumanoidRootPart") or inst:FindFirstChildWhichIsA("BasePart", true)
end

function IslandList()
    local out, map = {}, {}
    local spawns = Workspace:FindFirstChild("world") and Workspace.world:FindFirstChild("spawns")
    if spawns then
        for _, f in ipairs(spawns:GetChildren()) do
            if not SkipSpawns[f.Name] and not map[f.Name] then
                local p = FirstPart(f)
                if p then map[f.Name] = p; table.insert(out, f.Name) end
            end
        end
    end
    table.sort(out)
    return out, map
end

function NPCList()
    local out, map = {}, {}
    local npcs = Workspace:FindFirstChild("world") and Workspace.world:FindFirstChild("npcs")
    if npcs then
        for _, m in ipairs(npcs:GetDescendants()) do
            if m:IsA("Model") and m:FindFirstChild("HumanoidRootPart") and not map[m.Name] then
                map[m.Name] = m.HumanoidRootPart
                table.insert(out, m.Name)
            end
        end
    end
    table.sort(out)
    return out, map
end

function TpSpotList()
    local out, map = {}, {}
    local spawns = Workspace:FindFirstChild("world") and Workspace.world:FindFirstChild("spawns")
    local pads = spawns and spawns:FindFirstChild("TpSpots")
    if pads then
        for _, p in ipairs(pads:GetChildren()) do
            if p:IsA("BasePart") and not map[p.Name] then
                map[p.Name] = p
                table.insert(out, p.Name)
            end
        end
    end
    table.sort(out)
    return out, map
end

function PlayerList()
    local out = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then table.insert(out, p.Name) end
    end
    table.sort(out)
    return out
end

Waypoints, WaypointOrder = {}, {}

WaypointFile = "fisch_hub/waypoints.json"

function PersistWaypoints()
    if not writefile then return end
    local out = {}
    for _, name in ipairs(WaypointOrder) do
        local cf = Waypoints[name]
        if cf then out[#out + 1] = { name = name, cf = { cf:GetComponents() } } end
    end
    pcall(function()
        if makefolder and not (isfolder and isfolder("fisch_hub")) then makefolder("fisch_hub") end
        writefile(WaypointFile, HttpService:JSONEncode(out))
    end)
end

function LoadWaypoints()
    local ok, data = pcall(function()
        return isfile and isfile(WaypointFile) and HttpService:JSONDecode(readfile(WaypointFile))
    end)
    if not (ok and type(data) == "table") then return end
    for _, w in ipairs(data) do
        if type(w.name) == "string" and type(w.cf) == "table" and #w.cf == 12 and not Waypoints[w.name] then
            Waypoints[w.name] = CFrame.new(table.unpack(w.cf))
            table.insert(WaypointOrder, w.name)
        end
    end
end
LoadWaypoints()

function SaveWaypoint(name)
    local root = GetRoot()
    if not root then return false end
    name = (name and name ~= "") and name or ("Waypoint " .. (#WaypointOrder + 1))
    if not Waypoints[name] then table.insert(WaypointOrder, name) end
    Waypoints[name] = root.CFrame
    PersistWaypoints()
    return name
end

function DeleteWaypoint(name)
    if not Waypoints[name] then return end
    Waypoints[name] = nil
    local i = table.find(WaypointOrder, name)
    if i then table.remove(WaypointOrder, i) end
    PersistWaypoints()
end

function NearestZone()
    local root = GetRoot()
    local zones = Workspace:FindFirstChild("zones")
    local folder = zones and zones:FindFirstChild("fishing")
    if not (root and folder) then return nil end
    local best, bestDist = nil, math.huge
    for _, z in ipairs(folder:GetChildren()) do
        if z:IsA("BasePart") then
            local d = (z.Position - root.Position).Magnitude
            if d < bestDist then best, bestDist = z, d end
        end
    end
    return best
end

Track(UserInputService.InputBegan:Connect(function(input, processed)
    if processed or not S.ClickTP then return end
    if input.UserInputType ~= Enum.UserInputType.MouseButton1 then return end
    if not UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then return end
    local mouse = LocalPlayer:GetMouse()
    if mouse.Hit then TeleportTo(CFrame.new(mouse.Hit.Position + Vector3.new(0, 3, 0))) end
end))

function ZoneFolder()
    local zones = Workspace:FindFirstChild("zones")
    return zones and zones:FindFirstChild("fishing")
end

function ZoneList()
    local out, map = {}, {}
    local folder = ZoneFolder()
    if folder then
        for _, z in ipairs(folder:GetChildren()) do
            if z:IsA("BasePart") and not map[z.Name] then
                map[z.Name] = z
                table.insert(out, z.Name)
            end
        end
    end
    table.sort(out)
    return out, map
end

Platform = nil

function SetPlatform(on)
    if not on then
        if Platform then Platform:Destroy() Platform = nil end
        return
    end
    if Platform and Platform.Parent then return end
    Platform = Instance.new("Part")
    Platform.Name = "FischPlatform"
    Platform.Size = Vector3.new(10, 1, 10)
    Platform.Anchored = true
    Platform.Transparency = 0.6
    Platform.Material = Enum.Material.ForceField
    Platform.Color = Color3.fromRGB(60, 170, 255)
    Platform.Parent = Workspace
end

function TeleportToZone(zone)
    local top = zone.Position + Vector3.new(0, zone.Size.Y / 2, 0)
    local params = RaycastParams.new()
    params.FilterType = Enum.RaycastFilterType.Exclude
    params.FilterDescendantsInstances = { GetCharacter(), Platform }
    local ray = Workspace:Raycast(top + Vector3.new(0, 200, 0), Vector3.new(0, -400, 0), params)
    local surfaceY = ray and ray.Position.Y or top.Y
    S.WaterPlatform = true
    SetPlatform(true)
    Platform.CFrame = CFrame.new(zone.Position.X, surfaceY + 0.5, zone.Position.Z)
    TeleportTo(CFrame.new(zone.Position.X, surfaceY + 4, zone.Position.Z))
end

KnownZones = {}
function WatchZones()
    local folder = ZoneFolder()
    if not folder then return end
    for _, z in ipairs(folder:GetChildren()) do KnownZones[z.Name] = true end
    Track(folder.ChildAdded:Connect(function(z)
        if KnownZones[z.Name] then return end
        KnownZones[z.Name] = true
        if S.ZoneNotify then Notify("New Zone", z.Name .. " appeared — check the Zones tab.", 6) end
        if S.AutoEventZone and z:IsA("BasePart") then
            Spawn(function()
                local rc = GetReelController()
                local t0 = tick()
                while ((rc and rc.ActiveReel) or ShakeUIOpen()) and tick() - t0 < 30 do task.wait(0.5) end
                if z.Parent then
                    TeleportToZone(z)
                    Notify("Event Zone", "Moved to " .. z.Name, 4)
                end
            end)
        end
    end))
end

function GetStatsFolder()
    local ps = Workspace:FindFirstChild("PlayerStats")
    local m = ps and ps:FindFirstChild(LocalPlayer.Name)
    local t = m and m:FindFirstChild("T")
    local f = t and t:FindFirstChild(LocalPlayer.Name)
    return f and f:FindFirstChild("Stats")
end

SpoofWant, SpoofReal, SpoofConns = {}, {}, {}

function SpoofStat(name, value)
    local stats = GetStatsFolder()
    local v = stats and stats:FindFirstChild(name)
    if not v then return false end
    if SpoofReal[name] == nil then SpoofReal[name] = v.Value end
    SpoofWant[name] = value
    v.Value = value
    if not SpoofConns[name] then
        SpoofConns[name] = Track(v.Changed:Connect(function()
            local want = SpoofWant[name]
            if want ~= nil and v.Value ~= want then
                SpoofReal[name] = v.Value
                v.Value = want
            end
        end))
    end
    return true
end

function RestoreStats()
    local stats = GetStatsFolder()
    for name, real in pairs(SpoofReal) do
        SpoofWant[name] = nil
        local v = stats and stats:FindFirstChild(name)
        if v then pcall(function() v.Value = real end) end
    end
    table.clear(SpoofReal)
end

SpoofLevelTag = nil
Track(RunService.Heartbeat:Connect(function()
    if not SpoofLevelTag then return end
    local char = GetCharacter()
    if not char then return end
    for _, d in ipairs(char:GetDescendants()) do
        if d:IsA("TextLabel") and d.Text:match("^Level:?%s*%d+") then
            local want = "Level: " .. SpoofLevelTag
            if d.Text ~= want then d.Text = want end
        end
    end
end))

function GetPlayerDataRep() return GetReplicator("PlayerData") end

function Upvalues(fn)
    local many = (debug and debug.getupvalues) or getupvalues
    if many then
        local ok, t = pcall(many, fn)
        if ok and type(t) == "table" then return t end
    end
    local one = (debug and debug.getupvalue) or getupvalue
    local out = {}
    if one then
        for i = 1, 16 do
            local ok, v = pcall(one, fn, i)
            if not ok then break end
            out[i] = v
        end
    end
    return out
end

function GetKeySignal(rep, key)
    local orig
    for _, v in pairs(Upvalues(rawget(rep, "ObserveKeys"))) do
        if type(v) == "function" then orig = v end
    end
    if not orig then return nil end
    local node = rep._signal_descendants[key]
    if not node then return nil end
    for _, v in pairs(Upvalues(orig)) do
        if type(v) == "table" and v ~= rep and node[v] and node[v].signal then
            return node[v].signal
        end
    end
end

function GetRodsKeySignal(rep) return GetKeySignal(rep, "Rods") end

SpoofedRods = {}

function SpoofRod(name)
    local rep = GetPlayerDataRep()
    if not (rep and rep.Data.Rods) then return false, "PlayerData replicator not found" end
    if rep.Data.Rods[name] then return false, "already owned" end
    local entry = { caught = 0, enchant = "none", favorited = false, secondaryEnchant = "none", skin = "Default" }
    rep.Data.Rods[name] = entry
    SpoofedRods[name] = true
    local sig = GetRodsKeySignal(rep)
    if sig then pcall(function() sig:Fire(name, entry) end) end
    return true, sig and "added" or "added (reopen Equipment to refresh)"
end

function RodNames()
    local out = {}
    if RodLibrary then
        for name, def in pairs(RodLibrary) do
            if type(name) == "string" and type(def) == "table" and not def.DEV and not def.Unregistered then
                table.insert(out, name)
            end
        end
    end
    table.sort(out)
    return out
end

function SpoofAllRods()
    local n = 0
    for _, name in ipairs(RodNames()) do
        if SpoofRod(name) then n = n + 1 end
    end
    return n
end

function RestoreRods()
    local rep = GetPlayerDataRep()
    if not rep then return end
    local sig = GetRodsKeySignal(rep)
    for name in pairs(SpoofedRods) do
        rep.Data.Rods[name] = nil
        if sig then pcall(function() sig:Fire(name, nil) end) end
    end
    table.clear(SpoofedRods)
end

function StatNames()
    local out = {}
    local st = GetStatsFolder()
    if st then
        for _, v in ipairs(st:GetChildren()) do
            if (v:IsA("NumberValue") or v:IsA("IntValue") or v:IsA("StringValue")) and v.Name ~= "newdata" then
                table.insert(out, v.Name)
            end
        end
    end
    table.sort(out)
    return out
end

function SpoofAnyStat(name, raw)
    local st = GetStatsFolder()
    local v = st and st:FindFirstChild(name)
    if not v then return false end
    local value = v:IsA("StringValue") and tostring(raw) or tonumber(raw)
    if value == nil then return false end
    return SpoofStat(name, value)
end

function RestoreStat(name)
    local real = SpoofReal[name]
    SpoofWant[name] = nil
    SpoofReal[name] = nil
    local st = GetStatsFolder()
    local v = st and st:FindFirstChild(name)
    if v and real ~= nil then pcall(function() v.Value = real end) end
end

NameSpoof = nil
NameOriginals = setmetatable({}, { __mode = "k" })

function ReplaceNames(root)
    if not (root and NameSpoof) then return end
    local escapedSpoof = NameSpoof:gsub("%%", "%%%%")
    for _, d in ipairs(root:GetDescendants()) do
        if (d:IsA("TextLabel") or d:IsA("TextButton")) and not d.Text:find(NameSpoof, 1, true) then
            local new = d.Text
            for _, real in ipairs({ LocalPlayer.Name, LocalPlayer.DisplayName }) do
                new = new:gsub((real:gsub("%p", "%%%0")), escapedSpoof)
            end
            if new ~= d.Text then
                if NameOriginals[d] == nil then NameOriginals[d] = d.Text end
                d.Text = new
            end
        end
    end
end

function RestoreNames()
    NameSpoof = nil
    for label, original in pairs(NameOriginals) do
        pcall(function() label.Text = original end)
    end
    table.clear(NameOriginals)
end

function FishByRarity(rarity)
    local out = {}
    if FishLibrary then
        for name, def in pairs(FishLibrary) do
            if type(name) == "string" and type(def) == "table" and def.Rarity == rarity then table.insert(out, name) end
        end
    end
    table.sort(out)
    return out
end

function AddFakeFish(name, weight, count)
    local rep = GetReplicator("PlayerInventory")
    local inv = rep and rep.Data.Inventory
    if not inv then return 0, "inventory replicator not found" end
    local sig = GetKeySignal(rep, "Inventory")
    local n = 0
    for _ = 1, math.clamp(count or 1, 1, 50) do
        local id = HttpService:GenerateGUID(false)
        local entry = { name = name, sub = { Weight = weight, Stack = 1 } }
        inv[id] = entry
        FakeFish[id] = true
        if sig then pcall(function() sig:Fire(id, entry) end) end
        n = n + 1
    end
    return n, sig and "added" or "added (reopen your backpack)"
end

function RemoveFakeFish()
    local rep = GetReplicator("PlayerInventory")
    local inv = rep and rep.Data.Inventory
    local sig = rep and GetKeySignal(rep, "Inventory")
    for id in pairs(FakeFish) do
        if inv then inv[id] = nil end
        if sig then pcall(function() sig:Fire(id, nil) end) end
    end
    table.clear(FakeFish)
end

BaitLibrary = nil
pcall(function() BaitLibrary = require(ReplicatedStorage.shared.modules.library.bait) end)

function BaitFolder()
    local st = GetStatsFolder()
    return st and st:FindFirstChild("bait")
end

function OwnedBaits()
    local out = {}
    local f = BaitFolder()
    if f then
        for _, c in ipairs(f:GetChildren()) do
            local name = c.Name:match("^bait_(.+)$")
            if name and tonumber(c.Value) and c.Value > 0 then out[name] = c.Value end
        end
    end
    return out
end

function BaitRarityOrder(name)
    local def = BaitLibrary and BaitLibrary[name]
    return def and RarityOrder(def.Rarity) or 0
end

function BestBait()
    local best, bestOrder = nil, -1
    for name in pairs(OwnedBaits()) do
        local ord = BaitRarityOrder(name)
        if ord > bestOrder then best, bestOrder = name, ord end
    end
    return best
end

function OwnedBaitNames()
    local out = { "Best Available" }
    local names = {}
    for name in pairs(OwnedBaits()) do table.insert(names, name) end
    table.sort(names, function(a, b) return BaitRarityOrder(a) > BaitRarityOrder(b) end)
    for _, n in ipairs(names) do table.insert(out, n) end
    return out
end

function EquipBait(name)
    local re = Remote("RE/Bait/Equip")
    if re and name then re:FireServer(name) end
end

function AutoBaitTick()
    local f = BaitFolder()
    if not f then return end
    local owned = OwnedBaits()
    local want = (S.BaitChoice ~= "Best Available" and owned[S.BaitChoice]) and S.BaitChoice or BestBait()
    if want and f.Value ~= want then EquipBait(want) end
end

function ClaimCrabCages()
    local rep = GetReplicator("PlayerData")
    local cages = rep and rep.Data.CrabCages
    local rf = Remote("RF/CrabCage/Claim")
    if not (cages and rf) then return 0 end
    local n = 0
    for id, cage in pairs(cages) do
        if type(cage) == "table" and cage.s == 2 then
            local ok, res = pcall(function() return rf:InvokeServer(id) end)
            if not (ok and res) and S.CrabTP then
                local active = Workspace:FindFirstChild("active")
                local folder = active and active:FindFirstChild("crabcages")
                local model = folder and folder:FindFirstChild(id)
                local root = GetRoot()
                if model and root then
                    local back = root.CFrame
                    TeleportTo(model:GetPivot() + Vector3.new(0, 4, 0))
                    task.wait(0.5)
                    ok, res = pcall(function() return rf:InvokeServer(id) end)
                    TeleportTo(back)
                end
            end
            if ok and res then n = n + 1 end
            task.wait(0.2)
        end
    end
    return n
end

function TreasureMaps()
    local inv = GetReplicator("PlayerInventory")
    local items = inv and inv.Data.Inventory
    local out = {}
    if items then
        for id, item in pairs(items) do
            if type(item) == "table" and item.name == "Treasure Map" and item.sub and item.sub.x then
                table.insert(out, { id = id, pos = Vector3.new(item.sub.x, item.sub.y, item.sub.z), repaired = item.sub.Repaired })
            end
        end
    end
    return out
end

function OpenTreasures()
    local re = Events:FindFirstChild("open_treasure")
    local root = GetRoot()
    if not (re and root) then return 0 end
    local back = root.CFrame
    local n = 0
    for _, map in ipairs(TreasureMaps()) do
        if map.repaired then
            TeleportTo(CFrame.new(map.pos + Vector3.new(0, 4, 4)))
            task.wait(0.8)
            re:FireServer(map.id)
            n = n + 1
            task.wait(0.8)
        end
    end
    TeleportTo(back)
    return n
end

function FirePrompt(prompt)
    if fireproximityprompt then
        pcall(fireproximityprompt, prompt)
    else
        pcall(function()
            prompt:InputHoldBegin()
            task.wait((prompt.HoldDuration or 0) + 0.05)
            prompt:InputHoldEnd()
        end)
    end
end

LastMeteor = nil

function CollectMeteor()
    local root = GetRoot()
    if not root then return 0 end
    local back = root.CFrame
    local n = 0
    for _, item in ipairs(CollectionService:GetTagged("MeteorItem")) do
        local part = item:IsA("BasePart") and item or item:FindFirstChildWhichIsA("BasePart", true)
        local prompt = item:FindFirstChildWhichIsA("ProximityPrompt", true)
        if part and item:IsDescendantOf(Workspace) then
            TeleportTo(part.CFrame + Vector3.new(0, 3, 0))
            task.wait(0.4)
            if prompt then FirePrompt(prompt) end
            n = n + 1
            task.wait(0.3)
        end
    end
    if S.MeteorReturn then TeleportTo(back) end
    return n
end

do
    local spawnRE = Remote("RE/Meteor/Spawn")
    if spawnRE then
        Track(spawnRE.OnClientEvent:Connect(function(pos, impactAt)
            if typeof(pos) ~= "Vector3" then return end
            LastMeteor = pos
            if S.MeteorNotify then Notify("Meteor!", "A meteor is landing — see the World tab.", 6) end
            if S.AutoMeteor then
                Spawn(function()
                    local untilLanded = (tonumber(impactAt) or 0) - Workspace:GetServerTimeNow() + 4
                    task.wait(math.clamp(untilLanded, 1, 30))
                    CollectMeteor()
                end)
            end
        end))
    end
end

function ClaimRodJournal()
    local rep = GetReplicator("PlayerData")
    local rods = rep and rep.Data.Rods
    local re = Remote("RE/RodJournal/ClaimRodReward")
    if not (rods and re) then return 0 end
    local n = 0
    for name in pairs(rods) do
        if not SpoofedRods[name] then
            re:FireServer(name)
            n = n + 1
            task.wait(0.1)
        end
    end
    return n
end

LootMarks = {}
function UpdateLootESP()
    local seen = {}
    if S.LootESP then
        for _, tag in ipairs({ "TreasureChest", "MeteorItem" }) do
            for _, obj in ipairs(CollectionService:GetTagged(tag)) do
                if obj:IsDescendantOf(Workspace) then
                    seen[obj] = true
                    if not LootMarks[obj] then
                        local hl = Instance.new("Highlight")
                        hl.FillColor = tag == "TreasureChest" and Color3.fromRGB(255, 200, 60) or Color3.fromRGB(255, 90, 40)
                        hl.FillTransparency = 0.4
                        hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                        hl.Adornee = obj
                        hl.Parent = obj
                        LootMarks[obj] = hl
                    end
                end
            end
        end
    end
    for obj, hl in pairs(LootMarks) do
        if not seen[obj] then pcall(function() hl:Destroy() end) LootMarks[obj] = nil end
    end
end

function RedeemCode(code)
    code = tostring(code or ""):gsub("^%s+", ""):gsub("%s+$", "")
    if code == "" then return end
    Events.runcode:FireServer(code)
end

KnownCodes = {
    "SkycrestIsInTheSky", "SkycrestNextWeek", "ShootingStars", "CollectMyPufferfish", "TheDeepIsVeryDeep",
    "HarpoonGunsAreAwesome", "HarpoonGunsNextWeek", "RoamingFishAndWaterPark", "OllieAndFinWhale",
    "DrylandsIsFire", "KingCrabstle", "Fischfest2026", "AquariumCustomization", "TheDeepAwaitsForYou",
    "scarlet", "TemporarySubmarine", "CARBON", "SUBMARINES", "BOBBER", "Shady", "HumpbackAndMegamouth",
    "Sovereign", "VenueTakeover", "nickandsnothegoat", "Companions", "ThanksFor10Mil",
}

function RedeemAllCodes()
    local n = 0
    for _, code in ipairs(KnownCodes) do
        if Unloading then break end
        RedeemCode(code)
        n = n + 1
        task.wait(1.1)
    end
    return n
end

function RedeemCodes(list)
    local n = 0
    for code in tostring(list or ""):gmatch("[^,%s]+") do
        RedeemCode(code)
        n = n + 1
        task.wait(1)
    end
    return n
end

HazardScripts = {
    ["oxygen"] = true, ["oxygen(peaks)"] = true, ["oxygenRefactor_WIP"] = true,
    ["pressure "] = true, ["pressure"] = true, ["temperature"] = true,
    ["temperature(heat)"] = true, ["deterioration"] = true,
}

function ApplyHazards(char)
    char = char or GetCharacter()
    if not char then return end
    for _, s in ipairs(char:GetDescendants()) do
        if s:IsA("LocalScript") and HazardScripts[s.Name] then
            s.Enabled = not S.NoHazards
        end
    end
    if S.NoHazards then
        local head = char:FindFirstChild("Head")
        local drown = head and head:FindFirstChild("drown")
        if drown then drown:Destroy() end
    end
end

Track(LocalPlayer.CharacterAdded:Connect(function(char)
    if not S.NoHazards then return end
    task.wait(1)
    ApplyHazards(char)
end))

function DiscoverAll()
    local zones = Workspace:FindFirstChild("zones")
    local player = zones and zones:FindFirstChild("player")
    local re = Events:FindFirstChild("discoverlocation")
    local stats = GetStatsFolder()
    local tracker = stats and stats:FindFirstChild("tracker_locationsdiscovered")
    if not (player and re) then return 0 end
    local sent, n = {}, 0
    for _, z in ipairs(player:GetChildren()) do
        local d = z:FindFirstChild("discover")
        local name = d and d.Value
        if name and name ~= "" and not sent[name]
            and not (tracker and tracker:FindFirstChild(name .. "Discovered")) then
            sent[name] = true
            re:FireServer(name)
            n = n + 1
            task.wait(0.25)
        end
    end
    return n
end

function OwnedRodNames()
    local rep = GetReplicator("PlayerData")
    local out = {}
    if rep and rep.Data.Rods then
        for name in pairs(rep.Data.Rods) do
            if type(name) == "string" and not SpoofedRods[name] then table.insert(out, name) end
        end
    end
    table.sort(out)
    return out
end

function SwapRod(name)
    local rf = Remote("RF/Rod/Equip")
    if not (rf and name) then return false end
    local ok, res = pcall(function() return rf:InvokeServer(name) end)
    local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
    local tool = bp and bp:WaitForChild(name, 10)
    local hum = GetHumanoid()
    if tool and hum then hum:EquipTool(tool) end
    return ok and res ~= false
end

Vessels = nil
pcall(function() Vessels = require(ReplicatedStorage.shared.modules.vessels) end)

function OwnedBoats()
    local out = {}
    local st = GetStatsFolder()
    local boats = st and st.Parent and st.Parent:FindFirstChild("Boats")
    if boats then
        for _, b in ipairs(boats:GetChildren()) do
            local known = not (Vessels and Vessels.library) or Vessels.library[b.Name] ~= nil
            if known then table.insert(out, b.Name) end
        end
    end
    table.sort(out)
    return out
end

function SpawnBoat(name)
    local rf = Remote("RF/Boats/Spawn")
    local close = Remote("RE/Boats/Close")
    if not (rf and name) then return end
    if LocalPlayer:GetAttribute("LastDock") ~= "None" and close then
        close:FireServer()
        local t0 = tick()
        local changed = false
        local conn = LocalPlayer:GetAttributeChangedSignal("LastDock"):Once(function() changed = true end)
        repeat task.wait() until changed or tick() - t0 > 3
        conn:Disconnect()
    end
    local ok, err = pcall(function() return rf:InvokeServer(name) end)
    if not ok then Notify("Boat", "Spawn failed: " .. tostring(err), 4) end
end

do
    local function describe(...)
        local parts = {}
        for i = 1, select("#", ...) do
            local v = select(i, ...)
            if type(v) == "string" and v ~= "" then
                table.insert(parts, (v:gsub("<[^>]->", "")))
            end
        end
        return table.concat(parts, " ")
    end
    for _, name in ipairs({ "anno_serverEvent", "nuke_spawned", "atomic_nuke_spawned", "cursed_nuke_spawned",
                            "love_nuke_spawned", "shady_nuke_spawned" }) do
        local re = Events:FindFirstChild(name)
        if re then
            Track(re.OnClientEvent:Connect(function(...)
                if not S.EventNotify then return end
                local text = describe(...)
                if text == "" then text = name:gsub("_", " ") end
                Notify("Server Event", text, 6)
            end))
        end
    end
end

HttpRequest = (syn and syn.request) or (http and http.request) or http_request or request

SendWebhook = function(fishName, rarity)
    if S.WebhookURL == "" or not HttpRequest then return end
    if RarityOrder(rarity) < RarityOrder(S.WebhookRarity) then return end
    Spawn(function()
        HttpRequest({
            Url = S.WebhookURL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/json" },
            Body = HttpService:JSONEncode({
                embeds = { {
                    title = "Hooked " .. fishName,
                    description = ("Rarity: **%s**\nPlayer: %s"):format(rarity, LocalPlayer.Name),
                    color = 3978751,
                } },
            }),
        })
    end)
end

function GetDataFolder()
    local st = GetStatsFolder()
    return st and st.Parent
end

function BackpackTools(match)
    local out = {}
    local bp = LocalPlayer:FindFirstChildOfClass("Backpack")
    local char = GetCharacter()
    for _, holder in ipairs({ bp, char }) do
        if holder then
            for _, t in ipairs(holder:GetChildren()) do
                if t:IsA("Tool") and (not match or match(t)) then table.insert(out, t) end
            end
        end
    end
    return out
end

function HoldTool(tool)
    local hum = GetHumanoid()
    if not (tool and hum) then return false end
    if tool.Parent ~= GetCharacter() then hum:EquipTool(tool) task.wait(0.3) end
    return tool.Parent == GetCharacter()
end

function CurrentRodName()
    local st = GetStatsFolder()
    local rod = st and st:FindFirstChild("rod")
    return rod and rod.Value
end

function CurrentEnchant()
    local rep = GetReplicator("PlayerData")
    local name = CurrentRodName()
    local data = rep and name and rep.Data.Rods and rep.Data.Rods[name]
    if not data then return nil end
    return data.enchant, data.secondaryEnchant
end

function FindRelic()
    for _, t in ipairs(BackpackTools(function(t) return t.Name:lower():find("relic") ~= nil end)) do
        return t
    end
end

function FindAltar()
    for _, tag in ipairs({ "EnchantAltar", "KeepersAltar" }) do
        for _, a in ipairs(CollectionService:GetTagged(tag)) do
            if a:IsDescendantOf(Workspace) then return a end
        end
    end
end

EnchantRunning = false

function EnchantOnce()
    local relic = FindRelic()
    if not relic then return false, "no relics left" end
    if not HoldTool(relic) then return false, "couldn't hold the relic" end
    if S.EnchantMethod == "Enchant Anywhere (pass)" then
        local ok, res = pcall(function() return Events.enchantrod:InvokeServer() end)
        if ok and res == true then return true end
        return false, ok and tostring(res) or "enchant failed"
    end
    local rf = Remote("RF/EnchantAltar/Interact")
    if not rf then return false, "altar remote missing" end
    local altar = FindAltar()
    local root = GetRoot()
    if altar and root and (root.Position - altar:GetPivot().Position).Magnitude > 20 then
        TeleportTo(altar:GetPivot() + Vector3.new(0, 4, 6))
        task.wait(0.5)
    end
    local ok, res, msg = pcall(function() return rf:InvokeServer(relic.Name) end)
    if ok and res then return true end
    return false, tostring(msg or res or "altar refused")
end

function EnchantMatches()
    local primary, secondary = CurrentEnchant()
    local want = tostring(S.EnchantTarget or ""):lower()
    if want == "" then return false end
    for _, e in ipairs({ primary, secondary }) do
        if type(e) == "string" and e:lower():find(want, 1, true) then return true, e end
    end
    return false
end

function AutoEnchant()
    if EnchantRunning then EnchantRunning = false return end
    EnchantRunning = true
    local tries = 0
    while EnchantRunning and not Unloading and tries < S.EnchantMaxTries do
        local hit, name = EnchantMatches()
        if hit then Notify("Enchant", "Got " .. name .. " after " .. tries .. " rolls!", 8) break end
        local ok, err = EnchantOnce()
        if not ok then Notify("Enchant", "Stopped: " .. tostring(err), 5) break end
        tries = tries + 1
        task.wait(1.6)
        local now = CurrentEnchant()
        Notify("Enchant", ("Roll %d: %s"):format(tries, tostring(now)), 2)
    end
    EnchantRunning = false
end

AppraiseHook = nil
do
    local re = Events:FindFirstChild("dialogstart")
    if re then
        Track(re.OnClientEvent:Connect(function(arg, npc, data)
            if not (typeof(npc) == "Instance" and npc.Name:lower():find("apprais") and type(data) == "table") then return end
            for _, node in pairs(data.dialog or {}) do
                if type(node) == "table" and type(node.choices) == "table" then
                    for key, choice in pairs(node.choices) do
                        local run = type(choice) == "table" and choice.run
                        if typeof(run) == "Instance" and run:IsA("RemoteFunction") then
                            local isAppraise = tostring(key):lower():find("apprais") ~= nil
                            if isAppraise or not AppraiseHook then
                                AppraiseHook = { remote = run, arg = arg, npc = npc }
                            end
                        end
                    end
                end
            end
            if AppraiseHook then Notify("Appraise", "Appraiser captured — auto appraise ready.", 4) end
        end))
    end
end

function HeldFishItem()
    local char = GetCharacter()
    local tool = char and char:FindFirstChildWhichIsA("Tool")
    local link = tool and tool:FindFirstChild("link")
    local inv = GetReplicator("PlayerInventory")
    local item = link and inv and inv.Data.Inventory and inv.Data.Inventory[link.Value]
    return item, tool
end

function AppraiseMatches(item)
    local sub = item and item.sub or {}
    local mutation = sub.Mutation
    if S.AppraiseMutation ~= "" then
        if not (mutation and tostring(mutation):lower():find(S.AppraiseMutation:lower(), 1, true)) then return false end
    elseif S.AppraiseAnyMutation and not mutation then
        return false
    end
    if S.AppraiseMinWeight > 0 and (tonumber(sub.Weight) or 0) < S.AppraiseMinWeight then return false end
    return true
end

AppraiseRunning = false

function AppraiseOnce()
    if S.AppraiseMethod == "Appraise Anywhere (pass)" then
        local rf = Remote("RF/AppraiseAnywhere/Fire")
        local ok, a, b = pcall(function() return rf:InvokeServer() end)
        return ok and a ~= false, b or a
    end
    if not AppraiseHook then return false, "talk to the Appraiser once (hold a fish, pick Appraise)" end
    local npcRoot = AppraiseHook.npc and AppraiseHook.npc:FindFirstChild("HumanoidRootPart")
    local root = GetRoot()
    if npcRoot and root and (root.Position - npcRoot.Position).Magnitude > 12 then
        TeleportTo(npcRoot.CFrame * CFrame.new(0, 0, -4))
        task.wait(0.4)
    end
    local ok, res = pcall(function() return AppraiseHook.remote:InvokeServer(AppraiseHook.arg) end)
    return ok and res ~= false, res
end

function AutoAppraise()
    if AppraiseRunning then AppraiseRunning = false return end
    local item = HeldFishItem()
    if not item then Notify("Appraise", "Hold the fish you want to appraise first.", 4) return end
    AppraiseRunning = true
    local tries = 0
    while AppraiseRunning and not Unloading and tries < S.AppraiseMaxTries do
        item = HeldFishItem()
        if not item then Notify("Appraise", "Fish no longer held — stopped.", 4) break end
        if AppraiseMatches(item) then
            Notify("Appraise", ("Done after %d: %s %s %.1fkg"):format(tries, tostring(item.sub.Mutation or ""), item.name, tonumber(item.sub.Weight) or 0), 8)
            break
        end
        local ok, err = AppraiseOnce()
        if not ok then Notify("Appraise", "Stopped: " .. tostring(err), 5) break end
        tries = tries + 1
        task.wait(1.2)
    end
    AppraiseRunning = false
end

function QuestTick()
    local folder = GetDataFolder()
    local rep = folder and folder:FindFirstChild("ReputationQuests")
    local active = folder and folder:FindFirstChild("QuestActive")
    local finished = folder and folder:FindFirstChild("QuestFinished")
    local claim, select = Remote("RE/ReputationQuests/ClaimQuest"), Remote("RE/ReputationQuests/SelectQuest")
    local n = 0
    if rep and claim then
        for _, faction in ipairs(rep:GetChildren()) do
            for _, quest in ipairs(faction:GetChildren()) do
                if not (finished and finished:FindFirstChild(quest.Name)) then
                    if active and active:FindFirstChild(quest.Name) then
                        claim:FireServer(faction.Name, quest.Name)
                    elseif S.AutoAcceptQuests and select then
                        select:FireServer(faction.Name, quest.Name)
                    end
                    n = n + 1
                    task.wait(0.15)
                end
            end
        end
    end

    local pd = GetReplicator("PlayerData")
    local chal = Remote("RF/Challenges/Claim")
    if pd and pd.Data.Challenges and chal then
        for category in pairs(pd.Data.Challenges) do
            pcall(function() chal:InvokeServer(category) end)
            task.wait(0.2)
        end
    end

    local load, claimMastery = Remote("RF/Mastery/LoadQuests"), Remote("RE/Mastery/ClaimQuest")
    local rod = CurrentRodName()
    if load and claimMastery and rod then
        local ok, data = pcall(function() return load:InvokeServer(rod) end)
        if ok and type(data) == "table" and type(data.Quests) == "table" then
            for questId in pairs(data.Quests) do
                claimMastery:FireServer(rod, questId)
                task.wait(0.15)
            end
        end
    end
    return n
end

function Caught(name)
    local rep = GetReplicator("PlayerBestiary")
    return rep and rep.Data.Bestiary and rep.Data.Bestiary[name] ~= nil
end

function UncaughtFish(minRarity)
    local out = {}
    if not FishLibrary then return out end
    local minOrder = RarityOrder(minRarity or "Trash")
    for name, def in pairs(FishLibrary) do
        if type(name) == "string" and type(def) == "table" and def.From and def.Rarity
            and not def.Unregistered and not def.NonFish and not def.FromLimited
            and RarityOrder(def.Rarity) >= minOrder and not Caught(name) then
            table.insert(out, name)
        end
    end
    table.sort(out, function(a, b)
        local ra, rb = RarityOrder(FishLibrary[a].Rarity), RarityOrder(FishLibrary[b].Rarity)
        if ra ~= rb then return ra > rb end
        return a < b
    end)
    return out
end

function FishInfo(name)
    local def = FishLibrary and FishLibrary[name]
    if not def then return "-" end
    local function list(t) return type(t) == "table" and #t > 0 and table.concat(t, "/") or "any" end
    return ("%s | %s | bait: %s | seasons: %s | weather: %s\n%s"):format(
        tostring(def.Rarity), tostring(def.From), tostring(def.FavouriteBait or "any"),
        list(def.Seasons), list(def.Weather), tostring(def.Hint or ""))
end

function GoToFishZone(name)
    local def = FishLibrary and FishLibrary[name]
    if not def then return false end
    local zones = Workspace:FindFirstChild("zones")
    local folder = zones and zones:FindFirstChild("fishing")
    local zone = folder and folder:FindFirstChild(def.From)
    if zone then TeleportToZone(zone) return true end
    local _, islands = IslandList()
    for island, part in pairs(islands) do
        if tostring(def.From):lower():find(island:lower(), 1, true) or island:lower():find(tostring(def.From):lower(), 1, true) then
            TeleportTo(part.CFrame + Vector3.new(0, 5, 0))
            return true
        end
    end
    return false
end

DailyItems = {}
do
    local re = Remote("RE/DailyShop/ReplicateItems")
    if re then
        Track(re.OnClientEvent:Connect(function(_, items)
            if type(items) == "table" then DailyItems = items end
        end))
    end
end

function BuyDailyShop()
    local re = Remote("RE/DailyShop/Purchase")
    if not re then return 0 end
    local n = 0
    for key, item in pairs(DailyItems) do
        local price = type(item) == "table" and tonumber(item.price)
        if price and not item.ProductId and price <= S.DailyMaxPrice then
            re:FireServer(key)
            n = n + 1
            task.wait(0.6)
        end
    end
    return n
end

function SellStorage()
    local rf = Events:FindFirstChild("SellAllStorage")
    if not rf then return false end
    local ok, res = pcall(function() return rf:InvokeServer() end)
    return ok and res ~= false
end

function ClaimAquarium()
    local re = Remote("RE/PersonalAquarium/ClaimRewards")
    if re then re:FireServer() end
end

TimeEvents = nil
pcall(function() TimeEvents = require(ReplicatedStorage.shared.modules.library.timeevents).Events end)

function FormatSpan(sec)
    sec = math.max(0, math.floor(sec))
    local d, h, m = sec // 86400, (sec % 86400) // 3600, (sec % 3600) // 60
    if d > 0 then return ("%dd %dh"):format(d, h) end
    if h > 0 then return ("%dh %dm"):format(h, m) end
    return ("%dm %ds"):format(m, sec % 60)
end

function EventStatus()
    if not TimeEvents then return "event data unavailable" end
    local now = DateTime.now().UnixTimestamp
    local active, nextName, nextIn = {}, nil, math.huge
    for name, ev in pairs(TimeEvents) do
        local s = typeof(ev.StartTime) == "DateTime" and ev.StartTime.UnixTimestamp
        local e = typeof(ev.EndTime) == "DateTime" and ev.EndTime.UnixTimestamp
        if s and e then
            if now >= s and now < e then
                table.insert(active, ("%s (ends in %s)"):format(name, FormatSpan(e - now)))
            elseif s > now and s - now < nextIn then
                nextName, nextIn = name, s - now
            end
        end
    end
    local out = #active > 0 and ("Active: " .. table.concat(active, ", ")) or "No timed event running"
    if nextName then out = out .. ("\nNext: %s in %s"):format(nextName, FormatSpan(nextIn)) end
    return out
end

HopFile = "fisch_hub/hop.json"

function ReadHop()
    local ok, data = pcall(function() return isfile and isfile(HopFile) and HttpService:JSONDecode(readfile(HopFile)) end)
    return ok and type(data) == "table" and data or nil
end

function WriteHop(data)
    pcall(function()
        if makefolder and not (isfolder and isfolder("fisch_hub")) then makefolder("fisch_hub") end
        writefile(HopFile, HttpService:JSONEncode(data))
    end)
end

function ZoneMatching(keyword)
    keyword = tostring(keyword or ""):lower()
    if keyword == "" then return nil end
    local zones = Workspace:FindFirstChild("zones")
    if not zones then return nil end
    for _, z in ipairs(zones:GetDescendants()) do
        if z:IsA("BasePart") and z.Name:lower():find(keyword, 1, true) then return z end
    end
end

function HopToNext(visited)
    local queue = queue_on_teleport or (syn and syn.queue_on_teleport)
    if queue and S.HopLoader ~= "" then pcall(queue, S.HopLoader) end
    local ok, body = pcall(function()
        return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Desc&limit=100")
    end)
    local decoded
    if not (ok and pcall(function() decoded = HttpService:JSONDecode(body) end) and decoded and decoded.data) then
        Notify("Event Hop", "Couldn't get the server list.", 4)
        return
    end
    local options = {}
    for _, server in ipairs(decoded.data) do
        if server.id ~= game.JobId and not visited[server.id] and server.playing and server.maxPlayers
            and server.playing < server.maxPlayers - 1 then
            table.insert(options, server.id)
        end
    end
    if #options == 0 then Notify("Event Hop", "No unvisited servers left.", 5) return end
    local pick = options[math.random(1, #options)]
    pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, pick, LocalPlayer) end)
end

function StartEventHop(keyword)
    local hop = { active = true, keyword = keyword, visited = { [game.JobId] = true }, hops = 0 }
    WriteHop(hop)
    local found = ZoneMatching(keyword)
    if found then
        WriteHop({ active = false })
        Notify("Event Hop", "Already here: " .. found.Name, 5)
        return
    end
    HopToNext(hop.visited)
end

function StopEventHop() WriteHop({ active = false }) end

function ResumeEventHop()
    local hop = ReadHop()
    if not (hop and hop.active and hop.keyword) then return end
    Spawn(function()
        task.wait(12)
        local zone = ZoneMatching(hop.keyword)
        hop.visited = hop.visited or {}
        hop.visited[game.JobId] = true
        hop.hops = (hop.hops or 0) + 1
        if zone then
            WriteHop({ active = false })
            Notify("Event Hop", ("Found %s after %d hops!"):format(zone.Name, hop.hops), 8)
            TeleportToZone(zone)
            if S.HopStartFarm and SetAutoFarm then SetAutoFarm(true) end
        elseif hop.hops >= S.HopMax then
            WriteHop({ active = false })
            Notify("Event Hop", "Gave up after " .. hop.hops .. " servers.", 6)
        else
            WriteHop(hop)
            Notify("Event Hop", ("No '%s' here (hop %d) — next server..."):format(hop.keyword, hop.hops), 4)
            task.wait(2)
            HopToNext(hop.visited)
        end
    end)
end

function TotemNames()
    local out, seen = {}, {}
    for _, t in ipairs(BackpackTools(function(t) return t.Name:lower():find("totem") ~= nil end)) do
        if not seen[t.Name] then seen[t.Name] = true table.insert(out, t.Name) end
    end
    table.sort(out)
    return out
end

function UseTotem(name)
    local tool
    for _, t in ipairs(BackpackTools(function(t) return t.Name == name end)) do tool = t break end
    if not tool then return false end
    local rod = GetEquippedRod()
    if not HoldTool(tool) then return false end
    pcall(function() tool:Activate() end)
    task.wait(1.5)
    if rod and rod.Parent then
        local hum = GetHumanoid()
        if hum then hum:EquipTool(rod) end
    end
    return true
end

LastTotem = 0
function AutoTotemTick()
    if not S.TotemChoice or S.TotemChoice == "" then return end
    local clock = Lighting.ClockTime
    local isNight = clock < 6 or clock >= 18
    local want = (S.TotemWhen == "When Night" and isNight)
        or (S.TotemWhen == "When Day" and not isNight)
        or (S.TotemWhen == "Every X Minutes" and tick() - LastTotem >= S.TotemEvery * 60)
    if not want or tick() - LastTotem < 60 then return end
    local rc = GetReelController()
    if (rc and rc.ActiveReel) or ShakeUIOpen() then return end
    if UseTotem(S.TotemChoice) then
        LastTotem = tick()
        Notify("Totem", "Used " .. S.TotemChoice, 3)
    end
end

StabController, HarpoonController = nil, nil
function FindMinigameControllers()
    if (StabController and HarpoonController) or not getgc then return end
    for _, v in ipairs(getgc(true)) do
        if type(v) == "table" then
            if not StabController and rawget(v, "type") == "stab" and type(rawget(v, "EndMinigame")) == "function" then
                StabController = v
            elseif not HarpoonController and type(rawget(v, "SpawnButton")) == "function"
                and type(rawget(v, "EndMinigame")) == "function" and type(rawget(v, "StartMinigame")) == "function" then
                HarpoonController = v
            end
        end
    end
end

FinishedMinigames = setmetatable({}, { __mode = "k" })

function AutoFinish(game_)
    if not game_ or FinishedMinigames[game_] then return end
    FinishedMinigames[game_] = true
    Spawn(function()
        local deadline = tick() + 6
        while not game_.ready and tick() < deadline and not Unloading do task.wait() end
        task.wait(S.MinigameDelay)
        pcall(function() game_:EndMinigame(true) end)
    end)
end

Track(RunService.Heartbeat:Connect(function()
    if Unloading or not (S.AutoSpear or S.AutoHarpoon) then return end
    FindMinigameControllers()
    if S.AutoSpear and StabController and StabController.ActiveReel then AutoFinish(StabController.ActiveReel) end
    if S.AutoHarpoon and HarpoonController and HarpoonController.ActiveMinigame then AutoFinish(HarpoonController.ActiveMinigame) end
end))

RoamMarks = {}
function UpdateRoamingESP()
    local seen = {}
    local active = Workspace:FindFirstChild("active")
    local folder = active and active:FindFirstChild("roamingFish")
    local root = GetRoot()
    if S.RoamingESP and folder then
        for _, rarityFolder in ipairs(folder:GetChildren()) do
            if RarityOrder(rarityFolder.Name) >= RarityOrder(S.RoamingMinRarity) or RarityOrder(rarityFolder.Name) == 0 then
                for _, fish in ipairs(rarityFolder:GetChildren()) do
                    local part = fish:IsA("BasePart") and fish or fish:FindFirstChildWhichIsA("BasePart", true)
                    if part then
                        seen[fish] = true
                        local mark = RoamMarks[fish]
                        if not mark then
                            local r = RarityLibrary and RarityLibrary[rarityFolder.Name]
                            local color = (r and typeof(r.Color) == "Color3") and r.Color or Color3.fromRGB(255, 255, 255)
                            local hl = Instance.new("Highlight")
                            hl.FillColor = color
                            hl.FillTransparency = 0.5
                            hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                            hl.Adornee = fish
                            hl.Parent = fish
                            local tag = Instance.new("BillboardGui")
                            tag.Size = UDim2.fromOffset(220, 20)
                            tag.AlwaysOnTop = true
                            tag.StudsOffset = Vector3.new(0, 4, 0)
                            tag.Adornee = part
                            local lbl = Instance.new("TextLabel")
                            lbl.Size = UDim2.fromScale(1, 1)
                            lbl.BackgroundTransparency = 1
                            lbl.TextColor3 = color
                            lbl.TextStrokeTransparency = 0.3
                            lbl.Font = Enum.Font.GothamBold
                            lbl.TextSize = 13
                            lbl.Parent = tag
                            tag.Parent = part
                            mark = { hl = hl, tag = tag, lbl = lbl, part = part, rarity = rarityFolder.Name }
                            RoamMarks[fish] = mark
                        end
                        local dist = root and math.floor((root.Position - mark.part.Position).Magnitude) or 0
                        mark.lbl.Text = ("%s [%s] %dm"):format(fish.Name, mark.rarity, dist)
                    end
                end
            end
        end
    end
    for fish, mark in pairs(RoamMarks) do
        if not seen[fish] then
            pcall(function() mark.hl:Destroy() mark.tag:Destroy() end)
            RoamMarks[fish] = nil
        end
    end
end

function NearestRoamingFish()
    local root = GetRoot()
    local best, bestDist = nil, math.huge
    for fish, mark in pairs(RoamMarks) do
        if root and mark.part.Parent then
            local d = (mark.part.Position - root.Position).Magnitude
            if d < bestDist then best, bestDist = mark.part, d end
        end
    end
    return best
end

LowGraphicsOn = false
function ApplyLowGraphics()
    if LowGraphicsOn then return end
    LowGraphicsOn = true
    pcall(function() settings().Rendering.QualityLevel = Enum.QualityLevel.Level01 end)
    pcall(function()
        Lighting.GlobalShadows = false
        Lighting.FogEnd = 1e6
        for _, e in ipairs(Lighting:GetChildren()) do
            if e:IsA("PostEffect") or e:IsA("Atmosphere") then e.Enabled = false end
        end
    end)
    pcall(function()
        local terrain = Workspace.Terrain
        terrain.WaterWaveSize, terrain.WaterWaveSpeed = 0, 0
        terrain.WaterReflectance, terrain.WaterTransparency = 0, 0
        terrain.Decoration = false
    end)
    local function strip(d)
        if d:IsA("ParticleEmitter") or d:IsA("Trail") or d:IsA("Beam") or d:IsA("Smoke") or d:IsA("Fire") or d:IsA("Sparkles") then
            d.Enabled = false
        elseif d:IsA("Decal") or d:IsA("Texture") then
            d.Transparency = 1
        elseif d:IsA("BasePart") then
            d.Material = Enum.Material.SmoothPlastic
            d.Reflectance = 0
            d.CastShadow = false
        end
    end
    Spawn(function()
        for i, d in ipairs(Workspace:GetDescendants()) do
            pcall(strip, d)
            if i % 4000 == 0 then task.wait() end
        end
    end)
    Track(Workspace.DescendantAdded:Connect(function(d) pcall(strip, d) end))
end

function Rejoin()
    pcall(function() TeleportService:Teleport(game.PlaceId, LocalPlayer) end)
end

function ServerHop()
    Spawn(function()
        local ok, body = pcall(function()
            return game:HttpGet("https://games.roblox.com/v1/games/" .. game.PlaceId .. "/servers/Public?sortOrder=Asc&limit=100")
        end)
        if not ok then Notify("Fisch", "Server list request failed.", 4) return end
        local decoded
        if not pcall(function() decoded = HttpService:JSONDecode(body) end) or not (decoded and decoded.data) then
            Notify("Fisch", "Could not parse the server list.", 4)
            return
        end
        for _, server in ipairs(decoded.data) do
            if server.playing and server.maxPlayers and server.playing < server.maxPlayers and server.id ~= game.JobId then
                Notify("Fisch", "Hopping servers...", 3)
                pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, server.id, LocalPlayer) end)
                return
            end
        end
        Notify("Fisch", "No other joinable servers found.", 4)
    end)
end

LightingBackup = {
    Brightness = Lighting.Brightness, ClockTime = Lighting.ClockTime,
    FogEnd = Lighting.FogEnd, GlobalShadows = Lighting.GlobalShadows, Ambient = Lighting.Ambient,
}

function ApplyFullbright(on)
    if on then
        Lighting.Brightness = 2
        Lighting.ClockTime = 14
        Lighting.FogEnd = 1e6
        Lighting.GlobalShadows = false
        Lighting.Ambient = Color3.fromRGB(180, 180, 180)
    else
        for k, v in pairs(LightingBackup) do pcall(function() Lighting[k] = v end) end
    end
end

Track(RunService.Heartbeat:Connect(function()
    if Unloading then return end
    local hum = GetHumanoid()
    if hum and S.WalkSpeedOn then
        local char = GetCharacter()
        if not (char and char:GetAttribute("FishingWalkSpeed") == 0) then
            hum.WalkSpeed = S.WalkSpeed
        end
    end
    if S.Fullbright then ApplyFullbright(true) end

    local root = GetRoot()
    if root then
        if S.WaterPlatform and Platform and Platform.Parent then
            local p = Platform.Position
            local r = root.Position
            if (Vector3.new(r.X, 0, r.Z) - Vector3.new(p.X, 0, p.Z)).Magnitude > 2 then
                Platform.CFrame = CFrame.new(r.X, p.Y, r.Z)
            end
        end

        if S.AnchorFishing then
            local rod = GetEquippedRod()
            local state = rod and RodValues(rod)
            local fishing = state and state.Value >= RodState.Casting
            if root.Anchored ~= (fishing and true or false) then root.Anchored = fishing and true or false end
        end
    end
end))

FlyVel, FlyGyro = nil, nil

function SetFly(on)
    if FlyVel then FlyVel:Destroy() FlyVel = nil end
    if FlyGyro then FlyGyro:Destroy() FlyGyro = nil end
    local hum = GetHumanoid()
    if hum then hum.PlatformStand = false end
    if not on then return end
    local root = GetRoot()
    if not root then return end
    FlyVel = Instance.new("BodyVelocity")
    FlyVel.MaxForce = Vector3.new(1e9, 1e9, 1e9)
    FlyVel.Velocity = Vector3.zero
    FlyVel.Parent = root
    FlyGyro = Instance.new("BodyGyro")
    FlyGyro.MaxTorque = Vector3.new(1e9, 1e9, 1e9)
    FlyGyro.P = 9e4
    FlyGyro.CFrame = root.CFrame
    FlyGyro.Parent = root
    if hum then hum.PlatformStand = true end
end

Track(RunService.RenderStepped:Connect(function()
    if not S.Fly then return end
    local root = GetRoot()
    if not root then return end
    if not (FlyVel and FlyVel.Parent == root) then SetFly(true) end
    local cam = Workspace.CurrentCamera
    local dir = Vector3.zero
    if UserInputService:IsKeyDown(Enum.KeyCode.W) then dir = dir + cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.S) then dir = dir - cam.CFrame.LookVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
    if UserInputService:IsKeyDown(Enum.KeyCode.Space) then dir = dir + Vector3.yAxis end
    if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then dir = dir - Vector3.yAxis end
    FlyVel.Velocity = dir.Magnitude > 0 and dir.Unit * S.FlySpeed or Vector3.zero
    FlyGyro.CFrame = cam.CFrame
end))

Track(RunService.Stepped:Connect(function()
    if not S.Noclip then return end
    local char = GetCharacter()
    if not char then return end
    for _, p in ipairs(char:GetDescendants()) do
        if p:IsA("BasePart") then p.CanCollide = false end
    end
end))

Track(UserInputService.JumpRequest:Connect(function()
    if not S.InfiniteJump then return end
    local hum = GetHumanoid()
    if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end))

ESPObjects = {}

function ClearESP(plr)
    local o = ESPObjects[plr]
    if not o then return end
    pcall(function() o.Highlight:Destroy() end)
    pcall(function() o.Tag:Destroy() end)
    ESPObjects[plr] = nil
end

function UpdateESP()
    local myRoot = GetRoot()
    for _, plr in ipairs(Players:GetPlayers()) do
        if plr ~= LocalPlayer then
            local char = plr.Character
            local head = char and char:FindFirstChild("Head")
            if S.PlayerESP and head then
                local o = ESPObjects[plr]
                if not o or o.Char ~= char then
                    ClearESP(plr)
                    local hl = Instance.new("Highlight")
                    hl.FillTransparency = 0.75
                    hl.FillColor = Color3.fromRGB(60, 170, 255)
                    hl.OutlineColor = Color3.new(1, 1, 1)
                    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
                    hl.Adornee = char
                    hl.Parent = char
                    local tag = Instance.new("BillboardGui")
                    tag.Size = UDim2.fromOffset(200, 20)
                    tag.StudsOffset = Vector3.new(0, 3, 0)
                    tag.AlwaysOnTop = true
                    tag.Adornee = head
                    local lbl = Instance.new("TextLabel")
                    lbl.Size = UDim2.fromScale(1, 1)
                    lbl.BackgroundTransparency = 1
                    lbl.TextColor3 = Color3.new(1, 1, 1)
                    lbl.TextStrokeTransparency = 0.3
                    lbl.Font = Enum.Font.GothamBold
                    lbl.TextSize = 13
                    lbl.Parent = tag
                    tag.Parent = head
                    o = { Char = char, Highlight = hl, Tag = tag, Label = lbl }
                    ESPObjects[plr] = o
                end
                local dist = myRoot and math.floor((myRoot.Position - head.Position).Magnitude) or 0
                o.Label.Text = ("%s  [%dm]"):format(plr.DisplayName, dist)
            else
                ClearESP(plr)
            end
        end
    end
end

Loop(0.25, function() return S.PlayerESP or next(ESPObjects) ~= nil end, UpdateESP)
Track(Players.PlayerRemoving:Connect(ClearESP))

Track(GuiService.ErrorMessageChanged:Connect(function()
    if not S.AutoRejoin then return end
    task.wait(2)
    Rejoin()
end))

Track(LocalPlayer.Idled:Connect(function()
    if not S.AntiAFK then return end
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end))

Loop(function() return S.RapidMode and 0 or 0.25 end, function() return S.AutoCast or S.AutoEquip end, function()
    if S.AutoCast then TryCast()
    elseif S.AutoEquip and not GetEquippedRod() then EquipRod() end
end)

Loop(function() return math.min(S.ShakeInterval, 0.05) end, function() return S.AutoShake end, TryShake)

Track(RunService.RenderStepped:Connect(function()
    if Unloading or not (S.AutoReel or S.HookNotify) then return end
    pcall(WatchReel)
end))

Spawn(WatchZones)

Loop(600, function() return S.AutoDaily end, ClaimDaily)
Loop(5, function() return S.AutoBait end, AutoBaitTick)
Loop(30, function() return S.AutoCrab end, function()
    local rc = GetReelController()
    if (rc and rc.ActiveReel) or ShakeUIOpen() then return end
    ClaimCrabCages()
end)
Loop(1, function() return S.LootESP or next(LootMarks) ~= nil end, UpdateLootESP)

LastSell = tick()
Loop(5, function() return S.AutoSell end, function()
    if tick() - LastSell < S.SellInterval * 60 then return end
    local rc = GetReelController()
    if (rc and rc.ActiveReel) or ShakeUIOpen() then return end
    LastSell = tick()
    SellAll()
end)

Loop(45, function() return S.AutoQuests end, QuestTick)
Loop(120, function() return S.AutoDailyShop end, BuyDailyShop)
Loop(300, function() return S.AutoAquarium end, ClaimAquarium)
Loop(20, function() return S.AutoTotem end, AutoTotemTick)
Loop(1, function() return S.RoamingESP or next(RoamMarks) ~= nil end, UpdateRoamingESP)

Loop(1, function() return NameSpoof ~= nil end, function()
    ReplaceNames(GetCharacter())
    ReplaceNames(PlayerGui)
end)

UIRefs = {}
UIGen = 0
WatermarkObj = nil
ArrayListObj = nil
AccentHex = "AA55EB"
AccentColors = {
    Purple = Color3.fromRGB(170, 85, 235), Blue = Color3.fromRGB(60, 140, 255), Cyan = Color3.fromRGB(0, 200, 220),
    Green = Color3.fromRGB(80, 220, 120), Red = Color3.fromRGB(235, 70, 70), Pink = Color3.fromRGB(255, 105, 180),
    Orange = Color3.fromRGB(255, 150, 50), Gold = Color3.fromRGB(255, 200, 60), White = Color3.fromRGB(230, 230, 230),
}
AccentOrder = { "Purple", "Blue", "Cyan", "Green", "Red", "Pink", "Orange", "Gold", "White" }
BuildUI = nil
ConfigFolder = "fisch_hub"
ConfigSkip = { CatchLog = true }

function WindowTitle()
    return ("<font color=\"#%s\">fisch</font> | %s"):format(AccentHex, S.StreamerMode and "hidden" or LocalPlayer.Name)
end

function CanUseFiles()
    return writefile ~= nil and readfile ~= nil and isfile ~= nil
end

function ConfigPath(name) return ConfigFolder .. "/" .. name .. ".json" end

function EnsureConfigFolder()
    pcall(function()
        if makefolder and not (isfolder and isfolder(ConfigFolder)) then makefolder(ConfigFolder) end
    end)
end

function SaveConfig(name)
    if not CanUseFiles() then return false, "your executor has no file functions" end
    name = tostring(name or ""):gsub("[^%w%-_ ]", "")
    if name == "" then return false, "enter a config name" end
    EnsureConfigFolder()
    local out = {}
    for k, v in pairs(S) do
        if not ConfigSkip[k] then
            local t = typeof(v)
            if t == "boolean" or t == "number" or t == "string" then
                out[k] = v
            elseif t == "EnumItem" then
                out[k] = { keycode = v.Name }
            end
        end
    end
    local ok, err = pcall(function() writefile(ConfigPath(name), HttpService:JSONEncode(out)) end)
    return ok, ok and ("saved " .. name) or tostring(err)
end

function LoadConfig(name)
    if not CanUseFiles() then return false, "your executor has no file functions" end
    local path = ConfigPath(tostring(name or ""))
    if not isfile(path) then return false, "no config named " .. tostring(name) end
    local ok, data = pcall(function() return HttpService:JSONDecode(readfile(path)) end)
    if not ok or type(data) ~= "table" then return false, "config file is corrupted" end
    for k, v in pairs(data) do
        if S[k] ~= nil and not ConfigSkip[k] then
            if type(v) == "table" and v.keycode then
                local key = Enum.KeyCode[v.keycode]
                if key then S[k] = key end
            elseif type(v) == type(S[k]) then
                S[k] = v
            end
        end
    end
    return true, "loaded " .. tostring(name)
end

function DeleteConfig(name)
    local path = ConfigPath(tostring(name or ""))
    if delfile and isfile and isfile(path) then pcall(delfile, path) return true end
    return false
end

function ConfigList()
    local out = {}
    local ok = pcall(function()
        if listfiles and isfolder and isfolder(ConfigFolder) then
            for _, f in ipairs(listfiles(ConfigFolder)) do
                local n = f:match("([^/\\]+)%.json$")
                if n then table.insert(out, n) end
            end
        end
    end)
    table.sort(out)
    return out
end

function GetAutoload()
    local ok, name = pcall(function()
        local p = ConfigFolder .. "/_autoload.txt"
        return isfile and isfile(p) and readfile(p) or nil
    end)
    return ok and name ~= "" and name or nil
end

function SetAutoload(name)
    if not CanUseFiles() then return false end
    EnsureConfigFolder()
    return pcall(function() writefile(ConfigFolder .. "/_autoload.txt", name or "") end)
end

function ApplyState()
    if S.Fullbright then ApplyFullbright(true) end
    ApplyHazards()
    SetPlatform(S.WaterPlatform)
    SetFly(S.Fly)
    pcall(function() RunService:Set3dRenderingEnabled(not S.Disable3D) end)
    if S.LowGraphics then ApplyLowGraphics() end
    if not S.AnchorFishing then
        local r = GetRoot()
        if r then r.Anchored = false end
    end
end

FarmKeys = { "AutoEquip", "AutoCast", "AutoShake", "AutoReel" }
SetAutoFarm = function(on)
    for _, k in ipairs(FarmKeys) do
        S[k] = on
        if UIRefs[k] then pcall(function() UIRefs[k]:Set(on, true) end) end
    end
    if UIRefs.AutoFarm then pcall(function() UIRefs.AutoFarm:Set(on, true) end) end
    Notify("Auto Farm", on and "ON (equip, cast, shake, reel)" or "OFF", 2)
end

Track(UserInputService.InputBegan:Connect(function(input, processed)
    if processed or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
    if input.KeyCode == S.FarmKey then
        SetAutoFarm(not S.AutoCast)
    elseif input.KeyCode == S.PanicKey then
        if GlobalScope.Fisch_Cleanup then GlobalScope.Fisch_Cleanup() end
    end
end))

FrameCount, FPS = 0, 0
Track(RunService.RenderStepped:Connect(function() FrameCount = FrameCount + 1 end))

function PingMs()
    local ok, ping = pcall(function() return LocalPlayer:GetNetworkPing() * 1000 end)
    if ok and ping and ping > 0 then return math.floor(ping) end
    ok, ping = pcall(function()
        return game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValue()
    end)
    return ok and math.floor(ping) or 0
end

Loop(1, function() return true end, function()
    FPS, FrameCount = FrameCount, 0
    if not WatermarkObj then return end
    WatermarkObj:SetVisible(S.Watermark)
    if not S.Watermark then return end
    local who = S.StreamerMode and "hidden" or LocalPlayer.Name
    WatermarkObj:SetText(('<font color="#%s">fisch</font> | %s | %d fps | %d ms | %s'):format(
        AccentHex, who, FPS, PingMs(), os.date("%H:%M:%S")))
end)

ActiveFeatures = {
    { "AutoCast", "Auto Cast" }, { "AutoShake", "Auto Shake" },
    { "AutoReel", function() return "Auto Reel [" .. S.ReelMode .. "]" end },
    { "RapidMode", "Rapid Mode" }, { "AutoSell", "Auto Sell" }, { "AutoBait", "Auto Bait" },
    { "AutoQuests", "Auto Quests" }, { "AutoCrab", "Crab Cages" }, { "AutoMeteor", "Meteors" },
    { "AutoEventZone", "Event Zones" }, { "AutoTotem", "Auto Totem" }, { "AutoSpear", "Auto Spear" },
    { "AutoHarpoon", "Auto Harpoon" }, { "AutoDailyShop", "Daily Shop" }, { "AutoAquarium", "Aquarium" },
    { "NoHazards", "No Hazards" }, { "Fly", "Fly" }, { "Noclip", "Noclip" }, { "WalkSpeedOn", "Speed" },
    { "PlayerESP", "Player ESP" }, { "LootESP", "Loot ESP" }, { "RoamingESP", "Roaming ESP" },
    { "Fullbright", "Fullbright" }, { "AntiAFK", "Anti-AFK" },
}

Loop(0.5, function() return ArrayListObj ~= nil end, function()
    ArrayListObj:SetVisible(S.ArrayList)
    if not S.ArrayList then return end
    local items = {}
    for _, f in ipairs(ActiveFeatures) do
        if S[f[1]] then table.insert(items, type(f[2]) == "function" and f[2]() or f[2]) end
    end
    table.sort(items, function(a, b) return #a > #b end)
    ArrayListObj:SetItems(items)
end)

Obelus = {}
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

    local function GuiParent()
        local ok, hui = pcall(function() return gethui and gethui() end)
        if ok and hui then return hui end
        local core = game:GetService("CoreGui")
        if pcall(function() local f = Instance.new("Folder"); f.Parent = core; f:Destroy() end) then return core end
        return PlayerGui
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
                    return Create("Frame", { BackgroundTransparency = 1, BorderSizePixel = 0, Size = UDim2.new(1, 0, 0, h), LayoutOrder = section.Count, Parent = content })
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
                        if not k.binding or input.UserInputType ~= Enum.UserInputType.Keyboard then return end
                        k.binding = false
                        if input.KeyCode ~= Enum.KeyCode.Escape then
                            k.key = input.KeyCode
                            if kcfg.Callback then task.spawn(kcfg.Callback, input.KeyCode) end
                        end
                        paint()
                    end)
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

function WrapTab(page)
    local w = { NextSide = "Left", Current = nil }

    local function safe(cb, what)
        return function(...)
            if not cb then return end
            local ok, err = pcall(cb, ...)
            if not ok then warn("[Fisch] " .. what .. " callback error: " .. tostring(err)) end
        end
    end

    function w:Section(cfg)
        local title = type(cfg) == "string" and cfg or (cfg and (cfg.Title or cfg.Name)) or "section"
        local side = (type(cfg) == "table" and cfg.Side) or w.NextSide
        w.NextSide = (side == "Left") and "Right" or "Left"
        w.Current = page:Section({ Name = tostring(title):lower(), Side = side })
        return w.Current
    end

    local function sec()
        if not w.Current then w:Section("general") end
        return w.Current
    end

    function w:Toggle(cfg)
        return sec():Toggle({ Name = cfg.Title, Default = cfg.Default, Tip = cfg.Desc, Callback = safe(cfg.Callback, "toggle") })
    end

    function w:Slider(cfg)
        return sec():Slider({
            Name = cfg.Title, Min = cfg.Min, Max = cfg.Max, Default = cfg.Default, Step = cfg.Step or 1,
            Suffix = cfg.Suffix, Tip = cfg.Desc, Callback = safe(cfg.Callback, "slider"),
        })
    end

    function w:Button(cfg)
        return sec():Button({ Name = cfg.Title, Tip = cfg.Desc, Callback = safe(cfg.Callback, "button") })
    end

    function w:Dropdown(cfg)
        local opts = cfg.Options or {}
        local d = sec():Dropdown({ Name = cfg.Title, Options = opts, Default = cfg.Default or opts[1], Tip = cfg.Desc, Callback = safe(cfg.Callback, "dropdown") })
        local el = {}
        function el:Refresh(newOpts) d:Refresh(newOpts) end
        function el:Set(v) d:Set(v) end
        el.GetValue = function() return d:Get() end
        return el
    end

    function w:Keybind(cfg)
        local def = cfg.Default
        if type(def) == "string" then def = Enum.KeyCode[def] end
        return sec():Keybind({
            Name = cfg.Title, Default = def,
            Callback = function(key) if cfg.Callback then pcall(cfg.Callback, key.Name) end end,
        })
    end

    function w:Input(cfg)
        return sec():Textbox({ Name = cfg.Title, Default = cfg.Default, Placeholder = cfg.Placeholder, Callback = safe(cfg.Callback, "input") })
    end

    function w:Label(cfg)
        local text = (cfg.Title and (tostring(cfg.Title) .. ": ") or "") .. tostring(cfg.Desc or cfg.Content or "")
        local l = sec():Label({ Text = text })
        return { SetLabel = function(_, t) l:Set(t) end }
    end

    return w
end

function WrapWindow(win)
    local ww = { Raw = win }
    function ww:Tab(cfg)
        return WrapTab(win:Page({ Name = tostring(cfg.Title or cfg.Name or "tab"):lower() }))
    end
    function ww:SetToggleKey(k)
        if type(k) == "string" then k = Enum.KeyCode[k] end
        if typeof(k) == "EnumItem" then win.ToggleKey = k; S.ToggleKey = k end
    end
    function ww:Toggle(state)
        if state == nil then state = not win.Main.Visible end
        win.Main.Visible = state
    end
    function ww:SetTitle(t) pcall(function() win.Main:FindFirstChildWhichIsA("Frame"):FindFirstChildWhichIsA("TextLabel").Text = t end) end
    function ww:Destroy() win:Destroy() end
    return ww
end

function ApplyAccent(name)
    local color = AccentColors[name] or AccentColors.Purple
    S.Accent = AccentColors[name] and name or "Purple"
    Obelus:SetAccent(color)
    AccentHex = Obelus:AccentHex()
end

function BuildProgressTab(Window)
    local Tab = Window:Tab({ Title = "Progress" })

    Tab:Section("Auto Enchant")
    local enchantLabel = Tab:Label({ Title = "Current", Desc = "-" })
    local function refreshEnchant()
        local p, s2 = CurrentEnchant()
        enchantLabel:SetLabel(("Current: %s%s  (rod: %s)"):format(tostring(p or "none"),
            (s2 and s2 ~= "none") and (" + " .. s2) or "", tostring(CurrentRodName() or "?")))
    end
    refreshEnchant()
    Tab:Dropdown({ Title = "Method", Options = { "Altar", "Enchant Anywhere (pass)" }, Default = S.EnchantMethod,
        Desc = "Altar teleports you to the enchant altar (must be loaded). The pass works anywhere.",
        Callback = function(v) S.EnchantMethod = v end })
    Tab:Input({ Title = "Target Enchant", Default = S.EnchantTarget, Placeholder = "e.g. Hasty, Clever, Mutated",
        Callback = function(t) S.EnchantTarget = t end })
    Tab:Slider({ Title = "Max Rolls", Min = 1, Max = 200, Default = S.EnchantMaxTries, Step = 1,
        Callback = function(v) S.EnchantMaxTries = v end })
    Tab:Button({ Title = "Start / Stop Auto Enchant", Desc = "Uses your Enchant Relics until the target enchant appears on your equipped rod.",
        Callback = function()
            if S.EnchantTarget == "" then Notify("Enchant", "Type a target enchant first.", 3) return end
            AutoEnchant()
            refreshEnchant()
        end })
    Tab:Button({ Title = "Refresh", Callback = refreshEnchant })

    Tab:Section("Auto Appraise")
    Tab:Dropdown({ Title = "Method", Options = { "Appraiser NPC", "Appraise Anywhere (pass)" }, Default = S.AppraiseMethod,
        Desc = "NPC: talk to the Appraiser once (hold a fish, choose Appraise) so the script can reuse it.",
        Callback = function(v) S.AppraiseMethod = v end })
    Tab:Input({ Title = "Target Mutation", Default = S.AppraiseMutation, Placeholder = "blank = any mutation",
        Callback = function(t) S.AppraiseMutation = t end })
    Tab:Toggle({ Title = "Require A Mutation", Default = S.AppraiseAnyMutation,
        Desc = "With no target typed, stop on any mutation.", Callback = function(v) S.AppraiseAnyMutation = v end })
    Tab:Slider({ Title = "Min Weight", Min = 0, Max = 5000, Default = S.AppraiseMinWeight, Step = 10, Suffix = "kg",
        Callback = function(v) S.AppraiseMinWeight = v end })
    Tab:Slider({ Title = "Max Appraisals", Min = 1, Max = 200, Default = S.AppraiseMaxTries, Step = 1,
        Callback = function(v) S.AppraiseMaxTries = v end })
    Tab:Button({ Title = "Start / Stop Auto Appraise", Desc = "Hold the fish first. Each appraisal costs C$.",
        Callback = AutoAppraise })

    Tab:Section("Quests")
    Tab:Toggle({ Title = "Auto Claim Quests", Default = S.AutoQuests,
        Desc = "Every 45s: claims finished reputation quests, challenges and rod mastery quests.",
        Callback = function(v) S.AutoQuests = v end })
    Tab:Toggle({ Title = "Auto Accept Reputation Quests", Default = S.AutoAcceptQuests,
        Callback = function(v) S.AutoAcceptQuests = v end })
    Tab:Button({ Title = "Claim Everything Now", Callback = function()
        Notify("Quests", "Checked " .. QuestTick() .. " reputation quests + challenges + mastery.", 4)
    end })

    Tab:Section("Bestiary Helper")
    local missing = UncaughtFish(S.BestiaryRarity)
    local selMissing = missing[1]
    local countLabel = Tab:Label({ Title = "Missing", Desc = #missing .. " fish" })
    local infoLabel = Tab:Label({ Desc = selMissing and FishInfo(selMissing) or "-" })
    local missDD
    Tab:Dropdown({ Title = "Min Rarity", Options = RarityNames(), Default = S.BestiaryRarity, Callback = function(v)
        S.BestiaryRarity = v
        missing = UncaughtFish(v)
        missDD:Refresh(missing)
        selMissing = missDD.GetValue()
        countLabel:SetLabel("Missing: " .. #missing .. " fish")
        infoLabel:SetLabel(selMissing and FishInfo(selMissing) or "-")
    end })
    missDD = Tab:Dropdown({ Title = "Uncaught Fish", Options = missing, Callback = function(v)
        selMissing = v
        infoLabel:SetLabel(FishInfo(v))
    end })
    Tab:Button({ Title = "Go To Its Zone", Callback = function()
        if selMissing and not GoToFishZone(selMissing) then
            Notify("Bestiary", "Zone '" .. tostring(FishLibrary[selMissing].From) .. "' isn't loaded — try the Teleports tab.", 4)
        end
    end })
    Tab:Button({ Title = "Equip Its Favourite Bait", Callback = function()
        local def = selMissing and FishLibrary[selMissing]
        if def and def.FavouriteBait and OwnedBaits()[def.FavouriteBait] then
            EquipBait(def.FavouriteBait)
            Notify("Bestiary", "Equipped " .. def.FavouriteBait, 3)
        else
            Notify("Bestiary", "You don't own its favourite bait.", 3)
        end
    end })
end

function BuildFishingTab(Window)
    local Tab = Window:Tab({ Title = "Fishing" })

    Tab:Section("Auto Farm")
    UIRefs.AutoFarm = Tab:Toggle({
        Title = "Auto Farm (all)", Default = S.AutoCast and S.AutoShake and S.AutoReel,
        Desc = "Turns on equip + cast + shake + reel together. Hotkey in Settings (default F6).",
        Callback = function(v) SetAutoFarm(v) end,
    })
    Tab:Toggle({
        Title = "Rapid Mode", Default = S.RapidMode,
        Desc = "Casts the instant the rod is free, finishes reels with zero delay and skips the reel cleanup wait.",
        Callback = function(v) S.RapidMode = v end,
    })
    Tab:Toggle({ Title = "Stop On Rare Catch", Default = S.StopOnRare,
        Desc = "Turns Auto Farm off when you hook a fish at/above the rarity below.",
        Callback = function(v) S.StopOnRare = v end })
    Tab:Dropdown({ Title = "Stop Rarity", Options = RarityNames(), Default = S.StopRarity,
        Callback = function(v) S.StopRarity = v end })

    Tab:Section("Cast")
    UIRefs.AutoEquip = Tab:Toggle({ Title = "Auto Equip Rod", Default = S.AutoEquip, Callback = function(v) S.AutoEquip = v end })
    UIRefs.AutoCast = Tab:Toggle({
        Title = "Auto Cast", Default = S.AutoCast,
        Desc = "Casts through FishingRod/Cast whenever the rod is idle.",
        Callback = function(v) S.AutoCast = v end,
    })
    Tab:Toggle({ Title = "Perfect Cast", Default = S.PerfectCast, Callback = function(v) S.PerfectCast = v end })
    Tab:Slider({ Title = "Min Cast Power", Min = 50, Max = 100, Default = S.CastPowerMin, Step = 1, Suffix = "%",
        Desc = "Used when Perfect Cast is off.", Callback = function(v) S.CastPowerMin = v end })
    Tab:Slider({ Title = "Cast Delay", Min = 0, Max = 5, Default = S.CastDelay, Step = 0.1, Suffix = "s",
        Desc = "Ignored in Rapid Mode.", Callback = function(v) S.CastDelay = v end })

    Tab:Section("Shake")
    UIRefs.AutoShake = Tab:Toggle({
        Title = "Auto Shake", Default = S.AutoShake,
        Desc = "Shakes while the shake UI is open.",
        Callback = function(v) S.AutoShake = v end,
    })
    Tab:Dropdown({ Title = "Shake Method", Options = { "Enter Key", "Click Button", "Remote" }, Default = S.ShakeMethod,
        Desc = "Enter Key uses the game's own shake handler (recommended). Remote can be rejected on slow-shake rods.",
        Callback = function(v) S.ShakeMethod = v end })
    Tab:Slider({ Title = "Extra Shake Delay", Min = 0, Max = 1.5, Default = S.ShakeInterval, Step = 0.01, Suffix = "s",
        Desc = "0 = shake the instant your rod's cooldown ends, which is the fastest the server accepts. Faster shakes make the server cancel the shake phase.",
        Callback = function(v) S.ShakeInterval = v end })

    Tab:Section("Reel")
    UIRefs.AutoReel = Tab:Toggle({
        Title = "Auto Reel", Default = S.AutoReel,
        Desc = "Instant: finishes as soon as the server starts the reel. Full Bar: normal-speed perfect catch.",
        Callback = function(v) S.AutoReel = v end,
    })
    Tab:Dropdown({ Title = "Reel Mode", Options = { "Instant", "Follow Fish", "Full Bar" }, Default = S.ReelMode,
        Desc = "Follow Fish: normal-size bar glued to the fish. Full Bar: bar fills the track.",
        Callback = function(v) S.ReelMode = v end })
    Tab:Slider({ Title = "Follow Smoothness", Min = 0, Max = 10, Default = S.FollowSmooth, Step = 0.5,
        Desc = "Follow Fish only. 0 = locked on, higher = drifts behind like a human.",
        Callback = function(v) S.FollowSmooth = v end })
    Tab:Slider({ Title = "Instant Delay", Min = 0, Max = 8, Default = S.InstantDelay, Step = 0.1, Suffix = "s",
        Desc = "Extra wait before finishing. 0 = immediate.", Callback = function(v) S.InstantDelay = v end })
    Tab:Toggle({ Title = "Hook Notifications", Default = S.HookNotify, Callback = function(v) S.HookNotify = v end })
    Tab:Dropdown({ Title = "Notify Rarity", Options = RarityNames(), Default = S.NotifyRarity,
        Desc = "Only notify for fish at/above this rarity.", Callback = function(v) S.NotifyRarity = v end })
    Tab:Toggle({ Title = "Anchor While Fishing", Default = S.AnchorFishing,
        Desc = "Stops you drifting or getting pushed while casting/reeling.",
        Callback = function(v)
            S.AnchorFishing = v
            if not v then local r = GetRoot(); if r then r.Anchored = false end end
        end })

    Tab:Section("Other Minigames")
    Tab:Toggle({ Title = "Auto Spear Fishing", Default = S.AutoSpear,
        Desc = "Finishes the spear (stab) minigame as soon as it's ready.",
        Callback = function(v) S.AutoSpear = v end })
    Tab:Toggle({ Title = "Auto Harpoon Minigame", Default = S.AutoHarpoon,
        Desc = "Finishes the harpoon gun minigame as soon as it's ready.",
        Callback = function(v) S.AutoHarpoon = v end })
    Tab:Slider({ Title = "Minigame Delay", Min = 0, Max = 5, Default = S.MinigameDelay, Step = 0.1, Suffix = "s",
        Callback = function(v) S.MinigameDelay = v end })

    Tab:Section("Rod Swap")
    local rodNames = OwnedRodNames()
    local selSwap = rodNames[1]
    local swapDD = Tab:Dropdown({ Title = "Owned Rod", Options = rodNames, Callback = function(v) selSwap = v end })
    Tab:Button({ Title = "Equip Rod", Desc = "Swaps to this rod from anywhere.", Callback = function()
        if selSwap then Notify("Rod", SwapRod(selSwap) and ("Equipped " .. selSwap) or "Swap failed.", 3) end
    end })
    Tab:Button({ Title = "Refresh Rods", Callback = function()
        swapDD:Refresh(OwnedRodNames()); selSwap = swapDD.GetValue()
    end })

    Tab:Section("Bait")
    Tab:Toggle({ Title = "Auto Equip Bait", Default = S.AutoBait,
        Desc = "Keeps a bait equipped; swaps when you run out.",
        Callback = function(v) S.AutoBait = v end })
    local baitDD = Tab:Dropdown({ Title = "Bait", Options = OwnedBaitNames(), Default = S.BaitChoice,
        Desc = "Best Available = highest rarity bait you own.",
        Callback = function(v) S.BaitChoice = v end })
    Tab:Button({ Title = "Refresh Baits", Callback = function()
        baitDD:Refresh(OwnedBaitNames())
        S.BaitChoice = baitDD.GetValue() or "Best Available"
    end })

    Tab:Section("Session")
    local label = Tab:Label({ Title = "Stats", Desc = "0 casts / 0 catches / 0 shakes" })
    local lastLabel = Tab:Label({ Title = "Last Catch", Desc = "-" })
    local rareLabel = Tab:Label({ Title = "Rares", Desc = "-" })
    local gen = UIGen
    Loop(1, function() return gen == UIGen end, function()
        local mins = math.max((tick() - Stats.Started) / 60, 1 / 60)
        label:SetLabel(("Stats: %d casts / %d catches (%.1f/min)"):format(Stats.Casts, Stats.Catches, Stats.Catches / mins))
        lastLabel:SetLabel("Last Catch: " .. (S.CatchLog[1] or "-"))
        local parts = {}
        for _, r in ipairs(RarityNames()) do
            local n = Stats.ByRarity[r]
            if n and RarityOrder(r) >= RarityOrder("Legendary") then table.insert(parts, r .. " " .. n) end
        end
        rareLabel:SetLabel("Rares: " .. (#parts > 0 and table.concat(parts, ", ") or "none yet"))
    end)
    Tab:Button({ Title = "Reset Session Stats", Callback = function()
        Stats.Casts, Stats.Catches, Stats.Shakes, Stats.Started = 0, 0, 0, tick()
        table.clear(Stats.ByRarity)
    end })
    Tab:Button({ Title = "Reset Rod", Desc = "Fires FishingRod/Reset if the rod gets stuck.", Callback = function()
        local re = Remote("RE/FishingRod/Reset")
        if re then re:FireServer() end
    end })
end

function BuildSellTab(Window)
    local Tab = Window:Tab({ Title = "Selling" })

    Tab:Section("Sell")
    Tab:Dropdown({ Title = "Method", Options = { "Direct (no teleport)", "Merchant Teleport", "Sell Anywhere (gamepass)" }, Default = S.SellMethod,
        Desc = "Direct calls SellAll from where you stand; if the server wants you near a merchant, use Merchant Teleport.",
        Callback = function(v) S.SellMethod = v end })
    Tab:Button({ Title = "Sell All Now", Callback = SellAll })
    Tab:Toggle({ Title = "Auto Sell", Default = S.AutoSell, Desc = "Waits until you're not mid-catch.",
        Callback = function(v) S.AutoSell = v; LastSell = tick() end })
    Tab:Slider({ Title = "Sell Every", Min = 1, Max = 30, Default = S.SellInterval, Step = 1, Suffix = "min",
        Callback = function(v) S.SellInterval = v end })

    Tab:Section("Protect Rares")
    Tab:Toggle({ Title = "Keep Rares", Default = S.KeepRares,
        Desc = "Favourites fish at/above the rarity below before every sell, so they're never sold.",
        Callback = function(v) S.KeepRares = v end })
    Tab:Dropdown({ Title = "Keep Rarity", Options = RarityNames(), Default = S.KeepRarity,
        Callback = function(v) S.KeepRarity = v end })
    Tab:Toggle({ Title = "Also Keep Mutated", Default = S.KeepMutated,
        Desc = "Protect any fish with a mutation, whatever its rarity.",
        Callback = function(v) S.KeepMutated = v end })
    Tab:Button({ Title = "Favourite Keepers Now", Callback = function()
        Notify("Sell", FavouriteKeepers() .. " fish favourited.", 3)
    end })
    Tab:Button({ Title = "Sell All From Storage", Callback = function()
        Notify("Sell", SellStorage() and "Storage sold." or "Storage sell refused.", 3)
    end })

    Tab:Section("Daily Shop")
    local shopLabel = Tab:Label({ Title = "Items", Desc = "open the daily shop once to load its items" })
    Tab:Slider({ Title = "Max Price", Min = 100, Max = 100000, Default = S.DailyMaxPrice, Step = 100, Suffix = " C$",
        Callback = function(v) S.DailyMaxPrice = v end })
    Tab:Button({ Title = "Buy All Daily Items", Desc = "C$ items only, under the max price. Robux items are always skipped.",
        Callback = function()
            Notify("Daily Shop", "Bought " .. BuyDailyShop() .. " items.", 3)
        end })
    Tab:Toggle({ Title = "Auto Buy Daily Items", Default = S.AutoDailyShop, Callback = function(v) S.AutoDailyShop = v end })
    local gen = UIGen
    Loop(3, function() return gen == UIGen end, function()
        local names = {}
        for key, item in pairs(DailyItems) do
            if type(item) == "table" then table.insert(names, ("%s (%s C$)"):format(tostring(key), tostring(item.price or "?"))) end
        end
        shopLabel:SetLabel("Items: " .. (#names > 0 and table.concat(names, ", ") or "open the daily shop once to load them"))
    end)

    Tab:Section("Aquarium")
    Tab:Button({ Title = "Claim Aquarium Profit", Callback = ClaimAquarium })
    Tab:Toggle({ Title = "Auto Claim (5 min)", Default = S.AutoAquarium, Callback = function(v) S.AutoAquarium = v end })

    Tab:Section("Rewards")
    Tab:Button({ Title = "Claim Daily Reward", Callback = ClaimDaily })
    Tab:Toggle({ Title = "Auto Claim Daily", Default = S.AutoDaily, Desc = "Tries every 10 minutes.",
        Callback = function(v) S.AutoDaily = v end })
    Tab:Button({ Title = "Claim Group Reward", Callback = ClaimGroupReward })
    Tab:Button({ Title = "Appraise Held Fish", Desc = "Needs the Appraise Anywhere pass.", Callback = AppraiseHeld })
end

function BuildTeleportTab(Window)
    local Tab = Window:Tab({ Title = "Teleports" })

    local islands, islandMap = IslandList()
    local npcs, npcMap = NPCList()
    local selIsland, selNpc = islands[1], npcs[1]

    Tab:Section("Islands")
    local islandDD = Tab:Dropdown({ Title = "Island", Options = islands, Callback = function(v) selIsland = v end })
    Tab:Button({ Title = "Teleport to Island", Callback = function()
        local p = selIsland and islandMap[selIsland]
        if p and p.Parent then TeleportTo(p.CFrame + Vector3.new(0, 5, 0)) else Notify("Teleport", "Spawn not loaded.", 3) end
    end })

    Tab:Section("NPCs")
    local npcDD = Tab:Dropdown({ Title = "NPC", Options = npcs, Callback = function(v) selNpc = v end })
    Tab:Button({ Title = "Teleport to NPC", Callback = function()
        local p = selNpc and npcMap[selNpc]
        if p and p.Parent then TeleportTo(p.CFrame * CFrame.new(0, 0, -4)) else Notify("Teleport", "NPC not loaded.", 3) end
    end })

    local pads, padMap = TpSpotList()
    local selPad = pads[1]
    Tab:Section("Teleport Pads")
    local padDD = Tab:Dropdown({ Title = "Pad", Options = pads, Callback = function(v) selPad = v end })
    Tab:Button({ Title = "Teleport to Pad", Callback = function()
        local p = selPad and padMap[selPad]
        if p and p.Parent then TeleportTo(p.CFrame + Vector3.new(0, 4, 0)) else Notify("Teleport", "Pad not loaded.", 3) end
    end })

    local plist = PlayerList()
    local selPlayer = plist[1]
    Tab:Section("Players")
    local playerDD = Tab:Dropdown({ Title = "Player", Options = plist, Callback = function(v) selPlayer = v end })
    Tab:Button({ Title = "Teleport to Player", Callback = function()
        local p = selPlayer and Players:FindFirstChild(selPlayer)
        local r = p and p.Character and p.Character:FindFirstChild("HumanoidRootPart")
        if r then TeleportTo(r.CFrame * CFrame.new(0, 0, 3)) else Notify("Teleport", "Player has no character.", 3) end
    end })

    Tab:Section("Waypoints")
    local wpName = ""
    local selWp = nil
    Tab:Input({ Title = "Name", Placeholder = "e.g. my fishing spot", Callback = function(t) wpName = t end })
    local wpDD
    Tab:Button({ Title = "Save Current Position", Callback = function()
        local name = SaveWaypoint(wpName)
        if not name then return end
        wpDD:Refresh(WaypointOrder)
        selWp = name
        Notify("Waypoints", "Saved " .. name, 3)
    end })
    wpDD = Tab:Dropdown({ Title = "Waypoint", Options = WaypointOrder, Callback = function(v) selWp = v end })
    selWp = WaypointOrder[1]
    Tab:Button({ Title = "Teleport to Waypoint", Callback = function()
        local cf = selWp and Waypoints[selWp]
        if cf then TeleportTo(cf) else Notify("Waypoints", "Pick a waypoint first.", 3) end
    end })
    Tab:Button({ Title = "Delete Waypoint", Callback = function()
        if not selWp then return end
        DeleteWaypoint(selWp)
        wpDD:Refresh(WaypointOrder)
        selWp = wpDD.GetValue()
    end })
    Tab:Label({ Desc = "Waypoints are saved to fisch_hub/waypoints.json and come back next session." })

    Tab:Section("Teleport Settings")
    Tab:Dropdown({ Title = "Teleport Method", Options = { "Instant", "Tween" }, Default = S.TPMode,
        Desc = "Tween flies you there in a straight line instead of snapping.",
        Callback = function(v) S.TPMode = v end })
    Tab:Slider({ Title = "Tween Speed", Min = 50, Max = 600, Default = S.TweenSpeed, Step = 10, Suffix = " st/s",
        Callback = function(v) S.TweenSpeed = v end })
    Tab:Toggle({ Title = "Ctrl + Click Teleport", Default = S.ClickTP, Callback = function(v) S.ClickTP = v end })

    Tab:Button({ Title = "Refresh Lists", Callback = function()
        islands, islandMap = IslandList()
        npcs, npcMap = NPCList()
        pads, padMap = TpSpotList()
        islandDD:Refresh(islands); selIsland = islandDD.GetValue()
        npcDD:Refresh(npcs); selNpc = npcDD.GetValue()
        padDD:Refresh(pads); selPad = padDD.GetValue()
        playerDD:Refresh(PlayerList()); selPlayer = playerDD.GetValue()
        Notify("Teleport", #islands .. " islands, " .. #npcs .. " NPCs, " .. #pads .. " pads.", 3)
    end })
end

function BuildZonesTab(Window)
    local Tab = Window:Tab({ Title = "Zones" })

    local zones, zoneMap = ZoneList()
    local selZone = zones[1]

    Tab:Section("Fishing Zones")
    local zoneDD = Tab:Dropdown({ Title = "Zone", Options = zones,
        Desc = "Event zones (hunts, pools) show up here while they're active.",
        Callback = function(v) selZone = v end })
    Tab:Button({ Title = "Teleport to Zone", Desc = "Drops you on the water with a platform to stand on.", Callback = function()
        local z = selZone and zoneMap[selZone]
        if z and z.Parent then TeleportToZone(z) else Notify("Zones", "Zone gone — refresh the list.", 3) end
    end })
    Tab:Button({ Title = "Refresh Zones", Callback = function()
        zones, zoneMap = ZoneList()
        zoneDD:Refresh(zones); selZone = zoneDD.GetValue()
        Notify("Zones", #zones .. " zones loaded.", 3)
    end })
    Tab:Button({ Title = "Teleport to Nearest Zone", Callback = function()
        local z = NearestZone()
        if z then TeleportToZone(z) else Notify("Zones", "No fishing zones loaded.", 3) end
    end })
    Tab:Toggle({ Title = "New Zone Alerts", Default = S.ZoneNotify, Callback = function(v) S.ZoneNotify = v end })
    Tab:Toggle({ Title = "Auto Go To Event Zones", Default = S.AutoEventZone,
        Desc = "When a new zone spawns (hunts, pools), finishes your current catch and moves you onto it.",
        Callback = function(v) S.AutoEventZone = v end })

    Tab:Section("Water")
    Tab:Toggle({ Title = "Water Platform", Default = S.WaterPlatform,
        Desc = "Invisible floor at your current height that follows you. Walk on water and fish anywhere.",
        Callback = function(v)
            S.WaterPlatform = v
            SetPlatform(v)
            local r = GetRoot()
            if v and r and Platform then Platform.CFrame = CFrame.new(r.Position - Vector3.new(0, 3.5, 0)) end
        end })
end

function BuildWorldTab(Window)
    local Tab = Window:Tab({ Title = "World" })

    Tab:Section("Treasure")
    local mapLabel = Tab:Label({ Title = "Maps", Desc = "-" })
    local function refreshMaps()
        local maps = TreasureMaps()
        local repaired = 0
        for _, m in ipairs(maps) do if m.repaired then repaired = repaired + 1 end end
        mapLabel:SetLabel(("Maps: %d total, %d repaired (ready)"):format(#maps, repaired))
    end
    refreshMaps()
    Tab:Button({ Title = "Open All Treasure Chests", Desc = "Teleports to every repaired map's chest, opens it, returns.",
        Callback = function()
            local n = OpenTreasures()
            Notify("Treasure", n .. " chests opened.", 4)
            refreshMaps()
        end })
    Tab:Button({ Title = "Refresh Map Count", Callback = refreshMaps })

    Tab:Section("Meteors")
    Tab:Toggle({ Title = "Meteor Alerts", Default = S.MeteorNotify, Callback = function(v) S.MeteorNotify = v end })
    Tab:Toggle({ Title = "Auto Collect Meteors", Default = S.AutoMeteor,
        Desc = "After impact, teleports to each meteor item and picks it up.",
        Callback = function(v) S.AutoMeteor = v end })
    Tab:Toggle({ Title = "Return After Collecting", Default = S.MeteorReturn, Callback = function(v) S.MeteorReturn = v end })
    Tab:Button({ Title = "Teleport to Last Meteor", Callback = function()
        if LastMeteor then TeleportTo(CFrame.new(LastMeteor + Vector3.new(0, 6, 0)))
        else Notify("Meteor", "No meteor this session yet.", 3) end
    end })
    Tab:Button({ Title = "Collect Meteor Items Now", Callback = function()
        Notify("Meteor", CollectMeteor() .. " items visited.", 3)
    end })

    Tab:Section("Crab Cages")
    Tab:Toggle({ Title = "Auto Claim Crab Cages", Default = S.AutoCrab, Desc = "Checks every 30s.",
        Callback = function(v) S.AutoCrab = v end })
    Tab:Toggle({ Title = "Teleport If Needed", Default = S.CrabTP,
        Desc = "If a remote claim is refused, hop to the cage (when loaded) and retry.",
        Callback = function(v) S.CrabTP = v end })
    Tab:Button({ Title = "Claim Crab Cages Now", Callback = function()
        Notify("Crab Cages", ClaimCrabCages() .. " cages claimed.", 3)
    end })

    Tab:Section("Collection")
    Tab:Button({ Title = "Claim Rod Journal Rewards", Desc = "Tries the journal reward for every rod you own.",
        Callback = function()
            Notify("Rod Journal", "Sent claims for " .. ClaimRodJournal() .. " rods.", 3)
        end })
    Tab:Toggle({ Title = "Loot ESP", Default = S.LootESP, Desc = "Highlights treasure chests (gold) and meteor items (orange).",
        Callback = function(v) S.LootESP = v end })
    Tab:Button({ Title = "Discover All Locations", Desc = "Unlocks every island/area you haven't visited yet.",
        Callback = function()
            Notify("Locations", "Discovering " .. DiscoverAll() .. " locations...", 4)
        end })
    Tab:Toggle({ Title = "Server Event Alerts", Default = S.EventNotify,
        Desc = "Pops up server-wide announcements (hunts, nukes, events).",
        Callback = function(v) S.EventNotify = v end })

    Tab:Section("Event Timer")
    local timerLabel = Tab:Label({ Desc = EventStatus() })
    local gen = UIGen
    Loop(1, function() return gen == UIGen end, function() timerLabel:SetLabel(EventStatus()) end)

    Tab:Section("Event Server Hop")
    Tab:Input({ Title = "Zone Keyword", Default = S.HopKeyword, Placeholder = "e.g. Megalodon, Whale, Hunt",
        Callback = function(t) S.HopKeyword = t end })
    Tab:Slider({ Title = "Max Servers", Min = 1, Max = 100, Default = S.HopMax, Step = 1, Callback = function(v) S.HopMax = v end })
    Tab:Toggle({ Title = "Start Farming When Found", Default = S.HopStartFarm, Callback = function(v) S.HopStartFarm = v end })
    Tab:Input({ Title = "Re-run Loader", Default = S.HopLoader,
        Placeholder = 'loadstring(readfile("fisch.lua"))()',
        Callback = function(t) S.HopLoader = t end })
    Tab:Label({ Desc = "The loader re-runs the script after each hop. Default reads fisch.lua from your executor's workspace folder; use your own loadstring URL if you host it." })
    Tab:Button({ Title = "Start Event Hop", Callback = function()
        if S.HopKeyword == "" then Notify("Event Hop", "Type a zone keyword first.", 3) return end
        if not (queue_on_teleport or (syn and syn.queue_on_teleport)) then
            Notify("Event Hop", "Your executor has no queue_on_teleport — the hop can't continue after joining.", 6)
            return
        end
        StartEventHop(S.HopKeyword)
    end })
    Tab:Button({ Title = "Stop Event Hop", Callback = function()
        StopEventHop()
        Notify("Event Hop", "Stopped.", 3)
    end })

    Tab:Section("Totems")
    local totems = TotemNames()
    if S.TotemChoice == "" then S.TotemChoice = totems[1] or "" end
    local totemDD = Tab:Dropdown({ Title = "Totem", Options = totems, Default = S.TotemChoice,
        Callback = function(v) S.TotemChoice = v end })
    Tab:Button({ Title = "Use Totem Now", Callback = function()
        Notify("Totem", UseTotem(S.TotemChoice) and ("Used " .. S.TotemChoice) or "You don't have that totem.", 3)
    end })
    Tab:Toggle({ Title = "Auto Use Totem", Default = S.AutoTotem, Callback = function(v) S.AutoTotem = v end })
    Tab:Dropdown({ Title = "When", Options = { "When Night", "When Day", "Every X Minutes" }, Default = S.TotemWhen,
        Callback = function(v) S.TotemWhen = v end })
    Tab:Slider({ Title = "Every", Min = 1, Max = 60, Default = S.TotemEvery, Step = 1, Suffix = " min",
        Callback = function(v) S.TotemEvery = v end })
    Tab:Button({ Title = "Refresh Totems", Callback = function()
        totemDD:Refresh(TotemNames()); S.TotemChoice = totemDD.GetValue() or ""
    end })
end

function BuildExtrasTab(Window)
    local Tab = Window:Tab({ Title = "Extras" })

    Tab:Section("Codes")
    local codeText = ""
    Tab:Input({ Title = "Code(s)", Placeholder = "one code, or several separated by commas",
        Callback = function(t) codeText = t end })
    Tab:Button({ Title = "Redeem", Callback = function()
        Notify("Codes", "Sent " .. RedeemCodes(codeText) .. " code(s).", 3)
    end })
    Tab:Button({ Title = "Redeem All Known Codes", Desc = "Tries every code in the built-in list (about 30s). Used or expired codes are simply refused.",
        Callback = function()
            Notify("Codes", "Redeeming " .. #KnownCodes .. " codes...", 3)
            Notify("Codes", "Done — sent " .. RedeemAllCodes() .. " codes. Check your inventory/chat.", 5)
        end })

    Tab:Section("Boats")
    local boats = OwnedBoats()
    local selBoat = boats[1]
    local boatDD = Tab:Dropdown({ Title = "Boat", Options = boats, Callback = function(v) selBoat = v end })
    Tab:Button({ Title = "Spawn Boat", Desc = "Spawns your boat from anywhere.", Callback = function()
        if selBoat then SpawnBoat(selBoat) else Notify("Boat", "No owned boats found.", 3) end
    end })
    Tab:Button({ Title = "Refresh Boats", Callback = function()
        boatDD:Refresh(OwnedBoats()); selBoat = boatDD.GetValue()
    end })

    Tab:Section("Survival")
    Tab:Toggle({ Title = "No Oxygen / Cold / Pressure Damage", Default = S.NoHazards,
        Desc = "Stops the oxygen, temperature and pressure meters. Swim and dive anywhere.",
        Callback = function(v)
            S.NoHazards = v
            ApplyHazards()
        end })

    Tab:Section("Discord Webhook")
    Tab:Input({ Title = "Webhook URL", Placeholder = "https://discord.com/api/webhooks/...",
        Callback = function(t) S.WebhookURL = tostring(t or "") end })
    Tab:Dropdown({ Title = "Min Rarity", Options = RarityNames(), Default = S.WebhookRarity,
        Desc = "Posts to your webhook when you hook a fish at/above this.",
        Callback = function(v) S.WebhookRarity = v end })
    Tab:Button({ Title = "Send Test", Callback = function()
        if S.WebhookURL == "" then Notify("Webhook", "Paste a webhook URL first.", 3) return end
        if not HttpRequest then Notify("Webhook", "Your executor has no HTTP request function.", 4) return end
        local saved = S.WebhookRarity
        S.WebhookRarity = "Trash"
        SendWebhook("Test Fish", "Trash")
        S.WebhookRarity = saved
        Notify("Webhook", "Test sent.", 3)
    end })

    BuildSettingsSections(Tab, Window)
    BuildPlayerSections(Tab)
    BuildSpoofSections(Tab)
end

function BuildSpoofSections(Tab)
    Tab:Section("Spoofer: Stats (local only)")
    Tab:Label({ Desc = "Only YOUR screen changes. Server values stay real." })
    local coins, level, xp, caught = 1000000, 999, 0, 99999
    Tab:Input({ Title = "Money (C$)", Default = tostring(coins), Callback = function(t) coins = tonumber(t) or coins end })
    Tab:Input({ Title = "Level", Default = tostring(level), Callback = function(t) level = tonumber(t) or level end })
    Tab:Input({ Title = "XP", Default = tostring(xp), Callback = function(t) xp = tonumber(t) or xp end })
    Tab:Input({ Title = "Fish Caught", Default = tostring(caught), Callback = function(t) caught = tonumber(t) or caught end })
    Tab:Button({ Title = "Apply Stat Spoof", Callback = function()
        local ok = SpoofStat("coins", coins)
        SpoofStat("level", level)
        SpoofStat("realLevel", level)
        SpoofStat("xp", xp)
        SpoofStat("tracker_fishcaught", caught)
        SpoofLevelTag = level
        Notify("Spoofer", ok and "Stats spoofed." or "Stats folder not found.", 3)
    end })
    Tab:Button({ Title = "Restore Stats", Callback = function()
        SpoofLevelTag = nil
        RestoreStats()
        Notify("Spoofer", "Real stats restored.", 3)
    end })

    Tab:Section("Spoofer: Any Stat")
    local statNames = StatNames()
    local selStat, statValue = statNames[1], ""
    local statDD = Tab:Dropdown({ Title = "Stat", Options = statNames,
        Desc = "Every value in your Stats folder: currencies (embercoins, minetokens...), trackers, title, rod...",
        Callback = function(v) selStat = v end })
    Tab:Input({ Title = "Value", Placeholder = "number or text", Callback = function(t) statValue = t end })
    Tab:Button({ Title = "Spoof Stat", Callback = function()
        if not selStat then return end
        Notify("Spoofer", SpoofAnyStat(selStat, statValue) and (selStat .. " = " .. statValue) or "That value doesn't fit this stat.", 3)
    end })
    Tab:Button({ Title = "Restore Stat", Callback = function()
        if selStat then RestoreStat(selStat) end
    end })
    Tab:Button({ Title = "Refresh Stat List", Callback = function()
        statDD:Refresh(StatNames()); selStat = statDD.GetValue()
    end })

    Tab:Section("Spoofer: Identity")
    local fakeName, fakeTitle = "", ""
    Tab:Input({ Title = "Fake Name", Placeholder = "shown instead of your name", Callback = function(t) fakeName = t end })
    Tab:Button({ Title = "Apply Name", Desc = "Rewrites your name on your overhead tag and in the HUD.", Callback = function()
        if fakeName == "" then return end
        RestoreNames()
        NameSpoof = fakeName
        ReplaceNames(GetCharacter())
        ReplaceNames(PlayerGui)
        Notify("Spoofer", "Name shown as " .. fakeName, 3)
    end })
    Tab:Button({ Title = "Restore Name", Callback = RestoreNames })
    Tab:Input({ Title = "Fake Title", Placeholder = "e.g. The Kraken Slayer", Callback = function(t) fakeTitle = t end })
    Tab:Button({ Title = "Apply Title", Callback = function()
        if fakeTitle ~= "" then
            Notify("Spoofer", SpoofAnyStat("title", fakeTitle) and "Title spoofed." or "Title stat not found.", 3)
        end
    end })

    Tab:Section("Spoofer: Fake Fish")
    local rarities = RarityNames()
    local fishRarity = "Mythical"
    local fishList = FishByRarity(fishRarity)
    local selFish, fishWeight, fishCount = fishList[1], 999, 1
    local fishDD
    Tab:Dropdown({ Title = "Rarity", Options = rarities, Default = fishRarity, Callback = function(v)
        fishRarity = v
        fishList = FishByRarity(v)
        fishDD:Refresh(fishList)
        selFish = fishDD.GetValue()
    end })
    fishDD = Tab:Dropdown({ Title = "Fish", Options = fishList, Callback = function(v) selFish = v end })
    Tab:Input({ Title = "Weight (kg)", Default = "999", Callback = function(t) fishWeight = tonumber(t) or fishWeight end })
    Tab:Slider({ Title = "Amount", Min = 1, Max = 50, Default = 1, Step = 1, Callback = function(v) fishCount = v end })
    Tab:Button({ Title = "Add To Backpack", Desc = "Only on your screen — can't be sold, traded or appraised.", Callback = function()
        if not selFish then return end
        local n, msg = AddFakeFish(selFish, fishWeight, fishCount)
        Notify("Fake Fish", n .. "x " .. selFish .. " " .. tostring(msg), 3)
    end })
    Tab:Button({ Title = "Remove Fake Fish", Callback = function()
        RemoveFakeFish()
        Notify("Fake Fish", "Removed.", 3)
    end })

    Tab:Section("Spoofer: Rods")
    Tab:Label({ Desc = "Spoofed rods show in Equipment as owned. You can't actually equip/fish with them." })
    local names = RodNames()
    local selRod = names[1]
    Tab:Dropdown({ Title = "Rod", Options = names, Callback = function(v) selRod = v end })
    Tab:Button({ Title = "Spoof Selected Rod", Callback = function()
        if not selRod then return end
        local ok, msg = SpoofRod(selRod)
        Notify("Rod Spoofer", selRod .. ": " .. tostring(msg), 3)
    end })
    Tab:Button({ Title = "Spoof ALL Rods", Callback = function()
        local n = SpoofAllRods()
        Notify("Rod Spoofer", n .. " rods added to your Equipment menu.", 4)
    end })
    Tab:Button({ Title = "Remove Spoofed Rods", Callback = function()
        RestoreRods()
        Notify("Rod Spoofer", "Spoofed rods removed.", 3)
    end })
    Tab:Button({ Title = "Restore EVERYTHING", Desc = "Undo every spoof: stats, level tag, name, rods, fake fish.", Callback = function()
        SpoofLevelTag = nil
        RestoreStats()
        RestoreNames()
        RestoreRods()
        RemoveFakeFish()
        Notify("Spoofer", "All spoofs removed.", 3)
    end })
end

function BuildPlayerSections(Tab)
    Tab:Section("Player: Movement")
    Tab:Toggle({ Title = "WalkSpeed", Default = S.WalkSpeedOn, Callback = function(v)
        S.WalkSpeedOn = v
        if not v then local h = GetHumanoid(); if h then h.WalkSpeed = 16 end end
    end })
    Tab:Slider({ Title = "Speed", Min = 16, Max = 150, Default = S.WalkSpeed, Step = 1, Callback = function(v) S.WalkSpeed = v end })
    Tab:Toggle({ Title = "Infinite Jump", Default = S.InfiniteJump, Callback = function(v) S.InfiniteJump = v end })
    Tab:Toggle({ Title = "Noclip", Default = S.Noclip, Callback = function(v) S.Noclip = v end })
    Tab:Toggle({ Title = "Fly", Default = S.Fly, Desc = "WASD to move, Space up, LeftShift down.",
        Callback = function(v) S.Fly = v; SetFly(v) end })
    Tab:Slider({ Title = "Fly Speed", Min = 10, Max = 250, Default = S.FlySpeed, Step = 5, Callback = function(v) S.FlySpeed = v end })

    Tab:Section("Player: Visuals")
    Tab:Toggle({ Title = "Fullbright", Default = S.Fullbright, Callback = function(v)
        S.Fullbright = v
        ApplyFullbright(v)
    end })
    Tab:Toggle({ Title = "Player ESP", Default = S.PlayerESP, Desc = "Highlight + name and distance on every player.",
        Callback = function(v) S.PlayerESP = v end })
    Tab:Toggle({ Title = "Roaming Fish ESP", Default = S.RoamingESP, Desc = "Highlights roaming fish and bosses, coloured by rarity.",
        Callback = function(v) S.RoamingESP = v end })
    Tab:Dropdown({ Title = "Roaming Min Rarity", Options = RarityNames(), Default = S.RoamingMinRarity,
        Callback = function(v) S.RoamingMinRarity = v end })
    Tab:Button({ Title = "Teleport To Nearest Roaming Fish", Callback = function()
        local p = NearestRoamingFish()
        if p then TeleportTo(p.CFrame + Vector3.new(0, 8, 0)) else Notify("Roaming", "Turn on Roaming Fish ESP first (none tracked).", 3) end
    end })

    Tab:Section("Player: Graphics")
    Tab:Toggle({ Title = "Low Graphics", Default = S.LowGraphics,
        Desc = "Strips textures, particles, shadows and water detail. Rejoin to undo.",
        Callback = function(v)
            S.LowGraphics = v
            if v then ApplyLowGraphics() else Notify("Graphics", "Rejoin to restore full graphics.", 4) end
        end })
end

function BuildSettingsSections(Tab, Window)
    Tab:Section("Settings: Menu")
    Tab:Keybind({ Title = "Toggle Menu", Default = S.ToggleKey, Callback = function(k) Window:SetToggleKey(k) end })
    Tab:Keybind({ Title = "Auto Farm Key", Default = S.FarmKey, Callback = function(k)
        S.FarmKey = Enum.KeyCode[k] or S.FarmKey
    end })
    Tab:Keybind({ Title = "Panic Key (unload)", Default = S.PanicKey, Callback = function(k)
        S.PanicKey = Enum.KeyCode[k] or S.PanicKey
    end })
    Tab:Toggle({ Title = "Watermark", Default = S.Watermark, Desc = "Name, FPS, ping and time, top-left. Drag to move.",
        Callback = function(v) S.Watermark = v; if WatermarkObj then WatermarkObj:SetVisible(v) end end })
    Tab:Toggle({ Title = "Feature List", Default = S.ArrayList, Desc = "Shows your active features top-right.",
        Callback = function(v) S.ArrayList = v end })
    Tab:Dropdown({ Title = "Accent Colour", Options = AccentOrder, Default = S.Accent, Callback = function(v)
        ApplyAccent(v)
        Window:SetTitle(WindowTitle())
    end })
    Tab:Toggle({ Title = "Streamer Mode", Default = S.StreamerMode, Desc = "Hides your username in the watermark and menu title.",
        Callback = function(v)
            S.StreamerMode = v
            Window:SetTitle(WindowTitle())
        end })
    Tab:Toggle({ Title = "Notifications", Default = S.Notifications, Callback = function(v) S.Notifications = v end })
    Tab:Toggle({ Title = "Anti-AFK", Default = S.AntiAFK, Callback = function(v) S.AntiAFK = v end })

    Tab:Section("Settings: Config")
    local cfgName = ""
    local cfgList = ConfigList()
    local selCfg = cfgList[1]
    Tab:Input({ Title = "Config Name", Placeholder = "e.g. afk farm", Callback = function(t) cfgName = t end })
    local cfgDD
    Tab:Button({ Title = "Save Config", Callback = function()
        local ok, msg = SaveConfig(cfgName ~= "" and cfgName or selCfg)
        Notify("Config", msg, 3)
        if ok then cfgDD:Refresh(ConfigList()); selCfg = cfgDD.GetValue() end
    end })
    cfgDD = Tab:Dropdown({ Title = "Saved Configs", Options = cfgList, Callback = function(v) selCfg = v end })
    Tab:Button({ Title = "Load Config", Desc = "Applies the config and rebuilds the menu.", Callback = function()
        if not selCfg then Notify("Config", "Pick a config first.", 3) return end
        local ok, msg = LoadConfig(selCfg)
        Notify("Config", msg, 3)
        if not ok then return end
        ApplyState()
        task.defer(function()
            if Window then Window:Destroy() end
            BuildUI()
        end)
    end })
    Tab:Button({ Title = "Delete Config", Callback = function()
        if selCfg and DeleteConfig(selCfg) then
            cfgDD:Refresh(ConfigList()); selCfg = cfgDD.GetValue()
        end
    end })
    Tab:Button({ Title = "Set As Autoload", Desc = "Loads this config automatically every time the script runs.", Callback = function()
        if selCfg and SetAutoload(selCfg) then Notify("Config", selCfg .. " will autoload.", 3) end
    end })
    Tab:Button({ Title = "Clear Autoload", Callback = function()
        SetAutoload("")
        Notify("Config", "Autoload cleared.", 3)
    end })
    if not CanUseFiles() then Tab:Label({ Desc = "Your executor has no file functions, so configs can't be saved." }) end

    Tab:Section("Settings: Performance")
    Tab:Toggle({ Title = "Disable 3D Rendering", Default = S.Disable3D,
        Desc = "Black screen, big FPS/CPU saving for AFK farming.",
        Callback = function(v)
            S.Disable3D = v
            pcall(function() RunService:Set3dRenderingEnabled(not v) end)
        end })
    Tab:Slider({ Title = "FPS Cap", Min = 5, Max = 240, Default = 60, Step = 5, Callback = function(v)
        if setfpscap then pcall(setfpscap, v) end
    end })

    Tab:Section("Settings: Server")
    Tab:Toggle({ Title = "Auto Rejoin on Kick", Default = S.AutoRejoin, Desc = "Rejoins if you get disconnected while AFK.",
        Callback = function(v) S.AutoRejoin = v end })
    Tab:Button({ Title = "Rejoin", Callback = Rejoin })
    Tab:Button({ Title = "Server Hop", Callback = ServerHop })
    Tab:Button({ Title = "Copy Job ID", Callback = function()
        if setclipboard then setclipboard(game.JobId) Notify("Server", "Job ID copied.", 3)
        else Notify("Server", "Job ID: " .. game.JobId, 8) end
    end })
    local jobId = ""
    Tab:Input({ Title = "Join Job ID", Placeholder = "paste a server's Job ID", Callback = function(t) jobId = t end })
    Tab:Button({ Title = "Join Server", Callback = function()
        if jobId == "" then return end
        pcall(function() TeleportService:TeleportToPlaceInstance(game.PlaceId, jobId, LocalPlayer) end)
    end })

    Tab:Section("Settings: Script")
    Tab:Label({ Desc = ("Players in server: %d  |  Place: %d"):format(#Players:GetPlayers(), game.PlaceId) })
    Tab:Button({ Title = "Unload Script", Desc = "Turns everything off, undoes spoofs and removes the menu.", Callback = function()
        if GlobalScope.Fisch_Cleanup then GlobalScope.Fisch_Cleanup() end
    end })
end

Window = nil

BuildUI = function()
    UIGen = UIGen + 1
    table.clear(UIRefs)
    ApplyAccent(S.Accent)
    local win = Obelus:Window({
        Name = WindowTitle(),
        ToggleKey = S.ToggleKey,
        Size = UDim2.fromOffset(720, 600),
    })
    WatermarkObj = win:Watermark()
    WatermarkObj:SetVisible(S.Watermark)
    ArrayListObj = win:ArrayList()
    ArrayListObj:SetVisible(S.ArrayList)
    Notifier = {
        Notify = function(_, cfg)
            win:Notify(cfg.Title or "Fisch", cfg.Content or "", cfg.Duration or 3)
        end,
    }
    Window = WrapWindow(win)

    BuildFishingTab(Window)
    BuildProgressTab(Window)
    BuildSellTab(Window)
    BuildTeleportTab(Window)
    BuildZonesTab(Window)
    BuildWorldTab(Window)
    BuildExtrasTab(Window)
    win.Pages[1]:Turn(true)

    if not GetReelController() then
        Notify("Fisch", "ReelController not found — auto reel unavailable.", 5)
    end
    Notify("Fisch", "Loaded. Toggle menu: " .. S.ToggleKey.Name, 5)
end

GlobalScope.Fisch_Cleanup = function()
    Unloading = true
    for _, conn in ipairs(Connections) do pcall(function() conn:Disconnect() end) end
    table.clear(Connections)

    if S.Fullbright then ApplyFullbright(false) end
    pcall(function()
        local h = GetHumanoid()
        if h and S.WalkSpeedOn then h.WalkSpeed = 16 end
        local r = GetRoot()
        if r and S.AnchorFishing then r.Anchored = false end
    end)
    SpoofLevelTag = nil
    if S.NoHazards then S.NoHazards = false pcall(ApplyHazards) end
    pcall(RestoreStats)
    pcall(RestoreRods)
    pcall(RestoreNames)
    pcall(RemoveFakeFish)
    SetPlatform(false)
    S.Fly = false
    pcall(SetFly, false)
    for plr in pairs(ESPObjects) do ClearESP(plr) end
    for _, hl in pairs(LootMarks) do pcall(function() hl:Destroy() end) end
    for _, mark in pairs(RoamMarks) do pcall(function() mark.hl:Destroy() mark.tag:Destroy() end) end
    EnchantRunning, AppraiseRunning = false, false
    pcall(function() RunService:Set3dRenderingEnabled(true) end)
    pcall(function() if Window then Window:Destroy() end end)

    GlobalScope.Fisch_Cleanup = nil
    warn("[Fisch] unloaded.")
end

do
    local auto = GetAutoload()
    if auto then
        local ok, msg = LoadConfig(auto)
        if ok then pcall(ApplyState) end
        task.delay(3, function() Notify("Config", ok and ("Autoloaded " .. auto) or msg, 4) end)
    end
end

ok, err = pcall(BuildUI)
if not ok then
    warn("[Fisch] UI failed: " .. tostring(err))
    Notify("Fisch", "UI failed to load: " .. tostring(err), 8)
end

pcall(ResumeEventHop)
