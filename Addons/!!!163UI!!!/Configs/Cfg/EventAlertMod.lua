local OnClick = function(self, button)
    if not(EA_Options_Frame:IsVisible()) then			
        EA_Options_Frame:Show()
    else						
        EA_Options_Frame:Hide()
    end
end
local OnTooltipShow = function(tt)
    local t="EventAlertMod (EAM)"
    -- t = t..EA_XCMD_CMDHELP["TITLE"].."\n"
    -- t = t..EA_XCMD_CMDHELP["OPT"].."\n"
    -- t = t..EA_XCMD_CMDHELP["HELP"].."\n"

    -- for k,v in pairs(EA_XCMD_CMDHELP) do
    --     if v[1] then t = t..v[1].."\n"..v[2].."\n" end									
    -- end
    
    -- t = t.."/eam SCDRemoveWhenCooldown".."\n"
    -- t = t.."/eam SCDNocombatStillKeep".."\n"
    -- t = t.."/eam SCDGlowWhenUsable".."\n"
    -- t = t.."/eam ShowEAconfig".."\n"
    -- t = t.."/eam ShowEAposition".."\n"
    -- t = t.."/eam MiniMap".."\n"
    -- t = t.."/eam UpdateInterval (0.1~1s)".."\n"
    -- t = t.."/eam IconAppendSpellTip".."\n"
    -- t = t.."/eam NewLineByIconCount (2~n)".."\n"
    -- t = t.."P.S.All command letter is Case-Insensitive"
    tt:SetText(t)
    tt:Show();
end

