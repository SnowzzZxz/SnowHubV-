local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local StarterGui = game:GetService("StarterGui")
local Players = game:GetService("Players")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SnowyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true
ScreenGui.DisplayOrder = 100

-- Cores Modernas
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
    warning = Color3.fromRGB(255, 200, 0)
}

-- Variáveis Globais
local options = {MAIN = {}, FARM = {}, BUY = {}, NOTIFY = {}}
local espHighlights = {}
local tpToolTool = nil
local brainrotAlerts = {}
local originalMaterials = {}
local targetHead = nil
local isHidden = false
local flyConnection = nil
local isFlying = false
local autoCollectThread = nil
local isAutoCollectActive = false
local notificationQueue = {}
local isNotifying = false

-- Sistema de Notificação Animado
local NotificationHolder = Instance.new("Frame")
NotificationHolder.Name = "NotificationHolder"
NotificationHolder.Size = UDim2.new(0, 350, 0, 200)
NotificationHolder.Position = UDim2.new(1, -370, 0, 20)
NotificationHolder.BackgroundTransparency = 1
NotificationHolder.Parent = ScreenGui

local function showNotification(title, text, duration, rarity)
    duration = duration or 5
    
    local notif = Instance.new("Frame")
    notif.Size = UDim2.new(1, 0, 0, 70)
    notif.Position = UDim2.new(0, 0, 1, 10)
    notif.BackgroundColor3 = COLORS.surface
    notif.Parent = NotificationHolder
    notif.ClipsDescendants = true
    
    local notifCorner = Instance.new("UICorner")
    notifCorner.CornerRadius = UDim.new(0, 8)
    notifCorner.Parent = notif
    
    local notifStroke = Instance.new("UIStroke")
    notifStroke.Thickness = 2
    notifStroke.Color = rarity and COLORS.accent or COLORS.primary
    notifStroke.Parent = notif
    
    local icon = Instance.new("TextLabel")
    icon.Size = UDim2.new(0, 30, 0, 30)
    icon.Position = UDim2.new(0, 10, 0.5, -15)
    icon.BackgroundTransparency = 1
    icon.Text = "📢"
    icon.TextColor3 = COLORS.text
    icon.TextSize = 20
    icon.Parent = notif
    
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Size = UDim2.new(1, -50, 0, 25)
    titleLabel.Position = UDim2.new(0, 50, 0, 10)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = COLORS.primary
    titleLabel.Font = Enum.Font.GothamBold
    titleLabel.TextSize = 16
    titleLabel.TextXAlignment = Enum.TextXAlignment.Left
    titleLabel.Parent = notif
    
    local textLabel = Instance.new("TextLabel")
    textLabel.Size = UDim2.new(1, -50, 0, 25)
    textLabel.Position = UDim2.new(0, 50, 0, 35)
    textLabel.BackgroundTransparency = 1
    textLabel.Text = text
    textLabel.TextColor3 = COLORS.textSoft
    textLabel.Font = Enum.Font.Gotham
    textLabel.TextSize = 14
    textLabel.TextXAlignment = Enum.TextXAlignment.Left
    textLabel.Parent = notif
    
    local progress = Instance.new("Frame")
    progress.Size = UDim2.new(1, 0, 0, 3)
    progress.Position = UDim2.new(0, 0, 1, -3)
    progress.BackgroundColor3 = COLORS.primary
    progress.Parent = notif
    
    -- Animação de entrada
    notif.Position = UDim2.new(0, 0, 1, 10)
    TweenService:Create(notif, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
        Position = UDim2.new(0, 0, 0, 0)
    }):Play()
    
    -- Animação da barra de progresso
    TweenService:Create(progress, TweenInfo.new(duration, Enum.EasingStyle.Linear), {
        Size = UDim2.new(0, 0, 0, 3)
    }):Play()
    
    -- Remove após duração
    task.wait(duration)
    
    -- Animação de saída
    TweenService:Create(notif, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Position = UDim2.new(0, 0, 1, 10)
    }):Play()
    
    task.wait(0.3)
    notif:Destroy()
end

