local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Configurações de animação
local ANIM_CONFIG = {
    fadeTime = 0.2,
    slideTime = 0.25,
    easingStyle = Enum.EasingStyle.Quad,
    easingDir = Enum.EasingDirection.Out
}

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SnowyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true

-- Cores modernas
local COLORS = {
    background = Color3.fromRGB(20, 20, 30),
    surface = Color3.fromRGB(30, 30, 40),
    primary = Color3.fromRGB(100, 150, 255),
    secondary = Color3.fromRGB(80, 80, 100),
    text = Color3.fromRGB(255, 255, 255),
    textSoft = Color3.fromRGB(200, 200, 200),
    success = Color3.fromRGB(100, 200, 100),
    danger = Color3.fromRGB(255, 100, 100)
}

-- Botão flutuante com letra S elegante
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 50, 0.5, -30)
FloatingButton.BackgroundColor3 = COLORS.primary
FloatingButton.Text = ""
FloatingButton.Parent = ScreenGui
FloatingButton.AutoButtonColor = false

-- Sombra
local Shadow = Instance.new("ImageLabel")
Shadow.Size = UDim2.new(1, 10, 1, 10)
Shadow.Position = UDim2.new(0, -5, 0, -5)
Shadow.BackgroundTransparency = 1
Shadow.Image = "rbxassetid://1316045217"
Shadow.ImageColor3 = Color3.new(0, 0, 0)
Shadow.ImageTransparency = 0.5
Shadow.ScaleType = Enum.ScaleType.Slice
Shadow.SliceCenter = Rect.new(10, 10, 10, 10)
Shadow.Parent = FloatingButton

-- Letra S elegante (em vez de ícone)
local BtnLabel = Instance.new("TextLabel")
BtnLabel.Size = UDim2.new(1, 0, 1, 0)
BtnLabel.BackgroundTransparency = 1
BtnLabel.Text = "S"
BtnLabel.TextColor3 = COLORS.text
BtnLabel.TextSize = 32
BtnLabel.Font = Enum.Font.GothamBold
BtnLabel.Parent = FloatingButton

-- Efeito de brilho
local Glow = Instance.new("ImageLabel")
Glow.Size = UDim2.new(1.2, 0, 1.2, 0)
Glow.Position = UDim2.new(-0.1, 0, -0.1, 0)
Glow.BackgroundTransparency = 1
Glow.Image = "rbxassetid://3570695787"
Glow.ImageColor3 = COLORS.primary
Glow.ImageTransparency = 0.7
Glow.Parent = FloatingButton

-- Menu principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 550)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -275)
MainFrame.BackgroundColor3 = COLORS.background
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui

-- Sombra do menu
local MainShadow = Instance.new("ImageLabel")
MainShadow.Size = UDim2.new(1, 20, 1, 20)
MainShadow.Position = UDim2.new(0, -10, 0, -10)
MainShadow.BackgroundTransparency = 1
MainShadow.Image = "rbxassetid://1316045217"
MainShadow.ImageColor3 = Color3.new(0, 0, 0)
MainShadow.ImageTransparency = 0.6
MainShadow.ScaleType = Enum.ScaleType.Slice
MainShadow.SliceCenter = Rect.new(10, 10, 10, 10)
MainShadow.Parent = MainFrame

-- Cantos arredondados
local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

-- Top bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 60)
TopBar.BackgroundColor3 = COLORS.surface
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 16)
TopBarCorner.Parent = TopBar

-- Gradiente no top bar
local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, COLORS.primary),
    ColorSequenceKeypoint.new(1, COLORS.surface)
})
TopGradient.Rotation = 90
TopGradient.Parent = TopBar

-- Letra S no título
local TitleIcon = Instance.new("TextLabel")
TitleIcon.Size = UDim2.new(0, 30, 0, 30)
TitleIcon.Position = UDim2.new(0, 15, 0.5, -15)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Text = "S"
TitleIcon.TextColor3 = COLORS.text
TitleIcon.Font = Enum.Font.GothamBold
TitleIcon.TextSize = 24
TitleIcon.Parent = TopBar

local ScriptTitle = Instance.new("TextLabel")
ScriptTitle.Size = UDim2.new(0, 200, 1, 0)
ScriptTitle.Position = UDim2.new(0, 55, 0, 0)
ScriptTitle.Text = "nowy Hub V3"
ScriptTitle.TextColor3 = COLORS.text
ScriptTitle.Font = Enum.Font.GothamBold
ScriptTitle.TextSize = 24
ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
ScriptTitle.BackgroundTransparency = 1
ScriptTitle.Parent = TopBar

-- Versão
local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 50, 1, 0)
VersionLabel.Position = UDim2.new(1, -100, 0, 0)
VersionLabel.Text = "v3.0"
VersionLabel.TextColor3 = COLORS.textSoft
VersionLabel.Font = Enum.Font.Gotham
VersionLabel.TextSize = 14
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right
VersionLabel.BackgroundTransparency = 1
VersionLabel.Parent = TopBar

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundColor3 = COLORS.secondary
CloseBtn.Text = "X"
CloseBtn.TextColor3 = COLORS.text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 18
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Sidebar
local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 160, 1, -60)
SideBar.Position = UDim2.new(0, 0, 0, 60)
SideBar.BackgroundColor3 = COLORS.surface
SideBar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 16)
SidebarCorner.Parent = SideBar

