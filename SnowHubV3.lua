local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local Mouse = Player:GetMouse()

-- Configurações de animação
local ANIM_TIME = 0.3
local ANIM_STYLE = Enum.EasingStyle.Quad

-- Cores futuristas
local COLORS = {
    background = Color3.fromRGB(10, 10, 20),
    surface = Color3.fromRGB(20, 20, 35),
    primary = Color3.fromRGB(0, 200, 255),
    secondary = Color3.fromRGB(140, 80, 255),
    accent = Color3.fromRGB(255, 80, 140),
    text = Color3.fromRGB(255, 255, 255),
    textSoft = Color3.fromRGB(180, 180, 200),
    success = Color3.fromRGB(0, 255, 150),
    danger = Color3.fromRGB(255, 60, 60),
    glass = Color3.fromRGB(255, 255, 255)
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SnowyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 100

-- Botão flutuante futurista
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 55, 0, 55)
FloatingButton.Position = UDim2.new(0, 50, 0.5, -27.5)
FloatingButton.BackgroundColor3 = COLORS.surface
FloatingButton.Text = ""
FloatingButton.Parent = ScreenGui
FloatingButton.AutoButtonColor = false

-- Efeito de vidro no botão
local ButtonGlass = Instance.new("Frame")
ButtonGlass.Size = UDim2.new(1, 0, 1, 0)
ButtonGlass.BackgroundColor3 = COLORS.glass
ButtonGlass.BackgroundTransparency = 0.95
ButtonGlass.Parent = FloatingButton

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = FloatingButton

-- Borda neon
local ButtonStroke = Instance.new("UIStroke")
ButtonStroke.Thickness = 2
ButtonStroke.Color = COLORS.primary
ButtonStroke.Transparency = 0.5
ButtonStroke.Parent = FloatingButton

-- Logo S
local Logo = Instance.new("TextLabel")
Logo.Size = UDim2.new(1, 0, 1, 0)
Logo.BackgroundTransparency = 1
Logo.Text = "S"
Logo.TextColor3 = COLORS.primary
Logo.TextSize = 32
Logo.Font = Enum.Font.GothamBold
Logo.Parent = FloatingButton

-- Brilho pulsante
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1.3, 0, 1.3, 0)
Glow.Position = UDim2.new(-0.15, 0, -0.15, 0)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://3570695787"
Glow.ImageColor3 = COLORS.primary
Glow.ImageTransparency = 0.7
Glow.Parent = FloatingButton

-- Menu principal (futurista)
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 450)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -225)
MainFrame.BackgroundColor3 = COLORS.background
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Efeito glassmorphism
local GlassEffect = Instance.new("Frame")
GlassEffect.Size = UDim2.new(1, 0, 1, 0)
GlassEffect.BackgroundColor3 = COLORS.glass
GlassEffect.BackgroundTransparency = 0.97
GlassEffect.Parent = MainFrame

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Borda neon
local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 1.5
MainStroke.Color = COLORS.primary
MainStroke.Transparency = 0.8
MainStroke.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = COLORS.surface
TopBar.BackgroundTransparency = 0.3
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 16)
TopBarCorner.Parent = TopBar

-- Logo pequena no topo
local SmallLogo = Instance.new("TextLabel")
SmallLogo.Size = UDim2.new(0, 30, 0, 30)
SmallLogo.Position = UDim2.new(0, 15, 0.5, -15)
SmallLogo.BackgroundTransparency = 1
SmallLogo.Text = "S"
SmallLogo.TextColor3 = COLORS.primary
SmallLogo.TextSize = 24
SmallLogo.Font = Enum.Font.GothamBold
SmallLogo.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(0, 200, 1, 0)
Title.Position = UDim2.new(0, 50, 0, 0)
Title.Text = "SNOWY HUB"
Title.TextColor3 = COLORS.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local Version = Instance.new("TextLabel")
Version.Size = UDim2.new(0, 50, 1, 0)
Version.Position = UDim2.new(1, -100, 0, 0)
Version.Text = "V3"
Version.TextColor3 = COLORS.textSoft
Version.Font = Enum.Font.Gotham
Version.TextSize = 14
Version.TextXAlignment = Enum.TextXAlignment.Right
Version.BackgroundTransparency = 1
Version.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0.5, -17.5)
CloseBtn.BackgroundColor3 = COLORS.accent
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = COLORS.text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Abas futuristas
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 45)
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.BackgroundColor3 = COLORS.surface
TabFrame.BackgroundTransparency = 0.5
TabFrame.Parent = MainFrame

