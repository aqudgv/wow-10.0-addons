--[[--
	PLUGIN: Eye of the Jailer
--]]--

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;


if __ns.__client._TocVersion < 90000 then
	return;
end

local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

----------------------------------------------------------------

-->	upvalue

do
	local dataObject = {
		type = "launcher",
		text = "宏伟宝库",
		icon = [[Interface\ICONS\achievement_dungeon_HallsofValor]],
		OnClick = function(self, ...)
			if not IsAddOnLoaded("Blizzard_WeeklyRewards") then
				LoadAddOn("Blizzard_WeeklyRewards");
			end
			local WeeklyRewardsFrame = _G.WeeklyRewardsFrame;
			if WeeklyRewardsFrame ~= nil then
				if WeeklyRewardsFrame:IsShown() then
					if InCombatLockdown() then
						WeeklyRewardsFrame:Hide();
					else
						HideUIPanel(WeeklyRewardsFrame);
					end
				else
					if InCombatLockdown() then
						WeeklyRewardsFrame:Show();
					else
						ShowUIPanel(WeeklyRewardsFrame);
					end
				end
			end
		end,
		OnTooltipShow = function(tip, ...)
			tip:AddLine("宏伟宝库")
		end,
	};

	local LibDBIcon = nil;
	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		LibDBIcon = LibStub("LibDBIcon-1.0");
		local db = __ns.__db.WeeklyRewardsMinimapButton;
		if db == nil then
			db = {  };
			__ns.__db.WeeklyRewardsMinimapButton = db;
		end
		db.minimapPos = db.minimapPos or 320
		local ldb = LibStub("LibDataBroker-1.1"):NewDataObject("WeeklyRewardsMBB", dataObject);
		LibDBIcon:Register("WeeklyRewardsMBB", ldb, db);
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		LibDBIcon:Show("WeeklyRewardsMBB");
	end
	local function _Disable(loading)
		LibDBIcon:Hide("WeeklyRewardsMBB");
	end

	__plugins['WeeklyRewardsMinimapButton'] = { _Enable, _Disable, };
end
