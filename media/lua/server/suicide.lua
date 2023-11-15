
local function OnClientCommand(module, command, player, args)
    local players = getOnlinePlayers()
    local playerOnlineID = player:getOnlineID()
    local commandArgs = {}
    commandArgs[1] = playerOnlineID;

    if module == "suicideModule" and command == "deathByFireArm" then
        for index = 0, players:size() - 1 do
            sendServerCommand(players:get(index), "suicideModule", "deathByFireArm", commandArgs)
        end
    end
end


-- Triggered event when the client sends a command to the server
Events.OnClientCommand.Add(OnClientCommand)
