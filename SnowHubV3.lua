local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "SnowyHub"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = PlayerGui

-- Botão flutuante
local FloatingButton = Instance.new("TextButton")
FloatingButton.Size = UDim2.new(0, 54, 0, 54)
FloatingButton.Position = UDim2.new(0, 50, 0.5, -27)
FloatingButton.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
FloatingButton.Text = ""
FloatingButton.Parent = ScreenGui

local UICornerBtn = Instance.new("UICorner")
UICornerBtn.CornerRadius = UDim.new(0, 12)
UICornerBtn.Parent = FloatingButton

local InnerBtn = Instance.new("Frame")
InnerBtn.Size = UDim2.new(0, 48, 0, 48)
InnerBtn.Position = UDim2.new(0.5, -24, 0.5, -24)
InnerBtn.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InnerBtn.Parent = FloatingButton

local UICornerInner = Instance.new("UICorner")
UICornerInner.CornerRadius = UDim.new(0, 10)
UICornerInner.Parent = InnerBtn

local BtnLabel = Instance.new("TextLabel")
BtnLabel.Size = UDim2.new(1, 0, 1, 0)
BtnLabel.BackgroundTransparency = 1
BtnLabel.Text = "S"
BtnLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
BtnLabel.TextSize = 24
BtnLabel.Font = Enum.Font.SourceSansBold
BtnLabel.Parent = InnerBtn

-- Menu principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 550, 0, 500)
MainFrame.Position = UDim2.new(0.5, -275, 0.5, -250)
MainFrame.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local UICornerFrame = Instance.new("UICorner")
UICornerFrame.CornerRadius = UDim.new(0, 12)
UICornerFrame.Parent = MainFrame

local InnerFrame = Instance.new("Frame")
InnerFrame.Size = UDim2.new(1, -6, 1, -6)
InnerFrame.Position = UDim2.new(0, 3, 0, 3)
InnerFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
InnerFrame.Parent = MainFrame

local UICornerInnerF = Instance.new("UICorner")
UICornerInnerF.CornerRadius = UDim.new(0, 10)
UICornerInnerF.Parent = InnerFrame

local TopBar = Instance.new("Frame")
TopBar.Size = UDim2.new(1, 0, 0, 45)
TopBar.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
TopBar.Parent = InnerFrame

local TopCorner = Instance.new("UICorner")
TopCorner.CornerRadius = UDim.new(0, 10)
TopCorner.Parent = TopBar

local ScriptTitle = Instance.new("TextLabel")
ScriptTitle.Size = UDim2.new(0, 150, 1, 0)
ScriptTitle.Position = UDim2.new(0, 10, 0, 0)
ScriptTitle.Text = "Snowy Hub V3"
ScriptTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
ScriptTitle.Font = Enum.Font.SourceSansBold
ScriptTitle.TextSize = 22
ScriptTitle.TextXAlignment = Enum.TextXAlignment.Left
ScriptTitle.BackgroundTransparency = 1
ScriptTitle.Parent = TopBar

local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 32, 0, 32)
CloseBtn.Position = UDim2.new(1, -42, 0.5, -16)
CloseBtn.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.TextSize = 18
CloseBtn.Parent = TopBar

local UICornerClose = Instance.new("UICorner")
UICornerClose.CornerRadius = UDim.new(0, 8)
UICornerClose.Parent = CloseBtn

local SideBar = Instance.new("Frame")
SideBar.Size = UDim2.new(0, 140, 1, -45)
SideBar.Position = UDim2.new(0, 0, 0, 45)
SideBar.BackgroundTransparency = 1
SideBar.Parent = InnerFrame

local MainContent = Instance.new("ScrollingFrame")
MainContent.Size = UDim2.new(1, -145, 1, -55)
MainContent.Position = UDim2.new(0, 145, 0, 50)
MainContent.BackgroundTransparency = 1
MainContent.ScrollBarThickness = 8
MainContent.CanvasSize = UDim2.new(0, 0, 0, 900)
MainContent.ScrollBarImageColor3 = Color3.fromRGB(255, 255, 255)
MainContent.AutomaticCanvasSize = Enum.AutomaticSize.Y
MainContent.Parent = InnerFrame

