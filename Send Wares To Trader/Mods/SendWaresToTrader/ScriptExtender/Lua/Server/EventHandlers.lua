EHandlers = {}

function EHandlers.OnMovedFromTo(movedObject, fromObject, toObject, isTrade)
  Utils.DebugPrint(0,
    "OnMovedFromTo called: " .. movedObject .. " from " .. fromObject .. " to " .. toObject .. " isTrade " .. isTrade)

  -- Don't try to move items that are being moved from the party
  if (Osi.IsInPartyWith(fromObject, Osi.GetHostCharacter()) and isTrade == 1) then
    Utils.DebugPrint(0, "Item is from the party and was sold, updating WareDelivery.delivered_wares")
    WareDelivery.delivered_wares[movedObject].sold = true
  end
end

function EHandlers.OnTradeEnds(trader, character)
  Utils.DebugPrint(0, "OnTradeEnds called: " .. trader .. " and " .. character)
  if Osi.IsInPartyWith(trader, Osi.GetHostCharacter()) == 1 then
    if JsonConfig.FEATURES.send_back_if_not_sold then
      WareDelivery.ReturnUnsoldWares(trader)
    end
  end
end

function EHandlers.RequestTrade(trader, character, itemsTagFilter, tradeMode)
  if Osi.IsInPartyWith(trader, Osi.GetHostCharacter()) == 1 then
    Utils.DebugPrint(0,
      "RequestTrade called: " ..
      trader .. " and " .. character .. " with itemsTagFilter " .. itemsTagFilter .. " and tradeMode " .. tradeMode)

    -- Send ware from party members to trader
    WareDelivery.SendPartyWaresToCharacter(trader)
  end
end

return EHandlers
