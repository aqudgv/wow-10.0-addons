
-------------------------------------------------------
-- BigFootPatch.lua
-- AndyXiao@BigFoot
-- 本文件是用来修正一些来自WoW本身Interface的问题
-------------------------------------------------------

-- 屏蔽界面失效的提醒
do
	UIParent:UnregisterEvent("ADDON_ACTION_BLOCKED");
	INTERFACE_ACTION_BLOCKED_SHOWN = true	-- UIParent.lua
	_G["ChatFrameEditBox"] = _G["ChatFrame1EditBox"]	-- for PlayerLink
end

--支持可以从团队框体直接选择
do
	local f = CreateFrame("Frame")
	f:RegisterEvent("ADDON_LOADED")
	f:SetScript("OnEvent", function(self, event,...)
		if event == "ADDON_LOADED" and select(1,...) == "Blizzard_RaidUI" then
			BigFoot_DelayCall(BFSecureCall,1,function ()
				for i=1,40 do
					local raidbutton = getglobal("RaidGroupButton"..i);
					if(raidbutton and raidbutton.unit) then
						raidbutton:SetAttribute("type", "target");
						raidbutton:SetAttribute("unit", raidbutton.unit);
					end
				end
			end)
			f:UnregisterEvent("ADDON_LOADED")
		end
	end)
end

--QuickLoot中当拾取到空尸体的时候自动隐藏LootFrame 的逻辑移到这里
do
	local f = CreateFrame("Frame")
	f:RegisterEvent("LOOT_READY")
	f:SetScript("OnEvent",function(self,event)
		if ( GetNumLootItems() == 0 ) then
			HideUIPanel(LootFrame);
		end
	end)
end

-- 修改系统ADDON_ACTION_FORBIDDEN逻辑
do
	UIParent:UnregisterEvent("ADDON_ACTION_FORBIDDEN");

	-- StaticPopupDialogs["BF_ADDON_ACTION_FORBIDDEN"] = {
		-- text = ADDON_ACTION_FORBIDDEN,
		-- button1 = RELOADUI,
		-- button2 = IGNORE_DIALOG,
		-- OnAccept = function(self, data)
			-- ReloadUI();
		-- end,
		-- timeout = 0,
		-- exclusive = 1,
		-- whileDead = 1,
		-- hideOnEscape = 1,
		-- preferredIndex = STATICPOPUP_NUMDIALOGS,
	-- };

	-- local f = CreateFrame("Frame")
	-- f:RegisterEvent("ADDON_ACTION_FORBIDDEN")
	-- f:SetScript("OnEvent", function(self, event, ...)
		-- local FORBIDDEN_ADDON,FORBIDDEN_FUNCTION = ...;
		-- StaticPopup_Show("BF_ADDON_ACTION_FORBIDDEN", FORBIDDEN_ADDON);
	-- end)
end

-- 设置一些常用的cvar
do
	local LoaderFrame = CreateFrame("FRAME")
	LoaderFrame:RegisterEvent("PLAYER_LOGIN")

	local function LoaderEvents(frame, event, arg1)
		local patchVersion = '2022-11-2'

		BigFoot_AccountSet = BigFoot_AccountSet or {}
		if ( not BigFoot_AccountSet[patchVersion]) then
			-- ConsoleExec("cvar_default")
			-- https://nga.178.com/read.php?tid=34022995&_fp=2
			SetCVar("GxAllowCachelessShaderMode", 0)
			-- https://nga.178.com/read.php?tid=34037060
			SetCVar("minimapTrackingShowAll",1)

			if IsConfigurableAddOn("Combuctor") then
				StaticPopupDialogs["bf_Combuctor_Warning"] = {
					text = [[
10.0版本变更内容很大，请不要勾选加载过期插件！
    检测到已加载了过期的背包插件，
        系统已经自带了这个功能，
            点击“是”禁用。
]],
					button1 = YES,
					button2 = NO,
					OnAccept = function()
						DisableAddOn("Combuctor")
						ReloadUI()
					end,
					showAlert = 1,
					timeout = 0,
					hideOnEscape = true,
					whileDead = true,
					preferredIndex = STATICPOPUP_NUMDIALOGS,
				}
				BigFoot_DelayCall(function() StaticPopup_Show("bf_Combuctor_Warning") end, 1)
			end
			StaticPopupDialogs["bf_Warning"] = {
					text = [[
10.0版本由于机制问题会频繁导致污染问题，已将报警设置为静默状态。
在没有较好的处理办法前，建议在进入编辑模式前后重载一遍界面(/rl)。
如遇到卡按键无法使用的情况也请使用重载命令。
]],
				button1 = OKAY,
				OnAccept = function()
				end,
				showAlert = 1,
				timeout = 9,
				preferredIndex = STATICPOPUP_NUMDIALOGS,
			};
			BigFoot_DelayCall(function() StaticPopup_Show("bf_Warning") end, 1)

			BigFoot_AccountSet[patchVersion] = true;
		end
	end

	LoaderFrame:SetScript("OnEvent", LoaderEvents)
end
