
-- Function to check for the key press and kill the player
function checkForKeyPress()
    local player = getSpecificPlayer(0) -- Get the player
    local key1 = 37  -- Key code for the key you want to check (e.g., 25 for "K")
    local key2 = 50  -- Key code for the key you want to check (e.g., 25 for "M")
    local key3 = 31  -- Key code for the key you want to check (e.g., 25 for "S")

    if isKeyDown(key1) and isKeyDown(key2) and isKeyDown(key3) and not player:isDead() then
        player:Say("testing")
    end
end





-- Hook the function to the game's update loop
Events.OnTick.Add(checkForKeyPress)
