local _, U1 = ...

local _UserGuide = { config = {  }, preset = {  }, enableHoverTip = true, };
U1._UserGuide = _UserGuide;

local width = 1;
local height = 1;
local grw = 1;
local grh = 1;

local artwork_path = "Interface\\Addons\\!!!163UI!!!\\Guide\\ARTWORK\\";

local msg_whatsnew = "更新内容: \
\
· 【\124cffff007f功能修复\124r】\
\
            修复\124cff00ff00交易记录及交易界面增强\124r作为单体插件使用时报错\
\
            修复\124cff00ff00制造业界面增强\124r部分NPC商品的价格\
\
· 【\124cffff007f功能更新\124r】\
\
            新增\124cff00ff00奶油任务增强(ButterQuestTracker)\124r插件，删除\124cff00ff00MonkeyQuest\124r插件\
\
            \124cff00ff00Butter实用小功能\124r的WA管理器增加了TAQ相关字符串，输入/awa管理\
\
            \124cff00ff00自动售卖和修理\124r不再自动出售山地披风\
\
            \124cff00ff00不完善的预览版美化功能，虽然不会造成功能上的问题，但请务必自行备份WTF\124r：\
\
                        \124cff00ff00扁平风格\124r开启时，输入'/163bj 数字1-4'可以给大部分界面增加一个纹理\
\
                        0: \124cff00ff00关闭\124r 1: \124cff00ff00巫妖王\124r 2: \124cff00ff00兽人\124r 3: \124cff00ff00雷克萨\124r 4: \124cff00ff00侏儒\124r\
\
·【\124cffff007f整合插件例行更新\124r】\
";
--graphicList anchor starts from topleft [same as coord]
local graphicList = {
	{
		["Bagnon"]				= { coord = { { { 1037 / 1600, 467 / 900 }, { 1380 / 1600, 854 / 900 }, }, }, },
		["TipTac"]				= { coord = { { {  819 / 1600, 318 / 900 }, {  998 / 1600, 407 / 900 }, }, }, },
		["Recount"]			   = { coord = { { { 1388 / 1600, 695 / 900 }, { 1600 / 1600, 833 / 900 }, }, }, },
		["NeatPlates"]			= { coord = { { {  733 / 1600, 275 / 900 }, {  860 / 1600, 303 / 900 }, }, }, },
		["SimpleUnitFrames"]	  = { coord = { { {   20 / 1600,  12 / 900 }, {  472 / 1600,  94 / 900 }, }, }, },
		["Dominos"]			   = { coord = { { {  575 / 1600, 741 / 900 }, { 1026 / 1600, 900 / 900 }, }, { { 1521 / 1600, 220 / 900 }, { 1600 / 1600, 678 / 900 }, }, { { 1379 / 1600, 830 / 900 }, { 1600 / 1600, 900 / 900 }, }, }, },
		["ModernQuestWatch"]	  = { coord = { { { 1219 / 1600, 262 / 900 }, { 1374 / 1600, 354 / 900 }, }, }, },
		["QuestLogEx"]			= { coord = { { {	0 / 1600, 110 / 900 }, {  719 / 1600, 653 / 900 }, }, }, },
		["WhisperPop"]			= { coord = { { {  989 / 1600,  32 / 900 }, { 1199 / 1600, 372 / 900 }, }, }, },
		["TargetIndicator"]	   = { coord = { { {  783 / 1600, 820 / 900 }, {  810 / 1600, 264 / 900 }, }, }, },
	},
	{
		["Combuctor"]			 = { coord = { { {   74 / 1600, 306 / 900 }, {  575 / 1600, 867 / 900 }, }, }, },
		["ShadowedUnitFrames"]	= { coord = { { {  182 / 1600,  51 / 900 }, {  632 / 1600, 177 / 900 }, }, }, },
		["ElkBuffBars"]		   = { coord = { { {  306 / 1600, 252 / 900 }, {  528 / 1600, 276 / 900 }, }, }, },
		["Grid2"]				 = { coord = { { {  587 / 1600, 237 / 900 }, {  659 / 1600, 308 / 900 }, }, }, },
		["TinyTooltip"]		   = { coord = { { {  929 / 1600, 210 / 900 }, { 1100 / 1600, 366 / 900 }, }, }, },
		["BlinkHealthText"]	   = { coord = { { {  591 / 1600, 512 / 900 }, { 1069 / 1600, 611 / 900 }, }, }, },
		["Dominos"]			   = { coord = { { {  575 / 1600, 741 / 900 }, { 1026 / 1600, 900 / 900 }, }, { { 1521 / 1600, 220 / 900 }, { 1600 / 1600, 678 / 900 }, }, { { 1379 / 1600, 830 / 900 }, { 1600 / 1600, 900 / 900 }, }, }, },
		["Quartz"]				= { coord = { { {  669 / 1600, 675 / 900 }, {  942 / 1600, 711 / 900 }, }, }, },
		["Decursive"]			 = { coord = { { { 1198 / 1600, 298 / 900 }, { 1225 / 1600 ,323 / 900 }, }, }, },
		["Details"]			   = { coord = { { { 1175 / 1600, 630 / 900 }, { 1505 / 1600, 812 / 900 }, }, }, },
		["MonkeyLibrary"]		 = { coord = { { { 1206 / 1600, 383 / 900 }, { 1493 / 1600, 782 / 900 }, }, }, },
		["SexyMap"]			   = { coord = { { { 1389 / 1600,   0 / 900 }, { 1600 / 1600, 213 / 900 }, }, }, },
		["ModernQuestWatch"]	  = { coord = { { { 1361 / 1600, 182 / 900 }, { 1514 / 1600, 275 / 900 }, }, }, },
		["WhisperPop"]			= { coord = { { {	0 / 1600, 513 / 900 }, {   32 / 1600, 545 / 900 }, }, }, },
		["ChocolateBar"]		  = { coord = { { {	0 / 1600, 872 / 900 }, {  570 / 1600, 900 / 900 }, }, { { 1035 / 1600, 872 / 900 }, { 1379 / 1600, 900 / 900 }, }, }, },
	},
};
local guideTable =
{
	{
		TAG = "",
		BG = "BG1";
	},
	-- {
	-- 	TAG = "",
	-- 	whatsnew = true,
	-- },
	{
		TAG = "背包整合插件",
		{ "Bagnon", desc = "简易风格的背包整合插件", },
		{ "Combuctor", desc = "暴雪经典风格的背包整合插件", },
		{ desc = "不使用/自己手动管理", },
		conflict = true,
	},
	{
		TAG = "任务插件",
		{ "!KalielsTracker", desc = "任务追踪增强\n追踪右侧的任务追踪列表", },
		{ "WorldQuestTracker", desc = "世界任务增强\n自动寻找加入世界任务队伍", },
		{ "WorldQuestsList", desc = "世界任务列表\n在地图上显示世界任务的列表", },
		{ desc = "不使用", },
		conflict = false,
	},
	{
		TAG = "头像增强插件",
		{ "ShadowedUnitFrames", title = "ShadowedUnitFrames", desc = "扁平化、3D头像的SUF+目标血量模拟插件", },
		{ "EN_UnitFrames", title = "EN_UnitFrames", desc = "带延展加宽信息、3d头像的UFP，集成目标血量显示", },
		{ desc = "不使用/自己手动管理", },
		conflict = true,
	},
	{
		TAG = "统计插件",
		{ "Skada", desc = "简单易用的伤害统计插件，占用资源比Details少", },
		{ "Details", desc = "功能强大的伤害统计插件，配置比较复杂，内存占用量非常大。适合高级用户使用。插件内有仇恨模块", },
		{ desc = "不使用/自己手动管理", },
	},
	{
		TAG = "鼠标增强插件",
		{ "TipTac", desc = "", },
		{ desc = "不使用/自己手动管理", },
		conflict = true,
	},
	{
		TAG = "姓名板加强",
		{ "NeatPlates", desc = "姓名版增强，可以自定义姓名版风格，附带buff显示、施法条显示、仇恨显示等功能。", },
		{ "TidyPlates_ThreatPlates", desc = "同样好用的姓名板插件，根据喜好选择", },
		{ desc = "不使用/自己手动管理", },
		conflict = true,
	},
	{
		TAG = "推荐使用",
		{ "Dominos", desc = "多米诺动作条，可以自定义动作条布局。", 
			-- preset = true,
			-- options = {'三行紧凑型', 'MINI', '暴雪布局型', 'NORM', "小屏紧凑型", "COMPACT"},
			-- callback = function(v)
			-- 	Dominos:Unload()
			-- 	-- Dominos.db:ResetProfile()
			-- 	-- insert out diff
			-- 	Dominos:U1_SetPreset(v);
			-- 	Dominos.isNewProfile = nil
			-- 	Dominos:Load()
			-- 	local masque = U1GetMasqueCore and U1GetMasqueCore()
			-- 	if masque and masque.Group then masque:Group("Dominos"):ReSkinWithSub() end
			-- end,
		},
		{ "ExRT", desc = "有史以来最强大的魔兽世界团队工具。如果您是RL或管理，推荐强制要求全团使用。早用早爽，一直用一直爽。", },
		{ desc = "不使用/自己手动管理", },
	},
	{
		TAG = "其他界面插件",
		{ "AtlasLoot", title = "AtlasLoot", desc = "副本掉落、商业制造、声望购买物品查看，界面附带副本地图查看", },
		{ "SexyMap", desc = "小地图美化插件", },
		{ "Quartz", desc = "施法条增强", },
		{ "GatherMate2", desc = "采集助手，附带集点数据库", },
		{ desc = "不使用/自己手动管理", },
	},
	{
		TAG = "其他插件\n如果你不知道它们是做什么，那就关闭它们吧",
		{ "WeakAuras", title = "WA", desc = "WeakAuras\n技能监控，需要玩家自己定义监控内容，通过导入字符串可以实现多种功能", },
		{ "TellMeWhen", title = "TMW", desc = "TellMeWhen\n技能监控，需要玩家自己定义监控内容，更推荐使用WA（如果会配置）", },
		{ "Grid", desc = "团队框架", },
		{ "Decursive", desc = "一键驱散", },
		{ "GTFO", desc = "站位提醒插件", },
		{ "HHTD", desc = "治疗必须死插件，PVP中帮助你砍治疗", },
		{ desc = "不使用/自己手动管理", },
	},
	{
		TAG = "",
		BG = "BG14"
	},	--	14
	-- {
	-- 	TAG = "",
	-- 	BG = "BG15"
	-- },	--	15
};

