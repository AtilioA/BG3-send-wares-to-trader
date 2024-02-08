WareDelivery = {}

-- Keep track of original inventory for each delivered ware
WareDelivery.delivered_wares = {}

function WareDelivery.RegisterDeliveredWare(item, partyMember, character)
  local itemObject = item.TemplateName .. "_" .. item.Guid
  WareDelivery.delivered_wares[itemObject] = { ["from"] = partyMember, ["to"] = character, sold = false }
end

-- Iterate WareDelivery.delivered_wares and send back the items that were not sold to 'from' character
function WareDelivery.ReturnUnsoldWares(trader)
  for itemObject, ware in pairs(WareDelivery.delivered_wares) do
    if ware and ware.sold == false and ware.to == trader then -- and ware.from ~= ware.to then
      local from = ware.from
      if Osi.IsInPartyWith(trader, from) == 1 then
        local exactamount, totalamount = Osi.GetStackAmount(itemObject)
        Utils.DebugPrint(1, "Returning unsold ware to " .. from .. " from " .. trader)
        -- Utils.DumpObjectEntity(itemObject, "Returned ware")
        Osi.ToInventory(itemObject, from, totalamount, 0, 1)
        Ware.MarkAsWare(itemObject)
      else
        Utils.DebugPrint(1,
          "Not returning ware to " ..
          from .. " because they are not a follower. Sending it back would unmark the item as ware.")
      end
      WareDelivery.delivered_wares[itemObject] = nil
    end
  end
  WareDelivery.delivered_wares = {}
end

function WareDelivery.DeliverWare(item, partyMember, character)
  if partyMember == character then
    return
  end

  local showNotification = 0
  if JsonConfig.FEATURES.show_notification == true then
    showNotification = 1
  end

  Utils.DebugPrint(2, "Found ware in " .. partyMember .. "'s inventory: " .. item.Name)

  local itemObject = item.TemplateName .. "_" .. item.Guid
  local exactamount, totalamount = Osi.GetStackAmount(itemObject)
  Osi.ToInventory(itemObject, character, totalamount, showNotification, 0)
end

function WareDelivery.SendPartyWaresToCharacter(character)
  local partyMembers = Utils.GetAllCampMembers()

  for _, partyMember in ipairs(partyMembers) do
    local partyMemberEntity = Ext.Entity.Get(partyMember)
    -- This check is insane and might not be necessary
    if partyMemberEntity and partyMemberEntity.ServerCharacter and partyMemberEntity.ServerCharacter.Template and partyMemberEntity.ServerCharacter.Template.Name and partyMemberEntity.Uuid and partyMemberEntity.Uuid.EntityUuid then
      local partyMemberUUID = partyMemberEntity.ServerCharacter.Template.Name .. "_" .. partyMemberEntity.Uuid
          .EntityUuid
      Utils.DebugPrint(2,
        "Checking " .. partyMemberUUID .. " for wares to send to " .. character .. tostring(partyMemberUUID == character))
      if partyMemberUUID ~= character then
        local ware = GetWaresInInventory(GetInventory(partyMember, true, false))
        if ware ~= nil then
          for _, item in ipairs(ware) do
            Utils.DebugPrint(2, "Found ware in " .. partyMemberUUID .. "'s inventory: ")
            WareDelivery.RegisterDeliveredWare(item, partyMemberUUID, character)
            WareDelivery.DeliverWare(item, partyMemberUUID, character)
            -- Utils.DumpObjectEntity(item.TemplateName .. '_' .. item.Guid, "Sent ware")
          end
        end
      end
    end
  end
end

return WareDelivery
