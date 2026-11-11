-- ══════════════════════════════════════════════════════════════
--  NOUSIGI HUB  •  PREMIUM REDESIGN  •  Glassmorphism / Dark Gold
-- ══════════════════════════════════════════════════════════════

if getgenv().Nousigi then
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "Nousigi Hub") then
				v:Destroy()
			end
		end
	end
end
getgenv().Nousigi = true

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')

-- ── COLOR SYSTEM ───────────────────────────────────────────────
local T1UIColor = {
	-- Accent
	["Border Color"]                = Color3.fromRGB(255, 206, 27),
	["Title Text Color"]            = Color3.fromRGB(255, 206, 27),
	["Page Selected Color"]         = Color3.fromRGB(255, 206, 27),
	["Section Underline Color"]     = Color3.fromRGB(255, 206, 27),
	["Toggle Border Color"]         = Color3.fromRGB(255, 206, 27),
	["Button Color"]                = Color3.fromRGB(255, 206, 27),
	["Slider Line Color"]           = Color3.fromRGB(255, 206, 27),
	["Slider Highlight Color"]      = Color3.fromRGB(194, 156, 20),
	["Textbox Highlight Color"]     = Color3.fromRGB(255, 206, 27),
	["Box Highlight Color"]         = Color3.fromRGB(255, 206, 27),
	["Dropdown Selected Color"]     = Color3.fromRGB(255, 206, 27),
	["Dropdown Selected Check Color"] = Color3.fromRGB(219, 177, 23),

	-- Text
	["GUI Text Color"]              = Color3.fromRGB(240, 238, 230),
	["Text Color"]                  = Color3.fromRGB(235, 233, 225),
	["Toggle Checked Color"]        = Color3.fromRGB(240, 238, 230),
	["Toggle Desc Color"]           = Color3.fromRGB(180, 178, 170),
	["Placeholder Text Color"]      = Color3.fromRGB(140, 138, 130),
	["Section Text Color"]          = Color3.fromRGB(220, 218, 210),

	-- Icons
	["Click Effect Color"]          = Color3.fromRGB(230, 230, 230),
	["Setting Icon Color"]          = Color3.fromRGB(220, 218, 210),
	["Search Icon Color"]           = Color3.fromRGB(180, 178, 170),
	["Search Icon Highlight Color"] = Color3.fromRGB(255, 206, 27),
	["Dropdown Icon Color"]         = Color3.fromRGB(200, 198, 190),

	-- Logo
	["Logo Image"]                  = "rbxassetid://5009915795",

	-- Backgrounds (deep dark glass)
	["Background Main Color"]       = Color3.fromRGB(14, 14, 20),
	["Background 1 Color"]          = Color3.fromRGB(32, 32, 44),   -- was 20,20,26 — sáng hơn
	["Background 1 Transparency"]   = 0.45,                          -- was 0.08 — trong hơn
	["Background 2 Color"]          = Color3.fromRGB(42, 42, 56),   -- was 30,30,38
	["Background 3 Color"]          = Color3.fromRGB(52, 52, 66),   -- was 40,40,50
	["Background Image"]            = "",

	-- Label
	["Label Color"]                 = Color3.fromRGB(30, 30, 38),

	-- Tween speeds
	["Tween Animation 1 Speed"]     = DisableAnimation and 0 or 0.22,
	["Tween Animation 2 Speed"]     = DisableAnimation and 0 or 0.40,
	["Tween Animation 3 Speed"]     = DisableAnimation and 0 or 0.10,

	-- Misc
	["Text Stroke Transparency"]    = 0.6,
}

getgenv().UIColor   = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled  = false

-- ── SERVICES ───────────────────────────────────────────────────
local TweenService = game:GetService('TweenService')
local uis          = game:GetService("UserInputService")
local RunService   = game:GetService("RunService")

-- ── HELPERS ────────────────────────────────────────────────────
local Library          = {}
local Library_Function = {}

local function tw(obj, t, props)
	TweenService:Create(obj, TweenInfo.new(t, Enum.EasingStyle.Quint, Enum.EasingDirection.Out), props):Play()
end

local function makeDraggable(topBarObject, object)
	local dragging, dragInput, dragStart, startPosition
	topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragging   = true
			dragStart  = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			TweenService:Create(object, TweenInfo.new(DisableAnimation and 0 or 0.10, Enum.EasingStyle.Linear), {
				Position = UDim2.new(
					startPosition.X.Scale, startPosition.X.Offset + delta.X,
					startPosition.Y.Scale, startPosition.Y.Offset + delta.Y
				)
			}):Play()
		end
	end)
end

function Library_Function.Getcolor(color)
	return {
		math.floor(color.r * 255),
		math.floor(color.g * 255),
		math.floor(color.b * 255)
	}
end

local function colorToRGB(c)
	local r = Library_Function.Getcolor(c)
	return r[1] .. "," .. r[2] .. "," .. r[3]
end

-- ── SCREEN GUIs ────────────────────────────────────────────────
Library_Function.Gui      = Instance.new('ScreenGui')
Library_Function.NotiGui  = Instance.new('ScreenGui')
Library_Function.HideGui  = Instance.new('ScreenGui')

Library_Function.Gui.ZIndexBehavior  = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name            = 'Nousigi Hub GUI'
Library_Function.Gui.Enabled         = false

Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name           = 'Nousigi Hub Notification'

Library_Function.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.HideGui.Name           = 'Nousigi Hub Btn'

getgenv().ReadyForGuiLoaded = false
spawn(function()
	repeat task.wait() until getgenv().ReadyForGuiLoaded
	if getgenv().UIToggled then
		Library_Function.Gui.Enabled = true
	end
end)

-- ── FLOATING TOGGLE BUTTON ─────────────────────────────────────
local btnHide = Instance.new('TextButton', Library_Function.HideGui)
btnHide.BackgroundTransparency = 1
btnHide.Text                   = ""
btnHide.AnchorPoint            = Vector2.new(0, 1)
btnHide.Size                   = UDim2.new(0, 54, 0, 54)
btnHide.Position               = UDim2.new(0, 15, 1, -15)

-- Outer glow ring
local btnGlow = Instance.new('ImageLabel', btnHide)
btnGlow.AnchorPoint          = Vector2.new(0.5, 0.5)
btnGlow.BackgroundTransparency = 1
btnGlow.Position             = UDim2.new(0.5, 0, 0.5, 0)
btnGlow.Size                 = UDim2.new(0, 72, 0, 72)
btnGlow.ZIndex               = 0
btnGlow.Image                = "rbxassetid://5028857084"
btnGlow.ImageTransparency    = 0.55
btnGlow.ImageColor3          = getgenv().UIColor["Title Text Color"]
btnGlow.ScaleType            = Enum.ScaleType.Slice
btnGlow.SliceCenter          = Rect.new(24, 24, 276, 276)

local btnHideFrame = Instance.new('Frame', btnHide)
btnHideFrame.AnchorPoint       = Vector2.new(0, 1)
btnHideFrame.Size              = UDim2.new(0, 54, 0, 54)
btnHideFrame.Position          = UDim2.new(0, 0, 1, 0)
btnHideFrame.Name              = "dut dit"
btnHideFrame.BackgroundColor3  = Color3.fromRGB(14, 14, 18)
btnHideFrame.BackgroundTransparency = getgenv().UIToggled and 0 or 0.25

local btnFrameStroke = Instance.new("UIStroke", btnHideFrame)
btnFrameStroke.Thickness    = 1.5
btnFrameStroke.Color        = getgenv().UIColor["Title Text Color"]
btnFrameStroke.Transparency = 0.4

local imgHide = Instance.new('ImageLabel', btnHide)
imgHide.Image               = getgenv().UIColor["Logo Image"]
imgHide.BackgroundTransparency = 1
imgHide.AnchorPoint         = Vector2.new(0.5, 0.5)
imgHide.Position            = UDim2.new(0.5, 0, 0.5, 0)
local _bsize = getgenv().UIToggled and (getgenv().T1 and 32 or 42) or (getgenv().T1 and 26 or 32)
imgHide.Size                = UDim2.new(0, _bsize, 0, _bsize)

local UICornerBtnHide = Instance.new("UICorner", btnHideFrame)
UICornerBtnHide.CornerRadius = UDim.new(1, 0)

-- RGB pulse on the glow ring
local _rgbAngle = 0
local _rgbConn
local function startBtnRGB()
	if _rgbConn then return end
	_rgbConn = RunService.Heartbeat:Connect(function(dt)
		_rgbAngle = (_rgbAngle + dt * 60) % 360
		local h = _rgbAngle / 360
		btnFrameStroke.Color = Color3.fromHSV(h, 0.7, 1)
		btnGlow.ImageColor3  = Color3.fromHSV(h, 0.6, 1)
	end)
end
local function stopBtnRGB()
	if _rgbConn then _rgbConn:Disconnect(); _rgbConn = nil end
	btnFrameStroke.Color = getgenv().UIColor["Title Text Color"]
	btnGlow.ImageColor3  = getgenv().UIColor["Title Text Color"]
end
startBtnRGB()

Library.ToggleUI = function()
	getgenv().UIToggled = not getgenv().UIToggled
	local sizeXY = getgenv().UIToggled and (getgenv().T1 and 32 or 42) or (getgenv().T1 and 26 or 32)
	tw(imgHide, getgenv().UIColor["Tween Animation 1 Speed"], { Size = UDim2.new(0, sizeXY, 0, sizeXY) })
	tw(btnHideFrame, getgenv().UIColor["Tween Animation 1 Speed"], {
		BackgroundTransparency = getgenv().UIToggled and 0 or 0.25
	})
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for _, b in ipairs(game.CoreGui:GetChildren()) do
			if b.Name == "Nousigi Hub GUI" then
				b.Enabled = getgenv().UIToggled
			end
		end
	end
end

Library.DestroyUI = function()
	stopBtnRGB()
	if game.CoreGui:FindFirstChild("Nousigi Hub GUI") then
		for _, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "Nousigi Hub") then v:Destroy() end
		end
	end
end

-- Draggable float button
do
	local dragging, dragInput, dragStart, startPos = false, nil, nil, nil
	local holdTime, holdStarted = 0.1, 0

	btnHide.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or
		   input.UserInputType == Enum.UserInputType.Touch then
			holdStarted = tick()
			dragStart   = input.Position
			startPos    = btnHide.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging    = false
					holdStarted = 0
				end
			end)
		end
	end)
	btnHide.InputEnded:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragging    = false
			holdStarted = 0
		end
	end)
	btnHide.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or
		   input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	RunService.RenderStepped:Connect(function()
		if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
			dragging = true
		end
		if dragging and dragInput then
			local delta = dragInput.Position - dragStart
			btnHide.Position = UDim2.new(
				startPos.X.Scale, startPos.X.Offset + delta.X,
				startPos.Y.Scale, startPos.Y.Offset + delta.Y
			)
		end
	end)
end

btnHide.MouseButton1Click:Connect(function()
	Library.ToggleUI()
end)

-- ── NOTIFICATION SYSTEM ────────────────────────────────────────
local NotiContainer = Instance.new("Frame", Library_Function.NotiGui)
NotiContainer.Name                 = "NotiContainer"
NotiContainer.AnchorPoint          = Vector2.new(1, 1)
NotiContainer.BackgroundTransparency = 1
NotiContainer.Position             = UDim2.new(1, -8, 1, -8)
NotiContainer.Size                 = UDim2.new(0, 280, 1, -16)

local NotiList = Instance.new("UIListLayout", NotiContainer)
NotiList.SortOrder         = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding           = UDim.new(0, 6)

Library_Function.Gui.Parent     = game:GetService('CoreGui')
Library_Function.NotiGui.Parent = game:GetService('CoreGui')
Library_Function.HideGui.Parent = game:GetService('CoreGui')

-- ── NOTIFICATION BUILDER ───────────────────────────────────────
local libCreateNoti = function(Setting)
	local Title       = Setting.Title or ""
	local Description = Setting.Description or Setting.Desc or Setting.Content or ""
	local Duration    = Setting.Duration or Setting.Timeshow or Setting.Delay or 10
	getgenv().TitleNameNoti = Title

	local NotiFrame     = Instance.new("Frame", NotiContainer)
	local Noticontainer = Instance.new("Frame", NotiFrame)
	local NotiCorner    = Instance.new("UICorner", Noticontainer)
	local NotiStroke    = Instance.new("UIStroke", Noticontainer)
	local NotiGradient  = Instance.new("UIGradient", Noticontainer)
	local AccentBar     = Instance.new("Frame", Noticontainer)
	local AccentCorner  = Instance.new("UICorner", AccentBar)
	local Topnoti       = Instance.new("Frame", Noticontainer)
	local Ruafimg       = Instance.new("ImageLabel", Topnoti)
	local TextLabelNoti = Instance.new("TextLabel", Topnoti)
	local CloseContainer= Instance.new("Frame", Topnoti)
	local CloseImage    = Instance.new("ImageLabel", CloseContainer)
	local TextButton    = Instance.new("TextButton", CloseContainer)
	local Divider       = Instance.new("Frame", Noticontainer)
	local TextLabelNoti2= Instance.new("TextLabel", Noticontainer)

	-- Tính chiều cao noti: title row = 36px, desc thêm tùy text
	-- Dùng fixed height cho title-only, AutomaticSize chỉ trên desc label
	local hasDesc = Description and Description ~= ""

	NotiFrame.Name                 = "NotiFrame"
	NotiFrame.BackgroundTransparency = 1
	NotiFrame.ClipsDescendants     = true
	NotiFrame.Size                 = UDim2.new(1, 0, 0, hasDesc and 0 or 40)
	NotiFrame.AutomaticSize        = hasDesc and Enum.AutomaticSize.Y or Enum.AutomaticSize.None

	Noticontainer.Name              = "Noticontainer"
	Noticontainer.Position          = UDim2.new(1, 0, 0, 0)
	-- Height: 36 header + 8 bottom pad khi không có desc; AutomaticSize handle khi có desc
	Noticontainer.Size              = UDim2.new(1, 0, 0, hasDesc and 0 or 40)
	Noticontainer.AutomaticSize     = hasDesc and Enum.AutomaticSize.Y or Enum.AutomaticSize.None
	Noticontainer.BackgroundColor3  = Color3.fromRGB(14, 14, 20)
	Noticontainer.BackgroundTransparency = 0.05

	NotiCorner.CornerRadius = UDim.new(0, 8)

	NotiStroke.Color        = getgenv().UIColor["Title Text Color"]
	NotiStroke.Thickness    = 1
	NotiStroke.Transparency = 0.55

	NotiGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
	}
	NotiGradient.Rotation    = 100
	NotiGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.90),
		NumberSequenceKeypoint.new(1, 0.95)
	}

	-- Gold accent left bar (3px)
	AccentBar.Name               = "AccentBar"
	AccentBar.BackgroundColor3   = getgenv().UIColor["Title Text Color"]
	AccentBar.BorderSizePixel    = 0
	AccentBar.Position           = UDim2.new(0, 0, 0, 0)
	AccentBar.Size               = UDim2.new(0, 3, 1, 0)
	AccentCorner.CornerRadius    = UDim.new(0, 2)

	-- Header row: 36px tall, padded left of accent bar
	Topnoti.BackgroundTransparency = 1
	Topnoti.Position               = UDim2.new(0, 8, 0, 0)
	Topnoti.Size                   = UDim2.new(1, -8, 0, 36)

	-- Logo icon 18x18, vertically centered in 36px row
	Ruafimg.BackgroundTransparency = 1
	Ruafimg.AnchorPoint            = Vector2.new(0, 0.5)
	Ruafimg.Position               = UDim2.new(0, 4, 0.5, 0)
	Ruafimg.Size                   = UDim2.new(0, 18, 0, 18)
	Ruafimg.Image                  = getgenv().UIColor["Logo Image"]

	TextLabelNoti.Text = "<font color=\"rgb(" .. colorToRGB(getgenv().UIColor['Title Text Color']) .. ")\">"
		.. tostring("Nousigi") .. "</font>  " .. tostring(Title)
	TextLabelNoti.BackgroundTransparency = 1
	TextLabelNoti.Position               = UDim2.new(0, 26, 0, 0)
	TextLabelNoti.Size                   = UDim2.new(1, -50, 1, 0)
	TextLabelNoti.Font                   = Enum.Font.GothamBold
	TextLabelNoti.TextSize               = 12
	TextLabelNoti.TextWrapped            = true
	TextLabelNoti.TextXAlignment         = Enum.TextXAlignment.Left
	TextLabelNoti.RichText               = true
	TextLabelNoti.TextColor3             = getgenv().UIColor["GUI Text Color"]

	-- Close button anchored right of header
	CloseContainer.AnchorPoint          = Vector2.new(1, 0.5)
	CloseContainer.BackgroundTransparency = 1
	CloseContainer.Position             = UDim2.new(1, -4, 0.5, 0)
	CloseContainer.Size                 = UDim2.new(0, 18, 0, 18)

	CloseImage.BackgroundTransparency = 1
	CloseImage.Size                   = UDim2.new(1, 0, 1, 0)
	CloseImage.Image                  = "rbxassetid://3926305904"
	CloseImage.ImageRectOffset        = Vector2.new(284, 4)
	CloseImage.ImageRectSize          = Vector2.new(24, 24)
	CloseImage.ImageColor3            = getgenv().UIColor["Search Icon Color"]

	TextButton.BackgroundTransparency = 1
	TextButton.Size                   = UDim2.new(1, 0, 1, 0)
	TextButton.Font                   = Enum.Font.SourceSans
	TextButton.Text                   = ""
	TextButton.TextSize               = 14

	-- Thin divider under header, only when has desc
	Divider.BackgroundColor3       = getgenv().UIColor["Title Text Color"]
	Divider.BackgroundTransparency = 0.72
	Divider.BorderSizePixel        = 0
	Divider.Position               = UDim2.new(0, 8, 0, 36)
	Divider.Size                   = UDim2.new(1, -16, 0, 1)

	if hasDesc then
		TextLabelNoti2.Name             = 'TextColor'
		TextLabelNoti2.BackgroundTransparency = 1
		TextLabelNoti2.Position         = UDim2.new(0, 10, 0, 40)
		TextLabelNoti2.Size             = UDim2.new(1, -16, 0, 0)
		TextLabelNoti2.Font             = Enum.Font.Gotham
		TextLabelNoti2.Text             = Description
		TextLabelNoti2.TextSize         = 12
		TextLabelNoti2.TextXAlignment   = Enum.TextXAlignment.Left
		TextLabelNoti2.RichText         = true
		TextLabelNoti2.TextColor3       = getgenv().UIColor["Text Color"]
		TextLabelNoti2.AutomaticSize    = Enum.AutomaticSize.Y
		TextLabelNoti2.TextWrapped      = true
	else
		Divider.Visible        = false
		TextLabelNoti2.Visible = false
	end

	local function remove()
		tw(Noticontainer, getgenv().UIColor["Tween Animation 1 Speed"], {
			Position             = UDim2.new(1, 0, 0, 0),
			BackgroundTransparency = 1
		})
		task.wait(0.28)
		NotiFrame:Destroy()
	end

	Noticontainer.Position = UDim2.new(1, 0, 0, 0)
	task.defer(function()
		tw(Noticontainer, getgenv().UIColor["Tween Animation 2 Speed"], {
			Position             = UDim2.new(0, 0, 0, 0),
			BackgroundTransparency = 0.05
		})
	end)

	TextButton.MouseEnter:Connect(function()
		tw(CloseImage, getgenv().UIColor["Tween Animation 3 Speed"], {
			ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
		})
	end)
	TextButton.MouseLeave:Connect(function()
		tw(CloseImage, getgenv().UIColor["Tween Animation 3 Speed"], {
			ImageColor3 = getgenv().UIColor["Search Icon Color"]
		})
	end)
	TextButton.MouseButton1Click:Connect(function()
		task.wait(0.1)
		remove()
	end)
	spawn(function()
		task.wait(Duration)
		remove()
	end)
