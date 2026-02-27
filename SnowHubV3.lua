local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

-- Configurações de animação (otimizadas)
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
ScreenGui.IgnoreGuiInset = true -- Melhor para performance

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

-- Botão flutuante com efeito de brilho
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

-- Ícone do botão
local BtnIcon = Instance.new("ImageLabel")
BtnIcon.Size = UDim2.new(0.6, 0, 0.6, 0)
BtnIcon.Position = UDim2.new(0.2, 0, 0.2, 0)
BtnIcon.BackgroundTransparency = 1
BtnIcon.Image = "rbxassetid://4483345998" -- Ícone de floco de neve
BtnIcon.ImageColor3 = COLORS.text
BtnIcon.Parent = FloatingButton

-- Efeito de brilho no botão
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

-- Título com ícone
local TitleIcon = Instance.new("ImageLabel")
TitleIcon.Size = UDim2.new(0, 30, 0, 30)
TitleIcon.Position = UDim2.new(0, 15, 0.5, -15)
TitleIcon.BackgroundTransparency = 1
TitleIcon.Image = "rbxassetid://4483345998"
TitleIcon.Parent = TopBar

local ScriptTitle = Instance.new("TextLabel")
ScriptTitle.Size = UDim2.new(0, 200, 1, 0)
ScriptTitle.Position = UDim2.new(0, 55, 0, 0)
ScriptTitle.Text = "Snowy Hub V3"
ScriptTitle.TextColor3 = COLORS.text
ScriptTitle.Font = Enum.Font.GothamBold
ScriptTitle.TextSize = 24
ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
ScriptTitle.BackgroundTransparency = 1
ScriptTitle.Parent = TopBar

local VersionLabel = Instance.new("TextLabel")
VersionLabel.Size = UDim2.new(0, 50, 1, 0)
VersionLabel.Position = UDim2.new(1, -100, 0, 0)
VersionLabel.Text = "1.0.0"
VersionLabel.TextColor3 = COLORS.textSoft
VersionLabel.Font = Enum.Font.Gotham
ScriptTitle.TextSize = 14
VersionLabel.TextXAlignment = Enum.TextXAlignment.Right
VersionLabel.BackgroundTransparency = 1
VersionLabel.Parent = TopBar

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundColor3 = COLORS.secondary
CloseBtn.Text = ""
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

local CloseIcon = Instance.new("ImageLabel")
CloseIcon.Size = UDim2.new(0.5, 0, 0.5, 0)
CloseIcon.Position = UDim2.new(0.25, 0, 0.25, 0)
CloseIcon.BackgroundTransparency = 1
CloseIcon.Image = "rbxassetid://6031094678" -- Ícone X
CloseIcon.ImageColor3 = COLORS.text
CloseIcon.Parent = CloseBtn

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

-- Função para criar botões de aba (com animação)
local function createTabBtn(name, posIdx, iconId)
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

    local Icon = Instance.new("ImageLabel")
    Icon.Size = UDim2.new(0, 24, 0, 24)
    Icon.Position = UDim2.new(0, 15, 0.5, -12)
    Icon.BackgroundTransparency = 1
    Icon.Image = iconId or "rbxassetid://4483362458"
    Icon.ImageColor3 = COLORS.text
    Icon.Parent = Btn

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -50, 1, 0)
    Label.Position = UDim2.new(0, 50, 0, 0)
    Label.Text = name
    Label.TextColor3 = COLORS.text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Btn

    -- Efeito hover
    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.4
        }):Play()
    end)

    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
            BackgroundTransparency = 0.8
        }):Play()
    end)

    return Btn
end

-- Criar abas com ícones
local TabMain = createTabBtn("Principal", 0, "rbxassetid://6034509869") -- Ícone home
local TabFarm = createTabBtn("Farm", 1, "rbxassetid://6034530444") -- Ícone farm
local TabBuy = createTabBtn("Compras", 2, "rbxassetid://6034507510") -- Ícone shop
local TabSpeed = createTabBtn("Velocidade", 3, "rbxassetid://6034532992") -- Ícone speed

-- Função para criar opções toggle (com design moderno)
local function createOption(name, desc, posIdx, tab, startActive, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.95, 0, 0, 70)
    Container.Position = UDim2.new(0.025, 0, 0, posIdx * 80)
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = (tab == "Main")
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

