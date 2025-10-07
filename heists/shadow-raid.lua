print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position

    -- Auto-win code
    coroutine.wrap(function()
        -- *** เปลี่ยนเป็น Infinite Loop และควบคุมการรอเวลาด้วยตัวเอง ***
        while true do 

            -- ---------------------------------
            -- 1. TELEPORT TO LOOT (MANUAL LOOT)
            -- ---------------------------------

            local lootTeleported = false

            -- Find and teleport to the first unlooted item in BigLoot folder
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then

                    -- A. Teleport ไปที่ Loot Item
                    HRP.CFrame = CFrame.new(v.Position)
                    print("Info: Teleported to Loot. Please manually steal the item.")
                    lootTeleported = true
                    
                    -- **B. รอให้ผู้เล่น Loot ด้วยมือจนกว่าจะเสร็จ (Looting Bar เต็ม)**
                    -- โค้ดจะหยุดอยู่ตรงนี้ 5 วินาที ให้คุณมีเวลาเริ่มกด Loot
                    wait(5) 
                    
                    -- **เราจะไม่ break!** เราต้องรอจนกว่าจะถือกระเป๋า ก่อนจะทำขั้นตอนต่อไป
                end
            end
            
            -- หาก Teleport ไปหา Loot ได้สำเร็จ (และคุณได้เริ่ม Loot แล้ว)
            if lootTeleported then

                -- C. รอจนกว่าผู้เล่นจะถือกระเป๋า (Looting complete)
                -- สคริปต์จะหยุดอยู่ตรงนี้จนกว่าจะมี Tool ในตัวละคร (คือถือกระเป๋าแล้ว)
                repeat wait() 
                    -- ตรวจสอบทุกๆ 0.1 วินาที
                until HRP.Parent:FindFirstChildOfClass("Tool") or not HRP.Parent or not HRP.Parent.Parent
                
                print("Info: Looting complete. Securing bag...")
            end
            
            -- ---------------------------------
            -- 2. TELEPORT TO SECURE AREA (MANUAL THROW)
            -- ---------------------------------

            -- หากผู้เล่นถือกระเป๋า ให้วาร์ปไปที่รถตู้
            if HRP.Parent:FindFirstChildOfClass("Tool") then

                -- A. Teleport ไปยังพื้นที่ Secure Area (รถตู้)
                HRP.CFrame = CFrame.new(BagSecurePosition)
                wait(0.2)

                print("Info: Teleported to Van. Please manually throw the bag.")
                
                -- B. ให้เวลาผู้เล่นในการโยนกระเป๋า
                wait(2) 
            end

            -- *** รอเวลาที่ยาวนานก่อนที่จะเริ่มลูป Loot ชิ้นถัดไป ***
            -- (เพื่อให้มั่นใจว่าไม่มีการ Teleport แทรกในระหว่าง Loot ด้วยมือ)
            wait(15) 
        end
    end)()
    
    -- ... (โค้ด Click Ready และ Teleport Back to Lobby ยังคงอยู่)
    
end

print("info 2")
