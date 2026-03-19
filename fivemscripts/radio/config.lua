-- Tommy's Radio System Configuration
-- Documentation can be found at: https://tommys-scripts.gitbook.io/fivem/paid-scripts/tommys-radio/setup-and-configuration
-- Config Version 3.0 - Use a website like https://www.diffchecker.com/ to compare configuration file changes

Config = {
    -- Available radio layouts
    radioLayouts = {
        "AFX-1500",
        "AFX-1500G",
        "ARX-4000X",
        "XPR-6500",
        "XPR-6500S",
        "ATX-8000",
        "ATX-8000G",
        "ATX-NOVA",
        "TXDF-9100",
    },

    -- Default layouts by vehicle type
    defaultLayouts = {
        ["Handheld"] = "ATX-8000",
        ["Vehicle"] = "AFX-1500",
        ["Boat"] = "AFX-1500G",
        ["Air"] = "TXDF-9100",

    -- Example default layouts by spawn code

        ["fbi2"] = "XPR-6500",
        ["police"] = "XPR-6500",
    },

    -- Control keys
    controls = {
        talkRadioKey = "B",
        toggleRadioKey = "F6",
        channelUpKey = "",
        channelDownKey = "",
        zoneUpKey = "",
        zoneDownKey = "",
        menuUpKey = "",
        menuDownKey = "",
        menuRightKey = "",
        menuLeftKey = "",
        menuHomeKey = "",
        menuBtn1Key = "",
        menuBtn2Key = "",
        menuBtn3Key = "",
        emergencyBtnKey = "",
        closeRadioKey = "",
        powerBtnKey = "",
        styleUpKey= "",
        styleDownKey= "",
        voiceVolumeUpKey = "",
        voiceVolumeDownKey = "",
        sfxVolumeUpKey = "",
        sfxVolumeDownKey = "",
        volume3DUpKey = "",
        volume3DDownKey = "",
    },

    -- Network settings
    connectionAddr = "26.38.48.27",    -- Final connection string for clients, Including protocol (https://proxy.example.com) and/or port. (If empty, uses host ip address and port)
    serverPort = 7777,      -- Port for radio server & dispatch panel, choose a port that is not used by other resources.
    authToken = "changeme", -- Secure token for radio authentication, change this to a secure random string.
    dispatchNacId = "141",  -- NAC ID / Password for dispatch channel, change this to your desired ID.

    -- General settings
    doUpdateCheck = true,  -- Enable automatic update checking on resource start
    logLevel = 3,          -- (0 = Error, 1 = Warnings, 2 = Minimal, 3 = Normal, 4 = Debug, 5 = Verbose)
    pttReleaseDelay = 350, -- Delay in milliseconds before releasing PTT to prevent cut-off (250-500ms recommended)
    panicTimeout = 60000,

    -- Callsign system (SERVER ONLY)
    callsign = {
        enabled = true,              -- Master switch for callsign system
        command = "callsign",        -- Player command to set their own callsign
        clearCommand = "clearcallsign", -- Player command to clear their own callsign
        adminCommand = "setcallsign", -- Admin command to set callsign for another player
        allowSelf = true,            -- Allow players to set their own callsign
        allowAdmin = true,           -- Allow admins to set callsigns for others
        permission = "",              -- ACE permission for self callsign (leave blank to allow all)
        adminPermission = "",         -- ACE permission for admin callsign (leave blank to allow all)
        persist = true,              -- Persist callsigns using resource KVPs
        minLength = 2,
        maxLength = 16,
        pattern = "^[%w%-]+$",       -- Allowed characters (letters, numbers, dash)
        allowSpaces = false,
    },

    -- Audio settings
    voiceVolume = 60,                 -- Default voice volume (0-100), can be changed in radio settings menu
    sfxVolume = 20,                   -- Default sfx volume (0-100), can be changed in radio settings menu
    playTransmissionEffects = true,   -- Play background sound effects (sirens, helis, gunshots)
    analogTransmissionEffects = true, -- Play analog transmission sound effects (static during transmission)

    -- 3D Audio settings (EXPERIMENTAL)
    default3DAudio = true, -- true = earbuds OFF by default (3D audio enabled), false = earbuds ON by default (3D audio disabled)
    default3DVolume = 50,  -- Default 3D audio volume (0-100), saved per user like voice/sfx volume, default is 50

    -- Signal tower locations used for signal strength (x, y, z). Add/remove as needed.
    signalTowers = {
        { x = 1860.0, y = 3677.0, z = 33.0 },
        { x = 449.0, y = -992.0, z = 30.0 },
        { x = -979.0, y = -2632.0, z = 23.0 },
        { x = -2364.0, y = 3229.0, z = 45.0 },
        { x = -449.0, y = 6025.0, z = 35.0 },
        { x = 1529.0, y = 820.0, z = 79.0 },
        { x = -573.0, y = -146.0, z = 38.0 },
        { x = -3123.0, y = 1334.0, z = 25.0 },
        { x = 4445.0, y = -4465.0, z = 4.0 }, -- Cayo Perico signal tower (adjust to your preferred location)
    },

    -- Battery system configuration
    -- This function is called every second to update the battery level
    -- @param currentBattery: number - current battery level (0-100)
    -- @param deltaTime: number - time since last update in seconds
    -- @return: number - new battery level (0-100)
    batteryTick = function(currentBattery, deltaTime)
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)

        if vehicle ~= 0 then
            -- Charge battery when in vehicle
            local chargeRate = 0.5 -- 0.5% per second
            return math.min(100.0, currentBattery + (chargeRate * deltaTime))
        else
            -- Discharge battery when on foot
            local dischargeRate = 0.1 -- 0.5% per second
            return math.max(0.0, currentBattery - (dischargeRate * deltaTime))
        end
    end,

    -- Multiple Animation Configurations
    -- Users can select which animation to use through radio settings (you can remove or add more options)
    animations = {
        [1] = {
            name = "None",
            onKeyState = function(isKeyDown)
                -- Empty function for no animations
            end,
            onRadioOpen = function()
                -- Empty function for no animations
            end
        },
        [2] = {
            name = "Shoulder",
            onKeyState = function(isKeyDown)
                local playerPed = PlayerPedId()
                if not playerPed or playerPed == 0 then return end

                -- Initialize animation state tracker if it doesn't exist
                if not _radioAnimState then
                    _radioAnimState = {
                        isPlaying = false,
                        pendingStart = false,
                        dictLoaded = false
                    }
                end

                if isKeyDown then
                    -- Mark that we want to start animation
                    _radioAnimState.pendingStart = true

                    -- Animation when starting to talk (key down)
                    RequestAnimDict('random@arrests')

                    -- Non-blocking check for animation dictionary
                    Citizen.CreateThread(function()
                        local attempts = 0
                        while not HasAnimDictLoaded("random@arrests") and attempts < 50 do
                            Citizen.Wait(10)
                            attempts = attempts + 1
                        end

                        -- Only start animation if we still want to start it (user hasn't released PTT)
                        if _radioAnimState.pendingStart and HasAnimDictLoaded("random@arrests") then
                            _radioAnimState.dictLoaded = true
                            if not IsEntityPlayingAnim(playerPed, "random@arrests", "generic_radio_enter", 3) then
                                TaskPlayAnim(playerPed, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, false,
                                    false, false)
                                _radioAnimState.isPlaying = true
                            end
                        end
                    end)
                else
                    -- Animation when stopping talk (key up)
                    _radioAnimState.pendingStart = false

                    -- Stop animation immediately regardless of loading state
                    if _radioAnimState.isPlaying or IsEntityPlayingAnim(playerPed, "random@arrests", "generic_radio_enter", 3) then
                        StopAnimTask(playerPed, "random@arrests", "generic_radio_enter", -4.0)
                        _radioAnimState.isPlaying = false
                    end
                end
            end,
            onRadioOpen = function()
                local playerPed = PlayerPedId()
                if not playerPed or playerPed == 0 then return end

                -- Initialize animation state tracker if it doesn't exist
                if not _radioAnimState then
                    _radioAnimState = {
                        isPlaying = false,
                        pendingStart = false,
                        dictLoaded = false
                    }
                end

                -- Load animation dictionary for radio use
                RequestAnimDict('random@arrests')
            end
        },
        [3] = {
            name = "Handheld",
            onKeyState = function(isKeyDown)
                local playerPed = PlayerPedId()
                if not playerPed or playerPed == 0 then return end

                if not _radioAnimState then
                    _radioAnimState = {
                        isPlaying = false,
                        pendingStart = false,
                        dictLoaded = false,
                        radioProp = nil
                    }
                end



                if isKeyDown then
                    _radioAnimState.pendingStart = true
                    RequestAnimDict('cellphone@')

                    Citizen.CreateThread(function()
                        local attempts = 0
                        while not HasAnimDictLoaded("cellphone@") and attempts < 50 do
                            Citizen.Wait(10)
                            attempts = attempts + 1
                        end

                        if _radioAnimState.pendingStart and HasAnimDictLoaded("cellphone@") then
                            _radioAnimState.dictLoaded = true
                            if not IsEntityPlayingAnim(playerPed, "cellphone@", "cellphone_call_to_text", 3) then
                                TaskPlayAnim(playerPed, "cellphone@", "cellphone_call_to_text", 8.0, 2.0, -1, 50, 2.0, false, false, false)

                                -- Create and attach radio prop
                                _radioAnimState.radioProp = CreateObject(GetHashKey("prop_cs_hand_radio"), 0, 0, 0, true, true, true)
                                AttachEntityToEntity(_radioAnimState.radioProp, playerPed, GetPedBoneIndex(playerPed, 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, true, true, false, true, 1, true)
                                SetEntityAsMissionEntity(_radioAnimState.radioProp, true, true)

                                _radioAnimState.isPlaying = true
                            end
                        end
                    end)
                else
                    _radioAnimState.pendingStart = false
                    if _radioAnimState.isPlaying or IsEntityPlayingAnim(playerPed, "cellphone@", "cellphone_call_to_text", 3) then
                        StopAnimTask(playerPed, "cellphone@", "cellphone_call_to_text", -4.0)

                        -- Delete radio prop
                        if _radioAnimState.radioProp then
                            DeleteObject(_radioAnimState.radioProp)
                            _radioAnimState.radioProp = nil
                        end

                        _radioAnimState.isPlaying = false
                    end
                end
            end,
            onRadioOpen = function()
                local playerPed = PlayerPedId()
                if not playerPed or playerPed == 0 then return end

                if not _radioAnimState then
                    _radioAnimState = {
                        isPlaying = false,
                        pendingStart = false,
                        dictLoaded = false,
                        radioProp = nil
                    }
                end

                RequestAnimDict('cellphone@')
            end
        },
        [4] = {
            name = "Earpiece",
            onKeyState = function(isKeyDown)
                local playerPed = PlayerPedId()
                if not playerPed or playerPed == 0 then return end

                -- Initialize animation state tracker if it doesn't exist
                if not _radioAnimState then
                    _radioAnimState = {
                        isPlaying = false,
                        pendingStart = false,
                        dictLoaded = false
                    }
                end

                if isKeyDown then
                    -- Mark that we want to start animation
                    _radioAnimState.pendingStart = true

                    -- Animation when starting to talk (key down)
                    RequestAnimDict('cellphone@')

                    -- Non-blocking check for animation dictionary
                    Citizen.CreateThread(function()
                        local attempts = 0
                        while not HasAnimDictLoaded("cellphone@") and attempts < 50 do
                            Citizen.Wait(10)
                            attempts = attempts + 1
                        end

                        -- Only start animation if we still want to start it (user hasn't released PTT)
                        if _radioAnimState.pendingStart and HasAnimDictLoaded("cellphone@") then
                            _radioAnimState.dictLoaded = true
                            if not IsEntityPlayingAnim(playerPed, "cellphone@", "cellphone_call_listen_base", 3) then
                                TaskPlayAnim(playerPed, "cellphone@", "cellphone_call_listen_base", 8.0, 2.0, -1, 50, 2.0, false,
                                    false, false)
                                _radioAnimState.isPlaying = true
                            end
                        end
                    end)
                else
                    -- Animation when stopping talk (key up)
                    _radioAnimState.pendingStart = false

                    -- Stop animation immediately regardless of loading state
                    if _radioAnimState.isPlaying or IsEntityPlayingAnim(playerPed, "cellphone@", "cellphone_call_listen_base", 3) then
                        StopAnimTask(playerPed, "cellphone@", "cellphone_call_listen_base", -4.0)
                        _radioAnimState.isPlaying = false
                    end
                end
            end,
            onRadioOpen = function()
                local playerPed = PlayerPedId()
                if not playerPed or playerPed == 0 then return end

                -- Initialize animation state tracker if it doesn't exist
                if not _radioAnimState then
                    _radioAnimState = {
                        isPlaying = false,
                        pendingStart = false,
                        dictLoaded = false
                    }
                end

                -- Load animation dictionary for radio use
                RequestAnimDict('cellphone@')
            end
        }
    },



    -- Interference settings
    bonkingEnabled = true,
    bonkInterval = 750,
    interferenceTimeout = 5000,
    blockAudioDuringInterference = true,

    -- Permission check for radio access (SERVER ONLY)
    radioAccessCheck = function(playerId)
        if not playerId or playerId <= 0 then
            Logger.error("Invalid playerId in radioAccessCheck: " .. tostring(playerId))
            return false
        end

        -- QB-Core example (uncomment and modify as needed):
        -- local success, player = pcall(function()
        --     return exports['qb-core']:GetPlayer(playerId)
        -- end)
        --
        -- if success and player and player.PlayerData and player.PlayerData.job then
        --     local jobName = player.PlayerData.job.name
        --     return jobName == "police" or jobName == "ambulance" or jobName == "firefighter" or jobName == "ems"
        -- end
        --
        -- return false

        return true -- Default: allow everyone
    end,

    -- Get user NAC ID (SERVER ONLY)
    getUserNacId = function(serverId)
        if not serverId or serverId <= 0 then
            return nil
        end

        -- QB-Core example (uncomment and modify as needed):
        -- local success, player = pcall(function()
        --     return exports['qb-core']:GetPlayer(serverId)
        -- end)
        --
        -- if success and player and player.PlayerData and player.PlayerData.job then
        --     local jobName = player.PlayerData.job.name
        --     if jobName == "police" then
        --         return "141"
        --     elseif jobName == "ambulance" or jobName == "ems" then
        --         return "200"
        --     elseif jobName == "firefighter" then
        --         return "300"
        --     end
        -- end
        --
        -- return "0"

        return "141"
    end,

    -- Get player display name (SERVER ONLY)
    getPlayerName = function(serverId)
        if not serverId then return "DISPATCH" end
        if serverId <= 0 then return "DISPATCH" end

        -- QB-Core example (uncomment and modify as needed):
        -- local success, player = pcall(function()
        --     return exports['qb-core']:GetPlayer(serverId)
        -- end)
        --
        -- if success and player and player.PlayerData then
        --     -- Check for callsign in metadata
        --     if player.PlayerData.metadata and player.PlayerData.metadata.callsign and player.PlayerData.metadata.callsign ~= "NO CALLSIGN" and player.PlayerData.metadata.callsign ~= "" then
        --         return player.PlayerData.metadata.callsign
        --     end
        --
        --     -- Check for lastname in charinfo
        --     if player.PlayerData.charinfo and player.PlayerData.charinfo.lastname and player.PlayerData.charinfo.lastname ~= "" then
        --         return player.PlayerData.charinfo.lastname
        --     end
        -- end

        -- Fallback to FiveM player name
        local name = GetPlayerName(serverId)
        if not name or name == "" then
            return "Player " .. serverId
        end

        -- Extract callsign from name format "Name S. 2L-319"
        local callsign = string.match(name, "%s([%w%-]+%d+)$")
        if callsign then
            return callsign
        end

        return name
    end,

    -- Check if player has siren on and is going fast (CLIENT ONLY)
    bgSirenCheck = function()
        local playerPed = PlayerPedId()
        if not playerPed or playerPed == 0 then return false end

        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if not vehicle or vehicle == 0 then return false end

        -- Prefer LVC integration if available
        if GetResourceState and GetResourceState("lvc") == "started" then
            local ok, result = pcall(function()
                return exports["lvc"].sirenCheck()
            end)
            if ok and result ~= nil then
                return result
            end
        end

        if not IsVehicleSirenOn(vehicle) then return false end

        -- Check speed (convert m/s to mph) - lowered from 50 to 10 mph for better detection
        local speed = GetEntitySpeed(vehicle) * 2.237
        if speed <= 10 then return false end

        return IsVehicleSirenOn(vehicle)
    end,

    -- Alerts configuration, the first alert is the default alert for the SGN button in-game
    alerts = {
        [1] = {
          name = "SIGNAL 100", -- Alert Name
          color = "#d19d00", -- Hex color code for alert
          isPersistent = true, -- If true, the alert stays active until cleared
          tone = "ALERT_A", -- Corrosponds to a tone defined in client/radios/default/tones.json
        },
        [2] = {
          name = "SIGNAL 3",
          color = "#0049d1", -- Hex color code for alert
          isPersistent = true, -- If true, the alert stays active until cleared
          tone = "ALERT_A", -- Corrosponds to a tone defined in client/radios/default/tones.json
        },
        [3] = {
          name = "Ping",
          color = "#0049d1", -- Hex color code for alert
          tone = "ALERT_B", -- Corrosponds to a tone defined in client/radios/default/tones.json
        },
        [4] = {
          name = "Boop",
          color = "#1c4ba3", -- Hex color code for alert
          toneOnly = true, -- If true, only plays tone without showing alert on radio
          tone = "BONK", -- Corrosponds to a tone defined in client/radios/default/tones.json
        },
    },

    -- Radio zones and channels
    zones = {
        [1] = {
            name = "Statewide",
            nacIds = { "141", "110" },
            Channels = {
                [1] = {
                    name = "DISP",                                -- Channel Name
                    type = "conventional",                        -- Channel Type ("conventional" or "trunked")
                    frequency = 154.755,                          -- Frequency in MHz
                    allowedNacs = { "141" },                      -- Allowed NAC IDs for this channel (can connect and scan)
                    scanAllowedNacs = { "110", "200" },           -- NAC IDs that can only scan this channel (cannot connect)
                    gps = { color = 54, visibleToNacs = { 141 } } -- GPS settings for this channel, for blip colors reference (https://docs.fivem.net/docs/game-references/blips/#blip-colors)
                },
                [2] = {
                    name = "C2C",                                 -- Channel Name
                    type = "trunked",                             -- Channel Type ("conventional" or "trunked")
                    frequency = 856.1125,                         -- Frequency in MHz
                    frequencyRange = { 856.000, 859.000 },        -- Frequency range for trunked channels
                    coverage = 500,                               -- Coverage in meters
                    allowedNacs = { "141" },                      -- Allowed NAC IDs for this channel (can connect and scan)
                    scanAllowedNacs = { "110", "200" },           -- NAC IDs that can only scan this channel (cannot connect)
                    gps = { color = 25, visibleToNacs = { 141 } } -- GPS settings for this channel
                },
                [3] = {
                    name = "10-1",
                    type = "conventional",
                    frequency = 154.785,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { color = 47, visibleToNacs = { 141 } }
                },
                [4] = {
                    name = "OPS-1",
                    type = "conventional",
                    frequency = 154.815,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { color = 40, visibleToNacs = { 141 } }
                },
            },
        },
        [2] = {
            name = "Los Santos",
            nacIds = { "141" },
            Channels = {
                [1] = {
                    name = "DISP",
                    type = "conventional",
                    frequency = 460.250,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { visibleToNacs = { 141 } }
                },
                [2] = {
                    name = "C2C",
                    type = "trunked",
                    frequency = 460.325,
                    frequencyRange = { 460.325, 462.325 },
                    coverage = 250,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { color = 25, visibleToNacs = { 141 } }
                },
                [3] = {
                    name = "10-1",
                    type = "conventional",
                    frequency = 460.275,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { color = 47, visibleToNacs = { 141 } }
                },
                [4] = {
                    name = "OPS-1",
                    type = "conventional",
                    frequency = 462.450,
                    allowedNacs = { "50" },
                    scanAllowedNacs = { "141" },
                    gps = { color = 40, visibleToNacs = { 141 } }
                },
            },
        },
        [3] = {
            name = "Blaine County",
            nacIds = { "141" },
            Channels = {
                [1] = {
                    name = "DISP",
                    type = "conventional",
                    frequency = 155.070,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = {
                        color = 52,
                        visibleToNacs = { 141 }
                    }
                },
                [2] = {
                    name = "C2C",
                    type = "trunked",
                    frequency = 155.220,
                    frequencyRange = { 155.220, 157.220 },
                    coverage = 250,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { color = 25, visibleToNacs = { 141 } }
                },
                [3] = {
                    name = "10-1",
                    type = "conventional",
                    frequency = 155.100,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { color = 47, visibleToNacs = { 141 } }
                },
                [4] = {
                    name = "OPS-1",
                    type = "conventional",
                    frequency = 157.350,
                    allowedNacs = { "141" },
                    scanAllowedNacs = { "110", "200" },
                    gps = { color = 40, visibleToNacs = { 141 } }
                },
            },
        }
    }
}
