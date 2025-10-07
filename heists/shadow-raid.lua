print("info 1")
wait(4)

if game:IsLoaded() then
    local HRP = game:GetService("Players").LocalPlayer.Character.HumanoidRootPart
    local Remotes = game:GetService("ReplicatedStorage").RS_Package.Remotes 
    local BagSecurePosition = game:GetService("Workspace").BagSecuredArea.FloorPart.Position
    local TweenService = game:GetService("TweenService") 

    -- ฟังก์ชันสำหรับ Tween ตัวละคร (เคลื่อนที่นุ่มนวล)
    local function tweenToPosition(targetPosition)
        local tweenInfo = TweenInfo.new(
            1.5, -- ใช้เวลา 0.5 วินาทีในการเคลื่อนที่
            Enum.EasingStyle.Quad,
            Enum.EasingDirection.Out
        )
        local goal = {CFrame = CFrame.new(targetPosition)}
        local tween = TweenService:Create(HRP, tweenInfo, goal)
        tween:Play()
        tween.Completed:Wait() -- รอจนกว่าการเคลื่อนที่เสร็จสมบูรณ์
    end

    -- Auto-win code (Auto-Loot และ Auto-Move)
    coroutine.wrap(function()
        
        -- ปรับเวลา Loot ที่สำคัญ
        local LootDuration = 6.5 -- ***ลองปรับค่านี้หากยังเกิด Cancel Interaction***

        while true do 
            
            local lootFound = false
            
            -- ---------------------------------
            -- 1. AUTO-LOOT (Tween -> Start -> Wait -> Complete)
            -- ---------------------------------

            for _, v in pairs(game.Workspace.BigLoot:GetDescendants()) do
                local prompt = v:FindFirstChildOfClass("ProximityPrompt")

                if v:IsA("Part") and prompt then

                    -- A. TWEEN ไปที่ Loot Item
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
                    
                    print("Info: Looting Complete.")
                    lootFound = true
                    break 
                end
            end

            -- ---------------------------------
            -- 2. AUTO-MOVE TO VAN (Manual Throw Required)
            -- ---------------------------------

            if lootFound then 
                
                -- A. TWEEN ไปยังพื้นที่ Secure Area (รถตู้)
                tweenToPosition(BagSecurePosition)
                print("Loot Status: Item secured. Tweened to Van. Please MANUALLY THROW the bag!")
                
                -- B. หน่วงเวลาเล็กน้อยเพื่อให้คุณโยนกระเป๋า
                wait(3) 
            end
            
            -- ---------------------------------
            -- 3. การควบคุมลูปหลัก
            -- ---------------------------------
            
            if not lootFound then
                wait(10) -- ถ้าหา Loot ไม่พบ ให้รอ 10 วินาทีก่อนเริ่มหาใหม่
            else
                wait(0.5) -- ถ้า Loot สำเร็จ ให้รีบวนลูปเพื่อหา Loot ชิ้นต่อไป
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
