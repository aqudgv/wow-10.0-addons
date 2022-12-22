--[[--
	alex@0
--]]--
----------------------------------------------------------------------------------------------------
local ADDON, NS = ...;
----------------------------------------------------------------------------------------------------upvalue LUA
local math, table, string, bit = math, table, string, bit;
local type, tonumber, tostring = type, tonumber, tostring;
local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
local abs, ceil, floor, max, min, random, sqrt = abs, ceil, floor, max, min, random, sqrt;
local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat =
		format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat;
local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
local ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack = ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack;
local tConcat = table.concat;
local select = select;
local date, time = date, time;
----------------------------------------------------------------------------------------------------
local _G = _G;
local _ = nil;
----------------------------------------------------------------------------------------------------
----------------------------------------------------------------------------------------------------main
local function _debug_(...)
	print("\124cffff0000alaChat addon:\124r", ...);
end
local function _log_(...)
	print(...);
end
--------------------------------------------------
if NS.alaPopup then return; end
local alaPopup = {};
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
local DropDownList1 = DropDownList1;
local dropMenuBackdrop = {
	bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",	-- "Interface\\Buttons\\WHITE8X8";	-- "Interface\\Tooltips\\UI-Tooltip-Background",
	edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",	-- "Interface\\Tooltips\\UI-Tooltip-Border",
	tile = true,
	tileSize = 16,
	edgeSize = 16,
	insets = { left = 4, right = 4, top = 4, bottom = 4 }
};
local dropMenuBackdropColor = { TOOLTIP_DEFAULT_BACKGROUND_COLOR.r, TOOLTIP_DEFAULT_BACKGROUND_COLOR.g, TOOLTIP_DEFAULT_BACKGROUND_COLOR.b, 1.0 };
local dropMenuBackdropBorderColor = { TOOLTIP_DEFAULT_COLOR.r, TOOLTIP_DEFAULT_COLOR.g, TOOLTIP_DEFAULT_COLOR.b, 1.0};

local height = 16;
local interval = 0;
local v_to_border = 8;
local h_to_border = 8;
local menu = CreateFrame("BUTTON", nil, UIParent, "BackdropTemplate");
menu:SetFrameStrata("DIALOG");
menu:SetClampedToScreen(false);
menu:Show();
menu:SetPoint("TOPLEFT", DropDownList1, "TOPRIGHT");
menu:SetWidth(120);
menu:SetBackdrop(dropMenuBackdrop);
menu:SetBackdropColor(dropMenuBackdropColor[1], dropMenuBackdropColor[2], dropMenuBackdropColor[3], dropMenuBackdropColor[4]);
menu:SetBackdropBorderColor(dropMenuBackdropBorderColor[1], dropMenuBackdropBorderColor[2], dropMenuBackdropBorderColor[3], dropMenuBackdropBorderColor[4]);
menu:SetScript("OnClick", function(self, button)
	DropDownList1:Hide();
end);
-- DropDownList1:HookScript("OnShow", function()
-- 	if DropDownList1.dropdown.which then
-- 		menu:Show();
-- 	else
-- 		menu:Hide();
-- 	end
-- end);
-- DropDownList1:HookScript("OnHide", function()
-- 	menu:Hide();
-- end);
-- menu:Hide();
-- local _Hide = menu.Hide;
-- function menu:Hide()
-- 	_Hide(self);
-- 	-- C_Timer.After(0.05, function() UIDropDownMenu_RegisterCustomFrame(DropDownList1, menu); end)
-- end
-- UIDropDownMenu_RegisterCustomFrame(DropDownList1, menu);
-- C_Timer.NewTicker(0.05, function()
-- 	local customFrames = DropDownList1.customFrames;
-- 	if customFrames ~= nil then
-- 		for index = 1, #customFrames do
-- 			if customFrames[index] == menu then
-- 				return;
-- 			end
-- 		end
-- 	end
-- 	UIDropDownMenu_RegisterCustomFrame(DropDownList1, menu);
-- end);

local func = {  };
local buttons = {  };
local meta = {  };
local list = {  };
local target = nil;
local which = nil;


local mask = CreateFrame("BUTTON", menu);
mask:SetPoint("TOPLEFT", menu);
mask:SetPoint("BOTTOMRIGHT", menu);
mask:SetScript("OnClick", function(self)
	self:Hide();
	self:EnableMouse(false);
	func.set_num(0);
end)
mask:SetFrameStrata("FULLSCREEN_DIALOG");

local _Hide = menu.Hide;
local _Show = menu.Show;
function menu:Show()
	self:SetAlpha(1.0);
	self:EnableMouse(true);
	mask:Hide();
end
function menu:Hide()
	self:SetAlpha(0.0);
	self:EnableMouse(false);
	mask:Show();
	mask:EnableMouse(true);
end
function menu:Hide2()
	self:SetAlpha(0.0);
	self:EnableMouse(false);
end



local function dropMenuButtonOnClick(self)
	DropDownList1:Hide();
	if not target or not which then
		target = nil;
		which = nil;
		return;
	end
	local values = list[which] or list["*"];
	local id = self.id;
	if values and values[id] then
		meta[values[id]][2](which, target);
	end
	target = nil;
	which = nil;
	func.set_num(0);
