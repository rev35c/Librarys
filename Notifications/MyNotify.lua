local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

local screenGui = Instance.new("ScreenGui")
screenGui.Name = "NotificationGui"
screenGui.Parent = playerGui

local notificationFrame = Instance.new("Frame")
notificationFrame.Size = UDim2.new(0, 250, 0, 80)  -- size
notificationFrame.Position = UDim2.new(1, 260, 1, -100)  -- animation
notificationFrame.AnchorPoint = Vector2.new(1, 1)
notificationFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
notificationFrame.BorderSizePixel = 0
notificationFrame.Parent = screenGui

local uiCorner = Instance.new("UICorner")
uiCorner.CornerRadius = UDim.new(0, 10)
uiCorner.Parent = notificationFrame

local border = Instance.new("Frame")
border.Size = UDim2.new(1, 4, 1, 4)
border.Position = UDim2.new(0, -2, 0, -2)
border.AnchorPoint = Vector2.new(0, 0)
border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
border.BorderSizePixel = 0
border.ZIndex = 0
border.Parent = notificationFrame

local borderCorner = Instance.new("UICorner")
borderCorner.CornerRadius = UDim.new(0, 12)
borderCorner.Parent = border


local icon = Instance.new("ImageLabel")
icon.Size = UDim2.new(0, 50, 0, 50)
icon.Position = UDim2.new(0, 10, 0.5, -25)
icon.BackgroundTransparency = 1
icon.Image = "http://www.roblox.com/asset/?id=18878611160"
icon.Parent = notificationFrame

local title = Instance.new("TextLabel")
title.Size = UDim2.new(0, 170, 0, 25)
title.Position = UDim2.new(0, 70, 0.2, 0)
title.BackgroundTransparency = 1
title.Text = "Anti Cheat"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.Font = Enum.Font.SourceSansBold
title.TextSize = 18
title.TextXAlignment = Enum.TextXAlignment.Left
title.Parent = notificationFrame
local message = Instance.new("TextLabel")

message.Size = UDim2.new(0, 170, 0, 20)
message.Position = UDim2.new(0, 70, 0.5, 0)
message.BackgroundTransparency = 1
message.Text = "Success to Bypass TF1.8!"
message.TextColor3 = Color3.fromRGB(200, 200, 200)
message.Font = Enum.Font.SourceSans
message.TextSize = 16
message.TextXAlignment = Enum.TextXAlignment.Left
message.Parent = notificationFrame

local function showNotification()
    local tweenIn = TweenService:Create(notificationFrame, TweenInfo.new(0.5), {Position = UDim2.new(1, -10, 1, -10)})
    tweenIn:Play()
    wait(3)
    local tweenOut = TweenService:Create(notificationFrame, TweenInfo.new(0.5), {Position = UDim2.new(1, 260, 1, -10)})
    tweenOut:Play()
    tweenOut.Completed:Connect(function()
        screenGui:Destroy()
    end)
end
showNotification()
