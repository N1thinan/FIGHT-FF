local ServerStatus = game:GetService("ReplicatedStorage"):WaitForChild("ServerStatus")

script.Parent.Text = ServerStatus.Value

ServerStatus:GetPropertyChangedSignal("Value"):Connect(function()
	
	script.Parent.Text = ServerStatus.value
end)