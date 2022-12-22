local addonName, private = ...

local noop = function() end;

do      --  WorldMapQuest
	local enabled = true;
	local L = {  };
	local pool = {  };
	if GetLocale() == "zhCN" then
		L["DAY"] = "天";
		L["HOUR"] = "时";
		L["MINUTE"] = "分";
		L["SECOND"] = "秒";
	elseif GetLocale() == "zhTW" then
		L["DAY"] = "天";
		L["HOUR"] = "時";
		L["MINUTE"] = "分";
		L["SECOND"] = "秒";
	else
		L["DAY"] = "d";
		L["HOUR"] = "h";
		L["MINUTE"] = "m";
		L["SECOND"] = "s";
	end
	local wqpr = nil;
	local activePins = nil;
	for pr, _ in next, WorldMapFrame.dataProviders do
		if pr.GetPinTemplate and pr:GetPinTemplate() == "WorldMap_WorldQuestPinTemplate" then
			wqpr = pr;
			activePins = pr.activePins;
		end
	end
	if activePins ~= nil then
		local next, floor = next, floor;
		local C_TaskQuest = C_TaskQuest;
		local C_TaskQuest_GetQuestTimeLeftSeconds, C_TaskQuest_GetQuestsForPlayerByMapID = C_TaskQuest.GetQuestTimeLeftSeconds, C_TaskQuest.GetQuestsForPlayerByMapID
		local WorldMapFrame = WorldMapFrame;
		local font = GameFontNormal:GetFont();
		local function echo_time(quest)
			local pin = activePins[quest];
			if pin ~= nil then
				local sec = C_TaskQuest_GetQuestTimeLeftSeconds(quest);
				local text = pool[pin];
				if text == nil then
					text = pin:CreateFontString(nil, "OVERLAY");
					text:SetFont(font, 28);
					text:SetPoint("TOP", pin, "BOTTOM");
					pool[pin] = text;
					local mask = pin:CreateTexture(nil, "ARTWORK");
					mask:SetPoint("TOPLEFT", text, 0, -1);
					mask:SetPoint("BOTTOMRIGHT", text, 0, -2);
					mask:SetColorTexture(0.0, 0.0, 0.0, 0.5);
				else
					text:Show();
				end
				-- local scale = pin:GetEffectiveScale();
				-- text:SetScale(scale);print(scale, pin:GetWidth())
				if sec ~= nil then
					if sec > 3600 then
						text:SetVertexColor(0.0, 1.0, 0.0);
					elseif sec > 1800 then
						text:SetVertexColor((3600 - sec) / 1800, 1.0, 0.0);
					else
						text:SetVertexColor(1.0, 1.0 - sec / 1800, 0.0);
					end
					local str = "";
					if sec >= 86400 then
						str = str .. floor(sec / 86400) .. L["DAY"];
						sec = sec % 86400;
						str = str .. floor(sec / 3600) .. L["HOUR"];
						sec = sec % 3600;
					elseif sec >= 3600 then
						str = str .. floor(sec / 3600) .. L["HOUR"];
						sec = sec % 3600;
						str = str .. floor(sec / 60) .. L["MINUTE"];
					elseif sec >= 60 then
						str = str .. floor(sec / 60) .. L["MINUTE"];
						sec = sec % 60;
						str = str .. sec .. L["SECOND"];
					else
						str = str .. sec .. L["SECOND"];
					end
					text:SetText(str);
				else
					text:SetText(nil);
				end
			end
		end
		hooksecurefunc(wqpr, "RefreshAllData", function()
			if enabled then
				local mapID = WorldMapFrame:GetMapID();
				local taskInfo = C_TaskQuest_GetQuestsForPlayerByMapID(mapID);
				if taskInfo ~= nil then
					for _, info in next, taskInfo do
						echo_time(info.questId);
					end
				end
			end
		end);
	end
	private.WorldMapQuest = function(v, loading)
		enabled = not not v;
		if enabled then
		else
			for pin, text in next, pool do
				text:Hide();
			end
		end
	end
end


