print("info 1")

if game:IsLoaded() then
    -- Secure bags automatically
    coroutine.wrap(function()
        while wait() do
            for _, bag in pairs(game:GetService("Workspace").Bags:GetDescendants()) do
                if bag.Name == 'MoneyBag' then
                    bag.CFrame = game:GetService("Workspace").BagSecuredArea.FloorPart.CFrame * CFrame.new(0,0,10)
                end
            end
        end
    end)()

    -- Auto-win code
    coroutine.wrap(function()
        while wait(0.5) do
            -- Teleport to bags
            game:GetService("ReplicatedStorage").RS_Package.Remotes.ThrowBag:FireServer(Vector3.new(0.005740683991461992, -0.019172538071870804, -0.9997996687889099))

            -- Move to big loot
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                if v:IsA("Part") then
                    game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                end
            end

            wait(0.2)

            -- Fire proximity prompt
            for _, v in pairs(workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    fireproximityprompt(v)
                end
            end

            wait(0.01)

            -- Teleport to secure area
            game:GetService("Players").LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(game:GetService("Workspace").BagSecuredArea.FloorPart.Position)
        end
    end)()

    -- Click the "ready" button
    coroutine.wrap(function()
        while wait() do
            if game:GetService("ReplicatedStorage")["RS_Package"].ReplicatedGameStatus.BagsSecured.Value > 10 then
                for _, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui.PregameFrame["button_playerReady"].MouseButton1Click)) do
                    v.Function()
                end
            end
        end
    end)()

    -- If heist results appear, teleport back to lobby
    coroutine.wrap(function()
        while wait() do
            if game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui["frame_heistResults"].Visible then
                wait(2.5)
                game:GetService("TeleportService"):Teleport(21532277, game.Players.LocalPlayer)
            end
        end
    end)()
end

print("info 2")
