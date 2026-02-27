local Player = game.Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local UserInputService = game:GetService("UserInputService")

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
MainFrame.Size = UDim2.new(0, 400, 0, 300)
MainFrame.Position = UDim2.new(0.5, -200, 0.5, -150)
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
TabMain.Size = UDim2.new(0.5, -5, 0, 30)
TabMain.Position = UDim2.new(0, 5, 0, 45)
TabMain.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TabMain.Text = "Main"
TabMain.TextColor3 = Color3.new(1, 1, 1)
TabMain.Parent = MainFrame

local TabFarm = Instance.new("TextButton")
TabFarm.Size = UDim2.new(0.5, -5, 0, 30)
TabFarm.Position = UDim2.new(0.5, 0, 0, 45)
TabFarm.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
TabFarm.Text = "Farm"
TabFarm.TextColor3 = Color3.new(1, 1, 1)
TabFarm.Parent = MainFrame

-- Área de conteúdo
local Content = Instance.new("Frame")
Content.Size = UDim2.new(1, -10, 1, -85)
Content.Position = UDim2.new(0, 5, 0, 80)
Content.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
Content.Parent = MainFrame

-- Função toggle menu
local function toggleMenu()
    MainFrame.Visible = not MainFrame.Visible
end

-- Botão flutuante
FloatingButton.MouseButton1Click:Connect(toggleMenu)
CloseBtn.MouseButton1Click:Connect(function() MainFrame.Visible = false end)

-- Tecla L
UserInputService.InputBegan:Connect(function(input, gp)
    if not gp and input.KeyCode == Enum.KeyCode.L then
        toggleMenu()
    end
end)

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

print("✅ Snowy Hub - Versão Simples")
print("📌 Pressione L para abrir")