-- Botão flutuante com animação
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 65, 0, 65)
FloatingButton.Position = UDim2.new(0, 50, 0.5, -32.5)
FloatingButton.BackgroundColor3 = COLORS.primary
FloatingButton.Text = ""
FloatingButton.Parent = ScreenGui
FloatingButton.AutoButtonColor = false
FloatingButton.ZIndex = 10

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = FloatingButton

local ButtonGlow = Instance.new("ImageLabel")
ButtonGlow.Size = UDim2.new(1.3, 0, 1.3, 0)
ButtonGlow.Position = UDim2.new(-0.15, 0, -0.15, 0)
ButtonGlow.BackgroundTransparency = 1
ButtonGlow.Image = "rbxassetid://3570695787"
ButtonGlow.ImageColor3 = COLORS.primary
ButtonGlow.ImageTransparency = 0.6
ButtonGlow.Parent = FloatingButton

local BtnLabel = Instance.new("TextLabel")
BtnLabel.Size = UDim2.new(1, 0, 1, 0)
BtnLabel.BackgroundTransparency = 1
BtnLabel.Text = "S"
BtnLabel.TextColor3 = COLORS.text
BtnLabel.TextSize = 32
BtnLabel.Font = Enum.Font.GothamBold
BtnLabel.Parent = FloatingButton

-- Animação pulsante do botão
local pulseAnim = TweenService:Create(ButtonGlow, TweenInfo.new(2, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut, -1), {
    ImageTransparency = 0.3
})
pulseAnim:Play()

-- Menu principal com animação
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 600, 0, 550)
MainFrame.Position = UDim2.new(0.5, -300, 0.5, -275)
MainFrame.BackgroundColor3 = COLORS.background
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
MainFrame.Parent = ScreenGui
MainFrame.Active = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 16)
MainCorner.Parent = MainFrame

local MainStroke = Instance.new("UIStroke")
MainStroke.Thickness = 2
MainStroke.Color = COLORS.primary
MainStroke.Transparency = 0.5
MainStroke.Parent = MainFrame

-- Top Bar
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

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -80, 1, 0)
Title.Position = UDim2.new(0, 20, 0, 0)
Title.Text = "SNOWY HUB V3"
Title.TextColor3 = COLORS.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 24
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

-- Botão fechar (agora um círculo)
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 40, 0, 40)
CloseBtn.Position = UDim2.new(1, -50, 0.5, -20)
CloseBtn.BackgroundColor3 = COLORS.danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = COLORS.text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 20
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Abas
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, -20, 0, 50)
TabFrame.Position = UDim2.new(0, 10, 0, 70)
TabFrame.BackgroundColor3 = COLORS.surface
TabFrame.BackgroundTransparency = 0.5
TabFrame.Parent = MainFrame

local TabFrameCorner = Instance.new("UICorner")
TabFrameCorner.CornerRadius = UDim.new(0, 12)
TabFrameCorner.Parent = TabFrame

local function createTab(name, pos)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.25, -5, 0.7, 0)
    Btn.Position = UDim2.new(pos, 2, 0.15, 0)
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
    
    -- Hover effect
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
local TabBuy = createTab("BUY", 0.52)
local TabNotify = createTab("NOTIFY", 0.77)

-- Área de conteúdo
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -30, 1, -150)
Content.Position = UDim2.new(0, 15, 0, 130)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0, 0, 0, 0)
Content.ScrollBarImageColor3 = COLORS.primary
Content.Parent = MainFrame
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ScrollingEnabled = true

-- Função para criar toggle com design melhorado
local function createToggle(name, desc, posIdx, tab, startActive)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 70)
    Container.Position = UDim2.new(0, 5, 0, 5 + (posIdx * 75))
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = (tab == "MAIN")
    Container.Parent = Content

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 12)
    ContainerCorner.Parent = Container

    local ContainerStroke = Instance.new("UIStroke")
    ContainerStroke.Thickness = 1.5
    ContainerStroke.Color = COLORS.primary
    ContainerStroke.Transparency = 0.7
    ContainerStroke.Parent = Container

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -80, 0, 30)
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.Text = name
    Title.TextColor3 = COLORS.text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    if desc then
        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1, -80, 0, 20)
        Desc.Position = UDim2.new(0, 15, 0, 40)
        Desc.Text = desc
        Desc.TextColor3 = COLORS.textSoft
        Desc.Font = Enum.Font.Gotham
        Desc.TextSize = 12
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.BackgroundTransparency = 1
        Desc.Parent = Container
    end

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
    SwitchCircle.Position = startActive and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)
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
            Position = active and UDim2.new(1, -24, 0.5, -11) or UDim2.new(0, 3, 0.5, -11)
        }):Play()
    end)

    table.insert(options[tab], Container)
    return function() return active end
