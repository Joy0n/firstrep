local startbtn = 4
local trigger = false
local unlimit = 1

-- 130-150-2000-1000-2000=26920 a nujno predpolojitelno 27272 ili 25000 +-100
local scroll_number = 130
local scroll_pause = 150
local craft_pause = 2000 -- 1540?
local place_pause = 1000 -- 500?
local skinning_pause = 2000 -- 1500?

function sleep(a)
	local b=GetRunningTime()+a;
	repeat until GetRunningTime()>b 
end

function random_action()
	local action = math.random(20)
	if (action==1) then PressAndReleaseKey(0x1e) end	-- a
	if (action==2) then PressAndReleaseKey(0x20) end	-- d
	--if (action==3) then PressAndReleaseKey(0x11) end	-- w
	--if (action==4) then PressAndReleaseKey(0x1f) end	-- s
	if (action==5) then PressAndReleaseKey(0x2d) end	-- x
	if (action==6) then 
		PressAndReleaseKey(0x39)	-- space
		sleep(500) 
	end
	if (action==7) then 
		PressAndReleaseKey(0x25)	-- k
		sleep(math.random(300,500)) 
		PressAndReleaseKey(0x25)
	end
	if (action==8) then 
		PressAndReleaseKey(0x24)	-- j
		sleep(math.random(300,500)) 
		PressAndReleaseKey(0x24)
	end
	if (action==9) then 
		PressAndReleaseKey(0x31)	-- n
		sleep(math.random(300,500)) 
		PressAndReleaseKey(0x31)
	end
	if (action==10) then 
		PressAndReleaseKey(0x32)	-- m
		sleep(math.random(300,500)) 
		PressAndReleaseKey(0x32)
	end

end

function try_to_do_random_action()
	local try = math.random(6)
	if (try == 1) then random_action() end
end

function scroll(x)
	local y = x/2 - 1
	while y > 0 do
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break0\n") break end
		MoveMouseWheel(-1)
		y = y - 1
		sleep(math.random(scroll_pause, scroll_pause+20))
	end
end

function process()
	while unlimit do
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break1\n") break end
		--Scrollim otkativaem1
		scroll(scroll_number)
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break2\n") break end
		--Skinim odin raz na 4
		PressAndReleaseKey(0x05)
		sleep(math.random(skinning_pause, skinning_pause+300))
		try_to_do_random_action()
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break2.1\n") break end
		--Scrollim otkativaem2
		scroll(scroll_number)
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break2.2\n") break end

		--Pereriv mejdu scrollom i na4alom crafta
		sleep(math.random(500, 800))
		try_to_do_random_action()
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break3\n") break end

		--Craftim perviy bait na 1
		PressAndReleaseKey(0x02)
		sleep(math.random(craft_pause, craft_pause+300))
		try_to_do_random_action()
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break4\n") break end

		--Craftim vtoroi bait na 2
		PressAndReleaseKey(0x03)
		sleep(math.random(craft_pause, craft_pause+300))
		try_to_do_random_action()
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break5\n") break end

		--Stavim bait na 3
		PressAndReleaseKey(0x04)
		sleep(math.random(place_pause, place_pause+150))
		try_to_do_random_action()
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break6\n") break end

		--Skinim odin raz na 4
		PressAndReleaseKey(0x05)
		sleep(math.random(skinning_pause, skinning_pause+300))
		try_to_do_random_action()
		if (IsMouseButtonPressed(3)) then OutputLogMessage("Break7\n") break end
	end
end

function OnEvent(event, arg)
	if (event == "MOUSE_BUTTON_PRESSED" and arg == startbtn) then
		trigger = not trigger
		if (trigger) then
			OutputLogMessage("Enabled\n")
			process()
		else
			OutputLogMessage("Disabled\n")
		end
	end
	if (event == "MOUSE_BUTTON_PRESSED" and arg == 3) then
		trigger = not trigger
		OutputLogMessage("Break100\n")
		return
	end
end