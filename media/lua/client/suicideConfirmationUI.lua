-- Import necessary functions and classes from the PZ Lua API.
require "ISUI/ISPanel"

-- Create a class for your custom UI panel
MyCustomUIPanel = ISPanel:derive("MyCustomUIPanel")


-- Constructor for your custom panel
function MyCustomUIPanel:initialise()
    ISPanel.initialise(self)
    self.title = "Custom UI Panel"
    self.width = 300
    self.height = 200


        -- Create the first button
        self.button1 = ISButton:new(50, 50, 200, 40, "Yes", self, MyCustomUIPanel.onButton1Click)
        self:addChild(self.button1)
    
        -- Create the second button
        self.button2 = ISButton:new(50, 100, 200, 40, "No", self, MyCustomUIPanel.onButton2Click)
        self:addChild(self.button2)

end

-- Function to handle the first button click
function MyCustomUIPanel:onButton1Click()
    print("Killing myself")
    local player = getSpecificPlayer(0)
    player:setHealth(0)
end

-- Function to handle the second button click
function MyCustomUIPanel:onButton2Click()
    
end


-- Function to open your custom UI panel
function openCustomUIPanel()
    local panel = MyCustomUIPanel:new(100, 100, 300, 200)
    panel:initialise()  -- Call the initialise function to set up the panel
    panel:addToUIManager()
    panel:setVisible(true)
end

-- Register an event to open your panel (e.g., when the game starts)
Events.OnGameStart.Add(openCustomUIPanel)
