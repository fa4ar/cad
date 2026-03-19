-- Resource Information
-- Ensure the fx_version is set to 'bodacious' for compatibility with FiveM
fx_version 'bodacious'
game 'gta5'

name 'Tommy\'s Radio'
description 'FiveM In-Game Radio Script'
author 'Tommy Johnston'
version 'v3.0'

-- Lua Version
lua54 'yes'
node_version '22'

-- UI Configuration
ui_page 'client/index.html'

-- Files
files {
    'server/dist/bundle.js',
    'client/dist/bundle.js',
    'client/radios/**/*.*',
    'client/index.html',
    'server/dispatch.html',
}

-- Scripts
shared_scripts {
    'config.lua',
    'audio.lua',
    'shared.lua',
    'blips.lua',
}

client_scripts {
    'client/callsign_client.lua',
}

server_scripts {
    'server/dist/bundle.js',
    'server/callsign.lua',
    'server/dispatch.lua',
}

-- Escrow Configuration
escrow_ignore {
    'config.lua',
    'client/radios/**/*.*'
}

dependency '/assetpacks'
