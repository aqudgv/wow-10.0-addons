--  rewrited by ala

local addon = {  };

do  --------------------------------------------------  short Channel Name
    local next, strsub, gsub, tremove = next, strsub, gsub, tremove;

    local SC_DATA1, SC_DATA2;
    if GetLocale() == 'zhCN' then --短频道名字，每行最后一个字符串为显示名字
        SC_DATA1 = {
            CHAT_WHISPER_GET = "[密]%s说: ",
            CHAT_WHISPER_INFORM_GET = "[密]对%s说: ",
            CHAT_MONSTER_WHISPER_GET = "[密]%s说: ",
            CHAT_BN_WHISPER_GET = "[密]%s说: ",
            CHAT_BN_WHISPER_INFORM_GET = "[密]对%s说: ",
            CHAT_BN_CONVERSATION_GET = "%s:",
            CHAT_BN_CONVERSATION_GET_LINK = "|Hchannel:BN_CONVERSATION:%d|h[%s.对话]|h",
            CHAT_SAY_GET = "[说]%s: ",
            CHAT_MONSTER_SAY_GET = "[说]%s: ",
            CHAT_YELL_GET = "[喊]%s: ",
            CHAT_MONSTER_YELL_GET = "[喊]%s: ",
            CHAT_GUILD_GET = "|Hchannel:Guild|h[会]|h%s: ",
            CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[官]|h%s: ",
            CHAT_PARTY_GET = "|Hchannel:Party|h[队]|h%s: ",
            CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[队]|h%s: ",
            CHAT_MONSTER_PARTY_GET = "|Hchannel:Party|h[队]|h%s: ",
            CHAT_PARTY_GUIDE_GET = "|Hchannel:PARTY|h[副]|h%s: ",
            CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
            CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
            CHAT_RAID_GET = "|Hchannel:raid|h[团]|h%s: ",
            CHAT_RAID_LEADER_GET = "|Hchannel:raid|h[团]|h%s: ",
            CHAT_RAID_WARNING_GET = "[团]%s: ",
        
            CHAT_AFK_GET = "[AFK]%s: ",
            CHAT_DND_GET = "[DND]%s: ",
            CHAT_EMOTE_GET = "%s: ",
            CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h[宠]|h: ",
            CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h[宠]|h: ",
            CHAT_CHANNEL_LIST_GET = "|Hchannel:频道:%d|h[%s]|h",
            CHAT_CHANNEL_GET = "%s: ",
        };
        SC_DATA2 = {
            {"综合",        1,6, "综",},
            {"交易",        1,6, "交",},
            {"本地防务",    1,12,"本",},
            {"寻求组队",    1,12,"组",},
            {"大脚世界频道",1,18,"世",},
        };
    elseif GetLocale() == 'zhTW' then
        SC_DATA1 = {
            CHAT_WHISPER_GET = "[密]%s説: ",
            CHAT_WHISPER_INFORM_GET = "[密]对%s説: ",
            CHAT_MONSTER_WHISPER_GET = "[密]%s説: ",
            CHAT_BN_WHISPER_GET = "[密]%s説: ",
            CHAT_BN_WHISPER_INFORM_GET = "[密]对%s説: ",
            CHAT_BN_CONVERSATION_GET = "%s:",
            CHAT_BN_CONVERSATION_GET_LINK = "|Hchannel:BN_CONVERSATION:%d|h[%s.對話]|h",
            CHAT_SAY_GET = "[説]%s: ",
            CHAT_MONSTER_SAY_GET = "[説]%s: ",
            CHAT_YELL_GET = "[喊]%s: ",
            CHAT_MONSTER_YELL_GET = "[喊]%s: ",
            CHAT_GUILD_GET = "|Hchannel:Guild|h[會]|h%s: ",
            CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[官]|h%s: ",
            CHAT_PARTY_GET = "|Hchannel:Party|h[隊]|h%s: ",
            CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[隊]|h%s: ",
            CHAT_MONSTER_PARTY_GET = "|Hchannel:Party|h[隊]|h%s: ",
            CHAT_PARTY_GUIDE_GET = "|Hchannel:PARTY|h[副]|h%s: ",
            CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
            CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[副]|h%s: ",
            CHAT_RAID_GET = "|Hchannel:raid|h[團]|h%s: ",
            CHAT_RAID_LEADER_GET = "|Hchannel:raid|h[團]|h%s: ",
            CHAT_RAID_WARNING_GET = "[團]%s: ",
        
            CHAT_AFK_GET = "[AFK]%s: ",
            CHAT_DND_GET = "[DND]%s: ",
            CHAT_EMOTE_GET = "%s: ",
            CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h[寵]|h: ",
            CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h[寵]|h: ",
            CHAT_CHANNEL_LIST_GET = "|Hchannel:頻道:%d|h[%s]|h",
            CHAT_CHANNEL_GET = "%s: ",
        };
        SC_DATA2 = {
            {"綜合",			1,6,	"綜",},
            {"交易",			1,6,	"交",},
            {"本地防務",		1,12,	"本",},
            {"尋求組隊",		1,12,	"尋",},
            --
        };
    elseif GetLocale() == 'enUS' then
        SC_DATA1 = {
            CHAT_WHISPER_GET = "[W]%s: ",
            CHAT_WHISPER_INFORM_GET = "[W]to%s: ",
            CHAT_MONSTER_WHISPER_GET = "[W]%s: ",
            CHAT_BN_WHISPER_GET = "[W]%s: ",
            CHAT_BN_WHISPER_INFORM_GET = "[W]to%s: ",
            CHAT_BN_CONVERSATION_GET = "%s:",
            CHAT_BN_CONVERSATION_GET_LINK = "|Hchannel:BN_CONVERSATION:%d|h[%s.C]|h",
            CHAT_SAY_GET = "[S]%s: ",
            CHAT_MONSTER_SAY_GET = "[S]%s: ",
            CHAT_YELL_GET = "[Y]%s: ",
            CHAT_MONSTER_YELL_GET = "[Y]%s: ",
            CHAT_GUILD_GET = "|Hchannel:Guild|h[G]|h%s: ",
            CHAT_OFFICER_GET = "|Hchannel:OFFICER|h[O]|h%s: ",
            CHAT_PARTY_GET = "|Hchannel:Party|h[P]|h%s: ",
            CHAT_PARTY_LEADER_GET = "|Hchannel:PARTY|h[P]|h%s: ",
            CHAT_MONSTER_PARTY_GET = "|Hchannel:Party|h[P]|h%s: ",
            CHAT_PARTY_GUIDE_GET = "|Hchannel:PARTY|h[I]|h%s: ",
            CHAT_INSTANCE_CHAT_GET = "|Hchannel:INSTANCE_CHAT|h[I]|h%s: ",
            CHAT_INSTANCE_CHAT_LEADER_GET = "|Hchannel:INSTANCE_CHAT|h[I]|h%s: ",
            CHAT_RAID_GET = "|Hchannel:raid|h[R]|h%s: ",
            CHAT_RAID_LEADER_GET = "|Hchannel:raid|h[R]|h%s: ",
            CHAT_RAID_WARNING_GET = "[R]%s: ",
        
            CHAT_AFK_GET = "[AFK]%s: ",
            CHAT_DND_GET = "[DND]%s: ",
            CHAT_EMOTE_GET = "%s: ",
            CHAT_PET_BATTLE_INFO_GET = "|Hchannel:PET_BATTLE_INFO|h[Pet]|h: ",
            CHAT_PET_BATTLE_COMBAT_LOG_GET = "|Hchannel:PET_BATTLE_COMBAT_LOG|h[Pet]|h: ",
            CHAT_CHANNEL_LIST_GET = "|Hchannel:CHANNEL:%d|h[%s]|h",
            CHAT_CHANNEL_GET = "%s: ",
        };
        SC_DATA2 = {
            {"General",			1,7,	"G",},
            {"Trade",       	1,5,	"T",},
            {"LocalDefense",    1,12,	"D",},
            {"LookingForGroup", 1,15,	"L",},
            --
        };
    else
        return;
    end

    local control_shortChannelName = false;
    local backup_shortChannelName = {  };

    local chatFrames = {  };
    for i = 1, NUM_CHAT_WINDOWS do
        if i ~= 2 then
            chatFrames[#chatFrames + 1] = _G["ChatFrame" .. i];
        end
    end

    local _event_driver = CreateFrame("FRAME");
    _event_driver:RegisterEvent("PLAYER_LOGOUT");
    _event_driver:SetScript("OnEvent",
        function(_, event)
            if control_shortChannelName then
                for i = 1, #chatFrames do
                    local f = chatFrames[i];
                    for _, ct in next, SC_DATA2 do
                        for k, v in next, f.channelList do
                            if v == ct[4] then
                                f.channelList[k] = ct[1];
                            end
                        end
                    end
                end
            end
        end
    );
    hooksecurefunc(SlashCmdList, "JOIN",
        function(msg)
            if control_shortChannelName then
                local c = gsub(msg,"%s*([^%s]+).*","%1");
                for k, v in next, DEFAULT_CHAT_FRAME.channelList do
                    if v == c then
                        for _, ct in next, SC_DATA2 do
                            if strsub(c, ct[2], ct[3]) == ct[1] then
                                DEFAULT_CHAT_FRAME.channelList[k] = ct[4];
                            end
                        end
                        break;
                    end
                end
            end
        end
    );
    hooksecurefunc(SlashCmdList, "LEAVE",
        function(msg)
            local c = gsub(msg, "%s*([^%s]+).*", "%1");
            if control_shortChannelName then
                local s = nil;
                for k, ct in next, SC_DATA2 do
                    if c == ct[1] then
                        s = ct[4];
                    end
                end
                for i = 1, #chatFrames do
                    local f = chatFrames[i];
                    for k, v in next, f.channelList do
                        if v == s or v == c then
                            tremove(f.channelList,k);
                            break;
                        end
                    end
                end
            else
                for i = 1, #chatFrames do
                    local f = chatFrames[i];
                    for k, v in next, f.channelList do
                        if v == c then
                            tremove(f.channelList, k);
                            break;
                        end
                    end
                end
            end
        end
    );
    hooksecurefunc("ChatFrame_AddChannel",
        function(self, c)
            if control_shortChannelName then
                for k, v in next, self.channelList do
                    if v == c then
                        for _, ct in next, SC_DATA2 do
                            if strsub(c, ct[2], ct[3]) == ct[1] then
                                local sc = ct[4];
                                for i = 1, k do
                                    if self.channelList[i] == sc then
                                        sc = nil;
                                        break;
                                    end
                                end
                                self.channelList[k] = sc;
                                break;
                            end
                        end
                        break;
                    end
                end
            end
        end
    );
    hooksecurefunc("ChatFrame_RemoveChannel",
        function(self, c)
            if control_shortChannelName then
                for k, ct in next, SC_DATA2 do
                    if strsub(c, ct[2], ct[3]) == ct[1] then
                        c = ct[4];
                        break;
                    end
                end
                for k, v in next, self.channelList do
                    if v == c then
                        self.channelList[k] = nil;
                        break;
                    end
                end
            end
        end
    );
    hooksecurefunc("CreateChatChannelList",     --  聊天频道设置界面
        function(self, ...)
            if control_shortChannelName then
                local channelList = FCF_GetCurrentChatFrame().channelList;
                local zoneChannelList = FCF_GetCurrentChatFrame().zoneChannelList;
                for _, v in next, CHAT_CONFIG_CHANNEL_LIST do
                    for _, ct in next, SC_DATA2 do
                        if v.channelName and strsub(v.channelName, ct[2], ct[3]) == ct[1] then
                            -- v.channelName = ct[4];
                            -- v.text = strsub(v.text, 1, 2) .. ct[4];
                            local checked = nil;
                            if channelList then
                                for _, v2 in next, channelList do
                                    if v2 == ct[4] or v2 == ct[1] then
                                        checked = 1;
                                        break;
                                    end
                                end
                            end
                            if zoneChannelList then
                                for _, v2 in next, zoneChannelList do
                                    if (v2 == ct[4] or v2 == ct[1]) then
                                        checked = 1;
                                        break;
                                    end
                                end
                            end
                            v.checked = checked;
                            break;
                        end
                    end
                end
            end
        end
    );
    local function _cf_short_channel_name(self, event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, ...) -- main function
        for k, ct in next, SC_DATA2 do
            if arg9 == ct[1] or strsub(arg9, ct[2], ct[3]) == ct[1] then
                arg9 = ct[4];
                arg4 = arg8 .. ". " .. arg9;
                break;
            end
        end
        return false, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, ...;
    end
    local function shortChannelName_ToggleOn()
        if control_shortChannelName then
            return;
        end
        control_shortChannelName = true;
        for i = 1, #chatFrames do
            local f = chatFrames[i];
            for _, ct in next, SC_DATA2 do
                for k, v in next, f.channelList do
                    if strsub(v, ct[2], ct[3]) == ct[1] then
                        f.channelList[k] = ct[4];
                    end
                end
            end
        end
        ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", _cf_short_channel_name);
        for get, str in next, SC_DATA1 do
            backup_shortChannelName[get] = _G[get];
            _G[get] = str;
        end
        return control_shortChannelName;
    end
    local function shortChannelName_ToggleOff()
        if not control_shortChannelName then
            return;
        end
        control_shortChannelName = false;
        for i = 1, #chatFrames do
            local f = chatFrames[i];
            for _, ct in next, SC_DATA2 do
                for k, v in next, f.channelList do
                    if v == ct[4] then
                        f.channelList[k] = ct[1];
                    end
                end
            end
        end
        ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", _cf_short_channel_name);
        for get, str in next, backup_shortChannelName do
            _G[get] = str;
        end
        return control_shortChannelName;
    end
    addon.short_channel_name = {
        start = shortChannelName_ToggleOn,
        stop = shortChannelName_ToggleOff,
    };
end

do  --------------------------------------------------  short Realm Name
    local strsplit, strlen, strbyte, strsub = strsplit, strlen, strbyte, strsub;

	local len_displayed = 3;
	local cache_realm_list = {  };
	local function get_short(realm)
		local short = cache_realm_list[realm];
		if short == nil then
			if strlen(realm) > len_displayed + 2 then
				local pos = 1;
				while pos < len_displayed do
					local b = strbyte(realm, pos);
					if b <= 127 then		--	0111 1111
						pos = pos + 1;
					elseif b <= 223 then	--	1101 1111
						pos = pos + 2;
					elseif b <= 239 then	--	1110 1111
						pos = pos + 3;
					elseif b <= 247 then	--	1111 0111
						pos = pos + 4;
					--	合法utf-8最多4字节
					-- elseif b <= 251 then	--	1111 1011
					-- elseif b <= 253 then	--	1111 1101
					else
						pos = pos + 1;
					end
				end
				short = strsub(realm, 1, pos - 1);
				cache_realm_list[realm] = "\124r·\124cffff3f3f" .. short .. "\124r";
			else
				short = nil;
			end
		end
		return short;
	end
	local function filter(self, event, msg, sender, ...)
		local name, realm = strsplit("-", sender);
		if realm ~= nil then
			get_short(realm);
		end
	end
	local function start_cache_realm()
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_SAY", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_YELL", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_LEADER", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_RAID_WARNING", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_PARTY_LEADER", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_GUILD", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_OFFICER", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_BN_WHISPER", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_AFK", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_EMOTE", filter)
		ChatFrame_AddMessageEventFilter("CHAT_MSG_DND", filter)
	end
	local function stop_cache_realm()
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL_JOIN", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_CHANNEL_LEAVE", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_SAY", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_YELL", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BN_WHISPER", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_WHISPER_INFORM", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID_LEADER", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_RAID_WARNING", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_PARTY_LEADER", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_INSTANCE_CHAT", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_INSTANCE_CHAT_LEADER", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_GUILD", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_OFFICER", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_BN_WHISPER", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_AFK", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_EMOTE", filter)
		ChatFrame_RemoveMessageEventFilter("CHAT_MSG_DND", filter)
	end
	local orig_GetColoredName = GetColoredName;
	local function new_GetColoredName(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12)
		local coloredName = orig_GetColoredName(event, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12);
		-- if event == "CHAT_MSG_CHANNEL" then
			local name, realm = strsplit("-", arg2);
			if realm ~= nil then
				local short = get_short(realm);
				if short ~= nil then
					return gsub(coloredName, "%-" .. realm, short);
				else
					return coloredName;
				end
			else
				return coloredName;
			end
		-- else
			-- return coloredName;
		-- end
    end
    local function shortRealmName_ToggleOn()
        start_cache_realm();
        _G.GetColoredName = new_GetColoredName;
    end
    local function shortRealmName_ToggleOff()
        stop_cache_realm();
        _G.GetColoredName = orig_GetColoredName;
    end
    addon.short_realm_name = {
        start = shortRealmName_ToggleOn,
        stop = shortRealmName_ToggleOff,
    };
