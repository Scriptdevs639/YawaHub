-- Wait for the player's GUI to be available
local PlayerGui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- Remove any old versions of this GUI to prevent duplicates
if PlayerGui:FindFirstChild("ThanderTeleporter") then -- <-- RENAMED
	PlayerGui.ThanderTeleporter:Destroy() -- <-- RENAMED
end

-- Create the main ScreenGui to hold all elements
local ThanderTeleporterGui = Instance.new("ScreenGui") -- <-- RENAMED
ThanderTeleporterGui.Name = "ThanderTeleporter" -- <-- RENAMED
ThanderTeleporterGui.ResetOnSpawn = false
ThanderTeleporterGui.Parent = PlayerGui

-- Create the main frame (the window)
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 320, 0, 130)
MainFrame.Position = UDim2.new(0.5, -160, 0.5, -65)
MainFrame.BackgroundColor3 = Color3.fromRGB(35, 38, 41)
MainFrame.BorderColor3 = Color3.fromRGB(80, 80, 80)
MainFrame.Draggable = true
MainFrame.Active = true
MainFrame.Parent = ThanderTeleporterGui -- <-- RENAMED

-- Create the title label
local TitleLabel = Instance.new("TextLabel")
TitleLabel.Name = "TitleLabel"
TitleLabel.Size = UDim2.new(1, 0, 0, 30)
TitleLabel.BackgroundColor3 = Color3.fromRGB(25, 28, 31)
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Font = Enum.Font.SourceSansBold
TitleLabel.TextSize = 16
TitleLabel.Text = "Thander Teleporter" -- <-- RENAMED
TitleLabel.Parent = MainFrame

-- Create the minimize button
local MinimizeButton = Instance.new("TextButton")
MinimizeButton.Name = "MinimizeButton"
MinimizeButton.Size = UDim2.new(0, 25, 0, 20)
MinimizeButton.Position = UDim2.new(1, -30, 0, 5) -- Positioned in the top-right
MinimizeButton.BackgroundColor3 = Color3.fromRGB(25, 28, 31) -- Match title bar
MinimizeButton.BorderColor3 = Color3.fromRGB(80, 80, 80)
MinimizeButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MinimizeButton.Font = Enum.Font.SourceSansBold
MinimizeButton.TextSize = 20
MinimizeButton.Text = "—" -- Em-dash for minimize symbol
MinimizeButton.Parent = MainFrame

-- Create the input box for the username
local UsernameInput = Instance.new("TextBox")
UsernameInput.Name = "UsernameInput"
UsernameInput.Size = UDim2.new(1, -20, 0, 30)
UsernameInput.Position = UDim2.new(0.5, -150, 0, 40)
UsernameInput.BackgroundColor3 = Color3.fromRGB(55, 58, 61)
UsernameInput.TextColor3 = Color3.fromRGB(225, 225, 225)
UsernameInput.PlaceholderText = "Enter username..."
UsernameInput.Font = Enum.Font.SourceSans
UsernameInput.TextSize = 14
UsernameInput.ClearTextOnFocus = false
UsernameInput.Parent = MainFrame

-- Create the button to initiate the teleport
local TeleportButton = Instance.new("TextButton")
TeleportButton.Name = "TeleportButton"
TeleportButton.Size = UDim2.new(1, -20, 0, 35)
TeleportButton.Position = UDim2.new(0.5, -150, 0, 80)
TeleportButton.BackgroundColor3 = Color3.fromRGB(80, 120, 255)
TeleportButton.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleportButton.Font = Enum.Font.SourceSansBold
TeleportButton.TextSize = 16
TeleportButton.Text = "GO"
TeleportButton.Parent = MainFrame

-- Minimize functionality
local isMinimized = false
local originalSize = MainFrame.Size

local function toggleMinimize()
	isMinimized = not isMinimized -- Flips the value (true to false, false to true)
	
	if isMinimized then
		-- MINIMIZE: Shrink the frame and hide the content
		MainFrame.Size = UDim2.new(0, 320, 0, 30) -- Height of the title bar
		UsernameInput.Visible = false
		TeleportButton.Visible = false
		MinimizeButton.Text = "□" -- Restore symbol
	else
		-- RESTORE: Return to original size and show content
		MainFrame.Size = originalSize
		UsernameInput.Visible = true
		TeleportButton.Visible = true
		MinimizeButton.Text = "—" -- Minimize symbol
	end
end

-- Connect the function to the minimize button
MinimizeButton.MouseButton1Click:Connect(toggleMinimize)

-- The function that handles the teleport logic
local function teleportToPlayer()
	local localPlayer = game:GetService("Players").LocalPlayer
	local targetUsername = UsernameInput.Text

	-- Stop if the username is empty
	if not targetUsername or targetUsername == "" then
		return
	end

	local targetPlayer = game:GetService("Players"):FindFirstChild(targetUsername)

	-- Check if both you and the target are valid and have characters
	if localPlayer and localPlayer.Character and targetPlayer and targetPlayer.Character and targetPlayer.Character:FindFirstChild("HumanoidRootPart") then
		local targetPosition = targetPlayer.Character.HumanoidRootPart.Position
		-- Move your character to the target's position
		localPlayer.Character:MoveTo(targetPosition)
	else
		-- This message will appear in your executor's console if it fails
		warn("Player not found or their character hasn't loaded: " .. targetUsername)
	end
end

-- Connect the function to the button click
TeleportButton.MouseButton1Click:Connect(teleportToPlayer)
