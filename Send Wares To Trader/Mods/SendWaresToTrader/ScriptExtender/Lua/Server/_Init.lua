Ext.Require("Server/Utils.lua")
Ext.Require("Server/Helpers/Inventory.lua")
Ext.Require("Server/Config.lua")
Ext.Require("Server/WaresDelivery.lua")
Ext.Require("Server/EventHandlers.lua")

MOD_UUID = "0639ab64-2ddf-48e3-bed6-06cfbeea2bec"
local MODVERSION = Ext.Mod.GetMod(MOD_UUID).Info.ModVersion

if MODVERSION == nil then
    Utils.DebugPrint(0, "loaded (version unknown)")
else
    -- Remove the last element (build/revision number) from the MODVERSION table
    table.remove(MODVERSION)

    local versionNumber = table.concat(MODVERSION, ".")
    Utils.DebugPrint(0, "version " .. versionNumber .. " loaded")
end

local EventSubscription = Ext.Require("Server/SubscribedEvents.lua")
EventSubscription.SubscribeToEvents()
