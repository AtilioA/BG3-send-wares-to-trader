Ware = {}

function Ware.IsWare(objectEntity)
  if objectEntity ~= nil then
    return objectEntity.ServerItem and objectEntity.ServerItem.DontAddToHotbar == true
  end

  return false
end

function Ware.MarkAsWare(item)
  if type(item) == "string" then
    Utils.DebugPrint(3, "Marking " .. item .. " as ware")
    local itemEntity = Ext.Entity.Get(item)
    if itemEntity and itemEntity.ServerItem then
      itemEntity.ServerItem.DontAddToHotbar = true
    end
  elseif type(item) == "userdata" then
    Utils.DebugPrint(3, "Marking item entity as ware")
    if item.ServerItem then
      item.ServerItem.DontAddToHotbar = true
    end
  end
end

return Ware
