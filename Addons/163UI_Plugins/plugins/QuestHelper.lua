--[=[
	MISC
--]=]

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;


if __ns.__client._TocVersion < 90000 then
	return;
end

local __const = __ns.__const;
local __meta = __ns.__meta;
local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

local _F_coreDebug = __meta._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
local next = next;
local strfind = strfind;
local C_Timer_After = C_Timer.After;
local InCombatLockdown = InCombatLockdown;

local _LT_QuestMethod = {  };

local _LT_AdditionalActionButtons = {  };
local _LN_AdditionalActionButtons = 0;
local function _LF_OnEnter_AdditionalActionButton(self)
	if self.__spell ~= nil then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		GameTooltip:SetSpellByID(self.__spell);
	elseif self.__def ~= nil then
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		GameTooltip:SetText(self.__def);
	end
end
local function _LF_OnLeave_AdditionalActionButton(self)
	GameTooltip:Hide();
end
local function _LF_GetAdditionalActionButton()
	if _LN_AdditionalActionButtons > 0 then
		for _index = 1, _LN_AdditionalActionButtons do
			local _button = _LT_AdditionalActionButtons[_index];
			if _button.__inuse ~= true then
				_button.__inuse = true;
				_button.__spell = nil;
				_button.__def = nil;
				_button:SetAttribute('macrotext', "");
				_button.icon:SetTexture(nil);
				__meta._F_metaLeaveCombatCallOnceImmediate(_button.Show, _button);
				return _button;
			end
		end
	end
	local _button = CreateFrame('CheckButton', "keyname", UIParent, 'ActionBarButtonTemplate');
	_button:SetSize(32, 32);
	_button:SetPoint("TOP", 0 + 34 * _LN_AdditionalActionButtons, -240);
	_button:SetAttribute('type', 'macro');
	_button:SetAttribute('showgrid', 0);
	_button:SetScript("OnDragStart", nil);
	_button:SetScript("OnReceiveDrag", nil);
	_button:SetScript("OnEnter", _LF_OnEnter_AdditionalActionButton);
	_button:SetScript("OnLeave", _LF_OnLeave_AdditionalActionButton);
	_button.action = 0;
	_button.SetTooltip = _LF_OnEnter_AdditionalActionButton;
	_button.__inuse = true;
	_LN_AdditionalActionButtons = _LN_AdditionalActionButtons + 1;
	return _button;
end
local function _LF_RelAdditionalActionButton(button)
	button.__inuse = nil;
	__meta._F_metaLeaveCombatCallOnceImmediate(button.Hide, button);
end


-->		World Quest 59585		--	
	--	321843	132350
	--	321844	132306
	--	321847	132269
	local _LB_wq59585_InProgressing = false;
	local _LW_wq59585 = nil;
	local _LC_wq59585_macrotext = nil;
	local _LC_wq59585_icon = nil;
	local _LC_wq59585_spell = nil;
	local function _LF_wq59585_Delay()
		if not InCombatLockdown() then
			_LW_wq59585.__spell = _LC_wq59585_spell;
			_LW_wq59585:SetAttribute('macrotext', _LC_wq59585_macrotext);
			_LW_wq59585.icon:SetTexture(_LC_wq59585_icon);
		end
	end
	local function _LF_wq59585_CHAT_MSG_MONSTER_SAY(event, msg, sender)
		if sender == '训练师伊卡洛斯' then
			if msg == "打击。" then
				-- _F_coreDebug(1);
				_LC_wq59585_spell = 321843;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton1";
				_LC_wq59585_icon = 132350;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "低扫。" then
				-- _F_coreDebug(2);
				_LC_wq59585_spell = 321844;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton2";
				_LC_wq59585_icon = 132306;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "招架。" then
				-- _F_coreDebug(3);
				_LC_wq59585_spell = 321847;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton3";
				_LC_wq59585_icon = 132269;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "挥砍。" then
				-- _F_coreDebug(1);
				_LC_wq59585_spell = 341931;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton1";
				_LC_wq59585_icon = 132337;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "猛击。" then
				-- _F_coreDebug(2);
				_LC_wq59585_spell = 341928;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton2";
				_LC_wq59585_icon = 132357;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "格挡。" then
				-- _F_coreDebug(3);
				_LC_wq59585_spell = 341929;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton3";
				_LC_wq59585_icon = 236307;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "猛刺。" then
				-- _F_coreDebug(3);
				_LC_wq59585_spell = 342000;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton1";
				_LC_wq59585_icon = 132298;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "脚踢。" then
				-- _F_coreDebug(3);
				_LC_wq59585_spell = 342001;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton2";
				_LC_wq59585_icon = 132219;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			elseif msg == "躲闪。" then
				-- _F_coreDebug(3);
				_LC_wq59585_spell = 342002;
				_LC_wq59585_macrotext = "/click OverrideActionBarButton3";
				_LC_wq59585_icon = 538536;
				C_Timer_After(0.15, _LF_wq59585_Delay);
			end
		end
	end
	local function _LF_wq59585_UNIT_SPELLCAST_SUCCEEDED(event, unit, cast, id)
		if unit == 'player' and (
			id == 321843 or id == 321844 or id == 321847 or
			id == 341931 or id == 341928 or id == 341929 or
			id == 342000 or id == 342001 or id == 342002
		) then
			_LW_wq59585.__spell = nil;
			_LW_wq59585:SetAttribute('macrotext', "");
			_LW_wq59585.icon:SetTexture(nil);
		end
	end
	_LT_QuestMethod[59585] = function(accepted)
		if accepted then
			if _LB_wq59585_InProgressing then
				return;
			end
			_LB_wq59585_InProgressing = true;
			_LW_wq59585 = _LF_GetAdditionalActionButton();
			__meta._F_metaOnEvent(
				"CHAT_MSG_MONSTER_SAY",
				_LF_wq59585_CHAT_MSG_MONSTER_SAY
			);
			__meta._F_metaOnEvent(
				"UNIT_SPELLCAST_SUCCEEDED",
				_LF_wq59585_UNIT_SPELLCAST_SUCCEEDED
			);
		else
			_LB_wq59585_InProgressing = false;
			if _LW_wq59585 ~= nil then
				_LF_RelAdditionalActionButton(_LW_wq59585);
			end
			__meta._F_metaOnEventCancel(
				"CHAT_MSG_MONSTER_SAY",
				_LF_wq59585_CHAT_MSG_MONSTER_SAY
			);
			__meta._F_metaOnEventCancel(
				"UNIT_SPELLCAST_SUCCEEDED",
				_LF_wq59585_UNIT_SPELLCAST_SUCCEEDED
			);
		end
	end
