U1RegisterAddon("DBM_Mods_Bfa", {
    title = "DBM决战艾泽拉斯",
    desc = "DBM首领模块, 8.0决战艾泽拉斯副本",
    --icon = "Interface\\Icons\\Achievement_Zone_Northrend_01",
    icon = "Interface\\Icons\\Inv_HeartOfAzeroth",
    nopic = 1,
    tags = { "TAG_RAID", },
    defaultEnable = 1,
    nolodbutton = 1,
    dummy = 1,
    children = {
        "DBM-BfA",
        "DBM-Party-BfA",
        "DBM-CrucibleofStorms",
        "DBM-EternalPalace",
        "DBM-Nyalotha",
        "DBM-Uldir",
        "DBM-ZuldazarRaid",
    },
    toggle = function(name, info, enable, justload)
    end,
});

U1RegisterAddon("DBM-BfA", {title = "艾泽拉斯", parent = "DBM_Mods_Bfa", protected = 1, });
U1RegisterAddon("DBM-Party-BfA", {title = "争霸艾泽拉斯5人本", parent = "DBM_Mods_Bfa", protected = 1, });
U1RegisterAddon("DBM-CrucibleofStorms", {title = "风暴熔炉", parent = "DBM_Mods_Bfa", protected = 1, });
U1RegisterAddon("DBM-EternalPalace", {title = "永恒王宫", parent = "DBM_Mods_Bfa", protected = 1, });
U1RegisterAddon("DBM-Nyalotha", {title = "尼奥罗萨，觉醒之城", parent = "DBM_Mods_Bfa", protected = 1, });
U1RegisterAddon("DBM-Uldir", {title = "奥迪尔", parent = "DBM_Mods_Bfa", protected = 1, });
U1RegisterAddon("DBM-ZuldazarRaid", {title = "达萨罗之战", parent = "DBM_Mods_Bfa", protected = 1, });
