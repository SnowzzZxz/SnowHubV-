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
MainFrame.Size = UDim2.new(0, 500, 0, 400) -- Tamanho fixo
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = COLORS.background
MainFrame.Visible = false
MainFrame.Parent = ScreenGui
MainFrame.Active = true
MainFrame.Draggable = false

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 12)
MainCorner.Parent = MainFrame

-- Top bar (arrastável)
local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 40)
TopBar.BackgroundColor3 = COLORS.surface
TopBar.Parent = MainFrame
TopBar.Active = true

local TopBarCorner = Instance.new("UICorner")
TopBarCorner.CornerRadius = UDim.new(0, 12)
TopBarCorner.Parent = TopBar

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, -50, 1, 0)
Title.Position = UDim2.new(0, 15, 0, 0)
Title.Text = "Snowy Hub V3"
Title.TextColor3 = COLORS.text
Title.Font = Enum.Font.GothamBold
Title.TextSize = 20
Title.TextXAlignment = Enum.TextXAlignment.Left
Title.BackgroundTransparency = 1
Title.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -40, 0.5, -15)
CloseBtn.BackgroundColor3 = COLORS.secondary
CloseBtn.Text = "X"
CloseBtn.TextColor3 = COLORS.text
CloseBtn.Font = Enum.Font.GothamBold
CloseBtn.TextSize = 16
CloseBtn.Parent = TopBar

local CloseCorner = Instance.new("UICorner")
CloseCorner.CornerRadius = UDim.new(1, 0)
CloseCorner.Parent = CloseBtn

-- Abas
local TabFrame = Instance.new("Frame")
TabFrame.Size = UDim2.new(1, 0, 0, 40)
TabFrame.Position = UDim2.new(0, 0, 0, 40)
TabFrame.BackgroundColor3 = COLORS.surface
TabFrame.Parent = MainFrame

local TabMain = Instance.new("TextButton")
TabMain.Size = UDim2.new(0.25, -2, 0.8, 0)
TabMain.Position = UDim2.new(0.02, 0, 0.1, 0)
TabMain.BackgroundColor3 = COLORS.primary
TabMain.Text = "MAIN"
TabMain.TextColor3 = COLORS.text
TabMain.Font = Enum.Font.GothamBold
TabMain.TextSize = 14
TabMain.Parent = TabFrame

local TabFarm = Instance.new("TextButton")
TabFarm.Size = UDim2.new(0.25, -2, 0.8, 0)
TabFarm.Position = UDim2.new(0.27, 0, 0.1, 0)
TabFarm.BackgroundColor3 = COLORS.primary
TabFarm.Text = "FARM"
TabFarm.TextColor3 = COLORS.text
TabFarm.Font = Enum.Font.GothamBold
TabFarm.TextSize = 14
TabFarm.Parent = TabFrame

local TabMisc = Instance.new("TextButton")
TabMisc.Size = UDim2.new(0.25, -2, 0.8, 0)
TabMisc.Position = UDim2.new(0.52, 0, 0.1, 0)
TabMisc.BackgroundColor3 = COLORS.primary
TabMisc.Text = "MISC"
TabMisc.TextColor3 = COLORS.text
TabMisc.Font = Enum.Font.GothamBold
TabMisc.TextSize = 14
TabMisc.Parent = TabFrame

local TabSpeed = Instance.new("TextButton")
TabSpeed.Size = UDim2.new(0.25, -2, 0.8, 0)
TabSpeed.Position = UDim2.new(0.77, 0, 0.1, 0)
TabSpeed.BackgroundColor3 = COLORS.primary
TabSpeed.Text = "SPEED"
TabSpeed.TextColor3 = COLORS.text
TabSpeed.Font = Enum.Font.GothamBold
TabSpeed.TextSize = 14
TabSpeed.Parent = TabFrame

-- Área de conteúdo (ScrollFrame ajustado)
local Content = Instance.new("ScrollingFrame")
Content.Size = UDim2.new(1, -20, 1, -120)
Content.Position = UDim2.new(0, 10, 0, 90)
Content.BackgroundTransparency = 1
Content.ScrollBarThickness = 4
Content.CanvasSize = UDim2.new(0, 0, 2, 0) -- Tamanho fixo maior
Content.ScrollBarImageColor3 = COLORS.primary
Content.Parent = MainFrame
Content.AutomaticCanvasSize = Enum.AutomaticSize.Y
Content.ClipsDescendants = true
Content.ScrollingEnabled = true
Content.VerticalScrollBarPosition = Enum.VerticalScrollBarPosition.Right

