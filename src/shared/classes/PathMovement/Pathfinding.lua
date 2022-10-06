--[[
    Pathfinding.lua
    Riannater1234
    Created on 10/05/2022 @ 21:18:16
    
    Description:
        No description provided.
    
    Documentation:
        No documentation provided.
--]]

--= Module Loader =--
local require = require(game.ReplicatedStorage:WaitForChild(''))

--= Class Root =--
local Pathfinding         = { }
Pathfinding.__classname   = 'Pathfinding'

--= Controllers =--

--= Other Classes =--

--= Modules & Config =--
local classify          = require('$lib/Classify')

--= Roblox Services =--
local PathfindingService = game:GetService("PathfindingService")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

--= Instance References =--

--= Constants =--

--= Variables =--
local path = PathfindingService:CreatePath()
local player = Players.LocalPlayer
local character = player.Character
local humanoid = character:WaitForChild("Humanoid")

local TEST_DESTINATION = Vector3.new(100, 0, 100)

--= Shorthands =--

--= Functions =--

--= Class Internal =--

--= Class API =--

--= Class Constructor =--
function Pathfinding.new(): any
    local self = classify(Pathfinding)
    
    local function followPath(destination)
        -- Compute the path
        local success, errorMessage = pcall(function()
            path:ComputeAsync(character.PrimaryPart.Position, destination)
        end)
    
        if success and path.Status == Enum.PathStatus.Success then
            -- Get the path waypoints
            waypoints = path:GetWaypoints()
    
            -- Detect if path becomes blocked
            blockedConnection = path.Blocked:Connect(function(blockedWaypointIndex)
                -- Check if the obstacle is further down the path
                if blockedWaypointIndex >= nextWaypointIndex then
                    -- Stop detecting path blockage until path is re-computed
                    blockedConnection:Disconnect()
                    -- Call function to re-compute new path
                    followPath(destination)
                end
            end)
    
            -- Detect when movement to next waypoint is complete
            if not reachedConnection then
                reachedConnection = humanoid.MoveToFinished:Connect(function(reached)
                    if reached and nextWaypointIndex < #waypoints then
                        -- Increase waypoint index and move to next waypoint
                        nextWaypointIndex += 1
                        humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
                    else
                        reachedConnection:Disconnect()
                        blockedConnection:Disconnect()
                    end
                end)
            end
    
            -- Initially move to second waypoint (first waypoint is path start; skip it)
            nextWaypointIndex = 2
            humanoid:MoveTo(waypoints[nextWaypointIndex].Position)
        else
            warn("Path not computed!", errorMessage)
        end
    end
    
    followPath(TEST_DESTINATION)
    
    
    return self
end

--= Class Properties =--
Pathfinding.__properties = { }

--= Return Class =--
return Pathfinding