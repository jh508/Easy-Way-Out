-- Table instantiation to be accessed from other scripts
local userStats = {
    originalStress = 0
}

-- An array of quotes the user may say when opening the confirmation panel
local depressingQuotes = {
    "I've been having dark thoughts recently...",
    "I'm not sure I can go on much longer...",
    "This is not worth it anymore...",
    "Maybe I'm a better zombie than I am survivor..."
}

-- An array of quotes the user may say when closing the confirmation panel (The "No" button was pressed)
local lovelyQuotes = {
    "Maybe life is worth living...",
    "I mean, killing zombies is pretty fun...",
    "What am I even talking about? I love life...",
    "I'm very happy..."
}
-- A function added to the userStats table which adds specific stats to the player during the time they have the confirmation panel open
function userStats.activatePlayerStats()
    local player = getSpecificPlayer(0) 
    local stats = player:getStats()
    local originalStressVal = stats:getStress()
    userStats.originalStress = originalStressVal;
    stats:setStress(1)
    local sadQuote = ZombRand(4) + 1
    player:Say(depressingQuotes[sadQuote])
end

-- A function added to the userStats table which deactivates the stats added in the previous function when the confirmation panel is closed
function userStats.deactivatePlayerStats()
    local activateSuicide = require("suicideMain")
    local player = getSpecificPlayer(0) 
    local stats = player:getStats()
    stats:setStress(userStats.originalStress)
    if activateSuicide.isDenied == false then
    local goodQuote = ZombRand(4) + 1
    player:Say(lovelyQuotes[goodQuote])
    end
end

return userStats
