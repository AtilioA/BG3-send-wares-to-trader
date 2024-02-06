Ware = {}

function IsWare(object)
  local objectEntity = Ext.Entity.Get(object)
  if objectEntity ~= nil then
    return objectEntity.ServerItem and objectEntity.ServerItem.DontAddToHotbar == true
  end

  return false
end

return Ware
