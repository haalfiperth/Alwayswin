local Config = {
    Box = {
        Enable = false,
        Font = "Arcade",
        Color = Color3.fromRGB(255, 255, 255),
        Filled = {
            Enable = false,
            Gradient = {
                Enable = false,
                Color = {
                    Start = Color3.fromRGB(255, 255, 255),
                    End = Color3.fromRGB(0, 255, 0);
                },
            }
        }
    },
    Text = {
        Enable = true,
        Name = {
            Enable = false,
	    Type = "DisplayName",
            Color = Color3.fromRGB(255, 255, 255);
        },
        Studs = {
            Enable = false,
            Color = Color3.fromRGB(255, 255, 255);
        },
        Tool = {
            Enable = false,
            Color = Color3.fromRGB(255, 255, 255);
        },
    },
    Bars = {
        Health = {
            ShowOutline = false,
            Enable = false,
            Lerp = false;
            Color1 = Color3.fromRGB(0, 255, 0);
            Color2 = Color3.fromRGB(255, 255, 0),
            Color3 = Color3.fromRGB(255, 0, 0)
        },
        Armor = {
            ShowOutline = false,
            Enable = false,
            Lerp = false;
            Color1 = Color3.fromRGB(0, 0, 255);
            Color2 = Color3.fromRGB(135, 206, 235),
            Color3 = Color3.fromRGB(1, 0, 0)
        }
    }
}


if not LPH_OBFUSCATED then
	LPH_JIT_MAX = function(...)
		return (...)
	end
	LPH_NO_VIRTUALIZE = function(...)
		return (...)
	end
end

local Overlay = {};
local draw = nil

local Overlay
Config = Config;
Drawing = Drawing;

local gui_inset = game:GetService("GuiService"):GetGuiInset()

local utility, connections, cache = {}, {}, {};
utility.funcs = utility.funcs or {};
utility.funcs.make_text = function(p)
    local d = Instance.new("TextLabel")
    d.Parent = p
    d.Size = UDim2.new(0, 4, 0, 4)
    d.BackgroundTransparency = 1
    d.TextColor3 = Color3.fromRGB(255,255,255)
    d.TextStrokeTransparency = 0
    d.TextScaled = false
    d.TextSize = 10
    d.TextStrokeColor3 = Color3.fromRGB(0,0,0)
    d.Font = Config.Box.Font
    return d
end

utility.funcs.render = LPH_NO_VIRTUALIZE(function(player)
    if not player then return end

    cache[player] = cache[player] or {}
    cache[player].Box = {}
    cache[player].Bars = {}
    cache[player].Text = {}

    cache[player].Box.Full = {
        Square = Drawing.new("Square"),
        Inline = Drawing.new("Square"),
        Outline = Drawing.new("Square"),
        Filled = Instance.new('Frame', Instance.new('ScreenGui', game.CoreGui))
    }

    local Studs = Instance.new("ScreenGui")
    Studs.Parent = game.CoreGui

    local Name = Instance.new("ScreenGui")
    Name.Parent = game.CoreGui

    local Tool = Instance.new("ScreenGui")
    Tool.Parent = game.CoreGui

    cache[player].Text.Studs = utility.funcs.make_text(Studs)
    cache[player].Text.Tool = utility.funcs.make_text(Tool)
    cache[player].Text.Name = utility.funcs.make_text(Name)

    local armorGui = Instance.new("ScreenGui")
    armorGui.Name = player.Name .. "_ArmorBar"
    armorGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    armorGui.Parent = game.CoreGui

    local armorOutline = Instance.new("Frame")
    armorOutline.BackgroundColor3 = Color3.new(0, 0, 0)
    armorOutline.BorderSizePixel = 0
    armorOutline.Name = "Outline"
    armorOutline.Parent = armorGui

    local armorFill = Instance.new("Frame")
    armorFill.BackgroundTransparency = 0
    armorFill.BorderSizePixel = 0
    armorFill.Name = "Fill"
    armorFill.Parent = armorOutline

    local armorGradient = Instance.new("UIGradient", armorFill)
    armorGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.Bars.Armor.Color1),
        ColorSequenceKeypoint.new(0.5, Config.Bars.Armor.Color2),
        ColorSequenceKeypoint.new(1, Config.Bars.Armor.Color3)
    })
    armorGradient.Rotation = 90

    cache[player].Bars.Armor = {
        Gui = armorGui,
        Outline = armorOutline,
        Frame = armorFill,
        Gradient = armorGradient
    }

    local healthGui = Instance.new("ScreenGui")
    healthGui.Name = player.Name .. "_HealthBar"
    healthGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
    healthGui.Parent = game.CoreGui

    local healthOutline = Instance.new("Frame")
    healthOutline.BackgroundColor3 = Color3.new(0, 0, 0)
    healthOutline.BorderSizePixel = 0
    healthOutline.Name = "Outline"
    healthOutline.Parent = healthGui

    local healthFill = Instance.new("Frame")
    healthFill.BackgroundTransparency = 0
    healthFill.BorderSizePixel = 0
    healthFill.Name = "Fill"
    healthFill.Parent = healthOutline

    local healthGradient = Instance.new("UIGradient", healthFill)
    healthGradient.Color = ColorSequence.new({
        ColorSequenceKeypoint.new(0, Config.Bars.Health.Color1),
        ColorSequenceKeypoint.new(0.5, Config.Bars.Health.Color2),
        ColorSequenceKeypoint.new(1, Config.Bars.Health.Color3)
    })
    healthGradient.Rotation = 90

    cache[player].Bars.Health = {
        Gui = healthGui,
        Outline = healthOutline,
        Frame = healthFill,
        Gradient = healthGradient
    }
