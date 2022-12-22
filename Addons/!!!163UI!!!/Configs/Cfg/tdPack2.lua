
U1RegisterAddon('tdPack2', {
    title = '背包整理',
    defaultEnable = 1,
    tags = { "TAG_ITEM", },
    desc = "在背包窗口上显示背包整理按钮，可以按照预订顺序快速整理物品。`ctrl或shift右键点击整理按钮可以设置正序或逆序（背包的空格在前还是在后），下次整理只需要左键单击就能使用之前设置的顺序。",
    icon = [[Interface\Icons\INV_Misc_Bag_10_Green]],
    load = "LATER",

    {
        text = "配置选项",
        callback = function(cfg, v, loading)
            InterfaceOptionsFrame_Show();
            InterfaceOptionsFrame_OpenToCategory("tdPack2")
        end
    }

})

