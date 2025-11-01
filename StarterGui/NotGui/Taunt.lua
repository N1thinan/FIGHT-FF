local UIS = game:GetService("UserInputService")
local plr = game.Players.LocalPlayer
local char = plr.Character


local key = 'F'

local Taunt = Instance.new("Animation")
Taunt.AnimationId = 'rbxassetid://5105221684' -- other animations 2262820217, 2262813409, 2425154387, 
local taunted = false

UIS.InputBegan:Connect(function(Input, IsTyping)
 if IsTyping then return end
 local KeyPressed = Input.KeyCode
 if KeyPressed == Enum.KeyCode[key] then
  taunted = true
  local LoadAnimation = char.Humanoid:LoadAnimation(Taunt)
  LoadAnimation:Play()
  wait(2)
  taunted = false
 end
end)