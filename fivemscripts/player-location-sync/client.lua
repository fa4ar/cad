-- cad-map-sync/client.lua
local UPDATE_INTERVAL = 1000
local lastPos = nil
local lastVehicle = nil

local function getJob()
    local playerPed = PlayerPedId()
    local job = "civilian"
    
    if IsPedInAnyVehicle(playerPed, false) then
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        local driver = GetPedInVehicleSeat(vehicle, -1)
        
        if driver == playerPed then
            job = "driver"
        end
    end
    
    return job
end

local function getLocationName()
    local pos = GetEntityCoords(PlayerPedId())
    local street = GetStreetNameFromHashKey(GetStreetNameAtCoord(pos.x, pos.y, pos.z))
    local zone = GetLabelText(GetNameOfZone(pos.x, pos.y, pos.z))
    
    if street and street ~= "" then
        if zone and zone ~= "" and zone ~= "NULL" then
            return street .. ", " .. zone
        end
        return street
    end
    return nil
end

CreateThread(function()
    while true
    do
        Wait(UPDATE_INTERVAL)
        
        local ped = PlayerPedId()
        local pos = GetEntityCoords(ped)
        local rot = GetEntityRotation(ped)
        
        local data = {
            pos = {x = pos.x, y = pos.y, z = pos.z},
            rot = {x = rot.x, y = rot.y, z = rot.z}
        }
        
        local vehicle = GetVehiclePedIsIn(ped, false)
        if vehicle and vehicle ~= 0 then
            local plate = GetVehicleNumberPlateText(vehicle)
            local model = GetEntityModel(vehicle)
            local vehicleName = GetDisplayNameFromVehicleModel(model)
            
            data.vehicle = vehicleName
            data.licensePlate = plate
            data.hasSirenEnabled = IsVehicleSirenOn(vehicle)
            
            local driver = GetPedInVehicleSeat(vehicle, -1)
            if driver == ped then
                local job = getJob()
                data.job = job
            end
        else
            data.job = "pedestrian"
        end
        
        local weapon = GetSelectedPedWeapon(ped)
        if weapon and weapon ~= 0 then
            local weaponHash = string.format("%x", weapon)
            data.weapon = weaponHash
        end
        
        local location = getLocationName()
        if location then
            data.location = location
        end
        
        if data.job == "driver" and vehicle and vehicle ~= 0 then
            local driver = GetPedInVehicleSeat(vehicle, -1)
            if driver == ped then
                blip = {
                    x = pos.x,
                    y = pos.y,
                    color = 3,
                    name = "Police Vehicle",
                    sprite = 225
                }
            end
        elseif data.job == "pedestrian" then
            blip = {
                x = pos.x,
                y = pos.y,
                color = 0,
                name = "Civilian",
                sprite = 1
            }
        end
        
        data.blip = blip
        
        TriggerServerEvent("cad-sync:update", data)
        
        lastPos = pos
    end
end)

CreateThread(function()
    while true
    do
        Wait(5000)
        
        local ped = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(ped, false)
        
        if vehicle ~= lastVehicle then
            lastVehicle = vehicle
            
            local blipData = nil
            
            if vehicle and vehicle ~= 0 then
                local driver = GetPedInVehicleSeat(vehicle, -1)
                if driver == ped then
                    blipData = {
                        x = GetEntityCoords(ped).x,
                        y = GetEntityCoords(ped).y,
                        color = 3,
                        name = "Police Vehicle",
                        sprite = 225
                    }
                end
            end
            
            TriggerServerEvent("cad-sync:updateBlip", blipData)
        end
    end
end)

print("[cad-map-sync] Client loaded")
