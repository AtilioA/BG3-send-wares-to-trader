local function SubscribeToEvents()
  if JsonConfig.GENERAL.enabled == true then
    Utils.DebugPrint(2, "Subscribing to events with JSON config: " .. Ext.Json.Stringify(JsonConfig, { Beautify = true }))

    -- Moving/looting
    Ext.Osiris.RegisterListener("MovedFromTo", 4, "before", EHandlers.OnMovedFromTo)

    -- Trading
    Ext.Osiris.RegisterListener("TradeEnds", 2, "before", EHandlers.OnTradeEnds)
    Ext.Osiris.RegisterListener("RequestTrade", 4, "after", EHandlers.RequestTrade)
  end
end

return {
  SubscribeToEvents = SubscribeToEvents
}
