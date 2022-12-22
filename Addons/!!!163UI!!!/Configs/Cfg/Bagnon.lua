U1RegisterAddon("Bagnon", {
    title = "简约背包整合",
    defaultEnable = 1,
    load = "NORMAL", --注意要和BagBrother统一
    nopic = true,
    conflicts = { "Combuctor" },

    tags = { "TAG_ITEM", },
    desc = "整合背包/银行/公会银行/虚空储存，并支持离线查看。与分类背包整合（Combuctor）功能重复，建议只开启一个背包整合插件。",
    icon = [[Interface\Icons\INV_Misc_Bag_13]],
    optdeps = { "BagBrother" },

    -- runBeforeLoad = function(info, name)
    --     if Bagnon_Sets ~= nil and Bagnon_Sets.global ~= nil then
    --         for _, v in next, Bagnon_Sets.global do
    --             if type(v) == 'table' then
    --                 v.sort = false;
    --             end
    --         end
    --     end
    -- end,
    {
        var = "sort",
        default = true,
        text = "开启所有背包整理",
        -- tip = "说明：`开启后，每次进战斗都会打开自动发送功能。` `建议：放弃战斗后，可以通过/da命令临时屏蔽自动发送，防止无意义的刷屏（后面死的都是自杀速死）。",
        -- getvalue = function() return not DEATH_ANNOUNCE_OFF end,
        callback = function(cfg, v, loading)
            if Bagnon_Sets ~= nil and (Bagnon_Sets.__20201201_0 == nil or not loading) then
                Bagnon_Sets.__20201201_0 = true;
                if v then
                    if Bagnon_Sets.global ~= nil then
                        if Bagnon_Sets.global.inventory ~= nil then
                            Bagnon_Sets.global.inventory.sort = true;
                        end
                        if Bagnon_Sets.global.bank ~= nil then
                            Bagnon_Sets.global.bank.sort = true;
                        end
                        if Bagnon_Sets.global.vault ~= nil then
                            Bagnon_Sets.global.vault.sort = true;
                        end
                    end
                else
                    if Bagnon_Sets.global ~= nil then
                        if Bagnon_Sets.global.inventory ~= nil then
                            Bagnon_Sets.global.inventory.sort = false;
                        end
                        if Bagnon_Sets.global.bank ~= nil then
                            Bagnon_Sets.global.bank.sort = false;
                        end
                        if Bagnon_Sets.global.vault ~= nil then
                            Bagnon_Sets.global.vault.sort = false;
                        end
                    end
                end
                Bagnon.Frames:Update();
            end
        end,
    },

    -- {
    --     var = "reverseBag",
    --     default = false,
    --     text = "背包整理反向排列",
    --     -- tip = "说明：`开启后，每次进战斗都会打开自动发送功能。` `建议：放弃战斗后，可以通过/da命令临时屏蔽自动发送，防止无意义的刷屏（后面死的都是自杀速死）。",
    --     -- getvalue = function() return not DEATH_ANNOUNCE_OFF end,
    --     callback = function(cfg, v, loading)
    --         C_Container.SetSortBagsRightToLeft(true);
    --         if loading then return end
    --         if IsLoggedIn() then
    --             if v then
    --                 --true,true,true
    --                 -- C_Container.SetSortBagsRightToLeft(true);
    --                 if Bagnon_Sets ~= nil and Bagnon_Sets.global ~= nil and Bagnon_Sets.global.inventory ~= nil then
    --                     Bagnon_Sets.global.inventory.reverseBags = true;
    --                     Bagnon_Sets.global.inventory.reverseSlots = true;
    --                 end
    --                 ----C_Container.SetInsertItemsLeftToRight
    --             else
    --                 --true,false,false
    --                 -- C_Container.SetSortBagsRightToLeft(true);
    --                 --C_Container.SetInsertItemsLeftToRight
    --                 if Bagnon_Sets ~= nil and Bagnon_Sets.global ~= nil and Bagnon_Sets.global.inventory ~= nil then
    --                     Bagnon_Sets.global.inventory.reverseBags = false;
    --                     Bagnon_Sets.global.inventory.reverseSlots = false;
    --                 end
    --             end
    --             Bagnon.Frames:Update();
    --         end
    --     end,
    -- },

    -- {
    --     var = "SetInsertItemsLeftToRight",
    --     default = not not C_Container.GetInsertItemsLeftToRight(),
    --     text = "新物品放到左边行囊",
    --     tip = "说明：`默认关闭`因为暴雪XJB改，背包整理乱七八糟，所以把所有相关设置都放在这里。按照自己的喜好来设置吧",
    --     getvalue = function() return C_Container.GetInsertItemsLeftToRight() end,
    --     callback = function(cfg, v, loading)
    --         if loading then return end
    --         if IsLoggedIn() then
    --             if v then
    --                 C_Container.SetInsertItemsLeftToRight(true);
    --             else
    --                 C_Container.SetInsertItemsLeftToRight(false);
    --             end
    --         end
    --     end,
    -- },

    {
        text = "打开设置界面",
        callback = function()
            Bagnon:ShowOptions()
        end,
    },

    {
        text = "重置所有设置",
        confirm = "设置将无法恢复！\n确认重置并自动重载界面？",
        callback = function()
            Bagnon_Sets = nil
            ReloadUI()
        end
    },
});

U1RegisterAddon("Bagnon_Config", {
    parent = "Bagnon",
    protected = 1,
    hide = 1,
});

U1RegisterAddon("Bagnon_GuildBank", {
    parent = "Bagnon",
    --load = "NORMAL",
    title = "公会银行",
    desc = "暂时不能更改权限, 如有需要请关闭该子插件",
    defaultEnable = 0,
});

U1RegisterAddon("Bagnon_VoidStorage", {
    parent = "Bagnon",
    --load = "NORMAL",
    title = "虚空储存",
    defaultEnable = 0,
});