-- Função para criar botões de aba
local function createTabBtn(name, posIdx)
    local Btn = Instance.new("TextButton")
    Btn.Size = UDim2.new(0.85, 0, 0, 40)
    Btn.Position = UDim2.new(0.075, 0, 0, 20 + (posIdx * 50))
    Btn.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Btn.Text = name
    Btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    Btn.Font = Enum.Font.SourceSansBold
    Btn.TextSize = 18
    Btn.Parent = SideBar
    Instance.new("UICorner", Btn).CornerRadius = UDim.new(0, 8)
    return Btn
end

local TabMain = createTabBtn("Main", 0)
local TabFarm = createTabBtn("Farm", 1)
local TabBuy = createTabBtn("Buy", 2)
local TabSpeed = createTabBtn("Speed", 3)

local options = {Main = {}, Farm = {}, Buy = {}, Speed = {}}

-- Função para criar opções toggle
local function createOption(name, posIdx, startActive, tab, callback)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.95, 0, 0, 50)
    Container.Position = UDim2.new(0, 0, 0, posIdx * 60)
    Container.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Container.Visible = (tab == "Main")
    Container.Parent = MainContent
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(0.6, 0, 1, 0)
    Label.Position = UDim2.new(0.05, 0, 0, 0)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSans
    Label.TextSize = 16
    Label.Parent = Container

    local SwitchBG = Instance.new("TextButton")
    SwitchBG.Size = UDim2.new(0, 45, 0, 24)
    SwitchBG.Position = UDim2.new(1, -55, 0.5, -12)
    SwitchBG.BackgroundColor3 = startActive and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(40, 40, 40)
    SwitchBG.Text = ""
    SwitchBG.Parent = Container
    Instance.new("UICorner", SwitchBG).CornerRadius = UDim.new(1, 0)

    local Circle = Instance.new("Frame")
    Circle.Size = UDim2.new(0, 18, 0, 18)
    Circle.Position = startActive and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9)
    Circle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    Circle.Parent = SwitchBG
    Instance.new("UICorner", Circle).CornerRadius = UDim.new(1, 0)

    local active = startActive
    SwitchBG.MouseButton1Click:Connect(function()
        active = not active
        Circle:TweenPosition(active and UDim2.new(1, -21, 0.5, -9) or UDim2.new(0, 3, 0.5, -9), "Out", "Quad", 0.2, true)
        SwitchBG.BackgroundColor3 = active and Color3.fromRGB(150, 150, 150) or Color3.fromRGB(40, 40, 40)
        if callback then callback(active) end
    end)

    table.insert(options[tab], Container)
    return function() return active end
end

-- Função pra criar slider de velocidade
local function createSpeedSlider(name, posIdx, tab)
    local Container = Instance.new("Frame")
    Container.Size = UDim2.new(0.95, 0, 0, 70)
    Container.Position = UDim2.new(0, 0, 0, posIdx * 80)
    Container.BackgroundColor3 = Color3.fromRGB(80, 80, 80)
    Container.Visible = false
    Container.Parent = MainContent
    Instance.new("UICorner", Container).CornerRadius = UDim.new(0, 10)

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -20, 0, 30)
    Label.Position = UDim2.new(0, 10, 0, 5)
    Label.Text = name
    Label.TextColor3 = Color3.fromRGB(255, 255, 255)
    Label.BackgroundTransparency = 1
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Font = Enum.Font.SourceSansBold
    Label.TextSize = 18
    Label.Parent = Container

    local SliderBg = Instance.new("Frame")
    SliderBg.Size = UDim2.new(0.9, 0, 0, 20)
    SliderBg.Position = UDim2.new(0.05, 0, 0, 40)
    SliderBg.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    SliderBg.Parent = Container
    Instance.new("UICorner", SliderBg).CornerRadius = UDim.new(1, 0)

    local SliderFill = Instance.new("Frame")
    SliderFill.Size = UDim2.new(0.5, 0, 1, 0)
    SliderFill.BackgroundColor3 = Color3.fromRGB(100, 200, 100)
    SliderFill.Parent = SliderBg
    Instance.new("UICorner", SliderFill).CornerRadius = UDim.new(1, 0)

    local ValueLabel = Instance.new("TextLabel")
    ValueLabel.Size = UDim2.new(0, 50, 0, 20)
    ValueLabel.Position = UDim2.new(1, -60, 0, 40)
    ValueLabel.Text = "16"
    ValueLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
    ValueLabel.BackgroundTransparency = 1
    ValueLabel.Font = Enum.Font.SourceSansBold
    ValueLabel.TextSize = 16
    ValueLabel.Parent = Container

    local speed = 16
    local dragging = false

    local function updateSlider(input)
        local pos = UDim2.new(math.clamp((input.Position.X - SliderBg.AbsolutePosition.X) / SliderBg.AbsoluteSize.X, 0, 1), 0, 0.5, 0)
        SliderFill.Size = UDim2.new(pos.X.Scale, 0, 1, 0)
        speed = math.floor(16 + (pos.X.Scale * 84))
        ValueLabel.Text = tostring(speed)
    end

    SliderBg.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 then
            dragging = true
            updateSlider(input)
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
    return function() return speed end
