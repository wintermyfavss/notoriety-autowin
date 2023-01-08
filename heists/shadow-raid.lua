-- Secure bags automatically
task.spawn(function()
	while task.wait() do
		for i,v in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
            if v.Name == 'MoneyBag' then
            v.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,10)
            end
        end
	end
end)

-- Auto-win code
task.spawn(function()
while task.wait(0.5) do
    -- tp to bags
game:GetService("ReplicatedStorage").RS_Package.Remotes.ThrowBag:FireServer(Vector3.new(0.005740683991461992, -0.019172538071870804, -0.9997996687889099))
    for i,v in pairs(game.Workspace.BigLoot:GetDescendants()) do
        if v:IsA("Part") then
        game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
    end
end

wait(0.2)
  -- fire proximity prompt
for i,v in pairs(workspace:GetDescendants()) do
	if v:IsA("ProximityPrompt") then
		fireproximityprompt(v)
	end
end

wait(0.01)
-- tp to secure area
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").BagSecuredArea.FloorPart.Position)
end
end)

-- call mousebutton1click function
task.spawn(function()
while task.wait() do
if (game:GetService("ReplicatedStorage")["RS_Package"].ReplicatedGameStatus.BagsSecured.Value > 10) then
    for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui.PregameFrame["button_playerReady"].MouseButton1Click)) do
       v.Function()
    end
 end
end
end)

-- if heist results = teleport back to lobby.
task.spawn(function()
    while task.wait() do
        if game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui["frame_heistResults"].Visible then
        wait(2.5)
        game:GetService("TeleportService"):Teleport(21532277, game.Players.LocalPlayer)
    end
end
end)

-- Stats menu
task.spawn(function()
    local ScreenGui = Instance.new("ScreenGui")
    local Frame = Instance.new("Frame")
    local title = Instance.new("TextLabel")
    local cashtitle = Instance.new("TextLabel")
    local cashvalue = Instance.new("TextLabel")
    local xptitle = Instance.new("TextLabel")
    local xpvalue = Instance.new("TextLabel")
    
    ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")
    ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    
    Frame.Parent = ScreenGui
    Frame.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
    Frame.BorderColor3 = Color3.fromRGB(0, 102, 255)
    Frame.LayoutOrder = math.huge
    Frame.Position = UDim2.new(0, 25, 0.5, -60)
    Frame.Size = UDim2.new(0, 174, 0, 120)
    Frame.ZIndex = math.huge
    
    title.Name = "title"
    title.Parent = Frame
    title.BackgroundColor3 = Color3.fromRGB(0, 98, 255)
    title.BorderSizePixel = 0
    title.Size = UDim2.new(0, 174, 0, 19)
    title.Font = Enum.Font.RobotoMono
    title.Text = "Stats"
    title.TextColor3 = Color3.fromRGB(255, 255, 255)
    title.TextSize = 14.000
    title.TextStrokeTransparency = 0.000
    
    cashtitle.Name = "cashtitle"
    cashtitle.Parent = Frame
    cashtitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    cashtitle.BackgroundTransparency = 0.950
    cashtitle.Position = UDim2.new(0.0574712642, 0, 0.24166666, 0)
    cashtitle.Size = UDim2.new(0, 156, 0, 13)
    cashtitle.Font = Enum.Font.RobotoMono
    cashtitle.Text = "Cash"
    cashtitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    cashtitle.TextSize = 14.000
    cashtitle.TextStrokeTransparency = 0.000
    cashtitle.TextWrapped = true
    
    cashvalue.Name = "cashvalue"
    cashvalue.Parent = Frame
    cashvalue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    cashvalue.BackgroundTransparency = 1.000
    cashvalue.Position = UDim2.new(0.0574712642, 0, 0.400000006, 0)
    cashvalue.Size = UDim2.new(0, 156, 0, 11)
    cashvalue.Font = Enum.Font.RobotoMono
    cashvalue.TextColor3 = Color3.fromRGB(255, 255, 255)
    cashvalue.TextSize = 14.000
    cashvalue.TextStrokeTransparency = 0.000
    cashvalue.TextWrapped = true
    task.spawn(function()
        while task.wait() do
        for i,v in pairs(game.ReplicatedStorage.PlayerData:GetDescendants()) do
            if v.Name == "Cash" then -- im so stupd ipelase forgive me for making such trash code because the first one didnt work properly :pray: :man_tone5:
               cashvalue.Text = v.Value
            end
        end
    end
    end)
    
    xptitle.Name = "xptitle"
    xptitle.Parent = Frame
    xptitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    xptitle.BackgroundTransparency = 0.950
    xptitle.Position = UDim2.new(0.0574712642, 0, 0.558333337, 0)
    xptitle.Size = UDim2.new(0, 156, 0, 13)
    xptitle.Font = Enum.Font.RobotoMono
    xptitle.Text = "Level"
    xptitle.TextColor3 = Color3.fromRGB(255, 255, 255)
    xptitle.TextSize = 14.000
    xptitle.TextStrokeTransparency = 0.000
    xptitle.TextWrapped = true
    
    xpvalue.Name = "xpvalue"
    xpvalue.Parent = Frame
    xpvalue.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    xpvalue.BackgroundTransparency = 1.000
    xpvalue.Position = UDim2.new(0.0574712642, 0, 0.716666639, 0)
    xpvalue.Size = UDim2.new(0, 156, 0, 11)
    xpvalue.Font = Enum.Font.RobotoMono
    xpvalue.TextColor3 = Color3.fromRGB(255, 255, 255)
    xpvalue.TextSize = 14.000
    xpvalue.TextStrokeTransparency = 0.000
    xpvalue.TextWrapped = true
    while task.wait() do
        for i,v in pairs(game.ReplicatedStorage.PlayerData:GetDescendants()) do
            if v.Name == "Level" then
               xpvalue.Text = v.Value
            end
        end
    end
end)
