getgenv().crosshair = {
    enabled = false,
    text = true,
    refreshrate = 0,
    mode = 'Middle', -- Middle, Mouse, Custom
    firsttext = "alwayswin",
    secondtext = ".lol",
    position = Vector2.new(0, 0),
    lines = 4, -- Change this value to test different line counts
    width = 1.8,
    length = 15,
    radius = 11,
    color = Color3.fromRGB(189,172,255),
    spin = false,
    spin_speed = 150,
    spin_max = 340,
    spin_style = Enum.EasingStyle.Circular, -- Linear for normal smooth spin
    spin_direction = Enum.EasingDirection.InOut,
    resize = false, -- animate the length
    resize_speed = 150,
    resize_min = 5,
    resize_max = 22,
}

local runservice = game:GetService('RunService')
local inputservice = game:GetService('UserInputService')
local tweenservice = game:GetService('TweenService')
local camera = workspace.CurrentCamera

local last_render = 0

local drawings = {
    crosshair = {},
    text = {
        Text1 = Drawing.new('Text'),
        Text2 = Drawing.new('Text')
    }
}

drawings.text.Text1.Size = 13
drawings.text.Text1.Font = 2
drawings.text.Text1.Outline = true
drawings.text.Text1.Text = crosshair.firsttext
drawings.text.Text1.Color = Color3.new(1, 1, 1)

drawings.text.Text2.Size = 13
drawings.text.Text2.Font = 2
drawings.text.Text2.Outline = true
drawings.text.Text2.Text = crosshair.secondtext

local currentLines = crosshair.lines -- Track the current number of lines
local currentWidth = crosshair.width -- Track the current width

local function createCrosshairLines()
    for _, line in pairs(drawings.crosshair) do
        line[1]:Remove() -- Remove outline
        line[2]:Remove() -- Remove inline
    end
    drawings.crosshair = {}

    for idx = 1, crosshair.lines do
        local outline = Drawing.new('Line')
        outline.Color = Color3.new(0, 0, 0)
        outline.Thickness = crosshair.width + 2
        outline.ZIndex = 1 -- Lower ZIndex for outline

        local inline = Drawing.new('Line')
        inline.Color = crosshair.color
        inline.Thickness = crosshair.width
        inline.ZIndex = 2 -- Higher ZIndex for inline

        drawings.crosshair[idx] = {outline, inline}
    end
end

createCrosshairLines() -- Initialize crosshair lines

function solve(angle, radius)
    return Vector2.new(
        math.sin(math.rad(angle)) * radius,
        math.cos(math.rad(angle)) * radius
    )
end

runservice.PostSimulation:Connect(function()
    local _tick = tick()

    if _tick - last_render > crosshair.refreshrate then
        last_render = _tick

        if currentLines ~= crosshair.lines or currentWidth ~= crosshair.width then
            currentLines = crosshair.lines
            currentWidth = crosshair.width
            createCrosshairLines() -- Recreate the lines if the count or width has changed
        end

        local position = (
            crosshair.mode == 'Middle' and camera.ViewportSize / 2 or
            crosshair.mode == 'Mouse' and inputservice:GetMouseLocation() or
            crosshair.position
        )

        local text_1 = drawings.text.Text1
        local text_2 = drawings.text.Text2

        text_1.Visible = crosshair.text
        text_2.Visible = crosshair.text

        if crosshair.enabled then
            local text_x = text_1.TextBounds.X + text_2.TextBounds.X
            text_1.Position = position + Vector2.new(-text_x / 2, crosshair.radius + (crosshair.resize and crosshair.resize_max or crosshair.length) + 15)
            text_2.Position = text_1.Position + Vector2.new(text_1.TextBounds.X)
            text_2.Color = crosshair.color

            for idx = 1, crosshair.lines do
                local outline = drawings.crosshair[idx][1] -- Outline
                local inline = drawings.crosshair[idx][2]  -- Inline

                local angle = (idx - 1) * (360 / crosshair.lines) -- Distribute angles evenly
                local length = crosshair.length

                if crosshair.spin then
                    local spin_angle = -_tick * crosshair.spin_speed % crosshair.spin_max
                    angle = angle + tweenservice:GetValue(spin_angle / 360, crosshair.spin_style, crosshair.spin_direction) * 360
                end

                if crosshair.resize then
                    local resize_length = tick() * crosshair.resize_speed % 180
                    length = crosshair.resize_min + math.sin(math.rad(resize_length)) * crosshair.resize_max
                end

                inline.Visible = true
                inline.Color = crosshair.color
                inline.From = position + solve(angle, crosshair.radius)
                inline.To = position + solve(angle, crosshair.radius + length)
                inline.Thickness = crosshair.width

                outline.Visible = true
                outline.From = position + solve(angle, crosshair.radius - 1)
                outline.To = position + solve(angle, crosshair.radius + length + 1)
                outline.Thickness = crosshair.width + 1.5    
            end
        else
            for idx = 1, crosshair.lines do
                drawings.crosshair[idx][1].Visible = false -- Outline
                drawings.crosshair[idx][2].Visible = false -- Inline
            end
        end
    end
end)

return crosshair
