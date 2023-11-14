local userStats = {
    originalStress = 0
}

local depressingQuotes = {
    "I've been having dark thoughts recently...",
    "I'm not sure I can go on much longer...",
    "This is not worth it anymore...",
    "Maybe I'm a better zombie than I am survivor..."
}

local lovelyQuotes = {
    "Maybe life is worth living...",
    "I mean, killing zombies is pretty fun...",
    "What am I even talking about? I love life...",
    "I'm very happy..."
}

function userStats.activatePlayerStats()
    local player = getSpecificPlayer(0) 
    local stats = player:getStats()
    local originalStressVal = stats:getStress()
    userStats.originalStress = originalStressVal;
    stats:setStress(1)
    local sadQuote = ZombRand(4) + 1
    player:Say(depressingQuotes[sadQuote])
end

function userStats.deactivatePlayerStats()
    local player = getSpecificPlayer(0) 
    local stats = player:getStats()
    stats:setStress(userStats.originalStress)
    local goodQuote = ZombRand(4) + 1
    player:Say(lovelyQuotes[goodQuote])
end

return userStats
