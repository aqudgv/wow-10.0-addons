--[[
	@ALA / ALEX
--]]
local ADDON, NS = ...;
local alaPopup = NS.alaPopup;

local RAID_CLASS_COLORS = RAID_CLASS_COLORS;
local BNET_CLIENT_WOW = BNET_CLIENT_WOW;

local locale = GetLocale();

local AddFriend = C_FriendList and C_FriendList.AddFriend or AddFriend or function() end
local RemoveFriend = C_FriendList and C_FriendList.RemoveFriend or RemoveFriend or function() end
local GetFriendInfo = C_FriendList and C_FriendList.GetFriendInfo or GetFriendInfo or function() end
local AddIgnore = C_FriendList and C_FriendList.AddIgnore or C_FriendList and function() end
local DelIgnore = C_FriendList and C_FriendList.DelIgnore or C_FriendList and function() end
local IsIgnored = C_FriendList and C_FriendList.IsIgnored or C_FriendList and function() end
local SendWho = C_FriendList and C_FriendList.SendWho or SendWho or function() end

do
	local func = {
		NAME_COPY = function(which, frame)
			local editBox = ChatEdit_ChooseBoxForSend();
			ChatEdit_ActivateChat(editBox);
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				editBox:Insert(frame.name .. "-" .. frame.server);
			else
				editBox:Insert(frame.name);
			end
		end,
		FRIEND_ADD = function(which, frame)
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				AddFriend(frame.name .. "-" .. frame.server);
			else
				AddFriend(frame.name);
			end
		end,
		FRIEND_DEL = function(which, frame)
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				RemoveFriend(frame.name .. "-" .. frame.server);
			else
				RemoveFriend(frame.name);
			end
		end,
		FRIEND_ADD_OR_DEL = function(which, frame)
			local name = nil;
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				name = frame.name .. "-" .. frame.server;
			else
				name = frame.name;
			end
			local inlist = GetFriendInfo(name) ~= nil;
			if inlist then
				RemoveFriend(name);
			else
				AddFriend(name);
			end
		end,
		IGNORE_ADD = function(which, frame)
			local name = frame.name
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				name = name .. "-" .. frame.server;
			end
			AddIgnore(name);
			SendSystemMessage(name .. "已经被移出屏蔽列表");
		end,
		IGNORE_DEL = function(which, frame)
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				DelIgnore(frame.name .. "-" .. frame.server);
			else
				DelIgnore(frame.name);
			end
		end,
		IGNORE_ADD_OR_DEL = function(which, frame)
			local name = nil;
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				name = frame.name .. "-" .. frame.server;
			else
				name = frame.name;
			end
			local inlist = IsIgnored(name);
			if inlist then
				DelIgnore(name);
				SendSystemMessage(name .. "已经被移出屏蔽列表");
			else
				AddIgnore(name);
			end
		end,
		SEND_WHO = function(which, frame)
			local name = frame.name
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				name = name .. "-" .. frame.server;
			end
			SendWho("n-" .. name);
		end,
		GUILD_ADD = function(which, frame)
			local name = frame.name
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				name = name .. "-" .. frame.server;
			end
			GuildInvite(name);
		end,
		BN_TAG_COPY = function(which, frame)
			local tag = select(3, BNGetFriendInfoByID(frame.bnetIDAccount));
			local editBox = ChatEdit_ChooseBoxForSend();
			ChatEdit_ActivateChat(editBox);
			editBox:Insert(tag);
		end,
		BN_NAME_COPY = function(which, frame)
			local name = string.match(select(3, BNGetFriendInfoByID(frame.bnetIDAccount)), "(.+)#.+");
			local editBox = ChatEdit_ChooseBoxForSend();
			ChatEdit_ActivateChat(editBox);
			editBox:Insert(name);
		end,
		BN_GUILD_ADD = function(which, frame)
			GuildInvite(self.arg1.name);
		end,
	};
	local cond = {
		FRIEND_ADD_OR_DEL = function(which, frame)
			local name = nil;
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				name = frame.name .. "-" .. frame.server;
			else
				name = frame.name;
			end
			local inlist = GetFriendInfo(name) ~= nil;
			return inlist and "FRIEND_DEL" or "FRIEND_ADD";
		end,
		IGNORE_ADD_OR_DEL = function(which, frame)
			local name = nil;
			if frame.server and frame.server ~= "" and frame.server ~= GetRealmName() then
				name = frame.name .. "-" .. frame.server;
			else
				name = frame.name;
			end
			local inlist = IsIgnored(name);
			return inlist and "IGNORE_DEL" or "IGNORE_ADD";
		end,
	};

	local UnitPopupButtonsExtra = {
		["SEND_WHO"] = { enUS ="Query Detail",  zhCN = "查询玩家", zhTW = "查詢玩家" },
		["NAME_COPY"] = { enUS ="Get Name",	 zhCN = "获取名字", zhTW = "獲取名字", },
		["GUILD_ADD"] = { enUS ="Guild Invite", zhCN = "公会邀请", zhTW = "公會邀請", },
		["FRIEND_ADD"] = { enUS ="Add Friend",  zhCN = "添加好友", zhTW = "添加好友", },
		["FRIEND_DEL"] = { enUS ="Del Friend",  zhCN = "删除好友", zhTW = "删除好友", },
		["FRIEND_ADD_OR_DEL"] = { enUS ="Del or Add Friend",  zhCN = "添加或删除好友", zhTW = "添加或删除好友", },
		["IGNORE_ADD"] = { enUS ="Add Ignore",  zhCN = "屏蔽", zhTW = "屏蔽", },
		["IGNORE_DEL"] = { enUS ="Del Ignore",  zhCN = "取消屏蔽", zhTW = "取消屏蔽", },
		["IGNORE_ADD_OR_DEL"] = { enUS ="Del or Add Ignore",  zhCN = "添加或取消屏蔽", zhTW = "添加或取消屏蔽", },
		["BN_TAG_COPY"] = { enUS ="Get BN Name",  zhCN = "获取战网Tag", zhTW = "獲取戰網Tag", },
		["BN_NAME_COPY"] = { enUS ="Get BN Tag",  zhCN = "获取战网昵称", zhTW = "獲取戰網昵稱", },
		-- ["BN_GUILD_ADD"] = { enUS ="Guild Invite", zhCN = "公会邀请", zhTW = "公會邀請", nested = 1, },
	};
	local locale = GetLocale();
	for key, value in pairs(UnitPopupButtonsExtra) do
		alaPopup.add_meta(key, { value[locale] or value.enUS, func[key], cond[key], });
	end

	alaPopup.add_list("SELF", "NAME_COPY");

	alaPopup.add_list("FRIEND", "NAME_COPY");
	alaPopup.add_list("FRIEND", "SEND_WHO");
	alaPopup.add_list("FRIEND", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("FRIEND", "IGNORE_ADD_OR_DEL");
	alaPopup.add_list("FRIEND", "GUILD_ADD");

	alaPopup.add_list("FRIEND_OFFLINE", "NAME_COPY");

	alaPopup.add_list("PLAYER", "NAME_COPY");
	alaPopup.add_list("PLAYER", "SEND_WHO");
	alaPopup.add_list("PLAYER", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("PLAYER", "IGNORE_ADD_OR_DEL");
	alaPopup.add_list("PLAYER", "GUILD_ADD");

	alaPopup.add_list("PARTY", "NAME_COPY");
	alaPopup.add_list("PARTY", "SEND_WHO");
	alaPopup.add_list("PARTY", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("PARTY", "IGNORE_ADD_OR_DEL");
	alaPopup.add_list("PARTY", "GUILD_ADD");

	alaPopup.add_list("RAID", "NAME_COPY");
	alaPopup.add_list("RAID", "SEND_WHO");
	alaPopup.add_list("RAID", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("RAID", "IGNORE_ADD_OR_DEL");
	alaPopup.add_list("RAID", "GUILD_ADD");

	alaPopup.add_list("RAID_PLAYER", "NAME_COPY");
	alaPopup.add_list("RAID_PLAYER", "SEND_WHO");
	alaPopup.add_list("RAID_PLAYER", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("RAID_PLAYER", "IGNORE_ADD_OR_DEL");
	alaPopup.add_list("RAID_PLAYER", "GUILD_ADD");

	alaPopup.add_list("CHAT_ROSTER", "NAME_COPY");
	alaPopup.add_list("CHAT_ROSTER", "SEND_WHO");
	alaPopup.add_list("CHAT_ROSTER", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("CHAT_ROSTER", "INVITE");

	alaPopup.add_list("GUILD", "NAME_COPY");
	alaPopup.add_list("GUILD", "SEND_WHO");
	alaPopup.add_list("GUILD", "FRIEND_ADD_OR_DEL");

	alaPopup.add_list("ENEMY_PLAYER", "NAME_COPY");
	alaPopup.add_list("ENEMY_PLAYER", "IGNORE_ADD_OR_DEL");
	alaPopup.add_list("OTHERPET", "NAME_COPY");
	--alaPopup.add_list("PET", "NAME_COPY");
	alaPopup.add_list("TARGET", "NAME_COPY");

	-- alaPopup.add_list("BN_FRIEND", "BN_TAG_COPY");
	-- alaPopup.add_list("BN_FRIEND", "BN_NAME_COPY");
	-- -- alaPopup.add_list("BN_FRIEND", "BN_GUILD_ADD");
	-- alaPopup.add_list("BN_FRIEND_OFFLINE", "BN_TAG_COPY");
	-- alaPopup.add_list("BN_FRIEND_OFFLINE", "BN_NAME_COPY");

	alaPopup.add_list("_BRFF_SELF", "NAME_COPY");

	alaPopup.add_list("_BRFF_PARTY", "NAME_COPY");
	alaPopup.add_list("_BRFF_PARTY", "SEND_WHO");
	alaPopup.add_list("_BRFF_PARTY", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("_BRFF_PARTY", "GUILD_ADD");

	alaPopup.add_list("_BRFF_RAID_PLAYER", "NAME_COPY");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "SEND_WHO");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "FRIEND_ADD_OR_DEL");
	alaPopup.add_list("_BRFF_RAID_PLAYER", "GUILD_ADD");
end
