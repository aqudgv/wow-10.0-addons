do return end
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
