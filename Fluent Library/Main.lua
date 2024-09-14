game.Players.LocalPlayer:Kick("Script Patched by tayfun")

--[[
-- Chat GPT so pelo meme e banir os fudido que e burro de usar script skiddado :DDDDDD
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "SkateHubGui"
screenGui.Parent = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Criar o Frame para o hub
local mainFrame = Instance.new("Frame")
mainFrame.Size = UDim2.new(0, 300, 0, 200)
mainFrame.Position = UDim2.new(0.5, -150, 0.5, -100) -- Centralizar na tela
mainFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
mainFrame.BorderSizePixel = 2
mainFrame.BorderColor3 = Color3.fromRGB(0, 0, 0)
mainFrame.Parent = screenGui

-- Título do Hub
local title = Instance.new("TextLabel")
title.Text = "Skate Hub"
title.Size = UDim2.new(1, 0, 0, 50)
title.Position = UDim2.new(0, 0, 0, 0)
title.BackgroundTransparency = 1
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.Ubuntu -- Fonte preferida
title.TextSize = 24
title.Parent = mainFrame

-- Função auxiliar para criar botões
local function createButton(text, position, callback)
    local button = Instance.new("TextButton")
    button.Text = text
    button.Size = UDim2.new(1, -20, 0, 40)
    button.Position = position
    button.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    button.BorderSizePixel = 2
    button.BorderColor3 = Color3.fromRGB(0, 0, 0)
    button.TextColor3 = Color3.fromRGB(255, 255, 255)
    button.Font = Enum.Font.Ubuntu
    button.TextSize = 18
    button.Parent = mainFrame
    
    button.MouseButton1Click:Connect(callback)
end

-- Funções que serão ativadas pelos botões
local function function1()
    local A_1 = game:GetService("Workspace").TPSSystem.TPS
    local A_2 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local A_3 = 70
    local A_4 = Vector3.new(4000000, -math.huge, 4000000)
    local Event = game:GetService("Workspace").FE.Actions.KickG1
    Event:FireServer(A_1, A_2, A_3, A_4)
end

local function function2()
    local A_1 = game:GetService("Workspace").TPSSystem.TPS
    local A_2 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local A_3 = 70
    local A_4 = Vector3.new(4000000, 1, -4000000)
    local Event = game:GetService("Workspace").FE.Actions.KickG1
    Event:FireServer(A_1, A_2, A_3, A_4)
end

local function function3()
    local A_1 = game:GetService("Workspace").TPSSystem.TPS
    local A_2 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local A_3 = 0
    local A_4 = Vector3.new(4000000, math.huge, 4000000)
    local Event = game:GetService("Workspace").FE.Actions.KickG1
    Event:FireServer(A_1, A_2, A_3, A_4)
end

-- Criar os botões e conectar às funções
createButton("Chegue Perto da bola e Clique", UDim2.new(0, 10, 0, 60), function1)
createButton("Logo apos clique nesse", UDim2.new(0, 10, 0, 110), function2)
createButton("Ativar Reach[Chegue perto da bola]", UDim2.new(0, 10, 0, 160), function3)

-- Função para tornar o Frame arrastável
local dragging
local dragInput
local dragStart
local startPos

local function update(input)
    local delta = input.Position - dragStart
    mainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

mainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = mainFrame.Position
        
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

mainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
]]
