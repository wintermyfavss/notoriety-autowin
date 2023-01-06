task.spawn(function()
	while task.wait() do
		for i,v in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
            if v.Name == 'MoneyBag' then
            v.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,10)
            end
        end
	end

	end)
task.spawn(function()

while task.wait(0.5) do
game:GetService("ReplicatedStorage").RS_Package.Remotes.ThrowBag:FireServer(Vector3.new(0.005740683991461992, -0.019172538071870804, -0.9997996687889099))
for i,v in pairs(game.Workspace.BigLoot:GetDescendants()) do
	if v:IsA("Part") then
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
	end
end
wait(0.2)
for i,v in pairs(workspace:GetDescendants()) do
			if v:IsA("ProximityPrompt") then
				fireproximityprompt(v)
			end
		end
wait(0.01)
game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").BagSecuredArea.FloorPart.Position)
end
end)

task.spawn(function()
wait(3.5)
for i,v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui.PregameFrame["button_playerReady"].MouseButton1Click)) do
   v.Function()
end
end)

task.spawn(function()
while task.wait() do
if game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui["frame_heistResults"].Visible then
wait(2.5)
game:GetService("TeleportService"):Teleport(21532277, game.Players.LocalPlayer)
end
end
end)
