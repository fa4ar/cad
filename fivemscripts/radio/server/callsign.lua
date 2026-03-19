local DEFAULT_CALLSIGN_CONFIG = {
    enabled = true,
    command = "callsign",
    clearCommand = "clearcallsign",
    adminCommand = "setcallsign",
    allowSelf = true,
    allowAdmin = true,
    permission = "",
    adminPermission = "",
    persist = true,
    minLength = 2,
    maxLength = 16,
    pattern = "^[%w%-]+$",
    allowSpaces = false,
}

local function mergeConfig(defaults, overrides)
    local merged = {}
    for key, value in pairs(defaults) do
        merged[key] = value
    end
    if type(overrides) == "table" then
        for key, value in pairs(overrides) do
            merged[key] = value
        end
    end
    return merged
end

local CALLSIGN_CONFIG = mergeConfig(DEFAULT_CALLSIGN_CONFIG, Config and Config.callsign)
local CALLSIGN_KVP_PREFIX = "radio_callsign:"

local callsignsByIdentifier = {}
local callsignsByServerId = {}
local baseGetPlayerName = nil

local function logCallsign(message, level)
    if type(log) == "function" then
        log(message, level or 3, "Callsign")
    else
        print("[Callsign] " .. message)
    end
end

local function getPrimaryIdentifier(source)
    if not source or source <= 0 then
        return nil
    end

    local identifiers = GetPlayerIdentifiers(source)
    if not identifiers or #identifiers == 0 then
        return nil
    end

    for _, identifier in ipairs(identifiers) do
        if string.sub(identifier, 1, 8) == "license:" then
            return identifier
        end
    end

    return identifiers[1]
end

local function loadCallsign(identifier)
    if callsignsByIdentifier[identifier] ~= nil then
        return callsignsByIdentifier[identifier] or nil
    end

    local stored = nil
    if CALLSIGN_CONFIG.persist and GetResourceKvpString then
        stored = GetResourceKvpString(CALLSIGN_KVP_PREFIX .. identifier)
    end

    if stored and stored ~= "" then
        callsignsByIdentifier[identifier] = stored
        return stored
    end

    callsignsByIdentifier[identifier] = false
    return nil
end

local function getCallsignForSource(source)
    if not source or source <= 0 then
        return nil
    end

    local identifier = getPrimaryIdentifier(source)
    if not identifier then
        return nil
    end

    local callsign = loadCallsign(identifier)
    if callsign then
        callsignsByServerId[source] = callsign
    end

    return callsign
end

local function saveCallsign(identifier, callsign)
    callsignsByIdentifier[identifier] = callsign or false

    if not CALLSIGN_CONFIG.persist or not identifier then
        return
    end

    local key = CALLSIGN_KVP_PREFIX .. identifier
    if callsign and callsign ~= "" then
        SetResourceKvp(key, callsign)
    else
        if DeleteResourceKvp then
            DeleteResourceKvp(key)
        else
            SetResourceKvp(key, "")
        end
    end
end

local function sanitizeCallsign(input)
    if not input then
        return nil
    end

    local trimmed = input:gsub("^%s+", ""):gsub("%s+$", "")
    if trimmed == "" then
        return nil
    end

    if not CALLSIGN_CONFIG.allowSpaces and trimmed:find("%s") then
        return nil, "Callsign cannot contain spaces"
    end

    if #trimmed < CALLSIGN_CONFIG.minLength or #trimmed > CALLSIGN_CONFIG.maxLength then
        return nil, "Callsign must be between " .. CALLSIGN_CONFIG.minLength .. " and " .. CALLSIGN_CONFIG.maxLength .. " characters"
    end

    if CALLSIGN_CONFIG.pattern and not trimmed:match(CALLSIGN_CONFIG.pattern) then
        return nil, "Callsign contains invalid characters"
    end

    return trimmed
end

local function updatePlayerName(serverId, displayName)
    TriggerClientEvent("radio:receivePlayerName", -1, serverId, displayName)
    TriggerEvent("radio:updatePlayerName", serverId, displayName)
end

