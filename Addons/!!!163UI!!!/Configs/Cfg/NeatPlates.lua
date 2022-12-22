U1RegisterAddon("NeatPlates", {
    title = "美化姓名版",
    defaultEnable = 0,
    load = "NORMAL",
    optionsAfterLogin = 1,
    minimap = "LibDBIcon10_NeatPlatesIcon",

    tags = { "TAG_UNITFRAME", },
    -- icon = [[Interface\AddOns\NeatPlates\media\NeatPlatesIcon]],
    desc = "強大到爆的多功能姓名版美化插件。``设置口令：/NeatPlates",
    nopic = 1,
    conflicts = { "TidyPlates_ThreatPlates" },

    runBeforeLoad = function(info, name)
        local strsplit = strsplit;
        local UnitGUID = UnitGUID;
        local GetNamePlateForUnit = C_NamePlate.GetNamePlateForUnit;
        local _frame = CreateFrame('FRAME');
        _frame:RegisterEvent("NAME_PLATE_UNIT_ADDED");
        _frame:SetScript("OnEvent", function(_, event, unit)
            local _GUID = UnitGUID(unit);
            if _GUID ~= nil then
                local _type, _, _, _, _, _id = strsplit("-", _GUID);
                if _id == "157226" then
                    local _plate = GetNamePlateForUnit(unit);
                    _plate.showBlizzardPlate = true;
                    ShouldShowBlizzardPlate(_plate);
                end
            end
        end);
    end,

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
            -- SetCVar("nameplateShowSelf", 0)
        end
        return true
    end,

    --[[{
        text = "小地图按钮",
        type = "checkbox",
        var = "minimap",
        default = true,
        callback = function(cfg, v, loading)
            NeatPlatesOptions._EnableMiniButton = v
            if v then
                if not LibDBIcon10_NeatPlatesIcon then
                    NeatPlatesUtility:CreateMinimapButton()
                end
                NeatPlatesUtility:ShowMinimapButton()
            else
                if LibDBIcon10_NeatPlatesIcon then LibDBIcon10_NeatPlatesIcon:Hide() end
            end
        end
    },]]--
    {
        text = "配置选项",
        callback = function(cfg, v, loading) slash_NeatPlates() end
    },
    {
        text = "重置所有控制台设定",
        callback = function(cfg, v, loading)
            NeatPlatesOptions = nil;
            NeatPlatesHubCache = nil;
            NeatPlatesHubGlobal = nil;
            NeatPlatesHubSettings = nil;
            NeatPlatesWidgetData = nil; 
            ReloadUI();
        end,
    },
    --[[
    {
        text = "支持在姓名板上显示个人资源",
        tip = "说明`开启此选项并在'界面-名字'中开启'在敌方目标上显示玩家的特殊资源'后，可以在NeatPlates的姓名板上显示。`注意，此功能和敌方DEBUFF同时显示时会有问题。",
        var = "resourceBar",
        default = false,
        callback = function(cfg, v, loading)
            if loading then
                CoreDependCall("Blizzard_NamePlates", function()
                    if NamePlateTargetResourceFrame then
                        hooksecurefunc(NamePlateTargetResourceFrame, "SetParent", function(self, parent)
                            if not self._settingByUs and U1GetCfgValue(cfg._path) then
                                self._settingByUs = 1
                                self:SetParent(parent:GetParent())
                                self._settingByUs = nil
                            end
                        end)
                    end
                end)
            end
        end
    }
    --]]

});

U1RegisterAddon("NeatPlatesWidgets", { protected = 1, load = "NORMAL" })
U1RegisterAddon("NeatPlatesHub", { protected = 1, load = "NORMAL" })
