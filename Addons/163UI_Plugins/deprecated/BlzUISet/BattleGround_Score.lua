--[[--
	ALA@163UI
	复用代码请在显著位置标注来源【ALA@网易有爱】
--]]--

local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local GetScoreInfo = C_PvP.GetScoreInfo;
local format = format or string.format;

local PLAYER_NAME = UnitName("player");

local function dataProvider(...)
	local info = GetScoreInfo(...);
	if info ~= nil then
		--classToken
		--className
		local color = RAID_CLASS_COLORS[info.classToken];
		if color then
			if info.name == PLAYER_NAME then
				info.name = format(">>\124cff%.2x%.2x%.2x%s\124r<<", color.r * 255, color.g * 255, color.b * 255, info.name);
			else
				info.name = format("\124cff%.2x%.2x%.2x%s\124r", color.r * 255, color.g * 255, color.b * 255, info.name);
			end
		end
		return info;
	end
end

local function hook_func()
	local tableBuilder = PVPMatchScoreboard.tableBuilder;
	if tableBuilder == nil then
		return C_Timer.After(1.0, hook_func);
	end
	tableBuilder:SetDataProvider(dataProvider);
end
local function hook(frame)
	if frame.isInitialized then
		pcall(hook_func);
	else
		local _init = frame.Init;
		frame.Init = function(self)
			self.Init = _init;
			self:Init();
			pcall(hook_func);
		end
	end
end
local function do_hook()
	hook(PVPMatchScoreboard);
	hook(PVPMatchResults);
end

if IsAddOnLoaded("blizzard_pvpmatch") then
	pcall(do_hook);
else
	local f = CreateFrame("FRAME");
	f:RegisterEvent("ADDON_LOADED");
	f:SetScript("OnEvent", function(self, event, addon)
		if strlower(addon) == "blizzard_pvpmatch" then
			pcall(do_hook);
			f:UnregisterAllEvents();
			f:SetScript("OnEvent", nil);
			f = nil;
		end
	end);
end
