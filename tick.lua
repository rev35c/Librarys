

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

		Library.Enabled = true

		LOADER:Destroy()

	end

end


return syde


