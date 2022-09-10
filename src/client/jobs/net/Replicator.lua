--[[
    Replicator.lua
    FriendlyBiscuit
    Created on 05/04/2022 @ 14:22:18
    
    Description:
        Client side network event replication queue handler.
        Allows you to listen to server-queued RemoteEvent calls as well as send queued events.
    
    Documentation:
        <void> ::Listen(eventKey: string, callback: (...any) -> ())
        -> Creates a listener for the specified key that executes the callback when that event is received.
           Example:
           
           Replicator:Listen("CLIENT_MESSAGE", function(message: string)
               print("I received a message from the server!", message)
           end)
        
        <void> ::SendToServer(eventKey: string, ...: any)
        -> Queues up and fires the replication event with the specified arguments.
           Example:
           
           Replicator:SendToServer("SERVER_MESSAGE", "Hello, world!")

		<any> ::FetchFromServer(functionKey: string, ...: any)
		-> Queues up and fires the replication function with the specified arguments.
		   Example:

		   Replicator:FetchFromServer("PLAYER_DATA", "INVENTORY")

--]]

--= Root =--
local Replicator = { Priority = 1 }

--= Roblox Services =--
local rep_svc = game:GetService("ReplicatedStorage")

--= Object References =--
local main_event
local main_function

--= Constants =--
local EVENT_UUID = game.JobId
local FUNCTION_UUID = game.JobId .. "2"
local MESSAGES = {
	NO_LISTENER = "Failed to handle replicated event %q from the server - no event listener registered!",
}

--= Variables =--
local listeners = {}

--= Internal Functions =--
local function format(template: string, ...): string
	return "[ReplicatorClient] " .. MESSAGES[template]:format(...)
end

--= Job API =--
function Replicator:Listen(key: string, callback: (...any) -> ())
	local listener = listeners[key]

	if listener then
		table.insert(listener, callback)
	else
		listeners[key] = { callback }
	end
end

function Replicator:SendToServer(key: string, ...: any)
	while not main_event do
		task.wait(1)
	end
	main_event:FireServer(key, ...)
end

function Replicator:FetchFromServer(key: string, ...: any)
	while not main_function do
		task.wait(1)
	end
	return main_function:InvokeServer(key, ...)
end

--= Job Initializers =--
function Replicator:Run()
	if EVENT_UUID == "" or self.FLAGS.IS_STUDIO then
		EVENT_UUID = "REPLICATOR_STUDIO"
	end

	if FUNCTION_UUID == "2" or self.FLAGS.IS_STUDIO then
		FUNCTION_UUID = "REPLICATOR_STUDIO2"
	end

	main_event = rep_svc:WaitForChild(EVENT_UUID)
	main_function = rep_svc:WaitForChild(FUNCTION_UUID)

	if main_event then
		main_event.OnClientEvent:Connect(function(key: string, ...: any)
			local listener = listeners[key]

			if listener then
				for _, callback in pairs(listener) do
					callback(...)
				end
			else
				warn(format("NO_LISTENER", key))
			end
		end)
	else
		error()
	end
end

--= Return Job =--
return Replicator
