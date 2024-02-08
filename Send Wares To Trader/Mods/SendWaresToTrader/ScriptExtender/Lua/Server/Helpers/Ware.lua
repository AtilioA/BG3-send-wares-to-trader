Ware = {}

function Ware.IsWare(objectEntity)
  if objectEntity ~= nil then
    return objectEntity.ServerItem and objectEntity.ServerItem.DontAddToHotbar == true
  end

  return false
end

function Ware.MarkAsWare(item)
  if type(item) == "string" then
    Ext.Entity.Get(item).ServerItem.DontAddToHotbar = true
  elseif type(item) == "userdata" then
    item.ServerItem.DontAddToHotbar = true
  end
end

return Ware
