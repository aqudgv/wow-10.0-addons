local noop = function() end;

-- SendMailNameEditBox:SetWidth(100);
-- SendMailNameEditBox._SetWidth = SendMailNameEditBox.SetWidth;
-- SendMailNameEditBox.SetWidth = noop;
-- SendMailNameEditBox._SetSize = SendMailNameEditBox.SetSize;
-- SendMailNameEditBox.SetSize = function(self, w, h) self:SetHeight(h); end;

-- do		--	Global String
-- 	if GetLocale() == "zhCN" then
-- 		_G.ITEM_SOULBOUND = "已绑定";
-- 	end
-- end


do		--	SendMailNameEditBox
	if SendMailNameEditBox ~= nil then
		SendMailNameEditBoxRight:ClearAllPoints();
		SendMailNameEditBoxRight:SetPoint("RIGHT", SendMailNameEditBox, 0, 3);
		SendMailNameEditBoxMiddle:ClearAllPoints();
		SendMailNameEditBoxMiddle:SetPoint("LEFT", SendMailNameEditBoxLeft, "RIGHT");
		SendMailNameEditBoxMiddle:SetPoint("RIGHT", SendMailNameEditBoxRight, "LEFT");
		--
		SendMailCostMoneyFrame:ClearAllPoints();
		SendMailCostMoneyFrame:SetPoint("CENTER", SendMailTitleText);
		SendMailTitleText:Hide();
	end
end
