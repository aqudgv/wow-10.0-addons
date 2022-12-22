U1RegisterAddon("Auctionator", {
    title = "拍卖行",
    defaultEnable = 0,

    tags = { "TAG_TRADING", },
    desc = "增强拍卖行界面，自动缓存拍卖行价格",
    icon = [[Interface\Icons\INV_Enchant_FormulaGood_01]],

    runBeforeLoad = function(info, name)
        CoreDependCall("blizzard_auctionhouseui", function()
            C_Timer.After(0.5, function()
                if AuctionHouseFrame ~= nil and AuctionatorConfigFrame ~= nil and AuctionatorConfigFrame.ScanButton ~= nil then
                    AuctionatorConfigFrame.ScanButton:SetParent(AuctionHouseFrame);
                    AuctionatorConfigFrame.ScanButton:ClearAllPoints();
                    -- 835.70 - 862.10 = -26.4
                    if AuctionHouseFrameCloseButton ~= nil then
                        AuctionatorConfigFrame.ScanButton:SetPoint("RIGHT", AuctionHouseFrameCloseButton, "LEFT", -8, 0);
                    else
                        AuctionatorConfigFrame.ScanButton:SetPoint("TOPRIGHT", AuctionHouseFrame, -34.4, 0);
                    end
                end
            end);
        end);
    end,
    {
        var = "autoscan",
        default = false,
        text = "打开拍卖行时自动开始扫描",
        tip = "说明：`打开拍卖场时执行自动扫描。`停用此选项时，可以按下拍卖场的 '完整扫描' 按钮来执行完整扫描。",
        getvalue = function() if AUCTIONATOR_CONFIG ~= nil then return AUCTIONATOR_CONFIG.autoscan end end,
        callback = function(cfg, v, loading)
            if AUCTIONATOR_CONFIG ~= nil and (AUCTIONATOR_CONFIG.__20201203_0 == nil or not loading) then
                AUCTIONATOR_CONFIG.__20201203_0 = true;
                if v then
                    AUCTIONATOR_CONFIG.autoscan = true;
                else
                    AUCTIONATOR_CONFIG.autoscan = false;
                end
            end
        end,
    },

});
