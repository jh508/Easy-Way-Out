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
    if playerPrimaryHandItem and playerPrimaryHandItem:IsWeapon() and playerPrimaryHandItem:getDisplayCategory() == "Weapon" then
        if playerPrimaryHandItem:isAimedFirearm() then
            
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