StaticPopupDialogs["163UI_GUIDE_RELOADUI_CONFIRM"] = {
	preferredIndex = 1,
	text = "需要重载界面才能启用配置，现在重载？",
	button1 = YES,
	--button2 = CANCEL,
	OnAccept = function(self, data)
		ReloadUI();
	end,
	OnCancel = function(self, data)
		ReloadUI();
		print("\124cffff0000请务必在适当时候重载界面。\n可以通过输入/rl、/console reloadui、或者在有爱控制台双击重载界面来重载\n返回角色选择和退出游戏重新进入也是可以的。\124r!")
	end,
	--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
	--hideOnEscape = 1,
	OnHide = function(self, data)
		ReloadUI();
	end,
	timeout = 0,
	exclusive = 1,
	whileDead = 1,
};

StaticPopupDialogs["163UI_GUIDE_WHATSNEW"] = {
	preferredIndex = 1,
	text = "完全扁平风格已经实装，点击\124cff00ff00网易有爱控制台\124r-\124cff00ff00方案管理\124r（顶部）-\124cff00ff00扁平风格\124r开启",
	button1 = YES,
	--button2 = CANCEL,
	OnAccept = function(self, data)
	end,
	OnCancel = function(self, data)
	end,
	--OnHide = ConfirmOnCancel, --OnCancel完了会执行OnHide
	--hideOnEscape = 1,
	OnHide = function(self, data)
	end,
	timeout = 8,
	exclusive = 1,
	whileDead = 1,
};

local function _ShouldEnableAddon(name)
	if GetAddOnEnableState(UnitName('player'), name) == 0 then
		return 1;
	end
	return 0;
end
local function _ShouldDisableAddon(name)
	if GetAddOnEnableState(UnitName('player'), name) ~= 0 then
		return 1;
	end
	return 0;