end

-- Função para criar slider com design melhorado
local function createSlider(name, desc, posIdx, tab, min, max, default)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 85)
    Container.Position = UDim2.new(0, 5, 0, 5 + (posIdx * 90))
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = false
    Container.Parent = Content

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 12)
    ContainerCorner.Parent = Container

    local ContainerStroke = Instance.new("UIStroke")
    ContainerStroke.Thickness = 1.5
    ContainerStroke.Color = COLORS.primary
    ContainerStroke.Transparency = 0.7
    ContainerStroke.Parent = Container

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -20, 0, 25)
    Title.Position = UDim2.new(0, 15, 0, 10)
    Title.Text = name
    Title.TextColor3 = COLORS.text
    Title.Font = Enum.Font.GothamBold
    Title.TextSize = 16
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.BackgroundTransparency = 1
    Title.Parent = Container

    if desc then
        local Desc = Instance.new("TextLabel")
        Desc.Size = UDim2.new(1, -20, 0, 20)
        Desc.Position = UDim2.new(0, 15, 0, 35)
        Desc.Text = desc
        Desc.TextColor3 = COLORS.textSoft
        Desc.Font = Enum.Font.Gotham
        Desc.TextSize = 12
        Desc.TextXAlignment = Enum.TextXAlignment.Left
        Desc.BackgroundTransparency = 1
        Desc.Parent = Container
    end

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.85, -20, 0, 6)
    SliderBg.Position = UDim2.new(0.1, 0, 0, 60)
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
    SliderButton.Size = UDim2.new(0, 22, 0, 22)
    SliderButton.Position = UDim2.new(SliderFill.Size.X.Scale, -11, 0.5, -11)
    SliderButton.BackgroundColor3 = COLORS.primary
    SliderButton.Text = ""
    SliderButton.Parent = Container

    local SliderButtonCorner = Instance.new("UICorner")
    SliderButtonCorner.CornerRadius = UDim.new(1, 0)
    SliderButtonCorner.Parent = SliderButton

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 50, 0, 25)
    ValueLabel.Position = UDim2.new(0.9, -25, 0, 30)
    ValueLabel.Text = tostring(default)
    ValueLabel.TextColor3 = COLORS.primary
    ValueLabel.Font = Enum.Font.GothamBold
    ValueLabel.TextSize = 16
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Parent = Container

    local value = default
    local dragging = false

    local function updateSlider(input)
        local posX = math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1)
        SliderFill.Size = UDim2.new(posX, 0, 1, 0)
        SliderButton.Position = UDim2.new(posX, -11, 0.5, -11)
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
-- MAIN
local isGodRagdoll = createToggle("Anti Ragdoll", "Imune a quedas e immobilização", 0, "MAIN", true)
local isInstantCollect = createToggle("Instant Collect", "Pega itens sem segurar E", 1, "MAIN", true)
local isLowMode = createToggle("Low Mode", "Remove texturas para mais FPS", 2, "MAIN", false)
local isAutoBuyBrainrot = createToggle("Auto Buy Brainrot", "Compra automaticamente", 3, "MAIN", false)
local isTPTool = createToggle("Teleport Tool", "Ferramenta de teleporte", 4, "MAIN", false)
local isPlayerESP = createToggle("Player ESP", "Destaque outros jogadores", 5, "MAIN", false)
local isAutoCollect = createToggle("Auto Collect", "Coleta automática da base", 6, "MAIN", false)

-- FARM
local farmToggles = {}
local farmNames = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Stellar"}
for i, name in ipairs(farmNames) do
    farmToggles[name] = createToggle(name, "Farm brainrots " .. name, i-1, "FARM", false)
end