-- Linha divisória
local Divider = Instance.new("Frame")
Divider.Size = UDim2.new(0.9, 0, 0, 1)
Divider.Position = UDim2.new(0.05, 0, 0.2, 0)
Divider.BackgroundColor3 = COLORS.secondary
Divider.BorderSize = 0
Divider.Parent = SideBar

-- Main content
local MainContent = Instance.new("ScrollingFrame")
MainContent.Size = UDim2.new(1, -170, 1, -70)
MainContent.Position = UDim2.new(0, 165, 0, 65)
MainContent.BackgroundTransparency = 1
MainContent.ScrollBarThickness = 4
MainContent.CanvasSize = UDim2.new(0, 0, 0, 900)
MainContent.ScrollBarImageColor3 = COLORS.primary
MainContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
MainContent.Parent = MainFrame

-- Função para criar botões de aba
local function createTabBtn(name, posIdx)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.9, 0, 0, 50)
    Btn.Position = UDim2.new(0.05, 0, 0, 80 + (posIdx * 60))
    Btn.BackgroundColor3 = COLORS.primary
    Btn.BackgroundTransparency = 0.8
    Btn.Text = ""
    Btn.Parent = SideBar
    Btn.AutoButtonColor = false
    Btn.ClipsDescendants = true

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 12)
    BtnCorner.Parent = Btn

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, 0, 1, 0)
    Label.Text = name
    Label.TextColor3 = COLORS.text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.BackgroundTransparency = 1
    Label.Parent = Btn

    -- Efeito hover
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.4
        }):Play()
    end)

    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {
            BackgroundTransparency = 0.8
        }):Play()
    end)

    return Btn
end

-- Criar abas
local TabMain = createTabBtn("PRINCIPAL", 0)
local TabFarm = createTabBtn("FARM", 1)
local TabBuy = createTabBtn("COMPRAS", 2)
local TabSpeed = createTabBtn("VELOCIDADE", 3)

-- Função para criar opções toggle
local function createOption(name, desc, posIdx, tab, startActive, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.95, 0, 0, 70)
    Container.Position = UDim2.new(0.025, 0, 0, posIdx * 80)
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = (tab == "PRINCIPAL")
    Container.Parent = MainContent
    Container.ClipsDescendants = true

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 12)
    ContainerCorner.Parent = Container

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.Text = name
    Title.TextColor3 = COLORS.text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -20, 0, 20)
    Description.Position = UDim2.new(0, 15, 0, 35)
    Description.Text = desc or ""
    Description.TextColor3 = COLORS.textSoft
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 12
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.BackgroundTransparency = 1
    Description.Parent = Container

    -- Toggle switch
    local SwitchBG = Instance.new("Frame")
    SwitchBG.Size = UDim2.new(0, 50, 0, 26)
    SwitchBG.Position = UDim2.new(1, -70, 0.5, -13)
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
    SwitchCircle.Size = UDim2.new(0, 22, 0, 22)
    SwitchCircle.Position = startActive and UDim2.new(1, -26, 0.5, -11) or UDim2.new(0, 4, 0.5, -11)
    SwitchCircle.BackgroundColor3 = COLORS.text
    SwitchCircle.Parent = SwitchBG

    local CircleCorner = Instance.new("UICorner")
    CircleCorner.CornerRadius = UDim.new(1, 0)
    CircleCorner.Parent = SwitchCircle

    local active = startActive

    SwitchButton.MouseButton1Click:Connect(function()
        active = not active
        
        -- Animações
        local bgColor = active and COLORS.success or COLORS.secondary
        local circlePos = active and UDim2.new(1, -26, 0.5, -11) or UDim2.new(0, 4, 0.5, -11)
        
        TweenService:Create(SwitchBG, TweenInfo.new(0.2), {BackgroundColor3 = bgColor}):Play()
        TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {Position = circlePos}):Play()
        
        if callback then callback(active) end
    end)

    table.insert(options[tab], Container)
    return function() return active end
end

