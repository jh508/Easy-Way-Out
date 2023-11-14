-- suicideMain.lua

-- table instantiation to be accessed from other scripts
local activateSuicide = {}

-- Quote that will be displayed if the boolean value "denied" is false
activateSuicide.deniedQuote = "If only I had a weapon..."
-- Boolean value to determine whether or not the player can take the easy way out
activateSuicide.denied = false

-- a function inside the activateSuicide table which checks if the player is holding a weapon
function activateSuicide.killPlayer()
    local player = getSpecificPlayer(0)
    local playerPrimaryHandItem = player:getPrimaryHandItem()
    -- Get the sound manager and play the audio "9mmShot" at the players current location
    getSoundManager():PlayWorldSound("9mmShot", true, player:getCurrentSquare(), 0, 4, 1, false)

    if playerPrimaryHandItem and playerPrimaryHandItem:IsWeapon() and playerPrimaryHandItem:getDisplayCategory() == "Weapon" then
        if playerPrimaryHandItem:isAimedFirearm() then
            if playerPrimaryHandItem:getCurrentAmmoCount() > 0 then
                addBloodSplat(player:getCurrentSquare(), 200)
                player:setHealth(0)
            else
                player:Say("If I'm going to do this... I'll need a bullet")
            end
            print(playerPrimaryHandItem:getAmmoType())
        else
            
        end
       -- player:setHealth(0)
        activateSuicide.denied = false
    else
        activateSuicide.denied = true
        player:Say(activateSuicide.deniedQuote)
    end
end

return activateSuicide
