EHandlers = {}

EHandlers.trader = nil

function EHandlers.OnMovedFromTo(movedObject, fromObject, toObject, isTrade)
  Utils.DebugPrint(2,
    "OnMovedFromTo called: " .. movedObject .. " from " .. fromObject .. " to " .. toObject .. " isTrade " .. isTrade)
  -- Don't try to move items that are being moved to the party while trading (forget it, this is dumb)
  -- if (EHandlers.trader ~= nil and Osi.IsInPartyWith(fromObject, toObject) and isTrade == 0) then
  --   Utils.DebugPrint(0, "Item is being moved to the party while trading, ignoring")
  --   if WareDelivery.delivered_wares[movedObject] then
  --     WareDelivery.delivered_wares[movedObject].sold = true
  --     return
  --   else
  --     Utils.DebugPrint(0, "Item is not in delivered_wares")
  --   end
  -- end

  -- Don't try to move items that are being moved from the party
  if (Osi.IsInPartyWith(fromObject, Osi.GetHostCharacter()) and isTrade == 1) then
    if (WareDelivery.delivered_wares[movedObject]) then
      Utils.DebugPrint(2, "Item is from the party and was sold, updating WareDelivery.delivered_wares")
      -- If it's not present, it means it was from the trader's inventory already
      WareDelivery.delivered_wares[movedObject].sold = true
    end
  end
end

function EHandlers.OnTradeEnds(trader, character)
  Utils.DebugPrint(2, "OnTradeEnds called: " .. trader .. " and " .. character)
  if Osi.IsInPartyWith(trader, Osi.GetHostCharacter()) == 1 then
    EHandlers.trader = nil
    if JsonConfig.FEATURES.send_back_if_not_sold then
      WareDelivery.ReturnUnsoldWares(trader)
      -- Redundant, but just in case
      WareDelivery.ResetDeliveredWare()
    end
  end
end

function EHandlers.RequestTrade(trader, character, itemsTagFilter, tradeMode)
  if Osi.IsInPartyWith(trader, Osi.GetHostCharacter()) == 1 then
    EHandlers.trader = trader
    Utils.DebugPrint(2,
      "RequestTrade called: " ..
      trader .. " and " .. character .. " with itemsTagFilter " .. itemsTagFilter .. " and tradeMode " .. tradeMode)

    -- Send ware from party members to trader
    WareDelivery.SendPartyWaresToCharacter(trader)
  end
end

return EHandlers
