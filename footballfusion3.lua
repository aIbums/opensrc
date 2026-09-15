-- this is still very buggy magnet works use if u want

local GlobalScope = (getgenv and getgenv()) or _G or shared

if type(GlobalScope.FH_Cleanup) == "function" then
    pcall(GlobalScope.FH_Cleanup)
    task.wait(0.2)
end

local Players           = game:GetService("Players")
local RunService        = game:GetService("RunService")
local UserInputService  = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Workspace         = game:GetService("Workspace")
local Lighting          = game:GetService("Lighting")
local HttpService       = game:GetService("HttpService")
local StarterGui        = game:GetService("StarterGui")
local CoreGui           = game:GetService("CoreGui")
local VirtualUser       = game:GetService("VirtualUser")

local LocalPlayer = Players.LocalPlayer

local S = {
    BallESP            = true,
    BallPath           = true,
    BallLanding        = true,
    BallColor          = Color3.fromRGB(255, 170, 40),
    PathColor          = Color3.fromRGB(255, 255, 255),
    CatchHeight        = 2,

    AutoRun            = false,
    AutoRunKey         = "NONE",
    AutoRunOnlyMine    = false,
    Magnet             = false,
    MagnetRange        = 8,
    MagnetOnlyThrown   = true,
    AutoCatchClick     = false,
    AutoCatchRange     = 10,

    QBLead             = false,
    QBAim              = false,
    QBAimKey           = "LeftAlt",
    QBAimSmooth        = 3,
    QBAimFOV           = 250,
    QBLeadScale        = 1,
    QBBallSpeed        = 70,
    QBLearn            = true,

    AutoPursue         = false,
    PursueKey          = "NONE",
    TackleReach        = false,
    TackleRange        = 7,
    AutoBlock          = false,
    BlockKey           = "NONE",
    BlockReach         = false,
    BlockRange         = 7,

    WebhookOn          = false,
    WebhookURL         = "",
    WebhookEvery       = 15,
    WebhookOnTD        = true,

    PlayerESP          = false,
    ESPTeam            = true,
    ESPNames           = true,
    ESPDistance        = true,
    ESPRoles           = true,
    Chams              = false,
    ChamsFill          = 0.6,
    TeamColor          = Color3.fromRGB(70, 150, 255),
    EnemyColor         = Color3.fromRGB(255, 70, 70),
    CarrierColor       = Color3.fromRGB(255, 220, 0),
    OpenReceivers      = false,
    OpenDistance       = 10,
    CarrierTracer      = false,

    AutoDefense        = false,
    DefenseMode        = "Man",
    DefenseKey         = "NONE",

    Fullbright         = false,
    NoBlur             = false,
    CustomTime         = false,
    ClockTime          = 14,
    NoFog              = false,
    NoShadows          = false,
    CustomLighting     = false,
    LightBrightness    = 2,
    LightAmbient       = Color3.fromRGB(130, 130, 140),
    LightExposure      = 0,
    CustomAtmosphere   = false,
    AtmoDensity        = 0.3,
    AtmoHaze           = 1,
    AtmoGlare          = 0,
    AtmoColor          = Color3.fromRGB(255, 200, 150),
    NoPostFX           = false,
    Saturation         = 0,
    CCEnabled          = false,
    CCTint             = Color3.fromRGB(255, 245, 235),
    CCContrast         = 0.1,
    CCBrightness       = 0,
    BloomEnabled       = false,
    BloomIntensity     = 0.6,
    BloomSize          = 24,
    BloomThreshold     = 1.5,
    SunRays            = false,
    SunRaysIntensity   = 0.15,
    SkyPreset          = "Game Default",
    SkyCustomId        = "",
    SelfChams          = false,
    SelfMaterial       = "ForceField",
    SelfColor          = Color3.fromRGB(255, 150, 40),
    SelfTransparency   = 0,
    BallGlow           = false,

    SpeedHack          = false,
    WalkSpeed          = 22,
    JumpHack           = false,
    JumpPower          = 60,
    InfiniteJump       = false,

    AutoDailyXP        = true,
    AntiAFK            = true,

    Notifications      = true,
    Watermark          = true,
    KeybindList        = true,
    ToggleKey          = Enum.KeyCode.RightShift,
}

local R = {
    Connections   = {},
    Unloading     = false,
    FrameCount    = 0,
    BallHistory   = {},
    Prediction    = nil,
    LastMagnet    = 0,
    LastClick     = 0,
    Running       = false,
    Catches       = 0,
    Noclipped     = setmetatable({}, { __mode = "k" }),
}

local function Track(conn)
    if type(conn) == "function" then conn = { Disconnect = conn } end
    if conn then table.insert(R.Connections, conn) end
    return conn
end

local function Loop(interval, cond, fn)
    task.spawn(function()
        while not R.Unloading do
            if cond() then
                local ok, err = pcall(fn)
                if not ok and not R.Unloading then warn("[FH] loop error: " .. tostring(err)) end
            end
            task.wait(interval)
        end
    end)
end

local UI = { Lib = nil }

local function Notify(title, content, duration)
    if not S.Notifications then return end
    if UI.Lib and type(UI.Lib.Notify) == "function" then
        pcall(function() UI.Lib:Notify(title or "Fusion", content or "", tonumber(duration) or 3) end)
    else
        pcall(function()
            StarterGui:SetCore("SendNotification", { Title = title or "Fusion", Text = content or "", Duration = duration or 3 })
        end)
    end
end

local function EnumFrom(enumType, name)
    local ok, item = pcall(function() return enumType[name] end)
    return ok and item or nil
end

local function KeyEnum(key)
    if typeof(key) == "EnumItem" then return key end
    local name = (tostring(key or ""):gsub("^Enum%.%w+%.", ""))
    if name == "" or name == "NONE" then return nil end
    return EnumFrom(Enum.KeyCode, name) or EnumFrom(Enum.UserInputType, name)
end

local function KeyDown(key)
    local k = KeyEnum(key)
    if not k then return false end
    if k.EnumType == Enum.KeyCode then return UserInputService:IsKeyDown(k) end
    return UserInputService:IsMouseButtonPressed(k)
end

local function Char() return LocalPlayer.Character end

local function Hum(model)
    model = model or Char()
    return model and model:FindFirstChildOfClass("Humanoid")
end

local function Root(model)
    model = model or Char()
    return model and (model:FindFirstChild("HumanoidRootPart") or model.PrimaryPart)
end

local function Cam() return Workspace.CurrentCamera end

local function Kill(inst)
    if inst then pcall(function() inst:Destroy() end) end
end

local HasDrawing = type(Drawing) == "table" or typeof(Drawing) == "table"
local Drawings = {}

local function Draw(class, props)
    if not HasDrawing then return nil end
    local ok, obj = pcall(function() return Drawing.new(class) end)
    if not ok or not obj then return nil end
    for k, v in pairs(props or {}) do pcall(function() obj[k] = v end) end
    table.insert(Drawings, obj)
    return obj
end

local function Undraw(obj)
    if obj then pcall(function() obj:Remove() end) end
end

local function HiddenRoot()
    local ok, hui = pcall(function() return gethui and gethui() end)
    if ok and typeof(hui) == "Instance" then return hui end
    return CoreGui
end

local function Screen(pos)
    local v, on = Cam():WorldToViewportPoint(pos)
    return Vector2.new(v.X, v.Y), on and v.Z > 0
end

local Game = {}

function Game.Flags() return ReplicatedStorage:FindFirstChild("Flags") end

function Game.Flag(name)
    local flags = Game.Flags()
    local v = flags and flags:FindFirstChild(name)
    if v and v:IsA("ValueBase") then return v.Value end
    return nil
end

function Game.Remote(name)
    local remotes = ReplicatedStorage:FindFirstChild("Remotes")
    return remotes and remotes:FindFirstChild(name)
end

function Game.FlagPlayer(name)
    local v = Game.Flag(name)
    if typeof(v) ~= "Instance" then return nil end
    if v:IsA("Player") then return v end
    return Players:GetPlayerFromCharacter(v) or Players:GetPlayerFromCharacter(v.Parent)
end

function Game.BallPart(inst)
    if typeof(inst) ~= "Instance" then return nil end
    if inst:IsA("BasePart") then return inst end
    if inst:IsA("Tool") then
        return inst:FindFirstChild("Handle") or inst:FindFirstChildWhichIsA("BasePart")
    end
    if inst:IsA("Model") then return inst.PrimaryPart or inst:FindFirstChildWhichIsA("BasePart", true) end
    return nil
end

function Game.Ball()
    local part = Game.BallPart(Game.Flag("Ball"))
    if part and part.Parent then return part end
    local loose = Workspace:FindFirstChild("Football")
    part = Game.BallPart(loose)
    if part and not Players:GetPlayerFromCharacter(part:FindFirstAncestorOfClass("Model")) then return part end
    return nil
end

function Game.BallLoose(ball)
    ball = ball or Game.Ball()
    if not ball then return false end
    local model = ball:FindFirstAncestorOfClass("Model")
    if model and Players:GetPlayerFromCharacter(model) then return false end
    if ball:FindFirstAncestorOfClass("Backpack") then return false end
    return true
end

function Game.IsTeammate(p)
    if p == LocalPlayer then return true end
    if p.Neutral or LocalPlayer.Neutral then return false end
    return p.Team ~= nil and p.Team == LocalPlayer.Team
end

