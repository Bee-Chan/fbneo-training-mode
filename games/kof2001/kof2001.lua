assert(rb,"Run fbneo-training-mode.lua")

p1maxhealth = 0x66
p2maxhealth = 0x66

p1maxmeter = 0x90
p2maxmeter = 0x90

local p1health = 0x108239
local p2health = 0x108439

local p1meter = 0x1081e8
local p2meter = 0x1083e8

local p1metertoggle = p1meter+0x1e3
local p2metertoggle = p2meter+0x1e3

local p1direction = 0x108131
local p2direction = 0x108331

local p1combocounter = 0x1084b0
local p2combocounter = 0x1082b0

translationtable = {
	"coin",
	"start",
	"select",
	"up",
	"down",
	"left",
	"right",
	"button1",
	"button2",
	"button3",
	"button4",
	["Coin"] = 1,
	["Start"] = 2,
	["Select"] = 3,
	["Up"] = 4,
	["Down"] = 5,
	["Left"] = 6,
	["Right"] = 7,
	["Button A"] = 8,
	["Button B"] = 9,
	["Button C"] = 10,
	["Button D"] = 11,
}

gamedefaultconfig = {
	hud = {
		combotextx=138,
		combotexty=45,
		comboenabled=true,
		p1healthx=36,
		p1healthy=21,
		p1healthenabled=true,
		p2healthx=257,
		p2healthy=21,
		p2healthenabled=true,
		p1meterx=114,
		p1metery=207,
		p1meterenabled=true,
		p2meterx=179,
		p2metery=207,
		p2meterenabled=true,
	},
}

function playerOneFacingLeft()
	return rb(p1direction)==0
end

function playerTwoFacingLeft()
	return rb(p2direction)==0
end

function playerOneInHitstun()
	return rb(p2combocounter)~=0
end

function playerTwoInHitstun()
	return rb(p1combocounter)~=0
end

function readPlayerOneHealth()
	return rb(p1health)
end

function writePlayerOneHealth(health)
	wb(p1health, health)
end

function readPlayerTwoHealth()
	return rb(p2health)
end

function writePlayerTwoHealth(health)
	wb(p2health, health)
end

function readPlayerOneMeter()
	if rb(p1metertoggle) then return p1maxmeter end
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	if (meter==p1maxmeter) then
		wb(p1metertoggle, 1)
		wb(p1meter, 0)
	else
		wb(p1meter, meter)
		wb(p1metertoggle, 0)
	end
end

function readPlayerTwoMeter()
	if rb(p2metertoggle) then return p2maxmeter end
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	if (meter==p2maxmeter) then
		wb(p2metertoggle, 1)
		wb(p2meter, 0)
	else
		wb(p2meter, meter)
		wb(p2metertoggle, 0)
	end
end

function infiniteTime()
	ww(0x10A7d2, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
