
-----------------------------------
----- Core.lua
----- 使用Ace库创建插件 并提供开关
----- 2010 - 09 - 29
----- Terry@ bf
-----------------------------------
local T = LibStub("AceAddon-3.0"):NewAddon("TUnitFrame")
if not T then return end
T:SetDefaultModuleLibraries("AceEvent-3.0")
T:SetDefaultModuleState(false)

local _G = _G
local party,target,player

local _debug = false
local function debug_print(addon , ...)
	if _debug and BigFoot_Print then
		BigFoot_Print(...)
	end
end

-- PorEnhance
function TUnitFrame_SwitchPartyTarget(flag)
	party = T:GetModule("Party")
	assert(party,"Party target module does not exist")
	party:ToggleTarget(flag)
end

function TUnitFrame_SwitchPartyCastBar(flag)
	party = T:GetModule("Party")
	assert(party,"Party target module does not exist")
	party:ToggleCastBar(flag)
end

function TUnitFrame_Switch3DPor(flag)
	target = T:GetModule("Target")
	target:Toggle3DPor(flag)
	player = T:GetModule("Player")
	player:Toggle3DPor(flag)
	-- party = T:GetModule("Party")
	-- party:Toggle3DPor(flag)
end

function TUnitFrame_SwitchClassInfo(flag)
	target = T:GetModule("Target")
	target:ToggleClass(flag)
	-- party = T:GetModule("Party")
	-- party:ToggleClass(flag)
end

function TUnitFrame_SwitchPlayerInfoPane(flag)
	player = T:GetModule("Player")
	player:ToggleInfoPane(flag)
end

function TUnitFrame_SwitchMemberInfoPane(flag)
	party = T:GetModule("Party")
	party:ToggleInfoPane(flag)
end

function TUnitFrame_SwitchFormat(flag)
	player = T:GetModule("Player")
	player:ToggleFormattedText(flag)
	-- party = T:GetModule("Party")
	-- party:ToggleFormattedText(flag)
end

-- BuffMaster
function TUnitFrame_AdjustBuffSize(isMine, size)
	target = T:GetModule("Target")
	if not target:IsEnabled() then
		target:Enable()
	end
	if isMine then
		target.config.self = size or target.config.self
	else
		target.config.other = size or target.config.other
	end
	-- TargetFrame_UpdateAuras(_G.TargetFrame)
	_G.TargetFrame:UpdateAuras()
end

function TUnitFrame_ResetBuffSize()
	TUnitFrame_AdjustBuffSize(true,23)
	TUnitFrame_AdjustBuffSize(false,17)
	target:Disable()
end

function T:OnInitialize()
	self.Debug = debug_print
	self:Debug("TUnitFrame loaded")
end
