U1RegisterAddon("TidyPlates_ThreatPlates", {
    title = "Threat Plates 姓名板",
    defaultEnable = 0,
    load = "NORMAL",
    tags = { "TAG_UNITFRAME", },
    -- icon = [[Interface\AddOns\NeatPlates\media\NeatPlatesIcon]],
    nopic = 1,
    conflicts = { "NeatPlates" },
    desc = "Threat Plates 姓名版",
    {
        type = 'button',
        text = '配置选项',
        callback = function()
            TidyPlatesThreat:ChatCommand("")
        end,
    },
    
    toggle = function(name, info, enable, justload)
        if justload and IsLoggedIn() then
            local index = 1;
            while true do
                local frame = getglobal("NamePlate" .. index);
                if frame == nil then
                    break;
                end
                index = index + 1;
                Export163_OnNewNameplate(frame)
            end
        end
        return true
    end,
    {
        text = "加载姓名板",
        callback = function(cfg, v, loading)
            -- TidyPlatesThreat:OnInitialize();
            ReloadUI();
        end,
    },
});