end

-- === Opções da Main ===
local isGodRagdoll = createOption("Anti Ragdoll", 0, true, "Main")
local isInstantCollect = createOption("Instant Collect (sem segurar)", 1, true, "Main")
local isLowMode = createOption("Low Mode (mais FPS)", 2, false, "Main")
local isAutoBuyBrainrot = createOption("Auto Buy Brainrots (não perder)", 3, false, "Main")

-- === Opções do Farm (TODAS as raridades) ===
local isAutoCommon = createOption("Auto Common", 0, false, "Farm")
local isAutoUncommon = createOption("Auto Uncommon", 1, false, "Farm")
local isAutoRare = createOption("Auto Rare", 2, false, "Farm")
local isAutoEpic = createOption("Auto Epic", 3, false, "Farm")
local isAutoLegendary = createOption("Auto Legendary", 4, false, "Farm")
local isAutoMythic = createOption("Auto Mythic", 5, false, "Farm")
local isAutoSecret = createOption("Auto Secret", 6, false, "Farm")
local isAutoStellar = createOption("Auto Stellar", 7, false, "Farm")

-- === Opções de Compra ===
local buyIce = createOption("Auto Ice Emblem", 0, false, "Buy")
local buyVic = createOption("Auto Victrola", 1, false, "Buy")
local buyStar = createOption("Auto Star", 2, false, "Buy")
local buyFlow = createOption("Auto Flower", 3, false, "Buy")
local buyPhon = createOption("Auto Phone", 4, false, "Buy")

-- Slider de velocidade
local getSpeed = createSpeedSlider("Velocidade do Player", 0, "Speed")

-- Materiais para Low Mode
local originalMaterials = {}

-- Função pra trocar abas
local function showTab(tabName)
    for _, v in pairs(options.Main) do v.Visible = (tabName == "Main") end
    for _, v in pairs(options.Farm) do v.Visible = (tabName == "Farm") end
    for _, v in pairs(options.Buy) do v.Visible = (tabName == "Buy") end
    for _, v in pairs(options.Speed) do v.Visible = (tabName == "Speed") end
end

TabMain.MouseButton1Click:Connect(function() showTab("Main") end)
TabFarm.MouseButton1Click:Connect(function() showTab("Farm") end)
TabBuy.MouseButton1Click:Connect(function() showTab("Buy") end)
TabSpeed.MouseButton1Click:Connect(function() showTab("Speed") end)

-- Dragging do botão
local dragging, dragStart, startPos
FloatingButton.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = FloatingButton.Position
    end
end)

UserInputService.InputChanged:Connect(function(input)
    if dragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - dragStart
        FloatingButton.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

UserInputService.InputEnded:Connect(function() dragging = false end)

-- Fechar com botão X
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- Abrir/Fechar com tecla L
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if not gameProcessed and input.KeyCode == Enum.KeyCode.L then
        MainFrame.Visible = not MainFrame.Visible
    end
end)

