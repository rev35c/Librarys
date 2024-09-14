--UI
local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/Skinny-yz/Librarys/main/Fluent%20Library/Main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

---Window
local Window = Fluent:CreateWindow({
    Title = "Skate Hub(Mobile)",
    SubTitle = "",
    TabWidth = 130,
    Size = UDim2.fromOffset(500, 320),
    Acrylic = true, 
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.End
})

--Tabs
local Tabs = {
    Reach = Window:AddTab({ Title = "Reach & Reacts", Icon = "ruler" }),
    Gamepasses = Window:AddTab({ Title = "Gamepasses", Icon = "scale" }),
    AirDribbleHelper = Window:AddTab({ Title = "Air Dribble Helper", Icon = "terminal" }),
    Helpers = Window:AddTab({ Title = "Dribble Helpers", Icon = "ghost" }),
    BallModiffy = Window:AddTab({ Title = "Ball Modifications", Icon = "cpu" }),
    GameChanger = Window:AddTab({ Title = "Game Changer", Icon = "joystick" }),
    Misc = Window:AddTab({ Title = "Misc", Icon = "gamepad" }),
    TrollS = Window:AddTab({ Title = "Troll Scripts", Icon = "rbxassetid://131765165751888" }),
    Disguise = Window:AddTab({ Title = "Avatar Stolen", Icon = "person-standing" }),
    Skyes = Window:AddTab({ Title = "Skyes", Icon = "cloud" }),
    UI = Window:AddTab({ Title = "Configs UI", Icon = "rbxassetid://11293977610" }),
}
Window:SelectTab(1)


Tabs.Reach:AddButton({
Title = "Chegue Perto da bola e Clique",
Callback = function()
    local A_1 = game:GetService("Workspace").TPSSystem.TPS
    local A_2 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local A_3 = 70
    local A_4 = Vector3.new(4000000, -math.huge, 4000000)
    local Event = game:GetService("Workspace").FE.Actions.KickG1
    Event:FireServer(A_1, A_2, A_3, A_4)
end})
Tabs.Reach:AddButton({
    Title = "Logo apos clique nesse",
    Callback = function()
        local A_1 = game:GetService("Workspace").TPSSystem.TPS
    local A_2 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local A_3 = 70
    local A_4 = Vector3.new(4000000, 1, -4000000)
    local Event = game:GetService("Workspace").FE.Actions.KickG1
    Event:FireServer(A_1, A_2, A_3, A_4)
    end})
    Tabs.Reach:AddButton({
        Title = "Ativar Reach[Chegue perto da bola]",
        Callback = function()
            local A_1 = game:GetService("Workspace").TPSSystem.TPS
            local A_2 = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
            local A_3 = 0
            local A_4 = Vector3.new(4000000, math.huge, 4000000)
            local Event = game:GetService("Workspace").FE.Actions.KickG1
            Event:FireServer(A_1, A_2, A_3, A_4)
        end})
