--[[
    PlayerMovement.lua
    Ahmedluai22
    Created on 10/06/2022 @ 21:50:09
    
    Description:
        No description provided.
    
    Documentation:
        No documentation provided.
--]]

--= Module Loader =--
local require                = require(game.ReplicatedStorage:WaitForChild('Infinity'))

--= Class Root =--
local PlayerMovement         = { }
PlayerMovement.__classname   = 'PlayerMovement'

--= Controllers =--

--= Other Classes =--

--= Modules & Config =--
local classify          = require('$lib/Classify')

--= Roblox Services =--

--= Instance References =--

--= Constants =--

--= Variables =--

--= Shorthands =--

--= Functions =--

--= Class Internal =--

--= Class API =--

--= Class Constructor =--
function PlayerMovement.new(): any
    local self = classify(PlayerMovement)
    
    
    
    return self
end

--= Class Properties =--
PlayerMovement.__properties = { }

--= Return Class =--
return PlayerMovement