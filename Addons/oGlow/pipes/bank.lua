-- TODO:
--  - Write a description.

local GetContainerFreeSlots = GetContainerFreeSlots or C_Container.GetContainerFreeSlots;
local GetContainerNumSlots = GetContainerNumSlots or C_Container.GetContainerNumSlots;
local GetContainerNumFreeSlots = GetContainerNumFreeSlots or C_Container.GetContainerNumFreeSlots;
local GetContainerItemInfo = GetContainerItemInfo or C_Container.GetContainerItemInfo;
local GetContainerItemID = GetContainerItemID or C_Container.GetContainerItemID;
local GetContainerItemLink = GetContainerItemLink or C_Container.GetContainerItemLink;
local GetContainerItemDurability = GetContainerItemDurability or C_Container.GetContainerItemDurability;
local GetContainerItemCooldown = GetContainerItemCooldown or C_Container.GetContainerItemCooldown;
local UseContainerItem = UseContainerItem or C_Container.UseContainerItem;
local ContainerIDToInventoryID = ContainerIDToInventoryID or C_Container.ContainerIDToInventoryID;



local _E

local update = function(self)
	if(BankFrame:IsShown()) then
		for i=1, NUM_BANKGENERIC_SLOTS or 28 do
			local slotFrame = _G['BankFrameItem' .. i]
			local slotLink = GetContainerItemLink(-1, i)

			self:CallFilters('bank', slotFrame, _E and slotLink)
		end
	end
end

local enable = function(self)
	_E = true

	self:RegisterEvent('BANKFRAME_OPENED', update)
	self:RegisterEvent('PLAYERBANKSLOTS_CHANGED', update)
end

local disable = function(self)
	_E = nil

	self:UnregisterEvent('BANKFRAME_OPENED', update)
	self:UnregisterEvent('PLAYERBANKSLOTS_CHANGED', update)
end

oGlow:RegisterPipe('bank', enable, disable, update, 'Player bank frame', nil)