local function setCallsignForSource(serverId, callsign)
    if not serverId or serverId <= 0 then
        return false, "Invalid player id"
    end

    local identifier = getPrimaryIdentifier(serverId)
    if not identifier then
        return false, "Player identifier not found"
    end

    local cleaned = nil
    if callsign and callsign ~= "" then
        local sanitized, err = sanitizeCallsign(callsign)
        if not sanitized then
            return false, err or "Invalid callsign"
        end
        cleaned = sanitized
    end

    saveCallsign(identifier, cleaned)
    callsignsByServerId[serverId] = cleaned

    local displayName = nil
    if cleaned then
        displayName = cleaned
    elseif type(baseGetPlayerName) == "function" then
        displayName = baseGetPlayerName(serverId)
    elseif type(GetPlayerName) == "function" then
        displayName = GetPlayerName(serverId)
    else
        displayName = "Player " .. tostring(serverId)
    end

    updatePlayerName(serverId, displayName)
    return true, displayName
end

local function sendChatMessage(target, message, color)
    if target == 0 then
        return
    end

    TriggerClientEvent("chat:addMessage", target, {
        color = color or { 100, 200, 255 },
        multiline = true,
        args = { "Radio", message },
    })
end

baseGetPlayerName = Config and Config.getPlayerName
if type(baseGetPlayerName) == "function" then
    Config.getPlayerName = function(serverId)
        if CALLSIGN_CONFIG.enabled and serverId and serverId > 0 then
            local callsign = getCallsignForSource(serverId)
            if callsign and callsign ~= "" then
                return callsign
            end
        end
        return baseGetPlayerName(serverId)
    end
end

RegisterNetEvent("radio:setCallsign")
AddEventHandler("radio:setCallsign", function(callsign)
    local sourceId = source
    if not CALLSIGN_CONFIG.enabled then
        sendChatMessage(sourceId, "Callsign system is disabled", { 255, 100, 100 })
        return
    end

    if not CALLSIGN_CONFIG.allowSelf then
        sendChatMessage(sourceId, "Self callsign updates are disabled", { 255, 100, 100 })
        return
    end

    if CALLSIGN_CONFIG.allowSelf and CALLSIGN_CONFIG.permission and CALLSIGN_CONFIG.permission ~= "" then
        if not IsPlayerAceAllowed(sourceId, CALLSIGN_CONFIG.permission) then
            sendChatMessage(sourceId, "You do not have permission to set a callsign", { 255, 100, 100 })
            return
        end
    end

    local ok, result = setCallsignForSource(sourceId, callsign)
    if ok then
        local msg = "Callsign updated to " .. result
        if not callsign or callsign == "" then
            msg = "Callsign cleared"
        end
        sendChatMessage(sourceId, msg, { 100, 255, 100 })
        logCallsign("Player " .. sourceId .. " callsign updated to " .. tostring(result), 3)
    else
        sendChatMessage(sourceId, result or "Failed to update callsign", { 255, 100, 100 })
    end
end)

if CALLSIGN_CONFIG.command and CALLSIGN_CONFIG.command ~= "" then
    RegisterCommand(CALLSIGN_CONFIG.command, function(source, args)
        if source == 0 then
            print("Console must use /" .. CALLSIGN_CONFIG.adminCommand .. " <id> <callsign>")
            return
        end

        if not CALLSIGN_CONFIG.enabled then
            sendChatMessage(source, "Callsign system is disabled", { 255, 100, 100 })
            return
        end

        if not CALLSIGN_CONFIG.allowSelf then
            sendChatMessage(source, "Self callsign updates are disabled", { 255, 100, 100 })
            return
        end

        if CALLSIGN_CONFIG.permission and CALLSIGN_CONFIG.permission ~= "" then
            if not IsPlayerAceAllowed(source, CALLSIGN_CONFIG.permission) then
                sendChatMessage(source, "You do not have permission to set a callsign", { 255, 100, 100 })
                return
            end
        end

        local input = table.concat(args, " ")
        if input == "" then
            local current = getCallsignForSource(source)
            if current then
                sendChatMessage(source, "Current callsign: " .. current)
            else
                sendChatMessage(source, "No callsign set")
            end
            sendChatMessage(source, "Usage: /" .. CALLSIGN_CONFIG.command .. " <callsign>")
            return
        end

        if input:lower() == "clear" then
            setCallsignForSource(source, nil)
            sendChatMessage(source, "Callsign cleared", { 100, 255, 100 })
            return
        end

        local ok, result = setCallsignForSource(source, input)
        if ok then
            sendChatMessage(source, "Callsign updated to " .. result, { 100, 255, 100 })
        else
            sendChatMessage(source, result or "Failed to update callsign", { 255, 100, 100 })
        end
    end, false)
