--[[
    CharacterCreationHandler.lua
    CoIorEvent
    Created on 08/28/2022 @ 11:23:39
    
    Description:
        No description provided.
    
    Documentation:
        No documentation provided.
--]]

--= Module Loader =--
local require = require(game.ReplicatedStorage:WaitForChild("Infinity"))

--= Root =--
local CharacterCreationHandler = {}

--= Jobs =--
local Replicator = require("jobs/net/Replicator")

--= Classes =--

--= Modules & Config =--

--= Roblox Services =--

--= Object References =--

--= Constants =--

--= Variables =--

--= Shorthands =--

--= Functions =--

--= Job API =--

--= Job Initializers =--
function CharacterCreationHandler:InitAsync(): nil end

function CharacterCreationHandler:Init(): nil
	Replicator:Listen("GetUltimate", function(client)
		--// This script would then return the ultimate assigned to the players data, or a new one if they dont have any.
		return "Hello World"
	end)

	Replicator:Listen("UpdateChar", function(client, values)
		client:Kick(string.format("Hello %s %s", values.FirstName, values.LastName))
	end)
end

--= Return Job =--
return CharacterCreationHandler
