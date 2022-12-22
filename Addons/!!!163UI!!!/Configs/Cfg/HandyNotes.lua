﻿U1RegisterAddon("HandyNotes", {
    title = "地图标记",
    tags = { "TAG_MAP", },
    defaultEnable = 0,
    load = "NORMAL",
    optionsAfterLogin = 1,

    icon = [[Interface\Icons\Ability_Hunter_MarkedForDeath]],
    desc = "一个小巧且全能的地图标记注释功能类插件.``ALT+右键 添加一个注释标记`Ctrl+Shift+拖拽 移动已经添加的注释标记```设置口令：/handynotes",

    nopic = 1,
    {
        text = "配置选项",
        callback = function()
            LibStub("AceConfigDialog-3.0"):Open("HandyNotes")
        end
    },
    {
        text = "重置数据",
        tip = "说明`为了加快载入速度，网易有爱修改HandyNotes每个版本只查询一次数据，把数据保存起来，如果有问题请重置一下",
        reload = 1,
        callback = function()
            HandyNotesDB._mapData = nil
            U1Message("数据已重置，请重载界面")
        end
    }
});

U1RegisterAddon("HandyNotes_Argus", {
    title = "阿古斯地图宝箱",
    defaultEnable = 1,
    load = "NORMAL",
    modifier = "Vincero@NGA汉化",
})

U1RegisterAddon("HandyNotes_BattleForAzerothTreasures", {
    title = "争霸艾酱宝箱",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_CovenantSanctum", {
    title = "盟约圣所",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_Dragonflight", {
    title = "巨龙时代",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_DraenorTreasures", {
    title = "德拉诺地图宝箱",
    defaultEnable = 0,
    load = "NORMAL",
    desc = "在德拉诺地图上显示宝藏和稀有精英的位置, 数据量很大, 可能会造成卡顿, 请在需要时开启.",
    modifier = "Vincero@NGA汉化",
})

U1RegisterAddon("HandyNotes_DungeonLocations", {
    title = "副本入口",
    defaultEnable = 0,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_HallowsEnd", {
    title = "万圣节糖罐位置",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_LegionRaresTreasures", {
    title = "军团再临地图宝箱",
    defaultEnable = 1,
    load = "NORMAL",
    desc = "在军团再临地图上显示宝藏和稀有精英的位置, 数据量很大, 可能会造成卡顿, 请在需要时开启.",
    modifier = "Vincero@NGA汉化",
})

U1RegisterAddon("HandyNotes_LunarFestival", {
    title = "春节长者位置",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_Oribos", {
    title = "奥利波斯",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_Shadowlands", {
    title = "暗影国度稀有和宝箱",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_SummerFestival", {
    title = "仲夏节篝火位置",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_SuramarShalAranTelemancy", {
    title = "苏拉玛传送门",
    desc = "苏拉玛传送门",
    modifier = "karlock",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_VisionsOfNZoth", {
    title = "恩佐斯的幻象",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_WarfrontRares", {
    title = "阿拉希和黑海岸稀有",
    defaultEnable = 1,
    load = "NORMAL",
})

U1RegisterAddon("HandyNotes_WorldMapButton", {
    title = "世界地图图标开关",
    defaultEnable = 1,
    load = "NORMAL",
})
