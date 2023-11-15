
local function OnClientCommand(module, command, player, args)
    if module == "suicideModule" and command == "deathByFireArm" then
        local players = getOnlinePlayers()
        local playerOnlineID = player:getOnlineID()
        local commandArgs = {}
        commandArgs[1] = playerOnlineID;
        addSound(player, player:getCurrentSquare():getX(), player:getCurrentSquare():getY(), player:getCurrentSquare():getZ(), 30, 1.0)
        
        for index = 0, players:size() - 1 do
            sendServerCommand(players:get(index), "suicideModule", "deathByFireArm", commandArgs)
        end
    else
        if module == "suicideModule" and command == "deathByMelee" then
            local players = getOnlinePlayers()
            local playerOnlineID = player:getOnlineID()
            local commandArgs = {}
            commandArgs[1] = playerOnlineID;

            for index = 0, players:size() - 1 do
                sendServerCommand(players:get(index), "suicideModule", "deathByMelee", commandArgs)
            end
        end
    end
end


-- Triggered event when the client sends a command to the server
Events.OnClientCommand.Add(OnClientCommand)