end

if CALLSIGN_CONFIG.clearCommand and CALLSIGN_CONFIG.clearCommand ~= "" then
    RegisterCommand(CALLSIGN_CONFIG.clearCommand, function(source)
        if source == 0 then
            return
        end

        if not CALLSIGN_CONFIG.enabled then
            sendChatMessage(source, "Callsign system is disabled", { 255, 100, 100 })
            return
        end

        if not CALLSIGN_CONFIG.allowSelf then
            sendChatMessage(source, "Self callsign updates are disabled", { 255, 100, 100 })
            return
        end

        if CALLSIGN_CONFIG.permission and CALLSIGN_CONFIG.permission ~= "" then
            if not IsPlayerAceAllowed(source, CALLSIGN_CONFIG.permission) then
                sendChatMessage(source, "You do not have permission to set a callsign", { 255, 100, 100 })
                return
            end
        end

        setCallsignForSource(source, nil)
        sendChatMessage(source, "Callsign cleared", { 100, 255, 100 })
    end, false)
end

if CALLSIGN_CONFIG.adminCommand and CALLSIGN_CONFIG.adminCommand ~= "" then
    RegisterCommand(CALLSIGN_CONFIG.adminCommand, function(source, args)
        if not CALLSIGN_CONFIG.enabled then
            if source ~= 0 then
                sendChatMessage(source, "Callsign system is disabled", { 255, 100, 100 })
            end
            return
        end

        if not CALLSIGN_CONFIG.allowAdmin then
            if source ~= 0 then
                sendChatMessage(source, "Admin callsign updates are disabled", { 255, 100, 100 })
            end
            return
        end

        if source ~= 0 and CALLSIGN_CONFIG.adminPermission and CALLSIGN_CONFIG.adminPermission ~= "" then
            if not IsPlayerAceAllowed(source, CALLSIGN_CONFIG.adminPermission) then
                sendChatMessage(source, "You do not have permission to set callsigns for others", { 255, 100, 100 })
                return
            end
        end

        local targetId = tonumber(args[1] or "")
        if not targetId then
            if source ~= 0 then
                sendChatMessage(source, "Usage: /" .. CALLSIGN_CONFIG.adminCommand .. " <id> <callsign>", { 255, 255, 100 })
            else
                print("Usage: /" .. CALLSIGN_CONFIG.adminCommand .. " <id> <callsign>")
            end
            return
        end

        local input = table.concat(args, " ", 2)
        if input == "" then
            if source ~= 0 then
                sendChatMessage(source, "Usage: /" .. CALLSIGN_CONFIG.adminCommand .. " <id> <callsign>", { 255, 255, 100 })
            else
                print("Usage: /" .. CALLSIGN_CONFIG.adminCommand .. " <id> <callsign>")
            end
            return
        end

        if input:lower() == "clear" then
            local ok, result = setCallsignForSource(targetId, nil)
            if ok and source ~= 0 then
                sendChatMessage(source, "Cleared callsign for player " .. targetId, { 100, 255, 100 })
            end
            return
        end

        local ok, result = setCallsignForSource(targetId, input)
        if ok then
            if source ~= 0 then
                sendChatMessage(source, "Updated callsign for player " .. targetId .. " to " .. result, { 100, 255, 100 })
            end
        else
            if source ~= 0 then
                sendChatMessage(source, result or "Failed to update callsign", { 255, 100, 100 })
            end
        end
    end, false)
end

AddEventHandler("playerDropped", function()
    local sourceId = source
    callsignsByServerId[sourceId] = nil
end)

exports("getCallsign", function(serverId)
    return getCallsignForSource(serverId)
end)

exports("setCallsign", function(serverId, callsign)
    return setCallsignForSource(serverId, callsign)
end)
