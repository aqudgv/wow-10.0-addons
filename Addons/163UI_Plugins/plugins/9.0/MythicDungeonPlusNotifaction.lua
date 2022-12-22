--[[------------------------------------------------------------
163UI File
---------------------------------------------------------------]]
do return end
local addonName, private = ...

local _NOTIFACTION_POINT = { 0.20, 0.40, 0.60, 0.80, 1.00, };
local _NOTIFACTION_RANGE = 0.05;

---------------------------------------------------------------
local __ns = {  };
local _frame = CreateFrame("FRAME");
_frame:SetScript("OnEvent", function(self, event, ...)
	__ns[event](...);
end);

local _enabled_Manifestation_of_Pride = false;
local _enabled_Belligerent_Boast = false;
local GUID = UnitGUID('player');
local _is_in_chanllenge = false;
local _reported_progress = {  };

local IsInRaid, IsInGroup = _G.IsInRaid, _G.IsInGroup;
local SendChatMessage = _G.SendChatMessage;
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo;
local GetSpellLink = _G.GetSpellLink;
local C_Scenario_GetCriteriaInfo = _G.C_Scenario.GetCriteriaInfo;
local CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo;
local C_ChallengeMode_GetActiveKeystoneInfo = _G.C_ChallengeMode.GetActiveKeystoneInfo;

local function _Report(msg)
	local channel = nil;
	if IsInRaid(LE_PARTY_CATEGORY_INSTANCE) or IsInGroup(LE_PARTY_CATEGORY_INSTANCE) then
		channel = "INSTANCE_CHAT";
	elseif IsInRaid(LE_PARTY_CATEGORY_HOME) then
		channel = "RAID";
	elseif IsInGroup(LE_PARTY_CATEGORY_HOME) then
		channel = "PARTY";
	else
	end
	if channel ~= nil then
		SendChatMessage(msg, channel);
	else
		ChatFrame1:AddMessage(msg);
	end
end

--	狂妄吹嘘
function __ns.COMBAT_LOG_EVENT_UNFILTERED()
	local ts, ce, hideCaster, srcGUID, srcName, srcFlags, srcRaidFlags, dstGUID, dstName, dstFlags, dstRaidFlags, spellId, spellName, spellSchool = CombatLogGetCurrentEventInfo();
	if ce == "SPELL_AURA_APPLIED" and spellId == 342466 then
		if dstGUID == GUID then
			local link = GetSpellLink(spellId);
			if link == nil then
				if spellName ~= nil then
					link = "[" .. spellName .. "]";
				else
					link = "[狂妄吹嘘]";
				end
			end
			_Report("注意方向！ " .. link);
		end
	end
end

--	傲慢具象-刷新
function __ns.CHALLENGE_MODE_START()
	local activeKeystoneLevel, activeAffixIDs, wasActiveKeystoneCharged = C_ChallengeMode_GetActiveKeystoneInfo();
	if activeKeystoneLevel ~= nil and activeKeystoneLevel >= 10 then
		if _enabled_Belligerent_Boast then
			_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end
		_is_in_chanllenge = true;
		_reported_progress = {  };
	end
end
function __ns.CHALLENGE_MODE_COMPLETED()
	if _enabled_Belligerent_Boast then
		_frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
	end
	_is_in_chanllenge = false;
end
__ns.CHALLENGE_MODE_RESET = __ns.CHALLENGE_MODE_START;

local function hook_ScenarioTrackerProgressBar_SetValue(self, value)
	if _enabled_Manifestation_of_Pride then
		if _is_in_chanllenge and self.criteriaIndex then
			local criteriaString, criteriaType, completed, quantity, totalQuantity, flags, assetID, quantityString, criteriaID, duration, elapsed, criteriaFailed, isWeightedProgress = C_Scenario_GetCriteriaInfo(self.criteriaIndex);
			local currentQuantity = quantityString and tonumber(strsub(quantityString, 1, -2));
			if currentQuantity and totalQuantity then
				local percent = currentQuantity / totalQuantity;
				for index = 1, #_NOTIFACTION_POINT do
					if _reported_progress[index] ~= true then
						local point = _NOTIFACTION_POINT[index];
						if percent <= point and percent >= point - _NOTIFACTION_RANGE then
							_reported_progress[index] = true;
							_Report(format(">>傲慢具象<<刷新于进度%.2f%%！当前%.2f%%", point * 100, percent * 100));
							break;
						end
					end
				end
			end
		end
	end
end
hooksecurefunc("ScenarioTrackerProgressBar_SetValue", hook_ScenarioTrackerProgressBar_SetValue);

_frame:RegisterEvent("CHALLENGE_MODE_START");
_frame:RegisterEvent("CHALLENGE_MODE_COMPLETED");
_frame:RegisterEvent("CHALLENGE_MODE_RESET");




private.MythicDungeonPlusNotifaction = {
	Manifestation_of_Pride = function(v, loading)
		_enabled_Manifestation_of_Pride = not not v;
	end,
	Belligerent_Boast = function(v, loading)
		_enabled_Belligerent_Boast = not not v;
		if _enabled_Belligerent_Boast then
			if _is_in_chanllenge then
				_frame:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
			end
		else
			_frame:UnregisterEvent("COMBAT_LOG_EVENT_UNFILTERED");
		end
	end
}

if alaDevSV then
	_G._emu_mdpn = function()
		CombatLogGetCurrentEventInfo = function()
			return ts, "SPELL_AURA_APPLIED", hideCaster, GUID, srcName, srcFlags, srcRaidFlags, GUID, dstName, dstFlags, dstRaidFlags, 342466, "狂妄吹嘘", spellSchool;
		end
		__ns.COMBAT_LOG_EVENT_UNFILTERED()
		local prev = _is_in_chanllenge;
		_is_in_chanllenge = true;
		local criteriaIndex = { criteriaIndex = 1, };
		for index = 0.00, 1.00, 0.10 do
			C_Scenario_GetCriteriaInfo = function()
				return riteriaString, criteriaType, completed, quantity, 666, flags, assetID, format("%.2f%%", index * 666), criteriaID, duration, elapsed, criteriaFailed, isWeightedProgress;
			end
			hook_ScenarioTrackerProgressBar_SetValue(criteriaIndex);
		end
		C_Scenario_GetCriteriaInfo = _G.C_Scenario.GetCriteriaInfo;
		CombatLogGetCurrentEventInfo = _G.CombatLogGetCurrentEventInfo;
		_is_in_chanllenge = prev;
	end
end