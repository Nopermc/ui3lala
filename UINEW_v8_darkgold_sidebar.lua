-- HDANH HUB - CYBERPUNK DARK EDITION
-- Theme: Đen/xám than + Cyan neon + Vàng gold
-- Logic giữ nguyên từ bản gốc, giao diện thiết kế lại 100%

if getgenv().Nousigi then 
	if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "HDanh Hub") then
				v:Destroy()
			end
		end
	end
end
getgenv().Nousigi = true

local DisableAnimation = game.Players.LocalPlayer.PlayerGui:FindFirstChild('TouchGui')

-- ============================================================
-- THEME: CYBERPUNK DARK
-- Nền đen xám than + accent cyan neon + chữ vàng gold
-- ============================================================
local T1UIColor = {
    -- Accent / border : vàng gold (giống nút "Click" & tiêu đề trong ảnh mẫu)
    ["Border Color"]                  = Color3.fromRGB(224, 182, 112),
    ["Click Effect Color"]            = Color3.fromRGB(224, 182, 112),
    ["Setting Icon Color"]            = Color3.fromRGB(224, 182, 112),
    ["Logo Image"]                    = "rbxassetid://123613996022560",
    ["Search Icon Color"]             = Color3.fromRGB(200, 165, 100),
    ["Search Icon Highlight Color"]   = Color3.fromRGB(224, 182, 112),
    ["GUI Text Color"]                = Color3.fromRGB(224, 182, 112),
    -- Text Color chính: trắng sáng trên nền than đen
    ["Text Color"]                    = Color3.fromRGB(232, 232, 238),
    ["Placeholder Text Color"]        = Color3.fromRGB(118, 122, 136),
    ["Title Text Color"]              = Color3.fromRGB(224, 182, 112),

    -- Background sáng tối xen kẽ
    ["Background Main Color"]         = Color3.fromRGB(17, 18, 24),   -- tím đen sâu
    ["Background 1 Color"]            = Color3.fromRGB(30, 32, 42),   -- tím tối (sáng hơn)
    ["Background 1 Transparency"]     = 0.0,
    ["Background 2 Color"]            = Color3.fromRGB(24, 26, 34),   -- tím đen (tối hơn)
    ["Background 3 Color"]            = Color3.fromRGB(32, 35, 45),   -- tím đen trung
    ["Background Image"]              = "",

    ["Page Selected Color"]           = Color3.fromRGB(224, 182, 112),
    -- Section: vàng nổi bật trên nền tối
    ["Section Text Color"]            = Color3.fromRGB(224, 182, 112),
    ["Section Underline Color"]       = Color3.fromRGB(130, 80, 220),
    -- Toggle: xanh lá check
    ["Toggle Border Color"]           = Color3.fromRGB(20, 140, 80),
    ["Toggle Checked Color"]          = Color3.fromRGB(30, 160, 90),
    ["Toggle Desc Color"]             = Color3.fromRGB(148, 152, 168),

    -- Button: nền sáng hơn section
    ["Button Color"]                  = Color3.fromRGB(214, 178, 108),
    ["Label Color"]                   = Color3.fromRGB(24, 26, 34),
    ["Dropdown Icon Color"]           = Color3.fromRGB(255, 100, 180),
    ["Dropdown Selected Color"]       = Color3.fromRGB(255, 100, 180),
    ["Dropdown Selected Check Color"] = Color3.fromRGB(80, 255, 160),

    ["Textbox Highlight Color"]       = Color3.fromRGB(0, 210, 230),
    ["Box Highlight Color"]           = Color3.fromRGB(0, 160, 180),
    ["Slider Line Color"]             = Color3.fromRGB(55, 58, 72),
    ["Slider Highlight Color"]        = Color3.fromRGB(255, 160, 40),

    ["Tween Animation 1 Speed"]       = DisableAnimation and 0 or 0.25,
    ["Tween Animation 2 Speed"]       = DisableAnimation and 0 or 0.5,
    ["Tween Animation 3 Speed"]       = DisableAnimation and 0 or 0.1,
    ["Text Stroke Transparency"]      = .85
}

getgenv().UIColor = T1UIColor
getgenv().AllControls = {}
getgenv().UIToggled = false

local currcolor = {}
local Library = {};
local Library_Function = {}
local TweenService = game:GetService('TweenService')
local uis = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local function makeDraggable(topBarObject, object)
	local dragging = nil
	local dragInput = nil
	local dragStart = nil
	local startPosition = nil
	topBarObject.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPosition = object.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	topBarObject.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)
	uis.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			local delta = input.Position - dragStart
			if not djtmemay and cac then
				TweenService:Create(object, TweenInfo.new(DisableAnimation and 0 or 0.35, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {
					Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
				}):Play()
			elseif not djtmemay and not cac then
				object.Position = UDim2.new(startPosition.X.Scale, startPosition.X.Offset + delta.X, startPosition.Y.Scale, startPosition.Y.Offset + delta.Y)
			end
		end
	end)
end

Library_Function.Gui = Instance.new('ScreenGui')
Library_Function.Gui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.Gui.Name = 'HDanh Hub GUI'
Library_Function.Gui.Enabled = false

getgenv().ReadyForGuiLoaded = false
spawn(function()
	repeat
		task.wait()
	until getgenv().ReadyForGuiLoaded
	if getgenv().UIToggled then
		Library_Function.Gui.Enabled = true
	end
end)

Library_Function.NotiGui = Instance.new('ScreenGui')
Library_Function.NotiGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.NotiGui.Name = 'HDanh Hub Notification'

Library_Function.HideGui = Instance.new('ScreenGui')
Library_Function.HideGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
Library_Function.HideGui.Name = 'HDanh Hub'

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local ToggleScreenGui = Instance.new("ScreenGui")
ToggleScreenGui.Parent = game:GetService("CoreGui")
ToggleScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ToggleScreenGui.Name = "NazuXWindowsToggleUltimate"

local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UIS = game:GetService("UserInputService")

-- ============================================================
-- TOGGLE BUTTON - CYBERPUNK STYLE
-- ============================================================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "BananaToggleGui"
screenGui.ResetOnSpawn = false
screenGui.IgnoreGuiInset = true
screenGui.Parent = CoreGui

local mainButton = Instance.new("ImageButton")
mainButton.Parent = screenGui
mainButton.Size = UDim2.new(0, 58, 0, 58)
mainButton.Position = UDim2.new(0, 12, 0.5, -29)
mainButton.BackgroundColor3 = Color3.fromRGB(36, 39, 52)
mainButton.BackgroundTransparency = 0
mainButton.AutoButtonColor = false
mainButton.Image = "rbxassetid://123613996022560"
mainButton.ImageColor3 = Color3.fromRGB(224, 182, 112)
mainButton.ScaleType = Enum.ScaleType.Fit
mainButton.ZIndex = 10
mainButton.ClipsDescendants = true
local mainBtnCorner = Instance.new("UICorner", mainButton)
mainBtnCorner.CornerRadius = UDim.new(0, 14)
local mainBtnStroke = Instance.new("UIStroke", mainButton)
mainBtnStroke.Thickness = 2
local mainBtnGrad = Instance.new("UIGradient", mainBtnStroke)
mainBtnGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 210, 140)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(224, 182, 112)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 140, 70))
	}
mainBtnGrad.Rotation = 45

-- Bo tròn hoàn toàn
local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 10)
corner.Parent = mainButton

local icon = mainButton

-- UIStroke vàng gold (bỏ lớp innerGlow Frame thừa để giảm lag nhẹ)
local UIStroke = Instance.new("UIStroke")
UIStroke.Parent = mainButton
UIStroke.Color = Color3.fromRGB(224, 182, 112)
UIStroke.Thickness = 1.5
UIStroke.Transparency = 0.4

local isToggled = true
local dragging = false
local dragStart
local startPos
local CLICK_DISTANCE = 6

local tweenOn = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local tweenOff = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local fluentTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local hoverTweenInfo  = TweenInfo.new(0.15, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local clickTweenInfo  = TweenInfo.new(0.1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
local defaultTweenInfo = TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

local faded = false
local fadeOutTween = TweenService:Create(icon, defaultTweenInfo, { ImageTransparency = 0 })
local fadeInTween  = TweenService:Create(icon, defaultTweenInfo, { ImageTransparency = 0 })

mainButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		dragStart = input.Position
		startPos = mainButton.Position
		dragging = true
	end
end)

UIS.InputChanged:Connect(function(input)
	if dragging and (
		input.UserInputType == Enum.UserInputType.MouseMovement
		or input.UserInputType == Enum.UserInputType.Touch
	) then
		local delta = input.Position - dragStart
		if math.abs(delta.X) > CLICK_DISTANCE or math.abs(delta.Y) > CLICK_DISTANCE then
			mainButton.Position = UDim2.new(
				startPos.X.Scale,
				startPos.X.Offset + delta.X,
				startPos.Y.Scale,
				startPos.Y.Offset + delta.Y
			)
		end
	end
end)

UIS.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1
	or input.UserInputType == Enum.UserInputType.Touch then
		local delta = input.Position - dragStart
		if math.abs(delta.X) < CLICK_DISTANCE and math.abs(delta.Y) < CLICK_DISTANCE then
			isToggled = not isToggled
			if isToggled then
				TweenService:Create(mainButton, tweenOn, { BackgroundColor3 = Color3.fromRGB(36, 39, 52) }):Play()
			else
				TweenService:Create(mainButton, tweenOff, { BackgroundColor3 = Color3.fromRGB(48, 52, 70) }):Play()
			end
		end
		dragging = false
	end
end)

mainButton.MouseEnter:Connect(function()
	TweenService:Create(mainButton, fluentTweenInfo, { Size = UDim2.new(0, 62, 0, 62), BackgroundTransparency = 0 }):Play()
	TweenService:Create(UIStroke, fluentTweenInfo, { Transparency = 0.1 }):Play()
	TweenService:Create(mainButton, hoverTweenInfo, { BackgroundColor3 = Color3.fromRGB(28, 30, 40) }):Play()
end)

mainButton.MouseLeave:Connect(function()
	local targetColor = isToggled and Color3.fromRGB(36, 39, 52) or Color3.fromRGB(48, 52, 70)
	TweenService:Create(mainButton, fluentTweenInfo, { Size = UDim2.new(0, 58, 0, 58), BackgroundTransparency = 0 }):Play()
	TweenService:Create(UIStroke, fluentTweenInfo, { Transparency = 0.4 }):Play()
	TweenService:Create(mainButton, defaultTweenInfo, { BackgroundColor3 = targetColor }):Play()
end)

mainButton.MouseButton1Down:Connect(function()
	TweenService:Create(mainButton, hoverTweenInfo, { Size = UDim2.new(0, 54, 0, 54), BackgroundColor3 = Color3.fromRGB(28, 30, 40) }):Play()
end)

mainButton.MouseButton1Click:Connect(function()
	Library.ToggleUI()
	isToggled = getgenv().UIToggled
	local scaleTween = TweenService:Create(mainButton, clickTweenInfo, { Size = UDim2.new(0, 53, 0, 53) })
	local scaleBackTween = TweenService:Create(mainButton, clickTweenInfo, { Size = UDim2.new(0, 58, 0, 58) })
	local targetColor = isToggled and Color3.fromRGB(36, 39, 52) or Color3.fromRGB(48, 52, 70)
	local colorTween = TweenService:Create(mainButton, defaultTweenInfo, { BackgroundColor3 = targetColor })
	if faded then fadeOutTween:Play() else fadeInTween:Play() end
	faded = not faded
	scaleTween:Play()
	colorTween:Play()
	spawn(function() wait(0.15) scaleBackTween:Play() end)
end)

Library.ToggleUI = function()
	getgenv().UIToggled = not getgenv().UIToggled
	if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
		for a, b in ipairs(game.CoreGui:GetChildren()) do
			if b.Name == "HDanh Hub GUI" then
				b.Enabled = getgenv().UIToggled
			end
		end
	end
	isToggled = getgenv().UIToggled
	local targetColor = isToggled and Color3.fromRGB(36, 39, 52) or Color3.fromRGB(48, 52, 70)
	TweenService:Create(mainButton, defaultTweenInfo, { BackgroundColor3 = targetColor }):Play()
end

Library.DestroyUI = function()
	if game.CoreGui:FindFirstChild("HDanh Hub GUI") then
		for i, v in ipairs(game.CoreGui:GetChildren()) do
			if string.find(v.Name, "HDanh Hub") then v:Destroy() end
		end
	end
	local toggleGui = game.CoreGui:FindFirstChild("NazuXWindowsToggleUltimate")
	if toggleGui then toggleGui:Destroy() end
	getgenv().Nousigi = false
	getgenv().UIToggled = false
	getgenv().AllControls = {}
	getgenv().ReadyForGuiLoaded = false
end

-- ============================================================
-- NOTIFICATION SYSTEM
-- ============================================================
local NotiContainer = Instance.new("Frame")
local NotiList = Instance.new("UIListLayout")
NotiContainer.Name = "NotiContainer"
NotiContainer.Parent = Library_Function.NotiGui
NotiContainer.AnchorPoint = Vector2.new(1, 1)
NotiContainer.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
NotiContainer.BackgroundTransparency = 1.000
NotiContainer.Position = UDim2.new(1, -5, 1, -5)
NotiContainer.Size = UDim2.new(0, 350, 1, -10)
NotiList.Name = "NotiList"
NotiList.Parent = NotiContainer
NotiList.SortOrder = Enum.SortOrder.LayoutOrder
NotiList.VerticalAlignment = Enum.VerticalAlignment.Bottom
NotiList.Padding = UDim.new(0, 5)

Library_Function.Gui.Parent = game:GetService('CoreGui')
Library_Function.NotiGui.Parent = game:GetService('CoreGui')
Library_Function.HideGui.Parent = game:GetService('CoreGui')

function Library_Function.Getcolor(color)
	return { math.floor(color.r * 255), math.floor(color.g * 255), math.floor(color.b * 255) }
end

local libCreateNoti = function(Setting)
	getgenv().TitleNameNoti = Setting.Title or ""
	local Description = Setting.Description or Setting.Desc or Setting.Content or ""
	local Duration = Setting.Duration or Setting.Timeshow or Setting.Delay or 10

	local NotiFrame = Instance.new("Frame")
	local Noticontainer = Instance.new("Frame")
	local UICorner = Instance.new("UICorner")
	local NotiStroke = Instance.new("UIStroke")
	local Title_1 = Instance.new("TextLabel")
	local TextButton = Instance.new("TextButton")
	local CloseImage = Instance.new("ImageLabel")

	NotiFrame.Name = "NotiFrame"
	NotiFrame.Parent = NotiContainer
	NotiFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
	NotiFrame.BackgroundTransparency = 1
	NotiFrame.Size = UDim2.new(1, 0, 0, 60)
	NotiFrame.ClipsDescendants = true

	Noticontainer.Name = "Noticontainer"
	Noticontainer.Parent = NotiFrame
	Noticontainer.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
	Noticontainer.Size = UDim2.new(1, 0, 1, 0)
	Noticontainer.Position = UDim2.new(1, 0, 0, 0)

	UICorner.CornerRadius = UDim.new(0, 6)
	UICorner.Parent = Noticontainer

	NotiStroke.Color = Color3.fromRGB(0, 210, 230)
	NotiStroke.Thickness = 1
	NotiStroke.Transparency = 0.5
	NotiStroke.Parent = Noticontainer

	-- Left accent bar
	local accentBar = Instance.new("Frame")
	accentBar.Parent = Noticontainer
	accentBar.Size = UDim2.new(0, 3, 1, 0)
	accentBar.BackgroundColor3 = Color3.fromRGB(0, 210, 230)
	accentBar.BorderSizePixel = 0
	local accentCorner = Instance.new("UICorner")
	accentCorner.CornerRadius = UDim.new(0, 3)
	accentCorner.Parent = accentBar

	Title_1.Name = "Title"
	Title_1.Parent = Noticontainer
	Title_1.BackgroundTransparency = 1
	Title_1.Position = UDim2.new(0, 14, 0, 8)
	Title_1.Size = UDim2.new(1, -40, 0, 20)
	Title_1.Font = Enum.Font.GothamBold
	Title_1.Text = getgenv().TitleNameNoti
	Title_1.TextSize = 14
	Title_1.TextXAlignment = Enum.TextXAlignment.Left
	Title_1.TextColor3 = Color3.fromRGB(224, 182, 112)

	TextButton.Name = "CloseBtn"
	TextButton.Parent = Noticontainer
	TextButton.BackgroundTransparency = 1
	TextButton.AnchorPoint = Vector2.new(1, 0)
	TextButton.Position = UDim2.new(1, -5, 0, 5)
	TextButton.Size = UDim2.new(0, 20, 0, 20)
	TextButton.Text = ""

	CloseImage.Name = "CloseImage"
	CloseImage.Parent = TextButton
	CloseImage.AnchorPoint = Vector2.new(0.5, 0.5)
	CloseImage.BackgroundTransparency = 1
	CloseImage.Position = UDim2.new(0.5, 0, 0.5, 0)
	CloseImage.Size = UDim2.new(0.8, 0, 0.8, 0)
	CloseImage.Image = "rbxassetid://3926305904"
	CloseImage.ImageRectOffset = Vector2.new(284, 4)
	CloseImage.ImageRectSize = Vector2.new(24, 24)
	CloseImage.ImageColor3 = getgenv().UIColor["Search Icon Color"]

	if Description and Description ~= "" then
		NotiFrame.Size = UDim2.new(1, 0, 0, 80)
		local TextLabelNoti2 = Instance.new("TextLabel")
		TextLabelNoti2.BackgroundTransparency = 1
		TextLabelNoti2.Position = UDim2.new(0, 14, 0, 30)
		TextLabelNoti2.Size = UDim2.new(1, -20, 0, 0)
		TextLabelNoti2.Font = Enum.Font.GothamBold
		TextLabelNoti2.Text = Description
		TextLabelNoti2.TextSize = 12
		TextLabelNoti2.TextXAlignment = Enum.TextXAlignment.Left
		TextLabelNoti2.RichText = true
		TextLabelNoti2.TextColor3 = getgenv().UIColor["Text Color"]
		TextLabelNoti2.AutomaticSize = Enum.AutomaticSize.Y
		TextLabelNoti2.TextWrapped = true
		TextLabelNoti2.Parent = Noticontainer
	end

	local function remove()
		TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			Position = UDim2.new(1, 0, 0, 0)
		}):Play()
		wait(.25)
		NotiFrame:Destroy()
	end

	TweenService:Create(Noticontainer, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
		Position = UDim2.new(0, 0, 0, 0)
	}):Play()

	TextButton.MouseEnter:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Highlight Color"]
		}):Play()
	end)
	TextButton.MouseLeave:Connect(function()
		TweenService:Create(CloseImage, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
			ImageColor3 = getgenv().UIColor["Search Icon Color"]
		}):Play()
	end)
	TextButton.MouseButton1Click:Connect(function() wait(.25) remove() end)
	spawn(function() wait(Duration) remove() end)
