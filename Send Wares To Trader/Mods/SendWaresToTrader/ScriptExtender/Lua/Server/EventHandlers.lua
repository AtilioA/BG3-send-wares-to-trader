Ext.Require("Server/Helpers/Food.lua")

EHandlers = {}

function EHandlers.OnMovedFromTo(movedObject, fromObject, toObject, isTrade)
  Utils.DebugPrint(2, "OnMovedFromTo called: " .. movedObject .. " from " .. fromObject .. " to " .. toObject .. " isTrade " .. isTrade)

  -- if Osi.IsInInventoryOf(fromObject, chestName) == 1 or Osi.IsInInventoryOf(movedObject, chestName) == 1 then
  --   Utils.DebugPrint(2, "Item is from the camp chest or a container within it. Not trying to send to chest.")
  --   return
  -- end

  -- Don't try to move items that are being moved from the party
  -- if (Osi.IsInPartyWith(fromObject, Osi.GetHostCharacter()) and isTrade ~= 1) then
  --   Utils.DebugPrint(2, "fromObject is in party with host. Not trying to send to chest.")

  --   local fromObjectHolder = GetObject(GetHolder(fromObject))
  --   if (fromObjectHolder ~= nil) then
  --     Utils.DebugPrint(2, "fromObjectHolder is in party with host. Not trying to send to chest.")
  --     return
  --   end

  --   local movedObjectHolder = GetObject(GetHolder(movedObject))
  --   if (movedObjectHolder ~= nil) then
  --     Utils.DebugPrint(2, "movedObjectHolder is in party with host. Not trying to send to chest.")
  --     return
  --   end

  --   return
  end

return EHandlers
