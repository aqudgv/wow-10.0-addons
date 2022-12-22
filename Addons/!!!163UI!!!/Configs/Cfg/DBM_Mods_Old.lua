U1RegisterAddon("DBM_Mods_Old", {
    title = "DBM燃烧的远征和经典旧世",
    desc = "DBM首领模块, 1.0经典旧世2.0燃烧的远征副本",
    icon = "Interface\\Icons\\ExpansionIcon_BurningCrusade",
    nopic = 1,
    tags = { "TAG_RAID", },
    defaultEnable = 1,
    nolodbutton = 1,
    dummy = 1,
    children = {
        "DBM-Party-Classic",
        "DBM-Party-BC",
    },
    toggle = function(name, info, enable, justload)
    end,
});

U1RegisterAddon("DBM-Party-Classic", {title = '经典旧世5人本', parent = "DBM_Mods_Old", protected = 1, });
U1RegisterAddon("DBM-Party-BC", {title = "燃烧的远征5人本", parent = "DBM_Mods_Old", protected = 1, });
