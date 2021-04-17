--[[
Works with the NTSC GameCube version only.
MD5 checksum: a824f5a7a553b7598592c6c129378262

Future plans:
  --Add support for PAL versions of Nightfire

Known Issues:
  --Island Infiltration has some timing errors once you get past the 2nd loading screen.
  --The driving level timer is totally busted.
  ]]

----- GLOBAL VARIABLES -----
local OnFootTimer = 0x802B65B2		--Memory address for the timer in on-foot levels
local DrivingTimer = 0x80378074		--Memory address for the timer in driving levels
local OnFootLevelID = 0x8029EB88	
--local DrivingLevelName = 0x800035F4 
local DrivingLevelName = 0x8036AFA4
local text = ""
local CurrentTime = 0
local IslandTimer = 0 --Island Infiltration gets its own timer because it's special
local IslandTimer2 = 0 --You get a timer! You get a timer! Everybody gets a timer!
local minutes = 0
local seconds = 0
local milliseconds = 0


function onScriptStart()
end

function onScriptCancel()
end

function onScriptUpdate()


	--On-foot levels
	if (ReadValue32(OnFootLevelID) > 117440512 
	    and ReadValue32(OnFootLevelID) < 117440584)
	or (ReadValue32(OnFootLevelID) > 117440584
		and ReadValue32(OnFootLevelID) < 117440767) then
			
			CurrentTime = ReadValue16(OnFootTimer)/100

			minutes = math.floor(CurrentTime/60)
			seconds = string.format("%02d",math.floor(CurrentTime)%60)
			milliseconds = string.sub(string.format("%.2f", CurrentTime-(math.floor(CurrentTime))),-2)

			SetScreenText("Time: " .. minutes .. ":" .. seconds .. "." .. milliseconds)



	--Driving Levels
	elseif ReadValueString(DrivingLevelName,11) == "paris_mis01"			--Paris Prelude
		or ReadValueString(DrivingLevelName,11) == "snow1a_mis3"			--Alpine Escape
		or ReadValueString(DrivingLevelName,11) == "snow2a_mis4"			--Enemies Vanquished
		or ReadValueString(DrivingLevelName,8) == "uw_mis11"				--Deep Descent
		or ReadValueString(DrivingLevelName,14) == "junglea_mis13a" then	--Island Infiltration 1

			CurrentTime = ReadValue32(DrivingTimer)

			minutes = math.floor(CurrentTime/3600)
			seconds = string.format("%02d",math.floor((CurrentTime/60)%60))
			milliseconds = string.sub(string.format("%.2f",(CurrentTime%60)/60),-2)
			IslandTimer = 0
			IslandTimer2 = 0

	
			SetScreenText("Time: " .. minutes .. ":" .. seconds .. "." .. milliseconds .. "\nCurrentTime: " .. CurrentTime)
	


	--Island Infiltration sections 2 and 3 get their own special timer because it's the only driving level with a loading screen.

	elseif ReadValueString(DrivingLevelName,14) == "jungleb_mis13b"	then	--Island Infiltration 2
			
			IslandTimer = ReadValue32(DrivingTimer) + CurrentTime

			minutes = math.floor(IslandTimer/3600)
			seconds = string.format("%02d",math.floor((IslandTimer/60)%60))
			milliseconds = string.sub(string.format("%.2f",(IslandTimer%60)/60),-2)

			SetScreenText("Time: " .. minutes .. ":" .. seconds .. "." .. milliseconds .. "\nCurrentTime: " .. CurrentTime .. "\nIslandTimer: " ..IslandTimer)

	--For whatever reason, the timer is offset by a random amount once you get to Island Infiltration's second and third loading screens.
	--I don't know what's causing this discrepancy. I may be using the wrong memory address, but I can't find anything better.
	--Unfortunately, This timer won't be accurate for Island Infiltration until there's a way to fix this.

	elseif ReadValueString(DrivingLevelName,14) == "junglec_mis13c"	then	--Island Infiltration 3

			IslandTimer2 = ReadValue32(DrivingTimer) + IslandTimer

			minutes = math.floor(IslandTimer2/3600)
			seconds = string.format("%02d",math.floor((IslandTimer2/60)%60))
			milliseconds = string.sub(string.format("%.2f",(IslandTimer2%60)/60),-2)

			SetScreenText("Time: " .. minutes .. ":" .. seconds .. "." .. milliseconds .. "\nIslandTimer: " .. IslandTimer .. "\nIslandTimer: " ..IslandTimer2)





	else text = "menu"

	end















end

function onStateLoaded()
end

function onStateSaved()
end