--[[------------------------------------------------------------
163UI File
---------------------------------------------------------------]]

local addonName, private = ...

local tonumber = tonumber;
local strmatch = strmatch;
local UnitGUID = UnitGUID;
local GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit;
local GetNamePlates = C_NamePlate.GetNamePlates;
local IsInInstance = IsInInstance;
local UnitIsPlayer = UnitIsPlayer;


local _M = {  };
local _F = CreateFrame("FRAME");
_F:SetScript("OnEvent", function(self, event, ...)
	return _M[event](self, event, ...);
end);

local function GetUnitID(unit)
	local guid = UnitGUID(unit);
	if guid then
		local id = strmatch(guid, "-(%d+)-%x+$");
		return id;
	end
end

local _orig_width = nil;
local _orig_height = nil;

local _NoOtherPlateAddon = not (IsAddOnLoaded("neatplates") or IsAddOnLoaded("tidyplates_threatplates"));

local _U = {  };
local _S = {  };
local _H = {  };
local _T = {
	--	爆炸物
	explosive = {
		enabled = false,
		id = "120651",
		scale_width = 2.0,
		scale_height = 2.0,
		color = { 1, 0, 1, },
	},
	--	怨毒影魔
	spiteful = {
		enabled = false,
		id = "174773",
		scale_width = 2.0,
		scale_height = 2.0,
		color = { 1, 0, 0.5, },
		obvious = false,
		callback = function(plate)
			_H[plate] = "spiteful";
		end,
	},
};


local function proc(plate, unit, UnitFrame)
	_H[plate] = nil;
	_U[plate] = nil;
	if _NoOtherPlateAddon then
		UnitFrame = plate.UnitFrame or UnitFrame;
		if UnitFrame ~= nil then
			unit = UnitFrame.unit or unit;
			-- print(unit, select(2, IsInInstance()) == "party", not UnitIsPlayer(unit), not UnitIsTapDenied(unit))
			if select(2, IsInInstance()) == "party" and not UnitIsPlayer(unit) and not UnitIsTapDenied(unit) then
				for which, _val in next, _T do
					if _val.enabled then
						local unitid = GetUnitID(unit);
						-- print(unitid)
						if unitid == _val.id then
							local healthBar = UnitFrame.healthBar;
							_orig_width = _orig_width or healthBar:GetWidth();
							_orig_height = _orig_height or healthBar:GetHeight();
							healthBar:SetWidth(_orig_width * _val.scale_width);
							healthBar:SetHeight(_orig_height * _val.scale_height);
							healthBar:SetStatusBarColor(_val.color[1], _val.color[2], _val.color[3], 1);
							_U[plate] = true;
							if _val.callback ~= nil then
								_val.callback(plate);
							end
							return;
						end
					end
				end
			end
		end
	end
	if _S[plate] ~= nil then
		_S[plate]:Hide();
	end
end
hooksecurefunc("CompactUnitFrame_OnUpdate", function(UnitFrame)
	if not UnitFrame:IsForbidden() then
		local _plate = UnitFrame:GetParent();
		if not _plate:IsForbidden() then
			proc(_plate, UnitFrame.unit, UnitFrame);
		end
	end
end);

function _M:NAME_PLATE_CREATED(event, plate)
	if plate ~= nil and _S[plate] == nil then
		local skull = plate:CreateTexture(nil, "OVERLAY");
		skull:SetSize(128, 64);
		skull:SetScale(0.9);
		skull:SetPoint("BOTTOM", plate, "TOP", 0, 2);
		skull:SetTexture("Interface\\Timer\\Countdown");
		skull:SetTexCoord(0.0, 0.25, 0.0, 0.5);
		skull:Hide();
		_S[plate] = skull;
	end
end
_F:RegisterEvent("NAME_PLATE_CREATED");
for _, plate in next, GetNamePlates() do
	_M:NAME_PLATE_CREATED("NAME_PLATE_CREATED", plate);
end
-- function _M:NAME_PLATE_UNIT_ADDED(event, unit)
-- 	local plate = GetNamePlateForUnit(unit);
-- 	if plate ~= nil then
-- 		proc(plate, unit);
-- 	end
-- end
-- _F:RegisterEvent("NAME_PLATE_UNIT_ADDED");
function _M:NAME_PLATE_UNIT_REMOVED(event, unit)
	local plate = GetNamePlateForUnit(unit);
	if plate ~= nil then
		local UnitFrame = plate.UnitFrame;
		if _U[plate] then
			_H[plate] = nil;
			_U[plate] = nil;
			if _S[plate] ~= nil then
				_S[plate]:Hide();
			end
			if UnitFrame ~= nil and UnitIsEnemy(unit, 'player') then
				local healthBar = UnitFrame.healthBar;
				healthBar:SetWidth(_orig_width);
				healthBar:SetHeight(_orig_height);
				healthBar:SetStatusBarColor(1, 0, 0, 1);
			end
		end
	end
end
_F:RegisterEvent("NAME_PLATE_UNIT_REMOVED");

C_Timer.NewTicker(0.1, function()
	for plate, which in next, _H do
		if _T[which].obvious then
			local UnitFrame = plate.UnitFrame;
			-- print(UnitFrame:IsForbidden(), UnitFrame.unit, _S[UnitFrame])
			if not UnitFrame:IsForbidden() then
				local unit = UnitFrame.unit;
				if unit ~= nil then
					-- print(unit, UnitIsUnit(unit .. 'target', 'player'));
					if _S[plate] == nil then
						_M:NAME_PLATE_CREATED("NAME_PLATE_CREATED", plate);
					end
					if UnitIsUnit(unit .. 'target', 'player') then
						_S[plate]:Show();
					else
						_S[plate]:Hide();
					end
				end
			end
		elseif _S[plate] ~= nil then
			_S[plate]:Hide();
		end
	end
end);


function _M:ADDON_LOADED(event, addon)
	addon = strlower(addon);
	if addon == "neatplates" or addon == "tidyplates_threatplates" then
		_NoOtherPlateAddon = false;
	end
end
_F:RegisterEvent("ADDON_LOADED");

private.MythicDungeonPlusNamePlate = {
	toggle = function(which, v, loading)
		_T[which].enabled = v;
		if not loading then
			if v then
				for i, plate in next, GetNamePlates() do
					proc(plate);
				end
			else
				if _orig_width then
					for i, plate in next, GetNamePlates() do
						plate.healthBar:SetWidth(_orig_width);
					end
				end
				if _orig_height then
					for i, plate in next, GetNamePlates() do
						plate.healthBar:SetHeight(_orig_height);
					end
				end
			end
		end
	end,
	width = function(which, scale)
		_T[which].scale_width = scale;
		for _, plate in next, GetNamePlates() do
			proc(plate);
		end
	end,
	height = function(which, scale)
		_T[which].scale_height = scale;
		for _, plate in next, GetNamePlates() do
			proc(plate);
		end
	end,
	obvious = function(which, v)
		_T[which].obvious = v;
	end,
};

--	test
if false then
	_T.__TEST = {
		enabled = true,
		id = "166718",
		scale_width = 4.0,
		scale_height = 2.0,
		color = { 0, 1, 1, },
		obvious = true,
		callback = function(plate)
			_H[plate] = "__TEST";
		end,
	};
	IsInInstance = function() return true, "party"; end
end