end

function Library:Notify(Setting, bypass)
	if not getgenv().Config or bypass then
		local s, e = pcall(function() libCreateNoti(Setting) end)
		if e then print(e) end
	end
end

-- ============================================================
-- CREATE WINDOW - CYBERPUNK DARK
-- ============================================================
-- ============================================================
-- CREATE WINDOW  -  BANANA HUB  REDESIGN v3
-- Layout: Tab bar nằm NGANG trên TopBar, content bên dưới
-- Theme: multi-color pastel-neon trên nền đen sâu
-- ============================================================
-- ============================================================
-- CREATE WINDOW + ADD TAB  -  v5 FIX
-- Tab bar NGANG, width cố định, scroll X, click đúng
-- ============================================================
function Library:CreateWindow(Setting)
	local TitleNameMain = Setting.Title or "HDANH HUB"
	getgenv().MainDesc = Setting.Desc or Setting.Subtitle or ""
	if Setting.Image then getgenv().UIColor["Logo Image"] = Setting.Image end

	local djtmemay = false
	cac = false

	-- Tông vàng gold đồng nhất (đúng theo ảnh mẫu), thay cho cầu vồng neon cũ
	local TAB_COLORS = {
		Color3.fromRGB(224, 182, 112),
		Color3.fromRGB(224, 182, 112),
		Color3.fromRGB(224, 182, 112),
		Color3.fromRGB(224, 182, 112),
		Color3.fromRGB(224, 182, 112),
		Color3.fromRGB(224, 182, 112),
		Color3.fromRGB(224, 182, 112),
		Color3.fromRGB(224, 182, 112),
	}

	-- Tất cả instance
	local Main           = Instance.new("Frame")
	local MainContainer  = Instance.new("Frame")
	local MainCorner     = Instance.new("UICorner")
	local Shadow         = Instance.new("ImageLabel")
	local TopBar         = Instance.new("Frame")
	local TitleRow       = Instance.new("Frame")
	local TabBarFrame    = Instance.new("Frame")
	local ControlList    = Instance.new("ScrollingFrame")   -- tab scroll ngang
	local UIListLayout   = Instance.new("UIListLayout")
	local Concacontainer = Instance.new("Frame")
	local Concacmain     = Instance.new("Frame")
	local MainPage       = Instance.new("Frame")
	local UIPage         = Instance.new("UIPageLayout")
	local PageControl    = ControlList  -- alias compat

	-- -- MAIN -----------------------------------------------------
	Main.Name = "Main"
	Main.Parent = Library_Function.Gui
	Main.BackgroundTransparency = 1
	Main.Position = UDim2.new(0.5, 0, 0.5, 0)
	Main.AnchorPoint = Vector2.new(0.5, 0.5)
	Main.Size = UDim2.new(0, 620, 0, 390)
	makeDraggable(Main, Main)

	Shadow.Parent = Main
	Shadow.AnchorPoint = Vector2.new(0.5, 0.5)
	Shadow.BackgroundTransparency = 1
	Shadow.Position = UDim2.new(0.5, 0, 0.5, 0)
	Shadow.Size = UDim2.new(1, 30, 1, 30)   -- giảm từ 70 -> 30: đỡ tốn overdraw, bớt lag
	Shadow.ZIndex = 0
	Shadow.Image = "rbxassetid://5028857084"
	Shadow.ImageColor3 = Color3.fromRGB(0, 0, 0)
	Shadow.ImageTransparency = 0.55
	Shadow.ScaleType = Enum.ScaleType.Slice
	Shadow.SliceCenter = Rect.new(24, 24, 276, 276)

	MainContainer.Name = "MainContainer"
	MainContainer.Parent = Main
	MainContainer.BackgroundColor3 = Color3.fromRGB(17, 18, 24)
	MainContainer.Size = UDim2.new(1, 0, 1, 0)

	MainCorner.CornerRadius = UDim.new(0, 10)
	MainCorner.Parent = MainContainer

	-- Viền vàng gold mảnh, không gradient nhiều điểm (đỡ tốn hơn cầu vồng)
	local mainStroke = Instance.new("UIStroke", MainContainer)
	mainStroke.Thickness = 1
	mainStroke.Color = Color3.fromRGB(224, 182, 112)
	mainStroke.Transparency = 0.35

	-- Nền tối phẳng, không cần gradient nặng
	MainContainer.BackgroundColor3 = Color3.fromRGB(17, 18, 24)

	getgenv().ReadyForGuiLoaded = true

	-- -- TOP BAR (chỉ còn 1 dòng tiêu đề, 34px) --------------------
	TopBar.Name = "TopBar"
	TopBar.Parent = MainContainer
	TopBar.BackgroundColor3 = Color3.fromRGB(20, 21, 28)
	TopBar.Size = UDim2.new(1, 0, 0, 34)

	local topCorner = Instance.new("UICorner", TopBar)
	topCorner.CornerRadius = UDim.new(0, 10)

	-- TITLE ROW (34px)
	TitleRow.Name = "TitleRow"
	TitleRow.Parent = TopBar
	TitleRow.BackgroundTransparency = 1
	TitleRow.Size = UDim2.new(1, 0, 1, 0)

	local Logo = Instance.new("ImageLabel", TitleRow)
	Logo.BackgroundTransparency = 1
	Logo.Position = UDim2.new(0, 10, 0.5, 0)
	Logo.AnchorPoint = Vector2.new(0, 0.5)
	Logo.Size = UDim2.new(0, 18, 0, 18)
	Logo.Image = getgenv().UIColor["Logo Image"]
	local logoGrad = Instance.new("UIGradient", Logo)
	logoGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 210, 140)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(224, 182, 112)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 140, 70))
	}
	logoGrad.Rotation = 45

	local TitleLabel = Instance.new("TextLabel", TitleRow)
	TitleLabel.BackgroundTransparency = 1
	TitleLabel.Position = UDim2.new(0, 34, 0, 0)
	TitleLabel.Size = UDim2.new(0.55, 0, 1, 0)
	TitleLabel.Font = Enum.Font.GothamBlack
	TitleLabel.TextSize = 13
	TitleLabel.TextXAlignment = Enum.TextXAlignment.Left
	TitleLabel.RichText = true
	TitleLabel.Text = "<font color=\"rgb(60,20,140)\">" .. tostring(TitleNameMain) .. "</font>"

	local SubLabel = Instance.new("TextLabel", TitleRow)
	SubLabel.BackgroundTransparency = 1
	SubLabel.AnchorPoint = Vector2.new(1, 0.5)
	SubLabel.Position = UDim2.new(1, -10, 0.5, 0)
	SubLabel.Size = UDim2.new(0.4, 0, 0, 14)
	SubLabel.Font = Enum.Font.Gotham
	SubLabel.TextSize = 10
	SubLabel.TextXAlignment = Enum.TextXAlignment.Right
	SubLabel.TextColor3 = Color3.fromRGB(140, 144, 158)
	SubLabel.Text = tostring(getgenv().MainDesc or "")

	-- Divider dưới title
	local titleDiv = Instance.new("Frame", TitleRow)
	titleDiv.Size = UDim2.new(1, -20, 0, 1)
	titleDiv.Position = UDim2.new(0, 10, 1, -1)
	titleDiv.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	titleDiv.BackgroundTransparency = 0
	titleDiv.BorderSizePixel = 0
	local tdGrad = Instance.new("UIGradient", titleDiv)
	tdGrad.Color = ColorSequence.new{
		ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 210, 140)),
		ColorSequenceKeypoint.new(0.5, Color3.fromRGB(224, 182, 112)),
		ColorSequenceKeypoint.new(1, Color3.fromRGB(190, 140, 70))
	}

	-- SIDEBAR TRÁI (dọc, từ trên xuống dưới) - thay cho tab bar ngang cũ
	local SIDEBAR_W = 152
	TabBarFrame.Name = "TabBarFrame"      -- giờ đóng vai trò Sidebar
	TabBarFrame.Parent = MainContainer
	TabBarFrame.BackgroundColor3 = Color3.fromRGB(20, 21, 28)
	TabBarFrame.Position = UDim2.new(0, 0, 0, 34)
	TabBarFrame.Size = UDim2.new(0, SIDEBAR_W, 1, -34)
	TabBarFrame.ClipsDescendants = true

	-- Đường viền dọc phân cách sidebar / nội dung
	local sideDiv = Instance.new("Frame", TabBarFrame)
	sideDiv.Name = "SideDiv"
	sideDiv.AnchorPoint = Vector2.new(1, 0)
	sideDiv.Position = UDim2.new(1, 0, 0, 0)
	sideDiv.Size = UDim2.new(0, 1, 1, 0)
	sideDiv.BackgroundColor3 = Color3.fromRGB(224, 182, 112)
	sideDiv.BackgroundTransparency = 0.75
	sideDiv.BorderSizePixel = 0

	-- Search box trên cùng sidebar
	local SearchFrame = Instance.new("Frame", TabBarFrame)
	SearchFrame.Name = "PageSearch"
	SearchFrame.Position = UDim2.new(0, 6, 0, 6)
	SearchFrame.Size = UDim2.new(1, -12, 0, 26)
	SearchFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
	SearchFrame.BackgroundTransparency = 0.1
	local sfCorner = Instance.new("UICorner", SearchFrame)
	sfCorner.CornerRadius = UDim.new(0, 6)
	local sfStroke = Instance.new("UIStroke", SearchFrame)
	sfStroke.Color = Color3.fromRGB(224, 182, 112)
	sfStroke.Thickness = 1
	sfStroke.Transparency = 0.55

	local SearchIcon = Instance.new("ImageLabel", SearchFrame)
	SearchIcon.BackgroundTransparency = 1
	SearchIcon.Position = UDim2.new(0, 6, 0.5, 0)
	SearchIcon.AnchorPoint = Vector2.new(0, 0.5)
	SearchIcon.Size = UDim2.new(0, 13, 0, 13)
	SearchIcon.Image = "rbxassetid://8154282545"
	SearchIcon.ImageColor3 = Color3.fromRGB(200, 165, 100)

	local SearchBox = Instance.new("TextBox", SearchFrame)
	SearchBox.Name = "SearchBox"
	SearchBox.Active = true
	SearchBox.BackgroundTransparency = 1
	SearchBox.Position = UDim2.new(0, 24, 0, 0)
	SearchBox.Size = UDim2.new(1, -28, 1, 0)
	SearchBox.Font = Enum.Font.Gotham
	SearchBox.PlaceholderColor3 = Color3.fromRGB(118, 122, 136)
	SearchBox.PlaceholderText = "Tìm..."
	SearchBox.Text = ""
	SearchBox.TextColor3 = Color3.fromRGB(222, 222, 230)
	SearchBox.TextSize = 11
	SearchBox.TextXAlignment = Enum.TextXAlignment.Left
	SearchBox.CursorPosition = -1

	-- ScrollingFrame chứa tab buttons (dọc, từ trên xuống dưới)
	ControlList.Name = "ControlList"
	ControlList.Parent = TabBarFrame
	ControlList.BackgroundTransparency = 1
	ControlList.BorderSizePixel = 0
	ControlList.Position = UDim2.new(0, 4, 0, 38)
	ControlList.Size = UDim2.new(1, -8, 1, -44)
	ControlList.CanvasSize = UDim2.new(0, 0, 0, 0)
	ControlList.ScrollBarThickness = 2
	ControlList.ScrollBarImageColor3 = Color3.fromRGB(224, 182, 112)
	ControlList.ScrollingDirection = Enum.ScrollingDirection.Y
	ControlList.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
	ControlList.ElasticBehavior = Enum.ElasticBehavior.Never

	UIListLayout.Parent = ControlList
	UIListLayout.FillDirection = Enum.FillDirection.Vertical
	UIListLayout.SortOrder = Enum.SortOrder.LayoutOrder
	UIListLayout.Padding = UDim.new(0, 4)
	UIListLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

	-- Update canvas height khi tabs thay đổi (dọc thay vì ngang)
	UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		ControlList.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y + 10)
	end)

	-- -- CONTENT AREA (bên phải sidebar) ---------------------------
	Concacontainer.Name = "Concacontainer"
	Concacontainer.Parent = MainContainer
	Concacontainer.BackgroundTransparency = 1
	Concacontainer.ClipsDescendants = true
	Concacontainer.Position = UDim2.new(0, SIDEBAR_W, 0, 34)
	Concacontainer.Size = UDim2.new(1, -SIDEBAR_W, 1, -34)

	Concacmain.Name = "Concacmain"
	Concacmain.Parent = Concacontainer
	Concacmain.BackgroundTransparency = 1
	Concacmain.Size = UDim2.new(1, 0, 1, 0)

	MainPage.Name = "MainPage"
	MainPage.Parent = Concacmain
	MainPage.BackgroundTransparency = 1
	MainPage.ClipsDescendants = true
	MainPage.Position = UDim2.new(0, 6, 0, 4)
	MainPage.Size = UDim2.new(1, -12, 1, -8)

	UIPage.Name = "UIPage"
	UIPage.Parent = MainPage
	UIPage.FillDirection = Enum.FillDirection.Vertical
	UIPage.SortOrder = Enum.SortOrder.LayoutOrder
	UIPage.EasingDirection = Enum.EasingDirection.InOut
	UIPage.EasingStyle = Enum.EasingStyle.Quart
	UIPage.Padding = UDim.new(0, 10)
	UIPage.TweenTime = getgenv().UIColor["Tween Animation 1 Speed"]

	-- -- SEARCH LOGIC --------------------------------------------
	-- Hàm bỏ dấu tiếng Việt và chuẩn hoá chuỗi để so sánh
	local function normalizeStr(s)
		s = string.lower(tostring(s or ""))
		-- bỏ dấu tiếng Việt thường gặp
		local map = {
			["à"]="a",["á"]="a",["ả"]="a",["ã"]="a",["ạ"]="a",
			["ă"]="a",["ắ"]="a",["ặ"]="a",["ằ"]="a",["ẳ"]="a",["ẵ"]="a",
			["â"]="a",["ấ"]="a",["ầ"]="a",["ẩ"]="a",["ẫ"]="a",["ậ"]="a",
			["đ"]="d",
			["è"]="e",["é"]="e",["ẻ"]="e",["ẽ"]="e",["ẹ"]="e",
			["ê"]="e",["ế"]="e",["ề"]="e",["ể"]="e",["ễ"]="e",["ệ"]="e",
			["ì"]="i",["í"]="i",["ỉ"]="i",["ĩ"]="i",["ị"]="i",
			["ò"]="o",["ó"]="o",["ỏ"]="o",["õ"]="o",["ọ"]="o",
			["ô"]="o",["ố"]="o",["ồ"]="o",["ổ"]="o",["ỗ"]="o",["ộ"]="o",
			["ơ"]="o",["ớ"]="o",["ờ"]="o",["ở"]="o",["ỡ"]="o",["ợ"]="o",
			["ù"]="u",["ú"]="u",["ủ"]="u",["ũ"]="u",["ụ"]="u",
			["ư"]="u",["ứ"]="u",["ừ"]="u",["ử"]="u",["ữ"]="u",["ự"]="u",
			["ỳ"]="y",["ý"]="y",["ỷ"]="y",["ỹ"]="y",["ỵ"]="y",
		}
		for src, dst in pairs(map) do
			s = s:gsub(src, dst)
		end
		return s
	end

	-- Fuzzy match: tất cả ký tự trong query phải xuất hiện theo thứ tự trong target
	local function fuzzyMatch(target, query)
		if query == "" then return true end
		target = normalizeStr(target)
		query  = normalizeStr(query)
		-- Partial: nếu query là substring thì match ngay
		if string.find(target, query, 1, true) then return true end
		-- Fuzzy: từng ký tự của query phải xuất hiện tuần tự trong target
		local ti = 1
		for qi = 1, #query do
			local qc = query:sub(qi, qi)
			local found = false
			while ti <= #target do
				if target:sub(ti, ti) == qc then
					ti = ti + 1
					found = true
					break
				end
				ti = ti + 1
			end
			if not found then return false end
		end
		return true
	end

	if not GlobalSearch then
		GlobalSearch = function(searchText)
			-- Reset tất cả khi rỗng
			if searchText == "" or searchText == nil then
				for _, control in pairs(getgenv().AllControls) do
					control.Section.Visible = true
					control.Element.Visible = true
				end
				for _, tab in pairs(ControlList:GetChildren()) do
					if not tab:IsA("UIListLayout") then tab.Visible = true end
				end
				return
			end

			-- Ẩn tất cả trước
			for _, control in pairs(getgenv().AllControls) do
				control.Section.Visible = false
				control.Element.Visible = false
			end
			for _, tab in pairs(ControlList:GetChildren()) do
				if not tab:IsA("UIListLayout") then tab.Visible = false end
			end

			-- Gom theo section
			local elementsInSection = {}
			for _, control in pairs(getgenv().AllControls) do
				local ef = fuzzyMatch(control.Name or "", searchText)
				local sf = fuzzyMatch(control.SectionName or "", searchText)
				local tf = fuzzyMatch(control.TabName or "", searchText)
				if not elementsInSection[control.Section] then
					elementsInSection[control.Section] = {}
				end
				table.insert(elementsInSection[control.Section], {
					control = control, ef = ef, sf = sf, tf = tf
				})
			end

			local foundTabs = {}
			for section, elems in pairs(elementsInSection) do
				local hasElementMatch = false
				for _, ei in ipairs(elems) do
					if ei.ef then hasElementMatch = true end
				end
				for _, ei in ipairs(elems) do
					local c = ei.control
					if ei.ef then
						-- Chức năng khớp: hiện chức năng + section
						c.Element.Visible = true
						c.Section.Visible = true
						foundTabs[c.TabName] = true
					elseif ei.sf then
						-- Section khớp: hiện toàn bộ section
						c.Element.Visible = true
						c.Section.Visible = true
						foundTabs[c.TabName] = true
					elseif ei.tf then
						-- Tab khớp: hiện toàn bộ tab
						c.Element.Visible = true
						c.Section.Visible = true
						foundTabs[c.TabName] = true
					end
				end
			end

			-- Hiện tab trong ControlList
			for tabName in pairs(foundTabs) do
				for _, tab in pairs(ControlList:GetChildren()) do
					if not tab:IsA("UIListLayout") then
						local tName = tab.Name:gsub("_Control$","")
						if fuzzyMatch(tName, searchText) or tName == tabName then
							tab.Visible = true
						end
					end
				end
			end
		end
	end

	-- SearchBox events: Text change + FocusLost (thoát search)
	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		GlobalSearch(SearchBox.Text)
	end)

	-- Nút X để clear search (hiện khi có text)
	local ClearBtn = Instance.new("TextButton", SearchFrame)
	ClearBtn.Name = "ClearBtn"
	ClearBtn.AnchorPoint = Vector2.new(1, 0.5)
	ClearBtn.Position = UDim2.new(1, -3, 0.5, 0)
	ClearBtn.Size = UDim2.new(0, 18, 0, 18)
	ClearBtn.BackgroundTransparency = 1
	ClearBtn.Text = "X"
	ClearBtn.Font = Enum.Font.GothamBold
	ClearBtn.TextSize = 10
	ClearBtn.TextColor3 = Color3.fromRGB(140, 60, 200)
	ClearBtn.Visible = false
	ClearBtn.ZIndex = 20

	SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
		ClearBtn.Visible = SearchBox.Text ~= ""
	end)

	ClearBtn.MouseButton1Click:Connect(function()
		SearchBox.Text = ""
		ClearBtn.Visible = false
		GlobalSearch("")
	end)

	-- FocusLost: nếu bấm ra ngoài mà không nhập gì -> clear
	SearchBox.FocusLost:Connect(function(enterPressed)
		if SearchBox.Text == "" then
			GlobalSearch("")
		end
	end)

	local Main_Function  = {}
	local LayoutOrderBut = -1
	local LayoutOrder    = -1
	local TabColorIndex  = 0

	-- ============================================================
	-- ADD TAB  -  HORIZONTAL, FIXED WIDTH, SCROLLABLE
	-- ============================================================
	function Main_Function:AddTab(PageName, IconId)
		local Page_Name = tostring(PageName)

		LayoutOrder    = LayoutOrder    + 1
		LayoutOrderBut = LayoutOrderBut + 1
		TabColorIndex  = (TabColorIndex % #TAB_COLORS) + 1
		local tabColor = TAB_COLORS[TabColorIndex]

		-- Sidebar dọc: mỗi tab là 1 hàng full-width, cao cố định
		local TAB_H = 32

		local PageNameControl = Instance.new("Frame")
		local Frame           = Instance.new("Frame")
		local TabNameCorner   = Instance.new("UICorner")
		local Line            = Instance.new("Frame")
		local InLine          = Instance.new("Frame")
		local LineCorner      = Instance.new("UICorner")
		local TabTitleContainer = Instance.new("Frame")
		local TabTitle        = Instance.new("TextLabel")
		local PageButton      = Instance.new("TextButton")

		-- Wrapper - full width, cao cố định (hàng dọc)
		PageNameControl.Name = Page_Name .. "_Control"
		PageNameControl.Parent = ControlList
		PageNameControl.BackgroundTransparency = 1
		PageNameControl.LayoutOrder = LayoutOrderBut
		PageNameControl.Size = UDim2.new(1, 0, 0, TAB_H)

		-- Tab hàng ngang full-width
		Frame.Name = "Frame"
		Frame.Parent = PageNameControl
		Frame.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
		Frame.BackgroundTransparency = 1
		Frame.Size = UDim2.new(1, 0, 1, 0)
		Frame.ClipsDescendants = false

		TabNameCorner.CornerRadius = UDim.new(0, 6)
		TabNameCorner.Parent = Frame

		-- Gạch nhấn bên trái (thay cho gạch dưới) khi tab được chọn
		Line.Name = "Line"
		Line.Parent = Frame
		Line.BackgroundTransparency = 1
		Line.Size = UDim2.new(1, 0, 1, 0)

		InLine.Name = "PageInLine"
		InLine.Parent = Line
		InLine.BackgroundColor3 = tabColor
		InLine.BackgroundTransparency = 1
		InLine.BorderSizePixel = 0
		InLine.AnchorPoint = Vector2.new(0, 0.5)
		InLine.Position = UDim2.new(0, 0, 0.5, 0)
		InLine.Size = UDim2.new(0, 3, 0.6, 0)

		LineCorner.CornerRadius = UDim.new(1, 0)
		LineCorner.Parent = InLine

		-- Icon (căn trái)
		local iconOffset = 10
		if IconId and IconId ~= "" then
			local TabIcon = Instance.new("ImageLabel", Frame)
			TabIcon.Name = "TabIcon"
			TabIcon.BackgroundTransparency = 1
			TabIcon.Position = UDim2.new(0, 10, 0.5, 0)
			TabIcon.AnchorPoint = Vector2.new(0, 0.5)
			TabIcon.Size = UDim2.new(0, 15, 0, 15)
			TabIcon.Image = IconId
			TabIcon.ImageColor3 = tabColor
			TabIcon.ScaleType = Enum.ScaleType.Fit
			iconOffset = 32
		end

		-- Tab title - căn trái, giống danh sách trong ảnh mẫu
		TabTitleContainer.Name = "TabTitleContainer"
		TabTitleContainer.Parent = Frame
		TabTitleContainer.BackgroundTransparency = 1
		TabTitleContainer.Position = UDim2.new(0, iconOffset, 0, 0)
		TabTitleContainer.Size = UDim2.new(1, -iconOffset - 6, 1, 0)

		TabTitle.Name = "TabTitle"
		TabTitle.Parent = TabTitleContainer
		TabTitle.BackgroundTransparency = 1
		TabTitle.Size = UDim2.new(1, 0, 1, 0)
		TabTitle.Font = Enum.Font.GothamBold
		TabTitle.Text = Page_Name
		TabTitle.TextSize = 12
		TabTitle.TextXAlignment = Enum.TextXAlignment.Left
		TabTitle.TextColor3 = Color3.fromRGB(180, 183, 194)
		TabTitle.TextTruncate = Enum.TextTruncate.AtEnd

		-- PageButton phủ toàn bộ tab, ZIndex cao để nhận click
		PageButton.Name = "PageButton"
		PageButton.Parent = Frame
		PageButton.BackgroundTransparency = 1
		PageButton.Size = UDim2.new(1, 0, 1, 0)
		PageButton.ZIndex = 10
		PageButton.Font = Enum.Font.Gotham
		PageButton.Text = ""

		-- Page content
		local PageContainer = Instance.new("ScrollingFrame")
		PageContainer.Name = Page_Name
		PageContainer.Parent = MainPage
		PageContainer.Active = true
		PageContainer.BackgroundTransparency = 1
		PageContainer.BorderSizePixel = 0
		PageContainer.Size = UDim2.new(1, 0, 1, 0)
		PageContainer.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageContainer.CanvasSize = UDim2.new(0, 0, 0, 0)
		PageContainer.ScrollBarThickness = 3
		PageContainer.ScrollBarImageColor3 = tabColor
		PageContainer.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
		PageContainer.Visible = LayoutOrderBut == 0

		local PageList = Instance.new("Frame")
		PageList.Name = "PageList"
		PageList.Parent = PageContainer
		PageList.BackgroundTransparency = 1
		PageList.Size = UDim2.new(1, 0, 1, 0)
		PageList.AutomaticSize = Enum.AutomaticSize.Y

		local PageListLayout = Instance.new("UIListLayout")
		PageListLayout.Parent = PageList
		PageListLayout.SortOrder = Enum.SortOrder.LayoutOrder
		PageListLayout.Padding = UDim.new(0, 5)

		local PagePadding = Instance.new("UIPadding")
		PagePadding.Parent = PageList
		PagePadding.PaddingTop = UDim.new(0, 5)
		PagePadding.PaddingLeft = UDim.new(0, 5)
		PagePadding.PaddingRight = UDim.new(0, 5)
		PagePadding.PaddingBottom = UDim.new(0, 5)

		PageListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			PageContainer.CanvasSize = UDim2.new(0, 0, 0, PageListLayout.AbsoluteContentSize.Y + 10)
		end)

		-- Highlight tab đầu tiên
		for i, v in pairs(ControlList:GetChildren()) do
			if not v:IsA("UIListLayout") then
				if i == 2 then
					v.Frame.Line.PageInLine.BackgroundTransparency = 0
					v.Frame.BackgroundColor3 = Color3.fromRGB(38, 34, 26)
					v.Frame.BackgroundTransparency = 0
					v.Frame.TabTitleContainer.TabTitle.TextColor3 = Color3.fromRGB(235, 235, 240)
				end
			end
		end

		-- Tab click handler
		PageButton.MouseButton1Click:Connect(function()
			if tostring(UIPage.CurrentPage) == PageContainer.Name then return end

			for _, v in pairs(MainPage:GetChildren()) do
				if not v:IsA("UIPageLayout") and not v:IsA("UICorner") then
					v.Visible = false
				end
			end
			PageContainer.Visible = true
			UIPage:JumpTo(PageContainer)

			for _, v in next, ControlList:GetChildren() do
				if not v:IsA("UIListLayout") then
					local isActive = v.Name == Page_Name .. "_Control"
					local tc = tabColor
					local fs = v.Frame:FindFirstChildOfClass("UIStroke")
					if fs then tc = fs.Color end

					TweenService:Create(v.Frame.Line.PageInLine,
						TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),
						{ BackgroundTransparency = isActive and 0 or 1 }):Play()

					TweenService:Create(v.Frame,
						TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),
						{
							BackgroundColor3 = isActive and Color3.fromRGB(38, 34, 26)
								or Color3.fromRGB(30, 32, 42),
							BackgroundTransparency = isActive and 0 or 1
						}):Play()

					if fs then
						TweenService:Create(fs,
							TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),
							{ Transparency = isActive and 0.15 or 0.6 }):Play()
					end

					TweenService:Create(v.Frame.TabTitleContainer.TabTitle,
						TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]),
						{ TextColor3 = isActive and Color3.fromRGB(235, 235, 240) or Color3.fromRGB(180, 183, 194) }):Play()
				end
			end
		end)

		-- ============================================================
		-- ADD SECTION
		-- ============================================================
		local pageFunction = {}
		function pageFunction:AddSection(Section_Name, Toggleable, SectionGap, SectionColor)
			local Toggleable = Toggleable or false
			local _rowIndex = 0   -- đếm row để xen kẽ sáng/tối
			local Section = Instance.new("Frame")
			local UICorner = Instance.new("UICorner")
			local Topsec = Instance.new("Frame")
			local Sectiontitle = Instance.new("TextLabel")
			local Linesec = Instance.new("Frame")
			local UIGradient = Instance.new("UIGradient")
			local SectionList = Instance.new("UIListLayout")
			
			Section.Name = Section_Name .. "_Dot"
			Section.Parent = PageList
			Section.Size = UDim2.new(1, -5, 0, 30)
			Section.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
			Section.BackgroundTransparency = 0.05
			Section.ClipsDescendants = true

			local sectionStroke = Instance.new("UIStroke", Section)
			sectionStroke.Color = Color3.fromRGB(160, 110, 230)
			sectionStroke.Thickness = 1
			sectionStroke.Transparency = 0.5

			local sectionGradient = Instance.new("UIGradient", Section)
			sectionGradient.Color = ColorSequence.new{
				ColorSequenceKeypoint.new(0, Color3.fromRGB(22, 24, 32)),
				ColorSequenceKeypoint.new(1, Color3.fromRGB(18, 19, 26))
			}
			sectionGradient.Rotation = 90
			sectionGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.05),
				NumberSequenceKeypoint.new(1, 0.15)
			}

			UICorner.CornerRadius = UDim.new(0, 4)
			UICorner.Parent = Section

			Topsec.Name = "Topsec"
			Topsec.Parent = Section
			Topsec.BackgroundColor3 = Color3.fromRGB(170, 130, 240)
			Topsec.BackgroundTransparency = 0.0
			Topsec.Size = UDim2.new(1, 0, 0, 30)

			-- Gradient trên Topsec
			local topsecGrad = Instance.new("UIGradient", Topsec)
			topsecGrad.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(180, 140, 255)),
					ColorSequenceKeypoint.new(0.6, Color3.fromRGB(155, 115, 240)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(135, 95, 225))
				}
			topsecGrad.Rotation = 0
			topsecGrad.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 0.82),
				NumberSequenceKeypoint.new(1, 0.98)
			}

			-- Left accent bar trên header section
			local secAccentBar = Instance.new("Frame", Topsec)
			secAccentBar.Size = UDim2.new(0, 3, 0.7, 0)
			secAccentBar.Position = UDim2.new(0, 0, 0.15, 0)
			secAccentBar.BackgroundColor3 = Color3.fromRGB(100, 40, 200)
			secAccentBar.BackgroundTransparency = 0
			secAccentBar.BorderSizePixel = 0
			local secAccentCorner = Instance.new("UICorner", secAccentBar)
			secAccentCorner.CornerRadius = UDim.new(1, 0)

			Sectiontitle.Name = "Sectiontitle"
			Sectiontitle.Parent = Topsec
			Sectiontitle.BackgroundColor3 = Color3.fromRGB(170, 130, 240)
			Sectiontitle.BackgroundTransparency = 1.000
			Sectiontitle.Position = UDim2.new(0, 10, 0, 0)
			Sectiontitle.Size = UDim2.new(1, -10, 1, 0)
			Sectiontitle.Font = Enum.Font.GothamBlack
			Sectiontitle.RichText = true
			Sectiontitle.Text = "<font color=\"rgb(0,200,255)\">[</font> " .. Section_Name .. "<font color=\"rgb(0,200,255)\">]</font>"
			Sectiontitle.TextSize = 12
			Sectiontitle.TextColor3 = Color3.fromRGB(255, 255, 255)

			Linesec.Name = "Linesec"
			Linesec.Parent = Topsec
			Linesec.AnchorPoint = Vector2.new(0.5, 1)
			Linesec.BorderSizePixel = 0
			Linesec.Position = UDim2.new(0.5, 0, 1, -1)
			Linesec.Size = UDim2.new(1, -10, 0, 1)
			Linesec.BackgroundColor3 = Color3.fromRGB(120, 70, 210)
			local linesecGrad = Instance.new("UIGradient", Linesec)
			linesecGrad.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.1, 0.2),
				NumberSequenceKeypoint.new(0.9, 0.2),
				NumberSequenceKeypoint.new(1, 1)
			}

			local LineShadow = Instance.new("ImageLabel", Linesec)
			LineShadow.Name = "LineShadow"
			LineShadow.AnchorPoint = Vector2.new(0.5, 0.5)
			LineShadow.BackgroundColor3 = Color3.fromRGB(55, 58, 72)
			LineShadow.BackgroundTransparency = 1
			LineShadow.Position = UDim2.new(0.5, 0, 0.5, 0)
			LineShadow.Size = UDim2.new(1, 8, 1, 8)
			LineShadow.ZIndex = 0
			LineShadow.Image = "rbxassetid://5028857084"
			LineShadow.ImageTransparency = 0.6
			LineShadow.ScaleType = Enum.ScaleType.Slice
			LineShadow.SliceCenter = Rect.new(24, 24, 276, 276)


			UIGradient.Transparency = NumberSequence.new{
				NumberSequenceKeypoint.new(0, 1),
				NumberSequenceKeypoint.new(0.5, 0),
				NumberSequenceKeypoint.new(0.51, 0.02),
				NumberSequenceKeypoint.new(1, 1)
			}
			UIGradient.Parent = Linesec

			SectionList.Name = "SectionList"
			SectionList.Parent = Section
			SectionList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionList.Padding = UDim.new(0, 5)

			local SizeSectionY
			local sectionIsVisible = false
			if Toggleable then
				local VisibilitySectionFrame = Instance.new("Frame")
				local VisibilitySectionFrameCorner = Instance.new("UICorner")
				local visibility = Instance.new("ImageButton")
				local visibility_off = Instance.new("ImageButton")
				local VisibilityButton = Instance.new("TextButton")
				VisibilityButton.Name = "VisibilityButton"
				VisibilityButton.Parent = Topsec
				VisibilityButton.AnchorPoint = Vector2.new(1, 0.5)
				VisibilityButton.BackgroundColor3 = Color3.fromRGB(170, 130, 240)
				VisibilityButton.BackgroundTransparency = 1.000
				VisibilityButton.BorderColor3 = Color3.fromRGB(40, 80, 100)
				VisibilityButton.BorderSizePixel = 0
				VisibilityButton.Font = Enum.Font.SourceSans
				VisibilityButton.Text = ""
				VisibilityButton.TextColor3 = Color3.fromRGB(255, 255, 255)
				VisibilityButton.TextSize = 14.000
				VisibilityButton.ZIndex = 2
				VisibilityButton.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilityButton.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrame.Name = "VisibilitySectionFrame"
				VisibilitySectionFrame.Parent = Topsec
				VisibilitySectionFrame.AnchorPoint = Vector2.new(1, 0.5)
				VisibilitySectionFrame.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
				VisibilitySectionFrame.BorderColor3 = Color3.fromRGB(40, 80, 100)
				VisibilitySectionFrame.BorderSizePixel = 0
				VisibilitySectionFrame.Position = UDim2.new(1, -5, 0.5, 0)
				VisibilitySectionFrame.Size = UDim2.new(0, 20, 0, 20)
				VisibilitySectionFrameCorner.CornerRadius = UDim.new(0, 4)
				VisibilitySectionFrameCorner.Name = "VisibilitySectionFrameCorner"
				VisibilitySectionFrameCorner.Parent = VisibilitySectionFrame
				visibility.Name = "visibility"
				visibility.Parent = VisibilitySectionFrame
				visibility.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility.BackgroundTransparency = 1.000
				visibility.LayoutOrder = 4
				visibility.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility.Size = UDim2.new(1, -4, 1, -4)
				visibility.ZIndex = 2
				visibility.Image = "rbxassetid://3926307971"
				visibility.ImageRectOffset = Vector2.new(84, 44)
				visibility.ImageRectSize = Vector2.new(36, 36)
				visibility.ImageTransparency = 1
				visibility_off.Name = "visibility_off"
				visibility_off.Parent = VisibilitySectionFrame
				visibility_off.AnchorPoint = Vector2.new(0.5, 0.5)
				visibility_off.BackgroundTransparency = 1.000
				visibility_off.LayoutOrder = 4
				visibility_off.Position = UDim2.new(0.5, 0, 0.5, 0)
				visibility_off.Size = UDim2.new(1, -4, 1, -4)
				visibility_off.ZIndex = 2
				visibility_off.Image = "rbxassetid://3926307971"
				visibility_off.ImageRectOffset = Vector2.new(564, 44)
				visibility_off.ImageRectSize = Vector2.new(36, 36)
				visibility_off.ImageTransparency = 0
				VisibilityButton.MouseButton1Down:Connect(function()
					sectionIsVisible = not sectionIsVisible
					TweenService:Create(visibility, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 0 or 1
					}):Play()
					wait(getgenv().UIColor["Tween Animation 1 Speed"] / 4)
					TweenService:Create(visibility_off, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"] / 2), {
						ImageTransparency = sectionIsVisible and 1 or 0
					}):Play()
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, (sectionIsVisible and SizeSectionY or 30))
					}):Play()
				end)
			end
			if SectionGap then
				local SectionGap = Instance.new("Frame")
				SectionGap.Name = "SectionGap"
				SectionGap.Parent = PageList
				SectionGap.Size = UDim2.new(1, -5, 0, 30)
				SectionGap.ClipsDescendants = true
				SectionGap.Transparency = 1
			end

			SectionList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				if (not Toggleable) then
					Section.Size = UDim2.new(1, -5, 0, SectionList.AbsoluteContentSize.Y + 5)
				end
				SizeSectionY = SectionList.AbsoluteContentSize.Y + 5
				if sectionIsVisible then
					TweenService:Create(Section, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size =  UDim2.new(1, -5, 0, SizeSectionY)
					}):Play()
				end
			end)
			local sectionFunction = {}
						function sectionFunction:AddToggle(idk,Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description
				local Default = Setting.Default
				if Default == nil then
					Default = false
				end
				local Callback = Setting.Callback
				local ToggleFrame = Instance.new("Frame")
				local TogFrame1 = Instance.new("Frame")
				local checkbox = Instance.new("ImageLabel")
				local check = Instance.new("Frame")
				local ToggleDesc = Instance.new("TextLabel")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleBg = Instance.new("Frame")
				local ToggleCorner = Instance.new("UICorner")
				local ToggleButton = Instance.new("TextButton")
				local ToggleList = Instance.new("UIListLayout")
				
				ToggleFrame.Name = "ToggleFrame"
				ToggleFrame.Parent = Section
				ToggleFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				ToggleFrame.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					ToggleFrame.AutomaticSize = Enum.AutomaticSize.Y
					ToggleFrame.Size = UDim2.new(1, 0, 0, 0)
				else
					ToggleFrame.AutomaticSize = Enum.AutomaticSize.None
					ToggleFrame.Size = UDim2.new(1, 0, 0, 30)
				end

				TogFrame1.Name = "TogFrame1"
				TogFrame1.Parent = ToggleFrame
				TogFrame1.AnchorPoint = Vector2.new(0.5, 0.5)
				TogFrame1.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				TogFrame1.BackgroundTransparency = 1.000
				TogFrame1.Position = UDim2.new(0.5, 0, 0.5, 0)
				TogFrame1.Size = UDim2.new(1, -10, 1, 0)
				
				checkbox.Name = "checkbox"
				checkbox.Parent = TogFrame1
				checkbox.AnchorPoint = Vector2.new(1, 0.5)
				checkbox.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				checkbox.BackgroundTransparency = 1.000
				checkbox.Position = UDim2.new(1, -5, 0.5, 0)
				checkbox.Size = UDim2.new(0, 20, 0, 20)
				checkbox.Image = "rbxassetid://4552505888"
				checkbox.ImageColor3 = Color3.fromRGB(20, 140, 80)
				
				check.Name = "check"
				check.Parent = checkbox
				check.AnchorPoint = Vector2.new(0.5, 0.5)
				check.BackgroundColor3 = Color3.fromRGB(30, 160, 90) -- xanh da trời (base)
				check.Position = UDim2.new(0.5, 0, 0.5, 0)
				-- Gradient hồng nhạt -> xanh da trời khi bật
				local checkGradient = Instance.new("UIGradient")
				checkGradient.Color = ColorSequence.new({
					ColorSequenceKeypoint.new(0, Color3.fromRGB(20, 150, 85)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(40, 180, 105)),
				})
				checkGradient.Rotation = 135
				checkGradient.Parent = check
				-- Bo tròn chấm toggle
				local checkCorner = Instance.new("UICorner")
				checkCorner.CornerRadius = UDim.new(1, 0)
				checkCorner.Parent = check
				
				if Desc and Desc ~= "" then
					ToggleDesc.Name = "ToggleDesc"
					ToggleDesc.Parent = TogFrame1
					ToggleDesc.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
					ToggleDesc.BackgroundTransparency = 1.000
					ToggleDesc.Position = UDim2.new(0, 10, 0, 25)
					ToggleDesc.Size = UDim2.new(1, -50, 0, 0)
					ToggleDesc.Font = Enum.Font.Gotham
					ToggleDesc.Text = Desc
					ToggleDesc.TextSize = 12.000
					ToggleDesc.TextWrapped = true
					ToggleDesc.TextXAlignment = Enum.TextXAlignment.Left
					ToggleDesc.RichText = true
					ToggleDesc.AutomaticSize = Enum.AutomaticSize.Y
					ToggleDesc.TextColor3 = Color3.fromRGB(148, 152, 168)
					
					local pad = Instance.new("UIPadding", TogFrame1)
					pad.PaddingTop = UDim.new(0, 5)
					pad.PaddingBottom = UDim.new(0, 5)
				end
				
				ToggleTitle.Name = "TextColor"
				ToggleTitle.Parent = TogFrame1
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				ToggleTitle.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					ToggleTitle.Position = UDim2.new(0, 10, 0, 5)
					ToggleTitle.Size = UDim2.new(1, -50, 0, 20)
				else
					ToggleTitle.Position = UDim2.new(0, 10, 0, 0)
					ToggleTitle.Size = UDim2.new(1, -50, 1, 0)
				end
				
				ToggleTitle.Font = Enum.Font.GothamBlack
				ToggleTitle.Text = Title
				ToggleTitle.TextSize = 14.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left
				ToggleTitle.TextYAlignment = Enum.TextYAlignment.Center
				ToggleTitle.RichText = true
				ToggleTitle.TextColor3 = Color3.fromRGB(20, 130, 75)
				
				ToggleBg.Name = "Background1"
				ToggleBg.Parent = TogFrame1
				ToggleBg.Size = UDim2.new(1, 0, 1, 0)
				local toggleBgGrad = Instance.new("UIGradient", ToggleBg)
				toggleBgGrad.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(19, 20, 27)),
							ColorSequenceKeypoint.new(1, Color3.fromRGB(32, 35, 45))
				}
				toggleBgGrad.Rotation = 0
				ToggleBg.ZIndex = 0
				ToggleBg.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				ToggleBg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				
				ToggleCorner.CornerRadius = UDim.new(0, 10)
				ToggleCorner.Name = "ToggleCorner"
				ToggleCorner.Parent = ToggleBg
				
				ToggleButton.Name = "ToggleButton"
				ToggleButton.Parent = TogFrame1
				ToggleButton.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				ToggleButton.BackgroundTransparency = 1.000
				ToggleButton.Size = UDim2.new(1, 0, 1, 0)
				ToggleButton.Position = UDim2.new(0, 0, 0, 0)
				ToggleButton.Font = Enum.Font.SourceSans
				ToggleButton.Text = ""
				ToggleButton.TextColor3 = Color3.fromRGB(20, 130, 75)
				ToggleButton.TextSize = 14.000
				
				ToggleList.Name = "ToggleList"
				ToggleList.Parent = ToggleFrame
				ToggleList.HorizontalAlignment = Enum.HorizontalAlignment.Center
				ToggleList.SortOrder = Enum.SortOrder.LayoutOrder
				ToggleList.VerticalAlignment = Enum.VerticalAlignment.Center
				ToggleList.Padding = UDim.new(0, 5)
				
				local function ChangeStage(val)
					local csize = val and UDim2.new(0.6, 0, 0.6, 0) or UDim2.new(0, 0, 0, 0)
					local pos = val and UDim2.new(0.5, 0, 0.5, 0) or UDim2.new(0.5, 0, 0.5, 0)
					local apos = val and Vector2.new(0.5, 0.5) or Vector2.new(0.5, 0.5)
					game.TweenService:Create(check, TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
						Size = csize,
						Position = pos,
						AnchorPoint = apos
					}):Play()
				end
				
				ChangeStage(Default)
				if Default and Callback then
					Callback(Default)
				end
				
				local function ButtonClick()
					Default = not Default
					ChangeStage(Default)
					if Callback then
						pcall(Callback, Default)
					end
				end
				
				ToggleButton.MouseButton1Click:Connect(function()
    ButtonClick()
end)

				local toggleFunction = {}
				function toggleFunction.SetStage(value)
					if value ~= Default then
						ButtonClick()
					end
				end
				
				local controlData = {
					Name = Title,
					Section = Section,
					Element = ToggleFrame,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
				
				return toggleFunction
			end
			function sectionFunction:AddButton(Setting, Callback)
				local Title = Setting.Title or Setting.Text or ""
				local Desc = Setting.Desc or Setting.Description
				local Callback = Setting.Callback or Setting.Func or function() end
				
				local Button = Instance.new("Frame")
				local RowBG_1 = Instance.new("Frame")
				local UICorner_1 = Instance.new("UICorner")
				local RowHover_1 = Instance.new("Frame")
				local UICorner_2 = Instance.new("UICorner")
				local TextColor_1 = Instance.new("TextLabel")
				local TextDesc = Instance.new("TextLabel") 
				local ClickArea_1 = Instance.new("Frame")
				local UICorner_3 = Instance.new("UICorner")
				local UIGradient_1 = Instance.new("UIGradient")
				local ImageLabel_1 = Instance.new("ImageLabel")
				local Frame_1 = Instance.new("Frame")
				local UICorner_4 = Instance.new("UICorner")
				local UIScale_1 = Instance.new("UIScale")
				local Button_1 = Instance.new("TextButton")
				
				Button.Name = "Button"
				Button.Parent = Section
				Button.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				Button.BackgroundTransparency = 1
				
				if Desc and Desc ~= "" then
					Button.AutomaticSize = Enum.AutomaticSize.Y
					Button.Size = UDim2.new(1, 0, 0, 0)
				else
					Button.AutomaticSize = Enum.AutomaticSize.None
						Button.Size = UDim2.new(1, 0, 0, 30)
				end
				
				RowBG_1.Name = "RowBG"
				RowBG_1.Parent = Button
				RowBG_1.AnchorPoint = Vector2.new(0.5, 0.5)
				RowBG_1.BackgroundColor3 = Color3.fromRGB(218, 208, 255)
				RowBG_1.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				RowBG_1.Position = UDim2.new(0.5, 0, 0.5, 0)
				RowBG_1.Size = UDim2.new(1, -10, 1, 0)
				
				UICorner_1.Parent = RowBG_1
				UICorner_1.CornerRadius = UDim.new(0,10)
				
				RowHover_1.Name = "RowHover"
				RowHover_1.Parent = RowBG_1
				RowHover_1.BackgroundColor3 = Color3.fromRGB(205, 195, 250)
				RowHover_1.BackgroundTransparency = 1
				RowHover_1.Size = UDim2.new(1, 0, 1, 0)
				RowHover_1.ZIndex = 2
				
				UICorner_2.Parent = RowHover_1
				UICorner_2.CornerRadius = UDim.new(0,10)
				
				TextColor_1.Name = "TextColor"
				TextColor_1.Parent = RowBG_1
				TextColor_1.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				TextColor_1.BackgroundTransparency = 1
				
				if Desc and Desc ~= "" then
					TextColor_1.Position = UDim2.new(0, 12, 0, 5)
					TextColor_1.Size = UDim2.new(1, -110, 0, 20)
				else
					TextColor_1.Position = UDim2.new(0, 12, 0, 0)
					TextColor_1.Size = UDim2.new(1, -110, 1, 0)
				end
				
				TextColor_1.Font = Enum.Font.GothamBold
				TextColor_1.Text = Title
				TextColor_1.TextColor3 = Color3.fromRGB(224, 182, 112)
				TextColor_1.TextSize = 14
				TextColor_1.TextStrokeTransparency = 0.85
				TextColor_1.TextXAlignment = Enum.TextXAlignment.Left
				
				if Desc and Desc ~= "" then
					TextDesc.Name = "Description"
					TextDesc.Parent = RowBG_1
					TextDesc.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
					TextDesc.BackgroundTransparency = 1
					TextDesc.Position = UDim2.new(0, 12, 0, 22)
					TextDesc.Size = UDim2.new(1, -110, 0, 0)
					TextDesc.AutomaticSize = Enum.AutomaticSize.Y
					TextDesc.Font = Enum.Font.Gotham
					TextDesc.Text = Desc
					TextDesc.TextColor3 = Color3.fromRGB(148, 152, 168)
					TextDesc.TextSize = 12
					TextDesc.TextWrapped = true
					TextDesc.TextXAlignment = Enum.TextXAlignment.Left
					
					local pad = Instance.new("UIPadding", RowBG_1)
					pad.PaddingTop = UDim.new(0, 5)
					pad.PaddingBottom = UDim.new(0, 5)
				end
				
				ClickArea_1.Name = "ClickArea"
				ClickArea_1.Parent = RowBG_1
				ClickArea_1.AnchorPoint = Vector2.new(1, 0.5)
				ClickArea_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ClickArea_1.Position = UDim2.new(1, -8, 0.5, 0)
				ClickArea_1.Size = UDim2.new(0, 94, 0, 30)
				ClickArea_1.ClipsDescendants = true
				
				UICorner_3.Parent = ClickArea_1
				UICorner_3.CornerRadius = UDim.new(0,12)
				
				UIGradient_1.Parent = ClickArea_1
				UIGradient_1.Color = ColorSequence.new{
					ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 255, 255)),
					ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 240, 255)),
					ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 180, 210)),
					ColorSequenceKeypoint.new(1, Color3.fromRGB(0, 210, 230))
				}
				UIGradient_1.Rotation = 90
				
				ImageLabel_1.Parent = ClickArea_1
				ImageLabel_1.AnchorPoint = Vector2.new(0.5, 0.5)
				ImageLabel_1.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				ImageLabel_1.BackgroundTransparency = 1
				ImageLabel_1.Position = UDim2.new(0.5, 0, 0.5, 0)
				ImageLabel_1.Size = UDim2.new(1, 14, 1, 14)
				ImageLabel_1.ZIndex = 0
				ImageLabel_1.Image = "rbxassetid://5028857084"
				ImageLabel_1.ImageTransparency = 0.7
				ImageLabel_1.ScaleType = Enum.ScaleType.Slice
				ImageLabel_1.SliceCenter = Rect.new(24, 24, 276, 276)
				
				Frame_1.Parent = ClickArea_1
				Frame_1.AnchorPoint = Vector2.new(0.5, 0)
				Frame_1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Frame_1.BackgroundTransparency = 0.8
				Frame_1.Position = UDim2.new(0.5, 0, 0, 2)
				Frame_1.Size = UDim2.new(1, -6, 0, 10)
				Frame_1.ZIndex = 2
				
				UICorner_4.Parent = Frame_1
				UICorner_4.CornerRadius = UDim.new(0,10)
				
				UIScale_1.Parent = ClickArea_1
				
				Button_1.Name = "Button"
				Button_1.Parent = ClickArea_1
				Button_1.Active = true
				Button_1.AutoButtonColor = false
				Button_1.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				Button_1.BackgroundTransparency = 1
				Button_1.Size = UDim2.new(1, 0, 1, 0)
				Button_1.Font = Enum.Font.GothamBold
				Button_1.Text = "Click"
				Button_1.TextColor3 = Color3.fromRGB(224, 182, 112)
				Button_1.TextSize = 13
				
				local scaleHover = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1.05 })
				local scaleNormal = TweenService:Create(UIScale_1, TweenInfo.new(0.12, Enum.EasingStyle.Sine), { Scale = 1 })
				
				Button_1.MouseEnter:Connect(function() scaleHover:Play() end)
				Button_1.MouseLeave:Connect(function() scaleNormal:Play() end)
				
				Button_1.MouseButton1Down:Connect(function()
					local ripple = Instance.new("Frame")
					ripple.AnchorPoint = Vector2.new(0.5, 0.5)
					ripple.Position = UDim2.new(0.5, 0, 0.5, 0)
					ripple.Size = UDim2.new(0, 0, 0, 0)
					ripple.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ripple.BackgroundTransparency = 0.6
					ripple.ZIndex = 20
					ripple.Parent = ClickArea_1
					
					local rippleCorner = Instance.new("UICorner")
					rippleCorner.CornerRadius = UICorner_3.CornerRadius
					rippleCorner.Parent = ripple
					
					local rippleTween = TweenService:Create(ripple, TweenInfo.new(0.35, Enum.EasingStyle.Quad, Enum.EasingDirection.Out), {
						Size = UDim2.new(1, 0, 1, 0),
						BackgroundTransparency = 1,
						Position = UDim2.new(0.5, 0, 0.5, 0)
					})
					rippleTween:Play()
					rippleTween.Completed:Connect(function() ripple:Destroy() end)
					
					Callback()
				end)
				
				local f = {}
				function f:SetTitle(vl) TextColor_1.Text = vl end
				
				local controlData = {
					Name = Title,
					Section = Section,
					Element = Button,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
				return f
			end
        
			function sectionFunction:AddLabel(text)
				local Title = text
                local LabelFrame = Instance.new("Frame")
                local LabelBG = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local TextColor = Instance.new("TextLabel")
                
                LabelFrame.Name = "LabelFrame"
                LabelFrame.Parent = Section
                LabelFrame.AutomaticSize = Enum.AutomaticSize.Y
                LabelFrame.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
                LabelFrame.BackgroundTransparency = 1
                LabelFrame.Size = UDim2.new(1, 0,0, 0)
                
                LabelBG.Name = "LabelBG"
                LabelBG.Parent = LabelFrame
                LabelBG.AnchorPoint = Vector2.new(0.5, 0)
                LabelBG.AutomaticSize = Enum.AutomaticSize.Y
                LabelBG.BackgroundColor3 = Color3.fromRGB(34, 37, 50)
                LabelBG.BackgroundTransparency = 0.25
                LabelBG.Position = UDim2.new(0.5, 0,0, 0)
                LabelBG.Size = UDim2.new(1, -10,0, -10)
                
                UICorner.Parent = LabelBG
                UICorner.CornerRadius = UDim.new(0,6)
                
                
                TextColor.Name = "TextColor"
                TextColor.Parent = LabelBG
                TextColor.AutomaticSize = Enum.AutomaticSize.Y
                TextColor.BackgroundColor3 = Color3.fromRGB(24, 26, 34)
                TextColor.BackgroundTransparency = 1
                TextColor.Position = UDim2.new(0, 12,0, 6)
                TextColor.Size = UDim2.new(1, -24,1, -12)
                TextColor.Font = Enum.Font.GothamMedium
                TextColor.Text = Title
                TextColor.TextColor3 = Color3.fromRGB(190, 195, 212)
                TextColor.TextSize = 14
                TextColor.TextStrokeTransparency = 0.8500000238418579
                TextColor.TextWrapped = true
                TextColor.TextXAlignment = Enum.TextXAlignment.Left
				local labelFunction = {}
				function labelFunction:SetText(text)
					TextColor.Text = text
				end
				function labelFunction.SetColor(color)
					TextColor.TextColor3 = color
				end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = LabelFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return labelFunction
			end
            function sectionFunction:AddDropdownSection(Setting)
                local Title = tostring(Setting.Text or Setting.Title or "")
                local Search = Setting.Search or false
              
                local DropdownFrame = Instance.new("Frame")
                local Dropdownbg = Instance.new("Frame")
                local Dropdowncorner = Instance.new("UICorner")
                local Topdrop = Instance.new("Frame")
                local UICorner = Instance.new("UICorner")
                local ImgDrop = Instance.new("ImageLabel")
                local DropdownButton = Instance.new("TextButton")
                local Dropdownlisttt = Instance.new("Frame")
                local DropdownScroll = Instance.new("ScrollingFrame")
                local ScrollContainer = Instance.new("Frame")
                local ScrollContainerList = Instance.new("UIListLayout")
                
                DropdownFrame.Name = Title .. "DropdownSectionFrame"
                DropdownFrame.Parent = Section
                DropdownFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
                DropdownFrame.BackgroundTransparency = 1.000
                DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
                DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
                
                Dropdownbg.Name = "Background1"
                Dropdownbg.Parent = DropdownFrame
                Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
                Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
                Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
                Dropdownbg.ClipsDescendants = true
                Dropdownbg.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
                Dropdownbg.BackgroundTransparency = 0.25
                
                Dropdowncorner.CornerRadius = UDim.new(0, 4)
                Dropdowncorner.Name = "Dropdowncorner"
                Dropdowncorner.Parent = Dropdownbg
                
                Topdrop.Name = "Background2"
                Topdrop.Parent = Dropdownbg
                Topdrop.Size = UDim2.new(1, 0, 0, 25)
                Topdrop.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
                Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
                
                UICorner.CornerRadius = UDim.new(0, 4)
                UICorner.Parent = Topdrop
                
                local Dropdowntitle
                if Search then
                    Dropdowntitle = Instance.new("TextBox")
                    Dropdowntitle.PlaceholderText = Title
                    Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
                else
                    Dropdowntitle = Instance.new("TextLabel")
                    Dropdowntitle.Text = Title
                end
                
                Dropdowntitle.Name = "TextColorPlaceholder"
                Dropdowntitle.Parent = Topdrop
                Dropdowntitle.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
                Dropdowntitle.BackgroundTransparency = 1.000
                Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
                Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
                Dropdowntitle.Font = Enum.Font.GothamBlack
                Dropdowntitle.TextSize = 14.000
                Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
                Dropdowntitle.ClipsDescendants = true
                Dropdowntitle.TextColor3 = Color3.fromRGB(180, 30, 100)
                
                ImgDrop.Name = "ImgDrop"
                ImgDrop.Parent = Topdrop
                ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
                ImgDrop.BackgroundTransparency = 1.000
                ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
                ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
                ImgDrop.Size = UDim2.new(0, 15, 0, 15)
                ImgDrop.Image = "rbxassetid://6954383209"
                ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
                
                DropdownButton.Name = "DropdownButton"
                DropdownButton.Parent = Topdrop
                DropdownButton.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
                DropdownButton.BackgroundTransparency = 1.000
                DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
                DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
                DropdownButton.Font = Enum.Font.GothamBold
                DropdownButton.Text = ""
                DropdownButton.TextColor3 = Color3.fromRGB(180, 30, 100)
                DropdownButton.TextSize = 14.000
                
                Dropdownlisttt.Name = "Dropdownlisttt"
                Dropdownlisttt.Parent = Dropdownbg
                Dropdownlisttt.BackgroundTransparency = 1.000
                Dropdownlisttt.BorderSizePixel = 0
                Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
                Dropdownlisttt.Size = UDim2.new(1, 0, 0, 0)
                Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
                
                DropdownScroll.Name = "DropdownScroll"
                DropdownScroll.Parent = Dropdownlisttt
                DropdownScroll.Active = true
                DropdownScroll.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
                DropdownScroll.BackgroundTransparency = 1.000
                DropdownScroll.BorderSizePixel = 0
                DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
                DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
                DropdownScroll.ScrollBarThickness = 5
                DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
                DropdownScroll.ScrollingEnabled = true
                DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
                
                ScrollContainer.Name = "ScrollContainer"
                ScrollContainer.Parent = DropdownScroll
                ScrollContainer.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
                ScrollContainer.BackgroundTransparency = 1.000
                ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
                ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
                
                ScrollContainerList.Name = "ScrollContainerList"
                ScrollContainerList.Parent = ScrollContainer
                ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
                ScrollContainerList.Padding = UDim.new(0, 5)
                
                local InternalSection = Instance.new("Frame")
                InternalSection.Name = "InternalSection"
                InternalSection.Parent = ScrollContainer
                InternalSection.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
                InternalSection.BackgroundTransparency = 1.000
                InternalSection.Size = UDim2.new(1, 0, 0, 0)
                InternalSection.AutomaticSize = Enum.AutomaticSize.Y
                
                local InternalList = Instance.new("UIListLayout")
                InternalList.Name = "InternalList"
                InternalList.Parent = InternalSection
                InternalList.SortOrder = Enum.SortOrder.LayoutOrder
                InternalList.Padding = UDim.new(0, 5)
                
                local isOpen = false
                
                DropdownButton.MouseButton1Click:Connect(function()
                    isOpen = not isOpen
                    
                    local listsize = isOpen and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, 230) or UDim2.new(1, 0, 0, 25)
                    local DropCRotation = isOpen and 90 or 0
                    
                    TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = listsize
                    }):Play()
                    TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Size = mainsize
                    }):Play()
                    TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                        Rotation = DropCRotation
                    }):Play()
                end)
                
                ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
                end)
                
                InternalList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
                    local contentHeight = math.min(InternalList.AbsoluteContentSize.Y + 10, 300)
                    local listsize = isOpen and UDim2.new(1, 0, 0, contentHeight) or UDim2.new(1, 0, 0, 0)
                    local mainsize = isOpen and UDim2.new(1, 0, 0, contentHeight + 25) or UDim2.new(1, 0, 0, 25)
                    
                    if isOpen then
                        TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = listsize
                        }):Play()
                        TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            Size = mainsize
                        }):Play()
                    end
                end)
                
               local dropdownSectionFunction = {}
                
                function dropdownSectionFunction:AddSlider(Setting)
                    local TitleText = tostring(Setting.Text or Setting.Title) or ""
                    local minValue = tonumber(Setting.Min) or 0
                    local maxValue = tonumber(Setting.Max) or 100
                    local Precise = Setting.Precise or false
                    local DefaultValue = tonumber(Setting.Default) or 0
                    local Callback = Setting.Callback
                    local Rounding = Setting.Rouding or Setting.Rounding
                    
                    local SliderFrame = Instance.new("Frame")
                    local SliderCorner = Instance.new("UICorner")
                    local SliderBG = Instance.new("Frame")
                    local SliderBGCorner = Instance.new("UICorner")
                    local SliderTitle = Instance.new("TextLabel")
                    local SliderBar = Instance.new("Frame")
                    local SliderButton = Instance.new("TextButton")
                    local SliderBarCorner = Instance.new("UICorner")
                    local Bar = Instance.new("Frame")
                    local BarCorner = Instance.new("UICorner")
                    local Sliderboxframe = Instance.new("Frame")
                    local Sliderbox = Instance.new("UICorner")
                    local Sliderbox_2 = Instance.new("TextBox")
                    
                    SliderFrame.Name = TitleText
                    SliderFrame.Parent = InternalSection
                    SliderFrame.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
                    SliderFrame.BackgroundTransparency = 1.000
                    SliderFrame.Size = UDim2.new(1, 0, 0, 50) 
                    
                    SliderCorner.CornerRadius = UDim.new(0, 4)
                    SliderCorner.Name = "SliderCorner"
                    SliderCorner.Parent = SliderFrame
                    
                    SliderBG.Name = "Background1"
                    SliderBG.Parent = SliderFrame
                    SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
                    SliderBG.Size = UDim2.new(1, -5, 1, 0) 
                    SliderBG.BackgroundColor3 = Color3.fromRGB(34, 37, 50)
                    SliderBG.BackgroundTransparency = 0.25
                    
                    SliderBGCorner.CornerRadius = UDim.new(0, 4)
                    SliderBGCorner.Name = "SliderBGCorner"
                    SliderBGCorner.Parent = SliderBG
                    
                    SliderTitle.Name = "TextColor"
                    SliderTitle.Parent = SliderBG
                    SliderTitle.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
                    SliderTitle.BackgroundTransparency = 1.000
                    SliderTitle.Position = UDim2.new(0, 10, 0, 0)
                    SliderTitle.Size = UDim2.new(0.65, -10, 0, 25) 
                    SliderTitle.Font = Enum.Font.GothamBlack
                    SliderTitle.Text = TitleText
                    SliderTitle.TextSize = 14.000
                    SliderTitle.RichText = true
                    SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
                    SliderTitle.TextColor3 = Color3.fromRGB(224, 182, 112)
                    
                    SliderBar.Name = "SliderBar"
                    SliderBar.Parent = SliderFrame
                    SliderBar.AnchorPoint = Vector2.new(0.5, 0.5)
                    SliderBar.Position = UDim2.new(0.5, 0, 0.5, 14)
                    SliderBar.Size = UDim2.new(0.9, 0, 0, 6) 
                    SliderBar.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
                    
                    SliderButton.Name = "SliderButton"
                    SliderButton.Parent = SliderBar
                    SliderButton.BackgroundColor3 = Color3.fromRGB(50, 54, 70)
                    SliderButton.BackgroundTransparency = 1.000
                    SliderButton.Size = UDim2.new(1, 0, 1, 0)
                    SliderButton.Font = Enum.Font.GothamBold
                    SliderButton.Text = ""
                    SliderButton.TextColor3 = Color3.fromRGB(205, 200, 220)
                    SliderButton.TextSize = 14.000
                    
                    SliderBarCorner.CornerRadius = UDim.new(1, 0)
                    SliderBarCorner.Name = "SliderBarCorner"
                    SliderBarCorner.Parent = SliderBar
                    
                    Bar.Name = "Bar"
                    Bar.BorderSizePixel = 0
                    Bar.Parent = SliderBar
                    Bar.Size = UDim2.new(0, 0, 1, 0)
                    Bar.BackgroundColor3 = Color3.fromRGB(55, 58, 72)
                    
                    BarCorner.CornerRadius = UDim.new(1, 0)
                    BarCorner.Name = "BarCorner"
                    BarCorner.Parent = Bar
                    
                    Sliderboxframe.Name = "Background2"
                    Sliderboxframe.Parent = SliderFrame
                    Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
                    Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
                    Sliderboxframe.Size = UDim2.new(0.25, 0, 0, 25) 
                    Sliderboxframe.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
                    
                    Sliderbox.CornerRadius = UDim.new(0, 4)
                    Sliderbox.Name = "Sliderbox"
                    Sliderbox.Parent = Sliderboxframe
                    
                    Sliderbox_2.Name = "TextColor"
                    Sliderbox_2.Parent = Sliderboxframe
                    Sliderbox_2.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
                    Sliderbox_2.BackgroundTransparency = 1.000
                    Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
                    Sliderbox_2.Font = Enum.Font.GothamBold
                    Sliderbox_2.Text = ""
                    Sliderbox_2.TextSize = 14.000
                    Sliderbox_2.TextColor3 = Color3.fromRGB(205, 200, 220)
                    
                    SliderButton.MouseEnter:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = Color3.fromRGB(224, 182, 112)
                        }):Play()
                    end)
                    
                    SliderButton.MouseLeave:Connect(function()
                        TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
                            BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
                        }):Play()
                    end)
                    
                    local callBackAndSetText = function(val)
                        Sliderbox_2.Text = tostring(val)
                        Callback(tonumber(val))
                    end
                    if DefaultValue then
                        if DefaultValue <= minValue then
                            DefaultValue = minValue
                        elseif DefaultValue >= maxValue then
                            DefaultValue = maxValue
                        end
                        Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
                        Sliderbox_2.Text = tostring(DefaultValue)
                    end
                    
                    
                    local dragging = false
                    local dragInput
                    local holdTime = 0
                    local holdStarted = 0
                    
                    local function onInputBegan(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            holdStarted = tick()
                            
                            input.Changed:Connect(function()
                                if input.UserInputState == Enum.UserInputState.End then
                                    dragging = false
                                    holdStarted = 0
                                end
                            end)
                        end
                    end
                    
                    local function onInputEnded(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
                            dragging = false
                            holdStarted = 0
                        end
                    end
                    
                    local function onInputChanged(input)
                        if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
                            dragInput = input
                        end
                    end
                    
                    SliderButton.InputBegan:Connect(onInputBegan)
                    SliderButton.InputEnded:Connect(onInputEnded)
                    SliderButton.InputChanged:Connect(onInputChanged)
                    
                    RunService.RenderStepped:Connect(function()
                        if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
                            dragging = true
                        end
                        
                        if dragging and dragInput then
                            local barWidth = math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SliderBar.AbsoluteSize.X)
                            local percentage = barWidth / SliderBar.AbsoluteSize.X
                            local value = minValue + (maxValue - minValue) * percentage
                            
                            if Rounding then
                                value = tonumber(string.format("%.".. Rounding .."f", value))
                            elseif not Precise then
                                value = math.floor(value)
                            end
                            
                            value = math.clamp(value, minValue, maxValue)
                            
                            pcall(function()
                                callBackAndSetText(value)
                            end)
                            Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        end
                    end)
                    
                    local function GetSliderValue(Value)
                        Value = tonumber(Value) or minValue
                        Value = math.clamp(Value, minValue, maxValue)
                        
                        if Rounding then
                            Value = tonumber(string.format("%.".. Rounding .."f", Value))
                        elseif not Precise then
                            Value = math.floor(Value)
                        end
                        
                        local percentage = (Value - minValue) / (maxValue - minValue)
                        Bar.Size = UDim2.new(percentage, 0, 1, 0)
                        callBackAndSetText(Value)
                    end
                    
                    Sliderbox_2.FocusLost:Connect(function()
                        GetSliderValue(Sliderbox_2.Text)
                    end)
                    
                    local slider_function = {}
                    function slider_function.SetValue(Value)
                        GetSliderValue(Value)
                    end
                    
                    function slider_function.GetValue()
                        return tonumber(Sliderbox_2.Text) or minValue
                    end
                    
                    return slider_function
                end
                
                function dropdownSectionFunction:SetOpen(state)
                    if state ~= isOpen then
                        DropdownButton.MouseButton1Click:Fire()
                    end
                end
                
                function dropdownSectionFunction:GetOpen()
                    return isOpen
                end
                
                function dropdownSectionFunction:SetTitle(newTitle)
                    if Search then
                        Dropdowntitle.PlaceholderText = newTitle
                    else
                        Dropdowntitle.Text = newTitle
                    end
                end
                
                local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownSectionFunction
            end
            
						function sectionFunction:AddDropdown(idk, Setting)
				local Title = tostring(Setting.Text or Setting.Title) or ""
				local List = Setting.Values
				local Search = Setting.Search or false
				local Selected = Setting.Selected or Setting.Multi or false
				local Slider = Setting.Slider or false
				local SliderRelease = Setting.SliderRelease or false
				local Default = (function ()
                    if Setting.Default then
                        if type(Setting.Default) == "number" then
                            return List[Setting.Default]
                        elseif type(Setting.Default) == "string" then
                            return Setting.Default
                        end
                    end
                    return nil
                end)()
				local Callback = Setting.Callback
				local pairs = Setting.SortPairs or pairs
				local DropdownFrame = Instance.new("Frame")
				local Dropdownbg = Instance.new("Frame")
				local Dropdowncorner = Instance.new("UICorner")
				local Topdrop = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				local ImgDrop = Instance.new("ImageLabel")
				local DropdownButton = Instance.new("TextButton")
				local Dropdownlisttt = Instance.new("Frame")
				local DropdownScroll = Instance.new("ScrollingFrame")
				local ScrollContainer = Instance.new("Frame")
				local ScrollContainerList = Instance.new("UIListLayout")
				local dropdownLeave = false
				local Dropdowntitle;
				if Search then
					Dropdowntitle = Instance.new("TextBox")
				else
					Dropdowntitle = Instance.new("TextLabel")
				end
				DropdownFrame.Name = Title .. "DropdownFrame"
				DropdownFrame.Parent = Section
				DropdownFrame.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				DropdownFrame.BackgroundTransparency = 1.000
				DropdownFrame.Position = UDim2.new(0, 0, 0.473684222, 0)
				DropdownFrame.Size = UDim2.new(1, 0, 0, 25)
				Dropdownbg.Name = "Background1"
				Dropdownbg.Parent = DropdownFrame
				Dropdownbg.AnchorPoint = Vector2.new(0.5, 0.5)
				Dropdownbg.Position = UDim2.new(0.5, 0, 0.5, 0)
				Dropdownbg.Size = UDim2.new(1, -10, 1, 0)
				Dropdownbg.ClipsDescendants = true
				Dropdownbg.BackgroundColor3 = Color3.fromRGB(30, 32, 42)
				Dropdownbg.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				Dropdowncorner.CornerRadius = UDim.new(0, 4)
				Dropdowncorner.Name = "Dropdowncorner"
				Dropdowncorner.Parent = Dropdownbg
				Topdrop.Name = "Background2"
				Topdrop.Parent = Dropdownbg
				Topdrop.Size = UDim2.new(1, 0, 0, 25)
				Topdrop.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
				Topdrop.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = Topdrop
				Dropdowntitle.Name = "TextColorPlaceholder"
				Dropdowntitle.Parent = Topdrop
				Dropdowntitle.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				Dropdowntitle.BackgroundTransparency = 1.000
				Dropdowntitle.Position = UDim2.new(0, 10, 0, 0)
				Dropdowntitle.Size = UDim2.new(1, -40, 1, 0)
				Dropdowntitle.Font = Enum.Font.GothamBlack
				Dropdowntitle.Text = ''
				Dropdowntitle.TextSize = 14.000
				Dropdowntitle.TextXAlignment = Enum.TextXAlignment.Left
				Dropdowntitle.ClipsDescendants = true
				local Sel = Instance.new("StringValue", Dropdowntitle)
				Sel.Value = ""
				if Default and table.find(List, Default) then
					Sel.Value = Default
				end
				if not Selected then
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
					if Default and Callback then
						task.spawn(function()
							pcall(Callback, Default)
						end)
					end
				else
					if Search then
						Dropdowntitle.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
					if Default and Callback then
						task.spawn(function()
							pcall(Callback, Default)
						end)
					end
				end
				Dropdowntitle.TextColor3 = Color3.fromRGB(180, 30, 100)
				ImgDrop.Name = "ImgDrop"
				ImgDrop.Parent = Topdrop
				ImgDrop.AnchorPoint = Vector2.new(1, 0.5)
				ImgDrop.BackgroundTransparency = 1.000
				ImgDrop.BorderColor3 = Color3.fromRGB(27, 42, 53)
				ImgDrop.Position = UDim2.new(1, -6, 0.5, 0)
				ImgDrop.Size = UDim2.new(0, 15, 0, 15)
				ImgDrop.Image = "rbxassetid://6954383209"
				ImgDrop.ImageColor3 = getgenv().UIColor["Dropdown Icon Color"]
				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = Topdrop
				DropdownButton.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				DropdownButton.BackgroundTransparency = 1.000
				DropdownButton.Size = Search and UDim2.new(0, 30, 0, 30) or UDim2.new(1, 0, 1 , 0)
				DropdownButton.Position = Search and UDim2.new(1, -35, 0, 0) or UDim2.new(0 , 0 , 0 , 0)
				DropdownButton.Font = Enum.Font.GothamBold
				DropdownButton.Text = ""
				DropdownButton.TextColor3 = Color3.fromRGB(180, 30, 100)
				DropdownButton.TextSize = 14.000
				Dropdownlisttt.Name = "Dropdownlisttt"
				Dropdownlisttt.Parent = Dropdownbg
				Dropdownlisttt.BackgroundTransparency = 1.000
				Dropdownlisttt.BorderSizePixel = 0
				Dropdownlisttt.Position = UDim2.new(0, 0, 0, 25)
				Dropdownlisttt.Size = UDim2.new(1, 0, 0, 25)
				Dropdownlisttt.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				DropdownScroll.Name = "DropdownScroll"
				DropdownScroll.Parent = Dropdownlisttt
				DropdownScroll.Active = true
				DropdownScroll.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				DropdownScroll.BackgroundTransparency = 1.000
				DropdownScroll.BorderSizePixel = 0
				DropdownScroll.Size = UDim2.new(1, 0, 1, 0)
				DropdownScroll.BottomImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 0)
				DropdownScroll.ScrollBarThickness = 5
				DropdownScroll.TopImage = "rbxasset://textures/ui/Scroll/scroll-middle.png"
				DropdownScroll.ScrollingEnabled = true
				DropdownScroll.VerticalScrollBarInset = Enum.ScrollBarInset.Always
				ScrollContainer.Name = "ScrollContainer"
				ScrollContainer.Parent = DropdownScroll
				ScrollContainer.BackgroundColor3 = Color3.fromRGB(26, 28, 37)
				ScrollContainer.BackgroundTransparency = 1.000
				ScrollContainer.Position = UDim2.new(0, 5, 0, 5)
				ScrollContainer.Size = UDim2.new(1, -15, 1, -5)
				ScrollContainerList.Name = "ScrollContainerList"
				ScrollContainerList.Parent = ScrollContainer
				ScrollContainerList.SortOrder = Enum.SortOrder.LayoutOrder
				ScrollContainerList.Padding = UDim.new(0, 5)
				ScrollContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
					DropdownScroll.CanvasSize = UDim2.new(0, 0, 0, 10 + ScrollContainerList.AbsoluteContentSize.Y + 5)
				end)
				local isbusy = false
				local found = {}
				local searchtable = {}
				local function edit()
					for i in pairs(found) do
						found[i] = nil
					end
					for h, l in pairs(ScrollContainer:GetChildren()) do
						if not l:IsA("UIListLayout") and not l:IsA("UIPadding") and not l:IsA('UIGridLayout') then
							l.Visible = false
						end
					end
					Dropdowntitle.Text = string.lower(Dropdowntitle.Text)
				end
				local function SearchDropdown()
					local Results = {}
					for i, v in pairs(searchtable) do
						if string.find(v, Dropdowntitle.Text) then
							table.insert(found, v)
						end
					end
					for a, b in pairs(ScrollContainer:GetChildren()) do
						for c, d in pairs(found) do
							if d == b.Name then
								b.Visible = true
							end
						end
					end
				end
				local function clear_object_in_list()
					for i, v in next, ScrollContainer:GetChildren() do
						if v:IsA('Frame') then
							v:Destroy()
						end
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
                    if Default and Callback then
                        task.spawn(function() Callback(Default, true) end)
                    end
                else
                    ListNew = List
                end
				local function refreshlist(SortPairs)
					pairs = SortPairs or pairs
					clear_object_in_list()
					searchtable = {}
					for i, v in pairs(ListNew) do
						if Selected then
							table.insert(searchtable, string.lower(i))
						elseif Slider then
							table.insert(searchtable, string.lower(v['Title']))
						else
							table.insert(searchtable, string.lower(v))
						end
					end
					if Selected then
                        for _, i in ipairs(OrderedList) do
                            local v = ListNew[i]
							local SampleItem = Instance.new("Frame")
							local SampleItemCorner = Instance.new("UICorner")
							local SampleItemBG = Instance.new("Frame")
							local SampleItemBGCorner = Instance.new("UICorner")
							local SampleItemTitle = Instance.new("TextLabel")
							local SampleItemCheck = Instance.new("ImageButton")
							local SampleItemButton = Instance.new("TextButton")
							SampleItem.Name = string.lower(i)
							SampleItem.Parent = ScrollContainer
							SampleItem.BackgroundColor3 = Color3.fromRGB(34, 37, 50)
							SampleItem.BackgroundTransparency = 1.000
							SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItem.LayoutOrder = 1
							SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
							SampleItem.Size = UDim2.new(1, 0, 0, 25)
							SampleItemCorner.CornerRadius = UDim.new(0, 4)
							SampleItemCorner.Name = "SampleItemCorner"
							SampleItemCorner.Parent = SampleItem
							SampleItemBG.Name = "SampleItemBG"
							SampleItemBG.Parent = SampleItem
							SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SampleItemBG.BackgroundColor3 = v and Color3.fromRGB(30, 160, 90) or Color3.fromRGB(55, 58, 72)
							SampleItemBG.BackgroundTransparency = v and .5 or 1
							SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
							SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
							SampleItemBGCorner.Name = "SampleItemBGCorner"
							SampleItemBGCorner.Parent = SampleItemBG
							SampleItemTitle.Name = "SampleItemTitle"
							SampleItemTitle.Parent = SampleItemBG
							SampleItemTitle.BackgroundColor3 = Color3.fromRGB(34, 37, 50)
							SampleItemTitle.BackgroundTransparency = 1.000
							SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
							SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
							SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
							SampleItemTitle.Font = Enum.Font.GothamBlack
							SampleItemTitle.Text = tostring(i)
							SampleItemTitle.TextColor3 = Color3.fromRGB(255, 210, 80)
							SampleItemTitle.TextSize = 14.000
							SampleItemTitle.TextStrokeTransparency = 0.500
							SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
							SampleItemCheck.Name = "SampleItemCheck"
							SampleItemCheck.Parent = SampleItemBG
							SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
							SampleItemCheck.BackgroundTransparency = 1.000
							SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
							SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
							SampleItemCheck.ZIndex = 2
							SampleItemCheck.Image = "rbxassetid://3926305904"
							SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
							SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
							SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
							SampleItemCheck.ImageTransparency = v and 0 or 1
							SampleItemButton.Name = "SampleItemButton"
							SampleItemButton.Parent = SampleItem
							SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
							SampleItemButton.BackgroundTransparency = 1.000
							SampleItemButton.BorderColor3 = Color3.fromRGB(40, 80, 100)
							SampleItemButton.BorderSizePixel = 0
							SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
							SampleItemButton.Font = Enum.Font.SourceSans
							SampleItemButton.TextColor3 = Color3.fromRGB(222, 222, 230)
							SampleItemButton.TextSize = 14.000
							SampleItemButton.TextTransparency = 1.000
							SampleItemButton.MouseEnter:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = .7
								}
										):Play()
							end)
							SampleItemButton.MouseLeave:Connect(function()
								if v then
									return
								end
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = 1
								}
										):Play()
							end)
							SampleItemButton.MouseButton1Click:Connect(function()
								v = not v
								TweenService:Create(
											SampleItemCheck,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									ImageTransparency = v and 0 or 1
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundColor3 = v and UIColor["Dropdown Selected Check Color"] or Color3.fromRGB(255, 255, 255)
								}
										):Play()
								TweenService:Create(
											SampleItemBG,
											TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
									BackgroundTransparency = v and .5 or 1
								}
										):Play()
								if Callback then
									Callback(i, v)
									ListNew[i] = v
								end
								if Search then
									Dropdowntitle.PlaceholderText = Title .. ': '
								else
									Dropdowntitle.Text = Title .. ': '
								end
							end)
						end
					elseif Slider then
						for i, v in pairs(ListNew) do
							local TitleText = tostring(v.Title) or ""
							local minValue = tonumber(v.Min) or 0
							local maxValue = tonumber(v.Max) or 100
							local Precise = v.Precise or false
							local DefaultValue = tonumber(v.Default) or minValue
							local SizeChia = 365;
							local SliderFrame = Instance.new("Frame")
							local SliderCorner = Instance.new("UICorner")
							local SliderBG = Instance.new("Frame")
							local SliderBGCorner = Instance.new("UICorner")
							local SliderTitle = Instance.new("TextLabel")
							local SliderBar = Instance.new("Frame")
							local SliderButton = Instance.new("TextButton")
							local SliderBarCorner = Instance.new("UICorner")
							local Bar = Instance.new("Frame")
							local BarCorner = Instance.new("UICorner")
							local Sliderboxframe = Instance.new("Frame")
							local Sliderbox = Instance.new("UICorner")
							local Sliderbox_2 = Instance.new("TextBox")
							SliderFrame.Name = string.lower(v['Title'])
							SliderFrame.Parent = ScrollContainer
							SliderFrame.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
							SliderFrame.BackgroundTransparency = 1.000
							SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
							SliderFrame.Size = UDim2.new(1, 0, 0, 50)
							SliderCorner.CornerRadius = UDim.new(0, 4)
							SliderCorner.Name = "SliderCorner"
							SliderCorner.Parent = SliderFrame
							SliderBG.Name = "Background1"
							SliderBG.Parent = SliderFrame
							SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
							SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
							SliderBG.Size = UDim2.new(1, -10, 1, 0)
							SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
							SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
							SliderBGCorner.CornerRadius = UDim.new(0, 4)
							SliderBGCorner.Name = "SliderBGCorner"
							SliderBGCorner.Parent = SliderBG
							SliderTitle.Name = "TextColor"
							SliderTitle.Parent = SliderBG
							SliderTitle.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
							SliderTitle.BackgroundTransparency = 1.000
							SliderTitle.Position = UDim2.new(0, 10, 0, 0)
							SliderTitle.Size = UDim2.new(1, -10, 0, 25)
							SliderTitle.Font = Enum.Font.GothamBlack
							SliderTitle.Text = TitleText
							SliderTitle.TextSize = 14.000
							SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
							SliderTitle.TextColor3 = Color3.fromRGB(224, 182, 112)
							SliderBar.Name = "SliderBar"
							SliderBar.Parent = SliderFrame
							SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
							SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
							SliderBar.Size = UDim2.new(1, -20, 0, 6)
							SliderBar.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
							SliderButton.Name = "SliderButton "
							SliderButton.Parent = SliderBar
							SliderButton.BackgroundColor3 = Color3.fromRGB(50, 54, 70)
							SliderButton.BackgroundTransparency = 1.000
							SliderButton.Size = UDim2.new(1, 0, 1, 0)
							SliderButton.Font = Enum.Font.GothamBold
							SliderButton.Text = ""
							SliderButton.TextColor3 = Color3.fromRGB(205, 200, 220)
							SliderButton.TextSize = 14.000
							SliderBarCorner.CornerRadius = UDim.new(1, 0)
							SliderBarCorner.Name = "SliderBarCorner"
							SliderBarCorner.Parent = SliderBar
							Bar.Name = "Bar"
							Bar.BorderSizePixel = 0
							Bar.Parent = SliderBar
							Bar.Size = UDim2.new(0, 0, 1, 0)
							Bar.BackgroundColor3 = Color3.fromRGB(55, 58, 72)
							BarCorner.CornerRadius = UDim.new(1, 0)
							BarCorner.Name = "BarCorner"
							BarCorner.Parent = Bar
							Sliderboxframe.Name = "Background2"
							Sliderboxframe.Parent = SliderFrame
							Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
							Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
							Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
							Sliderboxframe.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
							Sliderbox.CornerRadius = UDim.new(0, 4)
							Sliderbox.Name = "Sliderbox"
							Sliderbox.Parent = Sliderboxframe
							Sliderbox_2.Name = "TextColor"
							Sliderbox_2.Parent = Sliderboxframe
							Sliderbox_2.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
							Sliderbox_2.BackgroundTransparency = 1.000
							Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
							Sliderbox_2.Font = Enum.Font.GothamBold
							Sliderbox_2.Text = ""
							Sliderbox_2.TextSize = 14.000
							Sliderbox_2.TextColor3 = Color3.fromRGB(205, 200, 220)
							SliderButton.MouseEnter:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = Color3.fromRGB(224, 182, 112)
								}):Play()
							end)
							SliderButton.MouseLeave:Connect(function()
								TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
									BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
								}):Play()
							end)
							local callBackAndSetText = function(val)
								Sliderbox_2.Text = val
								ListNew[i].Default = val
								Callback(i, v)
							end
							if DefaultValue then
								if DefaultValue <= minValue then
									DefaultValue = minValue
								elseif DefaultValue >= maxValue then
									DefaultValue = maxValue
								end
								Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
								callBackAndSetText(DefaultValue)
							end
							if SliderRelease then
								local dragging = false
								local dragInput
								local holdTime = 0
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0 
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0 
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							else
								local dragging = false
								local dragInput
								local holdTime = 0 
								local holdStarted = 0

								local function onInputBegan(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										holdStarted = tick()
										
										input.Changed:Connect(function()
											if input.UserInputState == Enum.UserInputState.End then
												dragging = false
												holdStarted = 0
											end
										end)
									end
								end
										
								local function onInputEnded(input)
									if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
										dragging = false
										holdStarted = 0 
									end
								end

								local function onInputChanged(input)
									if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
										dragInput = input
									end
								end
										
								SliderButton.InputBegan:Connect(onInputBegan)
								SliderButton.InputEnded:Connect(onInputEnded)
								SliderButton.InputChanged:Connect(onInputChanged)
										
								RunService.RenderStepped:Connect(function()
									if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
										dragging = true
									end
									if dragging and dragInput then
										local value = Precise and  tonumber(string.format("%.1f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
										pcall(function()
											callBackAndSetText(value)
										end)
										Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
									end
								end)
							end
							local function GetSliderValue(Value)
								if tonumber(Value) <= minValue then
									Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
									callBackAndSetText(minValue)
								elseif tonumber(Value) >= maxValue then
									Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
									callBackAndSetText(maxValue)
								else
									Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
									callBackAndSetText(Value)
								end
							end
							Sliderbox_2.FocusLost:Connect(function()
								GetSliderValue(Sliderbox_2.Text)
							end)
						end
					else
						for i, v in pairs (ListNew) do
							if typeof(v) == "string" then
								local SampleItem = Instance.new("Frame")
								local SampleItemCorner = Instance.new("UICorner")
								local SampleItemBG = Instance.new("Frame")
								local SampleItemBGCorner = Instance.new("UICorner")
								local SampleItemTitle = Instance.new("TextLabel")
								local SampleItemCheck = Instance.new("ImageButton")
								local SampleItemButton = Instance.new("TextButton")
								SampleItem.Name = string.lower(v)
								SampleItem.Parent = ScrollContainer
								SampleItem.BackgroundColor3 = Color3.fromRGB(34, 37, 50)
								SampleItem.BackgroundTransparency = 1.000
								SampleItem.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItem.LayoutOrder = 1
								SampleItem.Position = UDim2.new(0, 0, 0.208333328, 0)
								SampleItem.Size = UDim2.new(1, 0, 0, 25)
								SampleItemCorner.CornerRadius = UDim.new(0, 4)
								SampleItemCorner.Name = "SampleItemCorner"
								SampleItemCorner.Parent = SampleItem
								SampleItemBG.Name = "SampleItemBG"
								SampleItemBG.Parent = SampleItem
								SampleItemBG.AnchorPoint = Vector2.new(0.5, 0.5)
								SampleItemBG.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemBG.BackgroundTransparency = 1
								SampleItemBG.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemBG.Position = UDim2.new(0.5, 0, 0.5, 0)
								SampleItemBG.Size = UDim2.new(1, 0, 1, 0)
								SampleItemBGCorner.CornerRadius = UDim.new(0, 4)
								SampleItemBGCorner.Name = "SampleItemBGCorner"
								SampleItemBGCorner.Parent = SampleItemBG
								SampleItemTitle.Name = "SampleItemTitle"
								SampleItemTitle.Parent = SampleItemBG
								SampleItemTitle.BackgroundColor3 = Color3.fromRGB(34, 37, 50)
								SampleItemTitle.BackgroundTransparency = 1.000
								SampleItemTitle.BorderColor3 = Color3.fromRGB(27, 42, 53)
								SampleItemTitle.Position = UDim2.new(0, 10, 0, 0)
								SampleItemTitle.Size = UDim2.new(1, -40, 0, 25)
								SampleItemTitle.Font = Enum.Font.GothamBlack
								SampleItemTitle.Text = v
								SampleItemTitle.TextColor3 = Color3.fromRGB(255, 210, 80)
								SampleItemTitle.TextSize = 14.000
								SampleItemTitle.TextStrokeTransparency = 0.500
								SampleItemTitle.TextXAlignment = Enum.TextXAlignment.Left
								SampleItemCheck.Name = "SampleItemCheck"
								SampleItemCheck.Parent = SampleItemBG
								SampleItemCheck.AnchorPoint = Vector2.new(1, 0.5)
								SampleItemCheck.BackgroundTransparency = 1.000
								SampleItemCheck.Position = UDim2.new(1, 0, 0.5, 0)
								SampleItemCheck.Size = UDim2.new(0, 25, 0, 25)
								SampleItemCheck.ZIndex = 2
								SampleItemCheck.Image = "rbxassetid://3926305904"
								SampleItemCheck.ImageColor3 = UIColor["Dropdown Selected Check Color"]
								SampleItemCheck.ImageRectOffset = Vector2.new(312, 4)
								SampleItemCheck.ImageRectSize = Vector2.new(24, 24)
								SampleItemCheck.ImageTransparency = 1
								SampleItemButton.Name = "SampleItemButton"
								SampleItemButton.Parent = SampleItem
								SampleItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
								SampleItemButton.BackgroundTransparency = 1.000
								SampleItemButton.BorderColor3 = Color3.fromRGB(40, 80, 100)
								SampleItemButton.BorderSizePixel = 0
								SampleItemButton.Size = UDim2.new(1, 0, 1, 0)
								SampleItemButton.Font = Enum.Font.SourceSans
								SampleItemButton.TextColor3 = Color3.fromRGB(222, 222, 230)
								SampleItemButton.TextSize = 14.000
								SampleItemButton.TextTransparency = 1.000
								SampleItemButton.MouseEnter:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .7
									}
											):Play()
								end)
								SampleItemButton.MouseLeave:Connect(function()
									if Sel.Value == v then
										return
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = Color3.fromRGB(255, 255, 255)
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = 1
									}
											):Play()
								end)
								SampleItemButton.MouseButton1Click:Connect(function()
									if Search then
										Dropdowntitle.PlaceholderText = Title .. ': ' .. v or ""
										Sel.Value = v
									else
										Dropdowntitle.Text = Title .. ': ' .. v or ""
										Sel.Value = v
									end
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									}
											):Play()
									TweenService:Create(
												SampleItemBG,
												TweenInfo.new(getgenv().UIColor["Tween Animation 1 Speed"]), {
										BackgroundTransparency = .5
									}
											):Play()
									if Callback then
										Callback(v)
									end
									if Search then
										Dropdowntitle.Text = ""
									end
									refreshlist()
								end)
								if Sel.Value == v then
									SampleItemBG.BackgroundTransparency = .5;
									SampleItemBG.BackgroundColor3 = UIColor["Dropdown Selected Check Color"]
									SampleItem.LayoutOrder = 0
								end
							end
						end
					end
				end
				if Search then
					Dropdowntitle.Changed:Connect(function()
						edit()
						SearchDropdown()
					end)
				end
				if typeof(Default) ~= 'table' then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': ' .. tostring(Default or "")
					else
						Dropdowntitle.Text = Title .. ': ' .. tostring(Default or "")
					end
				elseif Slider then
					Dropdowntitle.Text = ''
					Dropdowntitle.PlaceholderText = Title .. ': '
				elseif Selected then
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
				DropdownButton.MouseButton1Click:Connect(function()
					refreshlist()
					isbusy = not isbusy
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
				end)
				local dropdownFunction = {
					rf = refreshlist
				}
				function dropdownFunction:ClearText(v)
					if not Selected then
						if Search then
							Dropdowntitle.PlaceholderText = Title .. ': ' .. (v or "")
						else
							Dropdowntitle.Text = Title .. ': ' .. (v or "")
						end
					else
						Dropdowntitle.Text = Title .. ': ' .. (v or "")
					end
				end
				function dropdownFunction:GetNewList(List)
					Sel.Value = ""
							--refreshlist()
					isbusy = false
					local listsize = isbusy and UDim2.new(1, 0, 0, 170) or UDim2.new(1, 0, 0, 0)
					local mainsize = isbusy and UDim2.new(1, 0, 0, 200) or UDim2.new(1, 0, 0, 25)
					local DropCRotation = isbusy and 90 or 0
					TweenService:Create(Dropdownlisttt, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = listsize
					}):Play()
					TweenService:Create(DropdownFrame, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Size = mainsize
					}):Play()
					TweenService:Create(ImgDrop, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						Rotation = DropCRotation
					}):Play()
					ListNew = {}
					ListNew = List
					refreshlist()
					if Search then
						Dropdowntitle.PlaceholderText = Title .. ': '
					else
						Dropdowntitle.Text = Title .. ': '
					end
				end
                function dropdownFunction:SetValue(value)
                    if not Selected then
                        if table.find(ListNew, value) then
                            Sel.Value = value
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': ' .. value
                            else
                                Dropdowntitle.Text = Title .. ': ' .. value
                            end
                            if Callback then
                                Callback(value)
                            end
                            refreshlist()
                        end
                    else
                        if ListNew[value] ~= nil then
                            ListNew[value] = true
                            if Search then
                                Dropdowntitle.PlaceholderText = Title .. ': '
                            else
                                Dropdowntitle.Text = Title .. ': '
                            end
                            if Callback then
                                Callback(value, true)
                            end
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
                            if val == true then
                                table.insert(result, key)
                            end
                        end
                        return result
                    end
                end
				local controlData = {
                    Name = Title,
                    Section = Section,
                    Element = DropdownFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName,
                    SetValue = dropdownFunction.SetValue, 
                    GetValue = dropdownFunction.GetValue 
                }
                table.insert(getgenv().AllControls, controlData)
                
                return dropdownFunction
			end