-- Botão flutuante também abre
FloatingButton.MouseButton1Click:Connect(function() MainFrame.Visible = not MainFrame.Visible end)

-- === FUNÇÕES ===

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

-- 2. INSTANT COLLECT (ProximityPrompt sem segurar)
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
                pcall(function()
                    if part and part.Parent then
                        part.Material = mat
                    end
                end)
            end
            originalMaterials = {}
        end
    end
end)

-- 4. AUTO BUY BRAINROTS (não perder para outros)
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

-- 6. AUTO FARM (Todas as raridades) com COMPRA AUTOMÁTICA
local brainrotsFolder = workspace:WaitForChild("Client", 10):WaitForChild("Path", 5):WaitForChild("Brainrots", 5)
local targetHead = nil
local isHidden = false

-- Lista completa de raridades
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

-- Função para comprar o pet automaticamente (spamar E)
local function autoBuyPet()
    local char = Player.Character
    if not char or not char:FindFirstChild("HumanoidRootPart") then return false end
    
    -- Procura por ProximityPrompt perto do player
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") and prompt.Enabled then
            local part = prompt.Parent
            if part and part:IsA("BasePart") then
                local distance = (char.HumanoidRootPart.Position - part.Position).Magnitude
                -- Se estiver perto do prompt (distância de ativação)
                if distance <= prompt.MaxActivationDistance then
                    -- Ativa o prompt (compra o pet)
                    fireproximityprompt(prompt)
                    return true
                end
            end
        end
    end
    return false
end

-- Spam de compra mais rápido (10x por segundo)
task.spawn(function()
    while task.wait(0.1) do
        if targetHead then -- Se tem um alvo
            pcall(autoBuyPet)
        end
    end
end)

RunService.Heartbeat:Connect(function()
    -- Verifica quais raridades estão ativas
    local activeRarities = {}
    if isAutoCommon() then table.insert(activeRarities, "common") end
    if isAutoUncommon() then table.insert(activeRarities, "uncommon") end
    if isAutoRare() then table.insert(activeRarities, "rare") end
    if isAutoEpic() then table.insert(activeRarities, "epic") end
    if isAutoLegendary() then table.insert(activeRarities, "legendary") end
    if isAutoMythic() then table.insert(activeRarities, "mythic") end
    if isAutoSecret() then table.insert(activeRarities, "secret") end
    if isAutoStellar() then table.insert(activeRarities, "stellar") end

    if #activeRarities == 0 then 
        targetHead = nil 
        if isHidden then setVisibility(true) end
        return 
    end

    local char = Player.Character
    local root = char and char:FindFirstChild("HumanoidRootPart")
    if not root then return end

    -- Se já tem um alvo e ele ainda existe
    if targetHead and targetHead.Parent and targetHead.Parent.Parent == brainrotsFolder then
        -- Fica perto do pet para comprar
        root.CFrame = targetHead.CFrame * CFrame.new(0, 0, -3)
        
        if not isHidden then setVisibility(false) end
        
        -- Tenta comprar a cada frame também
        pcall(autoBuyPet)
        
        return
    end

    -- Procura novo alvo
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
                        root.CFrame = head.CFrame * CFrame.new(0, 0, -3) -- Teleporta e já posiciona para comprar
                        break
                    end
                end
                
                if targetHead then break end
            end
        end
    end
end)

-- 7. AUTO COMPRAR INGREDIENTES
local function isAnyBuyActive()
    return buyIce() or buyVic() or buyStar() or buyFlow() or buyPhon()
end

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
        if isAnyBuyActive() then
            pcall(function()
                for _, item in ipairs(buyList) do
                    if item.get() then
                        Bridge:FireServer("General", "Buy", item.name)
                    end
                end
            end)
        end
    end
end)

print("✅ Snowy Hub V3 carregado!")
print("📌 Pressione L para abrir/fechar")
print("📌 Abas: Main | Farm | Buy | Speed")
print("📌 Main: Anti Ragdoll, Instant Collect, Low Mode, Auto Buy Brainrot")
print("📌 Farm: Common até Stellar (8 raridades) - com COMPRA AUTOMÁTICA")
