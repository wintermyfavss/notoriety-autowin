print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local Remotes = game:GetService("ReplicatedStorage").RS_Package.Remotes
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position
    local Player = game:GetService("Players").LocalPlayer

    -- Auto-win code (จัดการ Loot และ Auto-Throw ตามจังหวะเวลา)
    coroutine.wrap(function()
        -- กำหนดเวลา Looting และ Securing
        local LootWaitTime = 4 -- **หน่วงเวลา 4 วินาทีตามที่คุณต้องการ**
        local ThrowWaitTime = 1 -- เวลาหน่วงเพื่อให้เซิร์ฟเวอร์ประมวลผลการ Throw

        while true do 
            
            local lootFound = false
            
            -- ---------------------------------
            -- 1. QUICK & DIRTY TELEPORT TO LOOT
            -- ---------------------------------
            
            -- ค้นหาทุกอย่างใน BigLoot และวาร์ปไปที่ทุกชิ้นส่วนทันที (Quick Teleport)
            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                
                if v:IsA("Part") then

                    -- A. Teleport ไปที่ Loot Item ทุกชิ้น
                    HRP.CFrame = CFrame.new(v.Position)
                    print("Info: Quick-Teleported to Loot position. Waiting 4s...")
                    
                    -- B. หน่วงเวลา 4 วินาที (สมมติว่า Loot สำเร็จแล้ว/กำลังถือกระเป๋า)
                    wait(LootWaitTime) 
                    
                    lootFound = true
                    
                    -- ---------------------------------
                    -- 2. AUTO-THROW BAG (ทำทันทีหลังรอ 4 วินาที)
                    -- ---------------------------------
                    
                    -- A. Teleport ไปยังพื้นที่ Secure Area (รถตู้)
                    HRP.CFrame = CFrame.new(BagSecurePosition)
                    wait(0.2)
                    
                    print("Info: Teleported to Van. Auto-Throwing Bag...")

                    -- B. สั่ง ThrowBag ทันที
                    Remotes.ThrowBag:FireServer(Vector3.new(0.005740683991461992, -0.019172538071870804, -0.9997996687889099))
                    
                    -- C. หน่วงเวลาเพื่อให้เซิร์ฟเวอร์ประมวลผลการ Throw
                    wait(ThrowWaitTime) 
                end
            end
            
            -- ---------------------------------
            -- 3. การควบคุมลูปหลัก
            -- ---------------------------------
            
            if not lootFound then
                wait(10) -- ถ้าหา Loot ไม่พบ ให้รอ 10 วินาทีก่อนเริ่มหาใหม่
            else
                -- ถ้ามีการ Loot เกิดขึ้น ให้หน่วงเวลาเล็กน้อยก่อนเริ่มลูปใหม่ทั้งหมด
                wait(0.5)
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