end


_G._163UI_Chat_ChatFrame = addon;






do return end
--- 简写大脚世界频道的名字

local DEBUG
local function debug(...)
    if DEBUG then
        ChatFrame3:AddMessage(table.concat({...}, ","))
    end
end

local origs = {} -- Original ChatFrame:AddMessage

local addMessageReplace = function(self, msg, ...)
    --debug(msg:gsub("\124", "/"))

    --大脚世界频道
    msg = msg:gsub('(%[%d+%. )大脚世界频道(%])', "%1世界%2")
    return origs[self](self, msg, ...)
end

hooksecurefunc("ChatEdit_UpdateHeader", function(editBox)
    local type = editBox:GetAttribute("chatType");
   	if ( not type ) then
           return;
       end
    if type == "CHANNEL" then
        local header = _G[editBox:GetName().."Header"];
        local text = header and header:GetText()
        if text then
            header:SetText((text:gsub('(%[%d+%. )大脚世界频道(%])', "%1世界%2")))
            editBox:SetTextInsets(8 + header:GetWidth(), 13, 0, 0);
        end
    end
end)

WithAllChatFrame(function(cf)
    if (DEBUG and cf:GetID()~=1) or (not DEBUG and cf:GetID()==2) then return end
    origs[cf] = cf.AddMessage
    cf.AddMessage = addMessageReplace
end)