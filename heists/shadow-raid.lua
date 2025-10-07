print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local Remotes = game:GetService("ReplicatedStorage").RS_Package.Remotes 
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position
    local TweenService = game:GetService("TweenService") -- ดึง TweenService

    -- ฟังก์ชันสำหรับ Tween ตัวละคร (เคลื่อนที่นุ่มนวล)
    local function tweenToPosition(targetPosition)
        local tweenInfo = TweenInfo.new(
            0.5, -- ใช้เวลา 0.5 วินาทีในการเคลื่อนที่
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )
        local goal = {CFrame = CFrame.new(targetPosition)}
        local tween = TweenService:Create(HRP, tweenInfo, goal)
        tween:Play()
        tween.Completed:Wait() -- รอจนกว่าการเคลื่อนที่เสร็จสมบูรณ์
    end

    -- Auto-win code (Auto-Loot, Auto-Throw, Tweening)
    coroutine.wrap(function()
        
        -- ปรับเวลา Loot และ Throw ที่สำคัญ
        local LootDuration = 5.4 -- ***ลองเริ่มที่ 3.5 วินาที (จากประสบการณ์ก่อนหน้า)***
        local ThrowWaitTime = 1.5 -- เวลาให้เซิร์ฟเวอร์ประมวลผลการ Throw

        while true do 
            
            local lootFound = false
            
            -- ---------------------------------
            -- 1. AUTO-LOOT (Start -> Wait -> Complete)
            -- ---------------------------------

            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then

                    -- A. TWEEN ไปที่ Loot Item แทนการวาร์ป
                    print("Info: Tweening to Loot position...")
                    tweenToPosition(v.Position) 
                    wait(0.1) 
                    
                    -- B. สั่งเริ่มปฏิสัมพันธ์ (Start Interaction)
                    print("Info: Starting Auto-Loot Interaction...")
                    Remotes.StartInteraction:FireServer(prompt)
                    
                    -- C. รอเวลา Loot ที่สมจริง
                    wait(LootDuration) 
                    
                    -- D. สั่งเสร็จสิ้นปฏิสัมพันธ์ (Complete Interaction)
                    Remotes.CompleteInteraction:FireServer(prompt)
                    
                    print("Info: Looting Complete. Securing bag...")
                    lootFound = true
                    break 
                end
            end

            -- ---------------------------------
            -- 2. AUTO-THROW BAG
            -- ---------------------------------

            if lootFound then 
                
                -- A. TWEEN ไปยังพื้นที่ Secure Area (รถตู้) แทนการวาร์ป
                tweenToPosition(BagSecurePosition)
                wait(0.2)
                
                print("Info: Tweened to Van. Auto-Throwing Bag...")

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
            else
                wait(0.5)
            end
        end
    end)()

    -- (ส่วน Click the "ready" button และ Teleport back to lobby ยังคงอยู่)

end

print("info 2")
