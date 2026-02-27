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
FloatingButton.Size = UDim2.new(0, 50, 0, 50)
FloatingButton.Position = UDim2.new(0, 50, 0.5, -25)
FloatingButton.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
FloatingButton.Text = "S"
FloatingButton.TextColor3 = Color3.new(1, 1, 1)
FloatingButton.TextSize = 24
FloatingButton.Font = Enum.Font.SourceSansBold
FloatingButton.Parent = ScreenGui

-- Menu principal
local MainFrame = Instance.new("Frame")
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

-- Título
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 40)
Title.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
Title.Text = "Snowy Hub"
Title.TextColor3 = Color3.new(1, 1, 1)
Title.TextSize = 20
Title.Font = Enum.Font.SourceSansBold
Title.Parent = MainFrame

-- Botão fechar
local CloseBtn = Instance.new("TextButton")
CloseBtn.Size = UDim2.new(0, 30, 0, 30)
CloseBtn.Position = UDim2.new(1, -35, 0, 5)
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 50, 50)
CloseBtn.Text = "X"
CloseBtn.TextColor3 = Color3.new(1, 1, 1)
CloseBtn.TextSize = 16
CloseBtn.Font = Enum.Font.SourceSansBold
CloseBtn.Parent = MainFrame

-- Abas
local TabMain = Instance.new("TextButton")
TabMain.Size = UDim2.new(0.25, -2, 0, 30)
TabMain.Position = UDim2.new(0.02, 0, 0, 45)
TabMain.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TabMain.Text = "MAIN"
TabMain.TextColor3 = Color3.new(1, 1, 1)
TabMain.Parent = MainFrame

local TabFarm = Instance.new("TextButton")
TabFarm.Size = UDim2.new(0.25, -2, 0, 30)
TabFarm.Position = UDim2.new(0.27, 0, 0, 45)
TabFarm.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TabFarm.Text = "FARM"
TabFarm.TextColor3 = Color3.new(1, 1, 1)
TabFarm.Parent = MainFrame

local TabMisc = Instance.new("TextButton")
TabMisc.Size = UDim2.new(0.25, -2, 0, 30)
TabMisc.Position = UDim2.new(0.52, 0, 0, 45)
TabMisc.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TabMisc.Text = "MISC"
TabMisc.TextColor3 = Color3.new(1, 1, 1)
TabMisc.Parent = MainFrame

local TabSpeed = Instance.new("TextButton")
TabSpeed.Size = UDim2.new(0.25, -2, 0, 30)
TabSpeed.Position = UDim2.new(0.77, 0, 0, 45)
TabSpeed.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TabSpeed.Text = "SPEED"
TabSpeed.TextColor3 = Color3.new(1, 1, 1)
TabSpeed.Parent = MainFrame

-- Área de conteúdo
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -10, 1, -85)
Content.Position = UDim2.new(0, 5, 0, 80)
Content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Content.Parent = MainFrame

-- Função para criar toggle
local function createToggle(name, pos, tab)
    local toggle = Instance.new("TextButton")
    toggle.Size = UDim2.new(1, -10, 0, 35)
    toggle.Position = UDim2.new(0, 5, 0, 5 + (pos * 40))
    toggle.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    toggle.Text = name .. " [OFF]"
    toggle.TextColor3 = Color3.new(1, 1, 1)
    toggle.Parent = Content
    toggle.Visible = false
    
    local active = false
    toggle.MouseButton1Click:Connect(function()
        active = not active
        toggle.Text = name .. (active and " [ON]" or " [OFF]")
        toggle.BackgroundColor3 = active and Color3.fromRGB(0, 150, 0) or Color3.fromRGB(60, 60, 60)
    end)
    
    return function() return active end
end

-- Função para criar slider
local function createSlider(name, pos, tab)
    local slider = Instance.new("TextButton")
    slider.Size = UDim2.new(1, -10, 0, 35)
    slider.Position = UDim2.new(0, 5, 0, 5 + (pos * 40))
    slider.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
    slider.Text = name .. ": 16"
    slider.TextColor3 = Color3.new(1, 1, 1)
    slider.Parent = Content
    slider.Visible = false
    
    local value = 16
    slider.MouseButton1Click:Connect(function()
        value = value + 10
        if value > 100 then value = 16 end
        slider.Text = name .. ": " .. value
    end)
    
    return function() return value end
end

-- Criar opções
local toggles = {
    MAIN = {},
    FARM = {},
    MISC = {},
    SPEED = {}
}

-- MAIN
toggles.MAIN[1] = createToggle("Anti Ragdoll", 0, "MAIN")
toggles.MAIN[2] = createToggle("Instant Collect", 1, "MAIN")
toggles.MAIN[3] = createToggle("Low Mode", 2, "MAIN")
toggles.MAIN[4] = createToggle("Auto Buy Brainrot", 3, "MAIN")

-- FARM
for i = 1, 8 do
    local names = {"Common", "Uncommon", "Rare", "Epic", "Legendary", "Mythic", "Secret", "Stellar"}
    toggles.FARM[i] = createToggle(names[i], i-1, "FARM")
end

-- MISC
toggles.MISC[1] = createToggle("Player ESP", 0, "MISC")
toggles.MISC[2] = createToggle("Invisible", 1, "MISC")

-- SPEED
toggles.SPEED[1] = createSlider("WalkSpeed", 0, "SPEED")

-- Função para mostrar aba
local function showTab(tab)
    for t, list in pairs(toggles) do
        for _, toggle in ipairs(list) do
            toggle.Visible = (t == tab)
        end
    end
end

-- Conectar abas
TabMain.MouseButton1Click:Connect(function() showTab("MAIN") end)
TabFarm.MouseButton1Click:Connect(function() showTab("FARM") end)
TabMisc.MouseButton1Click:Connect(function() showTab("MISC") end)
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

-- Função para abrir/fechar
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

print("✅ Snowy Hub carregado! Pressione L para abrir")