-- BUY (CORRIGIDO)
local buyIce = createToggle("Ice Emblem", "Compra Ice Emblem", 0, "BUY", false)
local buyVic = createToggle("Victrola", "Compra Victrola", 1, "BUY", false)
local buyStar = createToggle("Star", "Compra Star", 2, "BUY", false)
local buyFlow = createToggle("Flower", "Compra Flower", 3, "BUY", false)
local buyPhon = createToggle("Phone", "Compra Phone", 4, "BUY", false)

-- NOTIFY (espaço para notificações)
local notifyLabel = Instance.new("TextLabel")
notifyLabel.Size = UDim2.new(1, -20, 0, 100)
notifyLabel.Position = UDim2.new(0, 10, 0, 10)
notifyLabel.BackgroundTransparency = 1
notifyLabel.Text = "Notificações aparecerão aqui"
notifyLabel.TextColor3 = COLORS.textSoft
notifyLabel.Font = Enum.Font.Gotham
notifyLabel.TextSize = 16
notifyLabel.Parent = Content
notifyLabel.Visible = false
table.insert(options.NOTIFY, notifyLabel)

-- SPEED (agora na MAIN)
local getSpeed = createSlider("WalkSpeed", "Ajuste sua velocidade", 7, "MAIN", 16, 100, 16)

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
TabBuy.MouseButton1Click:Connect(function() showTab("BUY") end)
TabNotify.MouseButton1Click:Connect(function() showTab("NOTIFY") end)

showTab("MAIN")

-- Animações de entrada/saída do menu
local function toggleMenu()
    if MainFrame.Visible then
        TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
            Size = UDim2.new(0, 600, 0, 0)
        }):Play()
        task.wait(0.3)
        MainFrame.Visible = false
    else
        MainFrame.Visible = true
        MainFrame.Size = UDim2.new(0, 600, 0, 0)
        TweenService:Create(MainFrame, TweenInfo.new(0.5, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
            Size = UDim2.new(0, 600, 0, 550)
        }):Play()
    end
end

FloatingButton.MouseButton1Click:Connect(toggleMenu)
CloseBtn.MouseButton1Click:Connect(function()
    TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.In), {
        Size = UDim2.new(0, 600, 0, 0)
    }):Play()
    task.wait(0.3)
    MainFrame.Visible = false
end)

UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.L then
        toggleMenu()
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

-- === FUNÇÕES ===

-- TP Tool (CORRIGIDO)
local function toggleTPTool(active)
    if active then
        if not player.Backpack:FindFirstChild("TeleportTool") and not (player.Character and player.Character:FindFirstChild("TeleportTool")) then
            local tool = Instance.new("Tool")
            tool.Name = "TeleportTool"
            tool.RequiresHandle = false
            tool.Parent = player.Backpack
            tool.TextureId = "rbxassetid://4483345998"
            
            local desc = Instance.new("StringValue")
            desc.Name = "ToolTip"
            desc.Value = "Clique para teleportar"
            desc.Parent = tool
            
            tool.Activated:Connect(function()
                local mouse = player:GetMouse()
                if mouse and mouse.Hit and player.Character then
                    local hrp = player.Character:FindFirstChild("HumanoidRootPart")
                    if hrp then
                        hrp.CFrame = mouse.Hit + Vector3.new(0, 3, 0)
                        showNotification("TP Tool", "Teleportado com sucesso!", 2)
                    end
                end
            end)
            
            tpToolTool = tool
            showNotification("TP Tool", "Ferramenta ativada!", 2)
        end
    else
        if tpToolTool and tpToolTool.Parent then
            tpToolTool:Destroy()
        end
        local backpackTool = player.Backpack:FindFirstChild("TeleportTool")
        if backpackTool then backpackTool:Destroy() end
        local charTool = player.Character and player.Character:FindFirstChild("TeleportTool")
        if charTool then charTool:Destroy() end
        tpToolTool = nil
    end
end

-- Player ESP (CORRIGIDO)
local function toggleESP(active)
    if active then
        for _, p in pairs(Players:GetPlayers()) do
            if p ~= player and p.Character and not espHighlights[p] then
                local highlight = Instance.new("Highlight")
                highlight.Parent = p.Character
                highlight.FillColor = COLORS.accent
                highlight.OutlineColor = COLORS.primary
                highlight.FillTransparency = 0.5
                espHighlights[p] = highlight
            end
        end
        showNotification("ESP", "Player ESP ativado!", 2)
    else
        for p, highlight in pairs(espHighlights) do
            if highlight and highlight.Parent then
                highlight:Destroy()
            end
        end
        espHighlights = {}
    end
