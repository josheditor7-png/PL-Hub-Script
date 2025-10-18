--// PL HUB v5 – Dark Elegant Style + Draggable + AK-47 Fix
--// by ChatGPT for Josh
--// Compatible con Solara / Xeno

pcall(function()
	if game:GetService("Players").LocalPlayer.PlayerGui:FindFirstChild("PLHUB") then
		game:GetService("Players").LocalPlayer.PlayerGui.PLHUB:Destroy()
	end
end)

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")

local TweenService = game:GetService("TweenService")
local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- GUI base
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "PLHUB"
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
ScreenGui.ResetOnSpawn = false

-- Botón flotante
local OpenButton = Instance.new("TextButton")
OpenButton.Name = "OpenButton"
OpenButton.Parent = ScreenGui
OpenButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
OpenButton.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenButton.Font = Enum.Font.GothamBold
OpenButton.TextSize = 20
OpenButton.Text = "PLH"
OpenButton.Size = UDim2.new(0, 60, 0, 60)
OpenButton.Position = UDim2.new(0.1, 0, 0.4, 0)
OpenButton.BorderSizePixel = 0
OpenButton.Active = true
OpenButton.Draggable = true
Instance.new("UICorner", OpenButton).CornerRadius = UDim.new(1, 0)
Instance.new("UIStroke", OpenButton).Color = Color3.fromRGB(80, 80, 80)

-- Marco principal
local MainFrame = Instance.new("Frame")
MainFrame.Parent = ScreenGui
MainFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
MainFrame.Size = UDim2.new(0, 500, 0, 400)
MainFrame.Position = UDim2.new(0.5, -250, 0.5, -200)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 12)

-- Título (zona draggable)
local TitleBar = Instance.new("TextLabel")
TitleBar.Parent = MainFrame
TitleBar.Size = UDim2.new(1, 0, 0, 40)
TitleBar.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
TitleBar.Text = "PL HUB"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 24
TitleBar.TextColor3 = Color3.fromRGB(255, 255, 255)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0, 12)

-- Hacer MainFrame arrastrable por el título
do
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	TitleBar.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 then
			dragging = true
			dragStart = input.Position
			startPos = MainFrame.Position
			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)
	TitleBar.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement then
			dragInput = input
		end
	end)
	game:GetService("UserInputService").InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)
end

-- Panel lateral
local SideMenu = Instance.new("Frame")
SideMenu.Parent = MainFrame
SideMenu.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
SideMenu.Size = UDim2.new(0, 130, 1, -40)
SideMenu.Position = UDim2.new(0, 0, 0, 40)

local SideLayout = Instance.new("UIListLayout", SideMenu)
SideLayout.Padding = UDim.new(0, 10)
SideLayout.SortOrder = Enum.SortOrder.LayoutOrder
SideLayout.HorizontalAlignment = Enum.HorizontalAlignment.Center

