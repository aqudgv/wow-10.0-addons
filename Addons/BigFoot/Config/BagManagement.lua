
local MOD_BAG_MANAGEMENT_TITLE,BF_TRADE_OPEN_ALL_BAGS,BF_Set_combinedBags,BF_reverseCleanupBags,BF_lootLeftmostBag,BF_BANK_OPEN_ALL_BAGS
function BagManagementConfigFunc()
	if (GetLocale() == "zhCN") then
		MOD_BAG_MANAGEMENT_TITLE = {"背包管理", "beibaoguanli"};

		BF_BANK_OPEN_ALL_BAGS = "显示银行界面时打开所有背包";
		BF_TRADE_OPEN_ALL_BAGS = "与玩家交易时自动打开背包";
		BF_Set_combinedBags = "整合背包"
		BF_reverseCleanupBags = "反序整理"
		BF_lootLeftmostBag = "反序存放"
	elseif (GetLocale() == "zhTW") then
		MOD_BAG_MANAGEMENT_TITLE = {"背包管理", "beibaoguanli"};

		BF_BANK_OPEN_ALL_BAGS = "顯示銀行界面時打開所有背包";
		BF_TRADE_OPEN_ALL_BAGS = "與玩家交易時自動打開背包";
		BF_Set_combinedBags = "整合背包"
		BF_reverseCleanupBags = "反序整理"
		BF_lootLeftmostBag = "反序存放"
	else
		MOD_BAG_MANAGEMENT_TITLE = "Bag Management";

		BF_BANK_OPEN_ALL_BAGS = "Open all bags while talking with banker";
		BF_TRADE_OPEN_ALL_BAGS = "Open all bags while trading with player";
		BF_Set_combinedBags = "BF_Set_combinedBags"
		BF_reverseCleanupBags = "BF_reverseCleanupBags"
		BF_lootLeftmostBag = "BF_lootLeftmostBag"
	end

	ModManagement_RegisterMod(
		"BagManagement",
		"Interface\\Icons\\INV_Misc_Bag_16",
		MOD_BAG_MANAGEMENT_TITLE,
		"",
		nil,
		nil,
		{[5]=true}
	);

	local hookcvar = {
		["combinedBags"] = "BF_Set_combinedBags",
	}
	local function TraceCVar(cvar, value, ...)
		if not hookcvar[cvar] then return end
		BigFoot_SetModVariable("BagManagement", hookcvar[cvar], value);
	end
	hooksecurefunc('SetCVar', TraceCVar)

	if pcall(GetCVar, "combinedBags") then
	    ModManagement_RegisterCheckBox(
			"BagManagement",
			BF_Set_combinedBags,
			nil,
			"BF_Set_combinedBags",
			GetCVar("combinedBags"),
			function (arg)
				SetCVar("combinedBags", arg)
			end
		);
	end

	ModManagement_RegisterCheckBox(
		"BagManagement",
		BF_reverseCleanupBags,
		nil,
		"BF_reverseCleanupBags",
		C_Container.GetSortBagsRightToLeft() and 0 or 1,
		function (arg)
			if (arg == 1) then
				C_Container.SetSortBagsRightToLeft(false)
			else
				C_Container.SetSortBagsRightToLeft(true)
			end
		end
	);

	ModManagement_RegisterCheckBox(
		"BagManagement",
		BF_lootLeftmostBag,
		nil,
		"BF_lootLeftmostBag",
		C_Container.GetInsertItemsLeftToRight() and 1 or 0,
		function (arg)
			if (arg == 1) then
				C_Container.SetInsertItemsLeftToRight(true)
			else
				C_Container.SetInsertItemsLeftToRight(false)
			end
		end
	);

	ModManagement_RegisterCheckBox(
		"BagManagement",
		BF_BANK_OPEN_ALL_BAGS,
		nil,
		"EnabelOpenAllBagsOnBank",
		1,
		BagManage_BankOpenAll
	);

	ModManagement_RegisterCheckBox(
		"BagManagement",
		BF_TRADE_OPEN_ALL_BAGS,
		nil,
		"EnabelOpenAllBagsOnTrading",
		1,
		BagManage_TradeOpenAll
	);
end

BigFoot_AddCollector(BagManagementConfigFunc)