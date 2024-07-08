local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

-- Function to create a skeleton for a player
local function createSkeleton(player)
    local character = player.Character
    if not character then return end

    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            local skeletonPart = Instance.new("BoxHandleAdornment")
            skeletonPart.Size = part.Size
            skeletonPart.AlwaysOnTop = true
            skeletonPart.ZIndex = 10
            skeletonPart.Adornee = part
            skeletonPart.Transparency = 0.5
            skeletonPart.Color3 = Color3.new(1, 1, 1)  -- White color
            skeletonPart.Parent = part
        end
    end
end

-- Function to remove skeleton from a player
local function removeSkeleton(player)
    local character = player.Character
    if not character then return end

    for _, part in ipairs(character:GetChildren()) do
        if part:IsA("BasePart") then
            for _, adornment in ipairs(part:GetChildren()) do
                if adornment:IsA("BoxHandleAdornment") then
                    adornment:Destroy()
                end
            end
        end
    end
end

-- Add skeleton to all existing players
for _, player in ipairs(Players:GetPlayers()) do
    if player ~= LocalPlayer then
        createSkeleton(player)
    end
end

-- Listen for new players joining
Players.PlayerAdded:Connect(function(player)
    if player ~= LocalPlayer then
        player.CharacterAdded:Connect(function()
            createSkeleton(player)
        end)
    end
end)

-- Listen for players leaving
Players.PlayerRemoving:Connect(function(player)
    if player ~= LocalPlayer then
        removeSkeleton(player)
    end
end)

-- Update skeletons for players whose characters reset
Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        createSkeleton(player)
    end)
end)