local TabFrameStroke = Instance.new("UIStroke")
TabFrameStroke.Thickness = 1
TabFrameStroke.Color = COLORS.primary
TabFrameStroke.Transparency = 0.9
TabFrameStroke.Parent = TabFrame

local function createTab(name, pos)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.25, -2, 0.7, 0)
    Btn.Position = UDim2.new(pos, 0, 0.15, 0)
    Btn.BackgroundColor3 = COLORS.primary
    Btn.BackgroundTransparency = 0.8
    Btn.Text = name
    Btn.TextColor3 = COLORS.text
    Btn.Font = Enum.Font.GothamBold
    Btn.TextSize = 14
    Btn.Parent = TabFrame

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 8)
    BtnCorner.Parent = Btn

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
    end)
    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
    end)
    return Btn
end

local TabMain = createTab("MAIN", 0.02)
local TabFarm = createTab("FARM", 0.27)
local TabMisc = createTab("MISC", 0.52)
local TabBinds = createTab("BINDS", 0.77)

-- Área de conteúdo (scroll SOMENTE nas opções)
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -120)
Content.Position = UDim2.new(0, 10, 0, 105)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.ScrollBarImageColor3 = COLORS.primary
Content.Parent = MainFrame
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ScrollingEnabled = true
Content.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

-- Sistema de binds
local binds = {}
local bindButtons = {}

-- Função para criar toggle com bind
local function createToggle(name, posIdx, tab, startActive, hasBind)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 50)
    Container.Position = UDim2.new(0, 5, 0, 5 + (posIdx * 55))
    Container.BackgroundColor3 = COLORS.surface
    Container.BackgroundTransparency = 0.2
    Container.Visible = (tab == "MAIN")
    Container.Parent = Content
    Container.ClipsDescendants = true

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container

    local ContainerStroke = Instance.new("UIStroke")
    ContainerStroke.Thickness = 1
    ContainerStroke.Color = COLORS.primary
    ContainerStroke.Transparency = 0.9
    ContainerStroke.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, -10, 1, 0)
    Label.Position = UDim2.new(0, 15, 0, 0)
    Label.Text = name
    Label.TextColor3 = COLORS.text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    local SwitchBG = Instance.new("Frame")
    SwitchBG.Size = UDim2.new(0, 44, 0, 22)
    SwitchBG.Position = UDim2.new(1, -100, 0.5, -11)
    SwitchBG.BackgroundColor3 = startActive and COLORS.success or COLORS.secondary
    SwitchBG.Parent = Container

    local SwitchCorner = Instance.new("UICorner")
    SwitchCorner.CornerRadius = UDim.new(1, 0)
    SwitchCorner.Parent = SwitchBG

    local SwitchButton = Instance.new("TextButton")
    SwitchButton.Size = UDim2.new(1, 0, 1, 0)
    SwitchButton.BackgroundTransparency = 1
    SwitchButton.Text = ""
    SwitchButton.Parent = SwitchBG

    local SwitchCircle = Instance.new("Frame")
    SwitchCircle.Size = UDim2.new(0, 18, 0, 18)
    SwitchCircle.Position = startActive and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    SwitchCircle.BackgroundColor3 = COLORS.text
    SwitchCircle.Parent = SwitchBG

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = SwitchCircle

    local active = startActive
    local bindKey = nil
    local bindLabel = nil

    if hasBind then
        bindLabel = Instance.new("TextLabel")
        bindLabel.Size = UDim2.new(0, 40, 0, 20)
        bindLabel.Position = UDim2.new(1, -45, 0.5, -10)
        bindLabel.BackgroundColor3 = COLORS.primary
        bindLabel.BackgroundTransparency = 0.7
        bindLabel.Text = "NONE"
        bindLabel.TextColor3 = COLORS.text
        bindLabel.Font = Enum.Font.GothamBold
        bindLabel.TextSize = 11
        bindLabel.Parent = Container

        local BindCorner = Instance.new("UICorner")
        BindCorner.CornerRadius = UDim.new(0, 4)
        BindCorner.Parent = bindLabel

        local BindButton = Instance.new("TextButton")
        BindButton.Size = UDim2.new(1, 0, 1, 0)
        BindButton.BackgroundTransparency = 1
        BindButton.Text = ""
        BindButton.Parent = bindLabel

        table.insert(bindButtons, {button = BindButton, label = bindLabel, name = name})

        BindButton.MouseButton2Click:Connect(function()
            bindLabel.Text = "..."
            local binding = true
            local connection
            
            connection = UserInputService.InputBegan:Connect(function(input, gp)
                if binding and not gp then
                    if input.KeyCode ~= Enum.KeyCode.Unknown then
                        bindKey = input.KeyCode
                        bindLabel.Text = tostring(bindKey):gsub("Enum.KeyCode.", "")
                        binds[name] = {key = bindKey, toggle = function() return active end}
                        binding = false
                        connection:Disconnect()
                    end
                end
            end)
            
            task.wait(5)
            if binding then
                bindLabel.Text = "NONE"
                binding = false
                if connection then connection:Disconnect() end
            end
        end)
    end

    SwitchButton.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
            BackgroundColor3 = active and COLORS.success or COLORS.secondary
        }):Play()
        TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
            Position = active and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        }):Play()
        if callback then callback(active) end
    end)

    table.insert(options[tab], Container)
    return function() return active end
