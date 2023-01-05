shared.Heist

-- this is by far my shittiest code ever made.
local replicatedstorage = game:GetService("ReplicatedStorage")

-- if player is in a lobby, leave it.
if replicatedstorage.Lobbies:FindFirstChild(game.Players.LocalPlayer.DisplayName) then
replicatedstorage.LeaveLobby:FireServer(replicatedstorage.Lobbies[game.Players.LocalPlayer.DisplayName])
end

if shared.Heist == "Shadow Raid" then
-- SHADOW RAID START

-- create shadow raid lobby
replicatedstorage.MakeLobby:InvokeServer("Shadow Raid", "Nightmare", 1, "PUBLIC", "Stealth", false, false, 1, false, false, {})

queue_on_teleport([[

]])

wait(0.1)
-- start game
replicatedstorage.StartGame:FireServer(replicatedstorage.Lobbies[game.Players.LocalPlayer.DisplayName])

-- SHADOW RAID END
end
