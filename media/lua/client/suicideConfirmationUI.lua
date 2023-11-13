-- Import necessary functions and classes from the PZ Lua API.
require "ISUI/ISPanel"

-- Create a class for your custom UI panel
local suicideConfirmationPanel = ISPanel:derive("Kaleerie's Easy Way Out Confirmation Panel")

local isMenuOpen = false

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

local playerStats = {
    originalStress = 0
}

-- Constructor for your custom panel
function suicideConfirmationPanel:initialise()
    ISPanel.initialise(self)
    self.title = "Easy Way Out Confirmation"
    self.width = 300
    self.height = 200

    -- Create the first button
    self.button1 = ISButton:new(50, 50, 200, 40, "Yes", self, suicideConfirmationPanel.onButton1Click)
    self:addChild(self.button1)
    
    -- Create the second button
    self.button2 = ISButton:new(50, 100, 200, 40, "No", self, suicideConfirmationPanel.onButton2Click)
    self:addChild(self.button2)

    -- Set the visibility to false by default
    self:setVisible(false)
end

    -- Create a panel
   local panel = suicideConfirmationPanel:new(100, 100, 300, 200)

-- Function to handle the first button click
    function suicideConfirmationPanel:onButton1Click()
        local player = getSpecificPlayer(0)  -- Assuming you're getting the local player
        player:setHealth(0)
        closeSuicideConfirmPanel()
    end


    -- Function to handle the second button click
    function suicideConfirmationPanel:onButton2Click()
        sendClientCommand("MyModule", "MyCommand",  {})
        closeSuicideConfirmPanel()
    end

    function closeSuicideConfirmPanel()
        panel:setVisible(false)
        deactivatePlayerStats()
        isMenuOpen = false
    end

    -- Function to open your custom UI panel
    function openCustomUIPanel()
        panel:initialise()  -- Call the initialise function to set up the panel
        panel:addToUIManager()
        panel:setVisible(true)
        activatePlayerStats()
    end

-- Function to check for the key press and kill the player
    function checkForKeyPress()
        local key1 = 67  -- Key code for the key you want to check (e.g., 67 for "F9")

        if isKeyDown(key1) and not isMenuOpen then
            openCustomUIPanel()
            isMenuOpen = true
        end
    end

    function activatePlayerStats()
        local player = getSpecificPlayer(0) 
        local stats = player:getStats()
        local originalStressVal = stats:getStress()
        playerStats.originalStress = originalStressVal;
        print(playerStats.originalStress)
        stats:setStress(1)
        local sadQuote = ZombRand(4) + 1
        player:Say(depressingQuotes[sadQuote])
    end

    function deactivatePlayerStats()
        local player = getSpecificPlayer(0) 
        local stats = player:getStats()
        stats:setStress(playerStats.originalStress)
        local goodQuote = ZombRand(4) + 1
        player:Say(lovelyQuotes[goodQuote])
    end

-- Register an event to open your panel (e.g., when the game starts)
Events.OnTick.Add(checkForKeyPress)
