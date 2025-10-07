print("info 1")
wait(4) -- things might get broken if this aint here.

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local Remotes = game:GetService("ReplicatedStorage").RS_Package.Remotes
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position

    -- **ลบ** Coroutine เก่าที่พยายาม Secure bags โดยการเปลี่ยน CFrame (วิธีเก่าที่ถูก Patched)
    
    -- Auto-win code (รวม Looting และ Securing ไว้ใน Coroutine เดียวกัน)
    coroutine.wrap(function()
        while wait(0.5) do
            
            -- ---------------------------------
            -- 1. LOOT (STEAL) ALL ITEMS
            -- ---------------------------------

            -- ค้นหาและ Loot ไอเทมทั้งหมดใน BigLoot folder
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then
                    
                    -- A. Teleport ไปที่ Loot Item เพื่อเริ่ม Interaction
                    HRP.CFrame = CFrame.new(v.Position)
                    wait(0.1)

                    -- B. เริ่มการ Loot (Start Interaction)
                    Remotes.StartInteraction:FireServer(prompt)

                    -- C. Bypass Loot Time (ลองใช้ 0.5 วินาที)
                    wait(0.5) 

                    -- D. เสร็จสิ้นการ Loot (Complete Interaction)
                    Remotes.CompleteInteraction:FireServer(prompt)
                    
                    -- ตอนนี้ผู้เล่นควรจะถือกระเป๋าแล้ว
                end
            end
            
            -- ---------------------------------
            -- 2. SECURE ALL BAGS (THROW)
            -- ---------------------------------
            
            -- A. Teleport ไปยังพื้นที่ Secure Area (รถตู้)
            HRP.CFrame = CFrame.new(BagSecurePosition)
            wait(0.2)

            -- B. Fire ThrowBag (Securing)
            -- ใช้ Remote Event เก่าที่ถูกย้ายมาไว้ที่นี่เพื่อโยนกระเป๋าที่ถืออยู่
            game:GetService("ReplicatedStorage").RS_Package.Remotes.ThrowBag:FireServer(Vector3.new(0.005740683991461992, -0.019172538071870804, -0.9997996687889099))
            
            wait(0.2)
        end
    end)()

    -- Click the "ready" button (ส่วนนี้ยังทำงานได้ดี)
    coroutine.wrap(function()
        while wait() do
            if game:GetService("ReplicatedStorage")["RS_Package"].ReplicatedGameStatus.BagsSecured.Value > 10 then
                for _, v in pairs(getconnections(game:GetService("Players").LocalPlayer.PlayerGui["SG_Package"].MainGui.PregameFrame["button_playerReady"].MouseButton1Click)) do
                    v.Function()
                end
            end
        end
    end)()

    -- If heist results appear, teleport back to lobby (ส่วนนี้ยังทำงานได้ดี)
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
