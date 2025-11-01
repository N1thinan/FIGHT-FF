local ReplicatedStorage = game:GetService("ReplicatedStorage")
local ServerStorage = game:GetService("ServerStorage")

local Maps = ServerStorage:WaitForChild("Maps")
local ServerStatus = ReplicatedStorage:WaitForChild("ServerStatus")
local GameLength = 180 --How long in 1 game
local Weapon = ServerStorage:WaitForChild("Weapon")

-- Game loop
while true do 
	ServerStatus.Value = "Waiting for Enough Player.."
	
	repeat wait(2) until game.Players.NumPlayers >= 2
	
	ServerStatus.Value = "Intermission.."
	
	wait(20)
	
	local plrs = {}
	for i,player in pairs(game.Players:GetPlayers()) do
		if player then
			table.insert(plrs,player) --Add player to plrs Table
		end
	end
	
	wait()
	
	local AvilableMaps = Maps:GetChildren()
	local ChosenMap = AvilableMaps[math.random(1,#AvilableMaps)]
	
	ServerStatus.Value = ChosenMap.Name.."Chosen"
	
	local CloneMap = ChosenMap:Clone()
	CloneMap.Parent = workspace --clone Map from ServerStorage to Workspace
	wait(3)
	
	local Spawnpoints = CloneMap:FindFirstChild("Spawnpoints")
	
	if not Spawnpoints then
		print("Spawnpoint not found")
	end
	
	local AvalibleSpawnPoints = Spawnpoints:GetChildren()
	
	for i,player in pairs(plrs) do
		if player then
			Character = player.Character
			
			if Character then
				--teleport to map
				Character:FindFirstChild("HumanoidRootPart").CFrame = AvalibleSpawnPoints[1].CFrame
				table.remove(AvalibleSpawnPoints,1)
				--give Double jump
				local DoubleJump = ServerStorage.DoubleJump:clone()
				DoubleJump.Parent = player.Backpack
				--give Ability
				local WeaponZ = Weapon:GetChildren()
				local WWeaponZ = WeaponZ[math.random(1,#WeaponZ)]
				local WeaponYougot = WWeaponZ:clone()
				WeaponYougot.Parent = player.Backpack
				
				local GameTag = Instance.new("BoolValue")
				GameTag.Name = "GameTag"
				GameTag.Parent = player.Character
			else
				--there's no character
				if not player then
					table.remove(plrs,i)
				end
			end
		end
	end
	
	ServerStatus.Value = "Get Ready to Play!"
	
	wait(2.3)
	
	for i = GameLength,0,-1 do
		for i,player in pairs(plrs) do
			if player then
				Character = player.Character
				if not Character then
					--player just left the game
				else
					if Character:FindFirstChild("GameTag")then
						--player's still alive
					else
						table.remove(plrs,i)--shi* he ded
						print(player.Name.." dead!")
					end
				end
			else
				table.remove(plrs,x)
				print(player.Name.." dead!")
			end
		end
		
		ServerStatus.Value = "There are "..i.." seconds remaining,And "..#plrs.." players left"
		if #plrs == 1 then --Last player Standing
			ServerStatus.Value = "And the Winner is..."
			wait(2)
			ServerStatus.Value = ""..plrs[1].Name.."!!!"
			break
		elseif #plrs == 0 then
			ServerStatus.Value = "Ok.."
			wait(1)
			ServerStatus.Value = "Nobydy won :("
			break
		elseif i == 0 then
			ServerStatus.Value = "Time up!"
			wait(2)
			ServerStatus.Value = "Nobydy won :("
			break
		end
		
		wait(1)
	end
	print("Game End")
	for i,player in pairs(game.Players:GetPlayers()) do
		Character = player.Character
		if not Character then
			--ignore
		else
			if Character:FindFirstChild("GameTag") then
				Character.GameTag:Destroy()
			end
		end
		player:LoadCharacter()
	end
	CloneMap:Destroy()
	wait(5)
	ServerStatus.Value = "Game Ended"
	
	wait(2)
end