end
local function _EnableAddon(name)
	EnableAddOn(name);
	U1LoadAddOn(name, nil, true);
end
local function _DisableAddon(name)
	DisableAddOn(name);
end
local function Apply(config)
	--dump(config);
	local addonInfo = U1.addonInfo;
	if not addonInfo then
		print("\124cffff0000TABLE AddonInfo Not Found!\124r");
		return;
	end
	local action = _UserGuide.action;
	if not action then
		return;
	end
	for addon, enabled in pairs(action) do
		if enabled then
			_EnableAddon(addon);
		else
			_DisableAddon(addon);
		end
	end
	for i = 1, #guideTable do
		for j = 1, #guideTable[i] do
			local topAddon = guideTable[i][j][1];
			if topAddon and _UserGuide.preset[topAddon] and guideTable[i][j].callback and IsAddOnLoaded(topAddon) then
				--print("PRESET", topAddon, _UserGuide.preset[topAddon])
				guideTable[i][j].callback(_UserGuide.preset[topAddon]);
			end
		end
	end

	_UserGuide.frame:Hide();
	if _UserGuide.needReload then
		StaticPopup_Show("163UI_GUIDE_RELOADUI_CONFIRM", 0);
	end
end
local function Last(config)
	--dump(config);
	_UserGuide.frame:HideBG();
	local addonInfo = U1.addonInfo;
	if not addonInfo then
		print("\124cffff0000TABLE AddonInfo Not Found!\124r");
		return;
	end
	local addonList = nil;
	local conflicts = nil;
	local needReload = -1;
	local final = {  };
	local action = {  };
	for i = 1, #guideTable do
		for j = 1, #guideTable[i] do
			for k = 1, #guideTable[i][j] do
				local addon = guideTable[i][j][k];
				if addon then
					if config[i][j] then
						local info = addonInfo[string.lower(addon)];
						if info then
							if info.conflicts then
								for _, ca in pairs(info.conflicts) do
									final[ca] = false;
								end
							end
						end
						final[addon] = true;
						local lowerAddon = addon:lower();
						for _, v in pairs(addonInfo) do
							if v.parent == lowerAddon then
								final[v.name] = true;
							end
						end
					else
						final[addon] = false;
					end
				end
			end
		end
	end
	for addon, enabled in pairs(final) do
		if enabled and _ShouldEnableAddon(addon) > 0 then
			needReload = needReload + 1;
			action[addon] = true;
			if addonList then
				addonList = addonList .. ", " ..  addon;
			else
				addonList = addon;
			end
		elseif not enabled and _ShouldDisableAddon(addon) > 0 then
			needReload = needReload + 1;
			action[addon] = false;
			if conflicts then
				conflicts = conflicts .. ", " .. addon;
			else
				conflicts = addon;
			end
		end
	end

	if addonList then
		addonList = "即将开启以下插件:\n" .. addonList;
	else
		addonList = "没有需要开启的插件";
	end
	if conflicts then
		conflicts = "即将关闭以下插件:\n" .. conflicts;
	else
		conflicts = "没有需要关闭的插件";
	end
	_UserGuide.final = final;
	_UserGuide.action = action;
	_UserGuide.needReload = needReload > 0;

	if _UserGuide.frame.curStep then
		for i = 1, #guideTable[_UserGuide.frame.curStep] do
			_UserGuide.elements[i].check:Hide();
		end
	end

	_UserGuide.frame:ShowLast();
	_UserGuide.frame:ShowDisplay();
	if _UserGuide.needReload then
		_UserGuide.frame:SetTag("需要重载界面");
	else
		_UserGuide.frame:SetTag("不需要重载界面");
	end
	_UserGuide.frame:SetDisplay(addonList, conflicts);
end