-- Opções por aba
local options = {
    MAIN = {},
    FARM = {},
    MISC = {},
    SPEED = {}
}

-- Função para criar toggle
local function createToggle(name, posIdx, tab, startActive, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 45)
    Container.Position = UDim2.new(0, 5, 0, 5 + (posIdx * 50))
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = (tab == "MAIN")
    Container.Parent = Content
    Container.ClipsDescendants = true

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 8)
    ContainerCorner.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.7, -10, 1, 0)
    Label.Position = UDim2.new(0, 10, 0, 0)
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

-- Função para criar slider (CORRIGIDO - sem scroll extra)
local function createSlider(name, posIdx, tab, min, max, default)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(1, -10, 0, 60)
    Container.Position = UDim2.new(0, 5, 0, 5 + (posIdx * 65))
    Container.BackgroundColor3 = COLORS.surface
    Container.Visible = false
    Container.Parent = Content
    Container.ClipsDescendants = true

    local ContainerCorner = Instance.new("UICorner")
    ContainerCorner.CornerRadius = UDim.new(0, 8)
    ContainerCorner.Parent = Container

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 25)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.Text = name
    Label.TextColor3 = COLORS.text
    Label.Font = Enum.Font.Gotham
    Label.TextSize = 14
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.BackgroundTransparency = 1
    Label.Parent = Container

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.8, -10, 0, 4)
    SliderBg.Position = UDim2.new(0.1, 0, 0, 40)
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
    SliderButton.Size = UDim2.new(0, 16, 0, 16)
    SliderButton.Position = UDim2.new(SliderFill.Size.X.Scale, -8, 0.5, -8)
    SliderButton.BackgroundColor3 = COLORS.primary
    SliderButton.Text = ""
    SliderButton.Parent = Container

    local SliderButtonCorner = Instance.new("UICorner")
    SliderButtonCorner.CornerRadius = UDim.new(1, 0)
    SliderButtonCorner.Parent = SliderButton

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 40, 0, 20)
    ValueLabel.Position = UDim2.new(0.9, -20, 0, 35)
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
        SliderButton.Position = UDim2.new(posX, -8, 0.5, -8)
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
local isGodRagdoll = createToggle("Anti Ragdoll", 0, "MAIN", true)
local isInstantCollect = createToggle("Instant Collect", 1, "MAIN", true)
local isLowMode = createToggle("Low Mode", 2, "MAIN", false)
local isAutoBuyBrainrot = createToggle("Auto Buy Brainrot", 3, "MAIN", false)

-- FARM
local farmToggles = {}
for i, name in ipairs({"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Stellar"}) do
    farmToggles[name] = createToggle(name, i-1, "FARM", false)
end

-- MISC (Invisible e Fly)
local isInvisible = createToggle("Invisible", 0, "MISC", false)
local isFly = createToggle("Fly", 1, "MISC", false)

-- SPEED (apenas um slider)
local getSpeed = createSlider("WalkSpeed", 0, "SPEED", 16, 100, 16)

-- Função para trocar abas
local function showTab(tabName)
    for tab, items in pairs(options) do
        for _, item in ipairs(items) do
            item.Visible = (tab == tabName)
        end
    end
end

-- Conectar abas
TabMain.MouseButton1Click:Connect(function() showTab("MAIN") end)
TabFarm.MouseButton1Click:Connect(function() showTab("FARM") end)
TabMisc.MouseButton1Click:Connect(function() showTab("MISC") end)
TabSpeed.MouseButton1Click:Connect(function() showTab("SPEED") end)

-- Mostrar MAIN por padrão
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

-- === FUNÇÕES DO JOGO ===

-- 1. ANTI RAGDOLL
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

-- 2. INSTANT COLLECT
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

-- 3. LOW MODE
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

-- 4. AUTO BUY BRAINROTS
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