function sectionFunction:AddKeyBind(Setting, Callback)
    local TitleText = tostring(Setting.Title or Setting.Text) or ""
    local Default = Setting.Default or Setting.Key or "F"
    local Mode = Setting.Mode or "Toggle"
    local Callback = Setting.Callback or Callback or function() end
    
    local function GetKeyString(key)
        local keyStr = tostring(key)
        keyStr = keyStr:gsub("Enum.UserInputType.", "")
        keyStr = keyStr:gsub("Enum.KeyCode.", "")
        return keyStr
    end
    
    local CurrentKey = GetKeyString(Default)
    local CurrentMode = Mode
    local Picking = false
    local ToggleState = false
    local HoldActive = false
    
    local BindFrame = Instance.new("Frame")
    local BindCorner = Instance.new("UICorner")
    local BindBG = Instance.new("Frame")
    local ButtonCorner = Instance.new("UICorner")
    local BindButtonTitle = Instance.new("TextLabel")
    local BindCor = Instance.new("Frame")
    local ButtonCorner_2 = Instance.new("UICorner")
    local Bindkey = Instance.new("TextButton")
    
    BindFrame.Name = TitleText .. "bguvl"
    BindFrame.Parent = Section
    BindFrame.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
    BindFrame.BackgroundTransparency = 1.000
    BindFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
    BindFrame.Size = UDim2.new(1, 0, 0, 35)
    
    BindCorner.CornerRadius = UDim.new(0, 4)
    BindCorner.Name = "BindCorner"
    BindCorner.Parent = BindFrame
    
    BindBG.Name = "Background1"
    BindBG.Parent = BindFrame
    BindBG.AnchorPoint = Vector2.new(0.5, 0.5)
    BindBG.Position = UDim2.new(0.5, 0, 0.5, 0)
    BindBG.Size = UDim2.new(1, -10, 1, 0)
    BindBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
    BindBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
    
    ButtonCorner.CornerRadius = UDim.new(0, 4)
    ButtonCorner.Name = "ButtonCorner"
    ButtonCorner.Parent = BindBG
    
    BindButtonTitle.Name = "TextColor"
    BindButtonTitle.Parent = BindBG
    BindButtonTitle.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
    BindButtonTitle.BackgroundTransparency = 1.000
    BindButtonTitle.Position = UDim2.new(0, 10, 0, 0)
    BindButtonTitle.Size = UDim2.new(1, -10, 1, 0)
    BindButtonTitle.Font = Enum.Font.GothamBlack
    BindButtonTitle.Text = TitleText
    BindButtonTitle.TextSize = 14.000
    BindButtonTitle.TextXAlignment = Enum.TextXAlignment.Left
    BindButtonTitle.TextColor3 = Color3.fromRGB(20, 70, 190)
    
    BindCor.Name = "Background2"
    BindCor.Parent = BindBG
    BindCor.AnchorPoint = Vector2.new(1, 0.5)
    BindCor.Position = UDim2.new(1, -5, 0.5, 0)
    BindCor.Size = UDim2.new(0, 150, 0, 25)
    BindCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
    
    ButtonCorner_2.CornerRadius = UDim.new(0, 4)
    ButtonCorner_2.Name = "ButtonCorner"
    ButtonCorner_2.Parent = BindCor
    
    Bindkey.Name = "Bindkey"
    Bindkey.Parent = BindCor
    Bindkey.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
    Bindkey.BackgroundTransparency = 1.000
    Bindkey.Size = UDim2.new(1, 0, 1, 0)
    Bindkey.Font = Enum.Font.GothamBold
    Bindkey.Text = CurrentKey
    Bindkey.TextSize = 14.000
    Bindkey.TextColor3 = Color3.fromRGB(10, 110, 120)
    
    Bindkey.MouseButton1Click:Connect(function()
        if Picking then return end
        
        Picking = true
        Bindkey.Text = "..."
        
        task.wait(0.2)
        
        local Connection
        Connection = uis.InputBegan:Connect(function(input)
            if Picking then
                local Key
                
                if input.UserInputType == Enum.UserInputType.Keyboard then
                    Key = input.KeyCode.Name
                elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
                    Key = "MouseLeft"
                elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
                    Key = "MouseRight"
                end
                
                if Key then
                    Picking = false
                    CurrentKey = Key
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
        if input.UserInputType == Enum.UserInputType.Keyboard then
            pressedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            pressedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            pressedKey = "MouseRight"
        end
        
        if pressedKey == CurrentKey then
            if CurrentMode == "Toggle" then
                ToggleState = not ToggleState
                pcall(Callback, ToggleState)
            elseif CurrentMode == "Hold" then
                HoldActive = true
                pcall(Callback, true)
            end
        end
    end)
    
    uis.InputEnded:Connect(function(input)
        if Picking then return end
        if uis:GetFocusedTextBox() then return end
        
        local releasedKey
        if input.UserInputType == Enum.UserInputType.Keyboard then
            releasedKey = input.KeyCode.Name
        elseif input.UserInputType == Enum.UserInputType.MouseButton1 then
            releasedKey = "MouseLeft"
        elseif input.UserInputType == Enum.UserInputType.MouseButton2 then
            releasedKey = "MouseRight"
        end
        
        if releasedKey == CurrentKey and CurrentMode == "Hold" and HoldActive then
            HoldActive = false
            pcall(Callback, false)
        end
    end)
    
    local controlData = {
        Name = TitleText,
        Section = Section,
        Element = BindFrame,
        SectionName = Section_Name,
        TabName = Page_Name,
        TabButton = PageName
    }
    table.insert(getgenv().AllControls, controlData)
    
    local keybindFunction = {}
    
    function keybindFunction:Set(newKey)
        CurrentKey = GetKeyString(newKey)
        Bindkey.Text = CurrentKey
    end
    
    function keybindFunction:Get()
        return CurrentKey
    end
    
    function keybindFunction:SetMode(mode)
        if mode == "Hold" or mode == "Toggle" then
            CurrentMode = mode
            ToggleState = false
            HoldActive = false
        end
    end
    
    function keybindFunction:GetMode()
        return CurrentMode
    end
    
    function keybindFunction:GetState()
        if CurrentMode == "Toggle" then
            return ToggleState
        elseif CurrentMode == "Hold" then
            return HoldActive
        end
        return false
    end
    
    return keybindFunction
end
			function sectionFunction:AddInput(idk, Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local Desc = Setting.Desc or Setting.Description 
				local Placeholder = tostring(Setting.Placeholder) or ""
				local Default = Setting.Default or false
				local Number_Only = Setting.Numeric or false
				local Callback = Setting.Callback
				
				local BoxFrame = Instance.new("Frame")
				local BoxCorner = Instance.new("UICorner")
				local BoxBG = Instance.new("Frame")
				local ButtonCorner = Instance.new("UICorner")
				local Boxtitle = Instance.new("TextLabel")
				local BoxCor = Instance.new("Frame")
				local ButtonCorner_2 = Instance.new("UICorner")
				local Boxxx = Instance.new("TextBox")
				local Lineeeee = Instance.new("Frame")
				local UICorner = Instance.new("UICorner")
				
				BoxFrame.Name = "BoxFrame"
				BoxFrame.Parent = Section
				BoxFrame.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				BoxFrame.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					BoxFrame.AutomaticSize = Enum.AutomaticSize.Y
					BoxFrame.Size = UDim2.new(1, 0, 0, 0)
				else
					BoxFrame.Size = UDim2.new(1, 0, 0, 40)
				end
				
				BoxCorner.CornerRadius = UDim.new(0, 4)
				BoxCorner.Name = "BoxCorner"
				BoxCorner.Parent = BoxFrame
				
				BoxBG.Name = "Background1"
				BoxBG.Parent = BoxFrame
				BoxBG.AnchorPoint = Vector2.new(0.5, 0.5)
				BoxBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				BoxBG.Size = UDim2.new(1, -10, 1, 0)
				BoxBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				BoxBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				
				ButtonCorner.CornerRadius = UDim.new(0, 4)
				ButtonCorner.Name = "ButtonCorner"
				ButtonCorner.Parent = BoxBG
				
				Boxtitle.Name = "TextColor"
				Boxtitle.Parent = BoxBG
				Boxtitle.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				Boxtitle.BackgroundTransparency = 1.000
				
				if Desc and Desc ~= "" then
					Boxtitle.Position = UDim2.new(0, 10, 0, 5)
					Boxtitle.Size = UDim2.new(1, -10, 0, 20)
				else
					Boxtitle.Position = UDim2.new(0, 10, 0, 0)
					Boxtitle.Size = UDim2.new(0.5, 0, 1, 0) 
				end
				
				Boxtitle.Font = Enum.Font.GothamBlack
				Boxtitle.Text = TitleText
				Boxtitle.TextSize = 14.000
				Boxtitle.TextXAlignment = Enum.TextXAlignment.Left
				Boxtitle.TextColor3 = Color3.fromRGB(10, 110, 120)
				
				if Desc and Desc ~= "" then
					local TextDesc = Instance.new("TextLabel")
					TextDesc.Parent = BoxBG
					TextDesc.BackgroundTransparency = 1
					TextDesc.Position = UDim2.new(0, 10, 0, 25)
					TextDesc.Size = UDim2.new(1, -20, 0, 0)
					TextDesc.AutomaticSize = Enum.AutomaticSize.Y
					TextDesc.Font = Enum.Font.Gotham
					TextDesc.Text = Desc
					TextDesc.TextColor3 = Color3.fromRGB(148, 152, 168)
					TextDesc.TextSize = 12
					TextDesc.TextWrapped = true
					TextDesc.TextXAlignment = Enum.TextXAlignment.Left
					
					local pad = Instance.new("UIPadding", BoxBG)
					pad.PaddingTop = UDim.new(0, 5)
					pad.PaddingBottom = UDim.new(0, 5)
				end
				
				BoxCor.Name = "Background2"
				BoxCor.Parent = BoxBG
				BoxCor.AnchorPoint = Vector2.new(1, 0.5)
				BoxCor.ClipsDescendants = true
				
				BoxCor.Position = UDim2.new(1, -5, 0.5, 0)
				BoxCor.Size = UDim2.new(0, 120, 0, 25)
				
				BoxCor.BackgroundColor3 = getgenv().UIColor["Background 2 Color"]
				
				ButtonCorner_2.CornerRadius = UDim.new(0, 4)
				ButtonCorner_2.Name = "ButtonCorner"
				ButtonCorner_2.Parent = BoxCor
				
				Boxxx.Name = "TextColorPlaceholder"
				Boxxx.Parent = BoxCor
				Boxxx.BackgroundColor3 = Color3.fromRGB(30, 32, 44)
				Boxxx.BackgroundTransparency = 1.000
				Boxxx.Position = UDim2.new(0, 5, 0, 0)
				Boxxx.Size = UDim2.new(1, -5, 1, 0)
				Boxxx.Font = Enum.Font.GothamBold
				Boxxx.PlaceholderText = Placeholder
				Boxxx.Text = ""
				Boxxx.TextSize = 14.000
				Boxxx.TextXAlignment = Enum.TextXAlignment.Left
				Boxxx.PlaceholderColor3 = getgenv().UIColor["Placeholder Text Color"]
				Boxxx.TextColor3 = Color3.fromRGB(190, 195, 212)
				
				Lineeeee.Name = "TextNSBoxLineeeee"
				Lineeeee.Parent = BoxCor
				Lineeeee.BackgroundTransparency = 1.000
				Lineeeee.Position = UDim2.new(0, 0, 1, -2)
				Lineeeee.Size = UDim2.new(1, 0, 0, 6)
				Lineeeee.BackgroundColor3 = getgenv().UIColor["Box Highlight Color"]
				
				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = Lineeeee
				
				Boxxx.Focused:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 0
					}):Play()
				end)
				
				if Number_Only then
					Boxxx:GetPropertyChangedSignal("Text"):Connect(function()
						if tonumber(Boxxx.Text) then
						else
							Boxxx.PlaceholderText = Placeholder
							Boxxx.Text = ''
						end
					end)
				end
				
				Boxxx.FocusLost:Connect(function()
					TweenService:Create(Lineeeee, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundTransparency = 1
					}):Play()
					if Boxxx.Text ~= '' then
						Callback(Boxxx.Text)
					end
				end)
				
				local textbox_function = {}
				if Default then Boxxx.Text = Default end
				function textbox_function.SetValue(Value)
					Boxxx.Text = Value
					Callback(Value)
				end
				
				local controlData = {
					Name = TitleText,
					Section = Section,
					Element = BoxFrame,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
				return textbox_function
			end
			function sectionFunction:AddSlider(Setting)
				local TitleText = tostring(Setting.Text or Setting.Title) or ""
				local minValue = tonumber(Setting.Min) or 0
				local maxValue = tonumber(Setting.Max) or 100
				local Precise = Setting.Precise or false
				local DefaultValue = tonumber(Setting.Default) or 0
				local Callback = Setting.Callback
				local SizeChia = 400;
                local SliderFrame = Instance.new("Frame")
				local SliderCorner = Instance.new("UICorner")
				local SliderBG = Instance.new("Frame")
				local SliderBGCorner = Instance.new("UICorner")
				local SliderTitle = Instance.new("TextLabel")
				local SliderBar = Instance.new("Frame")
				local SliderButton = Instance.new("TextButton")
				local SliderBarCorner = Instance.new("UICorner")
				local Bar = Instance.new("Frame")
				local BarCorner = Instance.new("UICorner")
				local Sliderboxframe = Instance.new("Frame")
				local Sliderbox = Instance.new("UICorner")
				local Sliderbox_2 = Instance.new("TextBox")
				SliderFrame.Name = TitleText .. 'buda'
				SliderFrame.Parent = Section
				SliderFrame.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				SliderFrame.BackgroundTransparency = 1.000
				SliderFrame.Position = UDim2.new(0, 0, 0.208333328, 0)
				SliderFrame.Size = UDim2.new(1, 0, 0, 50)
				SliderCorner.CornerRadius = UDim.new(0, 4)
				SliderCorner.Name = "SliderCorner"
				SliderCorner.Parent = SliderFrame
				SliderBG.Name = "Background1"
				SliderBG.Parent = SliderFrame
				SliderBG.AnchorPoint = Vector2.new(0.5, 0.5)
				SliderBG.Position = UDim2.new(0.5, 0, 0.5, 0)
				SliderBG.Size = UDim2.new(1, -10, 1, 0)
				SliderBG.BackgroundColor3 = getgenv().UIColor["Background 1 Color"]
				SliderBG.BackgroundTransparency = getgenv().UIColor["Background 1 Transparency"]
				SliderBGCorner.CornerRadius = UDim.new(0, 4)
				SliderBGCorner.Name = "SliderBGCorner"
				SliderBGCorner.Parent = SliderBG
				SliderTitle.Name = "TextColor"
				SliderTitle.Parent = SliderBG
				SliderTitle.BackgroundColor3 = Color3.fromRGB(32, 35, 45)
				SliderTitle.BackgroundTransparency = 1.000
				SliderTitle.Position = UDim2.new(0, 10, 0, 0)
				SliderTitle.Size = UDim2.new(1, -10, 0, 25)
				SliderTitle.Font = Enum.Font.GothamBlack
				SliderTitle.Text = TitleText
				SliderTitle.TextSize = 14.000
				SliderTitle.RichText = true
				SliderTitle.TextXAlignment = Enum.TextXAlignment.Left
				SliderTitle.TextColor3 = Color3.fromRGB(224, 182, 112)
				SliderBar.Name = "SliderBar"
				SliderBar.Parent = SliderFrame
				SliderBar.AnchorPoint = Vector2.new(.5, 0.5)
				SliderBar.Position = UDim2.new(.5, 0, 0.5, 14)
				SliderBar.Size = UDim2.new(0, 400, 0, 6)
				SliderBar.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
				SliderButton.Name = "SliderButton "
				SliderButton.Parent = SliderBar
				SliderButton.BackgroundColor3 = Color3.fromRGB(50, 54, 70)
				SliderButton.BackgroundTransparency = 1.000
				SliderButton.Size = UDim2.new(1, 0, 1, 0)
				SliderButton.Font = Enum.Font.GothamBold
				SliderButton.Text = ""
				SliderButton.TextColor3 = Color3.fromRGB(205, 200, 220)
				SliderButton.TextSize = 14.000
				SliderBarCorner.CornerRadius = UDim.new(1, 0)
				SliderBarCorner.Name = "SliderBarCorner"
				SliderBarCorner.Parent = SliderBar
				Bar.Name = "Bar"
				Bar.BorderSizePixel = 0
				Bar.Parent = SliderBar
				Bar.Size = UDim2.new(0, 0, 1, 0)
				Bar.BackgroundColor3 = Color3.fromRGB(55, 58, 72)
				BarCorner.CornerRadius = UDim.new(1, 0)
				BarCorner.Name = "BarCorner"
				BarCorner.Parent = Bar
				Sliderboxframe.Name = "Background2"
				Sliderboxframe.Parent = SliderFrame
				Sliderboxframe.AnchorPoint = Vector2.new(1, 0)
				Sliderboxframe.Position = UDim2.new(1, -10, 0, 5)
				Sliderboxframe.Size = UDim2.new(0, 150, 0, 25)
				Sliderboxframe.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
				Sliderbox.CornerRadius = UDim.new(0, 4)
				Sliderbox.Name = "Sliderbox"
				Sliderbox.Parent = Sliderboxframe
				Sliderbox_2.Name = "TextColor"
				Sliderbox_2.Parent = Sliderboxframe
				Sliderbox_2.BackgroundColor3 = Color3.fromRGB(44, 48, 64)
				Sliderbox_2.BackgroundTransparency = 1.000
				Sliderbox_2.Size = UDim2.new(1, 0, 1, 0)
				Sliderbox_2.Font = Enum.Font.GothamBold
				Sliderbox_2.Text = ""
				Sliderbox_2.TextSize = 14.000
				Sliderbox_2.TextColor3 = Color3.fromRGB(205, 200, 220)
				SliderButton.MouseEnter:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = Color3.fromRGB(224, 182, 112)
					}):Play()
				end)
				SliderButton.MouseLeave:Connect(function()
					TweenService:Create(Bar, TweenInfo.new(getgenv().UIColor["Tween Animation 2 Speed"]), {
						BackgroundColor3 = getgenv().UIColor["Slider Line Color"]
					}):Play()
				end)
				local callBackAndSetText = function(val)
					Sliderbox_2.Text = val
					Callback(tonumber(val))
				end
				if DefaultValue then
					if DefaultValue <= minValue then
						DefaultValue = minValue
					elseif DefaultValue >= maxValue then
						DefaultValue = maxValue
					end
					Sliderbox_2.Text = tostring(DefaultValue)
					Bar.Size = UDim2.new(1 - ((maxValue - DefaultValue) / (maxValue - minValue)), 0, 0, 6)
                    if Callback then
                        Callback(tonumber(DefaultValue))
                    end
				end
				local dragging = false
				local dragInput
				local holdTime = 0 
				local holdStarted = 0

				local function onInputBegan(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						holdStarted = tick() 
						
						input.Changed:Connect(function()
							if input.UserInputState == Enum.UserInputState.End then
								dragging = false
								holdStarted = 0 
							end
						end)
					end
				end
						
				local function onInputEnded(input)
					if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
						dragging = false
						holdStarted = 0 
					end
				end

				local function onInputChanged(input)
					if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
						dragInput = input
					end
				end
						
				SliderButton.InputBegan:Connect(onInputBegan)
				SliderButton.InputEnded:Connect(onInputEnded)
				SliderButton.InputChanged:Connect(onInputChanged)
						
				RunService.RenderStepped:Connect(function()
					if holdStarted > 0 and (tick() - holdStarted >= holdTime) and not dragging then
						dragging = true
					end
					if dragging and dragInput then
						local value = Setting.Rouding and  tonumber(string.format("%.".. Setting.Rouding or 1 .."f", (((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))) or math.floor((((tonumber(maxValue) - tonumber(minValue)) / SizeChia) * Bar.AbsoluteSize.X) + tonumber(minValue))
						pcall(function()
							callBackAndSetText(value)
						end)
						Bar.Size = UDim2.new(0, math.clamp(dragInput.Position.X - Bar.AbsolutePosition.X, 0, SizeChia), 0, 6)
					end
				end)
				local function GetSliderValue(Value)
					if tonumber(Value) <= minValue then
						Bar.Size = UDim2.new(0, (0 * SizeChia), 0, 6)
						callBackAndSetText(minValue)
					elseif tonumber(Value) >= maxValue then
						Bar.Size = UDim2.new(0, (maxValue  /  maxValue * SizeChia), 0, 6)
						callBackAndSetText(maxValue)
					else
						Bar.Size = UDim2.new(1 - ((maxValue - Value) / (maxValue - minValue)), 0, 0, 6)
						callBackAndSetText(Value)
					end
				end
				Sliderbox_2.FocusLost:Connect(function()
					GetSliderValue(Sliderbox_2.Text)
				end)
				local slider_function = {}
				function slider_function.SetValue(Value)
					GetSliderValue(Value)
				end
				local controlData = {
                    Name = TitleText,
                    Section = Section,
                    Element = SliderFrame,
                    SectionName = Section_Name,
                    TabName = Page_Name,
                    TabButton = PageName
                }
                table.insert(getgenv().AllControls, controlData)
                
				return slider_function
			end
			function sectionFunction:AddSeperator(text)
				local SeparatorFrame = Instance.new("Frame")
				SeparatorFrame.Name = "Separator"
				SeparatorFrame.Parent = Section
				SeparatorFrame.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SeparatorFrame.BackgroundTransparency = 1.000
				SeparatorFrame.Size = UDim2.new(1, 0, 0, 25)

				if text and text ~= "" then
					local SeparatorLabel = Instance.new("TextLabel")
					SeparatorLabel.Name = "Title"
					SeparatorLabel.Parent = SeparatorFrame
					SeparatorLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					SeparatorLabel.BackgroundTransparency = 1.000
					SeparatorLabel.AnchorPoint = Vector2.new(0.5, 0.5)
					SeparatorLabel.Position = UDim2.new(0.5, 0, 0.5, 0)
					SeparatorLabel.AutomaticSize = Enum.AutomaticSize.X
					SeparatorLabel.Size = UDim2.new(0, 0, 1, 0)
					SeparatorLabel.Font = Enum.Font.GothamBold
					SeparatorLabel.Text = text
					SeparatorLabel.TextColor3 = getgenv().UIColor["Section Text Color"]
					SeparatorLabel.TextSize = 14.000
					
					local LeftLine = Instance.new("Frame")
					LeftLine.Name = "LeftLine"
					LeftLine.Parent = SeparatorFrame
					LeftLine.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					LeftLine.BorderSizePixel = 0
					LeftLine.AnchorPoint = Vector2.new(1, 0.5) 
					LeftLine.Position = UDim2.new(0.5, -5, 0.5, 0) 
					LeftLine.Size = UDim2.new(0.5, -10, 0, 1) 
					
					local LeftGradient = Instance.new("UIGradient")
					LeftGradient.Parent = LeftLine
					LeftGradient.Rotation = 180
					LeftGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),  
						NumberSequenceKeypoint.new(1, 0.8) 
					}

					local RightLine = Instance.new("Frame")
					RightLine.Name = "RightLine"
					RightLine.Parent = SeparatorFrame
					RightLine.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					RightLine.BorderSizePixel = 0
					RightLine.AnchorPoint = Vector2.new(0, 0.5)
					RightLine.Position = UDim2.new(0.5, 5, 0.5, 0)
					RightLine.Size = UDim2.new(0.5, -10, 0, 1)

					local RightGradient = Instance.new("UIGradient")
					RightGradient.Parent = RightLine
					RightGradient.Rotation = 0
					RightGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 0),
						NumberSequenceKeypoint.new(1, 0.8) 
					}

					local function UpdateSeparator()
						local textWidth = SeparatorLabel.TextBounds.X
						local padding = 8
						
						LeftLine.Size = UDim2.new(0.5, -(textWidth / 2) - padding, 0, 1)
						LeftLine.Position = UDim2.new(0.5, -(textWidth / 2) - padding, 0.5, 0)
						LeftLine.AnchorPoint = Vector2.new(1, 0.5)
						LeftLine.Position = UDim2.new(0.5, -(textWidth / 2) - padding, 0.5, 0)
						
						LeftLine.Size = UDim2.new(0.5, -(textWidth / 2) - padding, 0, 1)
						LeftLine.Position = UDim2.new(0, 0, 0.5, 0)
						LeftLine.AnchorPoint = Vector2.new(0, 0.5)

						RightLine.Size = UDim2.new(0.5, -(textWidth / 2) - padding, 0, 1)
						RightLine.Position = UDim2.new(1, 0, 0.5, 0) 
						RightLine.AnchorPoint = Vector2.new(1, 0.5)
					end

					SeparatorLabel:GetPropertyChangedSignal("TextBounds"):Connect(UpdateSeparator)
					UpdateSeparator()

				else
					local SeparatorLine = Instance.new("Frame")
					SeparatorLine.Name = "Line"
					SeparatorLine.Parent = SeparatorFrame
					SeparatorLine.BackgroundColor3 = getgenv().UIColor["Section Underline Color"]
					SeparatorLine.BorderSizePixel = 0
					SeparatorLine.Position = UDim2.new(0, 10, 0.5, 0)
					SeparatorLine.Size = UDim2.new(1, -20, 0, 1)
					
					local LineGradient = Instance.new("UIGradient")
					LineGradient.Parent = SeparatorLine
					LineGradient.Transparency = NumberSequence.new{
						NumberSequenceKeypoint.new(0, 1),
						NumberSequenceKeypoint.new(0.2, 0),
						NumberSequenceKeypoint.new(0.8, 0),
						NumberSequenceKeypoint.new(1, 1)
					}
				end

				local controlData = {
					Name = text or "Separator",
					Section = Section,
					Element = SeparatorFrame,
					SectionName = Section_Name,
					TabName = Page_Name,
					TabButton = PageName
				}
				table.insert(getgenv().AllControls, controlData)
			end

			return sectionFunction
		end
        local pagefunc = {}
        function pagefunc:AddLeftGroupbox(name)
            return pageFunction:AddSection(name)
        end
        function pagefunc:AddRightGroupbox(name)
            return pageFunction:AddSection(name)
        end
		return pagefunc
	end

	return Main_Function
end

return Library
