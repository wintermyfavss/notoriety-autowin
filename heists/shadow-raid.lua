print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local Remotes = game:GetService("ReplicatedStorage").RS_Package.Remotes
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position
    local Player = game:GetService("Players").LocalPlayer

    -- *************************************************************
    -- ** NEW: Interact Aura (Instant Loot) - ทำงานวนลูปตลอดเวลา **
    -- *************************************************************
    coroutine.wrap(function()
        print("Info: Interact Aura running...")
        while true do
            for i, v in pairs(game.Workspace:GetDescendants()) do
                if v:IsA("ProximityPrompt") then
                    local args = {
                        [1] = v
                    }
                    
                    -- สั่ง Start และ Complete ทันที (Instant Loot)
                    game:GetService("ReplicatedStorage").RS_Package.Remotes.StartInteraction:FireServer(unpack(args))
                    game:GetService("ReplicatedStorage").RS_Package.Remotes.CompleteInteraction:FireServer(unpack(args))
                end
            end
            -- หน่วงเวลาเล็กน้อยเพื่อให้การทำงานไม่ถี่จนเกินไป
            wait(0.05) 
        end
    end)()
    -- *************************************************************
    
    -- Auto-win code (จัดการ Teleport และ Auto-Throw)
    coroutine.wrap(function()
        local LootWaitTime = 5 
        local ThrowWaitTime = 1 

        while true do 
            
            -- ---------------------------------
            -- 1. TELEPORT TO LOOT ชิ้นถัดไป
            -- ---------------------------------

            local lootFound = false
            
            -- ค้นหาและ Teleport ไปยัง Loot Item ที่ยังมี Prompt (Interact Aura จะพยายาม Loot ให้แล้ว)
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then

                    -- A. Teleport ไปที่ Loot Item (เพื่อให้ Interact Aura ที่รันอยู่ใกล้ Prompt)
                    HRP.CFrame = CFrame.new(v.Position)
                    print("Info: Teleported to Loot position. Aura should be looting now.")
                    lootFound = true
                    
                    -- B. รอให้ Aura ทำงานและ Loot สำเร็จ
                    wait(LootWaitTime) 
                    
                    break 
                end
            end
            
            -- ---------------------------------
            -- 2. AUTO-THROW BAG (สันนิษฐานว่า Loot สำเร็จแล้ว)
            -- ---------------------------------

            if lootFound then 
                
                -- A. Teleport ไปยังพื้นที่ Secure Area (รถตู้)
                HRP.CFrame = CFrame.new(BagSecurePosition)
                wait(0.2)
                
                print("Info: Teleported to Van. Auto-Throwing Bag...")

                -- B. สั่ง ThrowBag ทันที
                Remotes.ThrowBag:FireServer(Vector3.new(0.005740683991461992, -0.019172538071870804, -0.9997996687889099))
                
                -- C. หน่วงเวลาเพื่อให้เซิร์ฟเวอร์ประมวลผลการ Throw
                wait(ThrowWaitTime) 
            end
            
            -- ---------------------------------
            -- 3. การควบคุมลูปหลัก
            -- ---------------------------------
            
            if not lootFound then
                wait(10)
            end
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
