local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local VirtualInputManager = game:GetService("VirtualInputManager")
local StarterGui = game:GetService("StarterGui")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SnowyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui
ScreenGui.IgnoreGuiInset = true

-- Cores
local COLORS = {
    background = Color3.fromRGB(18, 18, 30),
    surface = Color3.fromRGB(25, 25, 40),
    primary = Color3.fromRGB(0, 200, 255),
    secondary = Color3.fromRGB(140, 80, 255),
    accent = Color3.fromRGB(255, 80, 140),
    text = Color3.fromRGB(255, 255, 255),
    textSoft = Color3.fromRGB(180, 180, 200),
    success = Color3.fromRGB(0, 255, 150),
    danger = Color3.fromRGB(255, 60, 60)
}

-- Botão flutuante
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 60, 0, 60)
FloatingButton.Position = UDim2.new(0, 50, 0.5, -30)
FloatingButton.BackgroundColor3 = COLORS.primary
FloatingButton.Text = ""
FloatingButton.Parent = ScreenGui
FloatingButton.AutoButtonColor = false

local ButtonCorner = Instance.new("UICorner")
ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = FloatingButton

local BtnLabel = Instance.new("TextLabel")
BtnLabel.Size = UDim2.new(1, 0, 1, 0)
BtnLabel.BackgroundTransparency = 1
BtnLabel.Text = "S"
BtnLabel.TextColor3 = COLORS.text
BtnLabel.TextSize = 32
BtnLabel.Font = Enum.Font.GothamBold
BtnLabel.Parent = FloatingButton

-- Menu principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 500)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -250)
MainFrame.BackgroundColor3 = COLORS.background
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = true

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Top Bar
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 50)
TopBar.BackgroundColor3 = COLORS.surface
TopBar.Parent = MainFrame

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "SNOWY HUB V3"
Title.TextColor3 = COLORS.primary
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 35, 0, 35)
CloseBtn.Position = UDim2.new(1, -45, 0.5, -17.5)
CloseBtn.BackgroundColor3 = COLORS.danger
CloseBtn.Text = "✕"
CloseBtn.TextColor3 = COLORS.text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Abas
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 45)
TabFrame.Position = UDim2.new(0, 0, 0, 50)
TabFrame.BackgroundColor3 = COLORS.surface
TabFrame.Parent = MainFrame

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
    return Btn
end

local TabMain = createTab("MAIN", 0.02)
local TabFarm = createTab("FARM", 0.27)
local TabBuy = createTab("BUY", 0.52)
local TabSpeed = createTab("SPEED", 0.77)

-- Área de conteúdo
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

-- Variáveis globais
local options = {MAIN = {}, FARM = {}, BUY = {}, SPEED = {}}
local tpToolTool = nil
local espHighlights = {}
local brainrotAlerts = {}

-- Função de notificação
local function notify(title, text, duration)
    duration = duration or 3
    StarterGui:SetCore("SendNotification", {
        Title = title,
        Text = text,
        Duration = duration
    })
end

-- Função para criar toggle
local function createToggle(name, posIdx, tab, startActive, hasAlert)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 50)
    Container.Position = UDim2.new(0, 5, 0, 5 + (posIdx * 55))
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = (tab == "MAIN")
    Container.Parent = Content

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 8)
    ContainerCorner.Parent = Container

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
    SwitchBG.Position = UDim2.new(1, -54, 0.5, -11)
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
    local alertKey = hasAlert and name or nil
    if alertKey then
        brainrotAlerts[alertKey] = false
    end

    SwitchButton.MouseButton1Click:Connect(function()
        active = not active
        TweenService:Create(SwitchBG, TweenInfo.new(0.2), {
            BackgroundColor3 = active and COLORS.success or COLORS.secondary
        }):Play()
        TweenService:Create(SwitchCircle, TweenInfo.new(0.2), {
            Position = active and UDim2.new(1, -20, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
        }):Play()
        
        if alertKey then
            brainrotAlerts[alertKey] = active
        end
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
    Container.Visible = false
    Container.Parent = Content

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 8)
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

-- Função do TP Tool
local function toggleTPTool(active)
    if active then
        if player.Backpack:FindFirstChild("TeleportTool") or (player.Character and player.Character:FindFirstChild("TeleportTool")) then 
            return 
        end
        
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
                end
            end
        end)
        
        tpToolTool = tool
        notify("TP Tool", "Ferramenta de teleporte ativada!", 2)
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

-- Função do ESP
local function toggleESP(active)
    if active then
        for _, p in pairs(game.Players:GetPlayers()) do
            if p ~= player and p.Character and not espHighlights[p] then
                local highlight = Instance.new("Highlight")
                highlight.Parent = p.Character
                highlight.FillColor = COLORS.accent
                highlight.OutlineColor = COLORS.primary
                highlight.FillTransparency = 0.5
                espHighlights[p] = highlight
            end
        end
        notify("ESP", "Player ESP ativado!", 2)
    else
        for p, highlight in pairs(espHighlights) do
            if highlight and highlight.Parent then
                highlight:Destroy()
            end
        end
        espHighlights = {}
    end
