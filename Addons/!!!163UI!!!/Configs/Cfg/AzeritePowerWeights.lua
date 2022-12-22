U1RegisterAddon("AzeritePowerWeights", {
    title = "装备特质评分",
    defaultEnable = 1,
    load = "LATER",
    tags = { "TAG_ITEM", },
    icon = 1869493,
    {
        text = "选项配置",
        callback = function(cfg, v, loading)
            local func = CoreIOF_OTC or InterfaceOptionsFrame_OpenToCategory
            func("AzeritePowerWeights")
        end
    },
})