end

-- Auto Collect (CORRIGIDO)
local function getPlayerBase()
    local basesFolder = workspace:FindFirstChild("Server") and workspace.Server:FindFirstChild("Bases")
    if not basesFolder then return nil end
    
    for _, base in ipairs(basesFolder:GetChildren()) do
        local owner = base:FindFirstChild("OwnerId")
        if owner and owner.Value then
            local ownerVal = tonumber(owner.Value) or owner.Value
            if tonumber(ownerVal) == player.UserId then
                return base
            end
        end
    end
    return nil
end

local function startAutoCollect()
    if autoCollectThread then return end
    
    autoCollectThread = task.spawn(function()
        while isAutoCollectActive do
            local char = player.Character
            local hrp = char and char:FindFirstChild("HumanoidRootPart")
            
            if hrp then
                local base = getPlayerBase()
                if base then
                    local slots = base:FindFirstChild("Slots")
                    if slots then
                        local children = slots:GetChildren()
                        table.sort(children, function(a, b) return a.Name < b.Name end)
                        
                        for _, slot in ipairs(children) do
                            if not isAutoCollectActive then break end
                            
                            local collect = slot:FindFirstChild("Collect")
                            if collect then
                                if collect:IsA("Model") then
                                    local handle = collect:FindFirstChild("Handle")
                                    if handle and handle:IsA("BasePart") then
                                        pcall(function()
                                            hrp.CFrame = handle.CFrame + Vector3.new(0, 2, 0)
                                        end)
                                        task.wait(0.15)
                                    end
                                elseif collect:IsA("BasePart") then
                                    pcall(function()
                                        hrp.CFrame = collect.CFrame + Vector3.new(0, 2, 0)
                                    end)
                                    task.wait(0.15)
                                end
                            end
                        end
                    end
                end
            end
            task.wait(0.3)
        end
        autoCollectThread = nil
    end)
end

-- Auto Buy Ingredients (CORRIGIDO)
local buyList = {
    {toggle = buyIce, name = "IceEmblem"},
    {toggle = buyVic, name = "Victrola"},
    {toggle = buyStar, name = "Star"},
    {toggle = buyFlow, name = "Flower"},
    {toggle = buyPhon, name = "Phone"}
}

task.spawn(function()
    local Bridge = ReplicatedStorage:FindFirstChild("Remotes") and ReplicatedStorage.Remotes:FindFirstChild("Bridge")
    if Bridge then
        while task.wait(1) do
            for _, item in ipairs(buyList) do
                if item.toggle() then
                    pcall(function()
                        Bridge:FireServer("General", "Buy", item.name)
                    end)
                end
            end
        end
    end
end)

-- Anti Ragdoll
RunService.Heartbeat:Connect(function()
    if isGodRagdoll() then
        local char = player.Character
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
                local char = player.Character
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
    local char = player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = getSpeed()
        end
    end
end)

