

local inputservice =	game:GetService("InsertService")
local tweenservice = 	game:GetService("TweenService")
local https = 			game:GetService("HttpService")
local runservice =		game:GetService("RunService")
local userinput =		game:GetService("UserInputService")
local players =         game:GetService("Players"):GetPlayers()
local textservice =     game:GetService('TextService')
local player =          game:GetService('Players')
local coregui =         game:GetService("CoreGui")
local textservice =     game:GetService('TextService')

local Loader =          game:GetObjects("rbxassetid://110221114597158")[1]
local Library =         game:GetObjects("rbxassetid://123800669522471")[1]

local sharedModule = {}

Library.Enabled = false

local loaded = false
local syde = {

	theme = {
		['Accent'] = Color3.fromRGB(255, 255, 255);
		['HitBox'] = Color3.fromRGB(255, 255, 255);
		['Glow']   = Color3.fromRGB(0, 0, 0);

	};
	Connections = {};
	Comms = Instance.new('BindableEvent');
	ParentOverride = nil;
	Build = 'Lunar'
}


-- [ THEME MANAGEMENT ]
function syde:UpdateTheme(Config)
	if type(Config) ~= "table" then
		warn("[UpdateTheme] Invalid configuration table")
		return
	end

	local updatedKeys = {}

	for key, value in pairs(Config) do
		if self.theme[key] ~= nil then
			if typeof(self.theme[key]) == typeof(value) then
				if type(value) == "table" then
					self:DeepMerge(self.theme[key], value)
				else
					self.theme[key] = value
				end
				table.insert(updatedKeys, key)
			else
				warn(("[UpdateTheme] Type mismatch for key '%s' (expected %s, got %s)"):format(
					key, typeof(self.theme[key]), typeof(value)
					))
			end
		else
			warn("[UpdateTheme] Key '" .. key .. "' does not exist in theme")
		end
	end

	if #updatedKeys > 0 then
		for _, key in ipairs(updatedKeys) do
			self.Comms:Fire(key, self.theme[key])
		end
	end
end

function syde:DeepMerge(target, source)
	for k, v in pairs(source) do
		if type(v) == "table" and type(target[k]) == "table" then
			self:DeepMerge(target[k], v) 
		else
			target[k] = v
		end
	end
end

-- [UTILITIES]

function syde:getdark(Color, val, mode)
	if typeof(Color) ~= "Color3" or type(val) ~= "number" then
		warn("[getdark] Invalid input: Expected (Color3, number)")
		return Color
	end

	local H, S, V = Color:ToHSV()

	val = math.clamp(val, 0.1, 10) 

	if mode == "subtract" then
		V = math.clamp(V - (val / 10), 0, 1)  
	else
		V = math.clamp(V / val, 0, 1)  
	end

	return Color3.fromHSV(H, S, V)
end

function syde:HidePlaceHolder(instance, placeholder, recursive)
	if typeof(instance) ~= "Instance" or type(placeholder) ~= "string" then
		warn("[removeplaceholder] Invalid input: Expected (Instance, string)")
		return
	end

	local target = instance:FindFirstChild(placeholder)

	if not target then
		warn(("[removeplaceholder] Placeholder '%s' not found in instance '%s'"):format(placeholder, instance.Name))
		return
	end

	if target:IsA("GuiObject") then
		target.Visible = false
	else
		warn(("[removeplaceholder] '%s' is not a GuiObject and cannot be hidden"):format(placeholder))
		return
	end

	if recursive then
		for _, child in ipairs(target:GetDescendants()) do
			if child:IsA("GuiObject") then
				child.Visible = false
			end
		end
	end
end

function syde:AddConnection(Type, Callback)
	if typeof(Type) ~= "RBXScriptSignal" then
		error("[AddConnection] Invalid Type: Expected RBXScriptSignal, got " .. typeof(Type))
	end
	if typeof(Callback) ~= "function" then
		error("[AddConnection] Invalid Callback: Expected function, got " .. typeof(Callback))
	end

	local Connection = Type:Connect(Callback)
	local ConnectionData = { Connection = Connection }

	syde.Connections = syde.Connections or {}
	table.insert(syde.Connections, ConnectionData)

	local function Disconnect()
		if Connection.Connected then
			Connection:Disconnect()
		end

		for i = #syde.Connections, 1, -1 do
			if syde.Connections[i] == ConnectionData then
				table.remove(syde.Connections, i)
				break
			end
		end
	end

	task.spawn(function()
		task.wait(10)
		for i = #syde.Connections, 1, -1 do
			if not syde.Connections[i].Connection.Connected then
				table.remove(syde.Connections, i)
			end
		end
	end)

	return Connection, Disconnect
end

function syde:MakeResizable(Dragger, Object, MinSize, Callback, LockAspectRatio)
	assert(typeof(Dragger) == "Instance" and Dragger:IsA("GuiObject"), "[MakeResizable] Dragger must be a GuiObject")
	assert(typeof(Object) == "Instance" and Object:IsA("GuiObject"), "[MakeResizable] Object must be a GuiObject")
	assert(typeof(MinSize) == "Vector2", "[MakeResizable] MinSize must be a Vector2")
	assert(Callback == nil or typeof(Callback) == "function", "[MakeResizable] Callback must be a function or nil")

	local userInput = game:GetService("UserInputService")

	local startPosition, startSize = nil, nil
	local isResizing = false

	local function onInputBegan(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isResizing = true
			startPosition = userInput:GetMouseLocation()
			startSize = Object.AbsoluteSize
			tweenservice:Create(Library.lib.resize, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 13,0, 13)}):Play()
		end
	end

	local function onInputChanged(input)
		if isResizing and input.UserInputType == Enum.UserInputType.MouseMovement then
			local mouse = userInput:GetMouseLocation()
			local delta = mouse - startPosition

			local newWidth = math.max(MinSize.X, startSize.X + delta.X)
			local newHeight = math.max(MinSize.Y, startSize.Y + delta.Y)

			if LockAspectRatio then
				local aspectRatio = startSize.X / startSize.Y
				newHeight = newWidth / aspectRatio
			end

			Object:TweenSize(
				UDim2.fromOffset(newWidth, newHeight),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quint,
				0.7,
				true
			)

			if Callback then
				Callback(Vector2.new(newWidth, newHeight))
			end
		end
	end

	local function onInputEnded(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			isResizing = false
			startPosition, startSize = nil, nil
			tweenservice:Create(Library.lib.resize, TweenInfo.new(0.3, Enum.EasingStyle.Quart), {Size = UDim2.new(0, 15,0, 15)}):Play()
		end
	end

	syde:AddConnection(Dragger.InputBegan, onInputBegan)
	syde:AddConnection(userInput.InputChanged, onInputChanged)
	syde:AddConnection(Dragger.InputEnded, onInputEnded)

end

local loadTweens = {}

function syde:registerLoadTween(object, properties, initialState, tweenInfo)
	assert(typeof(object) == "Instance", "[registerLoadTween] Object must be an Instance")
	assert(typeof(properties) == "table", "[registerLoadTween] Properties must be a table")
	assert(typeof(initialState) == "table", "[registerLoadTween] Initial state must be a table")
	assert(typeof(tweenInfo) == "TweenInfo", "[registerLoadTween] TweenInfo must be of type TweenInfo")

	loadTweens[object] = {
		tween = tweenservice:Create(object, tweenInfo, properties),
		properties = properties,
		initialState = initialState,
		tweenInfo = tweenInfo
	}
end

function syde:resetToInitialState(animated, resetTweenInfo)
	for object, tweenData in pairs(loadTweens) do
		if object and object.Parent then
			tweenData.tween:Cancel()

			if animated then
				local resetTween = tweenservice:Create(object, resetTweenInfo or TweenInfo.new(0.3), tweenData.initialState)
				resetTween:Play()
				resetTween.Completed:Wait()
			else

				for property, value in pairs(tweenData.initialState) do
					object[property] = value
				end
			end
		end
	end
end

function syde:replayLoadTweens(targetObject)
	syde:resetToInitialState(false)

	for object, tweenData in pairs(loadTweens) do
		if object and object.Parent then
			if not targetObject or object == targetObject then
				tweenData.tween:Cancel()
				tweenData.tween:Play()
			end
		end
	end
end

function syde:removeLoadTween(object)
	if loadTweens[object] then
		loadTweens[object].tween:Cancel()
		loadTweens[object] = nil
	end
end

function syde:updateLayout(container, spacing)
	spacing = spacing or 5
	local yOffset = 0
	local containerWidth = container.AbsoluteSize.X 

	for _, v in ipairs(container:GetChildren()) do
		if v:IsA('UIListLayout') then
			v:Destroy()
		end
	end

	for _, child in ipairs(container:GetChildren()) do
		if (child:IsA("Frame") or child:IsA("ImageLabel") or child:IsA("TextLabel") or child:IsA("TextButton")) and child.Visible then
			--child.Size = UDim2.new(1, -10, 0, child.Size.Y.Offset) -- Full width, fixed height
			-- child.Position = UDim2.new(0, 0, 0, yOffset)
			tweenservice:Create(child, TweenInfo.new(0.45, Enum.EasingStyle.Exponential), {Position = UDim2.new(0, 0, 0, yOffset)}):Play()
			yOffset = yOffset + child.AbsoluteSize.Y + spacing
		end
	end

	container.CanvasSize = UDim2.new(0, 0, 0, yOffset)
end


function syde:AddDrag(Object, Main, speed, ConstrainToParent)
	assert(typeof(Object) == "Instance" and Object:IsA("GuiObject"), "[AddDrag] Object must be a GuiObject")
	assert(typeof(Main) == "Instance" and Main:IsA("GuiObject"), "[AddDrag] Main must be a GuiObject")

	local userInput = game:GetService("UserInputService")
	local tweenService = game:GetService("TweenService")

	local dragging, dragInput, startMousePos, startFramePos = false, nil, nil, nil
	speed = speed or 0.15  -- Default smoothness speed

	local function getConstrainedPosition(newPos)
		if not ConstrainToParent or not Main.Parent or not Main.Parent:IsA("GuiObject") then
			return newPos
		end

		local parentSize = Main.Parent.AbsoluteSize
		local frameSize = Main.AbsoluteSize

		local minX = 0
		local maxX = parentSize.X - frameSize.X
		local minY = 0
		local maxY = parentSize.Y - frameSize.Y

		local constrainedX = math.clamp(newPos.X.Offset, minX, maxX)
		local constrainedY = math.clamp(newPos.Y.Offset, minY, maxY)

		return UDim2.new(newPos.X.Scale, constrainedX, newPos.Y.Scale, constrainedY)
	end

	syde:AddConnection(Object.InputBegan, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			startMousePos = userInput:GetMouseLocation()
			startFramePos = Main.Position
		end
	end)

	syde:AddConnection(userInput.InputChanged, function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement and dragging then
			local currentMousePos = userInput:GetMouseLocation()
			local delta = currentMousePos - startMousePos

			local newPos = UDim2.new(
				startFramePos.X.Scale, startFramePos.X.Offset + delta.X,
				startFramePos.Y.Scale, startFramePos.Y.Offset + delta.Y
			)

			Main:TweenPosition(getConstrainedPosition(newPos), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, speed, true)
		end
	end)

	syde:AddConnection(Object.InputEnded, function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = false
		end
	end)
end

local notifications = {}
local notificationSpacing = 10

local tweenInfo = TweenInfo.new(0.7, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

function updatePositions()
	local screenHeight = workspace.CurrentCamera.ViewportSize.Y - 200
	local currentY = screenHeight

	for i = #notifications, 1, -1 do
		local notif = notifications[i]
		local targetPosition = UDim2.new(0, 250, 0, currentY - notif.Size.Y.Offset + 60) 
		tweenservice:Create(notif, tweenInfo, { Position = targetPosition }):Play()
		currentY = currentY - (notif.Size.Y.Offset + notificationSpacing)
	end
end

for _, temp in ipairs(Library.Notification:GetChildren()) do
	if temp:IsA("Frame") then
		temp.Visible = false
	end
end 


function syde:Notify(Notification)
	task.spawn(function()

		local NotifData = {
			Title = Notification.Title;
			Content = Notification.Content;
			Duration = Notification.Duration or 5;
		}

		local Notification = Library.Notification.Default:Clone()
		Notification.Visible = true
		Notification.Parent = Library.Notification
		Notification.Title.Text = NotifData.Title
		Notification.Content.Text = NotifData.Content
		Notification.Content.Size = UDim2.new(0, 200,0, Notification.Content.TextBounds.Y )
		Notification.Size = UDim2.new(1, 0,0, Notification.Content.TextBounds.Y + 50)

		table.insert(notifications, Notification)
		updatePositions()

		Notification.UIScale.Scale = 0.9
		Notification.close.ImageTransparency = 0.95
		Notification.BackgroundTransparency = 0.75
		Notification.Title.TextTransparency = 0.5
		Notification.Content.TextTransparency = 0.78

		Notification.Position = UDim2.new(0, 600, 0, 637)

		local function CloseNotif()

			if Notification and Notification.Parent then
				table.remove(notifications, table.find(notifications, Notification))
				tweenservice:Create(Notification.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Scale = 0.9}):Play()
				tweenservice:Create(Notification.close, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 0.95}):Play()
				tweenservice:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.75}):Play()
				tweenservice:Create(Notification.Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0.5}):Play()
				tweenservice:Create(Notification.Content, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0.78}):Play()

				task.wait(0.15)

				tweenservice:Create(Notification, TweenInfo.new(0.95, Enum.EasingStyle.Exponential), {Position = UDim2.new(0, Notification.Position.X.Offset + 400, 0, Notification.Position.Y.Offset) }):Play()
				task.wait(0.4)
				Notification:Destroy()
				updatePositions()
			end

		end

		task.wait(0.45)

		tweenservice:Create(Notification.UIScale, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {Scale = 1}):Play()
		tweenservice:Create(Notification.close, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 0.75}):Play()
		tweenservice:Create(Notification, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
		tweenservice:Create(Notification.Title, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
		tweenservice:Create(Notification.Content, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

		Notification.close.MouseEnter:Connect(function()
			tweenservice:Create(Notification.close, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 0.25}):Play()
		end)

		Notification.close.MouseLeave:Connect(function()
			tweenservice:Create(Notification.close, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), {ImageTransparency = 0.75}):Play()
		end)

		Notification.close.MouseButton1Click:Connect(function()
			CloseNotif()
		end)

		task.delay(NotifData.Duration, function()
			CloseNotif()
		end)
	end)
end

