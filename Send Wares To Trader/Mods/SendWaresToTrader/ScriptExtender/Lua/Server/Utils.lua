Utils = {}

function Utils.DebugPrint(level, ...)
  if JsonConfig and JsonConfig.DEBUG and JsonConfig.DEBUG.level >= level then
    if (JsonConfig.DEBUG.level == 0) then
      print("[Send Wares To Trader]: " .. ...)
    else
      print("[Send Wares To Trader][DEBUG LEVEL " .. level .. "]: " .. ...)
    end
  end
end

-- Get the last 36 characters of the UUID (template ID I guess)
function Utils.GetGUID(uuid)
  return string.sub(uuid, -36)
end

--- func desc
---@param templateuuid string
---@return string
function Utils.GetUID(templateuuid)
  if #templateuuid <= 36 then
    return templateuuid   -- Return the original string if it's too short
  end

  local result = string.sub(templateuuid, 1, -37) -- Remove last 36 characters

  -- Remove trailing underscore if present
  result = result:gsub("_$", "")

  return result
end

function Utils.GetPartyMembers()
  local teamMembers = {}

  local allPlayers = Osi.DB_Players:Get(nil)
  for _, player in ipairs(allPlayers) do
    if not string.match(player[1]:lower(), "%f[%A]dummy%f[%A]") then
      teamMembers[#teamMembers + 1] = Utils.GetGUID(player[1])
    end
  end

  return teamMembers
end

function Utils.GetPlayerEntity()
  return Ext.Entity.Get(Osi.GetHostCharacter())
end

return Utils