-- Função pra criar slider (com design moderno)
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
local options = {Main = {}, Farm = {}, Buy = {}, Speed = {}}

-- Opções da Main
local isGodRagdoll = createOption("Anti Ragdoll", "Imune a quedas e imobilização", 0, "Main", true)
local isInstantCollect = createOption("Instant Collect", "Pega itens sem segurar E", 1, "Main", true)
local isLowMode = createOption("Low Mode", "Remove texturas para mais FPS", 2, "Main", false)
local isAutoBuyBrainrot = createOption("Auto Buy Brainrots", "Compra automaticamente para não perder", 3, "Main", false)

-- Opções do Farm
local isAutoCommon = createOption("Auto Common", "Farm brainrots Common", 0, "Farm", false)
local isAutoUncommon = createOption("Auto Uncommon", "Farm brainrots Uncommon", 1, "Farm", false)
local isAutoRare = createOption("Auto Rare", "Farm brainrots Rare", 2, "Farm", false)
local isAutoEpic = createOption("Auto Epic", "Farm brainrots Epic", 3, "Farm", false)
local isAutoLegendary = createOption("Auto Legendary", "Farm brainrots Legendary", 4, "Farm", false)
local isAutoMythic = createOption("Auto Mythic", "Farm brainrots Mythic", 5, "Farm", false)
local isAutoSecret = createOption("Auto Secret", "Farm brainrots Secret", 6, "Farm", false)
local isAutoStellar = createOption("Auto Stellar", "Farm brainrots Stellar", 7, "Farm", false)

-- Opções de Compra
local buyIce = createOption("Auto Ice Emblem", "Compra Ice Emblem automaticamente", 0, "Buy", false)
local buyVic = createOption("Auto Victrola", "Compra Victrola automaticamente", 1, "Buy", false)
local buyStar = createOption("Auto Star", "Compra Star automaticamente", 2, "Buy", false)
local buyFlow = createOption("Auto Flower", "Compra Flower automaticamente", 3, "Buy", false)
local buyPhon = createOption("Auto Phone", "Compra Phone automaticamente", 4, "Buy", false)

-- Slider de velocidade
local getSpeed = createSlider("Velocidade do Player", "Ajuste sua velocidade (16-100)", 0, "Speed", 16, 100, 16)

-- Materiais para Low Mode
local originalMaterials = {}

-- Função pra trocar abas com animação
local function showTab(tabName)
    for tab, containers in pairs(options) do
        local visible = (tab == tabName)
        for _, container in ipairs(containers) do
            if visible then
                container.Visible = true
                container.Size = UDim2.new(0.95, 0, 0, 70)
                container.BackgroundTransparency = 0
            else
                container.Visible = false
            end
        end
    end
end

-- Conectar abas
TabMain.MouseButton1Click:Connect(function() showTab("Main") end)
TabFarm.MouseButton1Click:Connect(function() showTab("Farm") end)
TabBuy.MouseButton1Click:Connect(function() showTab("Buy") end)
TabSpeed.MouseButton1Click:Connect(function() showTab("Speed") end)

-- Dragging do botão flutuante
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

-- Animações de abrir/fechar
local function toggleMenu()
    if MainFrame.Visible then
        -- Fechar
        TweenService:Create(MainFrame, TweenInfo.new(0.2), {
            Size = UDim2.new(0, 600, 0, 0)
        }):Play()
        task.wait(0.2)
        MainFrame.Visible = false
    else
        -- Abrir
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 600, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 550)
        }):Play()
    end
end

-- Botão flutuante
FloatingButton.MouseButton1Click:Connect(toggleMenu)
CloseBtn.MouseButton1Click:Connect(toggleMenu)

-- Tecla L
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

-- === FUNÇÕES DO SCRIPT (mantidas iguais) ===
-- [Cole aqui todas as funções do script anterior:
-- Anti Ragdoll, Instant Collect, Low Mode, Auto Buy Brainrot, 
-- Velocidade, Auto Farm com compra automática, Auto Buy Ingredientes]

print("✅ Snowy Hub V3 - Design Premium carregado!")
print("📌 Pressione L para abrir/fechar")
print("🎨 Design moderno com animações otimizadas")
