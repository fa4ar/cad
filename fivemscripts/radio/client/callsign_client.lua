if IsDuplicityVersion and IsDuplicityVersion() then
    return
end

local function addSuggestion(command, description, params)
    if not command or command == "" then
        return
    end

    TriggerEvent("chat:addSuggestion", "/" .. command, description, params or {})
end

Citizen.CreateThread(function()
    Citizen.Wait(1000)

    local cfg = Config and Config.callsign or nil
    if not cfg or cfg.enabled == false then
        return
    end

    addSuggestion(cfg.command or "callsign", "Set your callsign", {
        { name = "callsign", help = "Callsign text or 'clear'" },
    })

    addSuggestion(cfg.clearCommand or "clearcallsign", "Clear your callsign")

    addSuggestion(cfg.adminCommand or "setcallsign", "Set callsign for a player", {
        { name = "id", help = "Server ID" },
        { name = "callsign", help = "Callsign text or 'clear'" },
    })
end)
