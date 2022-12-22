--[[
	All rights reserved
	by ala@163UI
--]]
local ADDON, _NS = ...;

local L = select(2, ...).L

----------------------------------------------------------------------------------------------------upvalue
	----------------------------------------------------------------------------------------------------LUA
	local math, table, string, bit = math, table, string, bit;
	local type, tonumber, tostring = type, tonumber, tostring;
	local getfenv, setfenv, pcall, xpcall, assert, error, loadstring = getfenv, setfenv, pcall, xpcall, assert, error, loadstring;
	local abs, ceil, floor, max, min, random, sqrt = abs, ceil, floor, max, min, random, sqrt;
	local format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat =
			format, gmatch, gsub, strbyte, strchar, strfind, strlen, strlower, strmatch, strrep, strrev, strsub, strupper, strtrim, strsplit, strjoin, strconcat;
	local getmetatable, setmetatable, rawget, rawset = getmetatable, setmetatable, rawget, rawset;
	local next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack = next, ipairs, pairs, sort, tContains, tinsert, tremove, wipe, unpack;
	local select = select;
	local date, time = date, time;
	----------------------------------------------------------------------------------------------------GAME
	local print = print;
	local GetTime = GetTime;
	local CreateFrame = CreateFrame;
	local GetCursorPosition = GetCursorPosition;
	local IsAltKeyDown = IsAltKeyDown;
	local IsControlKeyDown = IsControlKeyDown;
	local IsShiftKeyDown = IsShiftKeyDown;
----------------------------------------------------------------------------------------------------
	--------------------------------------------------
	local function _noop_()
	end
	--------------------------------------------------
	local __PATH = "Interface\\AddOns\\!!!163UI!!!\\Textures\\flat\\";
	local ui_theme = {
		__PATH .. "Theme\\LichKing",
		__PATH .. "Theme\\Orc",
		__PATH .. "Theme\\Rexxar",
		__PATH .. "Theme\\Gnome",
	};
	local ui_theme_focus = 384 / 1024;
	local ui_style = {
		texture_white = "Interface\\Buttons\\WHITE8X8",
		texture_unk = "Interface\\Icons\\inv_misc_questionmark",
		texture_highlight = "Interface\\Buttons\\UI-Common-MouseHilight",
		texture_triangle = "interface\\transmogrify\\transmog-tooltip-arrow",
		texture_config = "interface\\buttons\\ui-optionsbutton",

		texture_modern_arrow_bottom = __PATH .. "ArrowBottom",
		texture_modern_arrow_top = __PATH .. "ArrowTop",
		texture_modern_arrow_down = __PATH .. "ArrowDown",
		texture_modern_arrow_up = __PATH .. "ArrowUp",
		texture_modern_arrow_left = __PATH .. "ArrowLeft",
		texture_modern_arrow_right = __PATH .. "ArrowRight",
		texture_modern_rotate_left = __PATH .. "RotateLeft",
		texture_modern_rotate_right = __PATH .. "RotateRight",
		texture_modern_button_minus = __PATH .. "MinusButton",
		texture_modern_button_plus = __PATH .. "PlusButton",
		texture_modern_button_minus_clear = __PATH .. "MinusButtonClear",
		texture_modern_button_plus_clear = __PATH .. "PlusButtonClear",
		texture_modern_button_minus_clear_circle = __PATH .. "MinusButtonClearCircle",
		texture_modern_button_plus_clear_circle = __PATH .. "PlusButtonClearCircle",
		texture_modern_button_close = __PATH .. "Close",
		texture_modern_check_button_border = __PATH .. "CheckButtonBorder",
		texture_modern_check_button_center = __PATH .. "CheckButtonCenter",
		texture_modern_check_button_circle_border = __PATH .. "CheckButtonCircleBorder",
		texture_modern_check_button_circle_center = __PATH .. "CheckButtonCircleCenter",
		texture_modern_item_button_border = __PATH .. "ItemButtonIconBorderTexture",
		texture_modern_circle_border_thin = __PATH .. "CircleBorderThin",
		texture_modern_circle_border_thick = __PATH .. "CircleBorderThick",
		texture_modern_circle_border_mask = __PATH .. "Circle_White_Border",

		edgeBackdrop = {
			bgFile = "Interface\\Buttons\\WHITE8X8",
			edgeFile = "Interface\\Buttons\\WHITE8X8",
			tile = false,
			tileSize = 16,
			edgeSize = 1,
			insets = { left = 0, right = 0, top = 0, bottom = 0, },
		},

		textureButtonColorNormal = { 0.75, 0.75, 0.75, 0.75, },
		textureButtonColorPushed = { 0.25, 0.25, 0.25, 1.0, },
		textureButtonColorHighlight= { 0.25, 0.25, 0.75, 1.0, },
		textureButtonColorDisabled= { 0.5, 0.5, 0.5, 0.25, },

		colorButtonColorNormal = { 0.1, 0.1, 0.1, 0.75, },
		colorButtonColorPushed = { 0.75, 1.0, 1.0, 0.125, },
		colorButtonColorHighlight = { 0.75, 1.0, 1.0, 0.125, },
		colorButtonColorDisabled = { 0.5, 0.5, 0.5, 0.25, },

		checkButtonColorNormal = { 0.75, 0.75, 1.0, 0.25, },
		checkButtonColorPushed = { 0.75, 0.75, 1.0, 0.50, },
		checkButtonColorHighlight = { 0.75, 0.75, 1.0, 0.25, },
		checkButtonColorChecked = { 0.75, 0.75, 1.0, 0.50, },
		checkButtonColorDisabled = { 0.5, 0.5, 0.5, 0.25, },
		checkButtonColorDisabledChecked = { 0.5, 0.5, 0.5, 0.4, },

		frameFont = SystemFont_Shadow_Med1:GetFont(),	--	"Fonts\ARKai_T.ttf"
		frameFontSize = min(select(2, SystemFont_Shadow_Med1:GetFont()) + 1, 15),
		frameFontOutline = "NORMAL",

	};
	local __ns = {  };
