print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position
    local Player = game:GetService("Players").LocalPlayer

    -- Auto-win code (จัดการ Loot และ Secure ตามลำดับ Inventory)
    coroutine.wrap(function()
        while true do 

            -- ---------------------------------
            -- 1. SECURE กระเป๋าที่ถืออยู่ก่อน (ความสำคัญสูงสุด)
            -- ---------------------------------
            
            -- ***ตรวจสอบว่าผู้เล่นถือ 'LootBag' อยู่หรือไม่***
            if HRP.Parent:FindFirstChild("MoneyBag") then
                
                -- A. Teleport ไปยังพื้นที่ Secure Area (รถตู้)
                HRP.CFrame = CFrame.new(BagSecurePosition)
                print("Info: Teleported to Van. Please manually throw the bag.")
                wait(0.2)
                
                -- B. รอจนกว่ากระเป๋าจะถูกโยนออกไป
                repeat wait() 
                    -- วนลูปจนกว่าผู้เล่นจะไม่มี 'LootBag' ในมือแล้ว
                until not HRP.Parent:FindFirstChild("MoneyBag") or not HRP.Parent or not HRP.Parent.Parent
                
                print("Info: Bag Secured. Looking for next Loot...")
                
                -- หน่วงเวลาเล็กน้อยก่อนไปหา Loot ใหม่
                wait(1) 
            end
            
            -- ---------------------------------
            -- 2. TELEPORT TO LOOT ชิ้นถัดไป
            -- ---------------------------------

            local lootFound = false
            
            -- ค้นหาและ Teleport ไปยัง Loot Item ที่ยังไม่ถูก Loot
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                -- ตรวจสอบว่ามี Prompt อยู่หรือไม่ (แสดงว่ายัง Loot ไม่เสร็จ)
                if v:IsA("Part") and prompt then

                    -- A. Teleport ไปที่ Loot Item
                    HRP.CFrame = CFrame.new(v.Position)
                    print("Info: Teleported to Loot. Please manually steal the item.")
                    lootFound = true
                    
                    -- B. รอให้ผู้เล่นมีเวลา Loot ด้วยมือ
                    wait(4) 
                    
                    break -- วาร์ปไปที่ชิ้นแรกแล้วออกจากลูปหา Loot
                end
            end
            
            -- ---------------------------------
            -- 3. การควบคุมลูปหลัก
            -- ---------------------------------
            
            if not lootFound then
                wait(5)
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
