fx_version 'cerulean'
game 'gta5'

name 'cad-map-sync'
author 'CAD Team'
version '1.0.0'
description 'Синхронизация местоположения игроков с CAD через WebSocket'

server_scripts {
    'server.lua'
}

client_scripts {
    'client.lua'
}

dependencies {
    'xotch_lib'
}