-->
-->		Quest 57870				--	林鬼的游戏
	--	Creature-0-3925-2222-7125-159477-00006EDB0B		159477顽皮的欺诈者
	local function _LF_q57870_CHAT_MSG_MONSTER_SAY(event, msg, name, _, _, target, _, _, _, _, _, line, guid)
		if name == "顽皮的欺诈者" then
			if strfind(msg, "强壮") or strfind(msg, "壮观") then
				_F_coreDebug("/flex    /strong");
				DoEmote("flex");
			elseif strfind(msg, "感谢") then
				_F_coreDebug("/ty    /thank    /thanks");
				DoEmote("thank");
			elseif strfind(msg, "跳舞") then
				_F_coreDebug("/dance");
				DoEmote("dance");
			elseif strfind(msg, "欢呼") then
				_F_coreDebug("/cheer    /woot");
				DoEmote("cheer");
			elseif strfind(msg, "介绍") then
				_F_coreDebug("/introduce");
				DoEmote("introduce");
			elseif strfind(msg, "赞美") or strfind(msg, "表扬") or strfind(msg, "慷慨") then
				_F_coreDebug("/praise    /lavish");
				DoEmote("praise");
			elseif strfind(msg, "鞠躬") or strfind(msg, "bow") then
				_F_coreDebug("/bow");
				DoEmote("bow");
			end
		end
	end
	_LT_QuestMethod[57870] = function(accepted)
		if accepted then
			__meta._F_metaOnEvent(
				"CHAT_MSG_MONSTER_SAY",
				_LF_q57870_CHAT_MSG_MONSTER_SAY
			);
		else
			__meta._F_metaOnEventCancel(
				"CHAT_MSG_MONSTER_SAY",
				_LF_q57870_CHAT_MSG_MONSTER_SAY
			);
		end
	end
-->


local function _LF_OnEvent_QUEST_ACCEPTED(event, questID)
	local _method = _LT_QuestMethod[questID];
	_F_coreDebug(questID, _method ~= nil);
	if _method ~= nil then
		_method(true);
	end
end
local function _LF_OnEvent_QUEST_REMOVED(event, questID)
	local _method = _LT_QuestMethod[questID];
	if _method ~= nil then
		_method(false);
	end
end


for _index = 1, C_QuestLog.GetNumQuestLogEntries() do
	local _info = C_QuestLog.GetInfo(_index);
	if _info ~= nil then
		local _questID = _info.questID;
		if _questID ~= nil and _questID > 0 then
			_LF_OnEvent_QUEST_ACCEPTED("QUEST_ACCEPTED", _questID);
		end
	end
end

__plugins['QuestHelper'] = {
	function()
		__meta._F_metaOnEvent(
			"QUEST_ACCEPTED",
			_LF_OnEvent_QUEST_ACCEPTED
		);
		__meta._F_metaOnEvent(
			"QUEST_REMOVED",
			_LF_OnEvent_QUEST_REMOVED
		);
	end,
	function()
		__meta._F_metaOnEventCancel(
			"QUEST_ACCEPTED",
			_LF_OnEvent_QUEST_ACCEPTED
		);
		__meta._F_metaOnEventCancel(
			"QUEST_REMOVED",
			_LF_OnEvent_QUEST_REMOVED
		);
	end
};