print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local Remotes = game:GetService("ReplicatedStorage").RS_Package.Remotes 
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position

    -- **ลบโค้ด Instant Loot (ProximityPrompt HoldDuration = 0) และโค้ด Click Ready ที่ไม่เกี่ยวข้องกับการ Loot ออกไป**

    -- Auto-win code (Auto-Loot, Auto-Throw, Teleport)
    coroutine.wrap(function()
        
        -- *** ปรับเวลา Loot และ Throw ที่สำคัญ ***
        local LootDuration = 4 -- เวลาที่ใช้ Loot จริง ๆ (ลองเริ่มที่ 2.5 วินาที)
        local ThrowWaitTime = 1.0 -- เวลาให้เซิร์ฟเวอร์ประมวลผลการ Throw

        while true do 
            
            local lootFound = false
            
            -- ---------------------------------
            -- 1. AUTO-LOOT (Start -> Wait -> Complete)
            -- ---------------------------------

            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then

                    -- A. Teleport ไปที่ Loot Item
                    HRP.CFrame = CFrame.new(v.Position)
                    wait(0.1) 
                    
                    -- B. สั่งเริ่มปฏิสัมพันธ์ (Start Interaction)
                    print("Info: Starting Auto-Loot Interaction...")
                    Remotes.StartInteraction:FireServer(prompt)
                    
                    -- C. รอเวลา Loot (เลียนแบบการกดค้าง)
                    wait(LootDuration) 
                    
                    -- D. สั่งเสร็จสิ้นปฏิสัมพันธ์ (Complete Interaction)
                    Remotes.CompleteInteraction:FireServer(prompt)
                    
                    print("Info: Looting Complete. Should have bag now.")
                    lootFound = true
                    
                    -- ออกจากลูปหา Loot และไปขั้นตอน Securing
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
                wait(5) -- ถ้าหา Loot ไม่พบ ให้รอ 10 วินาทีก่อนเริ่มหาใหม่
            end
            
            wait(0.5)
        end
    end)()

    -- (ต้องนำส่วน Click the "ready" button และ If heist results appear, teleport back to lobby มาใส่ด้วย)

end

print("info 2")