----------------------------------------------------------------------------------------------------
local SET = nil;

local _EventHandler = CreateFrame('FRAME');
-->		--	EventHandler
	local function _EventHandler_OnEvent(self, event, ...)
		return __ns[event](...);
	end
	function _EventHandler:FireEvent(event, ...)
		local func = __ns[event];
		if func then
			return func(...);
		end
	end
	function _EventHandler:RegEvent(event)
		__ns[event] = __ns[event] or _noop_;
		self:RegisterEvent(event);
		self:SetScript('OnEvent', _EventHandler_OnEvent);
	end
	function _EventHandler:UnregEvent(event)
		self:UnregisterEvent(event);
	end
-->

local __errorHandler = geterrorhandler();
hooksecurefunc("seterrorhandler", function(handler)
	__errorHandler = handler;
end);
local xpcall = xpcall;
local function SafeCall(func, ...)
	return xpcall(func, __errorHandler, ...);
end

-->
	local callback = {  };
	callback["Dominos"] = function(v)
		Dominos:Unload()
		-- Dominos.db:ResetProfile()
		-- insert out diff
		Dominos:U1_SetPreset(v);
		Dominos.isNewProfile = nil
		Dominos:Load()
		local masque = U1GetMasqueCore and U1GetMasqueCore()
		if masque and masque.Group then masque:Group("Dominos"):ReSkinWithSub() end
		if U1DB then
			if U1DB.__dominos__preset_again == nil then
				U1DB.__dominos__preset_again = true;
			else
				U1DB.__dominos__preset_again = nil;
			end
		end
	end
	callback["Masque"] = function(v)
		local Masque = Masque or LibStub('AceAddon-3.0'):GetAddon('Masque', true);
		if Masque then
			local Group = Masque.Core.GetGroup();
			Group:__Set('SkinID', v);
		end
		if U1DB then
			if U1DB.__masque__preset_again == nil then
				U1DB.__masque__preset_again = true;
			else
				U1DB.__masque__preset_again = nil;
			end
		end
	end
	callback["SexyMap"] = function(v)
		local sm = _163ExportMeta_SexMap;
		local mod = sm.borders
		local preset = mod.presets[v] or sm.borderPresets[v]
		mod.db.borders = sm.core.deepCopyHash(preset.borders)
		mod.db.backdrop = preset.backdrop and sm.core.deepCopyHash(preset.backdrop) or sm.core.deepCopyHash(defaults.backdrop)
		sm.core.db.shape = preset.shape
		return mod:ApplySettings()
	end
	callback["GearManagerEx"] = function(v)
		if GearManagerExToolBarFrame ~= nil and SUFUnitplayer ~= nil then
			GearManagerExToolBarFrame:ClearAllPoints();
			GearManagerExToolBarFrame:SetPoint("BOTTOMLEFT", SUFUnitplayer, "TOPLEFT", 0, 0);
		end
	end
	local preset = {
		["Dominos"] = "MINI",
		["Masque"] = "Caith",
		["GearManagerEx"] = true,
	};
	-->
	local EASYFLAT_PROFNAME = "简易风格自动备份" .. UnitGUID('player');
	local function BackupProfile(name)
		--U1ProfileDetailFrame
		local prof, index = U1Profiles:CreateProfile(name, 'manual');
		if prof and index then
			U1Profiles:EditProfileOption(prof, { u1dbaddons = true, u1dbconfigs = true, });
			U1Profiles:SaveProfile(prof);
		end
	end
	local disabled = {
		[strlower"ChocolateBar"] = 1,
		[strlower"Grid"] = 1,
		[strlower"OmniCD"] = 1,
	};
	local enabled = {
		[strlower"!KalielsTracker"] = 1,
		[strlower"ShadowedUnitFrames"] = 1,
		[strlower"ShadowedUF_Options"] = 1,
		[strlower"Dominos"] = 1,
		[strlower"Masque"] = 1,
		[strlower"SexyMap"] = 1,
	};
	function _163_Preset_Simple()
		SafeCall(BackupProfile, EASYFLAT_PROFNAME);
		--
		function __ns.ADDON_LOADED(addon)
			local cb = callback[addon];
			local pr = preset[addon];
			if cb and pr then
				C_Timer.After(2.0, function() cb(pr); end);
				callback[addon] = nil;
			end
		end
		_EventHandler:RegEvent("ADDON_LOADED");
		local addonInfo = _NS.addonInfo
		for addon, info in next, addonInfo do
			if disabled[strlower(addon)] then
				DisableAddOn(addon);
			end
			if info.protected == 1 or info.defaultEnable == 1 then
			else
				if enabled[strlower(addon)] then
					if IsAddOnLoaded(addon) then
						SafeCall(__ns.ADDON_LOADED, addon);
					else
						U1LoadAddOn(addon, nil, true);
					end
				elseif info.defaultEnable == 0 then
					DisableAddOn(addon);
				end
			end
		end
		C_Timer.After(3.1, function() StaticPopup_Show("163UI_GUIDE_RELOADUI_CONFIRM", 0); end);
		for addon, cb in next, callback do
			local pr = preset[addon];
			if pr and IsAddOnLoaded(addon) then
				C_Timer.After(2.0, function() cb(pr); end);
				callback[addon] = nil;
			end
		end
		local wrap = CreateFrame("Frame", nil, UIParent)
		wrap:SetFrameStrata("TOOLTIP");
		wrap:EnableMouse(false);
		wrap:SetSize(256, 256);
		wrap:SetPoint("CENTER", 0, 256);
		wrap:Show();
		local tex = CreateFrame("BUTTON", nil, wrap);
		tex:SetFrameStrata("TOOLTIP");
		tex:EnableMouse(false);
		tex:SetSize(256, 256);
		tex:SetPoint("CENTER");
		tex:Show();
		tex:SetText(3);
		tex:GetFontString():SetFont(GameFontNormal:GetFont(), 256);
		local val = 3;
		local timer = 0.1;
		local tick = nil;
		tick = C_Timer.NewTicker(0.05, function()
			timer = timer + 0.05;
				if val <= 0 and timer >= 0.2 then
					tick:Cancel();
					tex:Hide();
					return;
				end
			if timer >= 1.0 then
				timer = timer - 1.0;
				val = val - 1;
				tex:SetText(val);
			end
		end);
		-- SaveAddOns();
	end
-->

