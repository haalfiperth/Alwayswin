    local Workspace, RunService, Players, CoreGui, Lighting, UIS = cloneref(game:GetService("Workspace")), cloneref(game:GetService("RunService")), cloneref(game:GetService("Players")), game:GetService("CoreGui"), cloneref(game:GetService("Lighting")), cloneref(game:GetService("UserInputService"))
    local ESP = {
        Enabled = false,
        TargetOnly = false,
        TeamCheck = false,
        MaxDistance = 200,
        FontSize = 11,
        FadeOut = {
            OnDistance = false,
            OnDeath = false,
            OnLeave = false,
        },
        Options = { 
            Teamcheck = false, TeamcheckRGB = Color3.fromRGB(0, 255, 0),
            Friendcheck = false, FriendcheckRGB = Color3.fromRGB(0, 255, 0),
            Highlight = false, HighlightRGB = Color3.fromRGB(255, 0, 0),
        },
        Drawing = {
            Chams = {
                Enabled  = false,
                Thermal = false,
                FillRGB = Color3.fromRGB(255, 255, 255),
                Fill_Transparency = 80,
                OutlineRGB = Color3.fromRGB(255, 255, 255),
                Outline_Transparency = 80,
                VisibleCheck = false,
            },
            Names = {
                Enabled = false,
                RGB = Color3.fromRGB(255, 255, 255),
            },
            Flags = {
                Enabled = false,
            },
            Distances = {
                Enabled = false, 
                Position = "Text",
                RGB = Color3.fromRGB(255, 255, 255),
            },
            Weapons = {
                Enabled = false, WeaponTextRGB = Color3.fromRGB(119, 120, 255),
                Outlined = false,
                Icons = false, RGB = Color3.fromRGB(255, 255, 255),
                Gradient = false,
                GradientRGB1 = Color3.fromRGB(255, 255, 255), GradientRGB2 = Color3.fromRGB(119, 120, 255),
            },
            Healthbar = {
                Enabled = false,  
                HealthText = false, Lerp = false, HealthTextRGB = Color3.fromRGB(119, 120, 255),
                Width = 2.5,
                Gradient = false, GradientRGB1 = Color3.fromRGB(200, 0, 0), GradientRGB2 = Color3.fromRGB(200, 200, 0), GradientRGB3 = Color3.fromRGB(0, 200, 0), 
            },
            Boxes = {
                Animate = false,
                RotationSpeed = 300,
                Gradient = false, GradientRGB1 = Color3.fromRGB(119, 120, 255), GradientRGB2 = Color3.fromRGB(0, 0, 0), 
                GradientFill = false, GradientFillRGB1 = Color3.fromRGB(119, 120, 255), GradientFillRGB2 = Color3.fromRGB(0, 0, 0), 
                Full = {
                    Enabled = false,
                    RGB = Color3.fromRGB(255, 255, 255),
                },
                Corner = {
                    Enabled = false,
                    RGB = Color3.fromRGB(255, 255, 255),
                },
            };
        };
        Items = {
            Enabled = false,
            Icons = false,
            RGB = Color3.fromRGB(255, 255, 255)
        },
        Connections = {
            RunService = RunService;
        };
        Fovcircle = {};
        Fonts = {};
    }

    -- Def & Vars
    local zenhub = ESP.Connections;
    local lplayer = Players.LocalPlayer;
    local camera = game.Workspace.CurrentCamera;
    local Cam = Workspace.CurrentCamera;
    local RotationAngle, Tick = -45, tick();

    -- Weapon Images
    local Path = "https://raw.githubusercontent.com/haalfiperth/Alwayswin/main/Assets/"
    local images = {
    	["[AK47]"] = game:HttpGet(Path.. "AK.png"),
    	["[AR]"] = game:HttpGet(Path.. "AR.png"),
    	["[AUG]"] = game:HttpGet(Path.. "AUG.png"),
    	["[Double-Barrel SG]"] = game:HttpGet(Path.. "DB.png"),
    	["[DrumGun]"] = game:HttpGet(Path.. "DRUMSHOTGUN.png"),
    	["[Flamethrower]"] = game:HttpGet(Path.. "FLAME.png"),
    	["[Glock]"] = game:HttpGet(Path.. "GLOCK.png"),
    	["[LMG]"] = game:HttpGet(Path.. "LMG.png"),
    	["[P90]"]= game:HttpGet(Path.. "P90.png"),
    	["[Revolver]"] = game:HttpGet(Path.. "REVOLVER.png"),
    	["[SMG]"] = game:HttpGet(Path.. "SMG.png"),
    	["[Shotgun]"] = game:HttpGet(Path.. "SHOTGUN.png"),
    	["[SilencerAR]"] = game:HttpGet(Path.. "SILENCER.png"),
    	["[TacticalShotgun]"] = game:HttpGet(Path.. "TAC.png"),
    	["[Knife]"] = game:HttpGet(Path.. "KNIFE.png"),
    	["[Rifle]"] = game:HttpGet(Path.. "RIFLE.png")
    } 

    -- Functions
    local Functions = {}
    do
        function Functions:Create(Class, Properties)
            local _Instance = typeof(Class) == 'string' and Instance.new(Class) or Class
            for Property, Value in pairs(Properties) do
                _Instance[Property] = Value
            end
            return _Instance;
        end
        --
        function Functions:GetPlayerTool(Character)
            for _, value in pairs(Character:GetChildren()) do
                if value.Name ~= "HolsterModel" and value:IsA("Model") and value.Name ~= "Hair" and (value:FindFirstChild("Detail") or value:FindFirstChild("Main") or value:FindFirstChild("Handle") or value:FindFirstChild("Attachments") or value:FindFirstChild("ArrowAttach") or value:FindFirstChild("Attach")) and value.PrimaryPart then
                    return value.Name;
                end
            end
            return "none"
        end    
        function Functions:GetPlayerToolImg(Character)
            for _, value in pairs(Character:GetChildren()) do
                if value.Name ~= "HolsterModel" and value:IsA("Model") and value.Name ~= "Hair" and (value:FindFirstChild("Detail") or value:FindFirstChild("Main") or value:FindFirstChild("Handle") or value:FindFirstChild("Attachments") or value:FindFirstChild("ArrowAttach") or value:FindFirstChild("Attach")) and value.PrimaryPart then
                    return Weapon_Icons[value.Name] ;
                end
            end
            return nil
        end     
        --
        function Functions:FadeOutOnDist(element, distance)
            local transparency = math.max(0.1, 1 - (distance / ESP.MaxDistance))
            if element:IsA("TextLabel") then
                element.TextTransparency = 1 - transparency
            elseif element:IsA("ImageLabel") then
                element.ImageTransparency = 1 - transparency
            elseif element:IsA("UIStroke") then
                element.Transparency = 1 - transparency
            elseif element:IsA("Frame") and (element == Healthbar or element == BehindHealthbar) then
                element.BackgroundTransparency = 1 - transparency
            elseif element:IsA("Frame") then
                element.BackgroundTransparency = 1 - transparency
            elseif element:IsA("Highlight") then
                element.FillTransparency = 1 - transparency
                element.OutlineTransparency = 1 - transparency
            end;
        end;  
        --
        local increase = Vector3.new(2, 2, 2) -- pf size
        local vertices = { { -0.5, -0.5, -0.5 }, { -0.5, 0.5, -0.5 }, { 0.5, -0.5, -0.5 }, { 0.5, 0.5, -0.5 },{ -0.5, -0.5, 0.5 }, { -0.5, 0.5, 0.5 }, { 0.5, -0.5, 0.5 }, { 0.5, 0.5, 0.5 } };
        function Functions:custom_bounds(model)
            local min_bound, max_bound = Vector3.new(math.huge, math.huge, math.huge), Vector3.new(-math.huge, -math.huge, -math.huge)
        
            for _, part in ipairs(model:GetChildren()) do
                if part:IsA("BasePart") then
                    local cframe, size = part.CFrame, part.Size
                    for _, v in ipairs(vertices) do
                        local world_space = cframe:PointToWorldSpace(Vector3.new(v[1] * size.X, (v[2] + 0.2) * (size.Y + 0.2), v[3] * size.Z))
                        min_bound = Vector3.new(math.min(min_bound.X, world_space.X), math.min(min_bound.Y, world_space.Y), math.min(min_bound.Z, world_space.Z))
                        max_bound = Vector3.new(math.max(max_bound.X, world_space.X), math.max(max_bound.Y, world_space.Y), math.max(max_bound.Z, world_space.Z))
                    end
                end
            end
        
            if min_bound == Vector3.new(math.huge, math.huge, math.huge) then return end
            local center = (min_bound + max_bound) / 2
            return CFrame.new(center), max_bound - min_bound + increase, center
        end   
    end;

    do -- Initalize
        local ScreenGui = Functions:Create("ScreenGui", {
            Parent = CoreGui,
            Name = "ESPHolder",
        });

        local DupeCheck = function(plr)
            if ScreenGui:FindFirstChild(plr.Name) then
                ScreenGui[plr.Name]:Destroy()
            end
        end

        local ESP = function(plr)
            coroutine.wrap(DupeCheck)(plr) -- Dupecheck
            local Name = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, -11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
            local Distance = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 11), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
            local Weapon = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0), RichText = true})
            local Box = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0.75, BorderSizePixel = 0})
            local Outline = Functions:Create("UIStroke", {Parent = Box, Enabled = ESP.Drawing.Boxes.Gradient, Transparency = 0, Color = Color3.fromRGB(255, 255, 255), LineJoinMode = Enum.LineJoinMode.Miter})
            local Gradient2 = Functions:Create("UIGradient", {Parent = Outline, Enabled = ESP.Drawing.Boxes.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Boxes.GradientRGB1), ColorSequenceKeypoint.new(1, ESP.Drawing.Boxes.GradientRGB2)}})
            local Healthbar = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = Color3.fromRGB(255, 255, 255), BackgroundTransparency = 0})
            local BehindHealthbar = Functions:Create("Frame", {Parent = ScreenGui, ZIndex = -1, BackgroundColor3 = Color3.fromRGB(0, 0, 0), BackgroundTransparency = 0})
            local HealthbarGradient = Functions:Create("UIGradient", {Parent = Healthbar, Enabled = ESP.Drawing.Healthbar.Gradient, Rotation = -90, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Healthbar.GradientRGB1), ColorSequenceKeypoint.new(0.5, ESP.Drawing.Healthbar.GradientRGB2), ColorSequenceKeypoint.new(1, ESP.Drawing.Healthbar.GradientRGB3)}})
            local HealthText = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(0.5, 0, 0, 31), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
            local Chams = Functions:Create("Highlight", {Parent = ScreenGui, FillTransparency = 1, OutlineTransparency = 0, OutlineColor = Color3.fromRGB(119, 120, 255), DepthMode = "AlwaysOnTop"})
            local WeaponIcon = Functions:Create("ImageLabel", {Parent = ScreenGui, BackgroundTransparency = 1, BorderColor3 = Color3.fromRGB(0, 0, 0), BorderSizePixel = 0, Size = UDim2.new(0, 40, 0, 40)})
            local Gradient3 = Functions:Create("UIGradient", {Parent = WeaponIcon, Rotation = -90, Enabled = ESP.Drawing.Weapons.Gradient, Color = ColorSequence.new{ColorSequenceKeypoint.new(0, ESP.Drawing.Weapons.GradientRGB1), ColorSequenceKeypoint.new(1, ESP.Drawing.Weapons.GradientRGB2)}})
            local LeftTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local LeftSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local RightTop = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local RightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local BottomSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local BottomDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local BottomRightSide = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local BottomRightDown = Functions:Create("Frame", {Parent = ScreenGui, BackgroundColor3 = ESP.Drawing.Boxes.Corner.RGB, Position = UDim2.new(0, 0, 0, 0)})
            local Flag1 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
            local Flag2 = Functions:Create("TextLabel", {Parent = ScreenGui, Position = UDim2.new(1, 0, 0, 0), Size = UDim2.new(0, 100, 0, 20), AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
            --local DroppedItems = Functions:Create("TextLabel", {Parent = ScreenGui, AnchorPoint = Vector2.new(0.5, 0.5), BackgroundTransparency = 1, TextColor3 = Color3.fromRGB(255, 255, 255), Font = Enum.Font.Code, TextSize = ESP.FontSize, TextStrokeTransparency = 0, TextStrokeColor3 = Color3.fromRGB(0, 0, 0)})
            --
            local Updater = function()
                local Connection;
                local function HideESP()
                    Box.Visible = false;
                    Name.Visible = false;
                    Distance.Visible = false;
                    Weapon.Visible = false;
                    Healthbar.Visible = false;
                    BehindHealthbar.Visible = false;
                    HealthText.Visible = false;
                    WeaponIcon.Visible = false;
                    LeftTop.Visible = false;
                    LeftSide.Visible = false;
                    BottomSide.Visible = false;
                    BottomDown.Visible = false;
                    RightTop.Visible = false;
                    RightSide.Visible = false;
                    BottomRightSide.Visible = false;
                    BottomRightDown.Visible = false;
                    Flag1.Visible = false;
                    Chams.Enabled = false;
                    Flag2.Visible = false;
                    if not plr then
                        ScreenGui:Destroy();
                        Connection:Disconnect();
                    end
                end
                --
                Connection = zenhub.RunService.RenderStepped:Connect(function()
                    --[[ do -- Item ESP
                        if ESP.Items.Enabled then
                            for _, debrisPart in pairs(workspace.Debris:GetChildren()) do
                                if debrisPart:IsA("BasePart") then
                                    local item_pos = debrisPart.Position
                                    local screen_pos, onScreen = Cam:WorldToScreenPoint(item_pos)
                                    DroppedItems.Text = debrisPart.Name
                                    DroppedItems.Position = UDim2.new(0, screen_pos.X, 0, screen_pos.Y)
                                    DroppedItems.Visible = onScreen
                                end
                            end
                        else
                            DroppedItems.Visible = false
                        end         
                    end]]
                    --
                    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
                        local cframe, size, position = Functions:custom_bounds(plr.Character)
                        local HRP = plr.Character.HumanoidRootPart;
                        local Humanoid = plr.Character:WaitForChild("Humanoid");
                        local Pos, OnScreen = Cam:WorldToScreenPoint(position);
                        local height = math.tan(math.rad(Cam.FieldOfView / 2)) * 2 * Pos.Z;
                        local Dist = (Cam.CFrame.Position - position).Magnitude / 3.5714285714;
                        
                        if OnScreen and Dist <= ESP.MaxDistance then
                            local scale = Vector2.new((Cam.ViewportSize.Y / height) * size.X, (Cam.ViewportSize.Y / height) * size.Y)

                            -- Fade-out effect --
                            if ESP.FadeOut.OnDistance then
                                Functions:FadeOutOnDist(Box, Dist)
                                Functions:FadeOutOnDist(Outline, Dist)
                                Functions:FadeOutOnDist(Name, Dist)
                                Functions:FadeOutOnDist(Distance, Dist)
                                Functions:FadeOutOnDist(Weapon, Dist)
                                Functions:FadeOutOnDist(Healthbar, Dist)
                                Functions:FadeOutOnDist(BehindHealthbar, Dist)
                                Functions:FadeOutOnDist(HealthText, Dist)
                                Functions:FadeOutOnDist(WeaponIcon, Dist)
                                Functions:FadeOutOnDist(LeftTop, Dist)
                                Functions:FadeOutOnDist(LeftSide, Dist)
                                Functions:FadeOutOnDist(BottomSide, Dist)
                                Functions:FadeOutOnDist(BottomDown, Dist)
                                Functions:FadeOutOnDist(RightTop, Dist)
                                Functions:FadeOutOnDist(RightSide, Dist)
                                Functions:FadeOutOnDist(BottomRightSide, Dist)
                                Functions:FadeOutOnDist(BottomRightDown, Dist)
                                Functions:FadeOutOnDist(Chams, Dist)
                                Functions:FadeOutOnDist(Flag1, Dist)
                                Functions:FadeOutOnDist(Flag2, Dist)
                            end

                            -- Teamcheck
                            if ESP.TeamCheck and plr ~= lplayer and ((lplayer.Team ~= plr.Team and plr.Team) or (not lplayer.Team and not plr.Team)) and plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") and plr.Character:FindFirstChild("Humanoid") then

                                do -- Chams
                                    Chams.Adornee = plr.Character
                                    Chams.Enabled = ESP.Drawing.Chams.Enabled
                                    Chams.FillColor = ESP.Drawing.Chams.FillRGB
                                    Chams.OutlineColor = ESP.Drawing.Chams.OutlineRGB
                                    do -- Breathe
                                        if ESP.Drawing.Chams.Thermal then
                                            local breathe_effect = math.atan(math.sin(tick() * 2)) * 2 / math.pi
                                            Chams.FillTransparency = ESP.Drawing.Chams.Fill_Transparency * breathe_effect * 0.01
                                            Chams.OutlineTransparency = ESP.Drawing.Chams.Outline_Transparency * breathe_effect * 0.01
                                        end
                                    end
                                    if ESP.Drawing.Chams.VisibleCheck then
                                        Chams.DepthMode = "Occluded"
                                    else
                                        Chams.DepthMode = "AlwaysOnTop"
                                    end
                                end;

                                do -- Corner Boxes

                                    if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                                        LeftTop.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        LeftSide.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        BottomSide.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        BottomDown.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        RightTop.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        RightSide.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        BottomRightSide.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                        BottomRightDown.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
                                    else
                                        LeftTop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                        LeftSide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                        BottomSide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                        BottomDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                        RightTop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                        RightSide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                        BottomRightSide.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                        BottomRightDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                                    end

                                    LeftTop.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    LeftTop.Position = UDim2.new(0, Pos.X - scale.X / 2, 0, Pos.Y - scale.Y / 2)
                                    LeftTop.Size = UDim2.new(0, scale.X / 3, 0, 1)
                                    
                                    LeftSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    LeftSide.Position = UDim2.new(0, Pos.X - scale.X / 2, 0, Pos.Y - scale.Y / 2)
                                    LeftSide.Size = UDim2.new(0, 1, 0, scale.Y / 3)
                                    
                                    BottomSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    BottomSide.Position = UDim2.new(0, Pos.X - scale.X / 2, 0, Pos.Y + scale.Y / 2)
                                    BottomSide.Size = UDim2.new(0, 1, 0, scale.Y / 3)
                                    BottomSide.AnchorPoint = Vector2.new(0, 5)
                                    
                                    BottomDown.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    BottomDown.Position = UDim2.new(0, Pos.X - scale.X / 2, 0, Pos.Y + scale.Y / 2)
                                    BottomDown.Size = UDim2.new(0, scale.X / 3, 0, 1)
                                    BottomDown.AnchorPoint = Vector2.new(0, 1)
                                    
                                    RightTop.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    RightTop.Position = UDim2.new(0, Pos.X + scale.X / 2, 0, Pos.Y - scale.Y / 2)
                                    RightTop.Size = UDim2.new(0, scale.X / 3, 0, 1)
                                    RightTop.AnchorPoint = Vector2.new(1, 0)
                                    
                                    RightSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    RightSide.Position = UDim2.new(0, Pos.X + scale.X / 2 - 1, 0, Pos.Y - scale.Y / 2)
                                    RightSide.Size = UDim2.new(0, 1, 0, scale.Y / 3)
                                    RightSide.AnchorPoint = Vector2.new(0, 0)
                                    
                                    BottomRightSide.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    BottomRightSide.Position = UDim2.new(0, Pos.X + scale.X / 2, 0, Pos.Y + scale.Y / 2)
                                    BottomRightSide.Size = UDim2.new(0, 1, 0, scale.Y / 3)
                                    BottomRightSide.AnchorPoint = Vector2.new(1, 1)
                                    
                                    BottomRightDown.Visible = ESP.Drawing.Boxes.Corner.Enabled
                                    BottomRightDown.Position = UDim2.new(0, Pos.X + scale.X / 2, 0, Pos.Y + scale.Y / 2)
                                    BottomRightDown.Size = UDim2.new(0, scale.X / 3, 0, 1)
                                    BottomRightDown.AnchorPoint = Vector2.new(1, 1)                                                            
                                end

                                do -- Boxes
                                    Box.Position = UDim2.new(0, Pos.X - scale.X / 2, 0, Pos.Y - scale.Y / 2)
                                    Box.Size = UDim2.new(0, scale.X, 0, scale.Y)
                                    Box.Visible = ESP.Drawing.Boxes.Full.Enabled;
                                end

                                do -- Healthbar
                                    local health = Humanoid.Health / Humanoid.MaxHealth;
                                    Healthbar.Visible = ESP.Drawing.Healthbar.Enabled;
                                    Healthbar.Position = UDim2.new(0, Pos.X - scale.X / 2 - 6, 0, Pos.Y - scale.Y / 2 + scale.Y * (1 - health))  
                                    Healthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, scale.Y * health)  
                                    --
                                    BehindHealthbar.Visible = ESP.Drawing.Healthbar.Enabled;
                                    BehindHealthbar.Position = UDim2.new(0, Pos.X - scale.X / 2 - 6, 0, Pos.Y - scale.Y / 2)  
                                    BehindHealthbar.Size = UDim2.new(0, ESP.Drawing.Healthbar.Width, 0, scale.Y)
                                    -- Health Text
                                    do
                                        if ESP.Drawing.Healthbar.HealthText then
                                            local healthPercentage = math.floor(Humanoid.Health / Humanoid.MaxHealth * 100)
                                            HealthText.Position = UDim2.new(0, Pos.X - scale.X / 2 - 6, 0, Pos.Y - scale.Y / 2 + scale.Y * (1 - healthPercentage / 100) + 3)
                                            HealthText.Text = tostring(healthPercentage)
                                            HealthText.Visible = Humanoid.Health < Humanoid.MaxHealth
                                        end                        
                                    end

                                    if ESP.Drawing.Healthbar.Lerp then
                                        local health_color = Color3.new(1, 0, 0)
                                        health_color = health_color:lerp(Color3.new(1, 0.65, 0), math.clamp((Humanoid.Health / Humanoid.MaxHealth), 0, 1))
                                        health_color = health_color:lerp(Color3.new(0, 1, 0), math.clamp((Humanoid.Health / Humanoid.MaxHealth - 0.5) * 2, 0, 1))                            
                                
                                        HealthText.TextColor3 = health_color
                                        HealthbarGradient.Color = ColorSequence.new{ ColorSequenceKeypoint.new(0, health_color), ColorSequenceKeypoint.new(0.5, health_color), ColorSequenceKeypoint.new(1, health_color) }
                                    end
                                end

                                do -- Names
                                    Name.Visible = ESP.Drawing.Names.Enabled
                                    if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                                        Name.TextColor3 = Color3.fromRGB(0, 255, 0)
                                    else
                                        Name.TextColor3 = Color3.fromRGB(255, 255, 255)
                                    end
                                    Name.Text = plr.Name
                                    Name.Position = UDim2.new(0, Pos.X, 0, Pos.Y - scale.Y / 2 - 9)
                                end
                                
                                do -- Distance
                                    if ESP.Drawing.Distances.Enabled then
                                        if ESP.Drawing.Distances.Position == "Bottom" then
                                            Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + scale.Y / 2 + 18)
                                            WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + scale.Y / 2 + 15);
                                            Distance.Position = UDim2.new(0, Pos.X, 0, Pos.Y + scale.Y / 2 + 7)
                                            Distance.Text = string.format("%d meters", math.floor(Dist))
                                            Distance.Visible = true
                                        elseif ESP.Drawing.Distances.Position == "Text" then
                                            Weapon.Position = UDim2.new(0, Pos.X, 0, Pos.Y + scale.Y / 2 + 8)
                                            WeaponIcon.Position = UDim2.new(0, Pos.X - 21, 0, Pos.Y + scale.Y / 2 + 5);
                                            Distance.Visible = false
                                            Name.Text = plr.Name
                                            Name.Visible = ESP.Drawing.Names.Enabled
                                            if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                                                Distance.TextColor3 = Color3.fromRGB(0, 255, 0)
                                                Weapon.TextColor3 = Color3.fromRGB(0, 255, 0)
                                            else
                                                Distance.TextColor3 = Color3.fromRGB(255, 255, 255)
                                                Weapon.TextColor3 = Color3.fromRGB(255, 255, 255)
                                            end
                                        end
                                    end
                                end

                                do -- Weapons
                                    local weapon = (plr.Character:FindFirstChildOfClass("Tool") and plr.Character:FindFirstChildOfClass("Tool").Name) or "None"
                                    Weapon.Text = ESP.Drawing.Weapons.Enabled and string.format(''.. weapon ..'', ESP.Drawing.Weapons.WeaponTextRGB.R * 255, ESP.Drawing.Weapons.WeaponTextRGB.G * 255, ESP.Drawing.Weapons.WeaponTextRGB.B * 255) or ""
                                    Weapon.Visible = ESP.Drawing.Weapons.Enabled
                                    
                                    do -- Weapon icons
                                        local WeaponImage = weapon ~= "None" and images[weapon] or nil
                                        WeaponIcon.ImageColor3 = ESP.Drawing.Weapons.RGB
                                        if WeaponImage then
                                            if ESP.Options.Friendcheck and lplayer:IsFriendsWith(plr.UserId) then
                                                WeaponIcon.ImageColor3 = Color3.fromRGB(0, 255, 0)
                                            else
                                                WeaponIcon.ImageColor3 = Color3.fromRGB(255, 255, 255)
                                            end
                                            WeaponIcon.Visible = ESP.Drawing.Weapons.Icons
                                            WeaponIcon.Image = WeaponImage
                                        else
                                            WeaponIcon.Visible = false
                                        end
                                    end
                                end                            
                            else
                                HideESP();
                            end
                        else
                            HideESP();
                        end
                    else
                        HideESP();
                    end
                end)
            end
            coroutine.wrap(Updater)();
        end
        do -- Update ESP
            for _, v in pairs(game:GetService("Players"):GetPlayers()) do
                if v.Name ~= lplayer.Name then
                    coroutine.wrap(ESP)(v)
                end      
            end
            --
            game:GetService("Players").PlayerAdded:Connect(function(v)
                coroutine.wrap(ESP)(v)
            end);
        end;
    end;
    --