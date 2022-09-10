--[[
    CharacterCreation.lua
    CoIorEvent
    Created on 08/28/2022 @ 11:07:11
    
    Description:
        No description provided.
    
    Documentation:
        No documentation provided.
--]]

--= Module Loader =--
local require = require(game.ReplicatedStorage:WaitForChild("Infinity"))

--= Root =--
local CharacterCreation = {}

--= Jobs =--
local Replicator = require("jobs/net/Replicator")

--= Classes =--

--= Modules & Config =--

--= Roblox Services =--
local Players = game:GetService("Players")

--= Object References =--
local Player = Players.LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
local CharCreator = PlayerGui:WaitForChild("CharCreator")
local CharCreatorFrame = CharCreator.Frame
-- local FirstNameBox = CharCreatorFrame.First
-- local LastNameBox = CharCreatorFrame.Last
-- local CharCreateButton = CharCreatorFrame.TextButton

--= Constants =--

--= Variables =--

--= Shorthands =--

--= Functions =--

--= Job API =--

--= Job Initializers =--
function CharacterCreation:InitAsync(): nil
	local Ultimate = Replicator:FetchFromServer("GetUltimate")
	print(Ultimate)
	-- CharCreateButton.MouseButton1Click:Connect(function()
	-- Replicator:SendToServer("UpdateChar", { FirstName = FirstNameBox.Text, LastName = LastNameBox.Text })
	-- end)
end

function CharacterCreation:Init(): nil end

--= Return Job =--
return CharacterCreation