U1RegisterAddon("EventAlertMod", {
    title = "技能特效报警",
    defaultEnable = 0,
    --optionsAfterVar = 1,
    load = "NORMAL", --5.0 script ran too long
    --secure = 1,
    minimap = "LibDBIcon10_EventAlertMod",
    --frames = {""}, --需要保存位置的框体

    tags = { "TAG_SPELL", },
    icon = [[Interface\Icons\Spell_Nature_Polymorph_Cow]],
    desc = "图标式的技能特效报警，当要监控的技能满足条件时，在人物上方或下方显示对应的法术图标及时间。可以监控技能冷却、增益和负面效果，也可以提醒需要释放的技能，例如死骑职业可以提示‘当身上没有战斗怒吼和寒冬号角，而且寒冬号角技能可用时，显示提示图标’。``设置界面稍微有点复杂，快捷指令是/eam opt。`其他指令说明：/eam help",
    pics = 2,

    --toggle = function(name, info, enable, justload) end, --如果未开插件，则初始不会调用。
    toggle = function(name, info, enable, justload)
        if not enable then
            return;
        end
        --  DEF
            if EA_MinimapOption ~= nil then
                EA_MinimapOption:Hide();
                EA_MinimapOption:EnableMouse(false);
                EA_MinimapOption:SetAlpha(0.0);
                EA_MinimapOption.Show = function() end;
            else
                local _CreateFrames_CreateMinimapOptionFrame = CreateFrames_CreateMinimapOptionFrame;
                CreateFrames_CreateMinimapOptionFrame = function()
                    local EA_MinimapOption = CreateFrames_CreateMinimapOptionFrame();
                    EA_MinimapOption:Hide();
                    EA_MinimapOption:EnableMouse(false);
                    EA_MinimapOption:SetAlpha(0.0);
                    EA_MinimapOption.Show = function() end;
                    return EA_MinimapOption;
                end
            end
        --	DBICON
            local LDI = LibStub("LibDBIcon-1.0", true);
            if LDI then
                LDI:Register("EventAlertMod",
                    {
                        icon = "Interface/Icons/Trade_Engineering",
                        OnClick = OnClick,
                        OnTooltipShow = OnTooltipShow,
                    },
                    {
                        minimapPos = EA_Config and EA_Config.DBI_POS or 360,
                    }
                );
            end
            local mb = LDI:GetMinimapButton("EventAlertMod");
            mb:RegisterEvent("PLAYER_LOGOUT");
            mb:HookScript("OnEvent", function(self)
                EA_Config.DBI_POS = self.minimapPos or self.db.minimapPos;
            end);
            mb:HookScript("OnDragStop", function(self)
                EA_Config.DBI_POS = self.minimapPos or self.db.minimapPos;
            end);
        --	LDB
            local LDB = LibStub:GetLibrary("LibDataBroker-1.1");
            if LDB then
                local obj = LDB:NewDataObject("alaTalentEmu", {
                    type = "launcher",
                    icon = "Interface/Icons/Trade_Engineering",
                    OnClick = OnClick,
                    OnTooltipShow = OnTooltipShow,
                });
            end
    end,

    {
        type = 'button',
        text = '开启设置界面',
        tip = "快捷命令`/eam opt",
        callback = function()
            return (SlashCmdList['EVENTALERTMOD'])'opt'
        end,
    },
    --[[{
        text = '是否显示死骑符文',
        visible = select(2, UnitClass("player")) == "DEATHKNIGHT",
        var = "DK_ShowRunes",
        default = false,
        callback = function(cfg, v, loading)
            EA_Config2.DK_ShowRunes = v
            if not v and not loading then
                for i=1, 6 do
                    CreateFrames_SpecialFrames_Hide(EA_SpecPower.Runes.frameindex[i])
                end
            end
        end
    },

    {
        text = '是否显示猎人宠物集中值',
        visible = select(2, UnitClass("player")) == "HUNTER",
        var = "HUNTER_ShowPetFocus",
        default = false,
        callback = function(cfg, v, loading)
            EA_Config2.HUNTER_ShowPetFocus = v
            if not v and not loading then
                if _G["EAFrameSpec_1000021"] then _G["EAFrameSpec_1000021"]:Hide() end
            end
        end
    },--]]

    {
        text = '图标堆叠文字大小',
        var = "stackFontHeight",
        default = 11,
        type = "spin",
        range = {9, 28, 1},
        callback = function(cfg, v, loading)
            EventAlert_AdjustFontSizeWithIconSize()
        end
    },

    {
        text = '技能冷却后保留图标',
        tip = '说明``选中此项，则本职业-技能CD中的技能，触发冷却以后，当冷却完成仍然会留在屏幕上，而且是动画闪烁提示。',
        var = "SCD_RemoveWhenCooldown",
        default = false,
        getvalue = function() return not EA_Config.SCD_RemoveWhenCooldown end,
        callback = function(cfg, v, loading)
            EA_Config.SCD_RemoveWhenCooldown = not v
        end
    },

    {
        text = "显示手工添加的法术ID",
        tip = "说明`欢迎将自己添加的法术ID提交给开发团队",
        callback = function()
        --EADef_Items[EA_CLASS_OTHER]
            local prefix, any, _, cls ={"Scd","Tar","","OTHER"},false, UnitClass("player")
            for _, p in next, prefix do
                local key = p:upper().."ITEMS"
                local def = EADef_Items[cls][key]
                if p == "OTHER" then p = "" cls = "OTHER" def = EADef_Items[EA_CLASS_OTHER] end
                local my = _G["EA_".. p .."Items"]
                for id, set in next,my and my[cls] or {} do
                    local sname = GetSpellInfo(id)
                    if sname and set.enable and not def[id] then
                        any = true
                        print(key, cls, id, sname)
                    end
                end
            end
            if not any then print("没有手工添加的法术") end
        end
    },

    {
        text = "重置所有设置为默认",
        confirm = "|cffff0000设置将无法恢复！|r\n包括框体位置、自定义法术ID等！\n一般仅在大版本更新后用！\n确认重置并自动重载界面？",
        callback = function()
            EA_Position,EA_Items,EA_AltItems,EA_TarItems,EA_ScdItems,EA_GrpItems,EA_Pos,EA_Deleted = nil
            -- local EA_SPELL_ITEM = EA_Config.EA_SPELL_ITEM
            -- EA_Config = { EA_SPELL_ITEM = EA_SPELL_ITEM, }
            EA_Config = nil
            ReloadUI()
        end
    },
});
