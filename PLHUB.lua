--// ⚡ PL HUB v5 - con Boost + Jump (Hulk Jump)
-- By Josh 

local player = game.Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")

-- 🖥 GUI ROOT
local gui = Instance.new("ScreenGui", playerGui)
gui.Name = "PLHUB"

-- 🟢 Floating Button
local floatBtn = Instance.new("TextButton", gui)
floatBtn.Size = UDim2.new(0, 60, 0, 60)
floatBtn.Position = UDim2.new(0.08, 0, 0.7, 0)
floatBtn.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
floatBtn.Text = "PLH"
floatBtn.TextColor3 = Color3.fromRGB(0, 255, 180)
floatBtn.Font = Enum.Font.GothamBold
floatBtn.TextSize = 22
floatBtn.Active, floatBtn.Draggable = true, true
Instance.new("UICorner", floatBtn).CornerRadius = UDim.new(1, 0)
local floatStroke = Instance.new("UIStroke", floatBtn)
floatStroke.Color = Color3.fromRGB(0, 255, 180)

-- 🧱 Main Window
local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 600, 0, 380)
main.Position = UDim2.new(0.35, 0, 0.3, 0)
main.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
main.Visible = false
main.Active, main.Draggable = true, true
Instance.new("UICorner", main).CornerRadius = UDim.new(0, 14)
Instance.new("UIStroke", main).Color = Color3.fromRGB(0, 255, 200)

-- 🔹 Title Bar
local titleBar = Instance.new("Frame", main)
titleBar.Size = UDim2.new(1, 0, 0, 45)
titleBar.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", titleBar).CornerRadius = UDim.new(0, 14)

local title = Instance.new("TextLabel", titleBar)
title.Size = UDim2.new(1, 0, 1, 0)
title.BackgroundTransparency = 1
title.Text = "⚡ PL HUB"
title.TextColor3 = Color3.fromRGB(0, 255, 200)
title.TextSize = 22
title.Font = Enum.Font.GothamBold

-- 📜 Left Menu
local menu = Instance.new("Frame", main)
menu.Size = UDim2.new(0, 150, 1, -45)
menu.Position = UDim2.new(0, 0, 0, 45)
menu.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Instance.new("UICorner", menu).CornerRadius = UDim.new(0, 14)

-- 📂 Scrollable Content
local contentHolder = Instance.new("ScrollingFrame", main)
contentHolder.Size = UDim2.new(1, -170, 1, -60)
contentHolder.Position = UDim2.new(0, 160, 0, 50)
contentHolder.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
contentHolder.CanvasSize = UDim2.new(0, 0, 0, 0)
contentHolder.ScrollBarThickness = 6
contentHolder.AutomaticCanvasSize = Enum.AutomaticSize.Y
contentHolder.ScrollBarImageColor3 = Color3.fromRGB(0, 255, 200)
Instance.new("UICorner", contentHolder).CornerRadius = UDim.new(0, 14)

-- Utility: Clear content
local function clearContent()
	for _, v in pairs(contentHolder:GetChildren()) do
		if not v:IsA("UICorner") then v:Destroy() end
	end
end

-- Utility: Section title
local function sectionTitle(name)
	local lbl = Instance.new("TextLabel", contentHolder)
	lbl.Size = UDim2.new(1, -20, 0, 35)
	lbl.Position = UDim2.new(0, 10, 0, 5)
	lbl.BackgroundTransparency = 1
	lbl.Text = name
	lbl.TextColor3 = Color3.new(1,1,1)
	lbl.Font = Enum.Font.GothamBold
	lbl.TextSize = 20
	lbl.TextXAlignment = Enum.TextXAlignment.Left
end

