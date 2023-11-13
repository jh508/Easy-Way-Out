
local function OnClientCommand(module, command, player, args)
    local commandSenderSteamID = player:getSteamID()

end

-- Triggered event when the client sends a command to the server
Events.OnClientCommand.Add(OnClientCommand)