end)

utility.funcs.clear_esp = LPH_NO_VIRTUALIZE(function(player)
    if not cache[player] then return end

    if cache[player].Box and cache[player].Box.Full then
        cache[player].Box.Full.Square.Visible = false
        cache[player].Box.Full.Outline.Visible = false
        cache[player].Box.Full.Inline.Visible = false
        if cache[player].Box.Full.Filled then
            cache[player].Box.Full.Filled.Visible = false
        end
    end

    if cache[player].Text then
        if cache[player].Text.Studs then cache[player].Text.Studs.Visible = false end
        if cache[player].Text.Tool then cache[player].Text.Tool.Visible = false end
        if cache[player].Text.Name then cache[player].Text.Name.Visible = false end
    end

    if cache[player].Bars then
        if cache[player].Bars.Health and cache[player].Bars.Health.Frame then
            cache[player].Bars.Health.Frame.Visible = false
            cache[player].Bars.Health.Outline.Visible = false
        end
        if cache[player].Bars.Armor and cache[player].Bars.Armor.Frame then
            cache[player].Bars.Armor.Frame.Visible = false
            cache[player].Bars.Armor.Outline.Visible = false
        end
    end
end)

utility.funcs.update = LPH_NO_VIRTUALIZE(function(player)
    if not player or not cache[player] then return end

    local character = player.Character
    local client_character = game.Players.LocalPlayer.Character
    local Camera = workspace.CurrentCamera
    if not character or not client_character then return end

    local rootPart = character:FindFirstChild("HumanoidRootPart")
    local client_root_part = client_character:FindFirstChild("HumanoidRootPart")
    local lower_torso = character:FindFirstChild("LowerTorso")
    local humanoid = character:FindFirstChildWhichIsA("Humanoid")

    if not rootPart or not humanoid then 
        utility.funcs.clear_esp(player)
        return 
    end

    local hrp2D = Camera:WorldToViewportPoint(rootPart.Position)
    local charSize = (Camera:WorldToViewportPoint(rootPart.Position - Vector3.new(0, 1, 0)).Y - Camera:WorldToViewportPoint(rootPart.Position + Vector3.new(0, 3, 0)).Y) / 2
    local size = Vector2.new(math.floor(charSize * 1.5), math.floor(charSize * 3.2)) 
    local position = Vector2.new(math.floor(hrp2D.X - charSize * 1.5 / 2), math.floor(hrp2D.Y - charSize * 3 / 2))
    local playerCache = cache[player]
    local Pos, onScreen = Camera:WorldToViewportPoint(rootPart.Position)
    if not onScreen then
        utility.funcs.clear_esp(player)
        return
    end

    if Config.Box.Enable then
        local fullBox = playerCache.Box.Full
        local square, outline, inline, filled = fullBox.Square, fullBox.Outline, fullBox.Inline, fullBox.Filled

        if Config.Box.Type == "Full" then
            square.Visible = Config.Box.Enable
            square.Position = position
            square.Size = size
            square.Color = Config.Box.Color
            square.Thickness = 2
            square.Filled = false
            square.ZIndex = 9e9

            outline.Visible = Config.Box.Enable
            outline.Position = position - Vector2.new(1, 1)
            outline.Size = size + Vector2.new(2, 2)
            outline.Color = Color3.new(0, 0, 0)
            outline.Thickness = 1
            outline.Filled = false

            inline.Visible = true
            inline.Position = position + Vector2.new(1, 1)
            inline.Size = size - Vector2.new(2, 2)
            inline.Color = Color3.new(0, 0, 0)
            inline.Thickness = 1
            inline.Filled = false

            if Config.Box.Filled.Enable and filled then
                filled.Position = UDim2.new(0, position.X, 0, position.Y - gui_inset.Y)
                filled.Size = UDim2.new(0, size.X, 0, size.Y)
                filled.BackgroundTransparency = 0.5
                filled.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                filled.Visible = Config.Box.Filled.Enable
                filled.ZIndex = -9e9

                if Config.Box.Filled.Gradient.Enable then
                    local gradient = filled:FindFirstChild("Gradient") or Instance.new("UIGradient")
                    gradient.Name = "Gradient"
                    gradient.Color = ColorSequence.new({
                        ColorSequenceKeypoint.new(0, Config.Box.Filled.Gradient.Color.Start),
                        ColorSequenceKeypoint.new(1, Config.Box.Filled.Gradient.Color.End)
                    })
                    gradient.Rotation = math.sin(tick() * 2) * 180
                    if not gradient.Parent then gradient.Parent = filled end
                end
            elseif filled then
                filled.Visible = false
            end
        else
            local fullBox = playerCache.Box.Full
            if fullBox then
                fullBox.Square.Visible = false
                fullBox.Outline.Visible = false
                fullBox.Inline.Visible = false
                if fullBox.Filled then
                    fullBox.Filled.Visible = false
                end
            end
        end
    end

    local bar_height = size.Y
    local bar_width = 3
    local base_x = position.X
    local y = position.Y - gui_inset.Y

    if Config.Bars.Health.Enable and humanoid then
        local targetHealth = math.clamp(humanoid.Health / humanoid.MaxHealth, 0, 1)
        local lastHealth = playerCache.Bars.Health.LastHealth or targetHealth
        local lerpedHealth = lastHealth + (targetHealth - lastHealth) * 0.05
        playerCache.Bars.Health.LastHealth = lerpedHealth

        local x = base_x - (bar_width + 4)
        local outline = playerCache.Bars.Health.Outline
        local fill = playerCache.Bars.Health.Frame

        if outline and fill then
            outline.Visible = true
            outline.Position = UDim2.new(0, x - 1, 0, y - 1)
            outline.Size = UDim2.new(0, bar_width + 2, 0, bar_height + 1.1)
            outline.BackgroundTransparency = 0.2

            fill.Visible = true
            fill.Position = UDim2.new(0, 1, 0, (1 - lerpedHealth) * bar_height + 1)
            fill.Size = UDim2.new(0, bar_width, 0, lerpedHealth * bar_height)
        end
    end

    if Config.Text.Enable then
        local nameLabel = playerCache.Text.Name
        local toolLabel = playerCache.Text.Tool
        local studsLabel = playerCache.Text.Studs
    
        local textOffset = 15
        local baseX = position.X + (size.X / 2)
        local baseY = position.Y - gui_inset.Y
    
        nameLabel.Visible = true
        nameLabel.Position = UDim2.new(0, baseX - (nameLabel.AbsoluteSize.X / 2), 0, baseY - textOffset + 6)
        nameLabel.Text = player.Name
    
        toolLabel.Visible = true
        toolLabel.Position = UDim2.new(0, baseX - (toolLabel.AbsoluteSize.X / 2), 0, baseY + size.Y + 15)
        local tool = character:FindFirstChildOfClass("Tool")
        toolLabel.Text = tool and tool.Name or "none"
    
        studsLabel.Visible = true
        studsLabel.Position = UDim2.new(0, baseX - (studsLabel.AbsoluteSize.X / 2), 0, baseY + size.Y + 5)
        local distance = (Camera.CFrame.Position - rootPart.Position).Magnitude
        local meters = distance * 0.28
        studsLabel.Text = string.format("[%.0fm]", meters)

    end
    

    if Config.Bars.Armor.Enable and character then
        local bodyEffects = character:FindFirstChild("BodyEffects")
        local values = bodyEffects and bodyEffects:FindFirstChild("Armor")
        local targetArmor = values and math.clamp(values.Value / 130, 0, 1) or 0
    
        local lastArmor = playerCache.Bars.Armor.LastArmor or targetArmor
        local lerpedArmor = lastArmor + (targetArmor - lastArmor) * 0.05
        playerCache.Bars.Armor.LastArmor = lerpedArmor
    
        local x = base_x - (bar_width * 2 + 6 + 2)
        local outline = playerCache.Bars.Armor.Outline
        local fill = playerCache.Bars.Armor.Frame
    
        if outline then
            outline.Visible = true
            outline.Position = UDim2.new(0, x - 1, 0, y - 1)
            outline.Size = UDim2.new(0, bar_width + 2, 0, bar_height + 1.1)
            outline.BackgroundTransparency = 0.2
        end
    
        if fill then
            fill.Visible = true
            fill.Position = UDim2.new(0, 1, 0, (1 - lerpedArmor) * bar_height + 1)
            fill.Size = UDim2.new(0, bar_width, 0, lerpedArmor * bar_height)
        end
    end    
end)


for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
    if player ~= game.Players.LocalPlayer then
        utility.funcs.render(player)
    end
end

game:GetService("Players").PlayerAdded:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        utility.funcs.render(player)
    end
end)

game:GetService("Players").PlayerRemoving:Connect(function(player)
    if player ~= game.Players.LocalPlayer then
        utility.funcs.clear_esp(player)
    end
end)

connections.main = connections.main or {}
connections.main.RenderStepped = game:GetService("RunService").Heartbeat:Connect(function()
    for v, _ in pairs(cache) do
        if v then
            utility.funcs.update(v)
        end
    end
end) 

return Config