-------------------------------------------------------
-- 🗺 TELEPORT SECTION
-------------------------------------------------------
local function openTeleports()
	clearContent()
	sectionTitle("TELEPORTS")

	local teleports = {
		{"Zona de armas", Vector3.new(-928.858,94.129,2049.145)},
		{"Zona Segura", Vector3.new(-56.212,11.099,1297.009)},
		{"Muralla", Vector3.new(825.557,125.840,2072.784)},
		{"Cafetería", Vector3.new(904.909,99.990,2269.678)},
		{"Celdas", Vector3.new(914.927,99.990,2458.348)},
		{"Yarda", Vector3.new(846.403,98.190,2545.063)},
		{"Techo de la cárcel", Vector3.new(931.791,118.990,2371.300)},
	}

	for i, info in ipairs(teleports) do
		local btn = Instance.new("TextButton", contentHolder)
		btn.Size = UDim2.new(1, -20, 0, 35)
		btn.Position = UDim2.new(0, 10, 0, 40 + (i - 1) * 45)
		btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		btn.Text = info[1]
		btn.TextColor3 = Color3.new(1,1,1)
		btn.TextSize = 18
		btn.Font = Enum.Font.GothamBold
		Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
		btn.MouseButton1Click:Connect(function()
			local hrp = player.Character and player.Character:FindFirstChild("HumanoidRootPart")
			if hrp then hrp.CFrame = CFrame.new(info[2]) end
		end)
	end
end

-------------------------------------------------------
-- 🎒 ITEMS SECTION (Mejorada)
-------------------------------------------------------
local function openItems()
	clearContent()
	sectionTitle("ITEMS")

	local akBtn = Instance.new("TextButton", contentHolder)
	akBtn.Size = UDim2.new(1, -20, 0, 35)
	akBtn.Position = UDim2.new(0, 10, 0, 45)
	akBtn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	akBtn.Text = "AK-47"
	akBtn.TextColor3 = Color3.new(1,1,1)
	akBtn.TextSize = 18
	akBtn.Font = Enum.Font.GothamBold
	Instance.new("UICorner", akBtn).CornerRadius = UDim.new(0,8)

	akBtn.MouseButton1Click:Connect(function()
		local char = player.Character or player.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")

		-- Guardar posición original
		local oldCFrame = hrp.CFrame

		-- Coordenadas del arma
		local akPos = Vector3.new(-918.259,96.928,2051.592)
		hrp.CFrame = CFrame.new(akPos)

		-- Esperar a que cargue el área
		task.wait(0.3)

		-- Detectar cambio de inventario
		local backpack = player:WaitForChild("Backpack")

		local function getTools()
			local tools = {}
			for _, t in pairs(backpack:GetChildren()) do
				if t:IsA("Tool") then
					table.insert(tools, t.Name)
				end
			end
			for _, t in pairs(char:GetChildren()) do
				if t:IsA("Tool") then
					table.insert(tools, t.Name)
				end
			end
			return tools
		end

		local before = getTools()
		local gotNewItem = false

		local function checkChange()
			local current = getTools()
			if #current > #before then
				gotNewItem = true
			end
		end

		local backpackConn = backpack.ChildAdded:Connect(checkChange)
		local charConn = char.ChildAdded:Connect(checkChange)

		repeat task.wait(0.1) until gotNewItem

		backpackConn:Disconnect()
		charConn:Disconnect()

		task.wait(0.2)
		hrp.CFrame = oldCFrame
	end)
end

