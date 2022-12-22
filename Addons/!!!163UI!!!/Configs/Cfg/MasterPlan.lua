U1RegisterAddon("MasterPlanA", {
    title = "要塞任务管家",
    defaultEnable = 0,
    loadWith = "Blizzard_GarrisonUI",
    nolodbutton = 1,

    tags = { "TAG_QUEST", },
    icon = [[Interface\Icons\Garrison_GreenWeaponUpgrade]],
    desc = "帮助你选择最优配置来进行要塞追随者任务。",
    nopic = 1,
});

U1RegisterAddon("MasterPlan", {
    title = "要塞任务大师",
    parent = "MasterPlanA",
    defaultEnable = 0,
    --loadWith = "Blizzard_GarrisonUI",
    nolodbutton = 1,
    -- conflicts = { "KayrCovenantMissions" },

    tags = { "TAG_QUEST", },
    icon = [[Interface\Icons\UI_Promotion_Garrisons]],
    desc = "修改并简化追随者任务面板的操作。",
    nopic = true,
});