end

function Library:Notify(Setting, bypass)
	if not getgenv().Config or bypass then
		local ok, err = pcall(libCreateNoti, Setting)
		if err then print(err) end
	end
end

-- ══════════════════════════════════════════════════════════════
--  MAIN WINDOW
-- ══════════════════════════════════════════════════════════════
function Library:CreateWindow(Setting)
	local TitleNameMain = Setting.Title or "Nousigi Hub"
	getgenv().MainDesc  = Setting.Desc or Setting.Subtitle or ""

	if Setting.Image then
		getgenv().UIColor["Logo Image"] = Setting.Image
	end

	local cac = false

	-- ── Root Frame ────────────────────────────────────────────
	local Main = Instance.new("Frame", Library_Function.Gui)
	Main.Name            = "Main"
	Main.BackgroundTransparency = 1
	Main.Position        = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint     = Vector2.new(0.5, 0.5)
	Main.Size            = UDim2.new(0, 650, 0, 370)
	makeDraggable(Main, Main)

	-- Drop shadow
	local Shadow = Instance.new("ImageLabel", Main)
	Shadow.Name               = "Shadow"
	Shadow.AnchorPoint        = Vector2.new(0.5, 0.5)
	Shadow.BackgroundTransparency = 1
	Shadow.Position           = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size               = UDim2.new(1, 60, 1, 60)
	Shadow.ZIndex             = 0
	Shadow.Image              = "rbxassetid://5028857084"
	Shadow.ImageTransparency  = 0.3
	Shadow.ImageColor3        = Color3.fromRGB(0, 0, 0)
	Shadow.ScaleType          = Enum.ScaleType.Slice
	Shadow.SliceCenter        = Rect.new(24, 24, 276, 276)

	-- Glow border
	local maingui = Instance.new("ImageLabel", Main)
	maingui.Name              = "maingui"
	maingui.AnchorPoint       = Vector2.new(0.5, 0.5)
	maingui.BackgroundTransparency = 1
	maingui.Position          = UDim2.new(0.5, 0, 0.5, 0)
	maingui.Size              = UDim2.new(1, 32, 1, 32)
	maingui.Image             = "rbxassetid://8068653048"
	maingui.ScaleType         = Enum.ScaleType.Slice
	maingui.SliceCenter       = Rect.new(15, 15, 175, 175)
	maingui.SliceScale        = 1.3
	maingui.ImageColor3       = getgenv().UIColor["Title Text Color"]
	maingui.ImageTransparency = 0.65

	-- Main container (glass panel)
	local MainContainer = Instance.new("ImageLabel", Main)
	MainContainer.Name              = "MainContainer"
	MainContainer.BackgroundColor3  = Color3.fromRGB(18, 18, 26)
	MainContainer.Size              = UDim2.new(1, 0, 1, 0)
	MainContainer.Image             = ""

	local mcCorner = Instance.new("UICorner", MainContainer)
	mcCorner.CornerRadius = UDim.new(0, 10)

	local mcStroke = Instance.new("UIStroke", MainContainer)
	mcStroke.Thickness    = 1.2
	mcStroke.Color        = Color3.fromRGB(255, 206, 27)
	mcStroke.Transparency = 0.6

	local mcGradient = Instance.new("UIGradient", MainContainer)
	mcGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160))
	}
	mcGradient.Rotation    = 110
	mcGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.88),
		NumberSequenceKeypoint.new(1, 0.94)
	}

	getgenv().ReadyForGuiLoaded = true

	-- Top bar
	local TopMain = Instance.new("Frame", MainContainer)
	TopMain.Name               = "TopMain"
	TopMain.BackgroundTransparency = 1
	TopMain.Size               = UDim2.new(1, 0, 0, 36)

	-- Gold accent line under top bar
	local TopAccent = Instance.new("Frame", TopMain)
	TopAccent.Name              = "TopAccent"
	TopAccent.BackgroundColor3  = getgenv().UIColor["Title Text Color"]
	TopAccent.BackgroundTransparency = 0.55
	TopAccent.BorderSizePixel   = 0
	TopAccent.Position          = UDim2.new(0, 0, 1, -1)
	TopAccent.Size              = UDim2.new(1, 0, 0, 1)

	-- Logo
	local Ruafimg = Instance.new("ImageLabel", TopMain)
	Ruafimg.BackgroundTransparency = 1
	Ruafimg.Position               = UDim2.new(0, 10, 0.5, -10)
	Ruafimg.Size                   = UDim2.new(0, 20, 0, 20)
	Ruafimg.Image                  = getgenv().UIColor["Logo Image"]

	-- Title label
	local TextLabelMain = Instance.new("TextLabel", TopMain)
	TextLabelMain.Name              = "TextLabelMain"
	TextLabelMain.BackgroundTransparency = 1
	TextLabelMain.Position          = UDim2.new(0, 36, 0, 0)
	TextLabelMain.Size              = UDim2.new(1, -50, 1, 0)
	TextLabelMain.Font              = Enum.Font.GothamBold
	TextLabelMain.RichText          = true
	TextLabelMain.TextSize          = 15
	TextLabelMain.TextWrapped       = true
	TextLabelMain.TextXAlignment    = Enum.TextXAlignment.Left
	TextLabelMain.TextColor3        = getgenv().UIColor["GUI Text Color"]
	TextLabelMain.Text = "<font color=\"rgb(" .. colorToRGB(getgenv().UIColor['Title Text Color']) .. ")\">"
		.. tostring(TitleNameMain) .. "</font>  "
		.. "<font color=\"rgb(160,158,150)\">" .. tostring(getgenv().MainDesc) .. "</font>"

	-- RGB stroke on top border (subtle animation)
	local _angle = 0
	RunService.Heartbeat:Connect(function(dt)
		if not Library_Function.Gui.Enabled then return end
		_angle = (_angle + dt * 40) % 360
		mcStroke.Color = Color3.fromHSV(_angle / 360, 0.55, 1)
	end)

	-- Content area
	local Concacontainer = Instance.new("Frame", MainContainer)
	Concacontainer.Name                = "Concacontainer"
	Concacontainer.BackgroundTransparency = 1
	Concacontainer.ClipsDescendants    = true
	Concacontainer.Position            = UDim2.new(0, 0, 0, 36)
	Concacontainer.Size                = UDim2.new(1, 0, 1, -36)

	local Concacmain = Instance.new("Frame", Concacontainer)
	Concacmain.Name                = "Concacmain"
	Concacmain.BackgroundTransparency = 1
	Concacmain.Size                = UDim2.new(1, 0, 1, 0)

	-- ── SIDEBAR ───────────────────────────────────────────────
	local PageControl = Instance.new("Frame", Concacmain)
	PageControl.Name              = "Background1"
	PageControl.Position          = UDim2.new(0, 6, 0, 6)
	PageControl.Size              = UDim2.new(0, 180, 1, -12)
	PageControl.BackgroundColor3  = Color3.fromRGB(22, 22, 32)
	PageControl.BackgroundTransparency = 0.3

	local pcCorner = Instance.new("UICorner", PageControl)
	pcCorner.CornerRadius = UDim.new(0, 8)

	local pcStroke = Instance.new("UIStroke", PageControl)
	pcStroke.Color       = Color3.fromRGB(255, 206, 27)
	pcStroke.Thickness   = 1
	pcStroke.Transparency = 0.72

	local pcGradient = Instance.new("UIGradient", PageControl)
	pcGradient.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(180, 180, 180))
	}
	pcGradient.Rotation    = 100
	pcGradient.Transparency = NumberSequence.new{
		NumberSequenceKeypoint.new(0, 0.88),
		NumberSequenceKeypoint.new(1, 0.95)
	}

	-- Sidebar title
	local ControlTitle = Instance.new("TextLabel", PageControl)
	ControlTitle.Name              = "GUITextColor"
	ControlTitle.BackgroundTransparency = 1
	ControlTitle.Position          = UDim2.new(0, 10, 0, 0)
	ControlTitle.Size              = UDim2.new(1, -20, 0, 32)
	ControlTitle.Font              = Enum.Font.GothamBold
	ControlTitle.Text              = TitleNameMain
	ControlTitle.TextSize          = 13
	ControlTitle.TextXAlignment    = Enum.TextXAlignment.Left
	ControlTitle.TextColor3        = getgenv().UIColor["Title Text Color"]

	-- Sidebar title underline
	local SidebarLine = Instance.new("Frame", PageControl)
	SidebarLine.BackgroundColor3  = getgenv().UIColor["Title Text Color"]
	SidebarLine.BackgroundTransparency = 0.65
	SidebarLine.BorderSizePixel   = 0
	SidebarLine.Position          = UDim2.new(0, 8, 0, 31)
	SidebarLine.Size              = UDim2.new(1, -16, 0, 1)

	-- Global search bar in sidebar
	local SideSearchFrame = Instance.new("Frame", PageControl)
	SideSearchFrame.Name             = "PageSearch"
	SideSearchFrame.AnchorPoint      = Vector2.new(0, 0)
	SideSearchFrame.BackgroundColor3 = Color3.fromRGB(36, 36, 50)
	SideSearchFrame.Position         = UDim2.new(0, 8, 0, 36)
	SideSearchFrame.Size             = UDim2.new(1, -16, 0, 24)
	SideSearchFrame.ClipsDescendants = true

	local SideSearchCorner = Instance.new("UICorner", SideSearchFrame)
	SideSearchCorner.CornerRadius = UDim.new(0, 6)

	local SideSearchStroke = Instance.new("UIStroke", SideSearchFrame)
	SideSearchStroke.Color       = Color3.fromRGB(80, 78, 60)
	SideSearchStroke.Thickness   = 1
	SideSearchStroke.Transparency = 0.4

	local SideSearchIcon = Instance.new("ImageLabel", SideSearchFrame)
	SideSearchIcon.BackgroundTransparency = 1
	SideSearchIcon.AnchorPoint            = Vector2.new(0, 0.5)
	SideSearchIcon.Position               = UDim2.new(0, 6, 0.5, 0)
	SideSearchIcon.Size                   = UDim2.new(0, 14, 0, 14)
	SideSearchIcon.Image                  = "rbxassetid://8154282545"
	SideSearchIcon.ImageColor3            = getgenv().UIColor["Search Icon Color"]

	local SideSearchBox = Instance.new("TextBox", SideSearchFrame)
	SideSearchBox.Name              = "SearchBox"
	SideSearchBox.BackgroundTransparency = 1
	SideSearchBox.Position          = UDim2.new(0, 24, 0, 0)
	SideSearchBox.Size              = UDim2.new(1, -28, 1, 0)
	SideSearchBox.Font              = Enum.Font.Gotham
	SideSearchBox.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
	SideSearchBox.PlaceholderText   = "Search..."
	SideSearchBox.Text              = ""
	SideSearchBox.TextColor3        = getgenv().UIColor["Text Color"]
	SideSearchBox.TextSize          = 12
	SideSearchBox.TextXAlignment    = Enum.TextXAlignment.Left

	-- Tab list
	local ControlList = Instance.new("ScrollingFrame", PageControl)
	ControlList.Name               = "ControlList"
	ControlList.Active             = true
	ControlList.BackgroundTransparency = 1
	ControlList.BorderSizePixel    = 0
	ControlList.Position           = UDim2.new(0, 0, 0, 65)
	ControlList.Size               = UDim2.new(1, -4, 1, -70)
	ControlList.BottomImage        = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.CanvasSize         = UDim2.new(0, 0, 0, 0)
	ControlList.ScrollBarThickness = 3
	ControlList.TopImage           = "rbxasset://textures/ui/Scroll/scroll-middle.png"

	local UIListLayout = Instance.new("UIListLayout", ControlList)
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding   = UDim.new(0, 4)

	local UIPadding = Instance.new("UIPadding", ControlList)
	UIPadding.PaddingLeft  = UDim.new(0, 6)
	UIPadding.PaddingRight = UDim.new(0, 2)
	UIPadding.PaddingTop   = UDim.new(0, 4)

	-- ── PAGE AREA ─────────────────────────────────────────────
	local MainPage = Instance.new("Frame", Concacmain)
	MainPage.Name              = "MainPage"
	MainPage.BackgroundTransparency = 1
	MainPage.ClipsDescendants  = true
	MainPage.Position          = UDim2.new(0, 194, 0, 6)
	MainPage.Size              = UDim2.new(1, -200, 1, -12)

	local UIPage = Instance.new("UIPageLayout", MainPage)
	UIPage.Name            = "UIPage"
	UIPage.FillDirection   = Enum.FillDirection.Vertical
	UIPage.SortOrder       = Enum.SortOrder.LayoutOrder
	UIPage.EasingDirection = Enum.EasingDirection.InOut
	UIPage.EasingStyle     = Enum.EasingStyle.Quint
	UIPage.Padding         = UDim.new(0, 10)
	UIPage.TweenTime       = getgenv().UIColor["Tween Animation 1 Speed"]

	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
	end)

	-- ── GLOBAL SEARCH ─────────────────────────────────────────
	if not GlobalSearch then
		GlobalSearch = function(searchText)
			searchText = string.lower(searchText)
			if searchText == "" then
				for _, control in pairs(getgenv().AllControls) do
					control.TabButton.Visible = true
					control.Section.Visible   = true
					control.Element.Visible   = true
				end
				for _, tab in pairs(ControlList:GetChildren()) do
					if not tab:IsA('UIListLayout') and not tab:IsA('UIPadding') then
						tab.Visible = true
					end
				end
				return
			end
			for _, control in pairs(getgenv().AllControls) do
				control.Section.Visible = false
				control.Element.Visible = false
			end
			for _, tab in pairs(ControlList:GetChildren()) do
				if not tab:IsA('UIListLayout') and not tab:IsA('UIPadding') then
					tab.Visible = false
				end
			end
			local sectionsWithElements = {}
			local elementsInSection    = {}
			for _, control in pairs(getgenv().AllControls) do
				local elementName = string.lower(control.Name or "")
				local sectionName = string.lower(control.SectionName or "")
				local elementFound = string.find(elementName, searchText, 1, true) ~= nil
				local sectionFound = string.find(sectionName, searchText, 1, true) ~= nil
				if not elementsInSection[control.Section] then
					elementsInSection[control.Section] = {}
				end
				table.insert(elementsInSection[control.Section], {
					control      = control,
					elementFound = elementFound,
					sectionFound = sectionFound
				})
				if elementFound then
					sectionsWithElements[control.Section] = true
				end
			end
			local foundTabs = {}
			for section, elements in pairs(elementsInSection) do
				local hasElementMatch = false
				local shouldShowSection = false
				for _, ei in ipairs(elements) do
					if ei.sectionFound then shouldShowSection = true end
					if ei.elementFound then hasElementMatch = true end
				end
				for _, ei in ipairs(elements) do
					local ctrl = ei.control
					if ei.elementFound then
						ctrl.Element.Visible = true
						if ei.sectionFound or hasElementMatch then
							ctrl.Section.Visible = true
						end
						foundTabs[ctrl.TabName] = true
						ctrl.TabButton.Visible  = true
					elseif ei.sectionFound and not hasElementMatch then
						ctrl.Section.Visible = true
						ctrl.Element.Visible = false
						foundTabs[ctrl.TabName] = true
						ctrl.TabButton.Visible  = true
					end
				end
			end
			for tabName in pairs(foundTabs) do
				for _, tab in pairs(ControlList:GetChildren()) do
					if not tab:IsA('UIListLayout') and not tab:IsA('UIPadding')
					and string.find(tab.Name, tabName, 1, true) then
						tab.Visible = true
					end
				end
			end
		end
	end

	SideSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		GlobalSearch(SideSearchBox.Text)
	end)

	-- ── TAB / SECTION / ELEMENT BUILDERS ──────────────────────
	local Main_Function   = {}
	local LayoutOrderBut  = -1
	local LayoutOrder     = -1
	local PageCounter     = 1

	function Main_Function:AddTab(PageName)
		local Page_Name  = tostring(PageName)
		local Page_Title = Page_Name

		LayoutOrder    = LayoutOrder    + 1
		LayoutOrderBut = LayoutOrderBut + 1

		-- ── Tab button ──────────────────────────────────────
		local PageNameFrame = Instance.new("Frame", ControlList)
		PageNameFrame.Name              = Page_Name .. "_Control"
		PageNameFrame.BackgroundTransparency = 1
		PageNameFrame.Size              = UDim2.new(1, -4, 0, 32)
		PageNameFrame.LayoutOrder       = LayoutOrderBut

		local TabBG = Instance.new("Frame", PageNameFrame)
		TabBG.Name                = "Frame"
		TabBG.BackgroundColor3    = Color3.fromRGB(36, 36, 50)
		TabBG.BackgroundTransparency = 1
		TabBG.BorderSizePixel     = 0
		TabBG.Size                = UDim2.new(1, 0, 1, 0)

		local TabBGCorner = Instance.new("UICorner", TabBG)
		TabBGCorner.CornerRadius = UDim.new(0, 7)

		-- Active indicator line
		local Line = Instance.new("Frame", TabBG)
		Line.Name              = "Line"
		Line.AnchorPoint       = Vector2.new(0, 0.5)
		Line.BackgroundTransparency = 1
		Line.Position          = UDim2.new(0, 0, 0.5, 0)
		Line.Size              = UDim2.new(0, 4, 1, 0)

		local InLine = Instance.new("Frame", Line)
		InLine.Name              = "PageInLine"
		InLine.AnchorPoint       = Vector2.new(0.5, 0.5)
		InLine.BorderSizePixel   = 0
		InLine.Position          = UDim2.new(0.5, 0, 0.5, 0)
		InLine.Size              = UDim2.new(1, 0, 0.6, 0)
		InLine.BackgroundColor3  = getgenv().UIColor["Title Text Color"]
		InLine.BackgroundTransparency = 1

		local InLineCorner = Instance.new("UICorner", InLine)
		InLineCorner.CornerRadius = UDim.new(1, 0)

		-- Tab title
		local TabTitleContainer = Instance.new("Frame", TabBG)
		TabTitleContainer.BackgroundTransparency = 1
		TabTitleContainer.Position               = UDim2.new(0, 10, 0, 0)
		TabTitleContainer.Size                   = UDim2.new(1, -14, 1, 0)

		local TabTitle = Instance.new("TextLabel", TabTitleContainer)
		TabTitle.Name              = "GUITextColor"
		TabTitle.BackgroundTransparency = 1
		TabTitle.Size              = UDim2.new(1, 0, 1, 0)
		TabTitle.Font              = Enum.Font.GothamBold
		TabTitle.Text              = Page_Name
		TabTitle.TextColor3        = getgenv().UIColor["GUI Text Color"]
		TabTitle.TextSize          = 13
		TabTitle.TextXAlignment    = Enum.TextXAlignment.Left

		local PageButton = Instance.new("TextButton", PageNameFrame)
		PageButton.Name              = "PageButton"
		PageButton.BackgroundTransparency = 1
		PageButton.Size              = UDim2.new(1, 0, 1, 0)
		PageButton.Font              = Enum.Font.SourceSans
		PageButton.Text              = ""
		PageButton.TextColor3        = Color3.fromRGB(0, 0, 0)
		PageButton.TextSize          = 14

		PageButton.MouseEnter:Connect(function()
			tw(TabBG, 0.12, { BackgroundTransparency = 0.7 })
		end)
		PageButton.MouseLeave:Connect(function()
			local isActive = (InLine.BackgroundTransparency == 0)
			tw(TabBG, 0.15, { BackgroundTransparency = isActive and 0.3 or 1 })
		end)

		-- ── Page container ──────────────────────────────────
		local CurrentPage = PageCounter
		PageCounter = PageCounter + 1

		local PageContainer = Instance.new("Frame", MainPage)
		PageContainer.Name                 = "Page" .. CurrentPage
		PageContainer.BackgroundColor3     = Color3.fromRGB(22, 22, 32)
		PageContainer.BackgroundTransparency = 0.3
		PageContainer.Position             = UDim2.new(0, 0, 0, 0)
		PageContainer.Size                 = UDim2.new(1, 0, 1, 0)
		PageContainer.LayoutOrder          = LayoutOrder

		local pcCon = Instance.new("UICorner", PageContainer)
		pcCon.CornerRadius = UDim.new(0, 8)

		local pcConStroke = Instance.new("UIStroke", PageContainer)
		pcConStroke.Color       = Color3.fromRGB(80, 78, 60)
		pcConStroke.Thickness   = 1
		pcConStroke.Transparency = 0.5

		local pcConGrad = Instance.new("UIGradient", PageContainer)
		pcConGrad.Color = ColorSequence.new{
			ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
			ColorSequenceKeypoint.new(1, Color3.fromRGB(160, 160, 160))
		}
		pcConGrad.Rotation    = 110
		pcConGrad.Transparency = NumberSequence.new{
			NumberSequenceKeypoint.new(0, 0.90),
			NumberSequenceKeypoint.new(1, 0.96)
		}

		-- Page title
		local PageTitle = Instance.new("TextLabel", PageContainer)
		PageTitle.Name              = "GUITextColor"
		PageTitle.BackgroundTransparency = 1
		PageTitle.Position          = UDim2.new(0, 12, 0, 0)
		PageTitle.Size              = UDim2.new(1, -50, 0, 30)
		PageTitle.Font              = Enum.Font.GothamBold
		PageTitle.Text              = "<font color=\"rgb("
			.. colorToRGB(getgenv().UIColor["Title Text Color"]) .. ")\">"
			.. Page_Title .. "</font>"
		PageTitle.RichText          = true
		PageTitle.TextSize          = 15
		PageTitle.TextXAlignment    = Enum.TextXAlignment.Left
		PageTitle.TextColor3        = getgenv().UIColor["GUI Text Color"]

		-- Page title underline
		local PageTitleLine = Instance.new("Frame", PageContainer)
		PageTitleLine.BackgroundColor3  = getgenv().UIColor["Title Text Color"]
		PageTitleLine.BackgroundTransparency = 0.65
		PageTitleLine.BorderSizePixel   = 0
		PageTitleLine.Position          = UDim2.new(0, 8, 0, 29)
		PageTitleLine.Size              = UDim2.new(1, -16, 0, 1)

		-- Per-page search
		local PageSearch        = Instance.new("Frame", PageContainer)
		local PageSearchCorner  = Instance.new("UICorner", PageSearch)
		local PageSearchIcon    = Instance.new("ImageLabel", PageSearch)
		local PageSearchButton  = Instance.new("TextButton", PageSearch)
		local PageSearchBox     = Instance.new("TextBox", PageSearch)

		PageSearch.Name              = "Page Search"
		PageSearch.AnchorPoint       = Vector2.new(1, 0)
		PageSearch.BackgroundColor3  = Color3.fromRGB(36, 36, 50)
		PageSearch.Position          = UDim2.new(1, -8, 0, 6)
		PageSearch.Size              = UDim2.new(0, 22, 0, 22)
		PageSearch.ClipsDescendants  = true

		PageSearchCorner.CornerRadius = UDim.new(0, 5)

		local psStroke = Instance.new("UIStroke", PageSearch)
		psStroke.Color       = Color3.fromRGB(80, 78, 60)
		psStroke.Thickness   = 1
		psStroke.Transparency = 0.4

		PageSearchIcon.Name              = "SearchIcon"
		PageSearchIcon.AnchorPoint       = Vector2.new(0.5, 0.5)
		PageSearchIcon.BackgroundTransparency = 1
		PageSearchIcon.Position          = UDim2.new(0, 11, 0.5, 0)
		PageSearchIcon.Size              = UDim2.new(0, 14, 0, 14)
		PageSearchIcon.Image             = "rbxassetid://8154282545"
		PageSearchIcon.ImageColor3       = getgenv().UIColor["Search Icon Color"]

		PageSearchButton.Name              = "Search Button"
		PageSearchButton.BackgroundTransparency = 1
		PageSearchButton.Size              = UDim2.new(0, 22, 0, 22)
		PageSearchButton.Font              = Enum.Font.SourceSans
		PageSearchButton.Text              = ""
		PageSearchButton.TextColor3        = Color3.fromRGB(0, 0, 0)
		PageSearchButton.TextSize          = 14

		PageSearchBox.Name              = "Search Box"
		PageSearchBox.BackgroundTransparency = 1
		PageSearchBox.Position          = UDim2.new(0, 28, 0, 0)
		PageSearchBox.Size              = UDim2.new(1, -32, 1, 0)
		PageSearchBox.Font              = Enum.Font.Gotham
		PageSearchBox.Text              = ""
		PageSearchBox.TextSize          = 12
		PageSearchBox.TextXAlignment    = Enum.TextXAlignment.Left
		PageSearchBox.PlaceholderText   = "Search..."
		PageSearchBox.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
		PageSearchBox.TextColor3        = getgenv().UIColor["Text Color"]

		local psOpen = false

		PageSearchButton.MouseEnter:Connect(function()
			tw(PageSearchIcon, getgenv().UIColor["Tween Animation 3 Speed"], {
				ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
			})
		end)
		PageSearchButton.MouseLeave:Connect(function()
			tw(PageSearchIcon, getgenv().UIColor["Tween Animation 3 Speed"], {
				ImageColor3 = getgenv().UIColor["Search Icon Color"]
			})
		end)
		PageSearchButton.MouseButton1Click:Connect(function()
			psOpen = not psOpen
			tw(PageSearch, getgenv().UIColor["Tween Animation 2 Speed"], {
				Size = psOpen and UDim2.new(0, 180, 0, 22) or UDim2.new(0, 22, 0, 22)
			})
		end)

		-- Page scroll list
		local PageList = Instance.new("ScrollingFrame", PageContainer)
		PageList.Name               = "PageList"
		PageList.Active             = true
		PageList.BackgroundTransparency = 1
		PageList.BorderSizePixel    = 0
		PageList.Position           = UDim2.new(0, 6, 0, 36)
		PageList.Size               = UDim2.new(1, -12, 1, -40)
		PageList.BottomImage        = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollBarThickness = 3
		PageList.TopImage           = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageList.ScrollingEnabled   = true
		PageList.VerticalScrollBarInset = Enum.ScrollBarInset.Always

		local Pagelistlayout = Instance.new("UIListLayout", PageList)
		Pagelistlayout.SortOrder = Enum.SortOrder.LayoutOrder
		Pagelistlayout.Padding   = UDim.new(0, 6)

		local PageListPad = Instance.new("UIPadding", PageList)
		PageListPad.PaddingTop  = UDim.new(0, 2)
		PageListPad.PaddingBottom = UDim.new(0, 6)

		Pagelistlayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageList.CanvasSize = UDim2.new(0, 0, 0, Pagelistlayout.AbsoluteContentSize.Y + 10)
		end)

		local function hideOtherFrame()
			for _, v in next, PageList:GetChildren() do
				if not v:IsA('UIListLayout') and not v:IsA('UIPadding') then
					v.Visible = false
				end
			end
		end
		local function showFrameName()
			for _, v in pairs(PageList:GetChildren()) do
				if not v:IsA('UIListLayout') and not v:IsA('UIPadding') then
					if string.find(string.lower(v.Name), string.lower(PageSearchBox.Text)) then
						v.Visible = true
					end
				end
			end
		end
		PageSearchBox:GetPropertyChangedSignal("Text"):Connect(function()
			hideOtherFrame()
			showFrameName()
		end)

		-- Auto-select first tab after a frame so children are parented
		if LayoutOrderBut == 0 then
			task.defer(function()
				for _, v in pairs(ControlList:GetChildren()) do
					if not v:IsA('UIListLayout') and not v:IsA('UIPadding') then
						pcall(function()
							if v.Frame and v.Frame:FindFirstChild("Line") then
								v.Frame.Line.PageInLine.BackgroundTransparency = 0
								v.Frame.BackgroundTransparency = 0.3
							end
						end)
						break
					end
				end
			end)
		end

		-- Tab click logic
		PageButton.MouseButton1Click:Connect(function()
			if tostring(UIPage.CurrentPage) == PageContainer.Name then return end

			for _, v in pairs(MainPage:GetChildren()) do
				if not v:IsA('UIPageLayout') then v.Visible = false end
			end
			PageContainer.Visible = true
			UIPage:JumpTo(PageContainer)

			for _, v in next, ControlList:GetChildren() do
				if not v:IsA('UIListLayout') and not v:IsA('UIPadding') then
					local isThis = (v.Name == Page_Name .. "_Control")
					pcall(function()
						tw(v.Frame.Line.PageInLine,
							getgenv().UIColor["Tween Animation 1 Speed"],
							{ BackgroundTransparency = isThis and 0 or 1 })
						tw(v.Frame,
							getgenv().UIColor["Tween Animation 1 Speed"],
							{ BackgroundTransparency = isThis and 0.3 or 1 })
						local lbl = v:FindFirstChild("GUITextColor")
							or (v.Frame and v.Frame:FindFirstChildWhichIsA("TextLabel"))
						if lbl then
							tw(lbl, getgenv().UIColor["Tween Animation 1 Speed"], {
								TextColor3 = isThis
									and getgenv().UIColor["Title Text Color"]
									or  getgenv().UIColor["GUI Text Color"]
							})
						end
					end)
				end
			end
		end)

		-- ── Section builder ──────────────────────────────────
		local pageFunction = {}

		function pageFunction:AddSection(Section_Name, Toggleable, SectionGap, SectionColor)
			Toggleable = Toggleable or false

			local Section    = Instance.new("Frame", PageList)
			local SCorner    = Instance.new("UICorner", Section)
			local SStroke    = Instance.new("UIStroke", Section)
			local SGradient  = Instance.new("UIGradient", Section)
			local Topsec     = Instance.new("Frame", Section)
			local Sectiontitle = Instance.new("TextLabel", Topsec)
			local Linesec    = Instance.new("Frame", Topsec)
			local LGradient  = Instance.new("UIGradient", Linesec)
			local SectionList = Instance.new("UIListLayout", Section)

			Section.Name                = Section_Name .. "_Dot"
			Section.Size               = UDim2.new(1, 0, 0, 30)
			-- Glass mid-tone: không quá tối, blend với page background
			Section.BackgroundColor3   = Color3.fromRGB(28, 28, 38)
			Section.BackgroundTransparency = 0.35
			Section.ClipsDescendants   = false

			SCorner.CornerRadius = UDim.new(0, 8)

			-- Stroke vàng mờ hơn, tinh tế
			SStroke.Color        = Color3.fromRGB(255, 206, 27)
			SStroke.Thickness    = 1
			SStroke.Transparency = 0.78

			-- Gradient nhẹ từ trên xuống
			SGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(200, 200, 200))
			}
			SGradient.Rotation    = 100
			SGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.72),
				NumberSequenceKeypoint.new(1, 0.82)
			}

			Topsec.Name              = "Topsec"
			Topsec.BackgroundTransparency = 1
			Topsec.Size              = UDim2.new(1, 0, 0, 30)

			Sectiontitle.Name         = "Sectiontitle"
			Sectiontitle.BackgroundTransparency = 1
			Sectiontitle.Position     = UDim2.new(0, 12, 0, 0)
			Sectiontitle.Size         = UDim2.new(1, -24, 1, 0)
			Sectiontitle.Font         = Enum.Font.GothamBold
			Sectiontitle.Text         = Section_Name
			Sectiontitle.TextSize     = 13
			Sectiontitle.TextColor3   = getgenv().UIColor["Title Text Color"]
			Sectiontitle.TextXAlignment = Enum.TextXAlignment.Left

			Linesec.Name              = "Linesec"
			Linesec.AnchorPoint       = Vector2.new(0.5, 1)
			Linesec.BorderSizePixel   = 0
			Linesec.Position          = UDim2.new(0.5, 0, 1, -1)
			Linesec.Size              = UDim2.new(1, -16, 0, 1)
			Linesec.BackgroundColor3  = getgenv().UIColor["Title Text Color"]
			Linesec.BackgroundTransparency = 0.5

			LGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.3, 0),
				NumberSequenceKeypoint.new(0.7, 0),
				NumberSequenceKeypoint.new(1, 1)
			}

			SectionList.Name       = "SectionList"
			SectionList.SortOrder  = Enum.SortOrder.LayoutOrder
			SectionList.Padding    = UDim.new(0, 4)

			-- Topsec luôn đầu (LayoutOrder = 0), elements dùng LayoutOrder >= 1
			-- UIPadding chỉ left/right/bottom, KHÔNG paddingTop vì Topsec đã trong layout
			local SectionListPad = Instance.new("UIPadding", Section)
			SectionListPad.PaddingTop    = UDim.new(0, 0)
			SectionListPad.PaddingBottom = UDim.new(0, 6)
			SectionListPad.PaddingLeft   = UDim.new(0, 4)
			SectionListPad.PaddingRight  = UDim.new(0, 4)

			-- Topsec phải LayoutOrder = 0 để UIListLayout xếp nó trước elements
			Topsec.LayoutOrder = 0

			local SizeSectionY    = 30
			local sectionIsVisible = false

			if Toggleable then
				local VisibilitySectionFrame = Instance.new("Frame", Topsec)
				local VisibilitySectionFrameCorner = Instance.new("UICorner", VisibilitySectionFrame)
				local visibility     = Instance.new("ImageButton", VisibilitySectionFrame)
				local visibility_off = Instance.new("ImageButton", VisibilitySectionFrame)
				local VisibilityButton = Instance.new("TextButton", Topsec)

				VisibilityButton.Name     = "VisibilityButton"
				VisibilityButton.AnchorPoint = Vector2.new(1, 0.5)
				VisibilityButton.BackgroundTransparency = 1
				VisibilityButton.BorderSizePixel = 0
				VisibilityButton.Font     = Enum.Font.SourceSans
				VisibilityButton.Text     = ""
				VisibilityButton.TextSize = 14
				VisibilityButton.ZIndex   = 2
				VisibilityButton.Position = UDim2.new(1, -6, 0.5, 0)
				VisibilityButton.Size     = UDim2.new(0, 20, 0, 20)

				VisibilitySectionFrame.Name       = "VisibilitySectionFrame"
				VisibilitySectionFrame.AnchorPoint = Vector2.new(1, 0.5)
				VisibilitySectionFrame.BackgroundColor3 = Color3.fromRGB(38, 38, 52)
				VisibilitySectionFrame.BorderSizePixel  = 0
				VisibilitySectionFrame.Position   = UDim2.new(1, -6, 0.5, 0)
				VisibilitySectionFrame.Size       = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrameCorner.CornerRadius = UDim.new(0, 4)

				visibility.Name              = "visibility"
				visibility.AnchorPoint       = Vector2.new(0.5, 0.5)
				visibility.BackgroundTransparency = 1
				visibility.LayoutOrder       = 4
				visibility.Position          = UDim2.new(0.5, 0, 0.5, 0)
				visibility.Size              = UDim2.new(1, -4, 1, -4)
				visibility.ZIndex            = 2
				visibility.Image             = "rbxassetid://3926307971"
				visibility.ImageRectOffset   = Vector2.new(84, 44)
				visibility.ImageRectSize     = Vector2.new(36, 36)
				visibility.ImageTransparency = 1

				visibility_off.Name              = "visibility_off"
				visibility_off.AnchorPoint       = Vector2.new(0.5, 0.5)
				visibility_off.BackgroundTransparency = 1
				visibility_off.LayoutOrder       = 4
				visibility_off.Position          = UDim2.new(0.5, 0, 0.5, 0)
				visibility_off.Size              = UDim2.new(1, -4, 1, -4)
				visibility_off.ZIndex            = 2
				visibility_off.Image             = "rbxassetid://3926307971"
				visibility_off.ImageRectOffset   = Vector2.new(564, 44)
				visibility_off.ImageRectSize     = Vector2.new(36, 36)
				visibility_off.ImageTransparency = 0

				VisibilityButton.MouseButton1Down:Connect(function()
					sectionIsVisible = not sectionIsVisible
					tw(visibility,     getgenv().UIColor["Tween Animation 1 Speed"] / 2, { ImageTransparency = sectionIsVisible and 0 or 1 })
					task.wait(getgenv().UIColor["Tween Animation 1 Speed"] / 4)
					tw(visibility_off, getgenv().UIColor["Tween Animation 1 Speed"] / 2, { ImageTransparency = sectionIsVisible and 1 or 0 })
					tw(Section,        getgenv().UIColor["Tween Animation 1 Speed"], {
						Size = UDim2.new(1, 0, 0, sectionIsVisible and SizeSectionY or 30)
					})
				end)
			end

			if SectionGap then
				local SectionGapFrame = Instance.new("Frame", PageList)
				SectionGapFrame.Name   = "SectionGap"
				SectionGapFrame.Size   = UDim2.new(1, 0, 0, 10)
				SectionGapFrame.BackgroundTransparency = 1
			end

			SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				-- AbsoluteContentSize đã gồm Topsec(30) + elements + gaps
				-- UIPadding bottom=6 được Roblox tính vào Size tự động
				-- Chỉ cộng thêm 10px buffer để không bị clip bottom
				local newH = SectionList.AbsoluteContentSize.Y + 10
				if not Toggleable then
					Section.Size = UDim2.new(1, 0, 0, newH)
				end
				SizeSectionY = newH
				if sectionIsVisible then
					tw(Section, getgenv().UIColor["Tween Animation 1 Speed"], {
						Size = UDim2.new(1, 0, 0, SizeSectionY)
					})
				end
			end)

			-- ── ELEMENT BUILDERS ──────────────────────────────────
			local sectionFunction = {}

			-- ── TOGGLE ────────────────────────────────────────────
			function sectionFunction:AddToggle(idk, Setting)
				local Title    = tostring(Setting.Text or Setting.Title) or ""
				local Desc     = Setting.Desc or Setting.Description
				local Default  = Setting.Default
				if Default == nil then Default = false end
				local Callback = Setting.Callback

				-- Toggle height: 36px no-desc, 52px với desc
				local toggleH = Desc and 52 or 36

				local ToggleFrame  = Instance.new("Frame", Section)
				local TogFrame1    = Instance.new("Frame", ToggleFrame)
				local PillBG       = Instance.new("Frame", TogFrame1)
				local PillBGCorner = Instance.new("UICorner", PillBG)
				local PillFill     = Instance.new("Frame", PillBG)
				local PillFillCorner = Instance.new("UICorner", PillFill)
				local PillKnob     = Instance.new("Frame", PillBG)
				local PillKnobCorner = Instance.new("UICorner", PillKnob)
				local PillGlow     = Instance.new("ImageLabel", PillBG)
				local ToggleTitle  = Instance.new("TextLabel", TogFrame1)
				local ToggleDesc   = Instance.new("TextLabel", TogFrame1)
				local ToggleBg     = Instance.new("Frame", TogFrame1)
				local ToggleCorner = Instance.new("UICorner", ToggleBg)
				local ToggleButton = Instance.new("TextButton", TogFrame1)
				local ToggleList   = Instance.new("UIListLayout", ToggleFrame)

				-- ToggleFrame: fixed height, no AutomaticSize
				ToggleFrame.Name                 = "ToggleFrame"
				ToggleFrame.BackgroundTransparency = 1
				ToggleFrame.Size                 = UDim2.new(1, 0, 0, toggleH)
				ToggleFrame.AutomaticSize        = Enum.AutomaticSize.None
				ToggleFrame.ClipsDescendants     = true

				-- TogFrame1: fills ToggleFrame, no AnchorPoint trick
				TogFrame1.Name                 = "TogFrame1"
				TogFrame1.BackgroundTransparency = 1
				TogFrame1.Position             = UDim2.new(0, 5, 0, 0)
				TogFrame1.Size                 = UDim2.new(1, -10, 1, 0)
				TogFrame1.AutomaticSize        = Enum.AutomaticSize.None
				TogFrame1.ClipsDescendants     = false

				-- Pill: absolute position right side, vertically centered
				PillBG.Name              = "PillBG"
				PillBG.AnchorPoint       = Vector2.new(1, 0.5)
				PillBG.BackgroundColor3  = Default and Color3.fromRGB(255, 206, 27) or Color3.fromRGB(44, 44, 60)
				PillBG.Position          = UDim2.new(1, -6, 0.5, 0)
				PillBG.Size              = UDim2.new(0, 44, 0, 22)
				PillBGCorner.CornerRadius = UDim.new(1, 0)

				local pillStroke = Instance.new("UIStroke", PillBG)
				pillStroke.Color        = Default and Color3.fromRGB(255, 226, 80) or Color3.fromRGB(80, 78, 60)
				pillStroke.Thickness    = 1
				pillStroke.Transparency = 0.4

				PillFill.Name                   = "PillFill"
				PillFill.BackgroundColor3       = Color3.fromRGB(255, 206, 27)
				PillFill.BackgroundTransparency = Default and 0 or 1
				PillFill.Size                   = UDim2.new(1, 0, 1, 0)
				PillFillCorner.CornerRadius     = UDim.new(1, 0)

				PillKnob.Name              = "PillKnob"
				PillKnob.AnchorPoint       = Vector2.new(0.5, 0.5)
				PillKnob.BackgroundColor3  = Color3.fromRGB(255, 255, 255)
				PillKnob.Position          = Default and UDim2.new(0.73, 0, 0.5, 0) or UDim2.new(0.27, 0, 0.5, 0)
				PillKnob.Size              = UDim2.new(0, 16, 0, 16)
				PillKnobCorner.CornerRadius = UDim.new(1, 0)

				PillGlow.Name              = "PillGlow"
				PillGlow.AnchorPoint       = Vector2.new(0.5, 0.5)
				PillGlow.BackgroundTransparency = 1
				PillGlow.Position          = UDim2.new(0.5, 0, 0.5, 0)
				PillGlow.Size              = UDim2.new(1, 16, 1, 16)
				PillGlow.ZIndex            = 0
				PillGlow.Image             = "rbxassetid://5028857084"
				PillGlow.ImageTransparency = Default and 0.5 or 1
				PillGlow.ImageColor3       = Color3.fromRGB(255, 206, 27)
				PillGlow.ScaleType         = Enum.ScaleType.Slice
				PillGlow.SliceCenter       = Rect.new(24, 24, 276, 276)

				-- Title: fixed 20px, top-aligned with padding
				ToggleTitle.Name                 = "TextColor"
				ToggleTitle.BackgroundTransparency = 1
				ToggleTitle.Position             = UDim2.new(0, 8, 0, Desc and 6 or 8)
				ToggleTitle.Size                 = UDim2.new(1, -58, 0, 20)
				ToggleTitle.Font                 = Enum.Font.GothamBold
				ToggleTitle.Text                 = Title
				ToggleTitle.TextSize             = 13
				ToggleTitle.TextXAlignment       = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment       = Enum.TextYAlignment.Center
				ToggleTitle.RichText             = true
				ToggleTitle.AutomaticSize        = Enum.AutomaticSize.None
				ToggleTitle.TextColor3           = getgenv().UIColor["Text Color"]

				if Desc then
					ToggleDesc.Name                 = "ToggleDesc"
					ToggleDesc.BackgroundTransparency = 1
					ToggleDesc.Position             = UDim2.new(0, 8, 0, 26)
					ToggleDesc.Size                 = UDim2.new(1, -58, 0, 20)
					ToggleDesc.Font                 = Enum.Font.Gotham
					ToggleDesc.Text                 = Desc
					ToggleDesc.TextSize             = 11
					ToggleDesc.TextWrapped          = true
					ToggleDesc.TextXAlignment       = Enum.TextXAlignment.Left
					ToggleDesc.RichText             = true
					ToggleDesc.AutomaticSize        = Enum.AutomaticSize.None
					ToggleDesc.TextColor3           = getgenv().UIColor["Toggle Desc Color"]
				end

				-- Background: semi-transparent, không đen đặc
				ToggleBg.Name                   = "Background1"
				ToggleBg.Size                   = UDim2.new(1, 0, 1, 0)
				ToggleBg.ZIndex                 = 0
				ToggleBg.BackgroundColor3       = Color3.fromRGB(38, 38, 52)
				ToggleBg.BackgroundTransparency = 0.55
				ToggleCorner.CornerRadius       = UDim.new(0, 6)

				-- Hit area covers pill zone
				ToggleButton.Name                   = "ToggleButton"
				ToggleButton.BackgroundTransparency = 1
				ToggleButton.AnchorPoint            = Vector2.new(1, 0.5)
				ToggleButton.Size                   = UDim2.new(0, 44, 0, 36)
				ToggleButton.Position               = UDim2.new(1, -6, 0.5, 0)
				ToggleButton.Font                   = Enum.Font.SourceSans
				ToggleButton.Text                   = ""
				ToggleButton.TextSize               = 14

				-- ToggleList on ToggleFrame (single child TogFrame1) — LayoutOrder only
				ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ToggleList.SortOrder           = Enum.SortOrder.LayoutOrder
				ToggleList.VerticalAlignment   = Enum.VerticalAlignment.Center
				ToggleList.Padding             = UDim.new(0, 0)

				local function ChangeStage(val)
					tw(PillBG,   getgenv().UIColor["Tween Animation 1 Speed"], {
						BackgroundColor3 = val and Color3.fromRGB(255, 206, 27) or Color3.fromRGB(44, 44, 60)
					})
					tw(PillFill, getgenv().UIColor["Tween Animation 1 Speed"], {
						BackgroundTransparency = val and 0 or 1
					})
					tw(PillKnob, getgenv().UIColor["Tween Animation 1 Speed"], {
						Position = val and UDim2.new(0.75, 0, 0.5, 0) or UDim2.new(0.28, 0, 0.5, 0)
					})
					tw(PillGlow, getgenv().UIColor["Tween Animation 1 Speed"], {
						ImageTransparency = val and 0.5 or 1
					})
					tw(pillStroke, getgenv().UIColor["Tween Animation 1 Speed"], {
						Color = val and Color3.fromRGB(255, 226, 80) or Color3.fromRGB(80, 78, 60)
					})
				end

				ChangeStage(Default)

				local function ButtonClick()
					Default = not Default
					ChangeStage(Default)
					if Callback then pcall(Callback, Default) end
				end

				ToggleButton.MouseButton1Down:Connect(ButtonClick)

				local toggleFunction = {}
				function toggleFunction.SetStage(value)
					if value ~= Default then ButtonClick() end
				end

				local controlData = {
					Name        = Title,
					Section     = Section,
					Element     = ToggleFrame,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame
				}
				table.insert(getgenv().AllControls, controlData)
				if Callback and Default ~= nil then pcall(Callback, Default) end

				return toggleFunction
			end

			-- ── BUTTON ────────────────────────────────────────────
			function sectionFunction:AddButton(Setting, _Callback)
				local Title    = Setting.Title or Setting.Text or ""
				local Callback = Setting.Callback or Setting.Func or function() end

				local Button     = Instance.new("Frame", Section)
				local RowBG      = Instance.new("Frame", Button)
				local RowBGCorner = Instance.new("UICorner", RowBG)
				local RowHover   = Instance.new("Frame", RowBG)
				local RowHoverCorner = Instance.new("UICorner", RowHover)
				local TextColor  = Instance.new("TextLabel", RowBG)
				local ClickArea  = Instance.new("Frame", RowBG)
				local ClickAreaCorner = Instance.new("UICorner", ClickArea)
				local ClickGrad  = Instance.new("UIGradient", ClickArea)
				local ClickGlow  = Instance.new("ImageLabel", ClickArea)
				local ClickShine = Instance.new("Frame", ClickArea)
				local ClickShineCorner = Instance.new("UICorner", ClickShine)
				local ClickScale = Instance.new("UIScale", ClickArea)
				local Button1    = Instance.new("TextButton", ClickArea)

				Button.Name              = "Button"
				Button.BackgroundTransparency = 1
				Button.Size              = UDim2.new(1, 0, 0, 40)

				RowBG.Name              = "RowBG"
				RowBG.AnchorPoint       = Vector2.new(0.5, 0.5)
				RowBG.BackgroundColor3  = getgenv().UIColor["Background 1 Color"]
				RowBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				RowBG.Position          = UDim2.new(0.5, 0, 0.5, 0)
				RowBG.Size              = UDim2.new(1, -10, 1, 0)
				RowBGCorner.CornerRadius = UDim.new(0, 8)

				RowHover.Name              = "RowHover"
				RowHover.BackgroundColor3  = getgenv().UIColor["Background 2 Color"]
				RowHover.BackgroundTransparency = 1
				RowHover.Size              = UDim2.new(1, 0, 1, 0)
				RowHover.ZIndex            = 2
				RowHoverCorner.CornerRadius = UDim.new(0, 8)

				TextColor.Name              = "TextColor"
				TextColor.BackgroundTransparency = 1
				TextColor.Position          = UDim2.new(0, 14, 0, 0)
				TextColor.Size              = UDim2.new(1, -120, 1, 0)
				TextColor.Font              = Enum.Font.GothamBold
				TextColor.Text              = Title
				TextColor.TextColor3        = getgenv().UIColor["GUI Text Color"]
				TextColor.TextSize          = 14
				TextColor.TextXAlignment    = Enum.TextXAlignment.Left

				ClickArea.Name              = "ClickArea"
				ClickArea.AnchorPoint       = Vector2.new(1, 0.5)
				ClickArea.BackgroundColor3  = Color3.fromRGB(255, 206, 27)
				ClickArea.Position          = UDim2.new(1, -8, 0.5, 0)
				ClickArea.Size              = UDim2.new(0, 94, 0, 28)
				ClickArea.ClipsDescendants  = true
				ClickAreaCorner.CornerRadius = UDim.new(0, 10)

				ClickGrad.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 226, 90)),
					ColorSequenceKeypoint.new(0.5, Color3.fromRGB(255, 206, 27)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(210, 160, 0))
				}
				ClickGrad.Rotation = 90

				ClickGlow.AnchorPoint       = Vector2.new(0.5, 0.5)
				ClickGlow.BackgroundTransparency = 1
				ClickGlow.Position          = UDim2.new(0.5, 0, 0.5, 0)
				ClickGlow.Size              = UDim2.new(1, 16, 1, 16)
				ClickGlow.ZIndex            = 0
				ClickGlow.Image             = "rbxassetid://5028857084"
				ClickGlow.ImageTransparency = 0.65
				ClickGlow.ImageColor3       = Color3.fromRGB(255, 230, 100)
				ClickGlow.ScaleType         = Enum.ScaleType.Slice
				ClickGlow.SliceCenter       = Rect.new(24, 24, 276, 276)

				ClickShine.AnchorPoint       = Vector2.new(0.5, 0)
				ClickShine.BackgroundColor3  = Color3.fromRGB(255, 255, 255)
				ClickShine.BackgroundTransparency = 0.75
				ClickShine.Position          = UDim2.new(0.5, 0, 0, 2)
				ClickShine.Size              = UDim2.new(1, -8, 0, 10)
				ClickShine.ZIndex            = 2
				ClickShineCorner.CornerRadius = UDim.new(0, 10)

				ClickScale.Scale = 1

				Button1.Name              = "Button"
				Button1.Active            = true
				Button1.AutoButtonColor   = false
				Button1.BackgroundTransparency = 1
				Button1.Size              = UDim2.new(1, 0, 1, 0)
				Button1.Font              = Enum.Font.GothamBold
				Button1.Text              = "Click"
				Button1.TextColor3        = Color3.fromRGB(20, 18, 10)
				Button1.TextSize          = 13

				local hoverIn  = TweenService:Create(ClickScale, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1.06 })
				local hoverOut = TweenService:Create(ClickScale, TweenInfo.new(0.14, Enum.EasingStyle.Sine), { Scale = 1 })

				Button1.MouseEnter:Connect(function()
					hoverIn:Play()
					tw(RowHover, 0.15, { BackgroundTransparency = 0.8 })
				end)
				Button1.MouseLeave:Connect(function()
					hoverOut:Play()
					tw(RowHover, 0.15, { BackgroundTransparency = 1 })
				end)

				Button1.MouseButton1Down:Connect(function()
					local ripple = Instance.new("Frame", ClickArea)
					ripple.AnchorPoint       = Vector2.new(0.5, 0.5)
					ripple.Position          = UDim2.new(0.5, 0, 0.5, 0)
					ripple.Size              = UDim2.new(0, 0, 0, 0)
					ripple.BackgroundColor3  = Color3.fromRGB(255, 255, 255)
					ripple.BackgroundTransparency = 0.5
					ripple.ZIndex            = 20
					Instance.new("UICorner", ripple).CornerRadius = UDim.new(0, 10)

					local rt = TweenService:Create(ripple,
						TweenInfo.new(0.32, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),
						{ Size = UDim2.new(1, 0, 1, 0), BackgroundTransparency = 1 })
					rt:Play()
					rt.Completed:Connect(function() ripple:Destroy() end)
					Callback()
				end)

				local f = {}
				function f:SetTitle(vl) TextColor.Text = vl end

				local controlData = {
					Name        = Title,
					Section     = Section,
					Element     = Button,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame
				}
				table.insert(getgenv().AllControls, controlData)
				return f
			end

			-- ── LABEL ─────────────────────────────────────────────
			function sectionFunction:AddLabel(text)
				local Title = text

				-- LabelFrame: AutomaticSize.Y tắt hoàn toàn trên Frame gốc,
				-- chỉ để AutomaticSize trên TextLabel bên trong,
				-- LabelBG tự resize qua SectionList AbsoluteContentSize.
				local LabelFrame  = Instance.new("Frame", Section)
				local LabelBG     = Instance.new("Frame", LabelFrame)
				local LabelCorner = Instance.new("UICorner", LabelBG)
				local LabelStroke = Instance.new("UIStroke", LabelBG)
				local LabelPad    = Instance.new("UIPadding", LabelBG)
				local TextColor   = Instance.new("TextLabel", LabelBG)

				LabelFrame.Name                 = "LabelFrame"
				LabelFrame.BackgroundTransparency = 1
				-- Không dùng AutomaticSize trên Frame container —
				-- dùng AutomaticSize.Y chỉ 1 cấp (LabelBG) để tránh cascade bug
				LabelFrame.AutomaticSize        = Enum.AutomaticSize.Y
				LabelFrame.Size                 = UDim2.new(1, 0, 0, 0)
				LabelFrame.ClipsDescendants     = false

				LabelBG.Name                 = "LabelBG"
				LabelBG.AutomaticSize        = Enum.AutomaticSize.Y
				LabelBG.BackgroundColor3     = Color3.fromRGB(38, 38, 52)
				LabelBG.BackgroundTransparency = 0.5
				LabelBG.Position             = UDim2.new(0, 5, 0, 0)
				LabelBG.Size                 = UDim2.new(1, -10, 0, 0)
				LabelCorner.CornerRadius     = UDim.new(0, 6)

				-- UIPadding thay vì position hack → không bị cascade size = 0
				LabelPad.PaddingLeft   = UDim.new(0, 10)
				LabelPad.PaddingRight  = UDim.new(0, 10)
				LabelPad.PaddingTop    = UDim.new(0, 6)
				LabelPad.PaddingBottom = UDim.new(0, 6)

				LabelStroke.Color        = Color3.fromRGB(80, 78, 60)
				LabelStroke.Thickness    = 1
				LabelStroke.Transparency = 0.5

				TextColor.Name               = "TextColor"
				TextColor.AutomaticSize      = Enum.AutomaticSize.Y
				TextColor.BackgroundTransparency = 1
				-- Size: full width của parent (padding đã handle offset),
				-- height = AutomaticSize → không dùng relative height %
				TextColor.Size               = UDim2.new(1, 0, 0, 0)
				TextColor.Font               = Enum.Font.GothamMedium
				TextColor.Text               = Title
				TextColor.TextColor3         = getgenv().UIColor["Text Color"]
				TextColor.TextSize           = 13
				TextColor.TextWrapped        = true
				TextColor.TextXAlignment     = Enum.TextXAlignment.Left

				local labelFunction = {}
				function labelFunction:SetText(t) TextColor.Text = t end
				function labelFunction.SetColor(c) TextColor.TextColor3 = c end

				local controlData = {
					Name        = Title,
					Section     = Section,
					Element     = LabelFrame,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame
				}
				table.insert(getgenv().AllControls, controlData)
				return labelFunction
			end

			-- ── DROPDOWN SECTION (contains sliders) ───────────────
			function sectionFunction:AddDropdownSection(Setting)
				local Title  = tostring(Setting.Text or Setting.Title or "")
				local Search = Setting.Search or false

				local DropdownFrame  = Instance.new("Frame", Section)
				local Dropdownbg     = Instance.new("Frame", DropdownFrame)
				local Dropdowncorner = Instance.new("UICorner", Dropdownbg)
				local DropdownStroke = Instance.new("UIStroke", Dropdownbg)
				local Topdrop        = Instance.new("Frame", Dropdownbg)
				local TopdropCorner  = Instance.new("UICorner", Topdrop)
				local ImgDrop        = Instance.new("ImageLabel", Topdrop)
				local DropdownButton = Instance.new("TextButton", Topdrop)
				local Dropdownlisttt = Instance.new("Frame", Dropdownbg)
				local DropdownScroll = Instance.new("ScrollingFrame", Dropdownlisttt)
				local ScrollContainer= Instance.new("Frame", DropdownScroll)
				local ScrollContainerList = Instance.new("UIListLayout", ScrollContainer)
				local InternalSection = Instance.new("Frame", ScrollContainer)
				local InternalList   = Instance.new("UIListLayout", InternalSection)

				DropdownFrame.Name              = Title .. "DropdownSectionFrame"
				DropdownFrame.BackgroundTransparency = 1
				DropdownFrame.Size              = UDim2.new(1, 0, 0, 25)

				Dropdownbg.Name              = "Background1"
				Dropdownbg.AnchorPoint       = Vector2.new(0.5, 0.5)
				Dropdownbg.Position          = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size              = UDim2.new(1, -10, 1, 0)
				Dropdownbg.ClipsDescendants  = true
				Dropdownbg.BackgroundColor3  = Color3.fromRGB(32, 32, 44)
				Dropdownbg.BackgroundTransparency = 0.5
				Dropdowncorner.CornerRadius  = UDim.new(0, 6)
				DropdownStroke.Color         = Color3.fromRGB(80, 78, 60)
				DropdownStroke.Thickness     = 1
				DropdownStroke.Transparency  = 0.5

				Topdrop.Name              = "Background2"
				Topdrop.Size              = UDim2.new(1, 0, 0, 25)
				Topdrop.BackgroundColor3  = Color3.fromRGB(38, 38, 52)
				Topdrop.BackgroundTransparency = 0.55
				TopdropCorner.CornerRadius = UDim.new(0, 6)

				local Dropdowntitle
				if Search then
					Dropdowntitle = Instance.new("TextBox", Topdrop)
					Dropdowntitle.PlaceholderText  = Title
					Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
				else
					Dropdowntitle = Instance.new("TextLabel", Topdrop)
					Dropdowntitle.Text = Title
				end
				Dropdowntitle.Name              = "TextColorPlaceholder"
				Dropdowntitle.BackgroundTransparency = 1
				Dropdowntitle.Position          = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size              = UDim2.new(1, -40, 1, 0)
				Dropdowntitle.Font              = Enum.Font.GothamBold
				Dropdowntitle.TextSize          = 13
				Dropdowntitle.TextXAlignment    = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants  = true
				Dropdowntitle.TextColor3        = getgenv().UIColor["Text Color"]

				ImgDrop.Name              = "ImgDrop"
				ImgDrop.AnchorPoint       = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1
				ImgDrop.Position          = UDim2.new(1, -8, 0.5, 0)
				ImgDrop.Size              = UDim2.new(0, 14, 0, 14)
				ImgDrop.Image             = "rbxassetid://6954383209"
				ImgDrop.ImageColor3       = getgenv().UIColor["Dropdown Icon Color"]

				DropdownButton.Name              = "DropdownButton"
				DropdownButton.BackgroundTransparency = 1
				DropdownButton.Size              = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1, 0)
				DropdownButton.Position          = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0, 0, 0, 0)
				DropdownButton.Font              = Enum.Font.GothamBold
				DropdownButton.Text              = ""

				Dropdownlisttt.Name              = "Dropdownlisttt"
				Dropdownlisttt.BackgroundTransparency = 1
				Dropdownlisttt.BorderSizePixel   = 0
				Dropdownlisttt.Position          = UDim2.new(0, 0, 0, 25)
				Dropdownlisttt.Size              = UDim2.new(1, 0, 0, 0)

				DropdownScroll.Active            = true
				DropdownScroll.BackgroundTransparency = 1
				DropdownScroll.BorderSizePixel   = 0
				DropdownScroll.Size              = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage       = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize        = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 3
				DropdownScroll.TopImage          = "rbxasset://textures/ui/Scroll/scroll-middle.png"

				ScrollContainer.BackgroundTransparency = 1
				ScrollContainer.Position          = UDim2.new(0, 5, 0, 5)
				ScrollContainer.Size              = UDim2.new(1, -15, 1, -5)

				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding   = UDim.new(0, 5)

				InternalSection.BackgroundTransparency = 1
				InternalSection.Size              = UDim2.new(1, 0, 0, 0)
				InternalSection.AutomaticSize     = Enum.AutomaticSize.Y

				InternalList.SortOrder = Enum.SortOrder.LayoutOrder
				InternalList.Padding   = UDim.new(0, 5)

				local isOpen = false

				DropdownButton.MouseButton1Click:Connect(function()
					isOpen = not isOpen
					tw(Dropdownlisttt, getgenv().UIColor["Tween Animation 2 Speed"], {
						Size = isOpen and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 0)
					})
					tw(DropdownFrame, getgenv().UIColor["Tween Animation 2 Speed"], {
						Size = isOpen and UDim2.new(1, 0, 0, 230) or UDim2.new(1, 0, 0, 25)
					})
					tw(ImgDrop, getgenv().UIColor["Tween Animation 2 Speed"], {
						Rotation = isOpen and 90 or 0
					})
				end)

				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
				end)
				InternalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					local contentHeight = math.min(InternalList.AbsoluteContentSize.Y + 10, 300)
					if isOpen then
						tw(Dropdownlisttt, getgenv().UIColor["Tween Animation 2 Speed"], { Size = UDim2.new(1, 0, 0, contentHeight) })
						tw(DropdownFrame,  getgenv().UIColor["Tween Animation 2 Speed"], { Size = UDim2.new(1, 0, 0, contentHeight + 25) })
					end
				end)

				local dropdownSectionFunction = {}

				function dropdownSectionFunction:AddSlider(Setting)
					local TitleText    = tostring(Setting.Text or Setting.Title) or ""
					local minValue     = tonumber(Setting.Min) or 0
					local maxValue     = tonumber(Setting.Max) or 100
					local Precise      = Setting.Precise or false
					local DefaultValue = tonumber(Setting.Default) or 0
					local Callback     = Setting.Callback
					local Rounding     = Setting.Rouding or Setting.Rounding

					local SliderFrame   = Instance.new("Frame", InternalSection)
					local SliderCorner  = Instance.new("UICorner", SliderFrame)
					local SliderBG      = Instance.new("Frame", SliderFrame)
					local SliderBGCorner = Instance.new("UICorner", SliderBG)
					local SliderTitle   = Instance.new("TextLabel", SliderBG)
					local SliderBar     = Instance.new("Frame", SliderFrame)
					local SliderButton  = Instance.new("TextButton", SliderBar)
					local SliderBarCorner = Instance.new("UICorner", SliderBar)
					local Bar           = Instance.new("Frame", SliderBar)
					local BarCorner     = Instance.new("UICorner", Bar)
					local Sliderboxframe = Instance.new("Frame", SliderFrame)
					local Sliderbox     = Instance.new("UICorner", Sliderboxframe)
					local Sliderbox_2   = Instance.new("TextBox", Sliderboxframe)

					SliderFrame.Name              = TitleText
					SliderFrame.BackgroundTransparency = 1
					SliderFrame.Size              = UDim2.new(1, 0, 0, 50)
					SliderCorner.CornerRadius     = UDim.new(0, 4)

					SliderBG.Name              = "Background1"
					SliderBG.AnchorPoint       = Vector2.new(0.5, 0.5)
					SliderBG.Position          = UDim2.new(0.5, 0, 0.5, 0)
					SliderBG.Size              = UDim2.new(1, -5, 1, 0)
					SliderBG.BackgroundColor3  = Color3.fromRGB(32, 32, 44)
					SliderBG.BackgroundTransparency = 0.5
					SliderBGCorner.CornerRadius = UDim.new(0, 4)

					SliderTitle.Name              = "TextColor"
					SliderTitle.BackgroundTransparency = 1
					SliderTitle.Position          = UDim2.new(0, 10, 0, 0)
					SliderTitle.Size              = UDim2.new(0.65, -10, 0, 25)
					SliderTitle.Font              = Enum.Font.GothamBold
					SliderTitle.Text              = TitleText
					SliderTitle.TextSize          = 13
					SliderTitle.RichText          = true
					SliderTitle.TextXAlignment    = Enum.TextXAlignment.Left
					SliderTitle.TextColor3        = getgenv().UIColor["Text Color"]

					SliderBar.Name              = "SliderBar"
					SliderBar.AnchorPoint       = Vector2.new(0.5, 0.5)
					SliderBar.Position          = UDim2.new(0.5, 0, 0.5, 14)
					SliderBar.Size              = UDim2.new(0.9, 0, 0, 5)
					SliderBar.BackgroundColor3  = Color3.fromRGB(60, 60, 78)

					SliderButton.BackgroundTransparency = 1
					SliderButton.Size              = UDim2.new(1, 0, 1, 0)
					SliderButton.Font              = Enum.Font.GothamBold
					SliderButton.Text              = ""

					SliderBarCorner.CornerRadius  = UDim.new(1, 0)

					Bar.Name              = "Bar"
					Bar.BorderSizePixel   = 0
					Bar.Size              = UDim2.new(0, 0, 1, 0)
					Bar.BackgroundColor3  = getgenv().UIColor["Slider Line Color"]
					BarCorner.CornerRadius = UDim.new(1, 0)

					Sliderboxframe.Name              = "Background2"
					Sliderboxframe.AnchorPoint       = Vector2.new(1, 0)
					Sliderboxframe.Position          = UDim2.new(1, -10, 0, 5)
					Sliderboxframe.Size              = UDim2.new(0.3, 0, 0, 22)
					Sliderboxframe.BackgroundColor3  = Color3.fromRGB(44, 44, 60)
					Sliderbox.CornerRadius           = UDim.new(0, 4)

					Sliderbox_2.Name              = "TextColor"
					Sliderbox_2.BackgroundTransparency = 1
					Sliderbox_2.Size              = UDim2.new(1, 0, 1, 0)
					Sliderbox_2.Font              = Enum.Font.GothamBold
					Sliderbox_2.Text              = ""
					Sliderbox_2.TextSize          = 13
					Sliderbox_2.TextColor3        = getgenv().UIColor["Text Color"]

					SliderButton.MouseEnter:Connect(function()
						tw(Bar, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"] })
					end)
					SliderButton.MouseLeave:Connect(function()
						tw(Bar, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundColor3 = getgenv().UIColor["Slider Line Color"] })
					end)

					local callBackAndSetText = function(val)
						Sliderbox_2.Text = tostring(val)
						Callback(tonumber(val))
					end

					DefaultValue = math.clamp(DefaultValue, minValue, maxValue)
					Bar.Size     = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 1, 0)
					Sliderbox_2.Text = tostring(DefaultValue)

					local dragging, dragInput = false, nil
					local holdTime, holdStarted = 0, 0

					SliderButton.InputBegan:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or
						   input.UserInputType == Enum.UserInputType.Touch then
							holdStarted = tick()
							input.Changed:Connect(function()
								if input.UserInputState == Enum.UserInputState.End then
									dragging = false; holdStarted = 0
								end
							end)
						end
					end)
					SliderButton.InputEnded:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseButton1 or
						   input.UserInputType == Enum.UserInputType.Touch then
							dragging = false; holdStarted = 0
						end
					end)
					SliderButton.InputChanged:Connect(function(input)
						if input.UserInputType == Enum.UserInputType.MouseMovement or
						   input.UserInputType == Enum.UserInputType.Touch then
							dragInput = input
						end
					end)

					RunService.RenderStepped:Connect(function()
						if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
							dragging = true
						end
						if dragging and dragInput then
							local bw  = math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
							local pct = bw / SliderBar.AbsoluteSize.X
							local val = minValue + (maxValue - minValue) * pct
							if Rounding then
								val = tonumber(string.format("%." .. Rounding .. "f", val))
							elseif not Precise then
								val = math.floor(val)
							end
							val = math.clamp(val, minValue, maxValue)
							pcall(callBackAndSetText, val)
							Bar.Size = UDim2.new(pct, 0, 1, 0)
						end
					end)

					local function GetSliderValue(Value)
						Value = math.clamp(tonumber(Value) or minValue, minValue, maxValue)
						if Rounding then
							Value = tonumber(string.format("%." .. Rounding .. "f", Value))
						elseif not Precise then
							Value = math.floor(Value)
						end
						local pct = (Value - minValue) / (maxValue - minValue)
						Bar.Size  = UDim2.new(pct, 0, 1, 0)
						callBackAndSetText(Value)
					end

					Sliderbox_2.FocusLost:Connect(function() GetSliderValue(Sliderbox_2.Text) end)

					local slider_function = {}
					function slider_function.SetValue(v) GetSliderValue(v) end
					function slider_function.GetValue() return tonumber(Sliderbox_2.Text) or minValue end
					return slider_function
				end

				function dropdownSectionFunction:SetOpen(state)
					if state ~= isOpen then DropdownButton.MouseButton1Click:Fire() end
				end
				function dropdownSectionFunction:GetOpen() return isOpen end
				function dropdownSectionFunction:SetTitle(newTitle)
					if Search then Dropdowntitle.PlaceholderText = newTitle
					else Dropdowntitle.Text = newTitle end
				end

				local controlData = {
					Name        = Title,
					Section     = Section,
					Element     = DropdownFrame,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame
				}
				table.insert(getgenv().AllControls, controlData)
				return dropdownSectionFunction
			end

			-- ── DROPDOWN ──────────────────────────────────────────
			function sectionFunction:AddDropdown(idk, Setting)
				local Title       = tostring(Setting.Text or Setting.Title) or ""
				local List        = Setting.Values
				local Search      = Setting.Search or false
				local Selected    = Setting.Selected or Setting.Multi or false
				local Slider      = Setting.Slider or false
				local SliderRelease = Setting.SliderRelease or false
				local Default     = (function()
					if Setting.Default then
						if type(Setting.Default) == "number" then return List[Setting.Default]
						elseif type(Setting.Default) == "string" then return Setting.Default end
					end
					return nil
				end)()
				local Callback    = Setting.Callback
				local pairs       = Setting.SortPairs or pairs

				local DropdownFrame  = Instance.new("Frame", Section)
				local Dropdownbg     = Instance.new("Frame", DropdownFrame)
				local Dropdowncorner = Instance.new("UICorner", Dropdownbg)
				local DropdownStroke = Instance.new("UIStroke", Dropdownbg)
				local Topdrop        = Instance.new("Frame", Dropdownbg)
				local TopdropCorner  = Instance.new("UICorner", Topdrop)
				local ImgDrop        = Instance.new("ImageLabel", Topdrop)
				local DropdownButton = Instance.new("TextButton", Topdrop)
				local Dropdownlisttt = Instance.new("Frame", Dropdownbg)
				local DropdownScroll = Instance.new("ScrollingFrame", Dropdownlisttt)
				local ScrollContainer = Instance.new("Frame", DropdownScroll)
				local ScrollContainerList = Instance.new("UIListLayout", ScrollContainer)
				local dropdownLeave  = false
				local Dropdowntitle

				if Search then Dropdowntitle = Instance.new("TextBox", Topdrop)
				else Dropdowntitle = Instance.new("TextLabel", Topdrop) end

				DropdownFrame.Name              = Title .. "DropdownFrame"
				DropdownFrame.BackgroundTransparency = 1
				DropdownFrame.Size              = UDim2.new(1, 0, 0, 25)

				Dropdownbg.Name              = "Background1"
				Dropdownbg.AnchorPoint       = Vector2.new(0.5, 0.5)
				Dropdownbg.Position          = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size              = UDim2.new(1, -10, 1, 0)
				Dropdownbg.ClipsDescendants  = true
				Dropdownbg.BackgroundColor3  = Color3.fromRGB(32, 32, 44)
				Dropdownbg.BackgroundTransparency = 0.5
				Dropdowncorner.CornerRadius  = UDim.new(0, 6)
				DropdownStroke.Color         = Color3.fromRGB(80, 78, 60)
				DropdownStroke.Thickness     = 1
				DropdownStroke.Transparency  = 0.5

				Topdrop.Name              = "Background2"
				Topdrop.Size              = UDim2.new(1, 0, 0, 25)
				Topdrop.BackgroundColor3  = Color3.fromRGB(38, 38, 52)
				Topdrop.BackgroundTransparency = 0.55
				TopdropCorner.CornerRadius = UDim.new(0, 6)

				Dropdowntitle.Name              = "TextColorPlaceholder"
				Dropdowntitle.BackgroundTransparency = 1
				Dropdowntitle.Position          = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size              = UDim2.new(1, -40, 1, 0)
				Dropdowntitle.Font              = Enum.Font.GothamBold
				Dropdowntitle.TextSize          = 13
				Dropdowntitle.TextXAlignment    = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants  = true

				local Sel = Instance.new("StringValue", Dropdowntitle)
				Sel.Value = ""
				if Default and table.find(List, Default) then Sel.Value = Default end

				if not Selected then
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText   = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
				else
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText   = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
				end
				Dropdowntitle.TextColor3 = getgenv().UIColor["Text Color"]

				ImgDrop.Name              = "ImgDrop"
				ImgDrop.AnchorPoint       = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1
				ImgDrop.Position          = UDim2.new(1, -8, 0.5, 0)
				ImgDrop.Size              = UDim2.new(0, 14, 0, 14)
				ImgDrop.Image             = "rbxassetid://6954383209"
				ImgDrop.ImageColor3       = getgenv().UIColor["Dropdown Icon Color"]

				DropdownButton.Name              = "DropdownButton"
				DropdownButton.BackgroundTransparency = 1
				DropdownButton.Size              = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1, 0)
				DropdownButton.Position          = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0, 0, 0, 0)
				DropdownButton.Font              = Enum.Font.GothamBold
				DropdownButton.Text              = ""

				Dropdownlisttt.Name              = "Dropdownlisttt"
				Dropdownlisttt.BackgroundTransparency = 1
				Dropdownlisttt.BorderSizePixel   = 0
				Dropdownlisttt.Position          = UDim2.new(0, 0, 0, 25)
				Dropdownlisttt.Size              = UDim2.new(1, 0, 0, 25)

				DropdownScroll.Active            = true
				DropdownScroll.BackgroundTransparency = 1
				DropdownScroll.BorderSizePixel   = 0
				DropdownScroll.Size              = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage       = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize        = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 3
				DropdownScroll.TopImage          = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.ScrollingEnabled  = true
				DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always

				ScrollContainer.BackgroundTransparency = 1
				ScrollContainer.Position          = UDim2.new(0, 5, 0, 5)
				ScrollContainer.Size              = UDim2.new(1, -15, 1, -5)

				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding   = UDim.new(0, 5)

				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
				end)

				local isbusy    = false
				local found     = {}
				local searchtable = {}

				local function edit()
					for i in pairs(found) do found[i] = nil end
					for _, l in pairs(ScrollContainer:GetChildren()) do
						if not l:IsA("UIListLayout") and not l:IsA("UIPadding") and not l:IsA('UIGridLayout') then
							l.Visible = false
						end
					end
					Dropdowntitle.Text = string.lower(Dropdowntitle.Text)
				end

				local function SearchDropdown()
					for _, v in pairs(searchtable) do
						if string.find(v, Dropdowntitle.Text) then table.insert(found, v) end
					end
					for _, b in pairs(ScrollContainer:GetChildren()) do
						for _, d in pairs(found) do
							if d == b.Name then b.Visible = true end
						end
					end
				end

				local function clear_object_in_list()
					for _, v in next, ScrollContainer:GetChildren() do
						if v:IsA('Frame') then v:Destroy() end
					end
				end

				local ListNew
				local OrderedList = {}
				if Selected then
					ListNew = {}
					for _, value in ipairs(List) do
						ListNew[value] = (value == Default)
						table.insert(OrderedList, value)
					end
				else
					ListNew = List
				end

				local function refreshlist(SortPairs)
					pairs = SortPairs or pairs
					clear_object_in_list()
					searchtable = {}

					local function mkItem(nameStr, isChecked, onClickFn)
						local SampleItem       = Instance.new("Frame", ScrollContainer)
						local SampleItemCorner = Instance.new("UICorner", SampleItem)
						local SampleItemBG     = Instance.new("Frame", SampleItem)
						local SampleItemBGCorner = Instance.new("UICorner", SampleItemBG)
						local SampleItemTitle  = Instance.new("TextLabel", SampleItemBG)
						local SampleItemCheck  = Instance.new("ImageButton", SampleItemBG)
						local SampleItemButton = Instance.new("TextButton", SampleItem)

						SampleItem.Name              = string.lower(nameStr)
						SampleItem.BackgroundTransparency = 1
						SampleItem.LayoutOrder       = 1
						SampleItem.Size              = UDim2.new(1, 0, 0, 24)
						SampleItemCorner.CornerRadius = UDim.new(0, 5)

						SampleItemBG.Name              = "SampleItemBG"
						SampleItemBG.AnchorPoint       = Vector2.new(0.5, 0.5)
						SampleItemBG.BackgroundColor3  = isChecked and getgenv().UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
						SampleItemBG.BackgroundTransparency = isChecked and 0.5 or 1
						SampleItemBG.Position          = UDim2.new(0.5, 0, 0.5, 0)
						SampleItemBG.Size              = UDim2.new(1, 0, 1, 0)
						SampleItemBGCorner.CornerRadius = UDim.new(0, 5)

						SampleItemTitle.BackgroundTransparency = 1
						SampleItemTitle.Position       = UDim2.new(0, 10, 0, 0)
						SampleItemTitle.Size           = UDim2.new(1, -40, 0, 24)
						SampleItemTitle.Font           = Enum.Font.GothamBold
						SampleItemTitle.Text           = nameStr
						SampleItemTitle.TextColor3     = getgenv().UIColor["Text Color"]
						SampleItemTitle.TextSize       = 13
						SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left

						SampleItemCheck.AnchorPoint       = Vector2.new(1, 0.5)
						SampleItemCheck.BackgroundTransparency = 1
						SampleItemCheck.Position          = UDim2.new(1, 0, 0.5, 0)
						SampleItemCheck.Size              = UDim2.new(0, 24, 0, 24)
						SampleItemCheck.ZIndex            = 2
						SampleItemCheck.Image             = "rbxassetid://3926305904"
						SampleItemCheck.ImageColor3       = getgenv().UIColor["Dropdown Selected Check Color"]
						SampleItemCheck.ImageRectOffset   = Vector2.new(312, 4)
						SampleItemCheck.ImageRectSize     = Vector2.new(24, 24)
						SampleItemCheck.ImageTransparency = isChecked and 0 or 1

						SampleItemButton.BackgroundTransparency = 1
						SampleItemButton.BorderSizePixel = 0
						SampleItemButton.Size            = UDim2.new(1, 0, 1, 0)
						SampleItemButton.Font            = Enum.Font.SourceSans
						SampleItemButton.Text            = ""
						SampleItemButton.TextColor3      = getgenv().UIColor["Text Color"]
						SampleItemButton.TextSize        = 14
						SampleItemButton.TextTransparency = 1

						SampleItemButton.MouseEnter:Connect(function()
							if isChecked then return end
							tw(SampleItemBG, getgenv().UIColor["Tween Animation 1 Speed"], {
								BackgroundColor3 = Color3.fromRGB(255, 255, 255),
								BackgroundTransparency = 0.8
							})
						end)
						SampleItemButton.MouseLeave:Connect(function()
							if isChecked then return end
							tw(SampleItemBG, getgenv().UIColor["Tween Animation 1 Speed"], {
								BackgroundTransparency = 1
							})
						end)
						SampleItemButton.MouseButton1Click:Connect(onClickFn)
						return SampleItem, SampleItemBG, SampleItemCheck
					end

					if Selected then
						for _, i in ipairs(OrderedList) do
							local v = ListNew[i]
							table.insert(searchtable, string.lower(i))
							local _, bg, chk = mkItem(i, v, function()
								v = not v
								ListNew[i] = v
								tw(chk, getgenv().UIColor["Tween Animation 1 Speed"], { ImageTransparency = v and 0 or 1 })
								tw(bg,  getgenv().UIColor["Tween Animation 1 Speed"], {
									BackgroundColor3     = v and getgenv().UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255),
									BackgroundTransparency = v and 0.5 or 1
								})
								if Callback then Callback(i, v) end
								local selectedText = {}
								for key, isSel in pairs(ListNew) do
									if isSel then table.insert(selectedText, tostring(key)) end
								end
								local joined = table.concat(selectedText, ", ")
								if Search then Dropdowntitle.PlaceholderText = Title .. ': ' .. joined
								else Dropdowntitle.Text = Title .. ': ' .. joined end
							end)
						end
					elseif Slider then
						-- Slider list items (preserved from original)
						for i, v in pairs(ListNew) do
							local TitleText    = tostring(v.Title) or ""
							local minValue     = tonumber(v.Min) or 0
							local maxValue     = tonumber(v.Max) or 100
							local Precise      = v.Precise or false
							local DefaultValue = tonumber(v.Default) or minValue
							local SizeChia     = 365
							-- (slider item build preserved exactly as original)
							local SliderFrame   = Instance.new("Frame", ScrollContainer)
							local SliderCorner  = Instance.new("UICorner", SliderFrame)
							local SliderBG      = Instance.new("Frame", SliderFrame)
							local SliderBGCorner = Instance.new("UICorner", SliderBG)
							local SliderTitle   = Instance.new("TextLabel", SliderBG)
							local SliderBar     = Instance.new("Frame", SliderFrame)
							local SliderButton  = Instance.new("TextButton", SliderBar)
							local SliderBarCorner = Instance.new("UICorner", SliderBar)
							local Bar           = Instance.new("Frame", SliderBar)
							local BarCorner     = Instance.new("UICorner", Bar)
							local Sliderboxframe = Instance.new("Frame", SliderFrame)
							local Sliderbox     = Instance.new("UICorner", Sliderboxframe)
							local Sliderbox_2   = Instance.new("TextBox", Sliderboxframe)

							SliderFrame.Name              = string.lower(v['Title'])
							SliderFrame.BackgroundTransparency = 1
							SliderFrame.Size              = UDim2.new(1, 0, 0, 50)
							SliderCorner.CornerRadius     = UDim.new(0, 4)
							SliderBG.Name              = "Background1"
							SliderBG.AnchorPoint       = Vector2.new(0.5, 0.5)
							SliderBG.Position          = UDim2.new(0.5, 0, 0.5, 0)
							SliderBG.Size              = UDim2.new(1, -10, 1, 0)
							SliderBG.BackgroundColor3  = getgenv().UIColor["Background 1 Color"]
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							SliderBGCorner.CornerRadius = UDim.new(0, 4)
							SliderTitle.Name              = "TextColor"
							SliderTitle.BackgroundTransparency = 1
							SliderTitle.Position          = UDim2.new(0, 10, 0, 0)
							SliderTitle.Size              = UDim2.new(1, -10, 0, 25)
							SliderTitle.Font              = Enum.Font.GothamBold
							SliderTitle.Text              = TitleText
							SliderTitle.TextSize          = 13
							SliderTitle.TextXAlignment    = Enum.TextXAlignment.Left
							SliderTitle.TextColor3        = getgenv().UIColor["Text Color"]
							SliderBar.Name              = "SliderBar"
							SliderBar.AnchorPoint       = Vector2.new(0.5, 0.5)
							SliderBar.Position          = UDim2.new(0.5, 0, 0.5, 14)
							SliderBar.Size              = UDim2.new(1, -20, 0, 5)
							SliderBar.BackgroundColor3  = Color3.fromRGB(60, 60, 78)
							SliderButton.Name              = "SliderButton "
							SliderButton.BackgroundTransparency = 1
							SliderButton.Size              = UDim2.new(1, 0, 1, 0)
							SliderButton.Font              = Enum.Font.GothamBold
							SliderButton.Text              = ""
							SliderBarCorner.CornerRadius  = UDim.new(1, 0)
							Bar.Name              = "Bar"
							Bar.BorderSizePixel   = 0
							Bar.Size              = UDim2.new(0, 0, 1, 0)
							Bar.BackgroundColor3  = getgenv().UIColor["Slider Line Color"]
							BarCorner.CornerRadius = UDim.new(1, 0)
							Sliderboxframe.Name              = "Background2"
							Sliderboxframe.AnchorPoint       = Vector2.new(1, 0)
							Sliderboxframe.Position          = UDim2.new(1, -10, 0, 5)
							Sliderboxframe.Size              = UDim2.new(0, 150, 0, 22)
							Sliderboxframe.BackgroundColor3  = Color3.fromRGB(44, 44, 60)
							Sliderbox.CornerRadius           = UDim.new(0, 4)
							Sliderbox_2.Name              = "TextColor"
							Sliderbox_2.BackgroundTransparency = 1
							Sliderbox_2.Size              = UDim2.new(1, 0, 1, 0)
							Sliderbox_2.Font              = Enum.Font.GothamBold
							Sliderbox_2.Text              = ""
							Sliderbox_2.TextSize          = 13
							Sliderbox_2.TextColor3        = getgenv().UIColor["Text Color"]

							SliderButton.MouseEnter:Connect(function()
								tw(Bar, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"] })
							end)
							SliderButton.MouseLeave:Connect(function()
								tw(Bar, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundColor3 = getgenv().UIColor["Slider Line Color"] })
							end)

							local callBackAndSetText = function(val)
								Sliderbox_2.Text = val
								ListNew[i].Default = val
								Callback(i, v)
							end
							if DefaultValue then
								DefaultValue = math.clamp(DefaultValue, minValue, maxValue)
								Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 1, 0)
								callBackAndSetText(DefaultValue)
							end

							-- Slider drag (preserved)
							local dragging, dragInput = false, nil
							local holdTime, holdStarted = 0, 0
							SliderButton.InputBegan:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or
								   input.UserInputType == Enum.UserInputType.Touch then
									holdStarted = tick()
									input.Changed:Connect(function()
										if input.UserInputState == Enum.UserInputState.End then
											dragging = false; holdStarted = 0
										end
									end)
								end
							end)
							SliderButton.InputEnded:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseButton1 or
								   input.UserInputType == Enum.UserInputType.Touch then
									dragging = false; holdStarted = 0
								end
							end)
							SliderButton.InputChanged:Connect(function(input)
								if input.UserInputType == Enum.UserInputType.MouseMovement or
								   input.UserInputType == Enum.UserInputType.Touch then
									dragInput = input
								end
							end)
							RunService.RenderStepped:Connect(function()
								if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then dragging = true end
								if dragging and dragInput then
									local value = Precise
										and tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue)))
										or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
									pcall(callBackAndSetText, value)
									Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 5)
								end
							end)
							local function GetSliderValue(Value)
								if tonumber(Value) <= minValue then
									Bar.Size = UDim2.new(0, 0, 0, 5); callBackAndSetText(minValue)
								elseif tonumber(Value) >= maxValue then
									Bar.Size = UDim2.new(0, maxValue / maxValue * SizeChia, 0, 5); callBackAndSetText(maxValue)
								else
									Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 5); callBackAndSetText(Value)
								end
							end
							Sliderbox_2.FocusLost:Connect(function() GetSliderValue(Sliderbox_2.Text) end)
						end
					else
						for i, v in pairs(ListNew) do
							if typeof(v) == "string" then
								table.insert(searchtable, string.lower(v))
								local isSelected = (Sel.Value == v)
								local sampleItem, sampleBG, sampleCheck = mkItem(v, false, function()
									if Search then
										Dropdowntitle.PlaceholderText = Title .. ': ' .. v
										Sel.Value = v
									else
										Dropdowntitle.Text = Title .. ': ' .. v
										Sel.Value = v
									end
									tw(sampleBG, getgenv().UIColor["Tween Animation 1 Speed"], {
										BackgroundColor3     = getgenv().UIColor["Dropdown Selected Check Color"],
										BackgroundTransparency = 0.5
									})
									if Callback then Callback(v) end
									if Search then Dropdowntitle.Text = "" end
									refreshlist()
								end)
								if isSelected then
									sampleBG.BackgroundTransparency = 0.5
									sampleBG.BackgroundColor3       = getgenv().UIColor["Dropdown Selected Check Color"]
									sampleItem.LayoutOrder          = 0
								end
							end
						end
					end
				end

				if Search then
					Dropdowntitle.Changed:Connect(function()
						edit(); SearchDropdown()
					end)
				end

				if typeof(Default) ~= 'table' then
					if Search then Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "") end
				elseif Slider then
					Dropdowntitle.Text = ''
					Dropdowntitle.PlaceholderText = Title .. ': '
				elseif Selected then
					if Search then Dropdowntitle.PlaceholderText = Title .. ': '
					else Dropdowntitle.Text = Title .. ': ' end
				end

				DropdownButton.MouseButton1Click:Connect(function()
					refreshlist()
					isbusy = not isbusy
					tw(Dropdownlisttt, getgenv().UIColor["Tween Animation 2 Speed"], {
						Size = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					})
					tw(DropdownFrame, getgenv().UIColor["Tween Animation 2 Speed"], {
						Size = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					})
					tw(ImgDrop, getgenv().UIColor["Tween Animation 2 Speed"], {
						Rotation = isbusy and 90 or 0
					})
				end)

				local dropdownFunction = { rf = refreshlist }

				function dropdownFunction:ClearText(v)
					if not Selected then
						if Search then Dropdowntitle.PlaceholderText = Title .. ': ' .. (v or "")
						else Dropdowntitle.Text = Title .. ': ' .. (v or "") end
					else
						Dropdowntitle.Text = Title .. ': ' .. (v or "")
					end
				end

				function dropdownFunction:GetNewList(List)
					Sel.Value = ""
					isbusy    = false
					tw(Dropdownlisttt, getgenv().UIColor["Tween Animation 2 Speed"], { Size = UDim2.new(1, 0, 0, 0) })
					tw(DropdownFrame,  getgenv().UIColor["Tween Animation 2 Speed"], { Size = UDim2.new(1, 0, 0, 25) })
					tw(ImgDrop,        getgenv().UIColor["Tween Animation 2 Speed"], { Rotation = 0 })
					ListNew = List
					refreshlist()
					if Search then Dropdowntitle.PlaceholderText = Title .. ': '
					else Dropdowntitle.Text = Title .. ': ' end
				end

				function dropdownFunction:SetValue(value)
					if not Selected then
						if table.find(ListNew, value) then
							Sel.Value = value
							if Search then Dropdowntitle.PlaceholderText = Title .. ': ' .. value
							else Dropdowntitle.Text = Title .. ': ' .. value end
							if Callback then Callback(value) end
							refreshlist()
						end
					else
						if ListNew[value] ~= nil then
							ListNew[value] = true
							if Search then Dropdowntitle.PlaceholderText = Title .. ': '
							else Dropdowntitle.Text = Title .. ': ' end
							if Callback then Callback(value, true) end
							refreshlist()
						end
					end
				end

				function dropdownFunction:GetValue()
					if not Selected then
						return Sel.Value
					else
						local result = {}
						for key, val in pairs(ListNew) do
							if val == true then table.insert(result, key) end
						end
						return result
					end
				end

				local controlData = {
					Name        = Title,
					Section     = Section,
					Element     = DropdownFrame,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame,
					SetValue    = dropdownFunction.SetValue,
					GetValue    = dropdownFunction.GetValue
				}
				table.insert(getgenv().AllControls, controlData)
				if Default and Callback then pcall(Callback, Default) end
				return dropdownFunction
			end

			-- ── KEYBIND ───────────────────────────────────────────
			function sectionFunction:AddKeyBind(Setting, Callback)
				local TitleText = tostring(Setting.Title or Setting.Text) or ""
				local Default   = Setting.Default or Setting.Key or "F"
				local Mode      = Setting.Mode or "Toggle"
				local Callback  = Setting.Callback or Callback or function() end

				local function GetKeyString(key)
					local s = tostring(key)
					s = s:gsub("Enum.UserInputType.", "")
					s = s:gsub("Enum.KeyCode.", "")
					return s
				end

				local CurrentKey  = GetKeyString(Default)
				local CurrentMode = Mode
				local Picking     = false
				local ToggleState = false
				local HoldActive  = false

				local BindFrame     = Instance.new("Frame", Section)
				local BindCorner    = Instance.new("UICorner", BindFrame)
				local BindBG        = Instance.new("Frame", BindFrame)
				local ButtonCorner  = Instance.new("UICorner", BindBG)
				local BindButtonTitle = Instance.new("TextLabel", BindBG)
				local BindCor       = Instance.new("Frame", BindBG)
				local ButtonCorner2 = Instance.new("UICorner", BindCor)
				local Bindkey       = Instance.new("TextButton", BindCor)

				BindFrame.Name              = TitleText .. "bguvl"
				BindFrame.BackgroundTransparency = 1
				BindFrame.Size              = UDim2.new(1, 0, 0, 35)
				BindCorner.CornerRadius     = UDim.new(0, 4)

				BindBG.Name              = "Background1"
				BindBG.AnchorPoint       = Vector2.new(0.5, 0.5)
				BindBG.Position          = UDim2.new(0.5, 0, 0.5, 0)
				BindBG.Size              = UDim2.new(1, -10, 1, 0)
				BindBG.BackgroundColor3  = getgenv().UIColor["Background 1 Color"]
				BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				ButtonCorner.CornerRadius = UDim.new(0, 6)

				BindButtonTitle.Name              = "TextColor"
				BindButtonTitle.BackgroundTransparency = 1
				BindButtonTitle.Position          = UDim2.new(0, 10, 0, 0)
				BindButtonTitle.Size              = UDim2.new(1, -10, 1, 0)
				BindButtonTitle.Font              = Enum.Font.GothamBold
				BindButtonTitle.Text              = TitleText
				BindButtonTitle.TextSize          = 13
				BindButtonTitle.TextXAlignment    = Enum.TextXAlignment.Left
				BindButtonTitle.TextColor3        = getgenv().UIColor["Text Color"]

				BindCor.Name              = "Background2"
				BindCor.AnchorPoint       = Vector2.new(1, 0.5)
				BindCor.Position          = UDim2.new(1, -6, 0.5, 0)
				BindCor.Size              = UDim2.new(0, 150, 0, 22)
				BindCor.BackgroundColor3  = Color3.fromRGB(44, 44, 60)
				ButtonCorner2.CornerRadius = UDim.new(0, 4)

				Bindkey.Name              = "Bindkey"
				Bindkey.BackgroundTransparency = 1
				Bindkey.Size              = UDim2.new(1, 0, 1, 0)
				Bindkey.Font              = Enum.Font.GothamBold
				Bindkey.Text              = CurrentKey
				Bindkey.TextSize          = 13
				Bindkey.TextColor3        = getgenv().UIColor["Text Color"]

				Bindkey.MouseButton1Click:Connect(function()
					if Picking then return end
					Picking      = true
					Bindkey.Text = "..."
					task.wait(0.2)
					local Connection
					Connection = uis.InputBegan:Connect(function(input)
						if Picking then
							local Key
							if input.UserInputType == Enum.UserInputType.Keyboard then Key = input.KeyCode.Name
							elseif input.UserInputType == Enum.UserInputType.MouseButton1 then Key = "MouseLeft"
							elseif input.UserInputType == Enum.UserInputType.MouseButton2 then Key = "MouseRight" end
							if Key then
								Picking      = false
								CurrentKey   = Key
								Bindkey.Text = Key
								Connection:Disconnect()
							end
						end
					end)
				end)

				uis.InputBegan:Connect(function(input, gpe)
					if gpe or Picking then return end
					if uis:GetFocusedTextBox() then return end
					local pressedKey
					if input.UserInputType == Enum.UserInputType.Keyboard then pressedKey = input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then pressedKey = "MouseLeft"
					elseif input.UserInputType == Enum.UserInputType.MouseButton2 then pressedKey = "MouseRight" end
					if pressedKey == CurrentKey then
						if CurrentMode == "Toggle" then
							ToggleState = not ToggleState; pcall(Callback, ToggleState)
						elseif CurrentMode == "Hold" then
							HoldActive = true; pcall(Callback, true)
						end
					end
				end)

				uis.InputEnded:Connect(function(input)
					if Picking then return end
					if uis:GetFocusedTextBox() then return end
					local releasedKey
					if input.UserInputType == Enum.UserInputType.Keyboard then releasedKey = input.KeyCode.Name
					elseif input.UserInputType == Enum.UserInputType.MouseButton1 then releasedKey = "MouseLeft"
					elseif input.UserInputType == Enum.UserInputType.MouseButton2 then releasedKey = "MouseRight" end
					if releasedKey == CurrentKey and CurrentMode == "Hold" and HoldActive then
						HoldActive = false; pcall(Callback, false)
					end
				end)

				local controlData = {
					Name        = TitleText,
					Section     = Section,
					Element     = BindFrame,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame
				}
				table.insert(getgenv().AllControls, controlData)

				local keybindFunction = {}
				function keybindFunction:Set(newKey) CurrentKey = GetKeyString(newKey); Bindkey.Text = CurrentKey end
				function keybindFunction:Get() return CurrentKey end
				function keybindFunction:SetMode(mode)
					if mode == "Hold" or mode == "Toggle" then
						CurrentMode = mode; ToggleState = false; HoldActive = false
					end
				end
				function keybindFunction:GetMode() return CurrentMode end
				function keybindFunction:GetState()
					if CurrentMode == "Toggle" then return ToggleState
					elseif CurrentMode == "Hold" then return HoldActive end
					return false
				end

				if Callback and Default then pcall(Callback, Default) end
				return keybindFunction
			end

			-- ── INPUT ─────────────────────────────────────────────
			function sectionFunction:AddInput(idk, Setting)
				local TitleText   = tostring(Setting.Text or Setting.Title) or ""
				local Placeholder = tostring(Setting.Placeholder) or ""
				local Default     = Setting.Default or false
				local Number_Only = Setting.Numeric or false
				local Callback    = Setting.Callback

				local BoxFrame     = Instance.new("Frame", Section)
				local BoxCorner    = Instance.new("UICorner", BoxFrame)
				local BoxBG        = Instance.new("Frame", BoxFrame)
				local ButtonCorner = Instance.new("UICorner", BoxBG)
				local BoxStroke    = Instance.new("UIStroke", BoxBG)
				local Boxtitle     = Instance.new("TextLabel", BoxBG)
				local BoxCor       = Instance.new("Frame", BoxBG)
				local ButtonCorner2 = Instance.new("UICorner", BoxCor)
				local Boxxx        = Instance.new("TextBox", BoxCor)
				local Lineeeee     = Instance.new("Frame", BoxCor)
				local LineCorner   = Instance.new("UICorner", Lineeeee)

				BoxFrame.Name              = "BoxFrame"
				BoxFrame.BackgroundTransparency = 1
				BoxFrame.Size              = UDim2.new(1, 0, 0, 60)
				BoxCorner.CornerRadius     = UDim.new(0, 4)

				BoxBG.Name              = "Background1"
				BoxBG.AnchorPoint       = Vector2.new(0.5, 0.5)
				BoxBG.Position          = UDim2.new(0.5, 0, 0.5, 0)
				BoxBG.Size              = UDim2.new(1, -10, 1, 0)
				BoxBG.BackgroundColor3  = Color3.fromRGB(32, 32, 44)
				BoxBG.BackgroundTransparency = 0.5
				ButtonCorner.CornerRadius = UDim.new(0, 6)
				BoxStroke.Color          = Color3.fromRGB(80, 78, 60)
				BoxStroke.Thickness      = 1
				BoxStroke.Transparency   = 0.5

				Boxtitle.Name              = "TextColor"
				Boxtitle.BackgroundTransparency = 1
				Boxtitle.Position          = UDim2.new(0, 10, 0, 0)
				Boxtitle.Size              = UDim2.new(1, -10, 0.5, 0)
				Boxtitle.Font              = Enum.Font.GothamBold
				Boxtitle.Text              = TitleText
				Boxtitle.TextSize          = 13
				Boxtitle.TextXAlignment    = Enum.TextXAlignment.Left
				Boxtitle.TextColor3        = getgenv().UIColor["Text Color"]

				BoxCor.Name              = "Background2"
				BoxCor.AnchorPoint       = Vector2.new(1, 0.5)
				BoxCor.ClipsDescendants  = true
				BoxCor.Position          = UDim2.new(1, -6, 0, 38)
				BoxCor.Size              = UDim2.new(1, -12, 0, 22)
				BoxCor.BackgroundColor3  = Color3.fromRGB(44, 44, 60)
				ButtonCorner2.CornerRadius = UDim.new(0, 4)

				Boxxx.Name              = "TextColorPlaceholder"
				Boxxx.BackgroundTransparency = 1
				Boxxx.Position          = UDim2.new(0, 6, 0, 0)
				Boxxx.Size              = UDim2.new(1, -6, 1, 0)
				Boxxx.Font              = Enum.Font.GothamBold
				Boxxx.PlaceholderText   = Placeholder
				Boxxx.Text              = ""
				Boxxx.TextSize          = 13
				Boxxx.TextXAlignment    = Enum.TextXAlignment.Left
				Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
				Boxxx.TextColor3        = getgenv().UIColor["Text Color"]

				Lineeeee.Name              = "TextNSBoxLineeeee"
				Lineeeee.BackgroundTransparency = 1
				Lineeeee.Position          = UDim2.new(0, 0, 1, -2)
				Lineeeee.Size              = UDim2.new(1, 0, 0, 2)
				Lineeeee.BackgroundColor3  = getgenv().UIColor["Box Highlight Color"]
				LineCorner.CornerRadius    = UDim.new(1, 0)

				Boxxx.Focused:Connect(function()
					tw(Lineeeee, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundTransparency = 0 })
					tw(BoxStroke, getgenv().UIColor["Tween Animation 2 Speed"], {
						Color        = getgenv().UIColor["Box Highlight Color"],
						Transparency = 0.4
					})
				end)

				if Number_Only then
					Boxxx:GetPropertyChangedSignal("Text"):Connect(function()
						if not tonumber(Boxxx.Text) then
							Boxxx.PlaceholderText = Placeholder
							Boxxx.Text = ''
						end
					end)
				end

				Boxxx.FocusLost:Connect(function()
					tw(Lineeeee, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundTransparency = 1 })
					tw(BoxStroke, getgenv().UIColor["Tween Animation 2 Speed"], {
						Color        = Color3.fromRGB(80, 78, 60),
						Transparency = 0.5
					})
					if Boxxx.Text ~= '' then Callback(Boxxx.Text) end
				end)

				if Default then Boxxx.Text = Default end

				local textbox_function = {}
				function textbox_function.SetValue(Value)
					Boxxx.Text = Value
					Callback(Value)
				end

				local controlData = {
					Name        = TitleText,
					Section     = Section,
					Element     = BoxFrame,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame
				}
				table.insert(getgenv().AllControls, controlData)
				if Callback and Default then pcall(Callback, Default) end
				return textbox_function
			end

			-- ── SLIDER ────────────────────────────────────────────
			function sectionFunction:AddSlider(Setting)
				local TitleText    = tostring(Setting.Text or Setting.Title) or ""
				local minValue     = tonumber(Setting.Min) or 0
				local maxValue     = tonumber(Setting.Max) or 100
				local Precise      = Setting.Precise or false
				local DefaultValue = tonumber(Setting.Default) or 0
				local Callback     = Setting.Callback
				local SizeChia     = 400

				local SliderFrame    = Instance.new("Frame", Section)
				local SliderCorner   = Instance.new("UICorner", SliderFrame)
				local SliderBG       = Instance.new("Frame", SliderFrame)
				local SliderBGCorner = Instance.new("UICorner", SliderBG)
				local SliderStroke   = Instance.new("UIStroke", SliderBG)
				local SliderTitle    = Instance.new("TextLabel", SliderBG)
				local SliderBar      = Instance.new("Frame", SliderFrame)
				local SliderButton   = Instance.new("TextButton", SliderBar)
				local SliderBarCorner = Instance.new("UICorner", SliderBar)
				local Bar            = Instance.new("Frame", SliderBar)
				local BarCorner      = Instance.new("UICorner", Bar)
				-- Bar thumb
				local BarThumb       = Instance.new("Frame", SliderBar)
				local BarThumbCorner = Instance.new("UICorner", BarThumb)
				local BarGlow        = Instance.new("ImageLabel", SliderBar)
				local Sliderboxframe = Instance.new("Frame", SliderFrame)
				local Sliderbox      = Instance.new("UICorner", Sliderboxframe)
				local Sliderbox_2    = Instance.new("TextBox", Sliderboxframe)

				SliderFrame.Name              = TitleText .. 'buda'
				SliderFrame.BackgroundTransparency = 1
				SliderFrame.Size              = UDim2.new(1, 0, 0, 52)
				SliderCorner.CornerRadius     = UDim.new(0, 4)

				SliderBG.Name              = "Background1"
				SliderBG.AnchorPoint       = Vector2.new(0.5, 0.5)
				SliderBG.Position          = UDim2.new(0.5, 0, 0.5, 0)
				SliderBG.Size              = UDim2.new(1, -10, 1, 0)
				SliderBG.BackgroundColor3  = Color3.fromRGB(32, 32, 44)
				SliderBG.BackgroundTransparency = 0.5
				SliderBGCorner.CornerRadius = UDim.new(0, 6)
				SliderStroke.Color         = Color3.fromRGB(80, 78, 60)
				SliderStroke.Thickness     = 1
				SliderStroke.Transparency  = 0.5

				SliderTitle.Name              = "TextColor"
				SliderTitle.BackgroundTransparency = 1
				SliderTitle.Position          = UDim2.new(0, 10, 0, 0)
				SliderTitle.Size              = UDim2.new(1, -10, 0, 26)
				SliderTitle.Font              = Enum.Font.GothamBold
				SliderTitle.Text              = TitleText
				SliderTitle.TextSize          = 13
				SliderTitle.RichText          = true
				SliderTitle.TextXAlignment    = Enum.TextXAlignment.Left
				SliderTitle.TextColor3        = getgenv().UIColor["Text Color"]

				SliderBar.Name              = "SliderBar"
				SliderBar.AnchorPoint       = Vector2.new(0.5, 0.5)
				SliderBar.Position          = UDim2.new(0.5, 0, 0.5, 14)
				SliderBar.Size              = UDim2.new(0, SizeChia, 0, 5)
				SliderBar.BackgroundColor3  = Color3.fromRGB(60, 60, 78)
				SliderBarCorner.CornerRadius = UDim.new(1, 0)

				SliderButton.Name              = "SliderButton "
				SliderButton.BackgroundTransparency = 1
				SliderButton.Size              = UDim2.new(1, 0, 1, 0)
				SliderButton.Font              = Enum.Font.GothamBold
				SliderButton.Text              = ""

				Bar.Name              = "Bar"
				Bar.BorderSizePixel   = 0
				Bar.Size              = UDim2.new(0, 0, 1, 0)
				Bar.BackgroundColor3  = getgenv().UIColor["Slider Line Color"]
				BarCorner.CornerRadius = UDim.new(1, 0)

				-- Thumb indicator
				BarThumb.Name              = "BarThumb"
				BarThumb.AnchorPoint       = Vector2.new(1, 0.5)
				BarThumb.BackgroundColor3  = Color3.fromRGB(255, 255, 255)
				BarThumb.Position          = UDim2.new(0, 0, 0.5, 0)
				BarThumb.Size              = UDim2.new(0, 10, 0, 10)
				BarThumb.ZIndex            = 3
				BarThumbCorner.CornerRadius = UDim.new(1, 0)
				BarThumb.Parent            = Bar

				BarGlow.AnchorPoint       = Vector2.new(0.5, 0.5)
				BarGlow.BackgroundTransparency = 1
				BarGlow.Position          = UDim2.new(0, 0, 0.5, 0)
				BarGlow.Size              = UDim2.new(0, 20, 0, 20)
				BarGlow.ZIndex            = 2
				BarGlow.Image             = "rbxassetid://5028857084"
				BarGlow.ImageTransparency = 0.65
				BarGlow.ImageColor3       = getgenv().UIColor["Slider Line Color"]
				BarGlow.ScaleType         = Enum.ScaleType.Slice
				BarGlow.SliceCenter       = Rect.new(24, 24, 276, 276)
				BarGlow.Parent            = Bar

				Sliderboxframe.Name              = "Background2"
				Sliderboxframe.AnchorPoint       = Vector2.new(1, 0)
				Sliderboxframe.Position          = UDim2.new(1, -10, 0, 6)
				Sliderboxframe.Size              = UDim2.new(0, 80, 0, 22)
				Sliderboxframe.BackgroundColor3  = Color3.fromRGB(44, 44, 60)
				Sliderbox.CornerRadius           = UDim.new(0, 4)

				Sliderbox_2.Name              = "TextColor"
				Sliderbox_2.BackgroundTransparency = 1
				Sliderbox_2.Size              = UDim2.new(1, 0, 1, 0)
				Sliderbox_2.Font              = Enum.Font.GothamBold
				Sliderbox_2.Text              = ""
				Sliderbox_2.TextSize          = 13
				Sliderbox_2.TextColor3        = getgenv().UIColor["Text Color"]

				SliderButton.MouseEnter:Connect(function()
					tw(Bar, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundColor3 = getgenv().UIColor["Slider Highlight Color"] })
					tw(SliderStroke, 0.15, { Color = getgenv().UIColor["Title Text Color"], Transparency = 0.4 })
				end)
				SliderButton.MouseLeave:Connect(function()
					tw(Bar, getgenv().UIColor["Tween Animation 2 Speed"], { BackgroundColor3 = getgenv().UIColor["Slider Line Color"] })
					tw(SliderStroke, 0.15, { Color = Color3.fromRGB(80, 78, 60), Transparency = 0.5 })
				end)

				local callBackAndSetText = function(val)
					Sliderbox_2.Text = val
					Callback(tonumber(val))
				end

				DefaultValue = math.clamp(DefaultValue, minValue, maxValue)
				Sliderbox_2.Text = tostring(DefaultValue)
				Bar.Size         = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 1, 0)

				local dragging, dragInput = false, nil
				local holdTime, holdStarted = 0, 0

				SliderButton.InputBegan:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or
					   input.UserInputType == Enum.UserInputType.Touch then
						holdStarted = tick()
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false; holdStarted = 0
							end
						end)
					end
				end)
				SliderButton.InputEnded:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or
					   input.UserInputType == Enum.UserInputType.Touch then
						dragging = false; holdStarted = 0
					end
				end)
				SliderButton.InputChanged:Connect(function(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or
					   input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end)

				RunService.RenderStepped:Connect(function()
					if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
						dragging = true
					end
					if dragging and dragInput then
						local value = Setting.Rouding
							and tonumber(string.format("%." .. (Setting.Rouding or 1) .. "f",
								(((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue)))
							or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
						pcall(callBackAndSetText, value)
						Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 5)
					end
				end)

				local function GetSliderValue(Value)
					local v = tonumber(Value) or minValue
					if v <= minValue then
						Bar.Size = UDim2.new(0, 0, 0, 5); callBackAndSetText(minValue)
					elseif v >= maxValue then
						Bar.Size = UDim2.new(0, maxValue / maxValue * SizeChia, 0, 5); callBackAndSetText(maxValue)
					else
						Bar.Size = UDim2.new(1 - ((maxValue - v) / (maxValue - minValue)), 0, 0, 5); callBackAndSetText(v)
					end
				end

				Sliderbox_2.FocusLost:Connect(function() GetSliderValue(Sliderbox_2.Text) end)

				local slider_function = {}
				function slider_function.SetValue(Value) GetSliderValue(Value) end

				local controlData = {
					Name        = TitleText,
					Section     = Section,
					Element     = SliderFrame,
					SectionName = Section_Name,
					TabName     = Page_Name,
					TabButton   = PageNameFrame
				}
				table.insert(getgenv().AllControls, controlData)
				if Callback and DefaultValue then pcall(Callback, DefaultValue) end
				return slider_function
			end

			return sectionFunction
		end

		-- Compatibility wrappers
		local pagefunc = {}
		function pagefunc:AddLeftGroupbox(name)  return pageFunction:AddSection(name) end
		function pagefunc:AddRightGroupbox(name) return pageFunction:AddSection(name) end
		return pagefunc
	end

	return Main_Function
end

return Library