-------------------------------------------------------
-- ⚙️ MISC SECTION (Base + NoClip + Boost + Jump)
-------------------------------------------------------
local function openMisc()
	clearContent()
	sectionTitle("MISC")

	local function makeButton(y, text)
		local b = Instance.new("TextButton", contentHolder)
		b.Size = UDim2.new(1, -20, 0, 35)
		b.Position = UDim2.new(0, 10, 0, y)
		b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		b.TextColor3 = Color3.new(1,1,1)
		b.TextSize = 18
		b.Font = Enum.Font.GothamBold
		b.Text = text
		Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
		return b
	end

	local BaseBtn = makeButton(45, "Base (OFF)")
	local baseEnabled, platform, conn = false, nil, nil
	local function createBase(pos)
		local p = Instance.new("Part")
		p.Anchored = true
		p.CanCollide = true
		p.Size = Vector3.new(12, 1, 12)
		p.Transparency = 0.5
		p.Color = Color3.fromRGB(0, 170, 255)
		p.Material = Enum.Material.ForceField
		p.CFrame = CFrame.new(pos)
		p.Parent = workspace
		return p
	end
	BaseBtn.MouseButton1Click:Connect(function()
		baseEnabled = not baseEnabled
		BaseBtn.Text = baseEnabled and "Base (ON)" or "Base (OFF)"
		if baseEnabled then
			local char = player.Character or player.CharacterAdded:Wait()
			local hrp = char:WaitForChild("HumanoidRootPart")
			if conn then conn:Disconnect() end
			conn = RunService.Heartbeat:Connect(function()
				if not baseEnabled then return end
				local under = hrp.Position - Vector3.new(0, 4, 0)
				if not platform then
					platform = createBase(under)
				else
					local dist = (platform.Position - under).Magnitude
					if dist > 5 then
						platform:Destroy()
						platform = createBase(under)
					else
						platform.Position = under
					end
				end
			end)
		else
			if conn then conn:Disconnect() end
			if platform then platform:Destroy() end
			platform = nil
		end
	end)

	local NoClipBtn = makeButton(95, "No Clip (OFF)")
	local noclipEnabled, noclipConn = false, nil
	NoClipBtn.MouseButton1Click:Connect(function()
		noclipEnabled = not noclipEnabled
		NoClipBtn.Text = noclipEnabled and "No Clip (ON)" or "No Clip (OFF)"
		if noclipEnabled then
			local char = player.Character or player.CharacterAdded:Wait()
			noclipConn = RunService.Stepped:Connect(function()
				for _, part in pairs(char:GetDescendants()) do
					if part:IsA("BasePart") and part.CanCollide then
						if not string.find(string.lower(part.Name), "floor") then
							part.CanCollide = false
						end
					end
				end
			end)
		else
			if noclipConn then noclipConn:Disconnect() end
			for _, part in pairs(player.Character:GetDescendants()) do
				if part:IsA("BasePart") then part.CanCollide = true end
			end
		end
	end)

	local BoostBtn = makeButton(145, "Boost (OFF)")
	local boostEnabled = false
	local normalSpeed, boostSpeed = 16, 100
	BoostBtn.MouseButton1Click:Connect(function()
		boostEnabled = not boostEnabled
		BoostBtn.Text = boostEnabled and "Boost (ON)" or "Boost (OFF)"
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.WalkSpeed = boostEnabled and boostSpeed or normalSpeed end
	end)

	local JumpBtn = makeButton(195, "Jump (OFF)")
	local jumpEnabled = false
	local normalJump, hulkJump = 50, 250
	JumpBtn.MouseButton1Click:Connect(function()
		jumpEnabled = not jumpEnabled
		JumpBtn.Text = jumpEnabled and "Jump (ON)" or "Jump (OFF)"
		local hum = player.Character and player.Character:FindFirstChildOfClass("Humanoid")
		if hum then hum.JumpPower = jumpEnabled and hulkJump or normalJump end
	end)
end

-------------------------------------------------------
-- 👁 VISUALS SECTION (NEW)
-------------------------------------------------------
local function openVisuals()
	clearContent()
	sectionTitle("VISUALS")
end

-------------------------------------------------------
-- MENU BUTTONS
-------------------------------------------------------
local sections = {
	{"Teleports", openTeleports},
	{"Items", openItems},
	{"Misc", openMisc},
	{"Visuals", openVisuals},
}

for i, sec in ipairs(sections) do
	local btn = Instance.new("TextButton", menu)
	btn.Size = UDim2.new(1, -20, 0, 40)
	btn.Position = UDim2.new(0, 10, 0, (i - 1) * 50 + 15)
	btn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	btn.TextColor3 = Color3.fromRGB(200, 200, 200)
	btn.TextSize = 18
	btn.Font = Enum.Font.GothamBold
	btn.Text = sec[1]
	Instance.new("UICorner", btn).CornerRadius = UDim.new(0, 8)
	btn.MouseButton1Click:Connect(function()
		for _, b in pairs(menu:GetChildren()) do
			if b:IsA("TextButton") then
				b.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				b.TextColor3 = Color3.fromRGB(200, 200, 200)
			end
		end
		btn.BackgroundColor3 = Color3.fromRGB(0, 255, 200)
		btn.TextColor3 = Color3.fromRGB(0, 0, 0)
		sec[2]()
	end)
end

-------------------------------------------------------
-- OPEN/CLOSE ANIMATION
-------------------------------------------------------
local open = false
floatBtn.MouseButton1Click:Connect(function()
	open = not open
	if open then
		main.Visible = true
		main.Size = UDim2.new(0, 0, 0, 0)
		TweenService:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 600, 0, 380)}):Play()
	else
		TweenService:Create(main, TweenInfo.new(0.3), {Size = UDim2.new(0, 0, 0, 0)}):Play()
		task.wait(0.3)
		main.Visible = false
	end
end)

