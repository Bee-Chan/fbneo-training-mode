assert(rb,"Run fbneo-training-mode.lua")

print "Known issues with kof98:"
print "Doesn't activate MAX properly"
print "Only partial support for advance with refilling max meter"
print ""

p1maxhealth = 0x67
p2maxhealth = 0x67

p1maxmeter = 0x80
p2maxmeter = 0x80

local p1health = 0x108239
local p2health = 0x108439

local p1meter = 0x1081e8
local p2meter = 0x1083e8

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
		combotexty=38,
		comboenabled=true,
		p1healthx=33,
		p1healthy=20,
		p1healthenabled=true,
		p2healthx=260,
		p2healthy=20,
		p2healthenabled=true,
		p1meterx=107,
		p1metery=204,
		p1meterenabled=true,
		p2meterx=186,
		p2metery=204,
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
	return rb(p1meter)
end

function writePlayerOneMeter(meter)
	wb(p1meter, meter)
	if meter==p1maxmeter then
		wb(0x1082e3, 3) -- advance
		ww(p1meter+4, 0x4000) -- set up the timer
		wb(p1meter+8, 0x10) -- activate
	end
end

function readPlayerTwoMeter()
	return rb(p2meter)
end

function writePlayerTwoMeter(meter)
	wb(p2meter, meter)
	if meter==p2maxmeter then
		wb(0x1084e3, 3) -- advance
		ww(p2meter+4, 0x4000)
		wb(p2meter+8, 0x10)
	end
end

function infiniteTime()
	ww(0x10A83a, 0x6000)
end

function Run() -- runs every frame
	infiniteTime()
end
