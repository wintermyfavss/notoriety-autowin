wait(4)
local replicatedstorage = game:GetService("ReplicatedStorage")

-- Leave lobby if already in one
if replicatedstorage.Lobbies:FindFirstChild(game.Players.LocalPlayer.DisplayName) then
    replicatedstorage.LeaveLobby:FireServer(replicatedstorage.Lobbies[game.Players.LocalPlayer.DisplayName])
end

local playerLevel = game.Players.LocalPlayer:GetAttribute("Level")
if playerLevel == 100 and shared.DenyIfMaxLevel == true then
    print("Player level is 100 and DenyIfMaxLevel is true. Lobby creation and start cancelled.")
else
    if shared.Heist == "Shadow Raid" then
        -- Create Shadow Raid lobby
        replicatedStorage.MakeLobby:InvokeServer(
            "Shadow Raid",      -- Heist
            "Nightmare",        -- Difficulty
            1,                  -- Contract Type
            "PUBLIC",           -- Lobby Type
            "Stealth",          -- Loud or Stealth
            false,              -- Contract Booster
            false,              -- Contract Modifier
            1,                  -- Preferred Player Count
            false,              -- Solo Contract
            false,              -- Rejoinable
            {}                  -- Friends Only
        )

        -- Queue on teleport and load Shadow Raid script
        if syn and syn.queue_on_teleport then
            syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/frel0/notoriety-autowin/main/heists/shadow-raid.lua'))()")
        elseif queue_on_teleport then
            queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/frel0/notoriety-autowin/main/heists/shadow-raid.lua'))()")
        end

        wait(0.15)

        -- Start game
        replicatedStorage.StartGame:FireServer(replicatedStorage.Lobbies[players.LocalPlayer.DisplayName])
    end
end
