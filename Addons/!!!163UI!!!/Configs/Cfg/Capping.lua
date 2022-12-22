U1RegisterAddon("Capping", {
    title = "战场计时器",
    defaultEnable = 0,
    load = "LOGIN",

    tags = { "TAG_PVP", },
    icon = [[Interface\Icons\Spell_Misc_HellifrePVPCombatMorale]],
    desc = "战场计时器，还有一些其他PvP指示。",
    nopic = 1,

    {
        text = "显示设置界面",
        tip = "说明`快捷命令 /capping",
        callback = function(cfg, v, loading)
            SlashCmdList["Capping"]("")
        end,
    },
--[[
    {
        text = "重置所有控制台设定",
        confirm = "是否确定？",
        callback = function(cfg, v, loading)
            CappingSettings.db.profile = nil
            ReloadUI()
        end,
    },]]--

});