function Game.Role(p)
    local tags = {}
    if Game.FlagPlayer("Carrier") == p then table.insert(tags, "BALL") end
    if Game.FlagPlayer("QB") == p then table.insert(tags, "QB") end
    if Game.FlagPlayer("Kicker") == p then table.insert(tags, "K") end
    return table.concat(tags, " ")
end

local Ball = {}

function Ball.Sample(ball)
    local h = R.BallHistory
    local now = os.clock()
    table.insert(h, { t = now, pos = ball.Position, vel = ball.AssemblyLinearVelocity })
    while #h > 12 or (h[1] and now - h[1].t > 0.5) do table.remove(h, 1) end
end

function Ball.Motion()
    local h = R.BallHistory
    local last = h[#h]
    if not last then return nil end
    local vel = last.vel
    local first = h[1]
    if vel.Magnitude < 0.5 and first ~= last and last.t > first.t then
        vel = (last.pos - first.pos) / (last.t - first.t)
    end
    local gravity = Workspace.Gravity
    local accel = Vector3.new(0, -gravity, 0)
    if #h >= 6 and first.vel.Magnitude > 0.5 then
        local dt = last.t - first.t
        if dt > 0.1 then
            local ay = (last.vel.Y - first.vel.Y) / dt
            if ay < -5 and ay > -gravity * 1.5 then accel = Vector3.new(0, ay, 0) end
        end
    end
    return last.pos, vel, accel
end

function Ball.Predict(targetY)
    local pos, vel, accel = Ball.Motion()
    if not pos or vel.Magnitude < 2 then return nil end
    local path = { pos }
    local p, v = pos, vel
    local step = 1 / 30
    for i = 1, 30 * 8 do
        local np = p + v * step + accel * (0.5 * step * step)
        v = v + accel * step
        if i % 3 == 0 then table.insert(path, np) end
        if v.Y < 0 and np.Y <= targetY then
            local f = (p.Y - targetY) / math.max(p.Y - np.Y, 1e-3)
            local hit = p:Lerp(np, math.clamp(f, 0, 1))
            table.insert(path, hit)
            return { Point = hit, Time = i * step, Path = path }
        end
        p = np
    end
    return nil
end

function Ball.Step()
    local ball = Game.Ball()
    if not (ball and Game.BallLoose(ball)) then
        table.clear(R.BallHistory)
        R.Prediction = nil
        return
    end
    Ball.Sample(ball)
    R.LastLooseAt = os.clock()
    local root = Root()
    local y = root and (root.Position.Y + S.CatchHeight) or (ball.Position.Y - 20)
    R.Prediction = Ball.Predict(y)
end

local Catch = {}

function Catch.MyPass()
    local qb = Game.FlagPlayer("QB")
    return qb == nil or Game.IsTeammate(qb)
end

function Catch.AutoRun()
    local hum, root = Hum(), Root()
    local pred = R.Prediction
    local want = S.AutoRun and pred and hum and root and (KeyEnum(S.AutoRunKey) == nil or KeyDown(S.AutoRunKey))
        and (not S.AutoRunOnlyMine or Catch.MyPass())
    if want then
        local target = Vector3.new(pred.Point.X, root.Position.Y, pred.Point.Z)
        if (target - root.Position).Magnitude > 1.5 then
            hum:MoveTo(target)
            R.Running = true
        end
    elseif R.Running then
        R.Running = false
        if hum and root then hum:MoveTo(root.Position) end
    end
end

function Catch.BodyParts()
    local char = Char()
    if not char then return {} end
    local parts = {}
    for _, name in ipairs({ "Left Arm", "Right Arm", "LeftHand", "RightHand", "Head", "Torso", "UpperTorso" }) do
        local p = char:FindFirstChild(name)
        if p and p:IsA("BasePart") then table.insert(parts, p) end
    end
    return parts
end

function Catch.Magnet()
    if not S.Magnet or type(firetouchinterest) ~= "function" then return end
    if os.clock() - R.LastMagnet < 0.05 then return end
    local ball, root = Game.Ball(), Root()
    if not (ball and root and Game.BallLoose(ball)) then return end
    if S.MagnetOnlyThrown and not (Game.Flag("Thrown") or Game.Flag("Fumble")) then return end
    if (ball.Position - root.Position).Magnitude > S.MagnetRange then return end
    R.LastMagnet = os.clock()
    for _, part in ipairs(Catch.BodyParts()) do
        pcall(firetouchinterest, part, ball, 0)
        pcall(firetouchinterest, part, ball, 1)
    end
end

function Catch.AutoClick()
    if not S.AutoCatchClick then return end
    if UI.Lib and UI.Lib:IsOpen() then return end
    if os.clock() - R.LastClick < 0.35 then return end
    local ball, root = Game.Ball(), Root()
    if not (ball and root and Game.BallLoose(ball) and Game.Flag("Thrown")) then return end
    if (ball.Position - root.Position).Magnitude > S.AutoCatchRange then return end
    R.LastClick = os.clock()
    if type(mouse1click) == "function" then
        mouse1click()
    elseif type(mouse1press) == "function" and type(mouse1release) == "function" then
        mouse1press()
        task.delay(0.05, function() pcall(mouse1release) end)
    end
end

local Visual = { Highlights = {}, Labels = {}, PathLines = {} }

function Visual.Folder()
    if not (Visual.Root and Visual.Root.Parent) then
        Visual.Root = Instance.new("Folder")
        Visual.Root.Name = "FH_Visuals"
        Visual.Root.Parent = HiddenRoot()
    end
    return Visual.Root
end

function Visual.Highlight(key, adornee, color, fill, on)
    local h = Visual.Highlights[key]
    if not on or not adornee then
        if h then
            Kill(h)
            Visual.Highlights[key] = nil
        end
        return
    end
    if not (h and h.Parent) then
        h = Instance.new("Highlight")
        h.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
        h.Parent = Visual.Folder()
        Visual.Highlights[key] = h
    end
    if h.Adornee ~= adornee then h.Adornee = adornee end
    h.FillColor, h.OutlineColor = color, color
    h.FillTransparency, h.OutlineTransparency = fill, 0
end

function Visual.Label(key, adornee, text, color)
    local bb = Visual.Labels[key]
    if not adornee or not text then
        if bb then
            Kill(bb)
            Visual.Labels[key] = nil
        end
        return
    end
    if not (bb and bb.Parent) then
        bb = Instance.new("BillboardGui")
        bb.AlwaysOnTop = true
        bb.Size = UDim2.fromOffset(200, 34)
        bb.StudsOffset = Vector3.new(0, 3.2, 0)
        bb.LightInfluence = 0
        local t = Instance.new("TextLabel")
        t.Name = "T"
        t.BackgroundTransparency = 1
        t.Size = UDim2.fromScale(1, 1)
        t.Font = Enum.Font.GothamBold
        t.TextSize = 13
        t.TextStrokeTransparency = 0.3
        t.Parent = bb
        bb.Parent = Visual.Folder()
        Visual.Labels[key] = bb
    end
    if bb.Adornee ~= adornee then bb.Adornee = adornee end
    bb.T.Text = text
    bb.T.TextColor3 = color
end

function Visual.Landing(point)
    local marker = Visual.Marker
    if not point then
        if marker then marker.Transparency = 1 end
        return
    end
    if not (marker and marker.Parent) then
        marker = Instance.new("Part")
        marker.Name = "FH_Landing"
        marker.Shape = Enum.PartType.Cylinder
        marker.Size = Vector3.new(0.2, 5, 5)
        marker.Anchored, marker.CanCollide, marker.CanQuery, marker.CanTouch = true, false, false, false
        marker.Material = Enum.Material.Neon
        marker.Parent = Cam()
        Visual.Marker = marker
    end
    local ground = Workspace:Raycast(point + Vector3.new(0, 5, 0), Vector3.new(0, -60, 0), Visual.GroundParams())
    local y = ground and ground.Position.Y + 0.1 or point.Y - 3
    marker.CFrame = CFrame.new(point.X, y, point.Z) * CFrame.Angles(0, 0, math.rad(90))
    marker.Color = S.BallColor
    marker.Transparency = 0.35
end

function Visual.GroundParams()
    if not Visual.Params then
        Visual.Params = RaycastParams.new()
        Visual.Params.FilterType = Enum.RaycastFilterType.Exclude
    end
    local ignore = { Cam() }
    for _, p in ipairs(Players:GetPlayers()) do
        if p.Character then table.insert(ignore, p.Character) end
    end
    Visual.Params.FilterDescendantsInstances = ignore
    return Visual.Params
end

function Visual.Path(path)
    local lines = Visual.PathLines
    local n = 0
    if path and HasDrawing then
        for i = 1, #path - 1 do
            local a, va = Screen(path[i])
            local b, vb = Screen(path[i + 1])
            if va and vb then
                n = n + 1
                local line = lines[n]
                if not line then
                    line = Draw("Line", { Thickness = 2, Transparency = 0.9 })
                    lines[n] = line
                end
                if line then
                    line.From, line.To, line.Color, line.Visible = a, b, S.PathColor, true
                end
            end
        end
    end
    for i = n + 1, #lines do lines[i].Visible = false end
end

function Visual.Tracer(target)
    if not HasDrawing then return end
    if not Visual.CarrierLine then Visual.CarrierLine = Draw("Line", { Thickness = 2 }) end
    local line = Visual.CarrierLine
    if not line then return end
    local root = target and Root(target.Character)
    if not root then
        line.Visible = false
        return
    end
    local to, on = Screen(root.Position)
    if not on then
        line.Visible = false
        return
    end
    local vs = Cam().ViewportSize
    line.From, line.To, line.Color, line.Visible = Vector2.new(vs.X / 2, vs.Y), to, S.CarrierColor, true
end

function Visual.Players()
    local carrier = Game.FlagPlayer("Carrier")
    local seen = {}
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer then
            local char = p.Character
            local root = Root(char)
            local mate = Game.IsTeammate(p)
            local show = S.PlayerESP and root and (not mate or S.ESPTeam)
            if show then
                seen[p] = true
                local color = p == carrier and S.CarrierColor or mate and S.TeamColor or S.EnemyColor
                local text = {}
                if S.ESPNames then table.insert(text, p.DisplayName) end
                if S.ESPRoles then
                    local role = Game.Role(p)
                    if role ~= "" then table.insert(text, "[" .. role .. "]") end
                end
                local myRoot = Root()
                if S.ESPDistance and myRoot then table.insert(text, math.floor((root.Position - myRoot.Position).Magnitude) .. "m") end
                if S.OpenReceivers and mate then
                    local nearest = math.huge
                    for _, q in ipairs(Players:GetPlayers()) do
                        local qr = Root(q.Character)
                        if qr and not Game.IsTeammate(q) and not q.Neutral then
                            nearest = math.min(nearest, (qr.Position - root.Position).Magnitude)
                        end
                    end
                    if nearest >= S.OpenDistance then
                        table.insert(text, "OPEN")
                        color = Color3.fromRGB(80, 255, 120)
                    end
                end
                Visual.Label(p, char:FindFirstChild("Head") or root, table.concat(text, "  "), color)
                Visual.Highlight(p, char, color, S.ChamsFill, S.Chams)
            end
        end
    end
    for key in pairs(Visual.Labels) do
        if typeof(key) == "Instance" and key:IsA("Player") and not seen[key] then Visual.Label(key, nil) end
    end
    for key in pairs(Visual.Highlights) do
        if typeof(key) == "Instance" and key:IsA("Player") and not seen[key] then Visual.Highlight(key, nil) end
    end
    Visual.Tracer(S.CarrierTracer and carrier ~= LocalPlayer and carrier or nil)
end

function Visual.Frame()
    local ball = Game.Ball()
    local loose = ball and Game.BallLoose(ball)
    Visual.Highlight("ball", ball, S.BallColor, 0.2, S.BallESP and ball ~= nil)
    local pred = R.Prediction
    if S.BallESP and ball and loose then
        local root = Root()
        local dist = root and math.floor((ball.Position - root.Position).Magnitude) or 0
        local text = dist .. "m"
        if pred then text = text .. string.format("  lands in %.1fs", pred.Time) end
        Visual.Label("ball", ball, text, S.BallColor)
    else
        Visual.Label("ball", nil)
    end
    Visual.Path(S.BallPath and pred and pred.Path or nil)
    Visual.Landing(S.BallLanding and pred and pred.Point or nil)
    Visual.Players()
end

function Visual.Clear()
    for key in pairs(Visual.Highlights) do Visual.Highlight(key, nil) end
    for key in pairs(Visual.Labels) do Visual.Label(key, nil) end
    Kill(Visual.Marker)
    Kill(Visual.Root)
end

local Look = { Saved = setmetatable({}, { __mode = "k" }) }

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

Look.FX, Look.Held = {}, {}
Look.SelfParts = setmetatable({}, { __mode = "k" })
Look.Materials = { "ForceField", "Neon", "Glass", "Foil", "SmoothPlastic", "Plastic", "Ice", "Marble", "Metal", "DiamondPlate" }
Look.SkyPresets = { "Game Default", "Classic Roblox", "Custom Asset ID" }

function Look.Effect(class, on, props)
    local fx = Look.FX[class]
    if not on then
        Kill(fx)
        Look.FX[class] = nil
        return
    end
    if not (fx and fx.Parent) then
        fx = Instance.new(class)
        fx.Name = "FH_" .. class
        fx.Parent = Lighting
        Look.FX[class] = fx
    end
    for k, v in pairs(props) do
        if fx[k] ~= v then fx[k] = v end
    end
end

function Look.ApplyLighting()
    local L = Lighting
    if S.Fullbright then
        Look.Set(L, "Brightness", 2)
        Look.Set(L, "Ambient", Color3.fromRGB(180, 180, 180))
        Look.Set(L, "OutdoorAmbient", Color3.fromRGB(180, 180, 180))
    elseif S.CustomLighting then
        Look.Set(L, "Brightness", S.LightBrightness)
        Look.Set(L, "Ambient", S.LightAmbient)
        Look.Set(L, "OutdoorAmbient", S.LightAmbient)
    else
        for _, p in ipairs({ "Brightness", "Ambient", "OutdoorAmbient" }) do Look.Reset(L, p) end
    end
    if S.CustomLighting then Look.Set(L, "ExposureCompensation", S.LightExposure) else Look.Reset(L, "ExposureCompensation") end
    if S.Fullbright or S.NoShadows then Look.Set(L, "GlobalShadows", false) else Look.Reset(L, "GlobalShadows") end
    if S.CustomTime then Look.Set(L, "ClockTime", S.ClockTime) else Look.Reset(L, "ClockTime") end
    if S.NoFog then
        Look.Set(L, "FogEnd", 1e6)
        Look.Set(L, "FogStart", 1e6)
    else
        Look.Reset(L, "FogEnd")
        Look.Reset(L, "FogStart")
    end

    local atmos = {}
    for _, c in ipairs(L:GetChildren()) do
        if c:IsA("Atmosphere") and c ~= Look.Atmo then table.insert(atmos, c) end
    end
    if S.CustomAtmosphere and not S.NoFog and #atmos == 0 then
        if not (Look.Atmo and Look.Atmo.Parent) then
            Look.Atmo = Instance.new("Atmosphere")
            Look.Atmo.Name = "FH_Atmosphere"
            Look.Atmo.Parent = L
        end
        table.insert(atmos, Look.Atmo)
    elseif Look.Atmo and not S.CustomAtmosphere then
        Kill(Look.Atmo)
        Look.Atmo = nil
    end
    for _, a in ipairs(atmos) do
        if S.NoFog then
            Look.Set(a, "Density", 0)
            Look.Set(a, "Haze", 0)
            Look.Set(a, "Glare", 0)
        elseif S.CustomAtmosphere then
            Look.Set(a, "Density", S.AtmoDensity)
            Look.Set(a, "Haze", S.AtmoHaze)
            Look.Set(a, "Glare", S.AtmoGlare)
            Look.Set(a, "Color", S.AtmoColor)
        else
            for _, p in ipairs({ "Density", "Haze", "Glare", "Color" }) do Look.Reset(a, p) end
        end
    end

    for _, c in ipairs(L:GetChildren()) do
        if c:IsA("PostEffect") and c.Name:sub(1, 3) ~= "FH_" then
            local off = S.NoPostFX or (S.NoBlur and c:IsA("BlurEffect"))
            if off then Look.Set(c, "Enabled", false) else Look.Reset(c, "Enabled") end
        end
    end
    Look.Effect("ColorCorrectionEffect", S.CCEnabled or S.Saturation ~= 0, {
        TintColor = S.CCEnabled and S.CCTint or Color3.new(1, 1, 1),
        Contrast = S.CCEnabled and S.CCContrast or 0,
        Brightness = S.CCEnabled and S.CCBrightness or 0,
        Saturation = S.Saturation / 100,
    })
    Look.Effect("BloomEffect", S.BloomEnabled, { Intensity = S.BloomIntensity, Size = S.BloomSize, Threshold = S.BloomThreshold })
    Look.Effect("SunRaysEffect", S.SunRays, { Intensity = S.SunRaysIntensity, Spread = 0.8 })
end

function Look.ApplySky()
    local want
    if S.SkyPreset == "Custom Asset ID" then
        local id = tostring(S.SkyCustomId or ""):match("%d+")
        want = id and ("id:" .. id) or nil
    elseif S.SkyPreset == "Classic Roblox" then
        want = "classic"
    end
    if want then
        if Look.SkyKey ~= want or not (Look.Sky and Look.Sky.Parent) then
            Kill(Look.Sky)
            local sky = Instance.new("Sky")
            if want:sub(1, 3) == "id:" then
                local url = "rbxassetid://" .. want:sub(4)
                for _, face in ipairs({ "Bk", "Dn", "Ft", "Lf", "Rt", "Up" }) do sky["Skybox" .. face] = url end
            end
            sky.Name = "FH_Sky"
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
        Kill(Look.Sky)
        Look.Sky, Look.SkyKey = nil, nil
        local last = Look.Held[#Look.Held]
        table.clear(Look.Held)
        if last and not Lighting:FindFirstChildOfClass("Sky") then pcall(function() last.Parent = Lighting end) end
    end
end

function Look.SelfPart(part, on)
    local saved = Look.SelfParts[part]
    if on then
        if not saved then
            saved = { Material = part.Material, Color = part.Color }
            Look.SelfParts[part] = saved
        end
        local mat = EnumFrom(Enum.Material, S.SelfMaterial) or Enum.Material.ForceField
        if part.Material ~= mat then part.Material = mat end
        if part.Color ~= S.SelfColor then part.Color = S.SelfColor end
        part.LocalTransparencyModifier = S.SelfTransparency
    elseif saved then
        Look.SelfParts[part] = nil
        pcall(function()
            part.Material, part.Color = saved.Material, saved.Color
            part.LocalTransparencyModifier = 0
        end)
    end
end

function Look.ApplySelf()
    local char = Char()
    local want = {}
    local hum = char and Hum(char)
    if S.SelfChams and char and hum and hum.Health > 0 then
        for _, d in ipairs(char:GetChildren()) do
            if d:IsA("BasePart") and d.Name ~= "HumanoidRootPart" then want[d] = true end
        end
    end
    for part in pairs(want) do pcall(Look.SelfPart, part, true) end
    for part in pairs(Look.SelfParts) do
        if not want[part] then pcall(Look.SelfPart, part, false) end
    end
end

function Look.ApplyBallGlow()
    local ball = S.BallGlow and Game.Ball() or nil
    local light = Look.BallLight
    if not ball then
        if light then
            Kill(light)
            Look.BallLight = nil
        end
        return
    end
    if not (light and light.Parent == ball) then
        Kill(light)
        light = Instance.new("PointLight")
        light.Name = "FH_Glow"
        light.Range, light.Brightness = 14, 3
        light.Parent = ball
        Look.BallLight = light
    end
    light.Color = S.BallColor
end

function Look.Apply()
    Look.ApplyLighting()
    Look.ApplySky()
    Look.ApplySelf()
    Look.ApplyBallGlow()
end

function Look.Restore()
    for inst, saved in pairs(Look.Saved) do
        for prop, original in pairs(saved) do pcall(function() inst[prop] = original end) end
    end
    table.clear(Look.Saved)
    for class in pairs(Look.FX) do Look.Effect(class, false) end
    Kill(Look.Atmo)
    Kill(Look.Sky)
    Kill(Look.BallLight)
    local last = Look.Held[#Look.Held]
    if last and not Lighting:FindFirstChildOfClass("Sky") then pcall(function() last.Parent = Lighting end) end
    table.clear(Look.Held)
    for part in pairs(Look.SelfParts) do pcall(Look.SelfPart, part, false) end
end

local Move = {}

function Move.Step()
    local hum = Hum()
    if not hum then return end
    if S.SpeedHack then
        if Move.SavedSpeed == nil then Move.SavedSpeed = hum.WalkSpeed end
        if hum.WalkSpeed ~= S.WalkSpeed then hum.WalkSpeed = S.WalkSpeed end
    elseif Move.SavedSpeed ~= nil then
        hum.WalkSpeed = Move.SavedSpeed
        Move.SavedSpeed = nil
    end
    if S.JumpHack then
        if Move.SavedJump == nil then Move.SavedJump = { hum.UseJumpPower, hum.JumpPower } end
        hum.UseJumpPower = true
        if hum.JumpPower ~= S.JumpPower then hum.JumpPower = S.JumpPower end
    elseif Move.SavedJump ~= nil then
        hum.UseJumpPower, hum.JumpPower = Move.SavedJump[1], Move.SavedJump[2]
        Move.SavedJump = nil
    end
end

Track(UserInputService.JumpRequest:Connect(function()
    if S.InfiniteJump then
        local hum = Hum()
        if hum then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
    end
end))

local Misc = {}

function Misc.DailyXP()
    local remote = Game.Remote("CharacterSoundEvent")
    if remote then pcall(function() remote:FireServer("Game", "redeem daily xp") end) end
end

Track(LocalPlayer.Idled:Connect(function()
    if not S.AntiAFK then return end
    pcall(function()
        VirtualUser:CaptureController()
        VirtualUser:ClickButton2(Vector2.new())
    end)
end))

function Misc.MatchInfo()
    local flags = Game.Flags()
    if not flags then return "no match data" end
    local home, away = Game.Flag("Home"), Game.Flag("Away")
    local score = string.format("%s %s - %s %s",
        typeof(home) == "Instance" and home.Name or "Home", tostring(Game.Flag("HomeScore") or 0),
        tostring(Game.Flag("AwayScore") or 0), typeof(away) == "Instance" and away.Name or "Away")
    local qb, carrier = Game.FlagPlayer("QB"), Game.FlagPlayer("Carrier")
    return string.format("%s | %s | %s | yard %s | play clock %s | QB %s | ball %s",
        score, tostring(Game.Flag("StatusTag") or "-"), tostring(Game.Flag("PlayType") or "-"),
        tostring(Game.Flag("YardTag") or "-"), tostring(Game.Flag("Playclock") or "-"),
        qb and qb.DisplayName or "-", carrier and carrier.DisplayName or (Game.Flag("Thrown") and "in the air" or "-"))
end

local Driver = { Errors = {}, PerFrame = {}, OnStart = {} }

function Driver.Run(name, fn, ...)
    local ok, err = pcall(fn, ...)
    if not ok and not R.Unloading then
        local last = Driver.Errors[name]
        if not last or os.clock() - last > 5 then
            Driver.Errors[name] = os.clock()
            warn("[FH] " .. name .. ": " .. tostring(err))
        end
    end
end

function Driver.Start()
    RunService:BindToRenderStep("FH_Frame", Enum.RenderPriority.Camera.Value + 1, function()
        if R.Unloading then return end
        R.FrameCount = R.FrameCount + 1
        Driver.Run("ball", Ball.Step)
        Driver.Run("magnet", Catch.Magnet)
        Driver.Run("catch click", Catch.AutoClick)
        Driver.Run("visuals", Visual.Frame)
        for name, fn in pairs(Driver.PerFrame) do Driver.Run(name, fn) end
    end)
    for _, fn in ipairs(Driver.OnStart) do Driver.Run("start", fn) end
    Track(function() pcall(function() RunService:UnbindFromRenderStep("FH_Frame") end) end)
    Track(RunService.Heartbeat:Connect(function()
        if not R.Unloading then Driver.Run("movement", Move.Step) end
    end))
    Loop(0.1, function() return true end, Catch.AutoRun)
    Loop(0.5, function() return true end, Look.Apply)
    Loop(600, function() return S.AutoDailyXP end, Misc.DailyXP)
end

local Field = {}

local function Flat(v) return Vector3.new(v.X, 0, v.Z) end

function Field.Axis()
    local g1, g2 = Workspace:FindFirstChild("LineGoal1"), Workspace:FindFirstChild("LineGoal2")
    if g1 and g2 and g1:IsA("BasePart") and g2:IsA("BasePart") then
        local d = Flat(g2.Position - g1.Position)
        if d.Magnitude > 20 then return d.Unit, d.Magnitude / 100 end
    end
    return Vector3.new(0, 0, 1), 3
end

function Field.Yards(a, b)
    local axis, perYard = Field.Axis()
    return math.abs((b - a):Dot(axis)) / perYard
end

function Game.SameTeam(a, b)
    return a ~= nil and b ~= nil and a.Team ~= nil and a.Team == b.Team and not a.Neutral
end

function Game.MyPossession()
    local tag = Game.Flag("PossessionTag")
    if LocalPlayer.Team and type(tag) == "string" and tag ~= "" then return tag == LocalPlayer.Team.Name end
    local carrier = Game.FlagPlayer("Carrier")
    return carrier ~= nil and Game.IsTeammate(carrier)
end

local QB = { LearnedSpeed = nil, Throws = 0 }

function QB.HasBall()
    local char = Char()
    return Game.FlagPlayer("Carrier") == LocalPlayer or (char ~= nil and char:FindFirstChild("Football") ~= nil)
end

function QB.Speed()
    if S.QBLearn and QB.LearnedSpeed then return QB.LearnedSpeed end
    return math.max(S.QBBallSpeed, 10)
end

function QB.PickReceiver()
    local mouse = UserInputService:GetMouseLocation()
    local best, bestOff
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= LocalPlayer and Game.IsTeammate(p) then
            local root = Root(p.Character)
            if root then
                local screen, on = Screen(root.Position)
                local off = (screen - mouse).Magnitude
                if on and off <= S.QBAimFOV and (not bestOff or off < bestOff) then best, bestOff = p, off end
            end
        end
    end
    return best
end

function QB.LeadPoint(receiver)
    local me, root = Root(), Root(receiver.Character)
    if not (me and root) then return nil end
    local vel = Flat(root.AssemblyLinearVelocity)
    local speed = QB.Speed()
    local point, t = root.Position, 0
    for _ = 1, 4 do
        t = Flat(point - me.Position).Magnitude / speed
        point = root.Position + vel * t * S.QBLeadScale
    end
    return point, t
end

function QB.Frame()
    if not QB.Circle and HasDrawing then
        QB.Circle = Draw("Circle", { Radius = 9, Thickness = 2, NumSides = 24, Filled = false, Visible = false })
        QB.Text = Draw("Text", { Size = 13, Center = true, Outline = true, Font = 2, Visible = false })
    end
    local active = (S.QBLead or S.QBAim) and QB.HasBall()
    local receiver = active and QB.PickReceiver() or nil
    local point, t
    if receiver then point, t = QB.LeadPoint(receiver) end
    local screen, on
    if point then screen, on = Screen(point) end

    if QB.Circle then
        local show = S.QBLead and on
        QB.Circle.Visible, QB.Text.Visible = show or false, show or false
        if show then
            QB.Circle.Position, QB.Circle.Color = screen, S.BallColor
            QB.Text.Position, QB.Text.Color = screen + Vector2.new(0, 12), S.BallColor
            QB.Text.Text = string.format("%s  %.1fs", receiver.DisplayName, t or 0)
        end
    end

    if S.QBAim and on and KeyDown(S.QBAimKey) and type(mousemoverel) == "function" and not (UI.Lib and UI.Lib:IsOpen()) then
        local delta = (screen - UserInputService:GetMouseLocation()) / math.max(S.QBAimSmooth, 1)
        if delta.Magnitude > 0.5 then mousemoverel(delta.X, delta.Y) end
    end
end

function QB.Learn()
    task.delay(0.15, function()
        local ball = Game.Ball()
        if not ball then return end
        local v = Flat(ball.AssemblyLinearVelocity).Magnitude
        if v < 5 then
            local pos, vel = Ball.Motion()
            if pos then v = Flat(vel).Magnitude end
        end
        if v > 15 and v < 400 then
            QB.Throws = QB.Throws + 1
            QB.LearnedSpeed = QB.LearnedSpeed and (QB.LearnedSpeed * 0.6 + v * 0.4) or v
        end
    end)
end

Driver.PerFrame["qb aim"] = QB.Frame

local Defense = { Steering = false, LastTackle = 0, LastBlock = 0 }

function Defense.Intercept(target, from, speed)
    local p, v = target.Position, Flat(target.AssemblyLinearVelocity)
    local d = Flat(p - from)
    local a = v:Dot(v) - speed * speed
    local b = 2 * d:Dot(v)
    local c = d:Dot(d)
    local t
    if math.abs(a) < 1e-3 then
        t = b ~= 0 and -c / b or 0
    else
        local disc = b * b - 4 * a * c
        if disc >= 0 then
            local sq = math.sqrt(disc)
            local t1, t2 = (-b - sq) / (2 * a), (-b + sq) / (2 * a)
            if t1 > 0 and t2 > 0 then t = math.min(t1, t2) else t = math.max(t1, t2) end
        end
    end
    if not t or t < 0 then t = 0 end
    return p + v * math.min(t, 3)
end

function Defense.Touch(theirChar)
    if type(firetouchinterest) ~= "function" or not theirChar then return end
    local targets = {}
    for _, name in ipairs({ "Torso", "UpperTorso", "HumanoidRootPart" }) do
        local part = theirChar:FindFirstChild(name)
        if part then table.insert(targets, part) end
    end
    for _, mine in ipairs(Catch.BodyParts()) do
        for _, theirs in ipairs(targets) do
            pcall(firetouchinterest, mine, theirs, 0)
            pcall(firetouchinterest, mine, theirs, 1)
        end
    end
end

function Defense.MarkTarget(root)
    local mark = Defense.Mark
    local qb = Game.FlagPlayer("QB")
    local markRoot = mark and mark.Parent and not Game.IsTeammate(mark) and Root(mark.Character)
    if markRoot and (markRoot.Position - root.Position).Magnitude < 60 then return markRoot end
    local best, bestDist
    for _, p in ipairs(Players:GetPlayers()) do
        if p ~= qb and not Game.IsTeammate(p) and not p.Neutral then
            local r = Root(p.Character)
            if r then
                local d = (r.Position - root.Position).Magnitude
                if not bestDist or d < bestDist then best, bestDist = p, d end
            end
        end
    end
    Defense.Mark = best
    return best and Root(best.Character) or nil
end

function Defense.AutoDefense(root, hum)
    local pred = R.Prediction
    if pred and (Game.Flag("Thrown") or Game.Flag("Fumble")) then return pred.Point end
    local speed = math.max(hum.WalkSpeed, 1)
    local carrier, qb = Game.FlagPlayer("Carrier"), Game.FlagPlayer("QB")
    local carrierRoot = carrier and carrier ~= LocalPlayer and not Game.IsTeammate(carrier) and Root(carrier.Character)
    if carrierRoot and (carrier ~= qb or S.DefenseMode == "Rush QB") then
        return Defense.Intercept(carrierRoot, root.Position, speed)
    end
    if S.DefenseMode == "Man" then
        local markRoot = Defense.MarkTarget(root)
        if markRoot then return markRoot.Position + Flat(markRoot.AssemblyLinearVelocity) * 0.35 end
    end
    return nil
end

function Defense.Step()
    local hum, root = Hum(), Root()
    if not (hum and root) then return end
    local carrier = Game.FlagPlayer("Carrier")
    local carrierRoot = carrier and carrier ~= LocalPlayer and Root(carrier.Character)
    local steer

    if S.AutoDefense and not Game.MyPossession() and (KeyEnum(S.DefenseKey) == nil or KeyDown(S.DefenseKey)) then
        steer = Defense.AutoDefense(root, hum)
    end

    if carrierRoot and not Game.IsTeammate(carrier) then
        if not steer and S.AutoPursue and (KeyEnum(S.PursueKey) == nil or KeyDown(S.PursueKey)) then
            steer = Defense.Intercept(carrierRoot, root.Position, math.max(hum.WalkSpeed, 1))
        end
        if S.TackleReach and os.clock() - Defense.LastTackle > 0.1
            and (carrierRoot.Position - root.Position).Magnitude <= S.TackleRange then
            Defense.LastTackle = os.clock()
            Defense.Touch(carrier.Character)
        end
    end

    if Game.MyPossession() and carrier ~= LocalPlayer then
        local protect = (carrierRoot and Game.IsTeammate(carrier)) and carrier or Game.FlagPlayer("QB")
        local protectRoot = protect and protect ~= LocalPlayer and Game.IsTeammate(protect) and Root(protect.Character)
        if protectRoot and S.AutoBlock and (KeyEnum(S.BlockKey) == nil or KeyDown(S.BlockKey)) then
            local threat, threatDist
            for _, p in ipairs(Players:GetPlayers()) do
                local r = not Game.IsTeammate(p) and not p.Neutral and Root(p.Character)
                if r then
                    local d = (r.Position - protectRoot.Position).Magnitude
                    if not threatDist or d < threatDist then threat, threatDist = r, d end
                end
            end
            if threat then
                local toward = Flat(protectRoot.Position - threat.Position)
                if toward.Magnitude > 0.1 then steer = threat.Position + toward.Unit * math.min(3, toward.Magnitude / 2) end
            end
        end
        if S.BlockReach and os.clock() - Defense.LastBlock > 0.15 then
            Defense.LastBlock = os.clock()
            for _, p in ipairs(Players:GetPlayers()) do
                local r = not Game.IsTeammate(p) and not p.Neutral and Root(p.Character)
                if r and (r.Position - root.Position).Magnitude <= S.BlockRange then Defense.Touch(p.Character) end
            end
        end
    end

    if steer and not R.Running then
        hum:MoveTo(Vector3.new(steer.X, root.Position.Y, steer.Z))
        Defense.Steering = true
    elseif Defense.Steering and not steer then
        Defense.Steering = false
        if not R.Running then hum:MoveTo(root.Position) end
    end
end

table.insert(Driver.OnStart, function()
    Loop(0.1, function()
        return S.AutoDefense or S.AutoPursue or S.TackleReach or S.AutoBlock or S.BlockReach or Defense.Steering
    end, Defense.Step)
    local flags = Game.Flags()
    local tag = flags and flags:FindFirstChild("StatusTag")
    if tag then Track(tag.Changed:Connect(function() Defense.Mark = nil end)) end
end)

local Stats = {
    N = { Catches = 0, Yards = 0, TDs = 0, Ints = 0, Tackles = 0, Attempts = 0, Completions = 0, PassYards = 0, IntsThrown = 0 },
    Pass = nil,
    Carrier = nil,
    RunStart = nil,
    LastCarrier = nil,
    LastCarrierAt = 0,
    Scores = {},
    StartedAt = os.time(),
}

function Stats.OnThrown(value)
    if not value then return end
    local passer = Game.FlagPlayer("QB") or Stats.LastCarrier
    local ball = Game.Ball()
    local passerRoot = passer and Root(passer.Character)
    Stats.Pass = { By = passer, From = (ball and ball.Position) or (passerRoot and passerRoot.Position), At = os.clock() }
    if passer == LocalPlayer then
        Stats.N.Attempts = Stats.N.Attempts + 1
        QB.Learn()
    end
end

function Stats.OnCarrier()
    local new = Game.FlagPlayer("Carrier")
    local prev = Stats.Carrier
    local now = os.clock()
    local myRoot = Root()

    if prev == LocalPlayer and new ~= LocalPlayer and Stats.RunStart and myRoot then
        local from, to = Stats.RunStart, myRoot.Position
        Stats.RunStart = nil
        task.delay(0.4, function()
            local threw = Stats.Pass and Stats.Pass.By == LocalPlayer and os.clock() - Stats.Pass.At < 1
            if not threw then Stats.N.Yards = Stats.N.Yards + Field.Yards(from, to) end
        end)
    end

    if prev and new == nil and prev ~= LocalPlayer and not Game.IsTeammate(prev) and myRoot then
        local r = Root(prev.Character)
        if r and (r.Position - myRoot.Position).Magnitude <= 6 then Stats.N.Tackles = Stats.N.Tackles + 1 end
    end

    local pass = Stats.Pass
    if new and pass and now - pass.At < 10 and pass.By ~= new then
        Stats.Pass = nil
        local sameTeam = Game.SameTeam(new, pass.By)
        if pass.By == LocalPlayer then
            if sameTeam then
                Stats.N.Completions = Stats.N.Completions + 1
                local r = Root(new.Character)
                if r and pass.From then Stats.N.PassYards = Stats.N.PassYards + Field.Yards(pass.From, r.Position) end
            else
                Stats.N.IntsThrown = Stats.N.IntsThrown + 1
            end
        end
        if new == LocalPlayer then
            Stats.N.Catches = Stats.N.Catches + 1
            if pass.By and not Game.SameTeam(pass.By, LocalPlayer) then Stats.N.Ints = Stats.N.Ints + 1 end
        end
    end

    if new == LocalPlayer and myRoot then Stats.RunStart = myRoot.Position end
    Stats.Carrier = new
    if new then Stats.LastCarrier, Stats.LastCarrierAt = new, now end
end

function Stats.OnScore(flagName, value)
    local before = Stats.Scores[flagName] or value
    Stats.Scores[flagName] = value
    if value - before < 6 then return end
    local team = Game.Flag(flagName == "HomeScore" and "Home" or "Away")
    if Stats.LastCarrier == LocalPlayer and os.clock() - Stats.LastCarrierAt < 4
        and (typeof(team) ~= "Instance" or team == LocalPlayer.Team) then
        Stats.N.TDs = Stats.N.TDs + 1
        Notify("Touchdown", "That's " .. Stats.N.TDs .. " this session.", 3)
        if S.WebhookOn and S.WebhookOnTD then task.spawn(Stats.Report, "Touchdown!") end
    end
end

function Stats.Summary()
    local n = Stats.N
    return string.format("%d catches, %d yds, %d TD, %d INT, %d tackles | passing %d/%d, %d yds, %d INT thrown",
        n.Catches, math.floor(n.Yards + 0.5), n.TDs, n.Ints, n.Tackles, n.Completions, n.Attempts, math.floor(n.PassYards + 0.5), n.IntsThrown)
end

function Stats.Report(title)
    local url = tostring(S.WebhookURL or "")
    if not url:match("^https://discord%.com/api/webhooks/") and not url:match("^https://discordapp%.com/api/webhooks/") then
        return false, "that isn't a Discord webhook URL"
    end
    local req = (syn and syn.request) or http_request or request or (http and http.request)
    if type(req) ~= "function" then return false, "this executor can't send HTTP requests" end
    local n = Stats.N
    local mins = math.floor((os.time() - Stats.StartedAt) / 60)
    local body = HttpService:JSONEncode({
        embeds = { {
            title = "Fusion Hub" .. (title and (" - " .. title) or ""),
            color = 16750120,
            fields = {
                { name = "Receiving", value = string.format("%d catches, %d yds", n.Catches, math.floor(n.Yards + 0.5)), inline = true },
                { name = "Touchdowns", value = tostring(n.TDs), inline = true },
                { name = "Defense", value = string.format("%d INT, %d tackles", n.Ints, n.Tackles), inline = true },
                { name = "Passing", value = string.format("%d/%d, %d yds, %d INT", n.Completions, n.Attempts, math.floor(n.PassYards + 0.5), n.IntsThrown), inline = true },
                { name = "Match", value = Misc.MatchInfo(), inline = false },
                { name = "Session", value = mins .. " min", inline = true },
            },
            footer = { text = LocalPlayer.Name },
        } },
    })
    local ok, res = pcall(req, { Url = url, Method = "POST", Headers = { ["Content-Type"] = "application/json" }, Body = body })
    if not ok then return false, tostring(res) end
    local code = type(res) == "table" and tonumber(res.StatusCode) or 204
    return code >= 200 and code < 300, code
end

table.insert(Driver.OnStart, function()
    local flags = Game.Flags()
    if not flags then return end
    local thrown, carrier = flags:FindFirstChild("Thrown"), flags:FindFirstChild("Carrier")
    if thrown then Track(thrown.Changed:Connect(function(v) Driver.Run("stats", Stats.OnThrown, v) end)) end
    if carrier then Track(carrier.Changed:Connect(function() Driver.Run("stats", Stats.OnCarrier) end)) end
    Stats.Carrier = Game.FlagPlayer("Carrier")
    for _, name in ipairs({ "HomeScore", "AwayScore" }) do
        local v = flags:FindFirstChild(name)
        if v then
            Stats.Scores[name] = v.Value
            Track(v.Changed:Connect(function(value) Driver.Run("stats", Stats.OnScore, name, value) end))
        end
    end
    local lastReport = os.clock()
    Loop(30, function() return S.WebhookOn end, function()
        if os.clock() - lastReport >= S.WebhookEvery * 60 then
            lastReport = os.clock()
            Stats.Report()
        end
    end)
end)

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

UI.Root = "FusionHub"
UI.ConfigDir = "FusionHub/configs"
UI.AutoloadFile = "FusionHub/autoload.txt"

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
        writefile(UI.ConfigPath(name), HttpService:JSONEncode({ Game = "FusionHub", Version = 1, Values = values }))
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
    { "Auto Run", "AutoRun", "AutoRunKey" },
    { "Magnet", "Magnet" },
    { "Auto Catch", "AutoCatchClick" },
    { "QB Aim", "QBAim", "QBAimKey" },
    { "Auto Defense", "AutoDefense", "DefenseKey" },
    { "Pursue", "AutoPursue", "PursueKey" },
    { "Tackle Reach", "TackleReach" },
    { "Auto Block", "AutoBlock", "BlockKey" },
    { "Block Reach", "BlockReach" },
    { "Player ESP", "PlayerESP" },
    { "Speed", "SpeedHack" },
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
        UI.WatermarkObj:SetText(string.format('<font color="#%s">fusion hub</font> | %d fps | %d ms | %s',
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

local Window = nil
UI.Status = {}

local function set(key) return function(v) S[key] = v end end

local function BuildBallTab(Window)
    local Tab = Window:Tab({ Title = "Ball" })

    Tab:Section({ Title = "Catching", Side = "Left" })
    Tab:Toggle({
        Title = "Auto Run To Ball",
        Desc = "When the ball is in the air, walks you to where it comes down at catch height.",
        Default = S.AutoRun,
        Callback = set("AutoRun"),
    })
    Tab:Keybind({ Title = "Hold Key", Desc = "NONE = always while it's on.", Default = S.AutoRunKey, Callback = set("AutoRunKey") })
    Tab:Toggle({ Title = "Only My Team's Passes", Desc = "Ignore passes thrown by the other team's QB (leave off to jump routes on defense).", Default = S.AutoRunOnlyMine, Callback = set("AutoRunOnlyMine") })
    Tab:Toggle({
        Title = "Ball Magnet",
        Desc = "Touches the ball with your arms when it's within reach (firetouchinterest). The server decides if it counts as a catch.",
        Default = S.Magnet,
        Callback = function(v)
            S.Magnet = v
            if v and type(firetouchinterest) ~= "function" and not UI.Init then
                Notify("Magnet", "This executor has no firetouchinterest, so the magnet can't work here.", 5)
            end
        end,
    })
    Tab:Slider({ Title = "Magnet Reach", Min = 2, Max = 25, Default = S.MagnetRange, Step = 0.5, Suffix = " studs", Callback = set("MagnetRange") })
    Tab:Toggle({ Title = "Magnet Only On Passes", Desc = "Only while Flags.Thrown / Fumble is set.", Default = S.MagnetOnlyThrown, Callback = set("MagnetOnlyThrown") })
    Tab:Toggle({ Title = "Auto Catch Click", Desc = "Clicks (the catch input) as a pass reaches you.", Default = S.AutoCatchClick, Callback = set("AutoCatchClick") })
    Tab:Slider({ Title = "Click Distance", Min = 3, Max = 25, Default = S.AutoCatchRange, Step = 0.5, Suffix = " studs", Callback = set("AutoCatchRange") })
    Tab:Slider({ Title = "Catch Height", Desc = "Where above your root the landing point is measured.", Min = 0, Max = 6, Default = S.CatchHeight, Step = 0.25, Suffix = " studs", Callback = set("CatchHeight") })

    Tab:Section({ Title = "Ball Visuals", Side = "Right" })
    Tab:Toggle({ Title = "Ball ESP", Desc = "Highlight, distance and time until it lands.", Default = S.BallESP, Callback = set("BallESP") })
    Tab:Toggle({ Title = "Flight Path", Default = S.BallPath, Callback = set("BallPath") })
    Tab:Toggle({ Title = "Landing Spot", Default = S.BallLanding, Callback = set("BallLanding") })
    Tab:Colorpicker({ Title = "Ball Color", Default = S.BallColor, Callback = set("BallColor") })
    Tab:Colorpicker({ Title = "Path Color", Default = S.PathColor, Callback = set("PathColor") })

    Tab:Section({ Title = "Status", Side = "Right" })
    UI.Status.Ball = Tab:Label({ Title = "Ball", Desc = "-" })
    UI.Status.Match = Tab:Label({ Title = "Match", Desc = "-" })
    UI.Status.Catches = Tab:Label({ Title = "Session", Desc = "-" })
end

local function BuildPlayersTab(Window)
    local Tab = Window:Tab({ Title = "Players" })

    Tab:Section({ Title = "ESP", Side = "Left" })
    Tab:Toggle({ Title = "Player ESP", Desc = "Name tags over everyone.", Default = S.PlayerESP, Callback = set("PlayerESP") })
    Tab:Toggle({ Title = "Show Teammates", Default = S.ESPTeam, Callback = set("ESPTeam") })
    Tab:Toggle({ Title = "Names", Default = S.ESPNames, Callback = set("ESPNames") })
    Tab:Toggle({ Title = "Distance", Default = S.ESPDistance, Callback = set("ESPDistance") })
    Tab:Toggle({ Title = "Roles", Desc = "[QB], [BALL] carrier, [K] kicker.", Default = S.ESPRoles, Callback = set("ESPRoles") })
    Tab:Toggle({ Title = "Chams", Default = S.Chams, Callback = set("Chams") })
    Tab:Slider({ Title = "Chams See-Through", Min = 0, Max = 1, Default = S.ChamsFill, Step = 0.05, Callback = set("ChamsFill") })

    Tab:Section({ Title = "Reads", Side = "Right" })
    Tab:Toggle({ Title = "Open Receivers", Desc = "Teammates with no defender within the distance below turn green and say OPEN (for QBs).", Default = S.OpenReceivers, Callback = set("OpenReceivers") })
    Tab:Slider({ Title = "Open Distance", Min = 4, Max = 30, Default = S.OpenDistance, Step = 1, Suffix = " studs", Callback = set("OpenDistance") })
    Tab:Toggle({ Title = "Ball Carrier Tracer", Desc = "A line to whoever has the ball.", Default = S.CarrierTracer, Callback = set("CarrierTracer") })

    Tab:Section({ Title = "Colors", Side = "Right" })
    Tab:Colorpicker({ Title = "Teammates", Default = S.TeamColor, Callback = set("TeamColor") })
    Tab:Colorpicker({ Title = "Opponents", Default = S.EnemyColor, Callback = set("EnemyColor") })
    Tab:Colorpicker({ Title = "Ball Carrier", Default = S.CarrierColor, Callback = set("CarrierColor") })
end

local function BuildPlayerTab(Window)
    local Tab = Window:Tab({ Title = "Movement" })

    Tab:Section({ Title = "Movement", Side = "Left" })
    Tab:Toggle({ Title = "Walk Speed", Desc = "Big jumps over the normal speed are easy for the server to spot.", Default = S.SpeedHack, Callback = set("SpeedHack") })
    Tab:Slider({ Title = "Speed", Min = 16, Max = 40, Default = S.WalkSpeed, Step = 0.5, Callback = set("WalkSpeed") })
    Tab:Toggle({ Title = "Jump Power", Default = S.JumpHack, Callback = set("JumpHack") })
    Tab:Slider({ Title = "Jump", Min = 30, Max = 120, Default = S.JumpPower, Step = 1, Callback = set("JumpPower") })
    Tab:Toggle({ Title = "Infinite Jump", Default = S.InfiniteJump, Callback = set("InfiniteJump") })

    Tab:Section({ Title = "Misc", Side = "Right" })
    Tab:Toggle({ Title = "Auto Daily XP", Desc = "Sends the game's own daily XP claim every 10 min (it only pays once a day).", Default = S.AutoDailyXP, Callback = set("AutoDailyXP") })
    Tab:Button({ Title = "Claim Daily XP Now", Callback = Misc.DailyXP })
    Tab:Toggle({ Title = "Anti AFK", Default = S.AntiAFK, Callback = set("AntiAFK") })
end

local function BuildPlaysTab(Window)
    local Tab = Window:Tab({ Title = "QB & Defense" })

    Tab:Section({ Title = "Quarterback", Side = "Left" })
    Tab:Toggle({
        Title = "Lead Marker",
        Desc = "With the ball: a circle where to aim so the pass meets the receiver nearest your mouse in stride.",
        Default = S.QBLead,
        Callback = set("QBLead"),
    })
    Tab:Toggle({ Title = "Aim Assist", Desc = "Moves your mouse onto the lead spot while the key is held.", Default = S.QBAim, Callback = set("QBAim") })
    Tab:Keybind({ Title = "Aim Key", Default = S.QBAimKey, Callback = set("QBAimKey") })
    Tab:Slider({ Title = "Aim Smoothness", Min = 1, Max = 10, Default = S.QBAimSmooth, Step = 0.5, Callback = set("QBAimSmooth") })
    Tab:Slider({ Title = "Pick Radius", Desc = "How close to your mouse a receiver has to be.", Min = 50, Max = 800, Default = S.QBAimFOV, Step = 10, Suffix = " px", Callback = set("QBAimFOV") })
    Tab:Slider({ Title = "Lead Amount", Desc = "Raise it if passes land behind receivers, lower it if they land ahead.", Min = 0.5, Max = 1.8, Default = S.QBLeadScale, Step = 0.05, Suffix = "x", Callback = set("QBLeadScale") })
    Tab:Toggle({ Title = "Learn Ball Speed", Desc = "Measures your own throws and uses their average speed.", Default = S.QBLearn, Callback = set("QBLearn") })
    Tab:Slider({ Title = "Ball Speed (until learned)", Min = 20, Max = 200, Default = S.QBBallSpeed, Step = 1, Suffix = " st/s", Callback = set("QBBallSpeed") })
    UI.Status.QB = Tab:Label({ Title = "Throws", Desc = "-" })

    Tab:Section({ Title = "Auto Defense", Side = "Right" })
    Tab:Toggle({
        Title = "Auto Defense",
        Desc = "When the other team has the ball: covers your man (or rushes the QB), runs to a pass in the air, then chases whoever caught it. It also moves you before the snap, so bind a hold key if that's a problem.",
        Default = S.AutoDefense,
        Callback = set("AutoDefense"),
    })
    Tab:Dropdown({
        Title = "Assignment",
        Desc = "Man: shadows the receiver nearest you. Rush QB: goes after the QB. Zone: stays put until the ball is thrown.",
        Options = { "Man", "Rush QB", "Zone" },
        Default = S.DefenseMode,
        Callback = set("DefenseMode"),
    })
    Tab:Keybind({ Title = "Hold Key", Desc = "NONE = always.", Default = S.DefenseKey, Callback = set("DefenseKey") })

    Tab:Section({ Title = "Tackling", Side = "Right" })
    Tab:Toggle({ Title = "Auto Pursue", Desc = "Runs the angle to meet the other team's ball carrier (not their back).", Default = S.AutoPursue, Callback = set("AutoPursue") })
    Tab:Keybind({ Title = "Pursue Key", Desc = "NONE = always.", Default = S.PursueKey, Callback = set("PursueKey") })
    Tab:Toggle({ Title = "Tackle Reach", Desc = "Touches their ball carrier once they're this close (the server decides if it's a tackle).", Default = S.TackleReach, Callback = set("TackleReach") })
    Tab:Slider({ Title = "Tackle Distance", Min = 3, Max = 20, Default = S.TackleRange, Step = 0.5, Suffix = " studs", Callback = set("TackleRange") })

    Tab:Section({ Title = "Blocking", Side = "Left" })
    Tab:Toggle({ Title = "Auto Block", Desc = "Steps in front of the rusher closest to your ball carrier (or QB).", Default = S.AutoBlock, Callback = set("AutoBlock") })
    Tab:Keybind({ Title = "Block Key", Desc = "NONE = always.", Default = S.BlockKey, Callback = set("BlockKey") })
    Tab:Toggle({ Title = "Block Reach", Desc = "Touches rushers within this distance while your team has the ball.", Default = S.BlockReach, Callback = set("BlockReach") })
    Tab:Slider({ Title = "Block Distance", Min = 3, Max = 20, Default = S.BlockRange, Step = 0.5, Suffix = " studs", Callback = set("BlockRange") })
end

local function BuildLookTab(Window)
    local Tab = Window:Tab({ Title = "Look" })

    Tab:Section({ Title = "Lighting", Side = "Left" })
    Tab:Toggle({ Title = "Fullbright", Default = S.Fullbright, Callback = set("Fullbright") })
    Tab:Toggle({ Title = "No Shadows", Default = S.NoShadows, Callback = set("NoShadows") })
    Tab:Toggle({ Title = "No Fog", Default = S.NoFog, Callback = set("NoFog") })
    Tab:Toggle({ Title = "Custom Time", Default = S.CustomTime, Callback = set("CustomTime") })
    Tab:Slider({ Title = "Time", Min = 0, Max = 24, Default = S.ClockTime, Step = 0.25, Suffix = "h", Callback = set("ClockTime") })
    Tab:Toggle({ Title = "Custom Lighting", Default = S.CustomLighting, Callback = set("CustomLighting") })
    Tab:Slider({ Title = "Brightness", Min = 0, Max = 6, Default = S.LightBrightness, Step = 0.1, Callback = set("LightBrightness") })
    Tab:Colorpicker({ Title = "Ambient", Default = S.LightAmbient, Callback = set("LightAmbient") })
    Tab:Slider({ Title = "Exposure", Min = -3, Max = 3, Default = S.LightExposure, Step = 0.1, Callback = set("LightExposure") })

    Tab:Section({ Title = "Atmosphere", Side = "Right" })
    Tab:Toggle({ Title = "Custom Atmosphere", Default = S.CustomAtmosphere, Callback = set("CustomAtmosphere") })
    Tab:Slider({ Title = "Density", Min = 0, Max = 1, Default = S.AtmoDensity, Step = 0.01, Callback = set("AtmoDensity") })
    Tab:Slider({ Title = "Haze", Min = 0, Max = 10, Default = S.AtmoHaze, Step = 0.1, Callback = set("AtmoHaze") })
    Tab:Slider({ Title = "Glare", Min = 0, Max = 10, Default = S.AtmoGlare, Step = 0.1, Callback = set("AtmoGlare") })
    Tab:Colorpicker({ Title = "Color", Default = S.AtmoColor, Callback = set("AtmoColor") })

    Tab:Section({ Title = "Post FX", Side = "Right" })
    Tab:Toggle({ Title = "No Blur", Desc = "The game's blur effect.", Default = S.NoBlur, Callback = set("NoBlur") })
    Tab:Toggle({ Title = "Hide Map Effects", Desc = "The map's own blur / color / sun rays.", Default = S.NoPostFX, Callback = set("NoPostFX") })
    Tab:Slider({ Title = "Saturation", Min = -100, Max = 100, Default = S.Saturation, Step = 1, Callback = set("Saturation") })
    Tab:Toggle({ Title = "Color Correction", Default = S.CCEnabled, Callback = set("CCEnabled") })
    Tab:Colorpicker({ Title = "Tint", Default = S.CCTint, Callback = set("CCTint") })
    Tab:Slider({ Title = "Contrast", Min = -1, Max = 1, Default = S.CCContrast, Step = 0.05, Callback = set("CCContrast") })
    Tab:Slider({ Title = "CC Brightness", Min = -1, Max = 1, Default = S.CCBrightness, Step = 0.05, Callback = set("CCBrightness") })
    Tab:Toggle({ Title = "Bloom", Default = S.BloomEnabled, Callback = set("BloomEnabled") })
    Tab:Slider({ Title = "Bloom Intensity", Min = 0, Max = 3, Default = S.BloomIntensity, Step = 0.05, Callback = set("BloomIntensity") })
    Tab:Slider({ Title = "Bloom Size", Min = 1, Max = 56, Default = S.BloomSize, Step = 1, Callback = set("BloomSize") })
    Tab:Slider({ Title = "Bloom Threshold", Min = 0, Max = 4, Default = S.BloomThreshold, Step = 0.05, Callback = set("BloomThreshold") })
    Tab:Toggle({ Title = "Sun Rays", Default = S.SunRays, Callback = set("SunRays") })
    Tab:Slider({ Title = "Sun Rays Intensity", Min = 0, Max = 1, Default = S.SunRaysIntensity, Step = 0.01, Callback = set("SunRaysIntensity") })

    Tab:Section({ Title = "Sky", Side = "Left" })
    Tab:Dropdown({ Title = "Skybox", Options = Look.SkyPresets, Default = S.SkyPreset, Callback = set("SkyPreset") })
    Tab:Input({ Title = "Sky Asset ID", Placeholder = "e.g. 159454299", Callback = set("SkyCustomId") })

    Tab:Section({ Title = "You & The Ball", Side = "Left" })
    Tab:Toggle({ Title = "Self Chams", Desc = "Your own body's material and color (only you see it).", Default = S.SelfChams, Callback = set("SelfChams") })
    Tab:Dropdown({ Title = "Material", Options = Look.Materials, Default = S.SelfMaterial, Callback = set("SelfMaterial") })
    Tab:Colorpicker({ Title = "Color", Default = S.SelfColor, Callback = set("SelfColor") })
    Tab:Slider({ Title = "See-Through", Min = 0, Max = 0.9, Default = S.SelfTransparency, Step = 0.05, Callback = set("SelfTransparency") })
    Tab:Toggle({ Title = "Ball Glow", Desc = "A light on the ball in the ball color.", Default = S.BallGlow, Callback = set("BallGlow") })
end

local function BuildStatsTab(Window)
    local Tab = Window:Tab({ Title = "Stats" })

    Tab:Section({ Title = "This Session", Side = "Left" })
    UI.Status.Stats = Tab:Label({ Title = "Stats", Desc = "-" })
    Tab:Button({
        Title = "Reset Stats",
        Callback = function()
            for k in pairs(Stats.N) do Stats.N[k] = 0 end
            Stats.StartedAt = os.time()
        end,
    })

    Tab:Section({ Title = "Discord Webhook", Side = "Right" })
    Tab:Input({ Title = "Webhook URL", Placeholder = "https://discord.com/api/webhooks/...", Callback = set("WebhookURL") })
    Tab:Toggle({ Title = "Send Reports", Default = S.WebhookOn, Callback = set("WebhookOn") })
    Tab:Slider({ Title = "Every", Min = 5, Max = 120, Default = S.WebhookEvery, Step = 5, Suffix = " min", Callback = set("WebhookEvery") })
    Tab:Toggle({ Title = "Also On Touchdowns", Default = S.WebhookOnTD, Callback = set("WebhookOnTD") })
    Tab:Button({
        Title = "Send Test",
        Callback = function()
            task.spawn(function()
                local ok, info = Stats.Report("Test")
                Notify("Webhook", ok and "Sent." or ("Failed: " .. tostring(info)), 3)
            end)
        end,
    })
end

local function BuildSettingsTab(Window)
    local Tab = Window:Tab({ Title = "Settings" })

    Tab:Section({ Title = "Interface", Side = "Left" })
    Tab:Keybind({ Title = "Menu Toggle Key", Default = "RightShift", Callback = function(k) Window:SetToggleKey(k) end })
    Tab:Toggle({ Title = "Notifications", Default = S.Notifications, Callback = set("Notifications") })
    Tab:Toggle({
        Title = "Watermark",
        Default = S.Watermark,
        Callback = function(v)
            S.Watermark = v
            if UI.WatermarkObj then UI.WatermarkObj:SetVisible(v) end
        end,
    })
    Tab:Toggle({
        Title = "Keybind List",
        Default = S.KeybindList,
        Callback = function(v)
            S.KeybindList = v
            if UI.KeyListObj then UI.KeyListObj:SetVisible(v) end
        end,
    })

    Tab:Section({ Title = "Configs", Side = "Left" })
    local nameBox = Tab:Input({ Title = "Config Name", Placeholder = "e.g. wr, qb", NoSave = true, Callback = function(t) UI.ConfigName = t end })
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
        Callback = function()
            local ok, err = UI.SetAutoload(UI.ConfigName)
            Notify("Configs", ok and ("'" .. tostring(UI.ConfigName) .. "' will load on inject.") or ("Failed: " .. tostring(err)), 4)
        end,
    })
    Tab:Button({ Title = "Clear Auto-Load", Callback = function() UI.SetAutoload(nil); Notify("Configs", "Auto-load cleared.", 3) end })

    Tab:Section({ Title = "Script", Side = "Right" })
    Tab:Button({
        Title = "Unload",
        Desc = "Puts lighting, speed and camera back and removes everything.",
        Callback = function() if GlobalScope.FH_Cleanup then GlobalScope.FH_Cleanup() end end,
    })
end

local function UpdateStatus()
    local st = UI.Status
    if not st.Ball then return end
    local ball = Game.Ball()
    local text
    if not ball then
        text = "not in play"
    elseif Game.BallLoose(ball) then
        local pred = R.Prediction
        text = "in the air, " .. math.floor(ball.AssemblyLinearVelocity.Magnitude) .. " st/s"
            .. (pred and string.format(", lands in %.1fs", pred.Time) or "")
    else
        local carrier = Game.FlagPlayer("Carrier")
        text = "held by " .. (carrier and carrier.DisplayName or ball:GetFullName())
    end
    st.Ball:SetLabel("Ball: " .. text)
    st.Match:SetLabel("Match: " .. Misc.MatchInfo())
    st.Catches:SetLabel("Session: " .. Stats.Summary())
    if st.Stats then st.Stats:SetLabel(Stats.Summary()) end
    if st.QB then
        st.QB:SetLabel(string.format("Throws: %d measured, ball speed %s", QB.Throws,
            QB.LearnedSpeed and (math.floor(QB.LearnedSpeed) .. " st/s (learned)") or (S.QBBallSpeed .. " st/s (set)")))
    end
end

Loop(0.3, function() return UI.Status.Ball ~= nil end, UpdateStatus)

local function BuildUI()
    Obelus:SetAccent(Color3.fromRGB(255, 150, 40))
    local win = Obelus:Window({
        Name = "fusion hub",
        ToggleKey = S.ToggleKey,
        Size = UDim2.fromOffset(640, 540),
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
        { "ball", BuildBallTab }, { "qb & defense", BuildPlaysTab }, { "players", BuildPlayersTab },
        { "look", BuildLookTab }, { "movement", BuildPlayerTab }, { "stats", BuildStatsTab }, { "settings", BuildSettingsTab },
    }) do
        local ok, err = pcall(entry[2], Window)
        if not ok then warn("[FH] " .. entry[1] .. " tab failed: " .. tostring(err)) end
    end

    Notify("Football Fusion 3", (Game.Flags() and "Match data found." or "Waiting for match data...") .. " Menu: " .. S.ToggleKey.Name, 5)
    task.delay(1, function()
        if not R.Unloading then pcall(UI.Autoload) end
    end)
end

GlobalScope.FH_Cleanup = function()
    R.Unloading = true
    for _, k in ipairs({ "AutoRun", "Magnet", "AutoCatchClick", "PlayerESP", "Chams", "BallESP", "SpeedHack", "JumpHack",
        "InfiniteJump", "Fullbright", "NoBlur", "NoFog", "CustomTime", "AutoDailyXP", "QBLead", "QBAim", "AutoDefense",
        "AutoPursue", "TackleReach", "AutoBlock", "BlockReach", "WebhookOn", "SelfChams", "BallGlow" }) do
        S[k] = false
    end
    pcall(Catch.AutoRun)
    pcall(Defense.Step)
    if QB.Circle then QB.Circle.Visible, QB.Text.Visible = false, false end
    pcall(Move.Step)
    pcall(Look.Restore)
    pcall(Visual.Clear)
    for _, conn in ipairs(R.Connections) do pcall(function() conn:Disconnect() end) end
    table.clear(R.Connections)
    for _, d in ipairs(Drawings) do Undraw(d) end
    table.clear(Drawings)
    pcall(function() if Window then Window:Destroy() end end)
    GlobalScope.FH_Cleanup = nil
    warn("[FH] unloaded.")
end

local ok, err = pcall(BuildUI)
if not ok then
    warn("[FH] UI failed to build: " .. tostring(err))
    pcall(function()
        StarterGui:SetCore("SendNotification", { Title = "Fusion Hub", Text = "UI failed: " .. tostring(err), Duration = 8 })
    end)
end

Driver.Start()