-- Função pra criar slider
local function createSlider(name, desc, posIdx, tab, min, max, default)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.95, 0, 0, 90)
    Container.Position = UDim2.new(0.025, 0, 0, posIdx * 100)
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = false
    Container.Parent = MainContent
    Container.ClipsDescendants = true

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 12)
    ContainerCorner.Parent = Container

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 30)
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.Text = name
    Title.TextColor3 = COLORS.text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    local Description = Instance.new("TextLabel")
    Description.Size = UDim2.new(1, -20, 0, 20)
    Description.Position = UDim2.new(0, 15, 0, 35)
    Description.Text = desc
    Description.TextColor3 = COLORS.textSoft
    Description.Font = Enum.Font.Gotham
    Description.TextSize = 12
    Description.TextXAlignment = Enum.TextXAlignment.Left
    Description.BackgroundTransparency = 1
    Description.Parent = Container

    -- Slider
    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.8, -20, 0, 6)
    SliderBg.Position = UDim2.new(0.1, 0, 0, 65)
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
    SliderButton.Size = UDim2.new(0, 20, 0, 20)
    SliderButton.Position = UDim2.new(SliderFill.Size.X.Scale, -10, 0.5, -10)
    SliderButton.BackgroundColor3 = COLORS.primary
    SliderButton.Text = ""
    SliderButton.ZIndex = 2
    SliderButton.Parent = Container

    local SliderButtonCorner = Instance.new("UICorner")
    SliderButtonCorner.CornerRadius = UDim.new(1, 0)
    SliderButtonCorner.Parent = SliderButton

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 50, 0, 20)
    ValueLabel.Position = UDim2.new(0.9, -25, 0, 60)
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
        SliderButton.Position = UDim2.new(posX, -10, 0.5, -10)
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
local options = {PRINCIPAL = {}, FARM = {}, COMPRAS = {}, VELOCIDADE = {}}

-- Opções da Principal
local isGodRagdoll = createOption("Anti Ragdoll", "Imune a quedas e imobilização", 0, "PRINCIPAL", true)
local isInstantCollect = createOption("Instant Collect", "Pega itens sem segurar E", 1, "PRINCIPAL", true)
local isLowMode = createOption("Low Mode", "Remove texturas para mais FPS", 2, "PRINCIPAL", false)
local isAutoBuyBrainrot = createOption("Auto Buy Brainrots", "Compra automaticamente para não perder", 3, "PRINCIPAL", false)

-- Opções do Farm
local isAutoCommon = createOption("Auto Common", "Farm brainrots Common", 0, "FARM", false)
local isAutoUncommon = createOption("Auto Uncommon", "Farm brainrots Uncommon", 1, "FARM", false)
local isAutoRare = createOption("Auto Rare", "Farm brainrots Rare", 2, "FARM", false)
local isAutoEpic = createOption("Auto Epic", "Farm brainrots Epic", 3, "FARM", false)
local isAutoLegendary = createOption("Auto Legendary", "Farm brainrots Legendary", 4, "FARM", false)
local isAutoMythic = createOption("Auto Mythic", "Farm brainrots Mythic", 5, "FARM", false)
local isAutoSecret = createOption("Auto Secret", "Farm brainrots Secret", 6, "FARM", false)
local isAutoStellar = createOption("Auto Stellar", "Farm brainrots Stellar", 7, "FARM", false)

-- Opções de Compras
local buyIce = createOption("Auto Ice Emblem", "Compra Ice Emblem automaticamente", 0, "COMPRAS", false)
local buyVic = createOption("Auto Victrola", "Compra Victrola automaticamente", 1, "COMPRAS", false)
local buyStar = createOption("Auto Star", "Compra Star automaticamente", 2, "COMPRAS", false)
local buyFlow = createOption("Auto Flower", "Compra Flower automaticamente", 3, "COMPRAS", false)
local buyPhon = createOption("Auto Phone", "Compra Phone automaticamente", 4, "COMPRAS", false)

-- Slider de velocidade
local getSpeed = createSlider("Velocidade do Player", "Ajuste sua velocidade (16-100)", 0, "VELOCIDADE", 16, 100, 16)

-- Função pra trocar abas
local function showTab(tabName)
    for tab, containers in pairs(options) do
        local visible = (tab == tabName)
        for _, container in ipairs(containers) do
            container.Visible = visible
        end
    end
end

-- Conectar abas
TabMain.MouseButton1Click:Connect(function() showTab("PRINCIPAL") end)
TabFarm.MouseButton1Click:Connect(function() showTab("FARM") end)
TabBuy.MouseButton1Click:Connect(function() showTab("COMPRAS") end)
TabSpeed.MouseButton1Click:Connect(function() showTab("VELOCIDADE") end)

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
        FloatingButton.Position = UDim2.new(
            startPos.X.Scale, 
            startPos.X.Offset + delta.X, 
            startPos.Y.Scale, 
            startPos.Y.Offset + delta.Y
        )
    end
end)

UserInputService.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

-- Função para abrir/fechar (CORRIGIDA)
local function toggleMenu()
    MainFrame.Visible = not MainFrame.Visible
end

-- Botão flutuante
FloatingButton.MouseButton1Click:Connect(toggleMenu)

-- Botão fechar
CloseBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = false
end)

-- TECLA L (CORRIGIDA)
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
        toggleMenu()
    end
end)

-- Efeito de pulsar no botão
local pulseTween = TweenService:Create(Glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
    ImageTransparency = 0.5
})
pulseTween:Play()

print("✅ Snowy Hub V3 carregado!")
print("📌 Pressione L para abrir/fechar")
print("🎨 Design elegante com letra S")
