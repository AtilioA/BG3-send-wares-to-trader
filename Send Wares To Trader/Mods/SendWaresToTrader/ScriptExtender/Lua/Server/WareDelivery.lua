WareDelivery = {}

-- Keep track of original inventory for each delivered ware
WareDelivery.delivered_wares = {}

function WareDelivery.RegisterDeliveredWare(item, partyMember, character)
  local itemObject = item.TemplateName .. item.Guid
  WareDelivery.delivered_wares[itemObject] = { ["from"] = partyMember, ["to"] = character, sold = false }
end

-- Iterate WareDelivery.delivered_wares and send back the items that were not sold to 'from' character
function WareDelivery.ReturnUnsoldWares(trader)
  for itemObject, ware in pairs(WareDelivery.delivered_wares) do
    if ware.sold == false and ware.to == trader then
      local from = ware.from
      local exactamount, totalamount = Osi.GetStackAmount(itemObject)
      Utils.DebugPrint(2, "Returning unsold ware to " .. from .. " from " .. trader)
      Osi.ToInventory(itemObject, from, totalamount, 1, 1)
      WareDelivery.delivered_wares[itemObject] = nil
    end
  end
end

function WareDelivery.DeliverWare(item, partyMember, character)
  Utils.DebugPrint(2, "Found ware in " .. partyMember .. "'s inventory: ")
  _D(item)
  Utils.DebugPrint(2, "Delivering ware to " .. character .. " from " .. partyMember)

  local itemObject = item.TemplateName .. item.Guid
  local exactamount, totalamount = Osi.GetStackAmount(itemObject)
  Osi.ToInventory(itemObject, character, totalamount, 1, 1)
end

function WareDelivery.SendPartyWaresToCharacter(character)
  local partyMembers = Utils.GetPartyMembers()

  for _, partyMember in ipairs(partyMembers) do
    if partyMember ~= character then
      local ware = GetWaresInInventory(GetInventory(partyMember, true, false))
      if ware ~= nil then
        for _, item in ipairs(ware) do
          WareDelivery.DeliverWare(item, partyMember, character)
          WareDelivery.RegisterDeliveredWare(item, partyMember, character)
        end
      end
    end
  end
end

return WareDelivery
