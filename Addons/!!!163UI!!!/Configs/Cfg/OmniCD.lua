
U1RegisterAddon("OmniCD", {
    title = "团队技能监控",
    defaultEnable = 0,
    load = "LOGIN",

    tags = { "TAG_SPELL", },
    icon = [[Interface\Icons\INV_Qiraj_JewelGlyphed]],
    desc = "监控团队技能、装备冷却。",
    nopic = 1,

    {
        text="配置选项",
        callback = function(cfg, v, loading)
            SlashCmdList.OmniCD("omnicd")
        end,
    },
});
