-- suicideMain.lua

-- table instantiation to be accessed from other scripts
local activateSuicide = {}

-- Quote that will be displayed if the boolean value "denied" is false
activateSuicide.deniedQuote = "If only I had a weapon..."
-- Boolean value to determine whether or not the player can take the easy way out
activateSuicide.isDenied = true

-- a function inside the activateSuicide table which checks if the player is holding a weapon
function activateSuicide.killPlayer()
    local player = getSpecificPlayer(0)
    local playerPrimaryHandItem = player:getPrimaryHandItem()
    -- Get the sound manager and play the audio "9mmShot" at the players current location
    if playerPrimaryHandItem and playerPrimaryHandItem:IsWeapon() and playerPrimaryHandItem:getDisplayCategory() == "Weapon" then
        if playerPrimaryHandItem:isAimedFirearm() then
            if playerPrimaryHandItem:getCurrentAmmoCount() > 0 then
                sendClientCommand("suicideModule", "deathByFireArm", {})
                playerPrimaryHandItem:setCurrentAmmoCount(playerPrimaryHandItem:getCurrentAmmoCount() - 1)
                activateSuicide.isDenied = false
                return
            else
                player:Say("If I'm going to do this... I'll need a bullet")
            end
            print(playerPrimaryHandItem:getAmmoType())
        else
            -- other weapon types
        end
    else
        activateSuicide.isDenied = true
        player:Say(activateSuicide.deniedQuote)
    end
end

local function OnServerCommand(module, command, arguments)
    if module == "suicideModule" and command == "deathByFireArm" then
        local player = getSpecificPlayer(0)
        addBloodSplat(player:getCurrentSquare(), 200)
        getSoundManager():PlayWorldSound("9mmShot", true, player:getCurrentSquare(), 0, 4, 1, false)
        player:setHealth(0)
    end
end

Events.OnServerCommand.Add(OnServerCommand)

return activateSuicide
