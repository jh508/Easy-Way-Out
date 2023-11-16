-- Import necessary functions and classes from the PZ Lua API.
require "ISUI/ISPanel"

-- Create a class for your custom UI panel
local quickResetConfirmationPanel = ISPanel:derive("Kaleerie's Easy Way Out Confirmation Panel")

-- Determines whether or not the user interface panel is open
local isMenuOpen = false
local isButton2 = false
-- Loading required scripts
local userStats = require("quickResetUserStats")
local activateQuickReset = require("quickResetMain")

-- Constructor for initialising the panel
function quickResetConfirmationPanel:initialise()
    ISPanel.initialise(self)
    self.title = "Easy Way Out Confirmation"
    self.width = 300
    self.height = 200

    -- Create the first button
    self.button1 = ISButton:new(50, 50, 200, 40, "Yes", self, quickResetConfirmationPanel.onButton1Click)
    self:addChild(self.button1)
    
    -- Create the second button
    self.button2 = ISButton:new(50, 100, 200, 40, "No", self, quickResetConfirmationPanel.onButton2Click)
    self:addChild(self.button2)

    -- Set the visibility to false by default
    self:setVisible(false)
end

    -- Create a panel
   local panel = quickResetConfirmationPanel:new(100, 100, 300, 200)

-- Function to handle the first button click
    function quickResetConfirmationPanel:onButton1Click()
        activateQuickReset.killPlayer()
        isButton2 = false
        closeConfirmationPanel()
    end

    -- Function to handle the second button click
    function quickResetConfirmationPanel:onButton2Click()
        isButton2 = true
        closeConfirmationPanel()
    end

    -- Function for closing the confirmation panel
    function closeConfirmationPanel()
        panel:setVisible(false)
            if isButton2 == true then
                userStats.deactivatePlayerStats()
                userStats.activatePlayerQuote()
            end

            if activateQuickReset.isDenied == true then
                userStats.deactivatePlayerStats()
            end
        isMenuOpen = false
    end

    -- Function for opening the confirmation panel
    function openCustomUIPanel()
        panel:initialise()  -- Call the initialise function to set up the panel
        panel:addToUIManager()
        panel:setVisible(true)
        userStats.activatePlayerStats()
    end

-- Function to check for the key press
    function checkForKeyPress()
        local key1 = 67  -- Key code for the key you want to check (e.g., 67 for "F9")

        if isKeyDown(key1) and not isMenuOpen then
            openCustomUIPanel()
            isMenuOpen = true
        end
    end

-- Register an event to check user input
Events.OnTick.Add(checkForKeyPress)
