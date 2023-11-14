-- suicideMain.lua

local activateSuicide = {}

activateSuicide.deniedQuote = "If only I had a weapon..."
activateSuicide.denied = false

function activateSuicide.killPlayer()
    local player = getSpecificPlayer(0)
    if player:getPrimaryHandItem() and player:getPrimaryHandItem():IsWeapon() and player:getPrimaryHandItem():getDisplayCategory() == "Weapon" then
        player:setHealth(0)
        activateSuicide.denied = false
    else
        activateSuicide.denied = true
        player:Say(activateSuicide.deniedQuote)
    end
end

return activateSuicide
