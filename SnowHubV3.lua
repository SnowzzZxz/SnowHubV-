local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SnowyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true

-- Cores
local COLORS = {
    background = Color3.fromRGB(20, 20, 30),
    surface = Color3.fromRGB(30, 30, 40),
    primary = Color3.fromRGB(100, 150, 255),
    secondary = Color3.fromRGB(80, 80, 100),
    text = Color3.fromRGB(255, 255, 255),
    success = Color3.fromRGB(100, 200, 100)
}

-- Botão flutuante
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 50, 0.5, -30)
FloatingButton.BackgroundColor3 = COLORS.primary
FloatingButton.Text = ""
FloatingButton.Parent = ScreenGui
FloatingButton.AutoButtonColor = false

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

local BtnLabel = Instance.new("TextLabel")
BtnLabel.Size = UDim2.new(1, 0, 1, 0)
BtnLabel.BackgroundTransparency = 1
BtnLabel.Text = "S"
BtnLabel.TextColor3 = COLORS.text
BtnLabel.TextSize = 32
BtnLabel.Font = Enum.Font.GothamBold
BtnLabel.Parent = FloatingButton

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

local TopGradient = Instance.new("UIGradient")
TopGradient.Color = ColorSequence.new({
    ColorSequenceKeypoint.new(0, COLORS.primary),
    ColorSequenceKeypoint.new(1, COLORS.surface)
})
TopGradient.Rotation = 90
TopGradient.Parent = TopBar

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
ScriptTitle.Size = UDim2.new(0, 150, 1, 0)
ScriptTitle.Position = UDim2.new(0, 55, 0, 0)
ScriptTitle.Text = "Snowy Hub"
ScriptTitle.TextColor3 = COLORS.text
ScriptTitle.Font = Enum.Font.GothamBold
ScriptTitle.TextSize = 22
ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
ScriptTitle.BackgroundTransparency = 1
ScriptTitle.Parent = TopBar

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
    Btn.Text = name
    Btn.TextColor3 = COLORS.text
    Btn.Font = Enum.Font.Gotham
    Btn.TextSize = 16
    Btn.Parent = SideBar
    Btn.AutoButtonColor = false

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 12)
    BtnCorner.Parent = Btn

    Btn.MouseEnter:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.4}):Play()
    end)

    Btn.MouseLeave:Connect(function()
        TweenService:Create(Btn, TweenInfo.new(0.2), {BackgroundTransparency = 0.8}):Play()
    end)

    return Btn
end

local TabMain = createTabBtn("MAIN", 0)
local TabFarm = createTabBtn("FARM", 1)
local TabBuy = createTabBtn("BUY", 2)
local TabSpeed = createTabBtn("SPEED", 3)

local options = {MAIN = {}, FARM = {}, BUY = {}, SPEED = {}}

-- Função para criar opções
local function createOption(name, posIdx, startActive, tab, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.95, 0, 0, 60)
    Container.Position = UDim2.new(0.025, 0, 0, posIdx * 70)
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = (tab == "MAIN")
    Container.Parent = MainContent

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 12)
    ContainerCorner.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Text = name
    Label.TextColor3 = COLORS.text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    local SwitchBG = Instance.new("Frame")
    SwitchBG.Size = UDim2.new(0, 50, 0, 26)
    SwitchBG.Position = UDim2.new(1, -65, 0.5, -13)
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
        TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
            BackgroundColor3 = active and COLORS.success or COLORS.secondary
        }):Play()
        TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
            Position = active and UDim2.new(1, -26, 0.5, -11) or UDim2.new(0, 4, 0.5, -11)
        }):Play()
        if callback then callback(active) end
    end)

    table.insert(options[tab], Container)
    return function() return active end
end

-- Slider
local function createSlider(name, posIdx, tab, min, max, default)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.95, 0, 0, 80)
    Container.Position = UDim2.new(0.025, 0, 0, posIdx * 90)
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = false
    Container.Parent = MainContent

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 12)
    ContainerCorner.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Position = UDim2.new(0, 15, 0, 10)
    Label.Text = name
    Label.TextColor3 = COLORS.text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 16
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.8, -20, 0, 4)
    SliderBg.Position = UDim2.new(0.1, 0, 0, 55)
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
    ValueLabel.Position = UDim2.new(0.9, -20, 0, 50)
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

-- Opções
local isGodRagdoll = createOption("Anti Ragdoll", 0, true, "MAIN")
local isInstantCollect = createOption("Instant Collect", 1, true, "MAIN")
local isLowMode = createOption("Low Mode", 2, false, "MAIN")
local isAutoBuyBrainrot = createOption("Auto Buy Brainrot", 3, false, "MAIN")

local isAutoCommon = createOption("Common", 0, false, "FARM")
local isAutoUncommon = createOption("Uncommon", 1, false, "FARM")
local isAutoRare = createOption("Rare", 2, false, "FARM")
local isAutoEpic = createOption("Epic", 3, false, "FARM")
local isAutoLegendary = createOption("Legendary", 4, false, "FARM")
local isAutoMythic = createOption("Mythic", 5, false, "FARM")
local isAutoSecret = createOption("Secret", 6, false, "FARM")
local isAutoStellar = createOption("Stellar", 7, false, "FARM")

local buyIce = createOption("Ice Emblem", 0, false, "BUY")
local buyVic = createOption("Victrola", 1, false, "BUY")
local buyStar = createOption("Star", 2, false, "BUY")
local buyFlow = createOption("Flower", 3, false, "BUY")
local buyPhon = createOption("Phone", 4, false, "BUY")

local getSpeed = createSlider("WalkSpeed", 0, "SPEED", 16, 100, 16)

-- Função pra trocar abas
local function showTab(tabName)
    for tab, containers in pairs(options) do
        for _, container in ipairs(containers) do
            container.Visible = (tab == tabName)
        end
    end
end

TabMain.MouseButton1Click:Connect(function() showTab("MAIN") end)
TabFarm.MouseButton1Click:Connect(function() showTab("FARM") end)
TabBuy.MouseButton1Click:Connect(function() showTab("BUY") end)
TabSpeed.MouseButton1Click:Connect(function() showTab("SPEED") end)

-- Dragging
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

-- Controles
local function toggleMenu()
    MainFrame.Visible = not MainFrame.Visible
end

FloatingButton.MouseButton1Click:Connect(toggleMenu)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.L then
        toggleMenu()
    end
end)

-- Animação do botão
local pulseTween = TweenService:Create(Glow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
    ImageTransparency = 0.5
})
pulseTween:Play()

-- Funções do jogo (mantidas iguais)
-- [Cole aqui todas as funções: Anti Ragdoll, Instant Collect, Low Mode, etc]
