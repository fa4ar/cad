-- cad-map-sync/server.lua
local Players = {}
local lastPlayerUpdate = {}

local function getPlayersData()
    local data = {}
    for src, player in pairs(Players) do
        table.insert(data, player)
    end
    return data
end

local function getBlipsData()
    local blips = {}
    for _, player in pairs(Players) do
        if player.blip and player.blip.x then
            table.insert(blips, player.blip)
        end
    end
    return blips
end

SetHttpHandler(function(req, res)
    local path = req.path
    
    if path == "/health" then
        res.send("OK")
        return
    end
    
    if path == "/blips" then
        res.set("Content-Type", "application/json")
        res.send(json.encode(getBlipsData()))
        return
    end
    
    if path == "/players" then
        res.set("Content-Type", "application/json")
        res.send(json.encode(getPlayersData()))
        return
    end
    
    if path == "/" or path == "/index.html" then
        res.set("Content-Type", "text/html")
        res.send([[
<!DOCTYPE html>
<html>
<head>
    <title>CAD Map Sync</title>
</head>
<body>
    <h1>CAD Map Sync Server</h1>
    <p>Online Players: ]] .. json.encode(getPlayersData()) .. [[</p>
    <p>Endpoints:</p>
    <ul>
        <li>/health - Health check</li>
        <li>/blips - Get all blips</li>
        <li>/players - Get all players</li>
    </ul>
</body>
</html>]])
        return
    end
    
    res.status(404)
end)

RegisterServerEvent("cad-sync:update")
AddEventHandler("cad-sync:update", function(data)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0) or tostring(src)
    
    Players[src] = {
        identifier = identifier,
        name = GetPlayerName(src),
        source = src,
        pos = data.pos or {x=0, y=0, z=0},
        rot = data.rot or {x=0, y=0, z=0},
        vehicle = data.vehicle,
        licensePlate = data.licensePlate,
        hasSirenEnabled = data.hasSirenEnabled,
        weapon = data.weapon,
        location = data.location,
        job = data.job,
        blip = data.blip,
        lastUpdate = os.time()
    }
end)

RegisterServerEvent("cad-sync:updateBlip")
AddEventHandler("cad-sync:updateBlip", function(blipData)
    local src = source
    
    if Players[src] then
        Players[src].blip = blipData
    end
end)

RegisterServerEvent("cad-sync:getPlayers")
AddEventHandler("cad-sync:getPlayers", function()
    TriggerClientEvent("cad-sync:playersData", source, getPlayersData())
end)

AddEventHandler("playerDropped", function(reason)
    local src = source
    Players[src] = nil
end)

AddEventHandler("playerConnecting", function(playerName, setKickReason, deferrals)
    local src = source
    local identifier = GetPlayerIdentifier(src, 0) or tostring(src)
    
    Players[src] = {
        identifier = identifier,
        name = playerName,
        source = src,
        pos = {x=0, y=0, z=0},
        lastUpdate = os.time()
    }
    
    deferrals.defer()
    Wait(100)
    deferrals.done()
end)

SetInterval(function()
    local now = os.time()
    local toRemove = {}
    
    for src, player in pairs(Players) do
        if player.lastUpdate and (now - player.lastUpdate) > 30 then
            table.insert(toRemove, src)
        end
    end
    
    for _, src in ipairs(toRemove) do
        Players[src] = nil
    end
end, 10000)

print("[cad-map-sync] Server started on port 30121")
print("[cad-map-sync] Endpoints: /health, /blips, /players")
