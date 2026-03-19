-- player-location-sync/config.lua
Config = {}

Config.WebSocketUrl = GetConvar('plsync_ws_url', 'ws://localhost:30121')
Config.BlipsEndpoint = GetConvar('plsync_blips_endpoint', '/blips')

Config.UpdateInterval = 1000
Config.SendVehicleData = true
Config.SendWeaponData = true
Config.SendLocationName = true

Config.Debug = GetConvar('plsync_debug', 'false') == 'true'

Config.MapCenter = vector2(0, 0)
Config.MapSize = 4096

Config.IconColors = {
    ['police'] = '#3b82f6',
    ['ems'] = '#ef4444',
    ['tow'] = '#f59e0b',
    ['helicopter'] = '#8b5cf6',
    ['civilian'] = '#6b7280'
}

Config.IconTypes = {
    police = 56,
    ems = 162,
    tow = 68,
    helicopter = 64,
    pedestrian = 6,
    vehicle = 225,
    default = 225
}
