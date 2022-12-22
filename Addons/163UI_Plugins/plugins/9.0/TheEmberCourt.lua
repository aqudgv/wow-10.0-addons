--[=[
	MISC
--]=]

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;


if __ns.__client._TocVersion < 90000 then
	return;
end

local __meta = __ns.__meta;
local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

local _F_coreDebug = __ns._F_coreDebug;
----------------------------------------------------------------

-->		upvalue
	local C_Timer_After = C_Timer.After;


local LOC = {
	[640] = "娱",
	[641] = "茶",
	[653] = "客",
};

do
	--[=[]]
		--		PLAYER_CHOICE_UPDATE(nil)
		--		choiceID
			653 = 客人（加里丹勋爵）
			640 = 娱乐（屁屁）
			641 = 茶点（挑剔的斯特凡）
		--		茶水列表、娱乐列表···		--	WTF BLZ BULLSHIT
			混乱	整洁
			327446 混乱 nil 132108 0 0 0 327446
			327447 整洁 nil 655994 0 0 0 327447
			安全	危险
			327448 安全 nil 633042 0 0 0 327448
			327449 危险 nil 1455893 0 0 0 327449
			朴实	颓废
			327450 朴实 nil 236994 0 0 0 327450
			327451 颓废 nil 237358 0 0 0 327451
			刺激	放松
			327452 刺激 nil 134272 0 0 0 327452
			327453 放松 nil 136041 0 0 0 327453
			休闲	正式
			327454 休闲 nil 135016 0 0 0 327454
			327455 正式 nil 135030 0 0 0 327455
		--		客人列表···					--	WTF BLZ BULLSHIT
			327339 混乱 nil 132108 0 0 0 327339
			327340 整洁 nil 655994 0 0 0 327340
			327341 安全 nil 633042 0 0 0 327341
			327342 危险 nil 1455893 0 0 0 327342
			327343 朴实 nil 236994 0 0 0 327343
			327344 颓废 nil 237358 0 0 0 327344
			327346 刺激 nil 134272 0 0 0 327346
			327347 放松 nil 136041 0 0 0 327347
			327348 休闲 nil 135016 0 0 0 327348
			327349 正式 nil 135030 0 0 0 327349
		--
		--	Creature-0-3149-2222-32324-165490-0000791DDF
	--]=]
	local _enabled = true;

	local _ui = nil;
	local _LT_Table = {
		{ 327446, 327447, },	--	混乱 = 132108, 整洁 = 655994
		{ 327448, 327449, },	--	安全 = 633042, 危险 = 1455893
		{ 327450, 327451, },	--	朴实 = 236994, 颓废 = 237358
		{ 327452, 327453, },	--	刺激 = 134272, 放松 = 136041
		{ 327454, 327455, },	--	休闲 = 135016, 正式 = 135030
		Get = function(self, id)
			local val = self[id];
			if val ~= nil then
				if val[2] == nil or val[3] == nil then
					local _name, _, _texture = GetSpellInfo(id);
					val[2] = _name;
					val[3] = _texture;
				end
				return val;
			end
		end,
		__REMAP = {
			[327339] = 327446,
			[327340] = 327447,
			[327341] = 327448,
			[327342] = 327449,
			[327343] = 327450,
			[327344] = 327451,
			[327346] = 327452,
			[327347] = 327453,
			[327348] = 327454,
			[327349] = 327455,
		},
	};
	local _LB_isIdling = true;
	local _LT_ChoicesTable = {
		[640] = {  },
		[641] = {  },
		[653] = {  },
	};
	local function _LF_ShowChoice(choiceID)
		local _tbl = _LT_ChoicesTable[_choiceID];
		for _index = 1, 3 do
			local _current = LOC[_choiceID] .. _index;
			local _id = _tbl[_index];
			if _id ~= nil then
				local _val = _LT_Table:Get(_id);
				if _val ~= nil then
					if _val[4] > 0 then
						_current = _current .. "  |T" .. _val[3] .. ":18|t" .. _val[2] .. "|cff00ff00+++|r";
					end
					local _opp = _LT_Table:Get(_val[1]);
					if _opp ~= nil then
						_current = _current .. "  |T" .. _opp[3] .. ":18|t" .. _opp[2] .. "|cffff0000+++|r";
					else
						_current = _current .. "???|cffff0000+++|r";
					end
					if _val[4] < 0 then
						_current = _current .. "  |T" .. _val[3] .. ":18|t" .. _val[2] .. "|cff00ff00+++|r";
					end
					-- _F_coreDebug(_id, _val[1], _val[2], _opp[2])
				end
			end
		end
	end
	local function _LF_EXECUTION_PLAYER_CHOICE_UPDATE()
		_LB_isIdling = true;
		local _frame = PlayerChoiceFrame;
		if _frame:IsShown() then
			local _choiceID = _frame.choiceID;	--	C_PlayerChoice.GetPlayerChoiceInfo().choiceID
			--	640 = 娱乐（屁屁）
			--	641 = 茶点（挑剔的斯特凡）
			--	653 = 客人（加里丹勋爵）
			if _LT_ChoicesTable[_choiceID] ~= nil then
				local _Options = _frame.Options;
				for _index = 1, 3 do
					_LT_ChoicesTable[_choiceID][_index] = {  };
					local _option = _Options[_index];
					if _option ~= nil and _option.WidgetContainer ~= nil then
						local _children = { _option.WidgetContainer:GetChildren() };
						local _numChildren = #_children;
						if _numChildren > 0 then
							local _current = LOC[_choiceID] .. _index;
							for _index2 = 1, _numChildren do
								if _children[_index2]:IsShown() then
									local _Spell = _children[_index2].Spell;
									if _Spell ~= nil then
										local _id = _Spell.spellID;
										if _id ~= nil then
											_id = _LT_Table.__REMAP[_id] or _id;
											tinsert(_LT_ChoicesTable[_choiceID][_index], _id);
											local _val = _LT_Table:Get(_id);
											if _val ~= nil then
												if _val[4] > 0 then
													_current = _current .. "  |T" .. _val[3] .. ":18|t" .. _val[2] .. "|cff00ff00+++|r";
												end
												local _opp = _LT_Table:Get(_val[1]);
												if _opp ~= nil then
													_current = _current .. "  |T" .. _opp[3] .. ":18|t" .. _opp[2] .. "|cffff0000+++|r";
												else
													_current = _current .. "???|cffff0000+++|r";
												end
												if _val[4] < 0 then
													_current = _current .. "  |T" .. _val[3] .. ":18|t" .. _val[2] .. "|cff00ff00+++|r";
												end
												-- _F_coreDebug(_id, _val[1], _val[2], _opp[2])
											end
										end
									end
								end
							end
							-- _F_coreDebug(_index, _current);
							local _line = _ui[_choiceID][_index];
							_line:SetText(_current);
							local _info2 = C_PlayerChoice.GetPlayerChoiceOptionInfo(_index);
							_F_coreDebug(_index, _info2.subHeader)
							if _info2.subHeader == "已选择" then
								_line._Background:Show();
							else
								_line._Background:Hide();
							end
							_ui:Show();
						else
							local _line = _ui[_choiceID][_index];
							_line:SetText("");
							_line._Background:Hide();
							_LT_ChoicesTable[_choiceID][_index] = nil;
						end
					else
						local _line = _ui[_choiceID][_index];
						_line:SetText("");
						_line._Background:Hide();
						_LT_ChoicesTable[_choiceID][_index] = nil;
					end
				end
			end
		end
	end
	local function _LF_PLAYER_CHOICE_UPDATE()
		if _LB_isIdling and _enabled then
			_LB_isIdling = false;
			C_Timer_After(0.1, _LF_EXECUTION_PLAYER_CHOICE_UPDATE);
		end
	end

	local _isInitialized = false;
	local function _Init()
		_isInitialized = true;
		for _index = 1, #_LT_Table do
			local _val = _LT_Table[_index];
			local _name1, _, _texture1 = GetSpellInfo(_val[1]);
			_LT_Table[_val[1]] = { _val[2], name1, _texture1, 1, };
			local _name2, _, _texture2 = GetSpellInfo(_val[2]);
			_LT_Table[_val[2]] = { _val[1], name2, _texture2, -1, };
		end
		_ui = __uilib:FRAME(nil, UIParent)
			:SetSize(560, 240):SetPoint("TOP"):Hide()
			:EnableMouse(true)
				:CreateTexture(nil, "BACKGROUND"):Key("_Background")
					:SetAllPoints()
					:SetColorTexture(0.0, 0.0, 0.0, 0.25)
					:up()
				:BUTTON():Key("_Close")
					:SetSize(24, 24):SetPoint("TOPRIGHT", -2, -2)
					:SetNormalTexture([[interface\buttons\ui-panel-minimizebutton-up]])
					:SetPushedTexture([[interface\buttons\ui-panel-minimizebutton-down]])
					:SetScript("OnClick", function(self)
						self:GetParent():Hide();
					end)
					:up()
			:un();
			--
			local function _LF_CreateFontString(p, y)
				local _bg = __uilib(p:CreateTexture(nil, "BACKGROUND")):Key("_Background")
					:SetHeight(20):SetPoint("LEFT"):SetPoint("RIGHT"):SetPoint("TOP", 0, y):Hide()
					:SetColorTexture(0.5, 0.25, 0.0, 0.25)
					:un();
				local _fs = __uilib(p:CreateFontString(nil, "ARTWORK"))
					:SetPoint("CENTER", _bg, "CENTER")
					:SetFont(GameFontNormal:GetFont(), 14)
					:un();
				_fs._Background = _bg;
				return _fs;
			end
			_ui[640] = {  };
			_ui[641] = {  };
			_ui[653] = {  };
			_ui[640][1] = _LF_CreateFontString(_ui, -30);
			_ui[640][2] = _LF_CreateFontString(_ui, -50);
			_ui[640][3] = _LF_CreateFontString(_ui, -70);
			_ui[641][1] = _LF_CreateFontString(_ui, -90);
			_ui[641][2] = _LF_CreateFontString(_ui, -110);
			_ui[641][3] = _LF_CreateFontString(_ui, -130);
			_ui[653][1] = _LF_CreateFontString(_ui, -150);
			_ui[653][2] = _LF_CreateFontString(_ui, -170);
			_ui[653][3] = _LF_CreateFontString(_ui, -190);
			--
		__meta._F_metaOnEvent("PLAYER_CHOICE_UPDATE", _LF_PLAYER_CHOICE_UPDATE);
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		_enabled = true;
	end
	local function _Disable(loading)
		_enabled = false;
		if _ui ~= nil and _ui:IsShown() then
			_ui:Hide();
		end
	end

	__plugins['TheEmberCourt'] = { _Enable, _Disable, };
end