-- 5. VELOCIDADE
RunService.Heartbeat:Connect(function()
    local char = Player.Character
    if char then
        local humanoid = char:FindFirstChild("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = getSpeed()
        end
    end
end)

-- 6. INVISIBLE
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

isInvisibleCallback = isInvisible
task.spawn(function()
    while task.wait(0.3) do
        if isInvisible() then
            setInvisible(true)
        else
            setInvisible(false)
        end
    end
end)

-- 7. FLY
local flying = false
local bodyGyro, bodyVelocity

local function fly(state)
    local char = Player.Character
    if not char then return end
    local root = char:FindFirstChild("HumanoidRootPart")
    local humanoid = char:FindFirstChild("Humanoid")
    if not root or not humanoid then return end

    if state and not flying then
        flying = true
        humanoid.PlatformStand = true
        
        bodyGyro = Instance.new("BodyGyro")
        bodyGyro.P = 9e4
        bodyGyro.maxTorque = Vector3.new(9e4, 9e4, 9e4)
        bodyGyro.CFrame = root.CFrame
        bodyGyro.Parent = root

        bodyVelocity = Instance.new("BodyVelocity")
        bodyVelocity.Velocity = Vector3.new(0, 0, 0)
        bodyVelocity.MaxForce = Vector3.new(9e4, 9e4, 9e4)
        bodyVelocity.Parent = root

        RunService.Heartbeat:Connect(function()
            if not flying then return end
            local moveDir = Vector3.new()
            if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir = moveDir + workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir = moveDir - workspace.CurrentCamera.CFrame.LookVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir = moveDir - workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir = moveDir + workspace.CurrentCamera.CFrame.RightVector end
            if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir = moveDir + Vector3.new(0, 1, 0) end
            if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir = moveDir - Vector3.new(0, 1, 0) end
            
            bodyVelocity.Velocity = moveDir * (getSpeed() * 2)
            bodyGyro.CFrame = workspace.CurrentCamera.CFrame
        end)
    elseif not state and flying then
        flying = false
        humanoid.PlatformStand = false
        if bodyGyro then bodyGyro:Destroy() end
        if bodyVelocity then bodyVelocity:Destroy() end
    end
end

isFlyCallback = isFly
task.spawn(function()
    while task.wait(0.3) do
        fly(isFly())
    end
end)

-- 8. AUTO FARM (com compra automática)
local brainrotsFolder = workspace:WaitForChild("Client", 10):WaitForChild("Path", 5):WaitForChild("Brainrots", 5)
local targetHead = nil
local isHidden = false

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

RunService.Heartbeat:Connect(function()
    local activeRarities = {}
    if farmToggles["Common"]() then table.insert(activeRarities, "common") end
    if farmToggles["Uncommon"]() then table.insert(activeRarities, "uncommon") end
    if farmToggles["Rare"]() then table.insert(activeRarities, "rare") end
    if farmToggles["Epic"]() then table.insert(activeRarities, "epic") end
    if farmToggles["Legendary"]() then table.insert(activeRarities, "legendary") end
    if farmToggles["Mythic"]() then table.insert(activeRarities, "mythic") end
    if farmToggles["Secret"]() then table.insert(activeRarities, "secret") end
    if farmToggles["Stellar"]() then table.insert(activeRarities, "stellar") end

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

-- 9. AUTO COMPRAR FLORES (CORRIGIDO)
local buyItems = {
    {toggle = buyIce, name = "IceEmblem"},
    {toggle = buyVic, name = "Victrola"},
    {toggle = buyStar, name = "Star"},
    {toggle = buyFlow, name = "Flower"},
    {toggle = buyPhon, name = "Phone"}
}

-- Criar os toggles de compra primeiro
local buyIce = createToggle("Ice Emblem", 0, "BUY", false)
local buyVic = createToggle("Victrola", 1, "BUY", false)
local buyStar = createToggle("Star", 2, "BUY", false)
local buyFlow = createToggle("Flower", 3, "BUY", false)
local buyPhon = createToggle("Phone", 4, "BUY", false)

task.spawn(function()
    local Bridge = ReplicatedStorage:WaitForChild("Remotes", 5):WaitForChild("Bridge")
    local buyToggles = {buyIce, buyVic, buyStar, buyFlow, buyPhon}
    local buyNames = {"IceEmblem", "Victrola", "Star", "Flower", "Phone"}
    
    while task.wait(0.5) do
        for i = 1, 5 do
            if buyToggles[i]() then
                pcall(function()
                    Bridge:FireServer("General", "Buy", buyNames[i])
                end)
            end
        end
    end
end)
