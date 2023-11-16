
local function OnClientCommand(module, command, player, args)
    if module == "resetModule" and command == "deathByFireArm" then
        local players = getOnlinePlayers()
        local playerOnlineID = player:getOnlineID()
        local commandArgs = {}
        commandArgs.onlineID = playerOnlineID;
        commandArgs.x = player:getCurrentSquare():getX()
        commandArgs.y = player:getCurrentSquare():getY()
        commandArgs.z = player:getCurrentSquare():getZ()
        addSound(player, player:getCurrentSquare():getX(), player:getCurrentSquare():getY(), player:getCurrentSquare():getZ(), 30, 1.0)
        for index = 0, players:size() - 1 do
            sendServerCommand(players:get(index), "resetModule", "deathByFireArm", commandArgs)
        end
    else
        if module == "resetModule" and command == "deathByMelee" then
            local players = getOnlinePlayers()
            local playerOnlineID = player:getOnlineID()
            local commandArgs = {}
            commandArgs.onlineID = playerOnlineID;
            commandArgs.x = player:getCurrentSquare():getX()
            commandArgs.y = player:getCurrentSquare():getY()
            commandArgs.z = player:getCurrentSquare():getZ()

            for index = 0, players:size() - 1 do
                sendServerCommand(players:get(index), "resetModule", "deathByMelee", commandArgs)
            end
        end
    end
end


-- Triggered event when the client sends a command to the server
Events.OnClientCommand.Add(OnClientCommand)
