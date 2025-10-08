print("info 1")
wait(4)

if game:IsLoaded() then
    local Players = game:GetService("Players")
    local Player = Players.LocalPlayer
    local ReplicatedStorage = game:GetService("ReplicatedStorage")
    local Workspace = game:GetService("Workspace")
    local Remotes = ReplicatedStorage.RS_Package.Remotes -- เพิ่ม Remotes เข้ามา

    -- ตรวจสอบและรอการโหลดของตัวละครและ HumanoidRootPart
    local character = Player.Character or Player.CharacterAdded:Wait()
    local HRP = character:WaitForChild("HumanoidRootPart")
    
    local BagSecurePosition = Workspace.BagSecuredArea.FloorPart.Position
    
    
    --------------------------------------------------------------------------------
    -- A. ฟังก์ชัน AUTO-INTERACT / AUTO-LOOT (ใช้แทนการ Loot ด้วยมือ)
    --------------------------------------------------------------------------------
    
    local function AutoInteract(promptInstance)
        -- จำลองการกดปุ่มค้างตามระยะเวลาที่กำหนดใน ProximityPrompt
        if promptInstance and promptInstance:IsA("ProximityPrompt") then
            
            -- ตรวจสอบเงื่อนไขเพิ่มเติม (ถ้ามี) ก่อนเริ่ม Interac
            
            promptInstance:InputHoldBegin()
            task.wait(promptInstance.HoldDuration) -- หน่วงเวลาตามระยะการกดค้างจริง
            promptInstance:InputHoldEnd()
            
            return true
        end
        return false
    end


    -- Auto-win code (จัดการ Loot และ Auto-Throw ตามจังหวะเวลา)
    coroutine.wrap(function()
        -- กำหนดเวลาสำหรับ Throw
        local ThrowWaitTime = 2 -- เวลาหน่วงเพื่อให้เซิร์ฟเวอร์ประมวลผลการ Throw

        while true do 
            
            -- ---------------------------------
            -- 1. TELEPORT และ AUTO-LOOT ชิ้นถัดไป
            -- ---------------------------------

            local lootFound = false
            
            -- ค้นหาและ Teleport ไปยัง Loot Item ที่ยังไม่ถูก Loot
            for _, v in pairs(Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then

                    -- A. Teleport ไปที่ Loot Item
                    HRP.CFrame = CFrame.new(v.Position)
                    wait(0.1) -- หน่วงเวลาเล็กน้อยให้ตัวละครตั้งตัว
                    
                    print("Info: Teleported to Loot. Attempting Auto-Loot...")
                    lootFound = true
                    
                    -- B. ทำการ Auto-Loot โดยเรียกใช้ฟังก์ชันใหม่
                    if AutoInteract(prompt) then
                        print("Info: Auto-Loot action successful.")
                        wait(0.5) -- หน่วงเวลาหลัง Loot สำเร็จ (ให้เกมประมวลผล)
                    end
                    
                    break -- วาร์ปไปที่ชิ้นแรกแล้วออกจากลูปหา Loot
                end
            end
            
            -- ---------------------------------
            -- 2. AUTO-THROW BAG (สันนิษฐานว่า Loot สำเร็จแล้ว)
            -- ---------------------------------

            if lootFound then 
                -- หากมีการวาร์ปไป Loot ในขั้นตอนที่ 1
                
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
            if ReplicatedStorage["RS_Package"].ReplicatedGameStatus.BagsSecured.Value > 10 then
                for _, v in pairs(getconnections(Player.PlayerGui["SG_Package"].MainGui.PregameFrame["button_playerReady"].MouseButton1Click)) do
                    v.Function()
                end
            end
        end
    end)()

    -- If heist results appear, teleport back to lobby 
    coroutine.wrap(function()
        while wait() do
            if Player.PlayerGui["SG_Package"].MainGui["frame_heistResults"].Visible then
                wait(2.5)
                game:GetService("TeleportService"):Teleport(21532277, Player)
            end
        end
    end)()
end

print("info 2")