--[LOADER INIALIZE]
-- just a bunch of task waits for now (feel free to skip)
do

	function syde:Load(Config)
		
		local LOADER = Loader
		LOADER.Enabled = true
		LOADER.Parent = coregui

		-- PreLoad
		Config.Name = Config.Name or 'Syde™'
		Config.Logo = Config.Logo or 'rbxassetid://14554547135'
		Config.ConfigFolder = Config.ConfigFolder or 'syde'
		Config.Status = Config.Status or false
		Config.Accent = Config.Accent or syde.theme.Accent
		Config.HitBox = Config.HitBox or syde.theme.HitBox

		local LoaderConfig = {
			Name = Config.Name;
			Logo = 'rbxassetid://'..Config.Logo;
			ConfigFolder = Config.ConfigFolder;
			Status = Config.Status;
			Accent = Config.Accent or syde.theme.Accent;
			Hitbox = Config.HitBox or syde.theme.HitBox;
			Socials = {}
		}

		local TweenWorkPos = 315
		local TweenWorkAppear = 287
		local TweenWorkDisappear = 270

		local Styles = {
			GitHub = {
				BackGroundColor = Color3.fromRGB(39, 39, 39);
				GradColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(129, 129, 129))};
				StrokeColor = Color3.fromRGB(34, 34, 34)
			},
			Discord = {
				BackGroundColor = Color3.fromRGB(88, 141, 255);
				GradColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(91, 125, 147))};
				StrokeColor = Color3.fromRGB(88, 141, 255)
			},
			Site = {
				BackGroundColor = Color3.fromRGB(39, 11, 34);
				GradColor = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(181, 33, 255))};
				StrokeColor = Color3.fromRGB(67, 19, 59)
			}
		}


		if typeof(Config.Socials) == "table" and #Config.Socials > 0 then
			LOADER.load.Size = UDim2.new(0, 400, 0, 360)
			LOADER.load.social.Visible = true

			syde:HidePlaceHolder(LOADER.load.social.largeblock, 'largesocial')
			syde:HidePlaceHolder(LOADER.load.social, 'little')
			syde:HidePlaceHolder(LOADER.load.social.little, 'smallblock1')
			syde:HidePlaceHolder(LOADER.load.social.little, 'smallblock2')

			for _, social in ipairs(Config.Socials) do
				table.insert(LoaderConfig.Socials, {
					Name = social.Name or '@None';
					Discord = social.Discord or 'None';
					Style = social.Style or "Default";
					Size = social.Size or "Medium";
					CopyToClip = social.CopyToClip ~= nil and social.CopyToClip or true;
				})
			end

			for _, social in ipairs(LoaderConfig.Socials) do
				if social.Size == "Large" then
					local LargeSocial = LOADER.load.social.largeblock.largesocial:Clone()
					LargeSocial.Visible = true
					LargeSocial.Parent = LOADER.load.social.largeblock

					-- [StyleHandle]
					if social.Style == 'GitHub' then
						LargeSocial.BackgroundColor3 = Styles.GitHub.BackGroundColor
						LargeSocial.UIStroke.Color = Styles.GitHub.StrokeColor
						LargeSocial.UIGradient.Color = Styles.GitHub.GradColor

						LargeSocial.DiscordTitle.Visible  = false
						LargeSocial.Visit.Visible = false

						LargeSocial.SocialName.Position = UDim2.new(0, 45,0, 25)
						LargeSocial.SocialName.Text = 'GitHub'
						LargeSocial.GitName.Visible = true
						LargeSocial.GitName.Text = '@'..social.Name
						LargeSocial.ImageLabel.Image = 'rbxassetid://86992377698608'
						LargeSocial.UIStroke.UIGradient:Destroy()
					elseif social.Style == 'Discord' then
						LargeSocial.BackgroundColor3 = Styles.Discord.BackGroundColor
						LargeSocial.UIStroke.Color = Styles.Discord.StrokeColor
						LargeSocial.UIGradient.Color = Styles.Discord.GradColor
						LargeSocial.ImageLabel.Image = 'rbxassetid://108012241529487'

						if not LargeSocial.UIStroke.UIGradient then
							local strokeGrad = Instance.new('UIGradient', LargeSocial.UIStroke)
							strokeGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(91, 125, 147))}
							strokeGrad.Rotation = -34
						else
							LargeSocial.UIStroke.UIGradient.Color =  ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(91, 125, 147))}
						end


						LargeSocial.DiscordTitle.Visible  = true
						LargeSocial.Visit.Visible = true
						LargeSocial.GitName.Visible = false
						LargeSocial.SocialName.Position = UDim2.new(0, 45,0, 30)
						LargeSocial.SocialName.Text = social.Name
						LargeSocial.Visit.Position = UDim2.new(1, -95,0.5, 0)
						LargeSocial.Visit.ImageLabel.Visible = true
					elseif social.Style == 'WebSite' then
						LargeSocial.BackgroundColor3 = Styles.Site.BackGroundColor
						LargeSocial.UIStroke.Color = Styles.Site.StrokeColor
						LargeSocial.UIGradient.Color = Styles.Site.GradColor
						LargeSocial.ImageLabel.Image = 'rbxassetid://74915074739925'

						LargeSocial.DiscordTitle.Visible  = false
						LargeSocial.Visit.Visible = true
						LargeSocial.GitName.Visible = false

						if not LargeSocial.UIStroke.UIGradient then
							local strokeGrad = Instance.new('UIGradient', LargeSocial.UIStroke)
							strokeGrad.Color = ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(181, 33, 225))}
							strokeGrad.Rotation = -25
						else
							LargeSocial.UIStroke.UIGradient.Color =  ColorSequence.new{ColorSequenceKeypoint.new(0.00, Color3.fromRGB(255, 255, 255)), ColorSequenceKeypoint.new(1.00, Color3.fromRGB(181, 33, 225))}
						end


						LargeSocial.SocialName.Text = social.Name
						LargeSocial.Visit.ImageLabel.Visible = false
						LargeSocial.Visit.TextColor3 = Color3.fromRGB(255, 255, 255)
						LargeSocial.Visit.Text = 'Visit site'
						LargeSocial.Visit.Position = UDim2.new(1, -80,0.5, 0)
					end
				end

				if social.Size == "Small" then
					LOADER.load.social.little.Visible = true
					local SmallSocial = LOADER.load.social.little.smallblock1:Clone()
					SmallSocial.Visible = true
					SmallSocial.Parent = LOADER.load.social.little

					if social.Style == "GitHub" then
						SmallSocial.BackgroundColor3 = Styles.GitHub.BackGroundColor
						SmallSocial.UIStroke.Color = Styles.GitHub.StrokeColor
						SmallSocial.UIGradient.Color = Styles.GitHub.GradColor

						SmallSocial.SocialName.Text = 'GitHub'
						SmallSocial.Text.Visible = true
						SmallSocial.Text.TextColor3 = Color3.fromRGB(90, 90, 90)
						SmallSocial.Text.Text = '@'..social.Name
						SmallSocial.ImageLabel.Image = 'rbxassetid://86992377698608'
					elseif social.Style == 'WebSite' then
						SmallSocial.BackgroundColor3 = Styles.Site.BackGroundColor
						SmallSocial.UIStroke.Color = Styles.Site.StrokeColor
						SmallSocial.UIGradient.Color = Styles.Site.GradColor

						SmallSocial.SocialName.Text = social.Name
						SmallSocial.Text.Visible = true
						SmallSocial.Text.TextColor3 = Color3.fromRGB(255, 255, 255)
						SmallSocial.Text.Text = 'Visit Site'
						SmallSocial.ImageLabel.Image = 'rbxassetid://74915074739925'
						SmallSocial.ImageLabel.ImageColor3 = Color3.fromRGB(231, 160, 255)
					end
				end

				if social.CopyToClip then
				end
			end

			local function updateSize()
				LOADER.load.Size = UDim2.new(LOADER.load.Size.X.Scale, LOADER.load.Size.X.Offset, 0,  LOADER.load.social.UIListLayout.AbsoluteContentSize.Y  + 235)
			end

			LOADER.load.social.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateSize)

			updateSize()

		else
			LoaderConfig.Socials = nil
		end

		if LoaderConfig.Socials == nil then
			LOADER.load.Size = UDim2.new(0, 400, 0, 250)
			LOADER.load.social.Visible = false
			TweenWorkPos = 200
			TweenWorkDisappear = 150
			TweenWorkAppear = 177
		end


		LOADER.load.logo.Image = LoaderConfig.Logo;
		syde.theme.Accent = Config.Accent;
		syde.theme.HitBox = Config.HitBox;
		LOADER.load.info.build.Text = syde.Build

		if LoaderConfig.Status == false then
			LOADER.load.logo.stroke.UIStroke.Color = Color3.fromRGB(24, 24, 24)
			LOADER.load.logo["Title/Status"].Text = 'Jannis Hub'
		end

		local statusColors = {
			Stable = { Color = Color3.fromRGB(25, 229, 22), Text = '<font color="#24bf48">Stable</font>' },
			Unstable = { Color = Color3.fromRGB(227, 229, 81), Text = '<font color="#e3e551">Unstable</font>' },
			Detected = { Color = Color3.fromRGB(229, 44, 47), Text = '<font color="#e52c2f">Detected</font>' },
			Patched = { Color = Color3.fromRGB(229, 44, 47), Text = '<font color="#e52c2f">Patched</font>' }
		}

		local statusData = statusColors[LoaderConfig.Status]
		if statusData then
			LOADER.load.logo.stroke.UIStroke.Color = statusData.Color
			LOADER.load.logo["Title/Status"].Text = string.format('%s  <font color="#363636">•</font>  %s', LoaderConfig.Name, statusData.Text)
		end

		local function initLoader()
			tweenservice:Create( LOADER.load.Salt, TweenInfo.new(0.65, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 25,0, 25)}):Play()
			tweenservice:Create( LOADER.load.Salt, TweenInfo.new(0.65, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
		end

		local function TweenWorkLabel(Finish, icon, Text)
			LOADER.load.work.Position = UDim2.new(0.5, 0,1, -40)
			LOADER.load.work.Text = Text
			LOADER.load.work.ImageLabel.Image = icon
			tweenservice:Create( LOADER.load.work, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
			tweenservice:Create( LOADER.load.work.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { ImageTransparency = 0 }):Play()
			tweenservice:Create( LOADER.load.work, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Position = UDim2.new(0.5, 0,1, -73) }):Play()
			--	tweenservice:Create(game.Workspace.Camera, TweenInfo.new(1, Enum.EasingStyle.Exponential), { FieldOfView  = game.Workspace.Camera.FieldOfView - 3 }):Play()
			task.wait(Finish)
			tweenservice:Create( LOADER.load.work, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
			tweenservice:Create( LOADER.load.work.ImageLabel, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()
			tweenservice:Create( LOADER.load.work, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Position = UDim2.new(0.5, 0,1, -100) }):Play()
			task.wait(0.6)

			-- reset

		end

		local function load()
			TweenWorkLabel(1,'rbxassetid://136002400178503', 'Securing UI...')
			TweenWorkLabel(1,'rbxassetid://126745165401124', 'Loading Files..')
			TweenWorkLabel(1,'rbxassetid://108012241529487', 'Checking For Discord...')
			TweenWorkLabel(1,'rbxassetid://136405833725573', 'Loading UI...')
			task.wait(1)
			tweenservice:Create( LOADER.load.Salt, TweenInfo.new(0.65, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 146,0, 25)}):Play()
			tweenservice:Create( LOADER.load.Salt.ImageLabel, TweenInfo.new(0.65, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
		end

		local TimeTillLoad = 1.5

		while TimeTillLoad > 0 do
			LOADER.load.info.TimeTill.Text = string.format("%.2f", TimeTillLoad) 
			task.wait(0.01) 
			TimeTillLoad -= 0.01 
		end

		LOADER.load.info.TimeTill.Text = '0.00'

		task.wait(TimeTillLoad)

		initLoader()
		task.wait(0.08)
		load()

		task.wait(2)

		--Library.Enabled = true

		LOADER:Destroy()

	end

end

-- [UI SETUP]
local UI = Library
local WINDOW = UI.lib
local TOPBAR = WINDOW.Top
local TABS = WINDOW.Tab.ScrollingFrame
local PAGES = WINDOW.Pages
local settingsOpen = false
local UIClosed = false
local UIToggle = Enum.KeyCode.End
UI.Parent = coregui

function CloseUI()
	PAGES.Visible = false
	WINDOW.Tab.Visible = false
	UIClosed = true
	tweenservice:Create(WINDOW, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1 }):Play()
	tweenservice:Create(WINDOW, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Size = UDim2.new(WINDOW.Size.X.Scale, WINDOW.Size.X.Offset, WINDOW.Size.Y.Scale, 200) }):Play()
	tweenservice:Create(WINDOW.Top.div, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.Title, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.Title.Sub, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Shadow.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.resize, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Mini.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Close.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Plugin.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Settings.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.expand, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Plugin, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Settings, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Frame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1 }):Play()
	task.wait(0.8)
	if UIClosed == true then
		syde:Notify({
			Title = 'UI Is Closed',
			Content = 'Use '.. UIToggle.Name ..' To Open Back.'
		})
	end

	WINDOW.Visible = false

end

function OpenUI()
	PAGES.Visible = true
	WINDOW.Tab.Visible = true
	WINDOW.Visible = true
	UIClosed = false
	tweenservice:Create(WINDOW, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0 }):Play()
	tweenservice:Create(WINDOW, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {Size = UDim2.new(WINDOW.Size.X.Scale, WINDOW.Size.X.Offset, WINDOW.Size.Y.Scale, 575) }):Play()
	tweenservice:Create(WINDOW.Top.div, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.7 }):Play()
	tweenservice:Create(WINDOW.Top.Title, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 0 }):Play()
	tweenservice:Create(WINDOW.Top.Title.Sub, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextTransparency = 0 }):Play()
	tweenservice:Create(WINDOW.Shadow.ImageLabel, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.5 }):Play()
	tweenservice:Create(WINDOW.resize, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Mini.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Close.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Plugin.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.7 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Settings.interact, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.7 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.expand, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Plugin, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.05 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Util.Settings, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0.05 }):Play()
	tweenservice:Create(WINDOW.Top.UHolder.Frame, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0 }):Play()
end

local BOUNCE = false

function ToggleUI()
	if BOUNCE then return end
	BOUNCE = true

	if UIClosed then
		OpenUI()
	else
		CloseUI()
	end

	task.delay(1, function()
		BOUNCE = false
	end)
end

