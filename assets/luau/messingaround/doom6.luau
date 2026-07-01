pcall(function() getgenv().IY_LOADED = nil end)
if not game:IsLoaded() then game.Loaded:Wait() end

loadstring(game:HttpGet("https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source"))()

function missing(t, f, fallback)
	if type(f) == t then return f end
	return fallback
end

queueteleport =  missing("function", queue_on_teleport or (syn and syn.queue_on_teleport) or (fluxus and fluxus.queue_on_teleport))

task.spawn(function()
    local Players = game:GetService("Players")
    local TeleportCheck = false
    Players.LocalPlayer.OnTeleport:Connect(function(State)
	    if (not TeleportCheck) and queueteleport then
		    TeleportCheck = true
		    queueteleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/gayloo/genassets/refs/heads/main/assets/luau/messingaround/doom6.luau'))()")
	    end
    end)
end)

local LocalPlayer = game.Players.LocalPlayer
local RunService = game:GetService("RunService")

game:GetService("UserInputService")

local v1 = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = v1:WaitForChild("HumanoidRootPart")
local Humanoid = v1:WaitForChild("Humanoid")

Humanoid.WalkSpeed = 29
Humanoid.JumpPower = 40
Humanoid.AutoRotate = true

local SlipperyMovement = Instance.new("BodyVelocity")

SlipperyMovement.Velocity = Vector3.new(0, 0, 0)
SlipperyMovement.MaxForce = Vector3.new(10000, 0, 10000)
SlipperyMovement.P = 1250
SlipperyMovement.Name = "SlipperyMovement"
SlipperyMovement.Parent = HumanoidRootPart

local v2 = Vector3.new(0, 0, 0)

RunService.RenderStepped:Connect(function()
	local MoveDirection = Humanoid.MoveDirection
	local v1 = Vector3.new(MoveDirection.X, 0, MoveDirection.Z)

	v2 = if v1.Magnitude > 0 then v2:Lerp(v1.Unit * 29, 0.5) else v2 * 0.8
	SlipperyMovement.Velocity = Vector3.new(v2.X, 0, v2.Z)
end)
