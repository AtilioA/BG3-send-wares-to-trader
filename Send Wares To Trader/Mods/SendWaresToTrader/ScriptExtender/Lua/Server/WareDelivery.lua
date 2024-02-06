WareDelivery = {}


-- function WareDelivery.SendInventoryWareToChest(character)
--   local campChestSack = GetCampChestSupplySack()
--   -- Not sure if nil is falsey in Lua, so we'll just be explicit
--   local shallow = not JsonConfig.FEATURES.send_existing_ware.nested_containers or false

--   local ware = GetWareInInventory(character, shallow)
--   if ware ~= nil then
--     for _, item in ipairs(ware) do
--       Utils.DebugPrint(2, "Found ware in " .. character .. "'s inventory: " .. item)
--       if not WareDelivery.IsWareItemRetainlisted(item) then
--         WareDelivery.DeliverWare(item, character, campChestSack)
--       end
--     end
--   end
-- end

-- --- Send ware to camp chest or supply sack.
-- ---@param object any The item to deliver.
-- ---@param from any The inventory to deliver from.
-- ---@param campChestSack any The supply sack to deliver to.
-- function WareDelivery.DeliverWare(object, from, campChestSack)
--   local shouldMove = false

--   if IsWare(object) then
--     if WareDelivery.IsWareItemRetainlisted(object) then
--       return
--     end

--     if shouldMove then
--       local exactamount, totalamount = Osi.GetStackAmount(object)
--       Utils.DebugPrint(2, "Should move " .. object .. " to camp chest.")
--       local targetInventory = Utils.GetChestUUID()

--       if campChestSack ~= nil then
--         targetInventory = campChestSack.Guid
--       else
--         -- Try to get the supply sack anyways if it has not been provided
--         local getCampChestSack = GetCampChestSupplySack()
--         if getCampChestSack ~= nil then
--           targetInventory = getCampChestSack.Guid
--         else
--           Utils.DebugPrint(1, "Camp chest supply sack not found.")
--           targetInventory = Utils.GetChestUUID()
--         end
--       end

--       if targetInventory then
--         Osi.ToInventory(object, targetInventory, totalamount, 1, 1)
--       else
--         Utils.DebugPrint(1, "Target inventory not found, not moving " .. object .. " to camp chest.")
--       end
--     else
--       Utils.DebugPrint(2, object .. " is not ware, won't move to camp chest.")
--     end
--   end
-- end

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
        end
      end
    end
  end
end

return WareDelivery
