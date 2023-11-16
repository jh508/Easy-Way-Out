-- quickResetMain.lua

-- table instantiation to be accessed from other scripts
local activateQuickReset = {}

-- Quote that will be displayed if the boolean value "denied" is false
activateQuickReset.deniedQuote = "If only I had a weapon..."
-- Boolean value to determine whether or not the player can take the easy way out
activateQuickReset.isDenied = true

-- Module and Command variables
local moduleName = "resetModule"
local deathByFireArmCommand = "deathByFireArm"
local deathByMeleeCommand = "deathByMelee"

-- Sound variables
local deathByFireArmSound = "9mmShot"
local deathByMeleeSound = "PZ_HeadExtract_01"

local function handlePlayerDeath(command, soundFile, onlineID, xPos, yPos, zPos)
    local player = getSpecificPlayer(0)
    addBloodSplat(getSquare(xPos, yPos, zPos), 200)
    getSoundManager():PlayWorldSound(soundFile, true, getSquare(xPos, yPos, zPos), 0, 30, 1, false)
    if player:getOnlineID() == onlineID then
        player:setHealth(0)
    end
end

-- a function inside the activateQuickReset table which checks if the player is holding a weapon
function activateQuickReset.killPlayer()
    local player = getSpecificPlayer(0)
    local playerPrimaryHandItem = player:getPrimaryHandItem()
    -- Get the sound manager and play the audio "9mmShot" at the players current location
    if playerPrimaryHandItem and playerPrimaryHandItem:IsWeapon() and playerPrimaryHandItem:getDisplayCategory() == "Weapon" then
        if playerPrimaryHandItem:isAimedFirearm() then
            if playerPrimaryHandItem:getCurrentAmmoCount() > 0 then
                -- If TRUE, the player is hosting the server in multiplayer
                if isClient() then
                    sendClientCommand(moduleName, deathByFireArmCommand, {})
                    playerPrimaryHandItem:setCurrentAmmoCount(playerPrimaryHandItem:getCurrentAmmoCount() - 1)
                    activateQuickReset.isDenied = false
                    return
                else -- Or the player is playing singleplayer
                    addBloodSplat(player:getCurrentSquare(), 200)
                    getSoundManager():PlayWorldSound(deathByFireArmSound, true, player:getCurrentSquare(), 0, 4, 1, false)
                    playerPrimaryHandItem:setCurrentAmmoCount(playerPrimaryHandItem:getCurrentAmmoCount() - 1)
                    player:setHealth(0)
                    return
                end
            else
                player:Say("If I'm going to do this... I'll need a bullet")
            end
        else
            -- If TRUE, the player is hosting the server in multiplayer
            if isClient() then
                sendClientCommand(moduleName, deathByMeleeCommand, {})
                activateQuickReset.isDenied = false
            else -- Or the player is playing singleplayer
                getSoundManager():PlayWorldSound(deathByMeleeSound, true, player:getCurrentSquare(), 0, 4, 1, false)
                addBloodSplat(player:getCurrentSquare(), 200)
                player:setHealth(0)
                activateQuickReset.isDenied = false
            end
        end
    else
        activateQuickReset.isDenied = true
        player:Say(activateQuickReset.deniedQuote)
    end
end

local function OnServerCommand(module, command, arguments)
    if module == moduleName then
        if command == deathByFireArmCommand then
            handlePlayerDeath(command, deathByFireArmSound, arguments.onlineID, arguments.x, arguments.y, arguments.z)
        elseif command == deathByMeleeCommand then
            handlePlayerDeath(command, deathByMeleeSound, arguments.onlineID, arguments.x, arguments.y, arguments.z)
        end
    end
end

Events.OnServerCommand.Add(OnServerCommand)

return activateQuickReset