end

-- Função para criar slider
local function createSlider(name, posIdx, tab, min, max, default)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 65)
    Container.Position = UDim2.new(0, 5, 0, 5 + (posIdx * 70))
    Container.BackgroundColor3 = COLORS.surface
    Container.BackgroundTransparency = 0.2
    Container.Visible = false
    Container.Parent = Content

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 10)
    ContainerCorner.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 25)
    Label.Position = UDim2.new(0, 15, 0, 10)
    Label.Text = name
    Label.TextColor3 = COLORS.text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.8, -20, 0, 4)
    SliderBg.Position = UDim2.new(0.1, 0, 0, 45)
    SliderBg.BackgroundColor3 = COLORS.secondary
    SliderBg.Parent = Container

    local SliderBgCorner = Instance.new("UICorner")
    SliderBgCorner.CornerRadius = UDim.new(1, 0)
    SliderBgCorner.Parent = SliderBg

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new((default - min) / (max - min), 0, 1, 0)
    SliderFill.BackgroundColor3 = COLORS.primary
    SliderFill.Parent = SliderBg

    local SliderFillCorner = Instance.new("UICorner")
    SliderFillCorner.CornerRadius = UDim.new(1, 0)
    SliderFillCorner.Parent = SliderFill

    local SliderButton = Instance.new("TextButton")
    SliderButton.Size = UDim2.new(0, 18, 0, 18)
    SliderButton.Position = UDim2.new(SliderFill.Size.X.Scale, -9, 0.5, -9)
    SliderButton.BackgroundColor3 = COLORS.primary
    SliderButton.Text = ""
    SliderButton.Parent = Container

    local SliderButtonCorner = Instance.new("UICorner")
    SliderButtonCorner.CornerRadius = UDim.new(1, 0)
    SliderButtonCorner.Parent = SliderButton

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 40, 0, 20)
    ValueLabel.Position = UDim2.new(0.9, -20, 0, 40)
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = COLORS.primary
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 14
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Parent = Container

    local value = default
    local dragging = false

    local function updateSlider(input)
        local posX = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(posX, 0, 1, 0)
        SliderButton.Position = UDim2.new(posX, -9, 0.5, -9)
        value = math.floor(min + (posX * (max - min)))
        ValueLabel.Text = tostring(value)
    end

    SliderButton.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
        end
    end)

    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            updateSlider(input)
        end
    end)

    UserInputService.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = false
        end
    end)

    table.insert(options[tab], Container)
    return function() return value end
