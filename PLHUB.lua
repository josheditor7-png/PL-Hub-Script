-- PL HUB vAK | Drag + Dark UI + Toolbox AK-47 loader
-- by ChatGPT for Josh
-- Nota: usa InsertService para intentar cargar modelos AK-47 del Creator Store/Toolbox

pcall(function()
	local plgui = game.Players.LocalPlayer:WaitForChild("PlayerGui")
	if plgui:FindFirstChild("PLHUB") then plgui.PLHUB:Destroy() end
end)

repeat task.wait() until game:IsLoaded() and game.Players.LocalPlayer and game.Players.LocalPlayer:FindFirstChild("PlayerGui")
local Players = game:GetService("Players")
local InsertService = game:GetService("InsertService")
local TweenService = game:GetService("TweenService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- Helper: try to load an asset id, return a Tool if found
local function tryLoadToolFromAsset(assetId)
	local ok, model = pcall(function() return InsertService:LoadAsset(assetId) end)
	if not ok or not model then return nil end
	-- Search for a Tool inside the model
	for _, obj in ipairs(model:GetDescendants()) do
		if obj:IsA("Tool") then
			-- detach the tool from the temporary model and return it
			obj.Parent = nil
			-- destroy remaining temporary container (model)
			pcall(function() model:Destroy() end)
			return obj
		end
	end
	-- If no Tool, maybe the model itself is a single model containing a Tool as direct child
	for _, child in ipairs(model:GetChildren()) do
		if child:IsA("Tool") then
			child.Parent = nil
			pcall(function() model:Destroy() end)
			return child
		end
	end
	-- nothing useful found
	pcall(function() model:Destroy() end)
	return nil
end

-- Lista de asset IDs plausibles de modelos "AK-47" encontrados en Creator Store / Toolbox.
-- El script intentará cada ID hasta encontrar una Tool válida.
local candidateAssetIds = {
	79255353,  -- (ejemplo: AK47 pages encontrados en Creator Store). :contentReference[oaicite:1]{index=1}
	72773560,
	329330697,
	688731098,
	13553295,
	432289870
}
-- UI: simple, oscuro y draggable por título (se concentra en Items -> AK-47)
local ScreenGui = Instance.new("ScreenGui", playerGui)
ScreenGui.Name = "PLHUB"
ScreenGui.ResetOnSpawn = false
ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.new(0, 520, 0, 420)
MainFrame.Position = UDim2.new(0.5, -260, 0.5, -210)
MainFrame.BackgroundColor3 = Color3.fromRGB(8,8,8)
MainFrame.Visible = false
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0,12)

local TitleBar = Instance.new("TextLabel", MainFrame)
TitleBar.Size = UDim2.new(1,0,0,40)
TitleBar.Position = UDim2.new(0,0,0,0)
TitleBar.BackgroundColor3 = Color3.fromRGB(18,18,18)
TitleBar.Text = "🔷 PL HUB"
TitleBar.Font = Enum.Font.GothamBold
TitleBar.TextSize = 20
TitleBar.TextColor3 = Color3.fromRGB(160,230,255)
Instance.new("UICorner", TitleBar).CornerRadius = UDim.new(0,12)

-- Make main draggable via TitleBar
do
	local dragging, dragInput, dragStart, startPos
	local UIS = game:GetService("UserInputService")
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
				if input.UserInputState == Enum.UserInputState.End then dragging = false end
			end)
		end
	end)
	TitleBar.InputChanged:Connect(function(input)
		dragInput = input
	end)
	UIS.InputChanged:Connect(function(input)
		if dragging and input == dragInput and input.UserInputType == Enum.UserInputType.MouseMovement then
			update(input)
		end
	end)
end

-- Side menu + content simplified (we only need Items section for este cambio)
local Side = Instance.new("Frame", MainFrame)
Side.Size = UDim2.new(0,140,1,-60)
Side.Position = UDim2.new(0,10,0,50)
Side.BackgroundColor3 = Color3.fromRGB(18,18,18)
Instance.new("UICorner", Side).CornerRadius = UDim.new(0,8)

local Content = Instance.new("Frame", MainFrame)
Content.Size = UDim2.new(1,-170,1,-70)
Content.Position = UDim2.new(0,160,0,50)
Content.BackgroundTransparency = 1

local ItemsBtn = Instance.new("TextButton", Side)
ItemsBtn.Size = UDim2.new(1,-20,0,36)
ItemsBtn.Position = UDim2.new(0,10,0,10)
ItemsBtn.Text = "Items"
ItemsBtn.Font = Enum.Font.GothamBold
ItemsBtn.TextColor3 = Color3.fromRGB(220,220,220)
ItemsBtn.BackgroundColor3 = Color3.fromRGB(28,28,28)
Instance.new("UICorner", ItemsBtn).CornerRadius = UDim.new(0,6)