end
function func.create(menu, id, x, y)
	local button = CreateFrame("BUTTON", nil, menu);
	--button:SetFrameStrata("FULLSCREEN_DIALOG");
	button:SetHeight(height);
	--button:SetNormalTexture("Interface\\Buttons\\UI-StopButton");
	--button:SetPushedTexture("Interface\\Buttons\\UI-StopButton");
	button:SetHighlightTexture("Interface\\TargetingFrame\\UI-StatusBar");
	button:GetHighlightTexture():SetVertexColor(0.5, 0.5, 0.0, 0.75);
	button:SetPoint("TOP", menu, x, y);
	button:SetWidth(menu:GetWidth() - 2 * h_to_border);

	local text = button:CreateFontString(nil, "ARTWORK", "GameFontNormal");
	text:SetPoint("LEFT", 2, 0);
	text:SetTextColor(1.0, 1.0, 1.0, 1.0);
	button.text = text;
	
	button:SetScript("OnClick", dropMenuButtonOnClick);
	button.id = id;

	return button;
end
function func.set_num(num)
	if #buttons < num then
		for i = #buttons + 1, num do
			buttons[i] = func.create(menu, i, 0, -((i - 1) * (height + interval) + v_to_border));
		end
	elseif #buttons > num then
		for i = num + 1, #buttons do
			buttons[i]:Hide();
		end
	end
	for i = 1, num do
		buttons[i]:Show();
	end
	if num > 0 then
		menu:SetHeight(2 * v_to_border + interval * (num - 1) + height * num);
		menu:Show();
		UIDropDownMenu_RegisterCustomFrame(DropDownList1, menu);
	else
		menu:Hide2();
	end
end
function func.set(which, frame)
	if which and (list[which] or list["*"]) then
		local values = list[which] or list["*"];
		local num = #values;
		func.set_num(num);
		for i = 1, num do
			local metaval = meta[values[i]];
			if metaval[3] ~= nil then
				local key = metaval[3](which, frame);
				if key ~= nil and meta[key] ~= nil then
					metaval = meta[key];
				end
			end
			buttons[i].text:SetText(metaval[1]);
		end
	else
		func.set_num(0);
	end
end

local function hook(level, value, frame, ...)
	if level == 1 and DropDownList1:IsShown() then
		-- bnetIDAccount
		if frame and frame.which then
			target = frame;
			which = frame.which;
			func.set(frame.which, frame);
		else
			func.set(nil, nil);
		end
	end
end
hooksecurefunc("ToggleDropDownMenu", hook)

if false then
	local function hook1(self)
		print(self:GetName())
	end
	local function hook2(level, value, meta, ...)
		if level == 1 and DropDownList1:IsShown() then
			_G.aladrop = meta;
			print(meta.name, meta.server == nil and "nil" or (meta.server == "" and "empty" or meta.server), meta.which, meta.unit);
			-- bnetIDAccount
		end
	end
	local function hook3(meta, initFunction, displayMode, level, menuList)
		if level == 1 then
			-- print(meta, initFunction, displayMode, level, menuList)
		end
	end

	hooksecurefunc(DropDownList1, "Show", hook1)
	-- hooksecurefunc(DropDownList2, "Show", hook1)
	hooksecurefunc("ToggleDropDownMenu", hook2)
	hooksecurefunc("UIDropDownMenu_Initialize", hook3);
end

local function tinsert_unique(meta, value)
	for k, v in ipairs(meta) do
		if value == v then
			return;
		end
	end
	tinsert(meta, value);
end
local function tremove_value(meta, value)
	for i = #meta, 1, -1 do
		if meta[i] == value then
			tremove(meta, i);
		end
	end
end
local function add_meta(key, value)
	if type(key) == 'table' then
		local k = #meta + 1;
		meta[k] = key;
		return k;
	elseif (not key or type(key) == 'string') and type(value) == 'table' then
		key = key or #meta + 1;
		meta[key] = value;
		return key;
	end
end
local function sub_meta(key)
	if type(key) == 'table' then
		for k, v in pairs(meta) do
			if v == key then
				meta[k] = nil;
				return k;
			end
		end
	elseif type(key) == 'string' or type(key) == 'number' then
		meta[key] = nil;
		return key;
	end
end
local function exist_meta(key)
	return meta[key] ~= nil;
end
local function find_meta(value)
	if type(value) ~= 'table' then
		return nil;
	end
	for k, v in pairs(meta) do
		if v == value then
			return k;
		end
	end
end
local function add_list(which, key)
	list[which] = list[which] or {  };
	if (type(key) == 'string' or type(key) == 'number') and exist_meta(key) then
		tinsert_unique(list[which], key);
	elseif type(key) == 'table' then
		tinsert_unique(list[which], add_meta(nil, key));
	end
end
local function sub_list(which, key)
	if list[which] then
		if type(key) == 'string' or type(key) == 'number' then
			tremove_value(list[which], key);
		else
			local k = find_meta(key);
			if k then
				tremove_value(list[which], k);
			end
		end
	end
end

alaPopup.add_meta = add_meta;
alaPopup.sub_meta = sub_meta;
alaPopup.add_list = add_list;
alaPopup.sub_list = sub_list;
alaPopup.func = func;
alaPopup.menu = menu;


NS.alaPopup = alaPopup;