end

-- Criar opções
-- MAIN
local isGodRagdoll = createToggle("Anti Ragdoll", 0, "MAIN", true)
local isInstantCollect = createToggle("Instant Collect", 1, "MAIN", true)
local isLowMode = createToggle("Low Mode", 2, "MAIN", false)
local isAutoBuyBrainrot = createToggle("Auto Buy Brainrot", 3, "MAIN", false)
local isTPTool = createToggle("Teleport Tool", 4, "MAIN", false)
local isPlayerESP = createToggle("Player ESP", 5, "MAIN", false)

-- FARM (com alertas)
local farmToggles = {}
local farmNames = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Stellar"}
for i, name in ipairs(farmNames) do
    farmToggles[name] = createToggle(name, i-1, "FARM", false, true)
end

-- BUY
local buyIce = createToggle("Ice Emblem", 0, "BUY", false)
local buyVic = createToggle("Victrola", 1, "BUY", false)
local buyStar = createToggle("Star", 2, "BUY", false)
local buyFlow = createToggle("Flower", 3, "BUY", false)
local buyPhon = createToggle("Phone", 4, "BUY", false)

-- SPEED
local getSpeed = createSlider("WalkSpeed", 0, "SPEED", 16, 100, 16)

-- Conectar toggles às funções
local tpToggle = isTPTool
local espToggle = isPlayerESP

-- Função para trocar abas
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
TabSpeed.MouseButton1Click:Connect(function() showTab("SPEED") end)

showTab("MAIN")

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

-- Controles do menu
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

-- Monitorar mudanças nos toggles
task.spawn(function()
    while task.wait(0.5) do
        -- TP Tool
        if tpToggle() then
            toggleTPTool(true)
        else
            toggleTPTool(false)
        end
        
        -- ESP
        if espToggle() then
            toggleESP(true)
        else
            toggleESP(false)
        end
    end
end)

-- === FUNÇÕES DO JOGO (mantidas do seu script original) ===

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

-- Auto Farm
local brainrotsFolder = workspace:WaitForChild("Client", 10):WaitForChild("Path", 5):WaitForChild("Brainrots", 5)
local targetHead = nil
local isHidden = false
local notifiedBrainrots = {}

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
    local char = Player.Character
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

-- Função para comprar pet
local function autoBuyPet()
    local char = Player.Character
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

-- Sistema de notificação de brainrots
local function checkForAlertBrainrots()
    for _, model in pairs(brainrotsFolder:GetChildren()) do
        if model:IsA("Model") then
            local ui = model:FindFirstChild("Brainrot_UI")
            local frame = ui and ui:FindFirstChild("Frame")
            local rarityLbl = frame and frame:FindFirstChild("Rarity")
            local titleLbl = frame and frame:FindFirstChild("Title")
            
            if rarityLbl then
                local rarityText = string.lower(rarityLbl.Text)
                for alertName, isActive in pairs(brainrotAlerts) do
                    if isActive and not notifiedBrainrots[model] then
                        if rarityText:find(string.lower(alertName)) then
                            notify("Brainrot Encontrado!", "Um brainrot " .. alertName .. " apareceu!", 5)
                            notifiedBrainrots[model] = true
                            
                            -- Remove after 30 seconds
                            task.spawn(function()
                                task.wait(30)
                                notifiedBrainrots[model] = nil
                            end)
                        end
                    end
                end
            end
        end
    end
end

RunService.Heartbeat:Connect(function()
    -- Check for alerts
    checkForAlertBrainrots()
    
    -- Farm logic
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

    local char = Player.Character
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
                        break
                    end
                end
                if targetHead then break end
            end
        end
    end
end)

-- Auto Buy Ingredients
local buyList = {
    {get = buyIce, name = "IceEmblem"},
    {get = buyVic, name = "Victrola"},
    {get = buyStar, name = "Star"},
    {get = buyFlow, name = "Flower"},
    {get = buyPhon, name = "Phone"}
}

task.spawn(function()
    local Bridge = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("Bridge")
    while task.wait(1) do
        for _, item in ipairs(buyList) do
            if item.get() then
                pcall(function()
                    Bridge:FireServer("General", "Buy", item.name)
                end)
            end
        end
    end
end)

print("✅ Snowy Hub V3 - Edição Completa")
print("📌 Pressione L para abrir/fechar")
print("📌 MAIN: Anti Ragdoll, Instant, Low, Auto Buy, TP Tool, ESP")
print("📌 FARM: 8 raridades + NOTIFICAÇÕES")