local ItemsFrame = Instance.new("ScrollingFrame", Content)
ItemsFrame.Size = UDim2.new(1,0,1,0)
ItemsFrame.CanvasSize = UDim2.new(0,0,0,0)
ItemsFrame.ScrollBarThickness = 6
ItemsFrame.Visible = true
local UIList = Instance.new("UIListLayout", ItemsFrame)
UIList.Padding = UDim.new(0,8)

-- AK-47 option (button)
local akButton = Instance.new("TextButton", ItemsFrame)
akButton.Size = UDim2.new(1,-10,0,36)
akButton.Position = UDim2.new(0,5,0,10)
akButton.Text = "AK-47 (Toolbox)"
akButton.Font = Enum.Font.Gotham
akButton.TextSize = 16
akButton.TextColor3 = Color3.fromRGB(230,230,230)
akButton.BackgroundColor3 = Color3.fromRGB(28,28,28)
Instance.new("UICorner", akButton).CornerRadius = UDim.new(0,6)

local statusLabel = Instance.new("TextLabel", Content)
statusLabel.Size = UDim2.new(1,0,0,28)
statusLabel.Position = UDim2.new(0,0,1,-28)
statusLabel.BackgroundTransparency = 1
statusLabel.Text = ""
statusLabel.Font = Enum.Font.Gotham
statusLabel.TextSize = 14
statusLabel.TextColor3 = Color3.fromRGB(180,180,180)
statusLabel.TextXAlignment = Enum.TextXAlignment.Left

-- Function: attempt to fetch & equip AK tool from candidate asset ids
local function obtainAndEquipAK()
	statusLabel.Text = "Buscando AK-47 en Creator Store..."
	-- try local stores first (ReplicatedStorage / Workspace)
	local foundTool = nil
	if game.ReplicatedStorage:FindFirstChild("AK-47") and game.ReplicatedStorage["AK-47"]:IsA("Tool") then
		foundTool = game.ReplicatedStorage["AK-47"]:Clone()
	end
	if not foundTool and workspace:FindFirstChild("AK-47") and workspace["AK-47"]:IsA("Tool") then
		foundTool = workspace["AK-47"]:Clone()
	end
	if foundTool then
		foundTool.Parent = player.Backpack
		task.wait(0.2)
		pcall(function() player.Character.Humanoid:EquipTool(foundTool) end)
		statusLabel.Text = "AK-47 cargado desde almacenamiento local y equipado."
		return true
	end

	-- Try InsertService with candidate asset ids
	for _, aid in ipairs(candidateAssetIds) do
		statusLabel.Text = "Intentando cargar asset id "..tostring(aid).." ..."
		local ok, tool = pcall(tryLoadToolFromAsset, aid)
		if ok and tool then
			-- parent to backpack and equip
			tool.Parent = player.Backpack
			task.wait(0.25)
			pcall(function() player.Character.Humanoid:EquipTool(tool) end)
			statusLabel.Text = "AK-47 cargado (asset "..tostring(aid)..") y equipado."
			return true
		end
		task.wait(0.15)
	end

	-- If nothing found
	statusLabel.Text = "No se pudo cargar AK-47 desde los assets probados. Revisa permisos o availability."
	return false
end

akButton.MouseButton1Click:Connect(function()
	akButton.BackgroundColor3 = Color3.fromRGB(10,120,200)
	task.spawn(function()
		pcall(obtainAndEquipAK)
		TweenService:Create(akButton, TweenInfo.new(0.15), {BackgroundColor3 = Color3.fromRGB(28,28,28)}):Play()
	end)
end)

-- Open button (floating)
local OpenFloating = Instance.new("TextButton", playerGui)
OpenFloating.Text = "PLH"
OpenFloating.Size = UDim2.new(0,60,0,60)
OpenFloating.Position = UDim2.new(0.07,0,0.4,0)
OpenFloating.BackgroundColor3 = Color3.fromRGB(20,20,20)
OpenFloating.TextColor3 = Color3.fromRGB(160,230,255)
OpenFloating.Font = Enum.Font.GothamBold
OpenFloating.TextSize = 20
OpenFloating.AutoButtonColor = false
Instance.new("UICorner", OpenFloating).CornerRadius = UDim.new(1,0)
OpenFloating.MouseButton1Click:Connect(function()
	MainFrame.Visible = not MainFrame.Visible
end)

print("PL HUB (AK loader) cargado. Intenta 'Items -> AK-47'.")
