--[[--
	PLUGIN: Eye of the Jailer
--]]--

local __addon, __ns = ...;
__ns = __ns or _G.__core_public.__ns_plugins;
__addon = __addon or __ns.__addon;


if __ns.__client._TocVersion < 90000 then
	return;
end

local __plugins = __ns.__plugins;

if __ns.__is_dev then
	setfenv(1, __ns.__env);
end

----------------------------------------------------------------

-->	upvalue
local C_Timer_After = C_Timer.After;
local C_UIWidgetManager_GetTopCenterWidgetSetID = C_UIWidgetManager.GetTopCenterWidgetSetID;
local C_UIWidgetManager_GetAllWidgetsBySetID = C_UIWidgetManager.GetAllWidgetsBySetID;
local C_UIWidgetManager_GetDiscreteProgressStepsVisualizationInfo = C_UIWidgetManager.GetDiscreteProgressStepsVisualizationInfo;


do
	local ContainerFrame = nil;
	local __EventHandler = nil;
	local _TextContainer = nil;

	local function fade()
		_TextContainer._TextAdd:SetAlpha(0.0);
	end
	local _oldValue = nil;
	local function showChange(newValue)
		if _oldValue ~= nil and _oldValue ~= newValue then
			local _diff = newValue - _oldValue;
			_TextContainer._TextAdd:SetAlpha(1);
			if _diff > 0 then
				_TextContainer._TextAdd:SetText("+" .. _diff);
			else
				_TextContainer._TextAdd:SetText(_diff);
			end
			C_Timer_After(3, fade);
		end
		_oldValue = newValue
	end
	local function OnEvent()
		if ContainerFrame:IsShown() then
			local _setID = C_UIWidgetManager_GetTopCenterWidgetSetID();
			local _widgets = C_UIWidgetManager_GetAllWidgetsBySetID(_setID);
			for _index = 1, #_widgets do
				local _widget = _widgets[_index];
				local _info = C_UIWidgetManager_GetDiscreteProgressStepsVisualizationInfo(_widget.widgetID);
				if _info ~= nil then
					local _value = _info.progressVal;
					if _value ~= nil and _value > 0 then
						_TextContainer:Show();
						showChange(_value);
						_TextContainer._Text:SetText(_value);
						return;
					else
						break
					end
				end
			end
			_oldValue = nil;
			_TextContainer:Hide();
		end
	end

	local _isInitialized = false;
	local function _Init(loading)
		_isInitialized = true;
		ContainerFrame = UIWidgetTopCenterContainerFrame;
		__EventHandler = CreateFrame("Frame");
		__EventHandler:RegisterEvent("PLAYER_ENTERING_WORLD");
		__EventHandler:RegisterEvent("ZONE_CHANGED");
		__EventHandler:RegisterEvent("UPDATE_UI_WIDGET");
		__EventHandler:RegisterEvent("UPDATE_ALL_UI_WIDGETS");
		_TextContainer = CreateFrame('FRAME', nil, ContainerFrame);
			_TextContainer:SetAllPoints();
			_TextContainer:Hide();
			_TextContainer:SetFrameStrata("HIGH");
			local _Text = _TextContainer:CreateFontString();
				_Text:SetFontObject(GameFontNormal);
				_Text:SetPoint("CENTER");
			_TextContainer._Text = _Text;
			local _TextAdd = _TextContainer:CreateFontString();
				_TextAdd:SetFontObject(GameFontHighlight);
				_TextAdd:SetPoint("CENTER", 0, -20);
			_TextContainer._TextAdd = _TextAdd;
		ContainerFrame._TextContainer = _TextContainer;
	end
	local function _Enable(loading)
		if not _isInitialized then
			_Init(loading);
		end
		__EventHandler:SetScript("OnEvent", OnEvent);
		if not loading then
			OnEvent();
		end
	end
	local function _Disable(loading)
		if __EventHandler ~= nil then
			__EventHandler:SetScript("OnEvent", nil);
		end
		if _TextContainer ~= nil then
			_TextContainer:Hide();
		end
	end

	__plugins['Eye_of_the_Jailer'] = { _Enable, _Disable, };
end