local elements = nil;
local function Check_OnClick(self)
	local key = self.key;
	local frame = self:GetParent();
	local step = frame.curStep;
	local sets = guideTable[step];
	--_UserGuide.config[step] = _UserGuide.config[step] or {};
	if self:GetChecked() then
		if sets.conflict then
			for i = 1, #sets do
				if i ~= key then
					elements[i].check:SetChecked(false);
					_UserGuide.config[step][i] = nil;
				end
			end
		elseif not sets[key][1] then
			for i = 1, #sets do
				if i ~= key then
					elements[i].check:SetChecked(false);
					_UserGuide.config[step][i] = nil;
				end
			end
		elseif not sets[#sets][1] then
			elements[#sets].check:SetChecked(false);
			_UserGuide.config[step][#sets] = nil;
		end
		_UserGuide.config[step][key] = true;
	else
		_UserGuide.config[step][key] = false;
		local allClosed = true;
		local index = nil;
		for j = 1, #guideTable[step] do
			if guideTable[step][j][1] then
				if _UserGuide.config[step][j] then
					allClosed = false;
				end
			else
				index = j;
			end
		end
		if allClosed and index then
			_UserGuide.config[step][index] = true;
			elements[index].check:SetChecked(true);
		end
	end
end
local function hoverGraphic(graphic, area, addon, x, y)
	graphic:SetNote(addon, x, y);
	for i = 1, #area do
		local hover = graphic.hovers[i];
		hover:SetSize(area[i][2][1] - area[i][1][1], area[i][2][2] - area[i][1][2]);
		hover:Show();
		hover:ClearAllPoints();
		hover:SetPoint("BOTTOMLEFT", area[i][1][1], area[i][1][2]);
	end
	graphic.nArea = #area;
end
local function hoverGraphic_Sticky(graphic, pic, area)
	graphic:SetGraphIndex(pic);
	graphic.sticky = true;
	graphic:Show();
	graphic.stickyFlashTimer = 0.0;
	for i = 1, #graphic.call do
		graphic.call[i]:Hide();
	end
	hoverGraphic(graphic, area);
end
local function presetOnClick(self)
	local curStep = _UserGuide.frame.curStep;
	local key = self.key;
	local v = guideTable[curStep][key];
	--print(curStep, key, v and v[1], v and v.preset)
	if v and v.preset then
		local data = {
			handler = function(button, var)
				if v[1] then
					_UserGuide.preset[v[1]] = var;
				end
			end,
			elements = {  },
		};
		for i = 1, #v.options / 2 do
			data.elements[i] = { para = { v.options[i * 2] }, text = v.options[i * 2 - 1], };
		end
		ALADROP(self, "BOTTOMLEFT",  data);
	end
end
local function hoverOnEnter(self)
	if _UserGuide.enableHoverTip then
		local v = guideTable[_UserGuide.frame.curStep][self.key];
		if v and v.pic then
			hoverGraphic_Sticky(_UserGuide.graphic, v.pic, graphicList[v.pic][v[1]].area);
		end
	end
end
local function CreateElement(frame, key)
	local check = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate");
	check:SetSize(24, 24);
	check:SetHitRectInsets(0, 0, 0, 0);
	check:GetNormalTexture():SetVertexColor(0.0, 1.0, 0.0, 1.0);
	check:GetPushedTexture():SetVertexColor(0.0, 1.0, 0.0, 1.0);
	check:GetCheckedTexture():SetVertexColor(0.0, 1.0, 0.0, 1.0);
	check:SetScript("OnClick", Check_OnClick);
	local preset = CreateFrame("Button", nil, check);
	preset:SetSize(24, 24);
	preset:SetPoint("LEFT", check, "RIGHT", 2, 0);
	preset:SetNormalTexture("interface\\minimap\\minimap-deadarrow");
	preset:GetNormalTexture():SetTexCoord(0.05, 0.95, 0.95, 0.05);
	preset:SetPushedTexture("interface\\minimap\\minimap-deadarrow");
	preset:GetNormalTexture():SetTexCoord(0.1, 1.0, 0.9, 0.0);
	preset:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	preset:EnableMouse(true);
	preset:SetScript("OnClick", presetOnClick);
	preset:SetScript("OnEnter", function(self)
		GameTooltip:ClearAllPoints();
		GameTooltip:SetOwner(self, "ANCHOR_LEFT");
		GameTooltip:SetText("使用有爱预设配置", 1.0, 1.0, 1.0);
	end);
	preset:SetScript("OnLeave", function(self)
		if GameTooltip:IsOwned(self) then
			GameTooltip:Hide();
		end
	end);
	local title = check:CreateFontString(nil, "ARTWORK");
	title:SetFont(GameFontHighlight:GetFont(), 15, "NORMAL");
	title:SetTextColor(1.0, 0.5, 0.0);
	title:SetPoint("LEFT", preset, "RIGHT", 2, 0);
	title:Show();
	local hover = CreateFrame("Button", nil, check);
	hover:SetSize(24, 24);
	hover:SetPoint("TOPLEFT", title, "TOPRIGHT", 4, 4);
	--hover:SetPoint("TOPLEFT", title);
	--hover:SetPoint("BOTTOMRIGHT", title);
	hover:SetNormalTexture("interface\\buttons\\adventureguidemicrobuttonalert");
	hover:GetNormalTexture():SetTexCoord(4 / 32, 26 / 32, 4 / 32, 26 / 32);
	hover:EnableMouse(true);
	hover:SetScript("OnEnter", hoverOnEnter);
	local texture = check:CreateTexture(nil, "ARTWORK");
	texture:SetSize(160, 160);
	texture:SetPoint("TOPLEFT", check, "BOTTOMLEFT", 0, -8);
	texture:Show();
	local desc = check:CreateFontString(nil, "ARTWORK");
	desc:SetFont(GameFontHighlight:GetFont(), 15, "NORMAL");
	--desc:SetPoint("TOPRIGHT", title, "BOTTOMRIGHT", 0, -8);
	desc:SetPoint("TOP", title, "BOTTOM", 0, -8);
	desc:SetPoint("LEFT", texture, "RIGHT", 0, 0);
	desc:Show();

	check.key = key;
	preset.key = key;
	hover.key = key;
	return { check = check, preset = preset, title = title, hover = hover, texture = texture, desc = desc, };
end
elements = setmetatable({  }, {
	__index = function(t, k)
		local ele = CreateElement(_UserGuide.frame, k);
		rawset(t, k ,ele);
		return ele;
	end
});

local function SetGuideStep(frame, step)
	if frame.prevStep then
		for i = frame.curStep and (#guideTable[frame.curStep] + 1) or 1, #guideTable[frame.prevStep] do
			elements[i].check:Hide();
		end
	end
	local sets = guideTable[frame.curStep];
	frame:SetTag(sets.TAG);
	if sets.BG then
		frame:ShowBG(artwork_path .. sets.BG);
	else
		frame:HideBG();
	end
	if sets.whatsnew then
		frame:ShowWhatsNew();
		frame:ShowWel();
	else
		frame:HideWhatsNew();
		frame:HideWel();
	end
	if #sets > 0 then
		for i = 1, #sets do
			local ele = elements[i];
			local set = sets[i];
			ele.check:Show();
			ele.check:SetChecked(_UserGuide.config[frame.curStep][i] or false);
			if set.texture then
				ele.texture:Show();
				if type(ele.texture) == "string" then
					ele.texture:SetTexture(set.texture);
				else
					ele.texture:SetTexture(artwork_path .. set[1]);
				end
			else
				ele.texture:Hide();
			end
			if set[1] then
				ele.title:SetText(set.title or table.concat(set, "\n"));
				if set.desc then
					ele.desc:SetText(set.desc);
				else
					ele.desc:SetText("");
				end
				if set.pic and graphicList[set.pic][set[1]] then
					ele.hover:Show();
				else
					ele.hover:Hide();
				end
			else
				ele.title:SetText(set.title or set.desc);
				ele.desc:SetText("");
				ele.hover:Hide();
			end
			if set.preset and set.callback then
				ele.preset:Show();
			else
				ele.preset:Hide();
			end
			if #sets <= 4 then
				local w = width / #sets - 10;
				--ele.title:SetWidth(w - 26 - 4);
				if set.desc then
					if set.texture then
						ele.texture:SetSize(w * 0.6, w * 0.6);
						ele.desc:SetWidth(w * 0.4);
					else
						ele.texture:SetWidth(w * 0.1);
						ele.desc:SetWidth(w * 0.8);
					end
				else
					ele.texture:SetSize(w, w);
				end
				local gap = (width - w * #sets) / (#sets + 1);
				ele.check:ClearAllPoints();
				ele.check:SetPoint("TOPLEFT", gap * i + w * (i - 1), -100 - 8 - 24);
			else
				local w = width / 4 - 10;
				--ele.title:SetWidth(w - 26 - 4);
				if set.desc then
					if set.texture then
						ele.texture:SetSize(w * 0.6, w * 0.6);
						ele.desc:SetWidth(w * 0.4);
					else
						ele.texture:SetWidth(w * 0.1);
						ele.desc:SetWidth(w * 0.8);
					end
				else
					ele.texture:SetSize(w, w);
				end
				local nrow = math.ceil(#sets / 2);
				local gap = (width - w * nrow) / (nrow + 1);
				if i <= nrow then
					ele.check:ClearAllPoints();
					ele.check:SetPoint("TOPLEFT", gap * i + w * (i - 1), -80 - 8 - 24);
				else
					ele.check:ClearAllPoints();
					ele.check:SetPoint("TOPLEFT", gap * (i - nrow) + w * (i - nrow - 1), -80 - 8 - 24 - 160);
				end
			end
		end
		frame:ShowHoverCheck();
		frame:ShowGraphicCall();
	else
		frame:HideHoverCheck();
		frame:HideGraphicCall();
	end
	frame:HideDisplay();
end

local function nextOnClick(self)
	local frame = self:GetParent();
	frame.prevStep = frame.curStep;
	if frame.curStep >= #guideTable then
		_UserGuide.frame:DisablePrev();
		self:Disable();
		Last(_UserGuide.config);
		return;
	else
		frame.curStep = frame.curStep + 1;
	end
	SetGuideStep(frame, frame.curStep);
	_UserGuide.frame:EnablePrev();
end
local function prevOnClick(self)
	local frame = self:GetParent();
	frame.curStep = frame.curStep or 1;
	if frame.curStep > 1 then
		frame.prevStep = frame.curStep;
		frame.curStep = frame.curStep - 1;
		if frame.curStep == 1 then
			self:Disable();
		end
		frame:EnableNext();
		SetGuideStep(frame, frame.curStep);
	end
end
local function applyOnClick(self)
	Apply(_UserGuide.config);
end
local function backOnClick(self)
	local frame = self:GetParent();
	_UserGuide.final = nil;
	_UserGuide.action = nil;
	_UserGuide.needReload = nil;
	frame:HideDisplay();
	frame:HideLast();
	frame:EnablePrev();
	frame:EnableNext();
	for i = 1, #guideTable[frame.curStep] do
		elements[i].check:Hide();
	end
	frame.prevStep = frame.curStep;
	SetGuideStep(frame, frame.curStep);
end
local function graphicOnUpdate(self, elasped)
	local l, r, t, b = self:GetLeft(), self:GetRight(), self:GetTop(), self:GetBottom();
	local x, y = GetCursorPosition();
	local s = self:GetEffectiveScale();
	x = x / s;
	y = y / s;
	if x >= l and x <= r and y >= b and y <= t then
		x = x - l;
		y = y - b;
		if not self.sticky then
			local G = graphicList[self.curGrap];
			if self.addon then
				local area = G[self.addon].area;
				local found = nil;
				for j = 1, #area do
					if x >= area[j][1][1] and y >= area[j][1][2] and x <= area[j][2][1] and y <= area[j][2][2] then
						found = true;
						break;
					end
				end
				if found then
					self:SetNote(nil, x, y);
				else
					self.addon = nil;
					self:HideAllHover();
					self:HideNote();
				end
			end
			if not self.addon then
				for addon, v in pairs(G) do
					local area = v.area;
					for j = 1, #area do
						if x >= area[j][1][1] and y >= area[j][1][2] and x <= area[j][2][1] and y <= area[j][2][2] then
							hoverGraphic(self, area, addon, x, y);
							self.addon = addon;
							break;
						end
					end
					if self.addon then
						break;
					end
				end
			end
		else
			self.stickyFlashTimer = self.stickyFlashTimer + elasped;
			if self.stickyFlashTimer > 0.5 then
				self.stickyFlashTimer = -1.0;
				if self.nArea then
					for i = 1, self.nArea do
						self.hovers[i]:Hide();
					end
				end
			elseif self.stickyFlashTimer > 0.0 then
				if self.nArea then
					for i = 1, self.nArea do
						self.hovers[i]:Show();
					end
				end
			end
		end
	elseif self.sticky then
		self.timer = self.timer + elasped;
		if self.timer > 0.1 then
			self:Hide();
		end
	end
end
local function graphicCallOnClick(self)
	local graphic = self:GetParent();
	if not graphic.sticky then
		graphic:SetGraphIndex(self.index);
	end
end
local function callOnClick(self)
	local frame = self:GetParent();
	local graphic = _UserGuide.graphic;
	graphic.sticky = nil;
	graphic:Show();
	for i = 1, #graphic.call do
		graphic.call[i]:Show();
	end
end
local function CreateGraphic(frame)
	local graphic = CreateFrame("Button", nil, frame);
	graphic:SetPoint("CENTER");
	graphic:SetSize(grw, grh);
	graphic:EnableMouse(true);
	graphic:SetFrameStrata("FULLSCREEN_DIALOG");
	graphic:RegisterForClicks("LeftButtonUp", "RightButtonUp");
	graphic:SetScript("OnClick", function(self, button)
		if button == "RightButton" then
			self:Hide();
		end
	end)
	local gt = graphic:CreateTexture(nil, "ARTWORK");
	gt:SetPoint("CENTER");
	gt:SetAllPoints();
	gt:SetTexCoord(0.0, 1600 / 2048, 0.0, 900 / 1024);
	local gc = CreateFrame("Button", nil, graphic);
	gc:SetSize(36, 36);
	gc:SetNormalTexture("Interface\\Buttons\\ui-grouploot-pass-up");
	gc:SetPushedTexture("Interface\\Buttons\\ui-grouploot-pass-up");
	gc:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	gc:SetPoint("TOPRIGHT", - 6, - 6);
	gc:SetScript("OnClick", function()
		graphic:Hide();
	end);
	local note = graphic:CreateFontString(nil, "OVERLAY");
	note:Hide();
	note:SetFont(GameFontHighlight:GetFont(), 15, "OUTLINE");
	note:SetTextColor(0.0, 1.0, 0.0);
	graphic.nGrap = #graphicList;
	graphic.hovers = setmetatable({  }, {
		__index = function(t, k)
			local hover = graphic:CreateTexture(nil, "OVERLAY");
			hover:SetTexture(artwork_path .. "hover");
			hover:SetBlendMode("ADD");
			hover:Hide();  
			rawset(t, k ,hover);
			return hover;
		end
	});
	function graphic:HideAllHover()
		for i = 1, #self.hovers do
			self.hovers[i]:Hide();
		end
	end
	function graphic:SetTexture(t)
		gt:SetTexture(t);
	end
	function graphic:SetNote(text, x, y)
		note:Show();
		if text then
			note:SetText(text);
		end
		if x and y then
			note:ClearAllPoints();
			note:SetPoint("BOTTOMLEFT", x, y);
		end
	end
	function graphic:HideNote()
		note:Hide();
	end
	function graphic:SetGraphIndex(i)
		if i <= #graphicList then
			graphic.curGrap = i;
			graphic.sticky = nil;
			self:HideAllHover();
			gt:SetTexture(artwork_path .. i);
		end
	end
	graphic:SetGraphIndex(1);
	graphic.timer = 0;
	graphic:SetScript("OnUpdate", graphicOnUpdate);
	graphic:SetScript("OnHide", function(self)
		self.timer = 0;
		self.sticky = nil;
		self.addon = nil;
		self.nArea = nil;
		self.stickyFlashTimer = nil;
		self:HideAllHover();
		self:HideNote();
	end);
	graphic:Hide();
	local graphicCall = {};
	for i = 1, #graphicList do
		local g = CreateFrame("Button", nil, graphic, "BackdropTemplate");
		g:SetSize(24, 24);
		--g:SetNormalTexture();
		g:SetPoint("TOP", graphic, "TOP", ((#graphicList - 1) / 2 - i + 1) * - 4 +(i - (#graphicList + 1) / 2) * 24, -4);
		g:SetBackdrop({
			bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
			edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
			tile = true,
			tileSize = 2,
			edgeSize = 2,
			insets = { left = 2, right = 2, top = 2, bottom = 2 }
		});
		local fs = g:CreateFontString(nil, "OVERLAY", "GameFontHighlight");
		fs:SetPoint("CENTER");
		fs:SetText(i);
		-- g:SetNormalFontObject(fs);
		-- g:SetPushedTextOffset(-1, -2);
		g:SetScript("OnClick", graphicCallOnClick);
		g.index = i;
		graphicCall[i] = g;
	end
	graphic.call = graphicCall;

	return graphic;
end
local function CreateGuideFrame()
	local frame = CreateFrame("frame", nil, UIParent, "BackdropTemplate");
	frame:SetPoint("CENTER");
	frame:SetSize(width, height);
	frame:SetFrameStrata("FULLSCREEN");
	frame:SetBackdrop({
		bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
		edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
		tile = true,
		tileSize = 2,
		edgeSize = 2,
		insets = { left = 2, right = 2, top = 2, bottom = 2 }
	});
	frame:SetBackdropColor(0.5, 0.5, 0.5, 1.0);
	
	local logo = frame:CreateTexture(nil, "ARTWORK");
	logo:SetSize(240, 60);
	logo:SetPoint("TOPLEFT", 20, -20);
	logo:SetTexture("Interface\\Addons\\!!!163UI!!!\\Textures\\UI2-watermark");
	logo:SetVertexColor(1.0, 0.75, 0.0);

	local tag = frame:CreateFontString(nil, "ARTWORK");
	tag:SetFont(GameFontHighlight:GetFont(), 20, "OUTLINE");
	tag:SetPoint("TOP", frame, "TOP", 0, -40 - 8);
	tag:SetTextColor(1.0, 0.75, 0.0);

	local bg = frame:CreateTexture(nil, "ARTWORK");
	bg:SetPoint("CENTER");
	bg:SetSize(height * 2, height);
	bg:Hide();

	local close = CreateFrame("Button", nil, frame);
	close:SetSize(36, 36);
	close:SetNormalTexture("Interface\\Buttons\\ui-grouploot-pass-up");
	close:SetPushedTexture("Interface\\Buttons\\ui-grouploot-pass-up");
	close:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	close:SetPoint("TOPRIGHT", - 6, - 6);
	close:SetScript("OnClick", function()
		frame:Hide();
		U1.db.whatsnew = false;
		-- StaticPopup_Show("163UI_GUIDE_WHATSNEW", 8);
	end);

	local next = CreateFrame("Button", nil, frame);
	next:SetSize(24, 24);
	next:SetNormalTexture("Interface\\timemanager\\ffbutton");
	next:SetPushedTexture("Interface\\timemanager\\ffbutton");
	next:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
	next:SetPoint("BOTTOMRIGHT", - 6, 6);
	next:SetScript("OnClick", nextOnClick);

	local prev = CreateFrame("Button", nil, frame);
	prev:SetSize(24, 24);
	prev:SetNormalTexture("Interface\\timemanager\\rwbutton");
	prev:SetPushedTexture("Interface\\timemanager\\rwbutton");
	prev:SetHighlightTexture("Interface\\Buttons\\CheckButtonHilight");
	prev:SetPoint("RIGHT", next, "LEFT", - 6, 0);
	prev:SetScript("OnClick", prevOnClick);
	prev:Disable();

	local displayL = frame:CreateFontString(nil, "OVERLAY");
	displayL:SetFont(GameFontHighlight:GetFont(), 18, "NORMAL");
	displayL:SetPoint("TOPLEFT", 10, -150);
	displayL:SetWidth(frame:GetWidth() * 0.5 - 15);
	displayL:Hide();

	local displayR = frame:CreateFontString(nil, "OVERLAY");
	displayR:SetFont(GameFontHighlight:GetFont(), 18, "NORMAL");
	displayR:SetPoint("TOPRIGHT", -10, -150);
	displayR:SetWidth(frame:GetWidth() * 0.5 - 15);
	displayR:Hide();

	local apply = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	apply:SetSize(80, 24);
	-- apply:SetNormalTexture("Interface\\Buttons\\ui-panel-button-up");
	-- apply:SetPushedTexture("Interface\\Buttons\\ui-panel-button-up");
	-- apply:SetHighlightTexture("Interface\\Buttons\\ui-panel-button-highlight")
	-- apply:GetNormalTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
	-- apply:GetPushedTexture():SetTexCoord(0, 78 / 128, 0, 21 / 32);
	-- apply:GetHighlightTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
	apply:SetPoint("TOP", tag, "BOTTOM", 80, -10);
	apply:Hide();
	apply:SetScript("OnClick", applyOnClick);
	apply:SetText("应用设置");
	-- local applyfs = apply:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	-- applyfs:SetPoint("CENTER");
	-- applyfs:SetText("应用设置");
	apply:Hide();

	local back = CreateFrame("Button", nil, frame, "UIPanelButtonTemplate");
	back:SetSize(80, 24);
	-- back:SetNormalTexture("Interface\\Buttons\\ui-panel-button-up");
	-- back:SetPushedTexture("Interface\\Buttons\\ui-panel-button-up");
	-- back:SetHighlightTexture("Interface\\Buttons\\ui-panel-button-highlight")
	-- back:GetNormalTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
	-- back:GetPushedTexture():SetTexCoord(0, 78 / 128, 0, 21 / 32);
	-- back:GetHighlightTexture():SetTexCoord(1 / 128, 79 / 128, 1 / 32, 22 / 32);
	back:SetPoint("TOP", tag, "BOTTOM", -72, -10);
	back:Hide();
	back:SetScript("OnClick", backOnClick);
	back:SetText("我再看看");
	-- local backfs = back:CreateFontString(nil, "ARTWORK", "GameFontHighlight");
	-- backfs:SetPoint("CENTER");
	-- backfs:SetText("我再看看");
	back:Hide();

	local wel = frame:CreateFontString(nil, "ARTWORK");
	wel:SetFont(GameFontHighlight:GetFont(), 24, "NORMAL");
	wel:SetPoint("TOP", 0, -80);
	wel:SetText("欢迎使用网易有爱");
	wel:Hide();

	local whatsnew = CreateFrame("EditBox", nil, frame);
	whatsnew:SetFont(GameFontHighlight:GetFont(), 13, "NORMAL");
	whatsnew:SetPoint("TOPLEFT", 8, -72 - 36);
	whatsnew:SetPoint("BOTTOMRIGHT", -8, - 8);
	whatsnew:SetMultiLine(true);
	whatsnew:EnableMouse(false);
	whatsnew:Disable();
	whatsnew:SetText(msg_whatsnew);
	whatsnew:Hide();

	function frame:ShowBG(texture)
		bg:Show();
		bg:SetTexture(texture);
		logo:Hide();
	end
	function frame:HideBG()
		bg:Hide();
		logo:Show();
	end
	function frame:EnableNext()
		next:Enable();
	end
	function frame:DisableNext()
		next:Disable();
	end
	function frame:EnablePrev()
		prev:Enable();
	end
	function frame:DisablePrev()
		prev:Disable();
	end
	function frame:ShowLast()
		apply:Show();
		back:Show();
	end
	function frame:HideLast()
		apply:Hide();
		back:Hide();
	end
	function frame:SetTag(text)
		tag:SetText(text);
	end
	function frame:ShowWel()
		wel:Show();
	end
	function frame:HideWel()
		wel:Hide();
	end
	function frame:ShowWhatsNew()
		whatsnew:Show();
	end
	function frame:HideWhatsNew()
		whatsnew:Hide();
	end
	function frame:ShowDisplay()
		displayL:Show();
		displayR:Show();
	end
	function frame:HideDisplay()
		displayL:Hide();
		displayR:Hide();
	end
	function frame:SetDisplay(tl, tr)
		if tl then
			displayL:SetText(tl);
		else
			displayL:SetText("");
		end
		if tr then
			displayR:SetText(tr);
		else
			displayR:SetText("");
		end
	end

	local call = CreateFrame("Button", nil, frame);
	call:SetSize(32, 32);
	call:SetPoint("TOP", 0, -8);
	call:SetNormalTexture("interface\\buttons\\adventureguidemicrobuttonalert");
	call:GetNormalTexture():SetTexCoord(4 / 32, 26 / 32, 4 / 32, 26 / 32);
	call:SetPushedTexture("interface\\buttons\\adventureguidemicrobuttonalert");
	call:GetPushedTexture():SetTexCoord(3 / 32, 25 / 32, 2 / 32, 24 / 32);
	call:SetHighlightTexture("Interface\\Buttons\\ui-panel-minimizebutton-highlight");
	call:EnableMouse(true);
	call:SetScript("OnClick", callOnClick);

	local enableHover = CreateFrame("CheckButton", nil, frame, "OptionsBaseCheckButtonTemplate");
	enableHover:SetHitRectInsets(0, 0, 0, 0);
	enableHover:GetNormalTexture():SetVertexColor(0.0, 1.0, 0.0, 1.0);
	enableHover:GetPushedTexture():SetVertexColor(0.0, 1.0, 0.0, 1.0);
	enableHover:GetCheckedTexture():SetVertexColor(0.0, 1.0, 0.0, 1.0);
	enableHover:SetPoint("BOTTOMLEFT", 4, 4);
	enableHover:SetScript("OnClick", function()
		_UserGuide.enableHoverTip = not _UserGuide.enableHoverTip;
	end);

	local enableHoverTitle = enableHover:CreateFontString(nil, "ARTWORK");
	enableHoverTitle:SetFont(GameFontHighlight:GetFont(), 15, "NORMAL");
	enableHoverTitle:SetTextColor(0.0, 1.0, 0.0);
	enableHoverTitle:SetPoint("LEFT", enableHover, "RIGHT", 4, 0);
	enableHoverTitle:Show();
	enableHoverTitle:SetText("关闭鼠标悬停图示");
	
	function frame:ShowGraphicCall()
		call:Show();
	end
	function frame:HideGraphicCall()
		call:Hide();
	end
	function frame:ShowHoverCheck()
		enableHover:Show();
	end
	function frame:HideHoverCheck()
		enableHover:Hide();
	end

	frame.curStep = 1;

	return frame;
end
local function StartGuide()
	width = math.min(GetScreenWidth() * 0.75, 800);
	height = math.min(GetScreenHeight() * 0.75, 480);
	grw = math.min(GetScreenWidth() * 0.75, 1600);
	grh = math.min(GetScreenHeight() * 0.75, 900);
	if grw * 9 > grh * 16 then
		grw = grh * 16 / 9;
	else
		grh = grw * 9 / 16;
	end
	for i = 1, #graphicList do
		for _, v in pairs(graphicList[i]) do
			v.area = {};
			for j = 1, #v.coord do
				v.area[j] = {  {  }, {  }, };
				v.area[j][1][1] = v.coord[j][1][1] * grw;
				v.area[j][1][2] = grh - v.coord[j][2][2] * grh;
				v.area[j][2][1] = v.coord[j][2][1] * grw;
				v.area[j][2][2] = grh - v.coord[j][1][2] * grh;
			end
		end
	end

	for i = 1, #guideTable do
		_UserGuide.config[i] = {};
		local allClosed = true;
		local index = nil;
		for j = #guideTable[i], 1, -1 do
			if guideTable[i][j][1] then
				local _, _, _, loadable, reason, _ = GetAddOnInfo(guideTable[i][j][1]);
				if not loadable and reason == "MISSING" then
					table.remove(guideTable[i], j);
					--print(guideTable[i][j][1])
				else
					_UserGuide.config[i][j] = IsAddOnLoaded(guideTable[i][j][1]);
					if _UserGuide.config[i][j] then
						allClosed = false;
					end
					--print(guideTable[i][j][1], _UserGuide.config[i][j])
				end
			else
				index = j;
			end
		end
		if allClosed and index then
			_UserGuide.config[i][index] = true;
		end
	end

	_UserGuide.frame = CreateGuideFrame();
	_UserGuide.elements = elements;
	-- _UserGuide.graphic = CreateGraphic(_UserGuide.frame);
	_UserGuide.frame:Show();

	_UserGuide.frame.curStep = 1;
	SetGuideStep(_UserGuide.frame, 1);

	_UserGuide.initialized = true;
end
function U1.UserGuide()do return end
	local db = U1.db;
	local dbg = U1.dbg;
	--print(db, dbg, db.version, db.prevVersion, dbg.version)
	if db.version ~= db.prevVersion then
		print("163UI is Starting Guide...")
		C_Timer.After(1.0, StartGuide);
		U1NewVersionPatchAddonSetting();
		db.whatsnew = true;
	elseif db.whatsnew then
		db.whatsnew = false;
		StaticPopup_Show("163UI_GUIDE_WHATSNEW", 0);
	end
end


function _G.U1NewVersionPatchAddonSetting(prev_ver, cur_ver)
	if U1NewVersionPatchAddonSettingFrame == nil then
		local frame = CreateFrame("FRAME", "U1NewVersionPatchAddonSettingFrame");
		local U1NewVersionPatchAddonSetting_AddonList = {
			["Details"] = {
			--	20200528105831,
				20200601000000,
				function()
					local function hand(profile)
						profile.overall_clear_newboss = false;
					end
					if _detalhes then
						hand(_detalhes);
					end
					if _detalhes_global then
						_detalhes_global.disable_talent_feature = true;
						if _detalhes_global.__profiles then
							for name, profile in pairs(_detalhes_global.__profiles) do
								if type(profile) == 'table' then
									hand(profile);
								end
							end
						end
					end
				end,
			},
			["Dominos"] = {
				20200614000000,
				function()
					if Dominos then
						Dominos:SetRightClickUnit(nil);
					end
				end,
			},
			["BigDebuffs"] = {
				20200614000000,
				function()
					local BigDebuffs = LibStub("AceAddon-3.0"):GetAddon("BigDebuffs");
					if BigDebuffs then
						BigDebuffs.db.profile.raidFrames.showAllClassBuffs = false;
						BigDebuffs.db.profile.raidFrames.enabled = false;
						BigDebuffs:Refresh();
					end
				end,
			},
			["Quartz"] = {
				20200617000000,
				function()
					local Quartz3 = LibStub("AceAddon-3.0"):GetAddon("Quartz3");
					if Quartz3 then
						Quartz3.db.profiles.Default.modules.Buff = false;
					end
				end
			},
		};
		local version = U1.db.prevVersion or -1;
		frame:SetScript("OnEvent", function(_, event, addon)
			local meta = U1NewVersionPatchAddonSetting_AddonList[addon];
			if meta then
				if meta[1] >= version then
					C_Timer.After(0.1, meta[2]);
				end
				U1NewVersionPatchAddonSetting_AddonList[addon] = nil;
				if next(U1NewVersionPatchAddonSetting_AddonList) == nil then
					frame:UnregisterAllEvents();
					frame:SetScript("OnEvent", nil);
					frame = nil;
					U1NewVersionPatchAddonSetting_AddonList = nil;
				end
			end
		end);
		frame:RegisterEvent("ADDON_LOADED");
		for addon, meta in pairs(U1NewVersionPatchAddonSetting_AddonList) do
			if meta[1] < version then
				U1NewVersionPatchAddonSetting_AddonList[addon] = nil;
			elseif IsAddOnLoaded(addon) then
				if meta[1] >= version then
					C_Timer.After(0.1, meta[2]);
				end
				U1NewVersionPatchAddonSetting_AddonList[addon] = nil;
			end
		end
	end
end


SLASH_163UIGUIDE1 = "/163UIGuide";
SLASH_163UIGUIDE2 = "/163Guide";
SLASH_163UIGUIDE3 = "/163g";
SlashCmdList["163UIGUIDE"] = function()
	if _UserGuide.initialized then
		_UserGuide.frame.prevStep = _UserGuide.frame.curStep;
		_UserGuide.frame.curStep = 1;
		SetGuideStep(_UserGuide.frame, 1);
		_UserGuide.frame:DisablePrev();
		_UserGuide.frame:EnableNext();
		_UserGuide.frame:HideLast();
		_UserGuide.frame:Show();
	else
		StartGuide();
	end
end
