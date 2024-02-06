Ware = {}

function Ware.IsWare(objectEntity)
  if objectEntity ~= nil then
    return objectEntity.ServerItem and objectEntity.ServerItem.DontAddToHotbar == true
  end

  return false
end

return Ware
