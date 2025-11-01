-- Made By Sid0The0Sloth <-- Help me a lot thank

health = 40 --the amount of health goes here

while wait() do
playername = game.Players.LocalPlayer.Name
	Player = game.Workspace:FindFirstChild(playername)
	if Player~=nil then
		h = Player:FindFirstChild("Humanoid")
		if h~=nil then
			if Player.Humanoid.Health <= health then
				h.WalkSpeed = 12
				h.JumpPower = 35
			else
				h.WalkSpeed  = 16
				h.JumpPower = 50
			end
		end
	else
	end
end