-- [Remove PlaceHolders]
syde:HidePlaceHolder(TABS, 'Tb')
syde:HidePlaceHolder(PAGES, 'Page')


	--[[
           __|  __| __ __| __ __| _ _|   \ |   __|   __|
         \__ \  _|     |      |     |   .  |  (_ | \__ \
         ____/ ___|   _|     _|   ___| _|\_| \___| ____/						
	]]
do
	local SettingsElements = {
		Connections = {};
		Comms = Instance.new('BindableEvent');
	}

	function SettingsElements:AddConnection(Type, Callback)
		if typeof(Type) ~= "RBXScriptSignal" then
			error("[AddConnection] Invalid Type: Expected RBXScriptSignal, got " .. typeof(Type))
		end
		if typeof(Callback) ~= "function" then
			error("[AddConnection] Invalid Callback: Expected function, got " .. typeof(Callback))
		end

		local Connection = Type:Connect(Callback)
		local ConnectionData = { Connection = Connection }

		SettingsElements.Connections = SettingsElements.Connections or {}
		table.insert(SettingsElements.Connections, ConnectionData)

		local function Disconnect()
			if Connection.Connected then
				Connection:Disconnect()
			end

			for i = #SettingsElements.Connections, 1, -1 do
				if SettingsElements.Connections[i] == ConnectionData then
					table.remove(SettingsElements.Connections, i)
					break
				end
			end
		end

		task.spawn(function()
			task.wait(10)
			for i = #SettingsElements.Connections, 1, -1 do
				if not SettingsElements.Connections[i].Connection.Connected then
					table.remove(SettingsElements.Connections, i)
				end
			end
		end)

		return Connection, Disconnect
	end

	function SettingsElements:GetSettingsElements()
		local element = {}

		function element:CreateButton(Button, Parent)
			local ButtonData = {
				Title = Button.Title or "Temp Button";
				CallBack = Button.CallBack;
				Desc = Button.Description or "";
				Type = Button.Type or 'Default';
				HoldTime = Button.HoldTime or 3;
			}

			local button = Library.Settings.Button:Clone()
			button.Visible = true
			button.Parent = Parent
			button.Title.Text = Button.Title
			button.Name = ButtonData.Title
			button.Title.Size = UDim2.new(0, button.Title.TextBounds.X + 15,0, 35)


			local fOTween = TweenInfo.new(0.7, Enum.EasingStyle.Exponential)
			local fITween = TweenInfo.new(0.7, Enum.EasingStyle.Exponential)

			if ButtonData.Type == 'Default' then
				-- UI Stroke effect on button press

				button.interact.MouseButton1Down:Connect(function()
					tweenservice:Create(button.UIStroke, fOTween, { Transparency = 1 }):Play()
					tweenservice:Create(button.ImageLabel, fOTween, { ImageTransparency = 1 }):Play()
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()
				end)

				button.interact.MouseButton1Up:Connect(function()
					tweenservice:Create(button.UIStroke, fITween, { Transparency = 0 }):Play()
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 0.95 }):Play()


				end)

				button.interact.MouseButton1Click:Connect(function()
					if ButtonData.CallBack then
						local success, errorMsg = pcall(ButtonData.CallBack)
						if not success then
							warn("[CALLBACK ERROR]:", errorMsg)
						end
					else
						warn("[CALLBACK MISSING]: No Function Assigned To", ButtonData.Title)
					end
				end)

				-- Extra Check 
				button.interact.MouseLeave:Connect(function()
					tweenservice:Create(button.UIStroke, fITween, { Transparency = 0 }):Play()
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 0.95 }):Play()
				end)
			elseif ButtonData.Type == 'Hold' then
				local HoldTime = ButtonData.HoldTime
				local Holding = false
				local TimeLeft = HoldTime
				local Complete = false

				button.ImageLabel.Image = 'rbxassetid://127075195365098'
				button.ImageLabel.Rotation = 0
				button.ImageLabel.Size = UDim2.new(0, 16,0, 16)
				button.ImageLabel.Position = UDim2.new(1, -41,0.5, 0)

				local function CancelOperation()
					Holding = false
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 0.95 }):Play()
					tweenservice:Create(button.Title.Timer, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
					if not Complete then
						tweenservice:Create(button.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 1 }):Play()
						tweenservice:Create(button.UIStroke.UIGradient, TweenInfo.new(1, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) }):Play()
						tweenservice:Create(button, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { Position = UDim2.new(0 ,-15 ,0 ,button.Position.Y.Offset) }):Play()
						task.wait(0.15)
						tweenservice:Create(button, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { Position = UDim2.new(0 ,30 ,0 ,button.Position.Y.Offset) }):Play()
						task.wait(0.15)
						tweenservice:Create(button, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { Position = UDim2.new(0 ,0 ,0 ,button.Position.Y.Offset) }):Play()
						task.wait(1)
						tweenservice:Create(button.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 0 }):Play()
					end

					-- did not complete 

					--	button.UIStroke.UIGradient.Offset = Vector2.new(-1, 0)
					--	tweenservice:Create(button.UIStroke, TweenInfo.new(HoldTime, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) }):Play()

					-- Restore the timer value
					TimeLeft = HoldTime
					button.Title.Timer.Text = tostring(HoldTime)
					task.wait(0.1)
					Complete = false
				end

				button.interact.MouseButton1Down:Connect(function()

					Holding = true
					TimeLeft = HoldTime
					button.Title.Timer.Text = tostring(TimeLeft)
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()
					tweenservice:Create(button.Title.Timer, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
					tweenservice:Create(button.UIStroke.UIGradient, TweenInfo.new(HoldTime, Enum.EasingStyle.Linear), { Offset = Vector2.new(0.7, 0) }):Play()
					tweenservice:Create(button.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 0}):Play()

					-- Countdown loop
					while Holding and TimeLeft > 0 do
						TimeLeft = math.max(0, TimeLeft - runservice.Heartbeat:Wait()) -- Ensures it doesn't go below 0
						button.Title.Timer.Text = string.format("%.1f", TimeLeft) -- Always shows at least 0.0

					end

					if TimeLeft <= 0 then
						Complete = true
						if ButtonData.CallBack then
							local success, errorMsg = pcall(ButtonData.CallBack)
							if not success then
								warn("[CALLBACK ERROR]:", errorMsg)
							end
						else
							warn("[CALLBACK MISSING]: No Function Assigned To", ButtonData.Title)
						end
						tweenservice:Create(button, TweenInfo.new(0.34, Enum.EasingStyle.Exponential), { BackgroundColor3 = Color3.fromRGB(24, 24, 24) }):Play()
						tweenservice:Create(button.UIStroke.UIGradient, TweenInfo.new(0.1, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) }):Play()
						task.wait(0.34)
						tweenservice:Create(button, TweenInfo.new(0.34, Enum.EasingStyle.Exponential), { BackgroundColor3 = Color3.fromRGB(17, 17, 17) }):Play()
					end
				end)

				button.interact.MouseButton1Up:Connect(function()
					CancelOperation()
				end)

				button.interact.MouseLeave:Connect(function()
					if Holding then
						CancelOperation()
					end
				end)
			end

			--[DESC]
			local descLabel = button:FindFirstChild("Desc")

			if descLabel then
				if ButtonData.Desc and ButtonData.Desc ~= "" then
					descLabel.Text = ButtonData.Desc
					descLabel.Visible = true
					descLabel.TextWrapped = true

					local function updateSize()
						local textSize = textservice:GetTextSize(
							descLabel.Text,
							descLabel.TextSize,
							descLabel.Font,
							Vector2.new(descLabel.AbsoluteSize.X, math.huge) -- Allows vertical expansion
						)

						local newDescSize = UDim2.new(1, -150, 0, textSize.Y)
						local newButtonSize = UDim2.new(button.Size.X.Scale, button.Size.X.Offset, 0, button.Title.Size.Y.Offset + textSize.Y + 5) -- Adding extra padding

						local descTween = tweenservice:Create(descLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newDescSize })
						descTween:Play()

						local buttonTween = tweenservice:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newButtonSize })
						buttonTween:Play()
					end

					updateSize()

					descLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
				else
					descLabel.Visible = false
				end
			end


		end

		---

		function element:ColorPicker(ColorPicker, Parent)
			local ColorPickerData = {
				Title = ColorPicker.Title;
				Color = ColorPicker.Color;
				Linkable = ColorPicker.Linkable;
				CallBack = ColorPicker.CallBack;
			}

			ColorPicker.Linkable = ColorPicker.Linkable or true

			local colorpicker = Library.Settings.ColorPicker:Clone()
			colorpicker.Visible = true
			colorpicker.Parent = Parent
			colorpicker.Title.Text = ColorPickerData.Title
			colorpicker.Name = ColorPickerData.Title

			local isLinkable = Instance.new("BoolValue")
			isLinkable.Name = 'isLinkable'
			isLinkable.Value = ColorPickerData.Linkable
			isLinkable.Parent = colorpicker

			local HueSat = Instance.new("Color3Value")
			HueSat.Name = 'HueSat'
			HueSat.Value = ColorPickerData.Color
			HueSat.Parent = colorpicker

			local Open = false
			local DeBounce = false
			local State = false

			colorpicker.color.Values.Hue.BackgroundTransparency = 1
			colorpicker.color.Values.Hue.Pin.BackgroundTransparency = 1
			colorpicker.color.Values.Hue.Pin.UIStroke.Transparency = 1
			colorpicker.color.Values.Rainbow.ImageTransparency = 1

			colorpicker.color.SVPicker.Pin.BackgroundTransparency = 1
			colorpicker.color.SVPicker.Pin.UIStroke.Transparency = 1
			colorpicker.color.SVPicker.Brightness.BackgroundTransparency = 1
			colorpicker.color.SVPicker.Saturation.BackgroundTransparency = 1

			colorpicker.HueValues.HEX.BackgroundTransparency = 1
			colorpicker.HueValues.HEX.UIStroke.Transparency = 1
			colorpicker.HueValues.HEX.V.HEXBox.TextTransparency = 1
			colorpicker.HueValues.HEX.Link.ImageTransparency = 1
			colorpicker.HueValues.HEX.Copy.ImageTransparency = 1

			colorpicker.HueValues.RGB.BackgroundTransparency = 1
			colorpicker.HueValues.RGB.UIStroke.Transparency = 1
			colorpicker.HueValues.RGB.V.RGBBox.TextTransparency = 1
			colorpicker.HueValues.RGB.Copy.ImageTransparency = 1
			colorpicker.QuickClose.Interactable = false

			local recentContainer = colorpicker.color.Recent
			local spacing = 5 -- Space between elements
			local frameSize = 12 -- Assumed size of each color frame

			-- Function to update recent color layout manually
			local function updateRecentLayout()
				local children = {} -- Store frames
				for _, child in pairs(recentContainer:GetChildren()) do
					if child:IsA("Frame") then
						table.insert(children, child)
					end
				end

				-- Sort based on order of appearance
				table.sort(children, function(a, b)
					return a.LayoutOrder > b.LayoutOrder -- Newest first
				end)

				-- Calculate total width needed
				local totalWidth = #children * frameSize + math.max(#children - 1, 0) * spacing
				local startX = recentContainer.AbsoluteSize.X - totalWidth -- Start at the right

				for _, frame in ipairs(children) do
					--	frame.Position = UDim2.new(0, startX, 0.5, -frame.Size.Y.Offset / 2)
					tweenservice:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(0, startX , 0.8, -frame.Size.Y.Offset / 2) }):Play()
					startX += frameSize + spacing
				end
			end

			-- Hook into child added/removed events
			recentContainer.ChildAdded:Connect(function(child)
				if child:IsA("Frame") then
					child.LayoutOrder = os.time() -- Ensure new frames have the latest order
					updateRecentLayout()
				end
			end)
			recentContainer.ChildRemoved:Connect(updateRecentLayout)
			updateRecentLayout()

			local function OpenPicker()
				Open = true
				DeBounce = true
				colorpicker.color.Values.Visible = true
				colorpicker.color.SVPicker.Visible = true
				colorpicker.HueValues.Visible = true
				colorpicker.color.Recent.Visible = true

				colorpicker.interact.Interactable = false
				colorpicker.QuickClose.Interactable = true

				tweenservice:Create(colorpicker.color, TweenInfo.new( 0.95, Enum.EasingStyle.Quart ), { Size = UDim2.new(0, 1,0, 1) }):Play()
				tweenservice:Create(colorpicker, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(35, 35, 35) }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.6, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				task.wait(0.12)
				tweenservice:Create(colorpicker.color, TweenInfo.new( 0.9, Enum.EasingStyle.Quart ), { Size = UDim2.new(1, -200,0, 120) }):Play()
				tweenservice:Create(colorpicker, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(18, 18, 18) }):Play()
				tweenservice:Create(colorpicker, TweenInfo.new( 0.8, Enum.EasingStyle.Quart ), { Size = UDim2.new(1, -40,0, 180) }):Play()
				tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new( 1, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()
				task.wait(0.6)

				tweenservice:Create(colorpicker.color.SVPicker.Brightness, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Saturation, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin.UIStroke, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { Transparency = 0.58 }):Play()

				task.wait(0.5)
				tweenservice:Create(colorpicker.color.Values.Hue, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 0.58 }):Play()

				tweenservice:Create(colorpicker.HueValues.HEX, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0.9 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 0.4 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.V.HEXBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()

				task.wait(0.09)
				tweenservice:Create(colorpicker.HueValues.RGB, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0.9 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 0.4 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.V.RGBBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()

				for _,v in ipairs(colorpicker.color.Recent:GetChildren()) do
					if v:IsA('Frame') then
						task.wait(0.1)
						tweenservice:Create(v, TweenInfo.new( 0.3, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
					end
				end

				task.wait(0.7)
				DeBounce = false
			end

			local function ClosePicker()
				Open = false
				DeBounce = true
				tweenservice:Create(colorpicker, TweenInfo.new( 0.85, Enum.EasingStyle.Quint ), { Size = UDim2.new(1, -40,0, 40) }):Play()
				tweenservice:Create(colorpicker.color, TweenInfo.new( 0.85, Enum.EasingStyle.Quint ), { Size = UDim2.new(0, 20,0, 20) }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.6, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				colorpicker.interact.Interactable = true
				colorpicker.QuickClose.Interactable = false

				--	task.wait(0.6)

				tweenservice:Create(colorpicker.color.SVPicker.Brightness, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Saturation, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin, TweenInfo.new( 1, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin.UIStroke, TweenInfo.new( 0.4, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin, TweenInfo.new( 1, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin.UIStroke, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()

				tweenservice:Create(colorpicker.HueValues.RGB, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.V.RGBBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()

				task.wait(0.1)

				tweenservice:Create(colorpicker.HueValues.HEX, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.V.HEXBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()
				for _,v in ipairs(colorpicker.color.Recent:GetChildren()) do
					if v:IsA('Frame') then
						tweenservice:Create(v, TweenInfo.new( 0.6, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
					end
				end
				task.wait(1)
				colorpicker.color.SVPicker.Visible = false
				colorpicker.color.Recent.Visible = false
				task.wait(0.7)
				DeBounce = false
			end

			colorpicker.interact.MouseButton1Click:Connect(function()
				if DeBounce then return end
				if not Open then
					Open = true
					OpenPicker()
				end
			end)

			colorpicker.QuickClose.MouseButton1Click:Connect(function()
				if DeBounce then return end
				if Open then
					Open = false
					ClosePicker()
				end
			end)

			colorpicker.QuickClose.MouseEnter:Connect(function()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Quint ), { Size = UDim2.new(0, 70,0, 3) }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }):Play()
			end)

			colorpicker.QuickClose.MouseLeave:Connect(function()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Quint ), { Size = UDim2.new(0, 60,0, 3) }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(33, 33, 33) }):Play()
			end)

			local HSV

			if ColorPickerData.Color then
				HSV = { ColorPickerData.Color:ToHSV() }
			else

				HSV = { 0, 0, 0 }
			end
			local Selected = ColorPickerData.Color
			local HueValue = HSV[1]

			local function TableToColor(Table)
				if type(Table) ~= "table" then return Table end
				return Color3.fromHSV(Table[1],Table[2],Table[3])
			end

			local function FormatColor(Color, format, precision)

				format = format or "RGB"
				precision = precision or 2

				local formattedColor = ""

				if format == "RGB" then
					return	math.round(Color.R * 255) .. "," .. math.round(Color.G * 255) .. "," .. math.round(Color.B * 255)
				elseif format == "Hex" then
					formattedColor = string.format("#%02X%02X%02X",
						math.round(Color.R * 255),
						math.round(Color.G * 255),
						math.round(Color.B * 255)
					)

					return formattedColor
				end
			end

			local SVPicker = colorpicker.color.SVPicker
			local HUESlider = colorpicker.color.Values.Hue

			SVPicker.Pin.BackgroundColor3 = ColorPickerData.Color
			HUESlider.Pin.BackgroundColor3 = ColorPickerData.Color

			local function updatestuff()
				ColorPickerData.Color = TableToColor(HSV)
				colorpicker.color.BackgroundColor3 = ColorPickerData.Color
				colorpicker.color.glow.ImageColor3 = ColorPickerData.Color

				colorpicker.color.BackgroundColor3 = Color3.fromHSV(HSV[1], 1, 1)
				local newColor = Color3.fromHSV(HSV[1], HSV[2], HSV[3])
				local newColor2 = Color3.fromHSV(HSV[1], 1, 1)

				HueSat.Value = ColorPickerData.Color

				tweenservice:Create(HUESlider.Pin, TweenInfo.new(0.1, Enum.EasingStyle.Exponential), {BackgroundColor3 = newColor2}):Play()
				tweenservice:Create(SVPicker.Pin, TweenInfo.new(0.1, Enum.EasingStyle.Exponential), {BackgroundColor3 = newColor}):Play()


				tweenservice:Create(SVPicker.Pin, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(HSV[2], 0, 1 - HSV[3], 0)
				}):Play()

				tweenservice:Create(HUESlider.Pin, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(1 - HSV[1], 0, 0.5, 0)
				}):Play()

				local formattedHex = FormatColor(ColorPickerData.Color, 'Hex')
				colorpicker.HueValues.HEX.V.HEXBox.PlaceholderText = formattedHex

				local formattedRGB = FormatColor(ColorPickerData.Color,'RGB', 2)
				colorpicker.HueValues.RGB.V.RGBBox.PlaceholderText = formattedRGB

				if ColorPickerData.CallBack then
					ColorPickerData.CallBack(ColorPickerData.Color)
				end
			end
			updatestuff()

			local function AddRecentColor(newColor)
				local recentFrame = colorpicker.colorPlaceHolder:Clone()
				recentFrame.Visible = true
				recentFrame.Parent = colorpicker.color.Recent
				recentFrame.BackgroundColor3 = newColor

				recentFrame.interact.MouseButton1Click:Connect(function()
				--[[	tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Size = UDim2.new(0, 5,0, 5) }):Play()
					task.wait(0.09)
					tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Size = UDim2.new(0, 12,0, 12) }):Play() ]]

					local h, s, v = newColor:ToHSV()
					if s > 0.02 then
						HSV[1] = h
					end
					HSV[2] = s
					HSV[3] = v
					updatestuff()

				end)

				recentFrame.interact.MouseEnter:Connect(function()
					tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 20,0, 20) }):Play()
				end)

				recentFrame.interact.MouseLeave:Connect(function()
					tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 12,0, 12) }):Play()
				end)

				local maxRecentColors = 10
				local recentContainer = colorpicker.color.Recent

				-- Iterate through children and remove only the first Frame when over limit
				local children = recentContainer:GetChildren()
				if #children > maxRecentColors then
					for _, child in ipairs(children) do
						if child:IsA("Frame") then
							child:Destroy()
							break -- Ensure only one frame is deleted at a time
						end
					end
				end
			end

			local SV, HUE = nil, nil

			SettingsElements:AddConnection(SVPicker.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					SV = runservice.RenderStepped:Connect(function()
						local mouse = game.Players.LocalPlayer:GetMouse()
						local ColorX = math.clamp(mouse.X - SVPicker.AbsolutePosition.X, 0, SVPicker.AbsoluteSize.X) / SVPicker.AbsoluteSize.X
						local ColorY = math.clamp(mouse.Y - SVPicker.AbsolutePosition.Y, 0, SVPicker.AbsoluteSize.Y) / SVPicker.AbsoluteSize.Y

						HSV[2] = ColorX
						HSV[3] = 1 - ColorY

						updatestuff()
					end)
				end
			end)

			SettingsElements:AddConnection(SVPicker.InputEnded, function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 and SV then
					SV:Disconnect()
					SV = nil
					AddRecentColor(ColorPickerData.Color)
				end
			end)

			SettingsElements:AddConnection(HUESlider.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					HUE = runservice.RenderStepped:Connect(function()
						local mouse = game.Players.LocalPlayer:GetMouse()
						local ColorX = math.clamp(mouse.X - HUESlider.AbsolutePosition.X, 0, HUESlider.AbsoluteSize.X) / HUESlider.AbsoluteSize.X

						HSV[1] = 1 - ColorX

						updatestuff()
					end)
				end
			end)

			SettingsElements:AddConnection(HUESlider.InputEnded, function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 and HUE then
					HUE:Disconnect()
					HUE = nil
					AddRecentColor(ColorPickerData.Color)
				end
			end)

			colorpicker.HueValues.HEX.V.HEXBox.FocusLost:Connect(function(Enter)
				if not Enter then return end

				local hexInput = colorpicker.HueValues.HEX.V.HEXBox.Text

				local success, result = pcall(function()
					return Color3.fromHex(hexInput)
				end)

				if success then
					local Hue, Saturation, Value = result:ToHSV()
					colorpicker.HueValues.HEX.V.HEXBox.Text = ''
					if Saturation > 0.02 then
						HSV[1] = Hue
					end
					HSV[2] = Saturation
					HSV[3] = Value
					updatestuff()
				else
					warn("Failed to convert hex to color:", result)
				end
			end)

			colorpicker.HueValues.RGB.V.RGBBox.FocusLost:Connect(function(Enter)
				if not Enter then return end

				local rgbInput = colorpicker.HueValues.RGB.V.RGBBox.Text

				local r, g, b = rgbInput:match("^(%d+),%s*(%d+),%s*(%d+)$")

				if r and g and b then

					r, g, b = tonumber(r), tonumber(g), tonumber(b)

					if r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
						local color = Color3.fromRGB(r, g, b)

						local Hue, Saturation, Value = color:ToHSV()
						if Saturation > 0.02 then
							HSV[1] = Hue
						end
						HSV[2] = Saturation
						HSV[3] = Value

						colorpicker.HueValues.RGB.V.RGBBox.Text = ''
						updatestuff()
					else
						warn("RGB values must be between 0 and 255.")
					end
				else
					warn("Invalid RGB format. Please use the format 'R,G,B' (e.g., 16,16,16).")
				end
			end)

			local UserInputService = game:GetService("UserInputService")
			local TweenService = game:GetService("TweenService")
			local RunService = game:GetService("RunService")

			local linkDragging = false
			local originalPosition = UDim2.new(1, -10, 0.5, 0)
			local draggedColorPicker = nil

			local function isMouseOver(guiObject)
				local mouse = game.Players.LocalPlayer:GetMouse()
				local pos = guiObject.AbsolutePosition
				local size = guiObject.AbsoluteSize
				return mouse.X >= pos.X and mouse.X <= pos.X + size.X and mouse.Y >= pos.Y and mouse.Y <= pos.Y + size.Y
			end

			colorpicker.HueValues.HEX.Link.MouseButton1Down:Connect(function()
				linkDragging = true
				draggedColorPicker = colorpicker

				TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {Size = UDim2.new(0, 20,0, 20)}):Play()

				local followMouse
				followMouse = RunService.RenderStepped:Connect(function()
					if not linkDragging then
						followMouse:Disconnect()
						return
					end
					local mouse = game.Players.LocalPlayer:GetMouse()
					colorpicker.HueValues.HEX.Link.Position = UDim2.new(0, mouse.X - colorpicker.AbsolutePosition.X - 10, 0, mouse.Y - colorpicker.AbsolutePosition.Y - 100)

					for _, otherPicker in pairs(Parent:GetChildren()) do
						if otherPicker:IsA("Frame") and otherPicker:FindFirstChild("isLinkable") and otherPicker.isLinkable.Value then
							if isMouseOver(otherPicker) and otherPicker ~= draggedColorPicker then
								TweenService:Create(otherPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
							else
								TweenService:Create(otherPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
							end
						end
					end
				end)
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and linkDragging then
					linkDragging = false
					local foundTarget = false

					for _, otherPicker in pairs(Parent:GetChildren()) do
						if otherPicker:IsA("Frame") and otherPicker:FindFirstChild("isLinkable") and otherPicker.isLinkable.Value then
							if isMouseOver(otherPicker) and otherPicker ~= draggedColorPicker then
								otherPicker.HueSat.Value = draggedColorPicker.HueSat.Value
								updatestuff() 
								foundTarget = true
								TweenService:Create(
									colorpicker.HueValues.HEX.Link,
									TweenInfo.new(0.3, Enum.EasingStyle.Quint),
									{ Position = originalPosition }
								):Play()

								TweenService:Create(otherPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
								TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {ImageColor3 = Color3.fromRGB(66, 66, 66)}):Play()
								TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {Size = UDim2.new(0, 15,0, 15)}):Play()
								break
							end
						end
					end

					if not foundTarget then
						TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {ImageColor3 = Color3.fromRGB(66, 66, 66)}):Play()
						TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {Size = UDim2.new(0, 15,0, 15)}):Play()
						TweenService:Create(
							colorpicker.HueValues.HEX.Link,
							TweenInfo.new(0.3, Enum.EasingStyle.Quint),
							{ Position = originalPosition }
						):Play()
					end
				end
			end)

			local function updateColorPicker()
				local Hue, Saturation, Value = HueSat.Value:ToHSV()

				if Saturation > 0.02 then
					HSV[1] = Hue
				end
				HSV[2] = Saturation
				HSV[3] = Value

				updatestuff()
			end

			HueSat.Changed:Connect(updateColorPicker)

			local hueIncrement = 0.005 

			local function RainbowEffect()
				HueValue = (HueValue + hueIncrement) % 1
				HSV[1] = HueValue

				updatestuff()
			end

			local isRainbowEnabled = false
			local huerender = nil

			local function ToggleRainbowEffect()
				isRainbowEnabled = not isRainbowEnabled
				if isRainbowEnabled then
					if not huerender then
						huerender = runservice.RenderStepped:Connect(RainbowEffect)
						tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new(0.5, Enum.EasingStyle.Exponential ), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end
				else
					if huerender then
						huerender:Disconnect()
						tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new(0.5, Enum.EasingStyle.Exponential ), {ImageColor3 = Color3.fromRGB(62, 62, 62)}):Play()
						huerender = nil
					end
				end
			end

			colorpicker.color.Values.Rainbow.MouseButton1Click:Connect(ToggleRainbowEffect)

		end

		---

		function element:Section(Title, Parent, Icon)
			local SectionData = {
				Title = Title
			}

			local Section =  Library.Settings.Section:Clone()
			Section.Visible = true
			Section.Title.Text = Title
			Section.Parent = Parent
			Section.Title.Position = UDim2.new(0, 0,0, 0)

			if Icon then
				Section.icon.Image = 'rbxassetid://'..Icon
				Section.Title.Position = UDim2.new(0, 25,0, 0)
			else
				Section.icon.Visible = false
			end
		end

		function element:Paragraph(Paragraph, Parent)
			local ParaData = {
				Title = Paragraph.Title;
				Content = Paragraph.Content;
			}

			local Para = Library.Settings.Paragraph:Clone()
			Para.Visible = true
			Para.Parent = Parent
			Para.Title.Text = ParaData.Title
			Para.Content.Text = ParaData.Content

			Para.Content.Size = UDim2.new(1, -20, 0, Para.Content.TextBounds.Y)
			Para.Size = UDim2.new(1, -15, 0, Para.Content.Size.Y.Offset + 45)

			local function updateSize()
				local textSize = textservice:GetTextSize(
					Para.Content.Text,
					Para.Content.TextSize,
					Para.Content.Font,
					Vector2.new(Para.Content.AbsoluteSize.X, math.huge) -- Allows vertical expansion
				)

				local newDescSize = UDim2.new(1, -20, 0, textSize.Y)
				local newButtonSize = UDim2.new(Para.Size.X.Scale, Para.Size.X.Offset, 0, textSize.Y + 40) -- Adding extra padding

				local descTween = tweenservice:Create(Para.Content, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newDescSize })
				descTween:Play()

				local buttonTween = tweenservice:Create(Para, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newButtonSize })
				buttonTween:Play()
			end

			updateSize()

			Para.Content:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)

			local ParagraphSettings = {}

			function ParagraphSettings:Set(text)
				Para.Content.Text = text
			end

			ParagraphSettings.Instance = Para

			return ParagraphSettings

		end

		function element:CreateSlider(Slider, Parent)
			local SliderData = {
				Title = Slider.Title;
				Desc = Slider.Description;
				Sliders = Slider.Sliders
			}

			local slider = Library.Settings.Slider:Clone()
			slider.Visible = true
			slider.Parent = Parent
			slider.Title.Text = SliderData.Title
			slider.Name = SliderData.Title
			slider.slideholder.slider.Visible = false


			--[SLIDERS INITIALIZE]
			for _, Options in ipairs(SliderData.Sliders) do
				local Slider =  Library.Settings.Slider.slideholder.slider:Clone()

				Options = {
					Title = Options.Title or "Slider";
					Increment = Options.Increment or 1;
					Range = Options.Range or {0, 100};
					StarterValue = Options.StarterValue or 16;
					CallBack = Options.CallBack;
				}

				Slider.Name = Options.Title
				Slider.Title.Text = Options.Title

				local dragging = false
				Slider.Visible = true
				Slider.Parent = slider.slideholder

				local SliderPosition
				if Options.StarterValue <= Options.Range[1] then
					SliderPosition = 0
				elseif Options.StarterValue >= Options.Range[2] then
					SliderPosition = 1
				else
					local range = Options.Range[2] - Options.Range[1]
					SliderPosition = (Options.StarterValue - Options.Range[1]) / range
				end


				Slider.slide.slideframe:TweenSize(UDim2.new(SliderPosition, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, true)

				local decimalPlaces = tostring(Options.Increment):match("%.([^0]*)") and #tostring(Options.Increment):match("%.([^0]*)") or 0
				Slider.v.Text = string.format("<font size='14'>%." .. decimalPlaces .. "f</font><font color='#434343'>/%." .. decimalPlaces .. "f</font>", Options.StarterValue, Options.Range[2])


				local function UpdateSlider(x)
					if dragging then
						local sliderStart = Slider.slide.AbsolutePosition.X
						local sliderWidth = Slider.slide.AbsoluteSize.X
						local sliderPosition = (x - sliderStart) / sliderWidth
						sliderPosition = math.clamp(sliderPosition, 0, 1)

						local range = Options.Range[2] - Options.Range[1]
						local newValue = Options.Range[1] + sliderPosition * range
						newValue = math.floor((newValue - Options.Range[1]) / Options.Increment + 0.5) * Options.Increment + Options.Range[1]

						-- Update the slider visual position
						local snapPosition = (newValue - Options.Range[1]) / range
						Slider.slide.slideframe:TweenSize(UDim2.new(snapPosition, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.55, true)


						-- Update the displayed value
						local decimalPlaces = tostring(Options.Increment):match("%.([^0]*)") and #tostring(Options.Increment):match("%.([^0]*)") or 0
						Slider.v.Text = string.format("<font size='14'>%." .. decimalPlaces .. "f</font><font color='#434343'>/%." .. decimalPlaces .. "f</font>", newValue, Options.Range[2])


						tweenservice:Create(Slider.Title, TweenInfo.new(0.55, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

						local success, errorMsg = pcall(function()
							Options.CallBack(newValue)
						end)
						if not success then
							warn("[CALLBACK ERROR][" .. Slider.Name .. "]: " .. tostring(errorMsg))
						end
					end
				end

				Slider.slide.Interact.MouseButton1Down:Connect(function()
					dragging = true
				end)

				Slider.slide.Interact.MouseButton1Up:Connect(function()
					dragging = false
				end)

				SettingsElements:AddConnection(userinput.InputEnded, function(input, processed)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
						tweenservice:Create(Slider.Title, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { TextTransparency = 0.6 }):Play()
					end
				end)

				SettingsElements:AddConnection(userinput.InputChanged, function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						UpdateSlider(input.Position.X)
					end
				end)

		--[[Slider.slide.slideframe.BackgroundColor3 = syde.theme.HitBox
		Slider.slide.slideframe.shadowHolder.ambientShadow.ImageColor3 = syde.theme.HitBox
		Slider.slide.slideframe.shadowHolder.penumbraShadow.ImageColor3 = syde.theme.HitBox
		Slider.slide.slideframe.shadowHolder.umbraShadow.ImageColor3 = syde.theme.HitBox]]
				slider.slideholder.Size = UDim2.new(1,-30,0,slider.slideholder.UIListLayout.AbsoluteContentSize.Y)
				slider.Size = UDim2.new(1,-40,0,slider.slideholder.AbsoluteSize.Y + 55)

		--[[syde:AddConnection(syde.Comms.Event, function(p, color)
			if p == 'HitBox' then
				Slider.slide.slideframe.BackgroundColor3 = color
				Slider.slide.slideframe.shadowHolder.ambientShadow.ImageColor3 = color
				Slider.slide.slideframe.shadowHolder.penumbraShadow.ImageColor3 = color
				Slider.slide.slideframe.shadowHolder.umbraShadow.ImageColor3 = color
			end
		end)]]
			end

			--[DESC]
			local descLabel = slider.slideholder:FindFirstChild("Desc")

			if descLabel then
				if SliderData.Desc and SliderData.Desc ~= "" then
					descLabel.Text = SliderData.Desc
					descLabel.Visible = true
					descLabel.TextWrapped = true

					local function updateSize()
						local textSize = textservice:GetTextSize(
							descLabel.Text,
							descLabel.TextSize,
							descLabel.Font,
							Vector2.new(descLabel.AbsoluteSize.X, math.huge) -- Allows vertical expansion
						)

						local newDescSize = UDim2.new(1, -150, 0, textSize.Y)
						local newButtonSize = UDim2.new(slider.Size.X.Scale, slider.Size.X.Offset, 0,slider.slideholder.AbsoluteSize.Y + slider.Title.Size.Y.Offset + textSize.Y - 5) -- Adding extra padding

						local descTween = tweenservice:Create(descLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newDescSize })
						descTween:Play()

						local ToggleTween = tweenservice:Create(slider, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newButtonSize })
						ToggleTween:Play()
					end

					updateSize()

					descLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
				else
					descLabel.Visible = false
				end
			end


		end

		function element:Keybind(Keybind, Parent)
			local KeybindData = {
				Title = Keybind.Title;
				Key = Keybind.Key;
				Desc = Keybind.Description or "";
				CallBack = Keybind.CallBack;
				WaitingForKey = false;
				Hold = false;
				Holding = false
			}

		
			local KeyBind = Library.Settings.KeyBind:Clone()
			KeyBind.Visible = true
			KeyBind.Parent = Parent
			KeyBind.Title.Text = KeybindData.Title
			KeyBind.Name = KeybindData.Title

			KeyBind.Bind.v.Text = KeybindData.Key and KeybindData.Key.Name or "NONE"
			tweenservice:Create(KeyBind.Bind, TweenInfo.new(0.55, Enum.EasingStyle.Quint ), {Size = UDim2.new(0, KeyBind.Bind.v.TextBounds.X + 15, 0, KeyBind.Bind.Size.Y.Offset)}):Play()

			KeyBind.interact.MouseButton1Click:Connect(function()
				KeyBind.Bind.v.Text = '...'
				KeybindData.WaitingForKey = true
			end)

			KeyBind.Bind.v:GetPropertyChangedSignal('TextBounds'):Connect(function()
				tweenservice:Create(KeyBind.Bind, TweenInfo.new(0.55, Enum.EasingStyle.Quint ), {Size = UDim2.new(0, KeyBind.Bind.v.TextBounds.X + 15, 0, KeyBind.Bind.Size.Y.Offset)}):Play()
			end)

			-- Utility: Set a keybind (both value and label)
			local function SetKeybind(keyCode)
				if keyCode and keyCode ~= Enum.KeyCode.Unknown then
					KeybindData.Key = keyCode
					KeyBind.Bind.v.Text = keyCode.Name

					if typeof(Keybind.OnKeyChanged) == "function" then
						pcall(Keybind.OnKeyChanged, keyCode)
					end
				else
					KeybindData.Key = nil
					KeyBind.Bind.v.Text = "NONE"
				end
			end

			-- Main input handler
			SettingsElements:AddConnection(userinput.InputBegan, function(input)
				if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

				-- Setup mode: waiting for a new keybind
				if KeybindData.WaitingForKey then
					KeybindData.WaitingForKey = false
					SetKeybind(input.KeyCode)
					return
				end

				-- Match against current keybind
				if input.KeyCode == KeybindData.Key then
					KeybindData.Hold = true

					-- Hold state monitor
					local holdConnection
					holdConnection = input.Changed:Connect(function(prop)
						if prop == "UserInputState" then
							local state = input.UserInputState
							KeybindData.Hold = (state == Enum.UserInputState.Begin)
							if state == Enum.UserInputState.End and holdConnection then
								holdConnection:Disconnect()
							end
						end
					end)

					-- Callback logic
					local success, result = pcall(KeybindData.CallBack, KeybindData.Key)
					if not KeybindData.Holding then
						if not success then
							warn(`[Keybind: {KeyBind.Name}] Callback Error: {result}`)
						end
					else
						if KeybindData.Hold then
							local holdLoop
							holdLoop = runservice.RenderStepped:Connect(function()
								if not KeybindData.Hold then
									KeybindData.CallBack(false)
									holdLoop:Disconnect()
								else
									KeybindData.CallBack(false)
								end
							end)
						end
					end
				end
			end)

		end

		return element

	end

	local element = SettingsElements:GetSettingsElements()

	element:Section('Accent', WINDOW.Settings.Pages.Theme.Container, '0')

	element:ColorPicker({
		Title = 'Accent',
		Linkable = true,
		Color = syde.theme.Accent;
		CallBack = function(v)
			print(v)
		end,
	}, WINDOW.Settings.Pages.Theme.Container)

	element:Keybind({
		Title = 'Toggle UI',
		Key = UIToggle,
		OnKeyChanged = function(newKey)
			UIToggle = newKey
		end,
		CallBack = function()
			ToggleUI()
		end,
	}, WINDOW.Settings.Pages.Theme.Container)

	element:Section('Hitbox', WINDOW.Settings.Pages.Theme.Container, '0')

	element:ColorPicker({
		Title = 'HitBox',
		Linkable = true,
		Color = syde.theme.HitBox;
		CallBack = function(c)
			syde:UpdateTheme({
				['HitBox'] = c
			})
		end,
	}, WINDOW.Settings.Pages.Theme.Container)

	element:CreateSlider({
		Title = 'Modifiers',
		Sliders = {
			{
				Title = 'Slider Density',
				Range = {0, 1},
				Increment = 0.1,
				StarterValue = WINDOW.Shadow.ImageLabel.ImageTransparency,
				CallBack = function(v)
					tweenservice:Create(WINDOW.Shadow.ImageLabel, TweenInfo.new(0.65, Enum.EasingStyle.Exponential), {ImageTransparency = v}):Play()
				end,
			},
		}
	}, WINDOW.Settings.Pages.Theme.Container)

	element:Paragraph({
		Title = 'Coming Soon',
		Content = 'Privacy Options Coming Soon'
	}, WINDOW.Settings.Pages.Privacy.Container)

	element:Paragraph({
		Title = 'Status',
		Content = 'Your Up To Date!'
	}, WINDOW.Settings.Pages.Info.Container)

	local startTime = tick()

	local uptimeParagraph = element:Paragraph({
		Title = 'Server Uptime',
		Content = 'Calculating...'
	}, WINDOW.Settings.Pages.Info.Container)

	local function formatTime(seconds)
		local days = math.floor(seconds / 86400)
		seconds = seconds % 86400
		local hours = math.floor(seconds / 3600)
		seconds = seconds % 3600
		local minutes = math.floor(seconds / 60)
		seconds = math.floor(seconds % 60)

		return string.format("%02d:%02d:%02d:%02d", days, hours, minutes, seconds)
	end

	local startTime = tick()

	SettingsElements:AddConnection(runservice.Heartbeat, function()
		local uptime = tick() - startTime
		local formatted = formatTime(uptime)
		uptimeParagraph:Set("Server Uptime: " .. formatted)
	end)

end


--[INITIALIZATION]
function syde:Init(library)

	UI.Enabled = true
	tweenservice:Create(game.Workspace.Camera, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { FieldOfView  = 70 }):Play()

	local Data = {
		Title = library.Title or "Syde",
		SubText = library.SubText or "Google",
	}

	-- [Setup UI Elements]
	TOPBAR.Title.Text = Data.Title
	TOPBAR.Title.Sub.Text = Data.SubText

	-- [Setup Dragging & Resizing]
	syde:AddDrag(TOPBAR, WINDOW, 0.7, true)
	syde:MakeResizable(WINDOW.resize, WINDOW, Vector2.new(654, 428))

	-- [Initial Transparency Setup]
	TOPBAR.Title.TextTransparency = 1
	TOPBAR.Title.Sub.TextTransparency = 1

	--[Settings Page Init]
	if not settingsOpen then

		WINDOW.Settings.Visible = false
		WINDOW.dim.Visible = false

		WINDOW.Settings.Position = UDim2.new(0.5, 176,0.5, -200)
		WINDOW.Settings.Size = UDim2.new(0, 200,0, 110)
		WINDOW.dim.BackgroundTransparency = 1
		WINDOW.Settings.void.BackgroundTransparency = 1
		WINDOW.Settings.void2.BackgroundTransparency = 1

		WINDOW.Settings.BackgroundTransparency = 1
		WINDOW.Settings.TabBlock.UIStroke.Transparency = 1
		WINDOW.Settings.Shadow.ImageLabel.ImageTransparency = 1

		WINDOW.Settings.TabBlock.Theme.BackgroundTransparency = 1
		WINDOW.Settings.TabBlock.Theme.TextTransparency = 1
		WINDOW.Settings.TabBlock.Theme.d.BackgroundTransparency = 1
		WINDOW.Settings.TabBlock.Theme.Frame.BackgroundTransparency = 1

		WINDOW.Settings.TabBlock.Info.BackgroundTransparency = 1
		WINDOW.Settings.TabBlock.Info.TextTransparency = 1
		WINDOW.Settings.TabBlock.Info.d.BackgroundTransparency = 1
		WINDOW.Settings.TabBlock.Info.Frame.BackgroundTransparency = 1

		WINDOW.Settings.TabBlock.Privacy.BackgroundTransparency = 1
		WINDOW.Settings.TabBlock.Privacy.TextTransparency = 1
	end

	-- [Play Intro Animations]
	task.spawn(function()
		task.wait(0.5)
		local titleTween = tweenservice:Create(TOPBAR.Title, TweenInfo.new(1.65, Enum.EasingStyle.Exponential), { TextTransparency = 0 })
		titleTween:Play()

		task.wait(0.1)
		local subTitleTween = tweenservice:Create(TOPBAR.Title.Sub, TweenInfo.new(1.65, Enum.EasingStyle.Exponential), { TextTransparency = 0 })
		subTitleTween:Play()

		task.wait()
		local textSize = TOPBAR.Title.TextBounds.X + 5

		tweenservice:Create(TOPBAR.Title, TweenInfo.new(1.55, Enum.EasingStyle.Quint), {
			Size = UDim2.new(0, textSize, 1, 0)
		}):Play()
	end)

	-- [Resize Hover Animations]
	local function animateResizeButton(isHovered)
		local targetColor = isHovered and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(35, 35, 35)
		tweenservice:Create(WINDOW.resize, TweenInfo.new(0.95, Enum.EasingStyle.Exponential), { ImageColor3 = targetColor }):Play()
	end

	WINDOW.resize.MouseEnter:Connect(function() animateResizeButton(true) end)
	WINDOW.resize.MouseLeave:Connect(function() animateResizeButton(false) end)

	--[Settings Handle]
	-- Hover
	WINDOW.Settings.Close.MouseEnter:Connect(function()
		tweenservice:Create(WINDOW.Settings.Close, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {ImageColor3 = Color3.fromRGB(255, 255, 255) }):Play()
	end)

	WINDOW.Settings.Close.MouseLeave:Connect(function()
		tweenservice:Create(WINDOW.Settings.Close, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {ImageColor3 = Color3.fromRGB(48, 48, 48) }):Play()
	end)

	-- got lazy
	local expand = TOPBAR.UHolder:WaitForChild('expand')

	local expanded = false

	if not expanded then
		tweenservice:Create(TOPBAR.UHolder, TweenInfo.new(1.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 70,1, 0)}):Play()
		tweenservice:Create(expand, TweenInfo.new(1.4, Enum.EasingStyle.Exponential), {Rotation = 0}):Play()
	end

	expand.MouseButton1Click:Connect(function()
		if not expanded then
			expanded = true
			tweenservice:Create(TOPBAR.UHolder, TweenInfo.new(1.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 140,1, 0)}):Play()
			tweenservice:Create(expand, TweenInfo.new(1.4, Enum.EasingStyle.Exponential), {Rotation = -180}):Play()
		else
			expanded = false
			tweenservice:Create(TOPBAR.UHolder, TweenInfo.new(1.4, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 70,1, 0)}):Play()
			tweenservice:Create(expand, TweenInfo.new(1.4, Enum.EasingStyle.Exponential), {Rotation = 0}):Play()
		end
	end)

	expand.MouseEnter:Connect(function()
		tweenservice:Create(expand, TweenInfo.new(1.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
	end)

	expand.MouseLeave:Connect(function()
		tweenservice:Create(expand, TweenInfo.new(1.4, Enum.EasingStyle.Exponential), {ImageTransparency = 0.8}):Play()
	end)


	WINDOW.Top.UHolder.Util.Mini.interact.MouseButton1Click:Connect(function()
		CloseUI()
	end)

	local tabBlock = WINDOW.Settings.TabBlock
	local pageLayout = WINDOW.Settings.Pages.UIPageLayout
	local pagesFolder = WINDOW.Settings.Pages

	for _, v in pairs(tabBlock:GetChildren()) do
		if v:IsA('TextButton') then
			v.MouseButton1Click:Connect(function()
				local targetPage = pagesFolder:FindFirstChild(v.Name)

				for _, other in pairs(tabBlock:GetChildren()) do
					if other:IsA('TextButton') then
						tweenservice:Create(other, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(15, 15, 15) }):Play()
						tweenservice:Create(other, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {TextColor3 = Color3.fromRGB(44, 44, 44) }):Play()

						if other.Name == 'Theme' then
							tweenservice:Create(other.d, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(15, 15, 15) }):Play()
						elseif other.Name == 'Info' then
							tweenservice:Create(other.d, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(15, 15, 15) }):Play()
						end


					end
				end

				tweenservice:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(26, 26, 26) }):Play()
				tweenservice:Create(v, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {TextColor3 = Color3.fromRGB(255, 255, 255) }):Play()
				if v.Name == 'Theme' then
					tweenservice:Create(v.d, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(26, 26, 26) }):Play()
				elseif v.Name == 'Info' then
					tweenservice:Create(v.d, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(26, 26, 26) }):Play()
				end

				if targetPage then
					pageLayout:JumpTo(targetPage)
				else
					warn("Page not found for tab:", v.Name)
				end
			end)
		end
	end



	-------------------------------

	local ldata = {
		first = false,
		selected = false
	}

	--[TAB INITIALIZATION]
	function ldata:InitTab(Title)
		local isFirstTab = not ldata.first 

		--[Tab Setup]
		local Tab = TABS.Tb:Clone()
		Tab.Visible = true
		Tab.Parent = TABS
		Tab.Title.Text = Title
		Tab.Name = Title

		Tab.Title.TextTransparency = 1
		Tab.indicator.BackgroundTransparency = 1

		for _, temp in ipairs(PAGES.Page:GetChildren()) do
			if temp:IsA("Frame") then
				temp.Visible = false
			end
		end

		--[Page Setup]
		local Page = PAGES.Page:Clone()
		Page.Visible = false
		Page.Parent = PAGES
		Page.Name = Title

		local defaultParent = Page 

		local function setInternalParent(newParent)
			defaultParent = newParent
		end


		Page.ChildAdded:Connect(function(child)
			child:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
				syde:updateLayout(Page, 7) 
			end)
			child:GetPropertyChangedSignal("Visible"):Connect(function()
				syde:updateLayout(Page, 7)
			end)
			syde:updateLayout(Page, 7)
		end)

		Page.ChildRemoved:Connect(function()
			syde:updateLayout(Page, 7)
		end)

		Page:GetPropertyChangedSignal("AbsoluteSize"):Connect(function()
			syde:updateLayout(Page, 7)
		end)

		syde:updateLayout(Page, 7)

		local function ChangeName(Name)
			tweenservice:Create(PAGES.TBName, TweenInfo.new(0), { TextTransparency = PAGES.TBName.TextTransparency }):Play()
			tweenservice:Create(PAGES.TBName, TweenInfo.new(0), { Position = PAGES.TBName.Position }):Play()

			local fadeOut = tweenservice:Create(PAGES.TBName, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), { TextTransparency = 1 })
			local moveUp = tweenservice:Create(PAGES.TBName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { Position = UDim2.new(0, 5, 0, -3) })

			fadeOut:Play()
			moveUp:Play()
			task.wait(0.2)

			PAGES.TBName.Position = UDim2.new(0, 5, 0, 30)

			PAGES.TBName.Text = Name

			local moveDown = tweenservice:Create(PAGES.TBName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { Position = UDim2.new(0, 5, 0, 20) })
			local fadeIn = tweenservice:Create(PAGES.TBName, TweenInfo.new(0.5, Enum.EasingStyle.Exponential), { TextTransparency = 0 })

			moveDown:Play()
			fadeIn:Play()
		end


		if isFirstTab then
			ChangeName(Title)
			Page.Visible = true
			ldata.first = Title
		end


		if ldata.first then
			tweenservice:Create(Tab.Title, TweenInfo.new(2, Enum.EasingStyle.Quint), { Size = UDim2.new(1, -8, 1, 0) }):Play()
			tweenservice:Create(Tab.Title, TweenInfo.new(2, Enum.EasingStyle.Quint), { TextColor3 = Color3.fromRGB(52, 52, 52) }):Play()
			tweenservice:Create(Tab.indicator, TweenInfo.new(2, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 2, 0, 10) }):Play()
			tweenservice:Create(Tab.Title, TweenInfo.new(2, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
			tweenservice:Create(Tab.indicator, TweenInfo.new(1, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0.9 }):Play()
			tweenservice:Create(Tab.indicator.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()
		else
			ldata.first = Title
			tweenservice:Create(Tab.Title, TweenInfo.new(2, Enum.EasingStyle.Quint), { Size = UDim2.new(1, -10, 1, 0) }):Play()
			tweenservice:Create(Tab.Title, TweenInfo.new(2, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
			tweenservice:Create(Tab.indicator, TweenInfo.new(2, Enum.EasingStyle.Exponential), { BackgroundColor3 = syde.theme.Accent }):Play()
			tweenservice:Create(Tab.indicator, TweenInfo.new(2, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 2, 0, 2) }):Play()
			tweenservice:Create(Tab.indicator.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential), { ImageTransparency = 0.6 }):Play()
		end

		local positionTweenInfo = TweenInfo.new(0.75, Enum.EasingStyle.Quint)
		local colorTweenInfo = TweenInfo.new(1.5, Enum.EasingStyle.Quart)

		local function ApplyTabStyle(tabButton, isSelected)
			local targetSize = isSelected and UDim2.new(1, -12, 1, 0) or UDim2.new(1, -12, 1, 0)
			local targetTextColor = isSelected and Color3.fromRGB(255, 255, 255) or Color3.fromRGB(52, 52, 52)
			local targetTransparency = isSelected and 0 or 1
			local targetColor = isSelected and syde.theme.Accent or Color3.fromRGB(29, 29, 29)
			local indicatorSize = isSelected and UDim2.new(0, 2, 0, 10) or UDim2.new(0, 2, 0, 5)

			tweenservice:Create(tabButton.Title, positionTweenInfo, { Size = targetSize, TextColor3 = targetTextColor }):Play()
			tweenservice:Create(tabButton.indicator, colorTweenInfo, { BackgroundTransparency = targetTransparency, BackgroundColor3 = targetColor, Size = indicatorSize }):Play()
			tweenservice:Create(tabButton.indicator.ImageLabel, colorTweenInfo, { ImageColor3 = targetColor }):Play()
			tweenservice:Create(tabButton.indicator.ImageLabel, colorTweenInfo, { ImageTransparency = isSelected and 0.6 or 1 }):Play()
		end

		ApplyTabStyle(Tab, isFirstTab)

		local function OpenSettings()

			WINDOW.Settings.Visible = true
			WINDOW.dim.Visible = true

			tweenservice:Create(WINDOW.Settings, TweenInfo.new(0.65, Enum.EasingStyle.Quint), { Position = UDim2.new(0.5, 0,0.5, 0) }):Play()
			tweenservice:Create(WINDOW.Settings, TweenInfo.new(0.35, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 500,0, 375) }):Play()
			tweenservice:Create(WINDOW.dim, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0.3 }):Play()
			tweenservice:Create(WINDOW.Settings.Close, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { ImageTransparency = 0 }):Play()

			tweenservice:Create(WINDOW.Settings.void, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), {  BackgroundTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.void2, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()

			tweenservice:Create(WINDOW.Settings, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.UIStroke, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { Transparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.Shadow.ImageLabel, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { ImageTransparency = 0.86 }):Play()

			tweenservice:Create(WINDOW.Settings.TabBlock.Theme, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Theme, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Theme.d, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Theme.Frame, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()

			tweenservice:Create(WINDOW.Settings.TabBlock.Info, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Info, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Info.d, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Info.Frame, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()

			tweenservice:Create(WINDOW.Settings.TabBlock.Privacy, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Privacy, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
		end

		local function CloseSettings()

			tweenservice:Create(WINDOW.Settings, TweenInfo.new(0.65, Enum.EasingStyle.Quint), { Position = UDim2.new(0.5, 176,0.5, -200) }):Play()
			tweenservice:Create(WINDOW.Settings, TweenInfo.new(0.35, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 200,0, 110) }):Play()
			tweenservice:Create(WINDOW.dim, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.Close, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()

			tweenservice:Create(WINDOW.Settings.void, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.void2, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()

			tweenservice:Create(WINDOW.Settings, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.UIStroke, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { Transparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.Shadow.ImageLabel, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()

			tweenservice:Create(WINDOW.Settings.TabBlock.Theme, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Theme, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Theme.d, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Theme.Frame, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()

			tweenservice:Create(WINDOW.Settings.TabBlock.Info, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Info, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Info.d, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Info.Frame, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()

			tweenservice:Create(WINDOW.Settings.TabBlock.Privacy, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
			tweenservice:Create(WINDOW.Settings.TabBlock.Privacy, TweenInfo.new(0.73, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()

			task.wait(0.4)
			WINDOW.dim.Visible = false
		end

		Tab.interact.MouseButton1Click:Connect(function()
			if ldata.first == Title then return end 


			ChangeName(Title)
			for _, otherPage in ipairs(PAGES:GetChildren()) do
				if otherPage:IsA("ScrollingFrame") then
					otherPage.Visible = false
				end
			end


			Page.Visible = true
			ldata.first = Title

			syde:replayLoadTweens()

			for _, otherTab in ipairs(TABS:GetChildren()) do
				if otherTab:IsA("Frame") then
					ApplyTabStyle(otherTab, otherTab == Tab)
				end
			end
		end)

		WINDOW.Top.UHolder.Util.Settings.interact.MouseButton1Click:Connect(function()
			if ldata.first == "Settings" then return end
			ldata.previousTab = ldata.first 
			ldata.first = "Settings"
			ChangeName('Settings')

			if not settingsOpen then
				settingsOpen = true
				OpenSettings()
			end

			tweenservice:Create(WINDOW.Top.UHolder.Util.Settings.interact, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()

		--[[	for _, otherPage in ipairs(PAGES:GetChildren()) do
				if otherPage:IsA("ScrollingFrame") then
					otherPage.Visible = false
				end
			end  ]]

			-- Make all tab buttons appear disabled
			for _, otherTab in ipairs(TABS:GetChildren()) do
				if otherTab:IsA("Frame") then
					ApplyTabStyle(otherTab, false) 
					otherTab.interact.Active = false 
					--	tweenservice:Create(otherTab, TweenInfo.new(0.5), { BackgroundTransparency = 0.7 }):Play() 
				end
			end
		end)


		WINDOW.Settings.Close.MouseButton1Click:Connect(function()
			if not ldata.previousTab then return end
			ldata.first = ldata.previousTab
			ChangeName(ldata.previousTab)

			-- Restore all normal pages
			for _, otherPage in ipairs(PAGES:GetChildren()) do
				if otherPage:IsA("ScrollingFrame") then
					otherPage.Visible = (otherPage.Name == ldata.previousTab)
				end
			end

			for _, otherTab in ipairs(TABS:GetChildren()) do
				if otherTab:IsA("Frame") then
					ApplyTabStyle(otherTab, otherTab.Name == ldata.previousTab) 
					otherTab.interact.Active = true 
				end
			end

			if settingsOpen then
				settingsOpen = false
				tweenservice:Create(WINDOW.Top.UHolder.Util.Settings.interact, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0.7}):Play()
				CloseSettings()
			end
		end)

		local InitElement = {}

		function InitElement:Section(Title, Icon)
			local SectionData = {
				Title = Title
			}

			local Section = PAGES.Page.Section:Clone()
			Section.Visible = true
			Section.Title.Text = Title
			Section.Parent = Page
			Section.Title.Position = UDim2.new(0, 0,0, 0)

			if Icon then
				Section.icon.Image = 'rbxassetid://'..Icon
				Section.Title.Position = UDim2.new(0, 25,0, 0)
			else
				Section.icon.Visible = false
			end
		end


		function InitElement:Button(Button)
			local ButtonData = {
				Title = Button.Title or "Temp Button";
				CallBack = Button.CallBack;
				Desc = Button.Description or "";
				Type = Button.Type or 'Default';
				HoldTime = Button.HoldTime or 3;
			}

			local button = PAGES.Page.Button:Clone()
			button.Visible = true
			button.Parent = Page
			button.Title.Text = ButtonData.Title
			button.Name = ButtonData.Title
			button.Title.Size = UDim2.new(0, button.Title.TextBounds.X + 15,0, 35)


			local fOTween = TweenInfo.new(0.7, Enum.EasingStyle.Exponential)
			local fITween = TweenInfo.new(0.7, Enum.EasingStyle.Exponential)

			if ButtonData.Type == 'Default' then
				-- UI Stroke effect on button press

				button.interact.MouseButton1Down:Connect(function()
					tweenservice:Create(button.UIStroke, fOTween, { Transparency = 1 }):Play()
					tweenservice:Create(button.ImageLabel, fOTween, { ImageTransparency = 1 }):Play()
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()
				end)

				button.interact.MouseButton1Up:Connect(function()
					tweenservice:Create(button.UIStroke, fITween, { Transparency = 0 }):Play()
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 0.95 }):Play()


				end)

				button.interact.MouseButton1Click:Connect(function()
					if ButtonData.CallBack then
						local success, errorMsg = pcall(ButtonData.CallBack)
						if not success then
							warn("[CALLBACK ERROR]:", errorMsg)
						end
					else
						warn("[CALLBACK MISSING]: No Function Assigned To", ButtonData.Title)
					end
				end)

				-- Extra Check 
				button.interact.MouseLeave:Connect(function()
					tweenservice:Create(button.UIStroke, fITween, { Transparency = 0 }):Play()
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 0.95 }):Play()
				end)
			elseif ButtonData.Type == 'Hold' then
				local HoldTime = ButtonData.HoldTime
				local Holding = false
				local TimeLeft = HoldTime
				local Complete = false

				button.ImageLabel.Image = 'rbxassetid://127075195365098'
				button.ImageLabel.Rotation = 0
				button.ImageLabel.Size = UDim2.new(0, 16,0, 16)
				button.ImageLabel.Position = UDim2.new(1, -41,0.5, 0)

				local function CancelOperation()
					Holding = false
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 0.95 }):Play()
					tweenservice:Create(button.Title.Timer, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
					if not Complete then
						tweenservice:Create(button.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 1 }):Play()
						tweenservice:Create(button.UIStroke.UIGradient, TweenInfo.new(1, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) }):Play()
						tweenservice:Create(button, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { Position = UDim2.new(0 ,-15 ,0 ,button.Position.Y.Offset) }):Play()
						task.wait(0.15)
						tweenservice:Create(button, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { Position = UDim2.new(0 ,30 ,0 ,button.Position.Y.Offset) }):Play()
						task.wait(0.15)
						tweenservice:Create(button, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { Position = UDim2.new(0 ,0 ,0 ,button.Position.Y.Offset) }):Play()
						task.wait(1)
						tweenservice:Create(button.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 0 }):Play()
					end

					-- did not complete 

					--	button.UIStroke.UIGradient.Offset = Vector2.new(-1, 0)
					--	tweenservice:Create(button.UIStroke, TweenInfo.new(HoldTime, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) }):Play()

					TimeLeft = HoldTime
					button.Title.Timer.Text = tostring(HoldTime)
					task.wait(0.1)
					Complete = false
				end

				button.interact.MouseButton1Down:Connect(function()

					Holding = true
					TimeLeft = HoldTime
					button.Title.Timer.Text = tostring(TimeLeft)
					tweenservice:Create(button.ImageLabel, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()
					tweenservice:Create(button.Title.Timer, TweenInfo.new(0.8, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
					tweenservice:Create(button.UIStroke.UIGradient, TweenInfo.new(HoldTime, Enum.EasingStyle.Linear), { Offset = Vector2.new(0.7, 0) }):Play()
					tweenservice:Create(button.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 0}):Play()

					-- Countdown loop
					while Holding and TimeLeft > 0 do
						TimeLeft = math.max(0, TimeLeft - runservice.Heartbeat:Wait())
						button.Title.Timer.Text = string.format("%.1f", TimeLeft) 

					end

					if TimeLeft <= 0 then
						Complete = true
						if ButtonData.CallBack then
							local success, errorMsg = pcall(ButtonData.CallBack)
							if not success then
								warn("[CALLBACK ERROR]:", errorMsg)
							end
						else
							warn("[CALLBACK MISSING]: No Function Assigned To", ButtonData.Title)
						end
						tweenservice:Create(button, TweenInfo.new(0.34, Enum.EasingStyle.Exponential), { BackgroundColor3 = Color3.fromRGB(24, 24, 24) }):Play()
						tweenservice:Create(button.UIStroke.UIGradient, TweenInfo.new(0.1, Enum.EasingStyle.Linear), { Offset = Vector2.new(-1, 0) }):Play()
						task.wait(0.34)
						tweenservice:Create(button, TweenInfo.new(0.34, Enum.EasingStyle.Exponential), { BackgroundColor3 = Color3.fromRGB(17, 17, 17) }):Play()
					end
				end)

				button.interact.MouseButton1Up:Connect(function()
					CancelOperation()
				end)

				button.interact.MouseLeave:Connect(function()
					if Holding then
						CancelOperation()
					end
				end)
			end

			--[DESC]
			local descLabel = button:FindFirstChild("Desc")

			if descLabel then
				if ButtonData.Desc and ButtonData.Desc ~= "" then
					descLabel.Text = ButtonData.Desc
					descLabel.Visible = true
					descLabel.TextWrapped = true

					local function updateSize()
						local textSize = textservice:GetTextSize(
							descLabel.Text,
							descLabel.TextSize,
							descLabel.Font,
							Vector2.new(descLabel.AbsoluteSize.X, math.huge)
						)

						local newDescSize = UDim2.new(1, -150, 0, textSize.Y)
						local newButtonSize = UDim2.new(button.Size.X.Scale, button.Size.X.Offset, 0, button.Title.Size.Y.Offset + textSize.Y + 5)

						local descTween = tweenservice:Create(descLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newDescSize })
						descTween:Play()

						local buttonTween = tweenservice:Create(button, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newButtonSize })
						buttonTween:Play()
					end

					updateSize()

					descLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
				else
					descLabel.Visible = false
				end
			end



		end


		function InitElement:Toggle(Toggle)
			local ToggleData = {
				Title = Toggle.Title or "Temp Toggle";
				Desc = Toggle.Description or "";
				V = Toggle.Value or false;
				Config = Toggle.Config or false;
				CallBack = Toggle.CallBack
			}

			local toggle = PAGES.Page.Toggle:Clone()
			toggle.Visible = true
			toggle.Parent = Page
			toggle.Title.Text = ToggleData.Title
			toggle.Name = ToggleData.Title

			local toggleConfiguration = UI.Render.ToggleConfiguration:Clone()
			toggleConfiguration.Parent = UI.Render
			toggleConfiguration.Visible = false

			toggleConfiguration.Container.KeyBind.Bind.v.Text = 'None'
			tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Size = UDim2.new(0, toggleConfiguration.Container.KeyBind.Bind.v.TextBounds.X + 20,0, 28) }):Play()

			toggleConfiguration.BackgroundTransparency = 1
			toggleConfiguration.Container.KeyBind.Title.TextTransparency = 1
			toggleConfiguration.Container.KeyBind.Bind.BackgroundTransparency = 1
			toggleConfiguration.Container.KeyBind.Bind.v.TextTransparency = 1
			toggleConfiguration.Container.Clear.Title.TextTransparency = 1
			toggleConfiguration.Container.Clear.clear.ImageLabel.ImageTransparency = 1
			toggleConfiguration.Size = UDim2.new(0, 75,0, 53)

			if not ToggleData.Config then
				toggle.Configure:Destroy()
			end

			local toggleTween = TweenInfo.new(0.7, Enum.EasingStyle.Exponential)
			local fadeTween = TweenInfo.new(0.57, Enum.EasingStyle.Exponential, Enum.EasingDirection.Out)

			local function UpdateToggleUI(state)
				local targetColor = state and syde.theme.HitBox or Color3.fromRGB(20, 20, 20)
				local strokeTransparency = state and 1 or 0
				local checkTransparency = state and 0 or 1
				local gradientTransparency = state and 0 or 1

				tweenservice:Create(toggle.tog, toggleTween, { BackgroundColor3 = targetColor }):Play()
				tweenservice:Create(toggle.tog.UIStroke, toggleTween, { Transparency = strokeTransparency }):Play()
				tweenservice:Create(toggle.tog.check, toggleTween, { ImageTransparency = checkTransparency }):Play()
				tweenservice:Create(toggle.tog.gradfr, fadeTween, { BackgroundTransparency = gradientTransparency }):Play()
			end

			UpdateToggleUI(ToggleData.V)

			toggle.interact.MouseButton1Click:Connect(function()
				ToggleData.V = not ToggleData.V
				UpdateToggleUI(ToggleData.V)

				local success, errorMsg = pcall(function()
					if ToggleData.CallBack then
						ToggleData.CallBack(ToggleData.V)
					end
				end)

				if not success then
					warn("[CALLBACK ERROR][" .. toggle.Name .. "]: " .. tostring(errorMsg))
				end
			end)

			--[DESC]
			local descLabel = toggle:FindFirstChild("Desc")

			if descLabel then
				if ToggleData.Desc and ToggleData.Desc ~= "" then
					descLabel.Text = ToggleData.Desc
					descLabel.Visible = true
					descLabel.TextWrapped = true

					local function updateSize()
						local textSize = textservice:GetTextSize(
							descLabel.Text,
							descLabel.TextSize,
							descLabel.Font,
							Vector2.new(descLabel.AbsoluteSize.X, math.huge)
						)

						local newDescSize = UDim2.new(1, -150, 0, textSize.Y)
						local newButtonSize = UDim2.new(toggle.Size.X.Scale, toggle.Size.X.Offset, 0, toggle.Title.Size.Y.Offset + textSize.Y + 5) -- Adding extra padding

						local descTween = tweenservice:Create(descLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newDescSize })
						descTween:Play()

						local ToggleTween = tweenservice:Create(toggle, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newButtonSize })
						ToggleTween:Play()
					end

					updateSize()

					descLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
				else
					descLabel.Visible = false
				end
			end


			-- [CONFIGURATIPON]
			if ToggleData.Config then

				local State = false

				local enterTween = TweenInfo.new(0.5, Enum.EasingStyle.Exponential)
				local leaveTween = TweenInfo.new(0.5, Enum.EasingStyle.Exponential)

				toggle.Configure.MouseEnter:Connect(function()
					tweenservice:Create(toggle.Configure, enterTween, { ImageColor3 = Color3.fromRGB(255, 255, 255) }):Play()
				end)

				toggle.Configure.MouseLeave:Connect(function()
					tweenservice:Create(toggle.Configure, leaveTween, { ImageColor3 = Color3.fromRGB(104, 104, 104) }):Play()
				end)

				local function ToggleConfigOpen()
					toggleConfiguration.Visible = true
					State = true

					tweenservice:Create(toggleConfiguration, enterTween, { BackgroundTransparency = 0 }):Play()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Title, enterTween, { TextTransparency = 0 }):Play()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind, enterTween, { BackgroundTransparency = 0 }):Play()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind.v, enterTween, { TextTransparency = 0 }):Play()
					tweenservice:Create(toggleConfiguration.Container.Clear.clear.ImageLabel, enterTween, { ImageTransparency = 0 }):Play()
					tweenservice:Create(toggleConfiguration.Container.Clear.Title, enterTween, { TextTransparency = 0 }):Play()
					tweenservice:Create(toggleConfiguration, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 186,0, 85) }):Play()

				end

				local function ToggleConfigClose()
					State = false

					tweenservice:Create(toggleConfiguration, enterTween, { BackgroundTransparency = 1 }):Play()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Title, enterTween, { TextTransparency = 1 }):Play()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind, enterTween, { BackgroundTransparency = 1 }):Play()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind.v, enterTween, { TextTransparency = 1 }):Play()
					tweenservice:Create(toggleConfiguration.Container.Clear.clear.ImageLabel, enterTween, { ImageTransparency = 1 }):Play()
					tweenservice:Create(toggleConfiguration.Container.Clear.Title, enterTween, { TextTransparency = 1 }):Play()
					tweenservice:Create(toggleConfiguration, TweenInfo.new(0.7, Enum.EasingStyle.Quint), { Size = UDim2.new(0, 75,0, 53) }):Play()

					task.wait(0.5)

					toggleConfiguration.Visible = false

				end

				local TogService
				local heldKeys = {} 
				local debounce1 = false

				local function ToggleConfig()
					if debounce1 then return end
					debounce1 = true

					if not toggleConfiguration.Visible then
						TogService = runservice.RenderStepped:Connect(function()
							toggleConfiguration:TweenPosition(UDim2.new(0,toggle.Configure.AbsolutePosition.X - 190,0,toggle.Configure.AbsolutePosition.Y + toggle.Configure.AbsoluteSize.Y + 65), Enum.EasingDirection.Out, Enum.EasingStyle.Quad, 0.1, true)
							if not toggleConfiguration.Visible then
								TogService:Disconnect()
							end
						end)
						ToggleConfigOpen()
					else
						if TogService then TogService:Disconnect() end
						ToggleConfigClose()
					end

					task.delay(0.4, function()
						debounce1 = false
					end)
				end

				toggle.Configure.MouseButton1Click:Connect(function()
					ToggleConfig()
				end)

				local function ResizeBindFrame()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind, TweenInfo.new(0.5, Enum.EasingStyle.Quint), { Size = UDim2.new(0, toggleConfiguration.Container.KeyBind.Bind.v.TextBounds.X + 20,0, 28) }):Play()
				end

				local function setKeybind(key)
					if not key then
						toggleConfiguration.Container.KeyBind.Bind.v.Text = 'None'
						ResizeBindFrame()
						ToggleData.Keybind = nil
					else
						ToggleData.Keybind = key
						ToggleData.KeybindReady = false

						tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind.v, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
						toggleConfiguration.Container.KeyBind.Bind.v.Text = key.Name
						tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind.v, TweenInfo.new(1, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
						ResizeBindFrame()

						task.delay(0.5, function()
							ToggleData.KeybindReady = true
						end)
					end
				end

				toggleConfiguration.Container.KeyBind.Interact.MouseButton1Click:Connect(function()
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind.v, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
					task.wait(0.2)
					toggleConfiguration.Container.KeyBind.Bind.v.Text = "..."
					tweenservice:Create(toggleConfiguration.Container.KeyBind.Bind.v, TweenInfo.new(0.25, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
					ResizeBindFrame()


					local connection
					connection = userinput.InputBegan:Connect(function(input, processed)
						if not processed and input.UserInputType == Enum.UserInputType.Keyboard then
							setKeybind(input.KeyCode)
							connection:Disconnect()
						end
					end)
				end)

				userinput.InputBegan:Connect(function(input, processed)
					if not processed and ToggleData.Keybind and ToggleData.KeybindReady and input.KeyCode == ToggleData.Keybind then
						ToggleData.V = not ToggleData.V
						UpdateToggleUI(ToggleData.V)

						if ToggleData.CallBack then
							local success, errorMsg = pcall(function()
								ToggleData.CallBack(ToggleData.V)
							end)
							if not success then
								warn("[CALLBACK ERROR][" .. toggle.Name .. "]: " .. tostring(errorMsg))
							end
						end
					end
				end)

				local debounce2 = false

				toggleConfiguration.Container.Clear.Interact.MouseButton1Click:Connect(function()
					if debounce2 then return end
					debounce2 = true

					setKeybind(nil)

					local function blink()
						tweenservice:Create(toggleConfiguration.Container.Clear.clear.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quint), { Rotation = 13 }):Play()
						task.wait(0.2)
						tweenservice:Create(toggleConfiguration.Container.Clear.clear.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quint), { Rotation = -13 }):Play()
						task.wait(0.2)
						tweenservice:Create(toggleConfiguration.Container.Clear.clear.ImageLabel, TweenInfo.new(0.25, Enum.EasingStyle.Quint), { Rotation = 0 }):Play()
					end

					blink()

					task.delay(2, function()
						debounce2 = false
					end)
				end)

				toggleConfiguration.Container.Clear.MouseEnter:Connect(function()
					tweenservice:Create(toggleConfiguration.Container.Clear.clear, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0.9 }):Play()
				end)

				toggleConfiguration.Container.Clear.MouseLeave:Connect(function()
					tweenservice:Create(toggleConfiguration.Container.Clear.clear, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
				end)

			end
		end

		function InitElement:CreateSlider(Slider)
			local SliderData = {
				Title = Slider.Title;
				Desc = Slider.Description;
				Sliders = Slider.Sliders
			}

			local slider = PAGES.Page.Slider:Clone()
			slider.Visible = true
			slider.Parent = Page
			slider.Title.Text = SliderData.Title
			slider.Name = SliderData.Title
			slider.slideholder.slider.Visible = false


			--[SLIDERS INITIALIZE]
			for _, Options in ipairs(SliderData.Sliders) do
				local Slider = PAGES.Page.Slider.slideholder.slider:Clone()

				Options = {
					Title = Options.Title or "Slider";
					Increment = Options.Increment or 1;
					Range = Options.Range or {0, 100};
					StarterValue = Options.StarterValue or 16;
					CallBack = Options.CallBack;
				}

				Slider.Name = Options.Title
				Slider.Title.Text = Options.Title

				local dragging = false
				Slider.Visible = true
				Slider.Parent = slider.slideholder

				local SliderPosition
				if Options.StarterValue <= Options.Range[1] then
					SliderPosition = 0
				elseif Options.StarterValue >= Options.Range[2] then
					SliderPosition = 1
				else
					local range = Options.Range[2] - Options.Range[1]
					SliderPosition = (Options.StarterValue - Options.Range[1]) / range
				end


				Slider.slide.slideframe:TweenSize(UDim2.new(SliderPosition, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.5, true)

				syde:registerLoadTween(
					Slider.slide.slideframe,
					{Size = UDim2.new(SliderPosition, 0, 1, 0)},
					{Size = UDim2.new(0, 100,1, 0)},
					TweenInfo.new(0.85, Enum.EasingStyle.Quint)
				)

				syde:replayLoadTweens(Slider.slide.slideframe)

				Slider.v.Text = string.format("<font size='14'>%d</font><font color='#434343'>/%d</font>", Options.StarterValue, Options.Range[2])

				local function UpdateSlider(x)
					if dragging then
						local sliderStart = Slider.slide.AbsolutePosition.X
						local sliderWidth = Slider.slide.AbsoluteSize.X
						local sliderPosition = (x - sliderStart) / sliderWidth
						sliderPosition = math.clamp(sliderPosition, 0, 1)

						local range = Options.Range[2] - Options.Range[1]
						local newValue = Options.Range[1] + sliderPosition * range
						newValue = math.floor((newValue - Options.Range[1]) / Options.Increment + 0.5) * Options.Increment + Options.Range[1]

						-- Update the slider visual position
						local snapPosition = (newValue - Options.Range[1]) / range
						Slider.slide.slideframe:TweenSize(UDim2.new(snapPosition, 0, 1, 0), Enum.EasingDirection.Out, Enum.EasingStyle.Quint, 0.55, true)

						syde:registerLoadTween(
							Slider.slide.slideframe,
							{Size = UDim2.new(snapPosition, 0, 1, 0)},
							{Size = UDim2.new(0, 100,1, 0)},
							TweenInfo.new(0.85, Enum.EasingStyle.Quint)
						)


						-- Update the displayed value
						Slider.v.Text = string.format("<font size='14'>%d</font><font color='#434343'>/%d</font>", newValue, Options.Range[2])

						tweenservice:Create(Slider.Title, TweenInfo.new(0.55, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()

						local success, errorMsg = pcall(function()
							Options.CallBack(newValue)
						end)
						if not success then
							warn("[CALLBACK ERROR][" .. Slider.Name .. "]: " .. tostring(errorMsg))
						end
					end
				end

				Slider.slide.Interact.MouseButton1Down:Connect(function()
					dragging = true
				end)

				Slider.slide.Interact.MouseButton1Up:Connect(function()
					dragging = false
				end)

				syde:AddConnection(userinput.InputEnded, function(input, processed)
					if input.UserInputType == Enum.UserInputType.MouseButton1 then
						dragging = false
						tweenservice:Create(Slider.Title, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { TextTransparency = 0.6 }):Play()
					end
				end)

				syde:AddConnection(userinput.InputChanged, function(input)
					if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
						UpdateSlider(input.Position.X)
					end
				end)

				Slider.slide.slideframe.BackgroundColor3 = syde.theme.HitBox
				Slider.slide.slideframe.shadowHolder.ambientShadow.ImageColor3 = syde.theme.HitBox
				Slider.slide.slideframe.shadowHolder.penumbraShadow.ImageColor3 = syde.theme.HitBox
				Slider.slide.slideframe.shadowHolder.umbraShadow.ImageColor3 = syde.theme.HitBox
				slider.slideholder.Size = UDim2.new(1,-30,0,slider.slideholder.UIListLayout.AbsoluteContentSize.Y)
				slider.Size = UDim2.new(1,-15,0,slider.slideholder.AbsoluteSize.Y + 55)

				syde:AddConnection(syde.Comms.Event, function(p, color)
					if p == 'HitBox' then
						Slider.slide.slideframe.BackgroundColor3 = color
						Slider.slide.slideframe.shadowHolder.ambientShadow.ImageColor3 = color
						Slider.slide.slideframe.shadowHolder.penumbraShadow.ImageColor3 = color
						Slider.slide.slideframe.shadowHolder.umbraShadow.ImageColor3 = color
					end
				end)
			end

			--[DESC]
			local descLabel = slider.slideholder:FindFirstChild("Desc")

			if descLabel then
				if SliderData.Desc and SliderData.Desc ~= "" then
					descLabel.Text = SliderData.Desc
					descLabel.Visible = true
					descLabel.TextWrapped = true

					local function updateSize()
						local textSize = textservice:GetTextSize(
							descLabel.Text,
							descLabel.TextSize,
							descLabel.Font,
							Vector2.new(descLabel.AbsoluteSize.X, math.huge)
						)

						local newDescSize = UDim2.new(1, -150, 0, textSize.Y)
						local newButtonSize = UDim2.new(slider.Size.X.Scale, slider.Size.X.Offset, 0,slider.slideholder.AbsoluteSize.Y + slider.Title.Size.Y.Offset + textSize.Y - 5) -- Adding extra padding

						local descTween = tweenservice:Create(descLabel, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newDescSize })
						descTween:Play()

						local ToggleTween = tweenservice:Create(slider, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newButtonSize })
						ToggleTween:Play()
					end

					updateSize()

					descLabel:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
				else
					descLabel.Visible = false
				end
			end

		end

		function InitElement:Dropdown(Dropdown)
			local DropdownData = {
				Title = Dropdown.Title or "Temp Dropdown";
				Options = Dropdown.Options or {};
				StarterOption = Dropdown.StarterOption;
				PlaceHolder = Dropdown.PlaceHolder or "Select Option...";
				Multi = Dropdown.Multi or false;
				CallBack = Dropdown.CallBack;
			}

			local dropdown = PAGES.Page.Dropdown:Clone()
			dropdown.Visible = true
			dropdown.Parent = Page
			dropdown.Title.Text = DropdownData.Title
			dropdown.Name = DropdownData.Title
			dropdown.dropHolder.drop.Container.Option.Visible = false
			dropdown.dropHolder.drop.Container.Visible = false
			tweenservice:Create(dropdown.dropHolder.drop.Container, TweenInfo.new(1, Enum.EasingStyle.Quint), { Size = UDim2.new(0.33, -20,0.576, -75) }):Play()
			dropdown.dropHolder.drop.Selected.Text = DropdownData.PlaceHolder 

			local DropOpen = false
			local DeBounce = false
			local OptionButton = dropdown.dropHolder.drop.Container.Option
			local SelectedOptions = {}
			local SelectedOrder = {}

			local function UpdateCustomLayout()
				local yOffset = 0
				for _, option in ipairs(dropdown.dropHolder.drop.Container:GetChildren()) do
					if option:IsA("Frame") and option.Visible then
						tweenservice:Create(option, TweenInfo.new(0.5, Enum.EasingStyle.Quint), {Position = UDim2.new(0, 0, 0, yOffset)}):Play()
						yOffset = yOffset + option.Size.Y.Offset + 7
					end
				end
			end

			local function OpenDrop()
				DropOpen = true
				dropdown.dropHolder.drop.Container.Visible = true
				dropdown.dropHolder.drop.Search.Visible = true

				tweenservice:Create(dropdown, TweenInfo.new(1.34, Enum.EasingStyle.Quint), { Size = UDim2.new(1, -15, 0, 300) }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Container, TweenInfo.new(1, Enum.EasingStyle.Quint), { Size = UDim2.new(1, -20, 1, -75) }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.void, TweenInfo.new(1.34, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.down, TweenInfo.new(0.35, Enum.EasingStyle.Quint), { Rotation = 180 }):Play()

				tweenservice:Create(dropdown.dropHolder.drop.Search, TweenInfo.new(1, Enum.EasingStyle.Exponential), { BackgroundTransparency = 0.65 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 0.4 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.TextBox, TweenInfo.new(1, Enum.EasingStyle.Exponential), { TextTransparency = 0 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential), { ImageTransparency = 0.9 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.icon, TweenInfo.new(1, Enum.EasingStyle.Exponential), { ImageTransparency = 0.85 }):Play()

			end

			local function CloseDrop()
				DropOpen = false
				tweenservice:Create(dropdown, TweenInfo.new(1, Enum.EasingStyle.Quint), { Size = UDim2.new(1, -15, 0, 89) }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Container, TweenInfo.new(1, Enum.EasingStyle.Quint), { Size = UDim2.new(0.33, -20, 0.576, -75) }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.void, TweenInfo.new(1.34, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.down, TweenInfo.new(0.35, Enum.EasingStyle.Quint), { Rotation = 0 }):Play()

				tweenservice:Create(dropdown.dropHolder.drop.Search, TweenInfo.new(1, Enum.EasingStyle.Exponential), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), { Transparency = 1 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.TextBox, TweenInfo.new(1, Enum.EasingStyle.Exponential), { TextTransparency = 1 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()
				tweenservice:Create(dropdown.dropHolder.drop.Search.icon, TweenInfo.new(1, Enum.EasingStyle.Exponential), { ImageTransparency = 1 }):Play()

				task.wait(0.6)
				dropdown.dropHolder.drop.Container.Visible = false
				dropdown.dropHolder.drop.Search.Visible = false

			end

			dropdown.dropHolder.drop.down.MouseButton1Click:Connect(function()
				if DeBounce then return end
				DeBounce = true

				if DropOpen then
					CloseDrop()
				else
					OpenDrop()
				end

				task.delay(1.2, function()
					DeBounce = false
				end)
			end)

			local function UpdateSelectedText()
				if #SelectedOrder > 0 then
					dropdown.dropHolder.drop.Selected.Text = table.concat(SelectedOrder, ", ")
				else
					dropdown.dropHolder.drop.Selected.Text = DropdownData.PlaceHolder
				end
			end

			local function AddToSelected(option)
				if not SelectedOptions[option] then
					SelectedOptions[option] = true

					local originalIndex
					for i, opt in ipairs(DropdownData.Options) do
						if opt == option then
							originalIndex = i
							break
						end
					end

					local insertIndex = 1
					for i, selected in ipairs(SelectedOrder) do
						local selectedIndex = table.find(DropdownData.Options, selected)
						if selectedIndex and selectedIndex < originalIndex then
							insertIndex = i + 1
						else
							break
						end
					end
					table.insert(SelectedOrder, insertIndex, option)
				end
			end

			local function RemoveFromSelected(option)
				if SelectedOptions[option] then
					SelectedOptions[option] = nil
					for i = #SelectedOrder, 1, -1 do
						if SelectedOrder[i] == option then
							table.remove(SelectedOrder, i)
							break
						end
					end
				end
			end

			--[SEARCH]
			dropdown.dropHolder.drop.Search.TextBox:GetPropertyChangedSignal("Text"):Connect(function()
				local searchText = dropdown.dropHolder.drop.Search.TextBox.Text:lower()

				for _, option in ipairs(dropdown.dropHolder.drop.Container:GetChildren()) do
					if option:IsA("Frame") and option:FindFirstChild("Title") then
						local optionText = option.Title.Text:lower()
						local isTemplate = option == Option or option.Name == "Option"
						local shouldShow = not isTemplate and (searchText == "" or optionText:find(searchText, 1, true))

						if shouldShow then
							option.Visible = true
							if SelectedOptions[option.Title.Text] then
								tweenservice:Create(option, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
								tweenservice:Create(option, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(31, 31, 31)}):Play()
								tweenservice:Create(option.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
								tweenservice:Create(option.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
								tweenservice:Create(option.ImageLabel, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 0}):Play()
							else
								tweenservice:Create(option, TweenInfo.new(1, Enum.EasingStyle.Exponential), {BackgroundTransparency = 0}):Play()
								tweenservice:Create(option, TweenInfo.new(1, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
								tweenservice:Create(option.Title, TweenInfo.new(1, Enum.EasingStyle.Exponential), {TextTransparency = 0}):Play()
								tweenservice:Create(option.UIStroke, TweenInfo.new(1, Enum.EasingStyle.Exponential), {Transparency = 0.5}):Play()
								tweenservice:Create(option.ImageLabel, TweenInfo.new(1, Enum.EasingStyle.Exponential), {ImageTransparency = 0.9}):Play()
							end
						else
							-- Hide with animation, but wait before setting Visible = false
							tweenservice:Create(option, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundTransparency = 1}):Play()
							tweenservice:Create(option, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
							tweenservice:Create(option.Title, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {TextTransparency = 1}):Play()
							tweenservice:Create(option.UIStroke, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
							tweenservice:Create(option.ImageLabel, TweenInfo.new(0.7, Enum.EasingStyle.Exponential), {ImageTransparency = 1}):Play()
							option.Visible = false
						end
					end
				end

				UpdateCustomLayout()
			end)



			local function SetDropdownOptions()
				local starterSet = false
				for _, OptionText in ipairs(DropdownData.Options) do
					local option = OptionButton:Clone()
					option.Title.Text = OptionText
					option.Parent = dropdown.dropHolder.drop.Container
					option.Visible = true
					option.Name = OptionText

					if OptionText == DropdownData.StarterOption and not starterSet then
						starterSet = true
						dropdown.dropHolder.drop.Selected.Text = OptionText
						SelectedOptions = {[OptionText] = true}
						SelectedOrder = {OptionText}

						tweenservice:Create(option, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(31, 31, 31)}):Play()
						tweenservice:Create(option.ImageLabel, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
					end

					option.Interact.MouseButton1Click:Connect(function()
						if DropdownData.Multi then
							if SelectedOptions[OptionText] then
								RemoveFromSelected(OptionText)
								tweenservice:Create(option, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
								tweenservice:Create(option.ImageLabel, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
							else
								AddToSelected(OptionText)
								tweenservice:Create(option, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}):Play()
								tweenservice:Create(option.ImageLabel, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()
							end
						else
							dropdown.dropHolder.drop.Selected.Text = OptionText

							SelectedOptions = {[OptionText] = true}
							SelectedOrder = {OptionText}

							for _, opt in ipairs(dropdown.dropHolder.drop.Container:GetChildren()) do
								if opt:IsA("Frame") then
									tweenservice:Create(opt, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(22, 22, 22)}):Play()
									tweenservice:Create(opt.ImageLabel, TweenInfo.new(0.3), {ImageTransparency = 0.9}):Play()
								end
							end

							tweenservice:Create(option, TweenInfo.new(0.3), {BackgroundColor3 = Color3.fromRGB(24, 24, 24)}):Play()
							tweenservice:Create(option.ImageLabel, TweenInfo.new(0.3), {ImageTransparency = 0}):Play()

							if DropdownData.CallBack then
								DropdownData.CallBack(OptionText)
							end

							CloseDrop()
						end

						UpdateSelectedText()

						if DropdownData.Multi and DropdownData.CallBack then
							DropdownData.CallBack(SelectedOrder)
						end
					end)
				end

				if not starterSet then
					dropdown.dropHolder.drop.Selected.Text = DropdownData.PlaceHolder
				end

				UpdateCustomLayout()
			end

			SetDropdownOptions()
		end


		function InitElement:TextInput(TextInput)
			local TextInputData = {
				Title = TextInput.Title or "Text Input",
				PlaceHolder = TextInput.PlaceHolder or "Enter text...",
				NumbersOnly = TextInput.NumberOnly or false,
				ClearOnLost = TextInput.ClearOnLost == nil and true or TextInput.ClearOnLost,
				MaxSize = TextInput.MaxSize or 100,
				CallBack = TextInput.CallBack,
			}

			local textinput = PAGES.Page.Input:Clone()
			textinput.Visible = true
			textinput.Parent = Page
			textinput.Name = TextInputData.Title
			textinput.Title.Text = TextInputData.Title
			textinput.TextFrame.TextBox.PlaceholderText = TextInputData.PlaceHolder

			local textBox = textinput.TextFrame.TextBox
			local defaultHeight = 32
			local maxHeight = TextInputData.MaxSize

			textinput.TextFrame.Enter.MouseEnter:Connect(function()
				tweenservice:Create(textinput.TextFrame.Enter, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
			end)

			textinput.TextFrame.Enter.MouseLeave:Connect(function()
				tweenservice:Create(textinput.TextFrame.Enter, TweenInfo.new(0.4, Enum.EasingStyle.Exponential), {TextColor3 = Color3.fromRGB(40, 40, 40)}):Play()
			end)

			textBox:GetPropertyChangedSignal("Text"):Connect(function()
				if TextInputData.NumbersOnly then
					textBox.Text = textBox.Text:gsub("%D", "")
				end

				textBox.Size = UDim2.new(1, -60, 0, defaultHeight + 40)

				local textSize = game:GetService("TextService"):GetTextSize(
					textBox.Text, textBox.TextSize, textBox.Font, Vector2.new(textBox.AbsoluteSize.X, math.huge)
				)

				if textBox.Text == "" then
					textBox.Size = UDim2.new(1, -60, 0, math.max(defaultHeight))
				else
					local newHeight = math.min(textSize.Y + 18, maxHeight + 50)
					textBox.Size = UDim2.new(1, -60, 0, newHeight)
				end

			end)

			textinput.TextFrame:GetPropertyChangedSignal("Size"):Connect(function()
				local newHeight = textinput.TextFrame.Size.Y.Offset
				local extraHeight = 32

				tweenservice:Create(
					textinput,
					TweenInfo.new(0.7, Enum.EasingStyle.Quint),
					{ Size = UDim2.new(1, -15, 0, newHeight + extraHeight + 25) }
				):Play()

			end)

			textBox:GetPropertyChangedSignal("Size"):Connect(function()
				local newHeight = textBox.Size.Y.Offset
				local totalHeight = math.max(newHeight, defaultHeight)

				tweenservice:Create(
					textinput.TextFrame,
					TweenInfo.new(0.7, Enum.EasingStyle.Quint),
					{ Size = UDim2.new(1, -60, 0, totalHeight + 0) }
				):Play()

			end)

			local function ProcessInput()
				local success, errorMsg = pcall(function()
					TextInputData.CallBack(textBox.Text)
				end)
				if not success then
					warn("Error in TextInput callback [" .. textinput.Name .. "]: " .. tostring(errorMsg))
				end
			end

			textinput.TextFrame.Enter.MouseButton1Click:Connect(ProcessInput)

			textBox.FocusLost:Connect(function(enterPressed)
				if enterPressed then
					ProcessInput()
				end
				if TextInputData.ClearOnLost then
					textBox.Text = ""
					textBox.Size = UDim2.new(1, -60, 0, math.max(defaultHeight))
				else
					textBox.ClearTextOnFocus = false
				end
			end)
		end

		function InitElement:ColorPicker(ColorPicker)
			local ColorPickerData = {
				Title = ColorPicker.Title;
				Color = ColorPicker.Color;
				Linkable = ColorPicker.Linkable;
				CallBack = ColorPicker.CallBack;
			}

			ColorPicker.Linkable = ColorPicker.Linkable or true

			local colorpicker = PAGES.Page.ColorPicker:Clone()
			colorpicker.Visible = true
			colorpicker.Parent = Page
			colorpicker.Title.Text = ColorPickerData.Title
			colorpicker.Name = ColorPickerData.Title

			local isLinkable = Instance.new("BoolValue")
			isLinkable.Name = 'isLinkable'
			isLinkable.Value = ColorPickerData.Linkable
			isLinkable.Parent = colorpicker

			local HueSat = Instance.new("Color3Value")
			HueSat.Name = 'HueSat'
			HueSat.Value = ColorPickerData.Color
			HueSat.Parent = colorpicker

			local Open = false
			local DeBounce = false
			local State = false

			colorpicker.color.Values.Hue.BackgroundTransparency = 1
			colorpicker.color.Values.Hue.Pin.BackgroundTransparency = 1
			colorpicker.color.Values.Hue.Pin.UIStroke.Transparency = 1
			colorpicker.color.Values.Rainbow.ImageTransparency = 1

			colorpicker.color.SVPicker.Pin.BackgroundTransparency = 1
			colorpicker.color.SVPicker.Pin.UIStroke.Transparency = 1
			colorpicker.color.SVPicker.Brightness.BackgroundTransparency = 1
			colorpicker.color.SVPicker.Saturation.BackgroundTransparency = 1

			colorpicker.HueValues.HEX.BackgroundTransparency = 1
			colorpicker.HueValues.HEX.UIStroke.Transparency = 1
			colorpicker.HueValues.HEX.V.HEXBox.TextTransparency = 1
			colorpicker.HueValues.HEX.Link.ImageTransparency = 1
			colorpicker.HueValues.HEX.Copy.ImageTransparency = 1

			colorpicker.HueValues.RGB.BackgroundTransparency = 1
			colorpicker.HueValues.RGB.UIStroke.Transparency = 1
			colorpicker.HueValues.RGB.V.RGBBox.TextTransparency = 1
			colorpicker.HueValues.RGB.Copy.ImageTransparency = 1
			colorpicker.QuickClose.Interactable = false

			local recentContainer = colorpicker.color.Recent
			local spacing = 5
			local frameSize = 12 

			local function updateRecentLayout()
				local children = {} 
				for _, child in pairs(recentContainer:GetChildren()) do
					if child:IsA("Frame") then
						table.insert(children, child)
					end
				end

				table.sort(children, function(a, b)
					return a.LayoutOrder > b.LayoutOrder 
				end)

				-- Calculate total width needed
				local totalWidth = #children * frameSize + math.max(#children - 1, 0) * spacing
				local startX = recentContainer.AbsoluteSize.X - totalWidth 

				for _, frame in ipairs(children) do
					--	frame.Position = UDim2.new(0, startX, 0.5, -frame.Size.Y.Offset / 2)
					tweenservice:Create(frame, TweenInfo.new(0.5, Enum.EasingStyle.Quart), {Position = UDim2.new(0, startX , 0.8, -frame.Size.Y.Offset / 2) }):Play()
					startX += frameSize + spacing
				end
			end

			recentContainer.ChildAdded:Connect(function(child)
				if child:IsA("Frame") then
					child.LayoutOrder = os.time() 
					updateRecentLayout()
				end
			end)
			recentContainer.ChildRemoved:Connect(updateRecentLayout)
			updateRecentLayout()

			local HSV

			if ColorPickerData.Color then
				HSV = { ColorPickerData.Color:ToHSV() }
			else

				HSV = { 0, 0, 0 }
			end
			local Selected = ColorPickerData.Color
			local HueValue = HSV[1]

			local function TableToColor(Table)
				if type(Table) ~= "table" then return Table end
				return Color3.fromHSV(Table[1],Table[2],Table[3])
			end

			local function FormatColor(Color, format, precision)

				format = format or "RGB"
				precision = precision or 2

				local formattedColor = ""

				if format == "RGB" then
					return	math.round(Color.R * 255) .. "," .. math.round(Color.G * 255) .. "," .. math.round(Color.B * 255)
				elseif format == "Hex" then
					formattedColor = string.format("#%02X%02X%02X",
						math.round(Color.R * 255),
						math.round(Color.G * 255),
						math.round(Color.B * 255)
					)

					return formattedColor
				end
			end

			local SVPicker = colorpicker.color.SVPicker
			local HUESlider = colorpicker.color.Values.Hue

			SVPicker.Pin.BackgroundColor3 = ColorPickerData.Color
			HUESlider.Pin.BackgroundColor3 = ColorPickerData.Color

			local function updatestuff()
				ColorPickerData.Color = TableToColor(HSV)
				colorpicker.color.BackgroundColor3 = ColorPickerData.Color
				colorpicker.color.glow.ImageColor3 = ColorPickerData.Color

				colorpicker.color.BackgroundColor3 = Color3.fromHSV(HSV[1], 1, 1)
				local newColor = Color3.fromHSV(HSV[1], HSV[2], HSV[3])
				local newColor2 = Color3.fromHSV(HSV[1], 1, 1)

				HueSat.Value = ColorPickerData.Color

				tweenservice:Create(HUESlider.Pin, TweenInfo.new(0.1, Enum.EasingStyle.Exponential), {BackgroundColor3 = newColor2}):Play()
				tweenservice:Create(SVPicker.Pin, TweenInfo.new(0.1, Enum.EasingStyle.Exponential), {BackgroundColor3 = newColor}):Play()


				tweenservice:Create(SVPicker.Pin, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(HSV[2], 0, 1 - HSV[3], 0)
				}):Play()

				tweenservice:Create(HUESlider.Pin, TweenInfo.new(0.3, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
					Position = UDim2.new(1 - HSV[1], 0, 0.5, 0)
				}):Play()

				local formattedHex = FormatColor(ColorPickerData.Color, 'Hex')
				colorpicker.HueValues.HEX.V.HEXBox.PlaceholderText = formattedHex

				local formattedRGB = FormatColor(ColorPickerData.Color,'RGB', 2)
				colorpicker.HueValues.RGB.V.RGBBox.PlaceholderText = formattedRGB

				if ColorPickerData.CallBack then
					ColorPickerData.CallBack(ColorPickerData.Color)
				end
			end
			updatestuff()

			local newColor = Color3.fromHSV(HSV[1], HSV[2], HSV[3])

			local function OpenPicker()
				Open = true
				DeBounce = true
				colorpicker.color.Values.Visible = true
				colorpicker.color.SVPicker.Visible = true
				colorpicker.HueValues.Visible = true
				colorpicker.color.Recent.Visible = true

				colorpicker.interact.Interactable = false
				colorpicker.QuickClose.Interactable = true

				tweenservice:Create(colorpicker.color, TweenInfo.new( 0.95, Enum.EasingStyle.Quart ), { Size = UDim2.new(0, 1,0, 1) }):Play()
				tweenservice:Create(colorpicker, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(35, 35, 35) }):Play()
				tweenservice:Create(colorpicker.color, TweenInfo.new( 1, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromHSV(HSV[1], 1, 1) }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.6, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				task.wait(0.12)
				tweenservice:Create(colorpicker.color, TweenInfo.new( 0.9, Enum.EasingStyle.Quart ), { Size = UDim2.new(1, -200,0, 120) }):Play()
				tweenservice:Create(colorpicker, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(18, 18, 18) }):Play()
				tweenservice:Create(colorpicker, TweenInfo.new( 0.8, Enum.EasingStyle.Quart ), { Size = UDim2.new(1, -15,0, 180) }):Play()
				tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new( 1, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()
				task.wait(0.6)

				tweenservice:Create(colorpicker.color.SVPicker.Brightness, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Saturation, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin.UIStroke, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { Transparency = 0.58 }):Play()

				task.wait(0.5)
				tweenservice:Create(colorpicker.color.Values.Hue, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 0.58 }):Play()

				tweenservice:Create(colorpicker.HueValues.HEX, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0.9 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 0.4 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.V.HEXBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()

				task.wait(0.09)
				tweenservice:Create(colorpicker.HueValues.RGB, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0.9 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 0.4 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.V.RGBBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 0 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 0 }):Play()

				for _,v in ipairs(colorpicker.color.Recent:GetChildren()) do
					if v:IsA('Frame') then
						task.wait(0.1)
						tweenservice:Create(v, TweenInfo.new( 0.3, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 0 }):Play()
					end
				end

				task.wait(0.7)
				DeBounce = false
			end


			colorpicker.interact.MouseButton1Click:Connect(function()
				if DeBounce then return end
				if not Open then
					Open = true
					OpenPicker()
				end
			end)

			colorpicker.QuickClose.MouseEnter:Connect(function()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Quint ), { Size = UDim2.new(0, 70,0, 3) }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(255, 255, 255) }):Play()
			end)

			colorpicker.QuickClose.MouseLeave:Connect(function()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Quint ), { Size = UDim2.new(0, 60,0, 3) }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundColor3 = Color3.fromRGB(33, 33, 33) }):Play()
			end)

			local function ClosePicker()
				Open = false
				DeBounce = true
				tweenservice:Create(colorpicker, TweenInfo.new( 0.85, Enum.EasingStyle.Quint ), { Size = UDim2.new(1, -15,0, 40) }):Play()
				tweenservice:Create(colorpicker.color, TweenInfo.new( 0.85, Enum.EasingStyle.Quint ), { Size = UDim2.new(0, 20,0, 20) }):Play()
				tweenservice:Create(colorpicker.color, TweenInfo.new( 0.6, Enum.EasingStyle.Exponential ), { BackgroundColor3 = ColorPickerData.Color }):Play()
				tweenservice:Create(colorpicker.QuickClose, TweenInfo.new( 0.6, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				colorpicker.interact.Interactable = true
				colorpicker.QuickClose.Interactable = false

				--	task.wait(0.6)

				tweenservice:Create(colorpicker.color.SVPicker.Brightness, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Saturation, TweenInfo.new( 2, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin, TweenInfo.new( 1, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.SVPicker.Pin.UIStroke, TweenInfo.new( 0.4, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin, TweenInfo.new( 1, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Hue.Pin.UIStroke, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new( 0.5, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()

				tweenservice:Create(colorpicker.HueValues.RGB, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.V.RGBBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.RGB.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()

				task.wait(0.1)

				tweenservice:Create(colorpicker.HueValues.HEX, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.UIStroke, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { Transparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.V.HEXBox, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { TextTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()
				tweenservice:Create(colorpicker.HueValues.HEX.Copy, TweenInfo.new( 0.8, Enum.EasingStyle.Exponential ), { ImageTransparency = 1 }):Play()
				for _,v in ipairs(colorpicker.color.Recent:GetChildren()) do
					if v:IsA('Frame') then
						tweenservice:Create(v, TweenInfo.new( 0.6, Enum.EasingStyle.Exponential ), { BackgroundTransparency = 1 }):Play()
					end
				end
				task.wait(1)
				colorpicker.color.SVPicker.Visible = false
				colorpicker.color.Recent.Visible = false
				task.wait(0.7)
				DeBounce = false
			end

			colorpicker.QuickClose.MouseButton1Click:Connect(function()
				if DeBounce then return end
				if Open then
					Open = false
					ClosePicker()
				end
			end)

			local function AddRecentColor(newColor)
				local recentFrame = colorpicker.colorPlaceHolder:Clone()
				recentFrame.Visible = true
				recentFrame.Parent = colorpicker.color.Recent
				recentFrame.BackgroundColor3 = newColor

				recentFrame.interact.MouseButton1Click:Connect(function()
				--[[	tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Size = UDim2.new(0, 5,0, 5) }):Play()
					task.wait(0.09)
					tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Exponential), {Size = UDim2.new(0, 12,0, 12) }):Play() ]]

					local h, s, v = newColor:ToHSV()
					if s > 0.02 then
						HSV[1] = h
					end
					HSV[2] = s
					HSV[3] = v
					updatestuff()

				end)

				recentFrame.interact.MouseEnter:Connect(function()
					tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 20,0, 20) }):Play()
				end)

				recentFrame.interact.MouseLeave:Connect(function()
					tweenservice:Create(recentFrame, TweenInfo.new(0.3, Enum.EasingStyle.Quint), {Size = UDim2.new(0, 12,0, 12) }):Play()
				end)

				local maxRecentColors = 10
				local recentContainer = colorpicker.color.Recent

				local children = recentContainer:GetChildren()
				if #children > maxRecentColors then
					for _, child in ipairs(children) do
						if child:IsA("Frame") then
							child:Destroy()
							break
						end
					end
				end
			end

			local SV, HUE = nil, nil

			syde:AddConnection(SVPicker.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					SV = runservice.RenderStepped:Connect(function()
						local mouse = game.Players.LocalPlayer:GetMouse()
						local ColorX = math.clamp(mouse.X - SVPicker.AbsolutePosition.X, 0, SVPicker.AbsoluteSize.X) / SVPicker.AbsoluteSize.X
						local ColorY = math.clamp(mouse.Y - SVPicker.AbsolutePosition.Y, 0, SVPicker.AbsoluteSize.Y) / SVPicker.AbsoluteSize.Y

						HSV[2] = ColorX
						HSV[3] = 1 - ColorY

						updatestuff()
					end)
				end
			end)

			syde:AddConnection(SVPicker.InputEnded, function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 and SV then
					SV:Disconnect()
					SV = nil
					AddRecentColor(ColorPickerData.Color)
				end
			end)

			syde:AddConnection(HUESlider.InputBegan, function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					HUE = runservice.RenderStepped:Connect(function()
						local mouse = game.Players.LocalPlayer:GetMouse()
						local ColorX = math.clamp(mouse.X - HUESlider.AbsolutePosition.X, 0, HUESlider.AbsoluteSize.X) / HUESlider.AbsoluteSize.X

						HSV[1] = 1 - ColorX

						updatestuff()
					end)
				end
			end)

			syde:AddConnection(HUESlider.InputEnded, function(i)
				if i.UserInputType == Enum.UserInputType.MouseButton1 and HUE then
					HUE:Disconnect()
					HUE = nil
					AddRecentColor(ColorPickerData.Color)
				end
			end)

			colorpicker.HueValues.HEX.V.HEXBox.FocusLost:Connect(function(Enter)
				if not Enter then return end

				local hexInput = colorpicker.HueValues.HEX.V.HEXBox.Text

				local success, result = pcall(function()
					return Color3.fromHex(hexInput)
				end)

				if success then
					local Hue, Saturation, Value = result:ToHSV()
					colorpicker.HueValues.HEX.V.HEXBox.Text = ''
					if Saturation > 0.02 then
						HSV[1] = Hue
					end
					HSV[2] = Saturation
					HSV[3] = Value
					updatestuff()
				else
					warn("Failed to convert hex to color:", result)
				end
			end)

			colorpicker.HueValues.RGB.V.RGBBox.FocusLost:Connect(function(Enter)
				if not Enter then return end

				local rgbInput = colorpicker.HueValues.RGB.V.RGBBox.Text

				local r, g, b = rgbInput:match("^(%d+),%s*(%d+),%s*(%d+)$")

				if r and g and b then

					r, g, b = tonumber(r), tonumber(g), tonumber(b)

					if r >= 0 and r <= 255 and g >= 0 and g <= 255 and b >= 0 and b <= 255 then
						local color = Color3.fromRGB(r, g, b)

						local Hue, Saturation, Value = color:ToHSV()
						if Saturation > 0.02 then
							HSV[1] = Hue
						end
						HSV[2] = Saturation
						HSV[3] = Value

						colorpicker.HueValues.RGB.V.RGBBox.Text = ''
						updatestuff()
					else
						warn("RGB values must be between 0 and 255.")
					end
				else
					warn("Invalid RGB format. Please use the format 'R,G,B' (e.g., 16,16,16).")
				end
			end)

			local UserInputService = game:GetService("UserInputService")
			local TweenService = game:GetService("TweenService")
			local RunService = game:GetService("RunService")

			local linkDragging = false
			local originalPosition = UDim2.new(1, -10, 0.5, 0)
			local draggedColorPicker = nil

			local function isMouseOver(guiObject)
				local mouse = game.Players.LocalPlayer:GetMouse()
				local pos = guiObject.AbsolutePosition
				local size = guiObject.AbsoluteSize
				return mouse.X >= pos.X and mouse.X <= pos.X + size.X and mouse.Y >= pos.Y and mouse.Y <= pos.Y + size.Y
			end

			colorpicker.HueValues.HEX.Link.MouseButton1Down:Connect(function()
				linkDragging = true
				draggedColorPicker = colorpicker

				TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {Size = UDim2.new(0, 20,0, 20)}):Play()

				local followMouse
				followMouse = RunService.RenderStepped:Connect(function()
					if not linkDragging then
						followMouse:Disconnect()
						return
					end
					local mouse = game.Players.LocalPlayer:GetMouse()
					colorpicker.HueValues.HEX.Link.Position = UDim2.new(0, mouse.X - colorpicker.AbsolutePosition.X - 10, 0, mouse.Y - colorpicker.AbsolutePosition.Y - 100)

					for _, otherPicker in pairs(Page:GetChildren()) do
						if otherPicker:IsA("Frame") and otherPicker:FindFirstChild("isLinkable") and otherPicker.isLinkable.Value then
							if isMouseOver(otherPicker) and otherPicker ~= draggedColorPicker then
								TweenService:Create(otherPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 0}):Play()
							else
								TweenService:Create(otherPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
							end
						end
					end
				end)
			end)

			UserInputService.InputEnded:Connect(function(input)
				if input.UserInputType == Enum.UserInputType.MouseButton1 and linkDragging then
					linkDragging = false
					local foundTarget = false

					for _, otherPicker in pairs(Page:GetChildren()) do
						if otherPicker:IsA("Frame") and otherPicker:FindFirstChild("isLinkable") and otherPicker.isLinkable.Value then
							if isMouseOver(otherPicker) and otherPicker ~= draggedColorPicker then
								otherPicker.HueSat.Value = draggedColorPicker.HueSat.Value
								updatestuff() 
								foundTarget = true
								TweenService:Create(
									colorpicker.HueValues.HEX.Link,
									TweenInfo.new(0.3, Enum.EasingStyle.Quint),
									{ Position = originalPosition }
								):Play()

								TweenService:Create(otherPicker.UIStroke, TweenInfo.new(0.6, Enum.EasingStyle.Exponential), {Transparency = 1}):Play()
								TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {ImageColor3 = Color3.fromRGB(66, 66, 66)}):Play()
								TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {Size = UDim2.new(0, 15,0, 15)}):Play()
								break
							end
						end
					end

					if not foundTarget then
						TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {ImageColor3 = Color3.fromRGB(66, 66, 66)}):Play()
						TweenService:Create(colorpicker.HueValues.HEX.Link, TweenInfo.new(0.5, Enum.EasingStyle.Exponential) , {Size = UDim2.new(0, 15,0, 15)}):Play()
						TweenService:Create(
							colorpicker.HueValues.HEX.Link,
							TweenInfo.new(0.3, Enum.EasingStyle.Quint),
							{ Position = originalPosition }
						):Play()
					end
				end
			end)

			local function updateColorPicker()
				local Hue, Saturation, Value = HueSat.Value:ToHSV()

				if Saturation > 0.02 then
					HSV[1] = Hue
				end
				HSV[2] = Saturation
				HSV[3] = Value

				updatestuff()
			end

			HueSat.Changed:Connect(updateColorPicker)

			local hueIncrement = 0.005 

			local function RainbowEffect()
				HueValue = (HueValue + hueIncrement) % 1
				HSV[1] = HueValue

				updatestuff()
			end

			local isRainbowEnabled = false
			local huerender = nil

			local function ToggleRainbowEffect()
				isRainbowEnabled = not isRainbowEnabled
				if isRainbowEnabled then
					if not huerender then
						huerender = runservice.RenderStepped:Connect(RainbowEffect)
						tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new(0.5, Enum.EasingStyle.Exponential ), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					end
				else
					if huerender then
						huerender:Disconnect()
						tweenservice:Create(colorpicker.color.Values.Rainbow, TweenInfo.new(0.5, Enum.EasingStyle.Exponential ), {ImageColor3 = Color3.fromRGB(62, 62, 62)}):Play()
						huerender = nil
					end
				end
			end

			colorpicker.color.Values.Rainbow.MouseButton1Click:Connect(ToggleRainbowEffect)

		end

		function InitElement:Keybind(Keybind)
			local KeybindData = {
				Title = Keybind.Title;
				Key = Keybind.Key;
				Desc = Keybind.Description or "";
				CallBack = Keybind.CallBack;
				WaitingForKey = false;
				Hold = false;
				Holding = false
			}

			local KeyBind = PAGES.Page.KeyBind:Clone()
			KeyBind.Visible = true
			KeyBind.Parent = Page
			KeyBind.Title.Text = KeybindData.Title
			KeyBind.Name = KeybindData.Title

			KeyBind.Bind.v.Text = KeybindData.Key and KeybindData.Key.Name or "NONE"
			tweenservice:Create(KeyBind.Bind, TweenInfo.new(0.55, Enum.EasingStyle.Quint ), {Size = UDim2.new(0, KeyBind.Bind.v.TextBounds.X + 15, 0, KeyBind.Bind.Size.Y.Offset)}):Play()

			KeyBind.interact.MouseButton1Click:Connect(function()
				KeyBind.Bind.v.Text = '...'
				KeybindData.WaitingForKey = true
			end)

			KeyBind.Bind.v:GetPropertyChangedSignal('TextBounds'):Connect(function()
				tweenservice:Create(KeyBind.Bind, TweenInfo.new(0.55, Enum.EasingStyle.Quint ), {Size = UDim2.new(0, KeyBind.Bind.v.TextBounds.X + 15, 0, KeyBind.Bind.Size.Y.Offset)}):Play()
			end)

			local function SetKeybind(keyCode)
				if keyCode and keyCode ~= Enum.KeyCode.Unknown then
					KeybindData.Key = keyCode
					KeyBind.Bind.v.Text = keyCode.Name
				else
					KeybindData.Key = nil
					KeyBind.Bind.v.Text = "NONE"
				end
			end

			-- Main input handler
			syde:AddConnection(userinput.InputBegan, function(input)
				if input.UserInputType ~= Enum.UserInputType.Keyboard then return end

				if KeybindData.WaitingForKey then
					KeybindData.WaitingForKey = false
					SetKeybind(input.KeyCode)
					return
				end

				if input.KeyCode == KeybindData.Key then
					KeybindData.Hold = true

					local holdConnection
					holdConnection = input.Changed:Connect(function(prop)
						if prop == "UserInputState" then
							local state = input.UserInputState
							KeybindData.Hold = (state == Enum.UserInputState.Begin)
							if state == Enum.UserInputState.End and holdConnection then
								holdConnection:Disconnect()
							end
						end
					end)

					local success, result = pcall(KeybindData.CallBack)
					if not KeybindData.Holding then
						if not success then
							warn(`[Keybind: {KeyBind.Name}] Callback Error: {result}`)
						end
					else
						if KeybindData.Hold then
							local holdLoop
							holdLoop = runservice.RenderStepped:Connect(function()
								if not KeybindData.Hold then
									KeybindData.CallBack(false)
									holdLoop:Disconnect()
								else
									KeybindData.CallBack(false)
								end
							end)
						end
					end
				end
			end)

		end

		function InitElement:Img(Img)
			local imgData = {
				img = Img.Image
			}

			local ImageBlock = PAGES.Page.img:Clone()
			ImageBlock.Visible = true
			ImageBlock.Parent = Page
			ImageBlock.ImageLabel.Image = 'rbxassetid://'..imgData.img

		end

		function InitElement:Label(Text, Alignment)

			local Label = PAGES.Page.Label:Clone()
			Label.Visible = true
			Label.Parent = Page
			Label.Text.Text = Text

			if Alignment == 'Center' then
				Label.Text.TextXAlignment = Enum.TextXAlignment.Center
			elseif Alignment == 'Right' then
				Label.Text.TextXAlignment = Enum.TextXAlignment.Right
			end

		end

		function InitElement:Paragraph(Paragraph)
			local ParaData = {
				Title = Paragraph.Title;
				Content = Paragraph.Content;
			}

			local Para = PAGES.Page.Paragraph:Clone()
			Para.Visible = true
			Para.Parent = Page
			Para.Title.Text = ParaData.Title
			Para.Content.Text = ParaData.Content

			Para.Content.Size = UDim2.new(1, -20, 0, Para.Content.TextBounds.Y)
			Para.Size = UDim2.new(1, -15, 0, Para.Content.Size.Y.Offset + 45)

			local function updateSize()
				local textSize = textservice:GetTextSize(
					Para.Content.Text,
					Para.Content.TextSize,
					Para.Content.Font,
					Vector2.new(Para.Content.AbsoluteSize.X, math.huge) -- Allows vertical expansion
				)

				local newDescSize = UDim2.new(1, -20, 0, textSize.Y)
				local newButtonSize = UDim2.new(Para.Size.X.Scale, Para.Size.X.Offset, 0, textSize.Y + 40) -- Adding extra padding

				local descTween = tweenservice:Create(Para.Content, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newDescSize })
				descTween:Play()

				local buttonTween = tweenservice:Create(Para, TweenInfo.new(0.3, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), { Size = newButtonSize })
				buttonTween:Play()
			end

			updateSize()

			Para.Content:GetPropertyChangedSignal("TextBounds"):Connect(updateSize)
		end

		return InitElement

	end

	return ldata

end

return syde

