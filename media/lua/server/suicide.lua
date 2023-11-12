
function OnServerCommand(module, command, arguments)
    if module == "test" then
        if command == "command" then
            print(arguments[1])
        end
    end
end

Events.OnServerCommand.Add(OnServerCommand)
