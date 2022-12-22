-- TODO:
--  - Prevent unnecessary double updates.
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



local hook
local _E

local pipe = function(self)
    if IsAddOnLoaded("Bagnon") then return end
	if(oGlow:IsPipeEnabled'bags') then
		for i, slotFrame in self:EnumerateValidItems() do
			local bid = slotFrame:GetBagID();
			local slotLink = GetContainerItemLink(bid, slotFrame:GetID())
			oGlow:CallFilters('bags', slotFrame, _E and slotLink)
		end
	end
end

local update = function(self)
    for i, frame in ipairs(UIParent.ContainerFrames) do
        if not frame:IsBankBag() then
            pipe(frame)
        end
    end
end

local enable = function(self)
	_E = true

	if(not hook) then
		for i, frame in ipairs(UIParent.ContainerFrames) do
            if not frame:IsBankBag() then
                hooksecurefunc(frame, "Update", pipe)
            end
		end
		if ContainerFrameCombinedBags then
			hooksecurefunc(ContainerFrameCombinedBags, "Update", pipe)
		end
		hook = true
	end
end

local disable = function(self)
	_E = nil
end

oGlow:RegisterPipe('bags', enable, disable, update, 'Bag containers', nil)
