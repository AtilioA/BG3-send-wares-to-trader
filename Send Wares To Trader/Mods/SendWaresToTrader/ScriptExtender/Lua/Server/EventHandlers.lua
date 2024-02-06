EHandlers = {}

function EHandlers.OnMovedFromTo(movedObject, fromObject, toObject, isTrade)
  Utils.DebugPrint(0,
    "OnMovedFromTo called: " .. movedObject .. " from " .. fromObject .. " to " .. toObject .. " isTrade " .. isTrade)

  -- if Osi.IsInInventoryOf(fromObject, chestName) == 1 or Osi.IsInInventoryOf(movedObject, chestName) == 1 then
  --   Utils.DebugPrint(0, "Item is from the camp chest or a container within it. Not trying to send to chest.")
  --   return
  -- end

  -- Don't try to move items that are being moved from the party
  -- if (Osi.IsInPartyWith(fromObject, Osi.GetHostCharacter()) and isTrade ~= 1) then
  --   Utils.DebugPrint(0, "fromObject is in party with host. Not trying to send to chest.")

  --   local fromObjectHolder = GetObject(GetHolder(fromObject))
  --   if (fromObjectHolder ~= nil) then
  --     Utils.DebugPrint(0, "fromObjectHolder is in party with host. Not trying to send to chest.")
  --     return
  --   end

  --   local movedObjectHolder = GetObject(GetHolder(movedObject))
  --   if (movedObjectHolder ~= nil) then
  --     Utils.DebugPrint(0, "movedObjectHolder is in party with host. Not trying to send to chest.")
  --     return
  --   end

  --   return
end

function EHandlers.OnTradeEnds(trader, character)
  Utils.DebugPrint(0, "OnTradeEnds called: " .. trader .. " and " .. character)
  -- if Osi.IsInPartyWith(trader, Osi.GetHostCharacter()) == 1 then
  --   if JsonConfig.FEATURES.send_back_if_not_sold then
  --     WareDelivery.SendBackUnsoldWares(trader)
  --   end
  -- end
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
