-- suicideMain.lua

-- table instantiation to be accessed from other scripts
local activateSuicide = {}

-- Quote that will be displayed if the boolean value "denied" is false
activateSuicide.deniedQuote = "If only I had a weapon..."
-- Boolean value to determine whether or not the player can take the easy way out
activateSuicide.isDenied = true

-- Sound variables
local deathByFireArmSound = "9mmShot"
local deathByMeleeSound = "PZ_HeadExtract_01"

local function handlePlayerDeath(command, soundFile)
    local player = getSpecificPlayer(0)
    addBloodSplat(player:getCurrentSquare(), 200)
    getSoundManager():PlayWorldSound(soundFile, true, player:getCurrentSquare(), 0, 4, 1, false)
    player:setHealth(0)
end

-- a function inside the activateSuicide table which checks if the player is holding a weapon
function activateSuicide.killPlayer()
    local player = getSpecificPlayer(0)
    local playerPrimaryHandItem = player:getPrimaryHandItem()
    -- Get the sound manager and play the audio "9mmShot" at the players current location
    if playerPrimaryHandItem and playerPrimaryHandItem:IsWeapon() and playerPrimaryHandItem:getDisplayCategory() == "Weapon" then
        if playerPrimaryHandItem:isAimedFirearm() then
            if playerPrimaryHandItem:getCurrentAmmoCount() > 0 then
                if isClient() then
                    sendClientCommand("suicideModule", "deathByFireArm", {})
                    playerPrimaryHandItem:setCurrentAmmoCount(playerPrimaryHandItem:getCurrentAmmoCount() - 1)
                    activateSuicide.isDenied = false
                    return
                else
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
            -- If TRUE, the player is hosting the server in singleplayer
            if isClient() then
                getSoundManager():PlayWorldSound(deathByMeleeSound, true, player:getCurrentSquare(), 0, 4, 1, false)
                addBloodSplat(player:getCurrentSquare(), 200)
                sendClientCommand("suicideModule", "deathByMelee", {})
                activateSuicide.isDenied = false
            else
                getSoundManager():PlayWorldSound(deathByMeleeSound, true, player:getCurrentSquare(), 0, 4, 1, false)
                addBloodSplat(player:getCurrentSquare(), 200)
                player:setHealth(0)
                activateSuicide.isDenied = false
            end
        end
    else
        activateSuicide.isDenied = true
        player:Say(activateSuicide.deniedQuote)
    end
end

local function OnServerCommand(module, command, arguments)
    local player = getSpecificPlayer(0)
    local playerOnlineID = player:getOnlineID()

    if module == "suicideModule" then
        if command == "deathByFireArm" and playerOnlineID == arguments[1] then
            handlePlayerDeath(command, deathByFireArmSound)
        elseif command == "deathByMelee" and playerOnlineID == arguments[1] then
            handlePlayerDeath(command, deathByMeleeSound)
        end
    end
end

Events.OnServerCommand.Add(OnServerCommand)

return activateSuicide

