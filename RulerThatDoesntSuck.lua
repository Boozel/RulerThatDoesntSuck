-- rulerThatDoesntSuck
-- 	By	[Discord]@Boozel#7654
-- 		[Email] boozel1992@gmail.com
-- 	Please contact me if you have any issues.

---------------------------
-- OPERATING:
--	+ Hover over Model A
--	+ Press Scripting 1 (Default Numpad 1)
--	+ Hover over target model
--	+ Press Scripting 2 (Default Numpad 2)
-- 	You can rebind the hotkeys in TTS' keybinds.
-- 	If you need to change the hotkey used, 
-- 	change the following values to the desired key:

SCRIPTING_A = 1;
SCRIPTING_B = 2;

---------------------------
-- OUTPUT:
-- + All players will see an alert noting
-- + "3D" and "3D" distance. These display
-- + the distance with verticality included (3D)
-- + and verticality ignored (2D).
-- + This is handy for fliers that charge.

-- + Measurements use the same metric that the in-game
-- + ruler uses.

---------------------------
-- OTHER NOTES:
-- + Origin and target models are interchangeable
-- + and do not need to be re-set between
-- + measurements. In other words, 
-- + You can set an origin model and then
-- + check distance to multiple models other
-- + models without having to hit SCRIPTING_A again.

---------------------------
-- WARNING:
-- + This script works by locating the base of the
-- + respective models, and then casting a ray between
-- + them. Severe verticality can therefore cause the
-- + script to fail. Be careful with this. Draw a line
-- + between the bases with your eyes and check that
-- + no model bits would be in the way of a segment from
-- + base-to-base.


-- ENJOY!

objecta = 0
objectb = 0

function onScriptingButtonDown(index, color)
	if index == SCRIPTING_A then
		objecta = Player[color].getHoverObject()
	end
	if index == SCRIPTING_B then
		objectb = Player[color].getHoverObject()
		local hitlist1 = findDistanceA(objecta, objectb)
		local hitlist2 = findDistanceA(objectb, objecta)
		local refofa = ExtractPointFromStupidTable(hitlist1, objectb)
		local refofb = ExtractPointFromStupidTable(hitlist2, objecta)
		local result = calculateDistance(hitlist1[refofa].point, hitlist2[refofb].point)
		local resultHoriz = calculateDistanceFlat(hitlist1[refofa].point, hitlist2[refofb].point)
		broadcastToAll("2D: Player " .. color .. ": " .. hitlist1[refofa].hit_object.getName() .. " to " .. hitlist2[refofb].hit_object.getName() .. " = " .. resultHoriz, {15,15,15})
		broadcastToAll("3D: Player " .. color .. ": " .. hitlist1[refofa].hit_object.getName() .. " to " .. hitlist2[refofb].hit_object.getName() .. " = " .. result, {15,15,15})
	end
end

function findDistanceA(obja, objb)
	local hitList = Physics.cast({
			origin = {obja.GetBounds().center.x, obja.GetBounds().center.y - (obja.GetBounds().size.y / 2), obja.GetBounds().center.z},
			direction = {objb.GetBounds().center.x - obja.GetBounds().center.x, (objb.GetBounds().center.y - (objb.GetBounds().size.y / 2)) - (obja.GetBounds().center.y - (obja.GetBounds().size.y / 2)), objb.GetBounds().center.z - obja.GetBounds().center.z},
			type = 2,
			size = {1,1,1},
			maxdistance = 1,
			debug = true,
			})
	return(hitList)
end 

function calculateDistance(pointa, pointb)
	local a1minb1 = pointa.x - pointb.x
	local a2minb2 = pointa.y - pointb.y
	local a3minb3 = pointa.z - pointb.z
	a1minb1 = a1minb1 * a1minb1
	a2minb2 = a2minb2 * a2minb2
	a3minb3 = a3minb3 * a3minb3
	return math.sqrt(a1minb1 + a2minb2 + a3minb3)
end

function calculateDistanceFlat(pointa, pointb)
	local a1minb1 = pointa.x - pointb.x
	local a3minb3 = pointa.z - pointb.z
	a1minb1 = a1minb1 * a1minb1
	a3minb3 = a3minb3 * a3minb3
	return math.sqrt(a1minb1 + a3minb3)
end

function ExtractPointFromStupidTable(inlist, target)
	local i = 1
	while(inlist[i])
		do
			if inlist[i].hit_object.guid == target.guid then
			return i
		end
		i = i + 1
	end
end
