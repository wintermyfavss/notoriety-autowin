print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position
    
    -- ลบ Coroutine เก่าที่พยายาม Secure bags โดยการเปลี่ยน CFrame

    -- Auto-win code
    coroutine.wrap(function()
        while wait(0.5) do
            
            -- ---------------------------------
            -- 1. TELEPORT TO LOOT (MANUAL LOOT)
            -- ---------------------------------

            local lootTeleported = false
            
            -- Find and teleport to the first unlooted item in BigLoot folder
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                -- ตรวจสอบว่ามี Prompt อยู่หรือไม่ (แสดงว่ายังไม่ได้ Loot)
                if v:IsA("Part") and prompt then
                    
                    -- A. Teleport ไปที่ Loot Item
                    HRP.CFrame = CFrame.new(v.Position)
                    print("Info: Teleported to Loot. Please manually steal the item.")
                    lootTeleported = true
                    break -- Teleport ไปยังชิ้นแรกแล้วออกไปรอ
                end
            end
            
            -- หาก Teleport ไปหา Loot ได้สำเร็จ ให้รอการ Loot ด้วยมือของผู้เล่น
            if lootTeleported then
                
                -- B. รอจนกว่าผู้เล่นจะถือกระเป๋า (หรือ Loot สำเร็จ)
                -- เราจะใช้การตรวจจับง่ายๆ คือรอให้ผู้เล่นมี Tool (กระเป๋า) ในตัวละคร
                -- (Note: หากเกมมีวิธีตรวจจับการถือกระเป๋าที่ดีกว่านี้ ควรใช้ตัวนั้น)
                repeat wait() 
                    -- วนลูปจนกว่าผู้เล่นจะถืออะไรบางอย่างในมือ หรือจนกว่าจะออกจาก Heist
                until HRP.Parent:FindFirstChildOfClass("Tool") or not HRP.Parent or not HRP.Parent.Parent
                
                print("Info: Looting complete. Securing bag...")
            end
            
            -- ---------------------------------
            -- 2. TELEPORT TO SECURE AREA (MANUAL THROW)
            -- ---------------------------------
            
            -- หากผู้เล่นถือกระเป๋า (หรือ Loot เสร็จแล้ว) ให้วาร์ปไปที่รถตู้
            if HRP.Parent:FindFirstChildOfClass("Tool") then
                
                -- A. Teleport ไปยังพื้นที่ Secure Area (รถตู้)
                HRP.CFrame = CFrame.new(BagSecurePosition)
                wait(0.2)
                
                print("Info: Teleported to Van. Please manually throw the bag.")
            end
            
            wait(0.5) -- รอช่วงเวลาสั้นๆ ก่อนตรวจสอบ Loot ชิ้นต่อไป
        end
    end)()

    -- Click the "ready" button (ยังคงอยู่)
    coroutine.wrap(function()
        while wait() do
            if game:GetService("ReplicatedStorage")["RS_Package"].ReplicatedGameStatus.BagsSecured.Value > 10 then
                for _, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui.PregameFrame["button_playerReady"].MouseButton1Click)) do
                    v.Function()
                end
            end
        end
    end)()

    -- If heist results appear, teleport back to lobby (ยังคงอยู่)
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
