
U1RegisterAddon("ProtoformSynthesisFieldJournal", {
    title = "原生体合成查看器",
    defaultEnable = 1,

    minimap = 'LibDBIcon10_ProtoformSynthesis',
    tags = { "TAG_MANAGEMENT", },
    icon = [[Interface\Icons\inv_progenitor_protoformsynthesis]],
    desc = "允许玩家在远离锻炉时查看可以合成的宠物坐骑列表。",
    nopic = 1,

    load = "NORMAL",

    runBeforeLoad = function(info, name)
        U1DBG.__plugins = U1DBG.__plugins or {  };
        U1DBG.__plugins.ProtoformSynthesis = U1DBG.__plugins.ProtoformSynthesis or { Minimap = { minimapPos = 0, }, };
        if LibStub then
            local icon = LibStub("LibDBIcon-1.0", true);
            if icon then
                icon:Register(
                    "ProtoformSynthesisFieldJournal",
                    {
                        icon = [[Interface\Icons\inv_progenitor_protoformsynthesis]],
                        OnClick = function(self, button)
                                if not IsAddOnLoaded("ProtoformSynthesisFieldJournal") then
                                    LoadAddOn("ProtoformSynthesisFieldJournal");
                                    ProtoformSynthesisFieldJournal:PLAYER_LOGIN();
                                end
                                if ProtoformSynthesisFieldJournal ~= nil then
                                    ProtoformSynthesisFieldJournal:Toggle();
                                    ProtoformSynthesisFieldJournal.TitleText:SetText("原生体合成");
                                end
                        end,
                        text = nil,
                        OnTooltipShow = function(tt)
                            tt:AddLine("原生体合成查看器");
                            tt:AddLine("ProtoformSynthesisFieldJournal", 0.5, 0.5, 0.5);
                        end
                    },
                    U1DBG.__plugins.ProtoformSynthesis.Minimap
                );
            end
        end
    end,


});

U1RegisterAddon("ProtoformSynthesis", { parent = "ProtoformSynthesisFieldJournal", title = "旧版本占位符", protected = nil, hide = nil });