-- Auto Farm
local brainrotsFolder = workspace:FindFirstChild("Client") and workspace.Client:FindFirstChild("Path") and workspace.Client.Path:FindFirstChild("Brainrots")
if brainrotsFolder then
    local rarityNames = {
        common = {"common"},
        uncommon = {"uncommon"},
        rare = {"rare"},
        epic = {"epic"},
        legendary = {"legendary"},
        mythic = {"mythic", "Gorillo Watermelondrillo", "Frigo Camelo", "Girafa Celestre", "Ganganzelli Trulala", "Tigroligre Frutonni"},
        secret = {"secret", "La Vacca Saturno Saturnita", "Esok Sekolah", "Tralaledon", "Garama and Madundung"},
        stellar = {"stellar", "Meowl", "Capitano Clash Warnini", "Strawberry Elephant"}
    }

    local function setVisibility(visible)
        local char = player.Character
        if not char then return end
        local transparency = visible and 0 or 1
        for _, v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") or v:IsA("Decal") then
                if v.Name ~= "HumanoidRootPart" then v.Transparency = transparency end
            elseif v:IsA("BillboardGui") or v:IsA("SurfaceGui") then
                v.Enabled = visible
            end
        end
        isHidden = not visible
    end

    local function autoBuyPet()
        local char = player.Character
        if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
        for _, prompt in pairs(workspace:GetDescendants()) do
            if prompt:IsA("ProximityPrompt") and prompt.Enabled then
                local part = prompt.Parent
                if part and part:IsA("BasePart") then
                    local distance = (char.HumanoidRootPart.Position - part.Position).Magnitude
                    if distance <= prompt.MaxActivationDistance then
                        fireproximityprompt(prompt)
                        return true
                    end
                end
            end
        end
        return false
    end

    task.spawn(function()
        while task.wait(0.1) do
            if targetHead then
                pcall(autoBuyPet)
            end
        end
    end)

    RunService.Heartbeat:Connect(function()
        local activeRarities = {}
        for _, name in ipairs(farmNames) do
            if farmToggles[name]() then
                table.insert(activeRarities, string.lower(name))
            end
        end

        if #activeRarities == 0 then 
            targetHead = nil 
            if isHidden then setVisibility(true) end
            return 
        end

        local char = player.Character
        local root = char and char:FindFirstChild("HumanoidRootPart")
        if not root then return end

        if targetHead and targetHead.Parent and targetHead.Parent.Parent == brainrotsFolder then
            root.CFrame = targetHead.CFrame * CFrame.new(0, 0, -3)
            if not isHidden then setVisibility(false) end
            pcall(autoBuyPet)
            return
        end

        targetHead = nil
        if isHidden then setVisibility(true) end

        for _, model in pairs(brainrotsFolder:GetChildren()) do
            if model:IsA("Model") then
                local ui = model:FindFirstChild("Brainrot_UI")
                local frame = ui and ui:FindFirstChild("Frame")
                local rarityLbl = frame and frame:FindFirstChild("Rarity")
                local titleLbl = frame and frame:FindFirstChild("Title")
                local head = model:FindFirstChild("Head")

                if head and frame then
                    local rarityText = rarityLbl and string.lower(rarityLbl.Text) or ""
                    local titleText = titleLbl and titleLbl.Text or ""
                    
                    for _, rarity in ipairs(activeRarities) do
                        local isTarget = false
                        local names = rarityNames[rarity]
                        for _, name in ipairs(names) do
                            if rarityText:find(name) or titleText == name then
                                isTarget = true
                                break
                            end
                        end
                        if isTarget then
                            targetHead = head
                            root.CFrame = head.CFrame * CFrame.new(0, 0, -3)
                            showNotification("Brainrot Encontrado!", "Um brainrot " .. rarity .. " apareceu!", 5, rarity)
                            break
                        end
                    end
                    if targetHead then break end
                end
            end
        end
    end)
end

-- Monitoramento dos toggles
task.spawn(function()
    while task.wait(0.5) do
        -- TP Tool
        toggleTPTool(isTPTool())
        
        -- ESP
        toggleESP(isPlayerESP())
        
        -- Auto Collect
        if isAutoCollect() and not isAutoCollectActive then
            isAutoCollectActive = true
            startAutoCollect()
            showNotification("Auto Collect", "Coleta automática ativada!", 2)
        elseif not isAutoCollect() and isAutoCollectActive then
            isAutoCollectActive = false
            showNotification("Auto Collect", "Coleta automática desativada!", 2)
        end
    end
end)

-- Update ESP for new players
Players.PlayerAdded:Connect(function(p)
    if isPlayerESP() then
        p.CharacterAdded:Connect(function(char)
            task.wait(1)
            if isPlayerESP() and not espHighlights[p] then
                local highlight = Instance.new("Highlight")
                highlight.Parent = char
                highlight.FillColor = COLORS.accent
                highlight.OutlineColor = COLORS.primary
                highlight.FillTransparency = 0.5
                espHighlights[p] = highlight
            end
        end)
    end
end)

print("✅ Snowy Hub V3 - Edição Premium")
print("📌 Pressione L para abrir/fechar")
print("📌 Notificações animadas no canto")
print("📌 TP Tool e ESP corrigidos")
print("📌 Design moderno com animações")