end

-- Criar opções
local options = {MAIN = {}, FARM = {}, MISC = {}, BINDS = {}}

-- MAIN
local isGodRagdoll = createToggle("Anti Ragdoll", 0, "MAIN", true, true)
local isInstantCollect = createToggle("Instant Collect", 1, "MAIN", true, true)
local isLowMode = createToggle("Low Mode", 2, "MAIN", false, true)
local isAutoBuyBrainrot = createToggle("Auto Buy Brainrot", 3, "MAIN", false, true)

-- FARM
local farmToggles = {}
for i, name in ipairs({"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Stellar"}) do
    farmToggles[name] = createToggle(name, i-1, "FARM", false, true)
end

-- MISC (Speed + ESP)
local getSpeed = createSlider("WalkSpeed", 0, "MISC", 16, 100, 16)
local isPlayerESP = createToggle("Player ESP", 1, "MISC", false, true)
local isInvisible = createToggle("Invisible", 2, "MISC", false, true)

-- BINDS (apenas informações dos binds)
local bindInfo = Instance.new("TextLabel")
bindInfo.Size = UDim2.new(1, -20, 0, 100)
bindInfo.Position = UDim2.new(0, 10, 0, 10)
bindInfo.BackgroundTransparency = 1
bindInfo.Text = "Clique com DIREITO nos toggles\npara definir uma tecla de atalho!"
bindInfo.TextColor3 = COLORS.textSoft
bindInfo.Font = Enum.Font.Gotham
bindInfo.TextSize = 14
bindInfo.TextWrapped = true
bindInfo.Parent = Content
table.insert(options.BINDS, bindInfo)

-- Função para trocar abas com animação
local function showTab(tabName)
    for tab, items in pairs(options) do
        for _, item in ipairs(items) do
            item.Visible = (tab == tabName)
        end
    end
end

TabMain.MouseButton1Click:Connect(function() showTab("MAIN") end)
TabFarm.MouseButton1Click:Connect(function() showTab("FARM") end)
TabMisc.MouseButton1Click:Connect(function() showTab("MISC") end)
TabBinds.MouseButton1Click:Connect(function() showTab("BINDS") end)

showTab("MAIN")

-- Sistema de binds (ativação por tecla)
UserInputService.InputBegan:Connect(function(input, gp)
    if gp then return end
    
    for name, bind in pairs(binds) do
        if input.KeyCode == bind.key then
            local toggleFunc = bind.toggle
            if toggleFunc then
                -- Simula clique no toggle
                -- (você precisa adaptar isso para cada toggle específico)
            end
        end
    end
end)

-- Dragging do botão
local dragging, dragStart, startPos
FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = FloatingButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        FloatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function() dragging = false end)

-- Animações de entrada/saída
local function toggleMenu()
    if MainFrame.Visible then
        TweenService:Create(MainFrame, TweenInfo.new(ANIM_TIME, ANIM_STYLE), {
            Size = UDim2.new(0, 550, 0, 0)
        }):Play()
        task.wait(ANIM_TIME)
        MainFrame.Visible = false
    else
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 550, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(ANIM_TIME, ANIM_STYLE, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 550, 0, 450)
        }):Play()
    end
end

FloatingButton.MouseButton1Click:Connect(toggleMenu)
CloseBtn.MouseButton1Click:Connect(function() 
    TweenService:Create(MainFrame, TweenInfo.new(ANIM_TIME, ANIM_STYLE), {
        Size = UDim2.new(0, 550, 0, 0)
    }):Play()
    task.wait(ANIM_TIME)
    MainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.L then
        toggleMenu()
    end
end)

-- Animação pulsante do botão
local pulse = TweenService:Create(Glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
    ImageTransparency = 0.3
})
pulse:Play()

-- === FUNÇÕES DO JOGO ===

