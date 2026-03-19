local L0_1, L1_1, L2_1
L0_1 = Citizen
L0_1 = L0_1.CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2
  L0_2 = Citizen
  L0_2 = L0_2.Wait
  L1_2 = 2000
  L0_2(L1_2)
  L0_2 = {}
  L1_2 = Config
  L1_2 = L1_2.zones
  L0_2.zones = L1_2
  L1_2 = Config
  L1_2 = L1_2.serverPort
  L0_2.serverPort = L1_2
  L1_2 = Config
  L1_2 = L1_2.authToken
  L0_2.authToken = L1_2
  L1_2 = Config
  L1_2 = L1_2.logLevel
  L0_2.logLevel = L1_2
  L1_2 = Config
  L1_2 = L1_2.dispatchNacId
  L0_2.dispatchNacId = L1_2
  L1_2 = Config
  L1_2 = L1_2.playTransmissionEffects
  L0_2.playTransmissionEffects = L1_2
  L1_2 = Config
  L1_2 = L1_2.analogTransmissionEffects
  L0_2.analogTransmissionEffects = L1_2
  L1_2 = Config
  L1_2 = L1_2.alerts
  L0_2.alerts = L1_2
  L1_2 = TriggerEvent
  L2_2 = "radio:updateDispatchConfig"
  L3_2 = L0_2
  L1_2(L2_2, L3_2)
  L1_2 = log
  L2_2 = "Dispatch config data sent to web server"
  L3_2 = 4
  L4_2 = "Dispatch"
  L1_2(L2_2, L3_2, L4_2)
end
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "playerJoining"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2
  L1_2 = Citizen
  L1_2 = L1_2.SetTimeout
  L2_2 = 2000
  function L3_2()
    local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
    L0_3 = Config
    L0_3 = L0_3.getPlayerName
    L1_3 = tonumber
    L2_3 = A0_2
    L1_3, L2_3, L3_3, L4_3, L5_3 = L1_3(L2_3)
    L0_3 = L0_3(L1_3, L2_3, L3_3, L4_3, L5_3)
    L1_3 = Config
    L1_3 = L1_3.getUserNacId
    L2_3 = tonumber
    L3_3 = A0_2
    L2_3, L3_3, L4_3, L5_3 = L2_3(L3_3)
    L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
    if L0_3 then
      L2_3 = TriggerEvent
      L3_3 = "radio:updatePlayerName"
      L4_3 = tonumber
      L5_3 = A0_2
      L4_3 = L4_3(L5_3)
      L5_3 = L0_3
      L2_3(L3_3, L4_3, L5_3)
    end
    if L1_3 then
      L2_3 = TriggerEvent
      L3_3 = "radio:updateNacId"
      L4_3 = tonumber
      L5_3 = A0_2
      L4_3 = L4_3(L5_3)
      L5_3 = L1_3
      L2_3(L3_3, L4_3, L5_3)
    end
  end
  L1_2(L2_2, L3_2)
end
L0_1(L1_1, L2_1)
L0_1 = exports
L1_1 = "getPlayerName"
function L2_1(A0_2)
  local L1_2, L2_2
  L1_2 = Config
  L1_2 = L1_2.getPlayerName
  L2_2 = A0_2
  return L1_2(L2_2)
end
L0_1(L1_1, L2_1)
L0_1 = exports
L1_1 = "getUserNacId"
function L2_1(A0_2)
  local L1_2, L2_2
  L1_2 = Config
  L1_2 = L1_2.getUserNacId
  L2_2 = A0_2
  return L1_2(L2_2)
end
L0_1(L1_1, L2_1)
L0_1 = Citizen
L0_1 = L0_1.CreateThread
function L1_1()
  local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
  while true do
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = 5000
    L0_2(L1_2)
    L0_2 = GetPlayers
    L0_2 = L0_2()
    L1_2 = ipairs
    L2_2 = L0_2
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = tonumber
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L8_2 = Config
        L8_2 = L8_2.getPlayerName
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        L9_2 = Config
        L9_2 = L9_2.getUserNacId
        L10_2 = L7_2
        L9_2 = L9_2(L10_2)
        if L8_2 then
          L10_2 = TriggerEvent
          L11_2 = "radio:updatePlayerName"
          L12_2 = L7_2
          L13_2 = L8_2
          L10_2(L11_2, L12_2, L13_2)
          L10_2 = TriggerClientEvent
          L11_2 = "radio:receivePlayerName"
          L12_2 = -1
          L13_2 = L7_2
          L14_2 = L8_2
          L10_2(L11_2, L12_2, L13_2, L14_2)
        end
        if L9_2 then
          L10_2 = TriggerEvent
          L11_2 = "radio:updateNacId"
          L12_2 = L7_2
          L13_2 = L9_2
          L10_2(L11_2, L12_2, L13_2)
        end
      end
    end
  end
