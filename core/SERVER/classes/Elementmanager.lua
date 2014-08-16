-- #######################################
-- ## Project:  MultiGamemode           ##
-- ## Name: 	Elementmanager          ##
-- ## Author:	StiviK                  ##
-- ## Version: 	1.0                     ##
-- #######################################

-- This is the Elementmanager for a MultiGamemode
-- (it needs to be a part of the Gamemode-Class)

function Gamemode:createBlip (...)
	local element = createBlip(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Blip"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createBlipAttachedTo (...)
	local element = createBlipAttachedTo(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Blip"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColCircle (...)
	local element = createColCircle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColCuboid (...)
	local element = createColCuboid(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColPolygon (...)
	local element = createColPolygon(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColRectangle (...)
	local element = createColRectangle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColSphere (...)
	local element = createColSphere(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createColTube (...)
	local element = createColTube(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["ColShape"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createEffect (...)
	local element = createEffect(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Effect"], element)
		return element;
	else
		return false;
	end
end

--function Gamemode:createElement (...)
--end

function Gamemode:createExplosion (...)
	local element = createExplosion(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		--table.insert(self.Elements[""], element) // It's just a boolean as retun!
		return element;
	else
		return false;
	end
end

function Gamemode:createFire (...)
	local element = createFire(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		--table.insert(self.Elements[""], element) // It's just a boolean as retun!
		return element;
	else
		return false;
	end
end

function Gamemode:createMarker (...)
	local element = createMarker(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Marker"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createObject (...)
	local element = createObject(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Object"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createPed (...)
	local element = createPed(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Ped"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createPickup (...)
	local element = createPickup(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Pickup"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createProjectile (...)
	local element = createProjectile(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Projectile"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createRadarArea (...)
	local element = createRadarAreaRadarArea(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["RadarArea"], element)
		return element;
	else
		return false;
	end
end

--function Gamemode:createResource (...)
--end

function Gamemode:createSWATRope (...)
	return error("Bad Argument @ Gamemode.createSWATRope! [createSWATRope does not work currently Serverside!]");
end

function Gamemode:createVehicle (...)
	local element = createVehicle(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Vehicle"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createWater (...)
	local element = createWater(...)
	setElementDimension(element, self.Dimension)
	
	if (element) then
		table.insert(self.Elements["Water"], element)
		return element;
	else
		return false;
	end
end

function Gamemode:createWeapon (...)
	return error("Bad Argument @ Gamemode.createWeapon! [createWeapon does not work currently Serverside!]");
end