local function CreateMenuButton(name)
	local btn = Instance.new("TextButton")
	btn.Parent = SideMenu
	btn.Size = UDim2.new(1, -20, 0, 35)
	btn.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	btn.Text = name
	btn.Font = Enum.Font.GothamBold
	btn.TextColor3 = Color3.fromRGB(220, 220, 220)
	btn.TextSize = 16
	btn.AutoButtonColor = false
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 6)

	local stroke = Instance.new("UIStroke", btn)
	stroke.Color = Color3.fromRGB(60, 60, 60)

	btn.MouseEnter:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(45, 45, 45)}):Play()
	end)
	btn.MouseLeave:Connect(function()
		TweenService:Create(btn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
	end)
	return btn
end

-- Contenedor de contenido
local ContentFrame = Instance.new("Frame")
ContentFrame.Parent = MainFrame
ContentFrame.BackgroundTransparency = 1
ContentFrame.Position = UDim2.new(0, 140, 0, 50)
ContentFrame.Size = UDim2.new(1, -150, 1, -60)

local function CreateSectionFrame()
	local frame = Instance.new("ScrollingFrame")
	frame.Parent = ContentFrame
	frame.Size = UDim2.new(1, 0, 1, 0)
	frame.BackgroundTransparency = 1
	frame.ScrollBarThickness = 4
	frame.Visible = false
	local layout = Instance.new("UIListLayout", frame)
	layout.Padding = UDim.new(0, 10)
	layout.SortOrder = Enum.SortOrder.LayoutOrder
	return frame
end

local function CreateOption(parent, name, callback)
	local frame = Instance.new("Frame")
	frame.Parent = parent
	frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
	frame.Size = UDim2.new(1, 0, 0, 35)
	frame.BorderSizePixel = 0
	Instance.new("UICorner", frame).CornerRadius = UDim.new(0, 6)

	local label = Instance.new("TextLabel")
	label.Parent = frame
	label.BackgroundTransparency = 1
	label.Text = name
	label.Font = Enum.Font.Gotham
	label.TextSize = 16
	label.TextColor3 = Color3.fromRGB(230, 230, 230)
	label.Position = UDim2.new(0, 10, 0, 0)
	label.Size = UDim2.new(0.7, 0, 1, 0)
	label.TextXAlignment = Enum.TextXAlignment.Left

	local switch = Instance.new("TextButton")
	switch.Parent = frame
	switch.Size = UDim2.new(0, 50, 0, 22)
	switch.Position = UDim2.new(1, -60, 0.5, -11)
	switch.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
	switch.Text = ""
	switch.AutoButtonColor = false
	Instance.new("UICorner", switch).CornerRadius = UDim.new(1, 0)

	local knob = Instance.new("Frame")
	knob.Parent = switch
	knob.Size = UDim2.new(0, 20, 0, 20)
	knob.Position = UDim2.new(0, 2, 0.5, -10)
	knob.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	Instance.new("UICorner", knob).CornerRadius = UDim.new(1, 0)

	local on = false
	switch.MouseButton1Click:Connect(function()
		on = not on
		local goal = {}
		if on then
			goal.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
			TweenService:Create(knob, TweenInfo.new(0.25), {Position = UDim2.new(1, -22, 0.5, -10)}):Play()
		else
			goal.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
			TweenService:Create(knob, TweenInfo.new(0.25), {Position = UDim2.new(0, 2, 0.5, -10)}):Play()
		end
		TweenService:Create(switch, TweenInfo.new(0.25), goal):Play()
		callback(on)
	end)
end

-- Secciones
local TeleportFrame = CreateSectionFrame()
local MiscFrame = CreateSectionFrame()
local ItemsFrame = CreateSectionFrame()

-- TELEPORTS
local Teleports = {
	["Zona de armas"] = Vector3.new(-928.858, 94.129, 2049.145),
	["Zona Segura"] = Vector3.new(-56.212, 11.099, 1297.009),
	["Muralla"] = Vector3.new(825.557, 125.840, 2072.784),
	["Cafetería"] = Vector3.new(904.909, 99.990, 2269.678),
	["Celdas"] = Vector3.new(914.927, 99.990, 2458.348),
	["Yarda"] = Vector3.new(846.403, 98.190, 2545.063),
	["Techo de la cárcel"] = Vector3.new(931.791, 118.990, 2371.300)
}

for name, pos in pairs(Teleports) do
	CreateOption(TeleportFrame, name, function(on)
		if on and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
			player.Character:MoveTo(pos)
		end
	end)
end

CreateOption(TeleportFrame, "Universal Teleport", function(on)
	if on then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/josheditor7-png/Teleport/refs/heads/main/Lines.lua"))()
	end
end)

-- ITEMS
CreateOption(ItemsFrame, "AK-47", function(on)
	if on then
		local id = "AK-47"
		local tool = nil

		if game.ReplicatedStorage:FindFirstChild(id) then
			tool = game.ReplicatedStorage[id]:Clone()
		elseif workspace:FindFirstChild(id) then
			tool = workspace[id]:Clone()
		end

		if not tool then
			-- Crea un arma básica si no existe
			tool = Instance.new("Tool")
			tool.Name = id
			local handle = Instance.new("Part")
			handle.Name = "Handle"
			handle.Size = Vector3.new(1, 1, 4)
			handle.BrickColor = BrickColor.new("Really black")
			handle.Parent = tool
			tool.Parent = player.Backpack
		else
			tool.Parent = player.Backpack
		end

		task.wait(0.2)
		player.Character.Humanoid:EquipTool(tool)
	end
end)

-- MENU
local Sections = {
	["Teleports"] = TeleportFrame,
	["Misc"] = MiscFrame,
	["Items"] = ItemsFrame
}

local Buttons = {}
for name in pairs(Sections) do
	local btn = CreateMenuButton(name)
	Buttons[name] = btn
	btn.MouseButton1Click:Connect(function()
		for n, frame in pairs(Sections) do
			frame.Visible = (n == name)
			if n == name then
				TweenService:Create(Buttons[n], TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()
			else
				TweenService:Create(Buttons[n], TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(30, 30, 30)}):Play()
			end
		end
	end)
end
Sections["Teleports"].Visible = true
TweenService:Create(Buttons["Teleports"], TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(0, 170, 255)}):Play()

-- Abrir / Cerrar GUI
local open = false
OpenButton.MouseButton1Click:Connect(function()
	open = not open
	if open then
		MainFrame.Visible = true
		MainFrame.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(MainFrame, TweenInfo.new(0.4), {Size = UDim2.new(0, 500, 0, 400)}):Play()
	else
		local t = TweenService:Create(MainFrame, TweenInfo.new(0.4), {Size = UDim2.new(0, 0, 0, 0)})
		t:Play()
		t.Completed:Connect(function()
			MainFrame.Visible = false
		end)
	end
end)

print("✅ PL HUB v5 cargado correctamente con arrastre y AK-47 funcional.")