end
L0_1(L1_1)
L0_1 = RegisterServerEvent
L1_1 = "radio:requestPlayerData"
L0_1(L1_1)
L0_1 = AddEventHandler
L1_1 = "radio:requestPlayerData"
function L2_1(A0_2)
  local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
  if A0_2 then
    L1_2 = Config
    L1_2 = L1_2.getPlayerName
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = Config
    L2_2 = L2_2.getUserNacId
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if L1_2 then
      L3_2 = TriggerEvent
      L4_2 = "radio:updatePlayerName"
      L5_2 = A0_2
      L6_2 = L1_2
      L3_2(L4_2, L5_2, L6_2)
    end
    if L2_2 then
      L3_2 = TriggerEvent
      L4_2 = "radio:updateNacId"
      L5_2 = A0_2
      L6_2 = L2_2
      L3_2(L4_2, L5_2, L6_2)
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "radio:broadcastChannelAlert"
function L2_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L4_2 = ipairs
  L5_2 = A3_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    if L9_2 then
      L10_2 = TriggerClientEvent
      L11_2 = "radio:showDispatchAlert"
      L12_2 = L9_2
      L13_2 = {}
      L13_2.type = A1_2
      L13_2.message = A2_2
      L13_2.frequency = A0_2
      L13_2.duration = 10000
      L10_2(L11_2, L12_2, L13_2)
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "radio:broadcastGlobalAlert"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  L3_2 = ipairs
  L4_2 = A2_2
  L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
  for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
    if L8_2 then
      L9_2 = TriggerClientEvent
      L10_2 = "radio:showDispatchAlert"
      L11_2 = L8_2
      L12_2 = {}
      L12_2.type = A0_2
      L12_2.message = A1_2
      L12_2.frequency = nil
      L12_2.duration = 10000
      L9_2(L10_2, L11_2, L12_2)
    end
  end
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "radio:dispatchBroadcast"
function L2_1(A0_2, A1_2, A2_2, A3_2)
  local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
  L4_2 = ipairs
  L5_2 = A3_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = TriggerClientEvent
    L11_2 = "radio:showDispatchAlert"
    L12_2 = L9_2
    L13_2 = {}
    L13_2.type = A1_2
    L13_2.message = A2_2
    L13_2.frequency = A0_2
    L13_2.duration = 10000
    L10_2(L11_2, L12_2, L13_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "radio:trackActiveAlert"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  if A2_2 and A1_2 then
    L3_2 = TriggerEvent
    L4_2 = "radio:updateActiveAlerts"
    L5_2 = A0_2
    L6_2 = A1_2
    L3_2(L4_2, L5_2, L6_2)
  else
    L3_2 = TriggerEvent
    L4_2 = "radio:updateActiveAlerts"
    L5_2 = A0_2
    L6_2 = nil
    L3_2(L4_2, L5_2, L6_2)
  end
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "radio:dispatchOneshot"
function L2_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
  L2_2 = A1_2.toneOnly
  if L2_2 then
    L2_2 = A1_2.tone
    if L2_2 then
      L2_2 = A1_2.tone
      if "" ~= L2_2 then
        L2_2 = TriggerEvent
        L3_2 = "radioServer:playToneOnChannel"
        L4_2 = A0_2
        L5_2 = A1_2.tone
        L2_2(L3_2, L4_2, L5_2)
      end
    end
  else
    L2_2 = A1_2.tone
    if L2_2 then
      L2_2 = A1_2.tone
      if "" ~= L2_2 then
        L2_2 = TriggerEvent
        L3_2 = "radioServer:playToneOnChannel"
        L4_2 = A0_2
        L5_2 = A1_2.tone
        L2_2(L3_2, L4_2, L5_2)
      end
    end
    L2_2 = A1_2.name
    if L2_2 then
      L2_2 = A1_2.color
      if L2_2 then
        L2_2 = TriggerEvent
        L3_2 = "radioServer:sendAlertOnChannel"
        L4_2 = A0_2
        L5_2 = A1_2.name
        L6_2 = A1_2.color
        L7_2 = false
        L2_2(L3_2, L4_2, L5_2, L6_2, L7_2)
      end
    end
  end
  L2_2 = log
  L3_2 = "One-shot alert "
  L4_2 = A1_2.name
  if not L4_2 then
    L4_2 = "Unknown"
  end
  L5_2 = " triggered on channel "
  L6_2 = A0_2
  L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
  L4_2 = 3
  L5_2 = "Dispatch"
  L2_2(L3_2, L4_2, L5_2)
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "radio:dispatchTone"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2
  L3_2 = TriggerEvent
  L4_2 = "radioServer:playToneOnChannel"
  L5_2 = A0_2
  L6_2 = A1_2
  L3_2(L4_2, L5_2, L6_2)
end
L0_1(L1_1, L2_1)
L0_1 = AddEventHandler
L1_1 = "radio:dispatchUserAlert"
function L2_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  if A0_2 and A1_2 then
    L3_2 = TriggerClientEvent
    L4_2 = "radio:showDispatchAlert"
    L5_2 = A0_2
    L6_2 = {}
    L6_2.type = "Information Alert"
    L6_2.message = A1_2
    L6_2.frequency = A2_2
    L6_2.duration = 10000
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = TriggerClientEvent
    L4_2 = "radioClient:playTone"
    L5_2 = A0_2
    L6_2 = "beep"
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = log
    L4_2 = "Dispatch alert sent to user "
    L5_2 = A0_2
    L6_2 = ": "
    L7_2 = A1_2
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 2
    L6_2 = "Dispatch"
    L3_2(L4_2, L5_2, L6_2)
  end
end
L0_1(L1_1, L2_1)
