print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local Remotes = game:GetService("ReplicatedStorage").RS_Package.Remotes -- เพิ่ม Remotes เข้ามา
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position
    local Player = game:GetService("Players").LocalPlayer

    -- Auto-win code (จัดการ Loot และ Auto-Throw ตามจังหวะเวลา)
    coroutine.wrap(function()
        -- กำหนดเวลา Looting และ Securing ด้วยมือ (สามารถปรับได้ตามความเหมาะสม)
        local LootWaitTime = 4 -- เวลาให้ผู้เล่น Loot ด้วยมือ
        local ThrowWaitTime = 1 -- เวลาหน่วงเพื่อให้เซิร์ฟเวอร์ประมวลผลการ Throw

        while true do 
            
            -- ---------------------------------
            -- 1. TELEPORT TO LOOT ชิ้นถัดไป
            -- ---------------------------------

            local lootFound = false
            
            -- ค้นหาและ Teleport ไปยัง Loot Item ที่ยังไม่ถูก Loot
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then

                    -- A. Teleport ไปที่ Loot Item
                    HRP.CFrame = CFrame.new(v.Position)
                    print("Info: Teleported to Loot. Please manually steal the item.")
                    lootFound = true
                    
                    -- B. รอให้ผู้เล่นมีเวลา Loot ด้วยมือ (Looting Bar เต็ม)
                    wait(LootWaitTime) 
                    
                    break -- วาร์ปไปที่ชิ้นแรกแล้วออกจากลูปหา Loot
                end
            end
            
            -- ---------------------------------
            -- 2. AUTO-THROW BAG (สันนิษฐานว่า Loot สำเร็จแล้ว)
            -- ---------------------------------

            if lootFound then 
                -- หากมีการวาร์ปไป Loot ในขั้นตอนที่ 1 (สันนิษฐานว่า Loot สำเร็จแล้ว)
                
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
                wait(10) -- ถ้าหา Loot ไม่พบ ให้รอ 10 วินาทีก่อนเริ่มหาใหม่
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