-- Anti Ragdoll
RunService.Heartbeat:Connect(function()
    if isGodRagdoll() then
        local char = Player.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local root = char.HumanoidRootPart
            if root:FindFirstChild("RagdollWeld") then root.RagdollWeld:Destroy() end
            for _, v in pairs(char:GetDescendants()) do
                if v:IsA("Motor6D") then v.Enabled = true end
                if v:IsA("BallSocketConstraint") or v:IsA("NoCollisionConstraint") then v:Destroy() end
            end
        end
    end
end)

-- Instant Collect
task.spawn(function()
    while task.wait(1) do
        if isInstantCollect() then
            pcall(function()
                for _, obj in pairs(workspace:GetDescendants()) do
                    if obj:IsA("ProximityPrompt") then
                        obj.HoldDuration = 0
                    end
                end
            end)
        end
    end
end)

-- Low Mode
local originalMaterials = {}
task.spawn(function()
    while task.wait(0.5) do
        if isLowMode() then
            pcall(function()
                for _, v in pairs(workspace:GetDescendants()) do
                    if v:IsA("BasePart") and (v.Name == "Part" or v.Name == "Floor") then
                        originalMaterials[v] = v.Material
                        v.Material = Enum.Material.Air
                    end
                end
            end)
        else
            for part, mat in pairs(originalMaterials) do
                pcall(function() if part and part.Parent then part.Material = mat end end)
            end
            originalMaterials = {}
        end
    end
end)

-- Auto Buy Brainrot
task.spawn(function()
    local blackListNames = {["SellPrompt"] = true, ["GrabPrompt"] = true, ["PlacePrompt"] = true, ["AddPrompt"] = true}
    while task.wait(0.1) do
        if isAutoBuyBrainrot() then
            pcall(function()
                local char = Player.Character
                if char and char:FindFirstChild("HumanoidRootPart") then
                    local root = char.HumanoidRootPart
                    for _, prompt in pairs(workspace:GetDescendants()) do
                        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                            if not blackListNames[prompt.Name] then
                                local part = prompt.Parent
                                local model = part and part:FindFirstAncestorOfClass("Model")
                                local isMerchant = model and (model.Name == "IngredientsMerchant" or model.Name == "RobuxMerchant")
                                if part and part:IsA("BasePart") and not isMerchant then
                                    local distance = (root.Position - part.Position).Magnitude
                                    if distance <= prompt.MaxActivationDistance then 
                                        fireproximityprompt(prompt) 
                                    end
                                end
                            end
                        end
                    end
                end
            end)
        end
    end
end)

-- Speed
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = getSpeed()
        end
    end
end)

-- Player ESP
task.spawn(function()
    while task.wait(1) do
        if isPlayerESP() then
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player then
                    local char = p.Character
                    if char then
                        local highlight = char:FindFirstChild("SnowyESP")
                        if not highlight then
                            highlight = Instance.new("Highlight")
                            highlight.Name = "SnowyESP"
                            highlight.FillColor = COLORS.accent
                            highlight.OutlineColor = COLORS.primary
                            highlight.FillTransparency = 0.5
                            highlight.Parent = char
                        end
                    end
                end
            end
        else
            for _, p in pairs(game.Players:GetPlayers()) do
                if p ~= Player then
                    local char = p.Character
                    if char then
                        local highlight = char:FindFirstChild("SnowyESP")
                        if highlight then highlight:Destroy() end
                    end
                end
            end
        end
    end
end)

-- Invisible
local function setInvisible(state)
    local char = Player.Character
    if not char then return end
    local alpha = state and 0.8 or 0
    for _, v in pairs(char:GetDescendants()) do
        if v:IsA("BasePart") or v:IsA("MeshPart") then
            v.Transparency = alpha
        end
    end
end

task.spawn(function()
    while task.wait(0.3) do
        setInvisible(isInvisible())
    end
end)

print("✅ Snowy Hub V3 - Edição Futurista")
print("📌 Pressione L para abrir/fechar")
print("🎮 Clique DIREITO nos toggles para definir teclas de atalho")
