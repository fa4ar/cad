local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1, L12_1, L13_1, L14_1, L15_1, L16_1, L17_1, L18_1, L19_1, L20_1, L21_1, L22_1, L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1
L0_1 = {}
activeAlerts = L0_1
L0_1 = {}
panicButtonChannels = L0_1
playerOwnedVehicle = nil
L0_1 = {}
L1_1 = {}
L2_1 = {}
L3_1 = {}
L4_1 = {}
function L5_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
  L2_2 = pairs
  L3_2 = A0_2
  L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
  for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
    if L7_2 == A1_2 then
      L8_2 = true
      return L8_2
    end
  end
  L2_2 = false
  return L2_2
end
doesTableContain = L5_1
L5_1 = {}
L6_1 = {}
L6_1.x = 1860.0
L6_1.y = 3677.0
L6_1.z = 33.0
L7_1 = {}
L7_1.x = 449.0
L7_1.y = -992.0
L7_1.z = 30.0
L8_1 = {}
L8_1.x = -979.0
L8_1.y = -2632.0
L8_1.z = 23.0
L9_1 = {}
L9_1.x = -2364.0
L9_1.y = 3229.0
L9_1.z = 45.0
L10_1 = {}
L10_1.x = -449.0
L10_1.y = 6025.0
L10_1.z = 35.0
L11_1 = {}
L11_1.x = 1529.0
L11_1.y = 820.0
L11_1.z = 79.0
L12_1 = {}
L12_1.x = -573.0
L12_1.y = -146.0
L12_1.z = 38.0
L13_1 = {}
L13_1.x = -3123.0
L13_1.y = 1334.0
L13_1.z = 25.0
L5_1[1] = L6_1
L5_1[2] = L7_1
L5_1[3] = L8_1
L5_1[4] = L9_1
L5_1[5] = L10_1
L5_1[6] = L11_1
L5_1[7] = L12_1
L5_1[8] = L13_1
if Config and type(Config.signalTowers) == "table" and next(Config.signalTowers) then
  L5_1 = {}
  L14_1 = ipairs
  L15_1 = Config.signalTowers
  L14_1, L15_1, L16_1, L17_1 = L14_1(L15_1)
  for L18_1, L19_1 in L14_1, L15_1, L16_1, L17_1 do
    if L19_1 and L19_1.x and L19_1.y and L19_1.z then
      L20_1 = table
      L20_1 = L20_1.insert
      L21_1 = L5_1
      L22_1 = {}
      L22_1.x = L19_1.x
      L22_1.y = L19_1.y
      L22_1.z = L19_1.z
      L20_1(L21_1, L22_1)
    end
  end
end
L6_1 = 100.0
L7_1 = GetGameTimer
L7_1 = L7_1()
function L8_1(A0_2, A1_2, A2_2)
  local L3_2, L4_2, L5_2, L6_2, L7_2
  if not A1_2 then
    A1_2 = 3
  end
  if not A2_2 then
    A2_2 = "Radio"
  end
  L3_2 = IsDuplicityVersion
  L3_2 = L3_2()
  if L3_2 then
    L3_2 = TriggerEvent
    L4_2 = "radio:log"
    L5_2 = A1_2
    L6_2 = A0_2
    L7_2 = A2_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
  else
    L3_2 = SendNUIMessage
    L4_2 = {}
    L4_2.type = "clientLog"
    L4_2.level = A1_2
    L4_2.message = A0_2
    L4_2.tag = A2_2
    L3_2(L4_2)
  end
end
log = L8_1
function L8_1(A0_2)
  local L1_2, L2_2
  if not A0_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "number" ~= L1_2 then
    L1_2 = tonumber
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    A0_2 = L1_2
  end
  L1_2 = type
  L2_2 = A0_2
  L1_2 = L1_2(L2_2)
  if "number" ~= L1_2 then
    L1_2 = nil
    return L1_2
  end
  L1_2 = math
  L1_2 = L1_2.floor
  L2_2 = A0_2 * 10000
  L2_2 = L2_2 + 0.5
  L1_2 = L1_2(L2_2)
  L1_2 = L1_2 / 10000
  return L1_2
end
convertFreq = L8_1
function L8_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
  if not A0_2 or A0_2.x == nil or A0_2.y == nil or A0_2.z == nil then
    L2_2 = {}
    return L2_2
  end
  L2_2 = {}
  L3_2 = GetPlayers
  L3_2 = L3_2()
  L4_2 = ipairs
  L5_2 = L3_2
  L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
  for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
    L10_2 = GetPlayerPed
    L11_2 = L9_2
    L10_2 = L10_2(L11_2)
    L11_2 = DoesEntityExist
    L12_2 = L10_2
    L11_2 = L11_2(L12_2)
    if L11_2 then
      L11_2 = GetEntityCoords
      L12_2 = L10_2
      L11_2 = L11_2(L12_2)
      L12_2 = vector3
      L13_2 = A0_2.x
      L14_2 = A0_2.y
      L15_2 = A0_2.z
      L12_2 = L12_2(L13_2, L14_2, L15_2)
      L13_2 = vector3
      L14_2 = L11_2.x
      L15_2 = L11_2.y
      L16_2 = L11_2.z
      L13_2 = L13_2(L14_2, L15_2, L16_2)
      L12_2 = L12_2 - L13_2
      L12_2 = #L12_2
      if A1_2 >= L12_2 then
        L13_2 = table
        L13_2 = L13_2.insert
        L14_2 = L2_2
        L15_2 = tonumber
        L16_2 = L9_2
        L15_2 = L15_2(L16_2)
        if L15_2 then
          L13_2(L14_2, L15_2)
        end
      end
    end
  end
  return L2_2
end
GetNearbyPlayers = L8_1
L8_1 = IsDuplicityVersion
L8_1 = L8_1()
if L8_1 then
  L8_1 = Citizen
  L8_1 = L8_1.CreateThread
  function L9_1()
    local L0_2, L1_2, L2_2
    L0_2 = TriggerEvent
    L1_2 = "radio:setLogLevel"
    L2_2 = Config
    L2_2 = L2_2.logLevel
    if not L2_2 then
      L2_2 = 3
    end
    L0_2(L1_2, L2_2)
    L0_2 = log
    L1_2 = "Radio server-side code starting up"
    L2_2 = 4
    L0_2(L1_2, L2_2)
  end
  L8_1(L9_1)
  L8_1 = Citizen
  L8_1 = L8_1.CreateThread
  function L9_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = math
      L1_2 = L1_2.random
      L2_2 = 5000
      L3_2 = 10000
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L1_2(L2_2, L3_2)
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L0_2 = pairs
      L1_2 = activeAlerts
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        if L5_2 then
          L6_2 = L5_2.isPersistent
          if L6_2 then
            L6_2 = L5_2.tone
            if L6_2 then
              L6_2 = L5_2.tone
              if "" ~= L6_2 then
                L6_2 = TriggerEvent
                L7_2 = "radioServer:playToneOnChannel"
                L8_2 = L4_2
                L9_2 = L5_2.tone
                L6_2(L7_2, L8_2, L9_2)
              end
            end
            L6_2 = TriggerEvent
            L7_2 = "radioServer:sendAlertOnChannel"
            L8_2 = L4_2
            L9_2 = L5_2.name
            L10_2 = L5_2.color
            if not L10_2 then
              L10_2 = "#ba8c00"
            end
            L11_2 = true
            L6_2(L7_2, L8_2, L9_2, L10_2, L11_2)
          end
        end
      end
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = math
      L1_2 = L1_2.random
      L2_2 = 5000
      L3_2 = 10000
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L1_2(L2_2, L3_2)
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L0_2 = pairs
      L1_2 = panicButtonChannels
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        if L5_2 then
          L6_2 = next
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          if L6_2 then
            L6_2 = next
            L7_2 = L5_2
            L6_2 = L6_2(L7_2)
            L7_2 = TriggerClientEvent
            L8_2 = "radioClient:setPanicOnChannel"
            L9_2 = -1
            L10_2 = L4_2
            L11_2 = panicButtonChannels
            L11_2 = L11_2[L4_2]
            L12_2 = L6_2
            L13_2 = true
            L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
          end
        end
      end
    end
  end
  L8_1(L9_1)
  L8_1 = Citizen
  L8_1 = L8_1.CreateThread
  function L9_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 30000
      L0_2(L1_2)
      L0_2 = GetGameTimer
      L0_2 = L0_2()
      L1_2 = 0
      L2_2 = 0
      L3_2 = pairs
      L4_2 = L3_1
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = L8_2.startTime
        L9_2 = L0_2 - L9_2
        L10_2 = 120000
        if L9_2 > L10_2 then
          L9_2 = log
          L10_2 = "Cleaning up stale talking state for player "
          L11_2 = L7_2
          L12_2 = " (talking for "
          L13_2 = L8_2.startTime
          L13_2 = L0_2 - L13_2
          L14_2 = "ms)"
          L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
          L11_2 = 3
          L9_2(L10_2, L11_2)
          L9_2 = L3_1
          L9_2[L7_2] = nil
          L2_2 = L2_2 + 1
        end
      end
      if L1_2 > 0 or L2_2 > 0 then
        L3_2 = log
        L4_2 = "Periodic cleanup: removed "
        L5_2 = L1_2
        L6_2 = " stale debounce entries and "
        L7_2 = L2_2
        L8_2 = " stale talking states"
        L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2
        L5_2 = 4
        L3_2(L4_2, L5_2)
      end
    end
  end
  L8_1(L9_1)
  L8_1 = {}
  function L9_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
    if A1_2 then
      L2_2 = A1_2.type
      if "trunked" == L2_2 then
        goto lbl_13
      end
    end
    if A1_2 then
      L2_2 = A1_2.frequency
      if L2_2 then
        goto lbl_12
      end
    end
    L2_2 = 0
    ::lbl_12::
    do return L2_2 end
    ::lbl_13::
    L2_2 = A1_2.coverage
    if L2_2 then
      L2_2 = A1_2.frequencyRange
      if L2_2 then
        goto lbl_24
      end
    end
    L2_2 = A1_2.frequency
    if not L2_2 then
      L2_2 = 0
    end
    do return L2_2 end
    ::lbl_24::
    if not A0_2 then
      L2_2 = A1_2.frequencyRange
      L2_2 = L2_2[1]
      return L2_2
    end
    L2_2 = A0_2.x
    if not L2_2 then
      L2_2 = A0_2[1]
    end
    L3_2 = A0_2.y
    if not L3_2 then
      L3_2 = A0_2[2]
    end
    L4_2 = A1_2.coverage
    L5_2 = math
    L5_2 = L5_2.floor
    L6_2 = L2_2 / L4_2
    L5_2 = L5_2(L6_2)
    L6_2 = math
    L6_2 = L6_2.floor
    L7_2 = L3_2 / L4_2
    L6_2 = L6_2(L7_2)
    L7_2 = math
    L7_2 = L7_2.floor
    L8_2 = L5_2 * 73856093
    L9_2 = L6_2 * 19349663
    L8_2 = L8_2 + L9_2
    L9_2 = A1_2.frequency
    L9_2 = L9_2 * 83492791
    L8_2 = L8_2 + L9_2
    L8_2 = L8_2 % 100000
    L7_2 = L7_2(L8_2)
    L8_2 = A1_2.frequencyRange
    L8_2 = L8_2[1]
    L9_2 = A1_2.frequencyRange
    L9_2 = L9_2[2]
    L10_2 = 0.0125
    L11_2 = math
    L11_2 = L11_2.floor
    L12_2 = L9_2 - L8_2
    L12_2 = L12_2 / L10_2
    L11_2 = L11_2(L12_2)
    L12_2 = L7_2 % L11_2
    L13_2 = math
    L13_2 = L13_2.floor
    L14_2 = L12_2 * L10_2
    L14_2 = L8_2 + L14_2
    L14_2 = L14_2 * 10000
    L13_2 = L13_2(L14_2)
    L13_2 = L13_2 / 10000
    return L13_2
  end
  L10_1 = RegisterNetEvent
  L11_1 = "radio:requestTrunkedFrequency"
  L10_1(L11_1)
  L10_1 = AddEventHandler
  L11_1 = "radio:requestTrunkedFrequency"
  function L12_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = L9_1
    L3_2 = A1_2
    L4_2 = A0_2
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = source
    L4_2 = L4_1
    L4_2[L3_2] = L2_2
    L4_2 = L3_1
    L4_2 = L4_2[L3_2]
    if L4_2 then
      L4_2 = L3_1
      L4_2 = L4_2[L3_2]
      L4_2.trunkedFreq = L2_2
      L4_2 = log
      L5_2 = "Updated trunked frequency for talking player "
      L6_2 = L3_2
      L7_2 = " to "
      L8_2 = tostring
      L9_2 = L2_2
      L8_2 = L8_2(L9_2)
      L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
      L6_2 = 4
      L4_2(L5_2, L6_2)
    end
    L4_2 = TriggerClientEvent
    L5_2 = "radio:receiveTrunkedFrequency"
    L6_2 = source
    L7_2 = L2_2
    L4_2(L5_2, L6_2, L7_2)
  end
  L10_1(L11_1, L12_1)
  L10_1 = RegisterNetEvent
  L11_1 = "radio:requestTrunkedScanFrequency"
  L10_1(L11_1)
  L10_1 = AddEventHandler
  L11_1 = "radio:requestTrunkedScanFrequency"
  function L12_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L3_2 = L9_1
    L4_2 = A1_2
    L5_2 = A0_2
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = TriggerClientEvent
    L5_2 = "radio:receiveTrunkedScanFrequency"
    L6_2 = source
    L7_2 = L3_2
    L8_2 = A2_2
    L4_2(L5_2, L6_2, L7_2, L8_2)
  end
  L10_1(L11_1, L12_1)
  L10_1 = RegisterNetEvent
  L11_1 = "radio:updateTrunkedLocation"
  L10_1(L11_1)
  L10_1 = AddEventHandler
  L11_1 = "radio:updateTrunkedLocation"
  function L12_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L2_2 = L9_1
    L3_2 = A1_2
    L4_2 = A0_2
    L2_2 = L2_2(L3_2, L4_2)
    L4_2 = source
    L3_2 = L8_1
    L3_2 = L3_2[L4_2]
    if L3_2 then
      L3_2 = L9_1
      L5_2 = source
      L4_2 = L8_1
      L4_2 = L4_2[L5_2]
      L5_2 = A0_2
      L3_2 = L3_2(L4_2, L5_2)
      if L3_2 then
        goto lbl_19
      end
    end
    L3_2 = nil
    ::lbl_19::
    if L3_2 ~= L2_2 then
      L4_2 = TriggerClientEvent
      L5_2 = "radio:receiveTrunkedFrequency"
      L6_2 = source
      L7_2 = L2_2
      L4_2(L5_2, L6_2, L7_2)
    end
    L5_2 = source
    L4_2 = L8_1
    L4_2[L5_2] = A1_2
  end
  L10_1(L11_1, L12_1)
  L10_1 = RegisterNetEvent
  L11_1 = "radio:updateTrunkedScanLocation"
  L10_1(L11_1)
  L10_1 = AddEventHandler
  L11_1 = "radio:updateTrunkedScanLocation"
  function L12_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L3_2 = L9_1
    L4_2 = A1_2
    L5_2 = A0_2
    L3_2 = L3_2(L4_2, L5_2)
    L4_2 = source
    L5_2 = "_"
    L6_2 = A2_2
    L4_2 = L4_2 .. L5_2 .. L6_2
    L5_2 = L8_1
    L5_2 = L5_2[L4_2]
    if L5_2 then
      L5_2 = L9_1
      L6_2 = L8_1
      L6_2 = L6_2[L4_2]
      L7_2 = A0_2
      L5_2 = L5_2(L6_2, L7_2)
      if L5_2 then
        goto lbl_21
      end
    end
    L5_2 = nil
    ::lbl_21::
    if L5_2 ~= L3_2 then
      L6_2 = TriggerClientEvent
      L7_2 = "radio:receiveTrunkedScanFrequency"
      L8_2 = source
      L9_2 = L3_2
      L10_2 = A2_2
      L6_2(L7_2, L8_2, L9_2, L10_2)
    end
    L6_2 = L8_1
    L6_2[L4_2] = A1_2
  end
  L10_1(L11_1, L12_1)
  L10_1 = RegisterNetEvent
  L11_1 = "radio:talkerState"
  L10_1(L11_1)
  L10_1 = AddEventHandler
  L11_1 = "radio:talkerState"
  function L12_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
    L1_2 = A0_2.serverId
    L2_2 = A0_2.frequency
    L3_2 = A0_2.state
    if L3_2 then
      L4_2 = convertFreq
      L5_2 = L2_2
      L4_2 = L4_2(L5_2)
      L5_2 = pairs
      L6_2 = L3_1
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
        if L9_2 ~= L1_2 then
          L11_2 = L10_2.trunkedFreq
          if not L11_2 then
            L11_2 = L10_2.frequency
          end
          if L11_2 then
            L12_2 = convertFreq
            L13_2 = L11_2
            L12_2 = L12_2(L13_2)
            if L12_2 == L4_2 then
              L14_2 = source
              if L14_2 and L14_2 > 0 then
                L15_2 = TriggerClientEvent
                L16_2 = "radio:forceTransmissionStopped"
                L17_2 = L14_2
                L18_2 = L1_2
                L15_2(L16_2, L17_2, L18_2)
                L15_2 = TriggerClientEvent
                L16_2 = "radioClient:playTone"
                L17_2 = L14_2
                L18_2 = "bonk"
                L15_2(L16_2, L17_2, L18_2)
              end
              L14_2 = log
              L15_2 = "Blocking talker start: player "
              L16_2 = L1_2
              L17_2 = " attempted to talk on "
              L18_2 = tostring
              L19_2 = L2_2
              L18_2 = L18_2(L19_2)
              L19_2 = " but player "
              L20_2 = L9_2
              L21_2 = " is already talking"
              L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2
              L16_2 = 3
              L14_2(L15_2, L16_2)
              return
            end
          end
        end
      end
      L4_2 = L3_1
      L5_2 = {}
      L5_2.frequency = L2_2
      L6_2 = L4_1
      L6_2 = L6_2[L1_2]
      L5_2.trunkedFreq = L6_2
      L6_2 = GetGameTimer
      L6_2 = L6_2()
      L5_2.startTime = L6_2
      L4_2[L1_2] = L5_2
      L4_2 = L4_1
      L4_2 = L4_2[L1_2]
      if L4_2 then
        L4_2 = " (trunked: "
        L5_2 = L4_1
        L5_2 = L5_2[L1_2]
        L6_2 = ")"
        L4_2 = L4_2 .. L5_2 .. L6_2
        if L4_2 then
          goto lbl_29
        end
      end
      L4_2 = ""
      ::lbl_29::
      L5_2 = log
      L6_2 = "Player "
      L7_2 = L1_2
      L8_2 = " started talking on frequency "
      L9_2 = tostring
      L10_2 = L2_2
      L9_2 = L9_2(L10_2)
      L10_2 = L4_2
      L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
      L7_2 = 4
      L5_2(L6_2, L7_2)
    else
      L4_2 = L3_1
      L4_2 = L4_2[L1_2]
      if L4_2 then
        L4_2 = GetGameTimer
        L4_2 = L4_2()
        L5_2 = L3_1
        L5_2 = L5_2[L1_2]
        L5_2 = L5_2.startTime
        L4_2 = L4_2 - L5_2
        L5_2 = log
        L6_2 = "Player "
        L7_2 = L1_2
        L8_2 = " stopped talking after "
        L9_2 = L4_2
        L10_2 = "ms"
        L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
        L7_2 = 4
        L5_2(L6_2, L7_2)
        L5_2 = L3_1
        L5_2[L1_2] = nil
      end
    end
  end
  L10_1(L11_1, L12_1)
  L10_1 = RegisterNetEvent
  L11_1 = "radioServer:setAlertOnChannel"
  function L12_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L4_2 = convertFreq
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if not A2_2 then
      L5_2 = log
      L6_2 = "Warning: No alert config provided for setAlertOnChannel"
      L7_2 = 2
      L5_2(L6_2, L7_2)
      return
    end
    if A1_2 then
      L5_2 = activeAlerts
      L5_2[L4_2] = A2_2
      L5_2 = A2_2.tone
      if L5_2 then
        L5_2 = A2_2.tone
        if "" ~= L5_2 then
          L5_2 = TriggerEvent
          L6_2 = "radioServer:playToneOnChannel"
          L7_2 = L4_2
          L8_2 = A2_2.tone
          L5_2(L6_2, L7_2, L8_2)
        end
      end
      L5_2 = TriggerEvent
      L6_2 = "radioServer:sendAlertOnChannel"
      L7_2 = L4_2
      L8_2 = A2_2.name
      L9_2 = A2_2.color
      if not L9_2 then
        L9_2 = "#ba8c00"
      end
      L10_2 = A2_2.isPersistent
      if not L10_2 then
        L10_2 = false
      end
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    else
      L5_2 = activeAlerts
      L5_2[L4_2] = nil
      L5_2 = TriggerEvent
      L6_2 = "radioServer:playToneOnChannel"
      L7_2 = L4_2
      L8_2 = "ALERT_B"
      L5_2(L6_2, L7_2, L8_2)
      L5_2 = TriggerEvent
      L6_2 = "radioServer:sendAlertOnChannel"
      L7_2 = L4_2
      L8_2 = "RESUME"
      L9_2 = "#126300"
      L10_2 = false
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    end
    L5_2 = TriggerClientEvent
    L6_2 = "radioClient:setAlertOnChannel"
    L7_2 = -1
    L8_2 = L4_2
    L9_2 = A1_2
    L10_2 = A2_2
    L5_2(L6_2, L7_2, L8_2, L9_2, L10_2)
    L5_2 = TriggerEvent
    L6_2 = "radio:trackActiveAlert"
    L7_2 = L4_2
    L8_2 = A2_2
    L9_2 = A1_2
    L5_2(L6_2, L7_2, L8_2, L9_2)
    if "dispatch" ~= A3_2 then
      L5_2 = TriggerEvent
      L6_2 = "radio:sendDispatchNotification"
      L7_2 = {}
      if A1_2 then
        L8_2 = "alert_activated"
        if L8_2 then
          goto lbl_79
        end
      end
      L8_2 = "alert_cleared"
      ::lbl_79::
      L7_2.type = L8_2
      L7_2.frequency = L4_2
      if A1_2 then
        L8_2 = A2_2.name
        L9_2 = " activated"
        L8_2 = L8_2 .. L9_2
        if L8_2 then
          goto lbl_91
        end
      end
      L8_2 = A2_2.name
      L9_2 = " cleared"
      L8_2 = L8_2 .. L9_2
      ::lbl_91::
      L7_2.message = L8_2
      if A1_2 then
        L8_2 = "warning"
        if L8_2 then
          goto lbl_98
        end
      end
      L8_2 = "success"
      ::lbl_98::
      L7_2.status = L8_2
      L5_2(L6_2, L7_2)
    end
    L5_2 = log
    L6_2 = A2_2.name
    if not L6_2 then
      L6_2 = "Alert"
    end
    L7_2 = " "
    if A1_2 then
      L8_2 = "activated"
      if L8_2 then
        goto lbl_112
      end
    end
    L8_2 = "deactivated"
    ::lbl_112::
    L9_2 = " on channel "
    L10_2 = L4_2
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
    L7_2 = 3
    L5_2(L6_2, L7_2)
  end
  L10_1(L11_1, L12_1)
  L10_1 = {}
  panicButtonChannels = L10_1
  L10_1 = RegisterNetEvent
  L11_1 = "radioServer:setPanicOnChannel"
  function L12_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L3_2 = A2_2 or nil
    if not A2_2 then
      L3_2 = source
    end
    L4_2 = convertFreq
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    if A1_2 then
      L5_2 = panicButtonChannels
      L5_2 = L5_2[L4_2]
      if not L5_2 then
        L5_2 = panicButtonChannels
        L6_2 = {}
        L5_2[L4_2] = L6_2
      end
      L5_2 = panicButtonChannels
      L5_2 = L5_2[L4_2]
      L5_2[L3_2] = L3_2
      L5_2 = TriggerClientEvent
      L6_2 = "radioClient:setPanicOnChannel"
      L7_2 = -1
      L8_2 = L4_2
      L9_2 = panicButtonChannels
      L9_2 = L9_2[L4_2]
      L10_2 = L3_2
      L11_2 = true
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L5_2 = Citizen
      L5_2 = L5_2.CreateThread
      function L6_2()
        local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3
        L0_3 = Citizen
        L0_3 = L0_3.Wait
        L1_3 = Config
        L1_3 = L1_3.panicTimeout
        L0_3(L1_3)
        L0_3 = panicButtonChannels
        L1_3 = L4_2
        L0_3 = L0_3[L1_3]
        if L0_3 then
          L0_3 = panicButtonChannels
          L1_3 = L4_2
          L0_3 = L0_3[L1_3]
          L1_3 = L3_2
          L0_3[L1_3] = nil
          L0_3 = next
          L1_3 = panicButtonChannels
          L2_3 = L4_2
          L1_3 = L1_3[L2_3]
          L0_3 = L0_3(L1_3)
          if nil == L0_3 then
            L0_3 = panicButtonChannels
            L1_3 = L4_2
            L0_3[L1_3] = nil
          end
          L0_3 = TriggerClientEvent
          L1_3 = "radioClient:setPanicOnChannel"
          L2_3 = -1
          L3_3 = L4_2
          L4_3 = panicButtonChannels
          L5_3 = L4_2
          L4_3 = L4_3[L5_3]
          if not L4_3 then
            L4_3 = {}
          end
          L5_3 = L3_2
          L6_3 = false
          L0_3(L1_3, L2_3, L3_3, L4_3, L5_3, L6_3)
        end
      end
      L5_2(L6_2)
    else
      L5_2 = panicButtonChannels
      L5_2 = L5_2[L4_2]
      if L5_2 then
        L5_2 = panicButtonChannels
        L5_2 = L5_2[L4_2]
        L5_2[L3_2] = nil
        L5_2 = next
        L6_2 = panicButtonChannels
        L6_2 = L6_2[L4_2]
        L5_2 = L5_2(L6_2)
        if nil == L5_2 then
          L5_2 = panicButtonChannels
          L5_2[L4_2] = nil
        end
      end
      L5_2 = TriggerClientEvent
      L6_2 = "radioClient:setPanicOnChannel"
      L7_2 = -1
      L8_2 = L4_2
      L9_2 = panicButtonChannels
      L9_2 = L9_2[L4_2]
      if not L9_2 then
        L9_2 = {}
      end
      L10_2 = L3_2
      L11_2 = A1_2
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L5_2 = log
      L6_2 = "Panic "
      if A1_2 then
        L7_2 = "activated"
        if L7_2 then
          goto lbl_70
        end
      end
      L7_2 = "deactivated"
      ::lbl_70::
      L8_2 = " for player "
      L9_2 = L3_2
      L10_2 = " on channel "
      L11_2 = L4_2
      L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2
      L7_2 = 4
      L5_2(L6_2, L7_2)
    end
  end
  L10_1(L11_1, L12_1)
  L10_1 = Citizen
  L10_1 = L10_1.CreateThread
  function L11_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = TriggerEvent
    L1_2 = "radio:setLogLevel"
    L2_2 = Config
    L2_2 = L2_2.logLevel
    if not L2_2 then
      L2_2 = 3
    end
    L0_2(L1_2, L2_2)
    L0_2 = TriggerEvent
    L1_2 = "radio:initServer"
    L2_2 = Config
    L2_2 = L2_2.connectionAddr
    L3_2 = Config
    L3_2 = L3_2.serverPort
    L4_2 = Config
    L4_2 = L4_2.authToken
    L5_2 = Config
    L5_2 = L5_2.logLevel
    L6_2 = Config
    L6_2 = L6_2.doUpdateCheck
    L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2)
  end
  L10_1(L11_1)
  L10_1 = {}
  L11_1 = {}
  L12_1 = RegisterNetEvent
  L13_1 = "radioServer:updateSirenStatus"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radioServer:updateSirenStatus"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
    L1_2 = source
    if not L1_2 or L1_2 <= 0 then
      return
    end
    L2_2 = L10_1
    L2_2 = L2_2[L1_2]
    if not L2_2 then
      L2_2 = false
    end
    L3_2 = A0_2 or L3_2
    if not A0_2 then
      L3_2 = false
    end
    if L2_2 ~= L3_2 then
      if L3_2 then
        L4_2 = L10_1
        L4_2[L1_2] = true
        L4_2 = log
        L5_2 = "Player "
        L6_2 = L1_2
        L7_2 = " siren ON"
        L5_2 = L5_2 .. L6_2 .. L7_2
        L6_2 = 4
        L4_2(L5_2, L6_2)
      else
        L4_2 = L10_1
        L4_2[L1_2] = nil
        L4_2 = log
        L5_2 = "Player "
        L6_2 = L1_2
        L7_2 = " siren OFF"
        L5_2 = L5_2 .. L6_2 .. L7_2
        L6_2 = 4
        L4_2(L5_2, L6_2)
      end
      L4_2 = TriggerClientEvent
      L5_2 = "radioClient:updateSirenList"
      L6_2 = -1
      L7_2 = L10_1
      L4_2(L5_2, L6_2, L7_2)
      L4_2 = 0
      L5_2 = pairs
      L6_2 = L10_1
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2 in L5_2, L6_2, L7_2, L8_2 do
        L4_2 = L4_2 + 1
      end
      L5_2 = log
      L6_2 = "Updated siren list with "
      L7_2 = L4_2
      L8_2 = " players"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = log
      L6_2 = "\240\159\154\168 SERVER: Sending siren list to dispatch - sirenPlayers table:"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = pairs
      L6_2 = L10_1
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
        L11_2 = log
        L12_2 = "\240\159\154\168 SERVER: sirenPlayers["
        L13_2 = tostring
        L14_2 = L9_2
        L13_2 = L13_2(L14_2)
        L14_2 = "] = "
        L15_2 = tostring
        L16_2 = L10_2
        L15_2 = L15_2(L16_2)
        L12_2 = L12_2 .. L13_2 .. L14_2 .. L15_2
        L13_2 = 4
        L11_2(L12_2, L13_2)
      end
      L5_2 = log
      L6_2 = "\240\159\154\168 SERVER: JSON encoding sirenPlayers for dispatch"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "radio:webSocketBroadcast"
      L7_2 = "updateSirenList"
      L8_2 = L10_1
      L5_2(L6_2, L7_2, L8_2)
    else
      L4_2 = log
      L5_2 = "Player "
      L6_2 = L1_2
      L7_2 = " siren status unchanged: "
      L8_2 = tostring
      L9_2 = L3_2
      L8_2 = L8_2(L9_2)
      L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
      L6_2 = 4
      L4_2(L5_2, L6_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radioServer:updateHeliStatus"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radioServer:updateHeliStatus"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
    L1_2 = source
    if not L1_2 or L1_2 <= 0 then
      return
    end
    L2_2 = L11_1
    L2_2 = L2_2[L1_2]
    if not L2_2 then
      L2_2 = false
    end
    L3_2 = A0_2 or L3_2
    if not A0_2 then
      L3_2 = false
    end
    if L2_2 ~= L3_2 then
      if L3_2 then
        L4_2 = L11_1
        L4_2[L1_2] = true
        L4_2 = log
        L5_2 = "Player "
        L6_2 = L1_2
        L7_2 = " helicopter ON"
        L5_2 = L5_2 .. L6_2 .. L7_2
        L6_2 = 4
        L4_2(L5_2, L6_2)
      else
        L4_2 = L11_1
        L4_2[L1_2] = nil
        L4_2 = log
        L5_2 = "Player "
        L6_2 = L1_2
        L7_2 = " helicopter OFF"
        L5_2 = L5_2 .. L6_2 .. L7_2
        L6_2 = 4
        L4_2(L5_2, L6_2)
      end
      L4_2 = TriggerClientEvent
      L5_2 = "radioClient:updateHeliList"
      L6_2 = -1
      L7_2 = L11_1
      L4_2(L5_2, L6_2, L7_2)
      L4_2 = 0
      L5_2 = pairs
      L6_2 = L11_1
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2 in L5_2, L6_2, L7_2, L8_2 do
        L4_2 = L4_2 + 1
      end
      L5_2 = log
      L6_2 = "Updated helicopter list with "
      L7_2 = L4_2
      L8_2 = " players"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = log
      L6_2 = "\240\159\154\129 SERVER: Sending heli list to dispatch - heliPlayers table:"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = pairs
      L6_2 = L11_1
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
        L11_2 = log
        L12_2 = "\240\159\154\129 SERVER: heliPlayers["
        L13_2 = tostring
        L14_2 = L9_2
        L13_2 = L13_2(L14_2)
        L14_2 = "] = "
        L15_2 = tostring
        L16_2 = L10_2
        L15_2 = L15_2(L16_2)
        L12_2 = L12_2 .. L13_2 .. L14_2 .. L15_2
        L13_2 = 4
        L11_2(L12_2, L13_2)
      end
      L5_2 = log
      L6_2 = "\240\159\154\129 SERVER: JSON encoding heliPlayers for dispatch"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "radio:webSocketBroadcast"
      L7_2 = "updateHeliList"
      L8_2 = L11_1
      L5_2(L6_2, L7_2, L8_2)
    else
      L4_2 = log
      L5_2 = "Player "
      L6_2 = L1_2
      L7_2 = " helicopter status unchanged: "
      L8_2 = tostring
      L9_2 = L3_2
      L8_2 = L8_2(L9_2)
      L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
      L6_2 = 4
      L4_2(L5_2, L6_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = AddEventHandler
  L13_1 = "playerDropped"
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = source
    L1_2 = L10_1
    L1_2 = L1_2[L0_2]
    if L1_2 then
      L1_2 = L10_1
      L1_2[L0_2] = nil
      L1_2 = L11_1
      L1_2[L0_2] = nil
      L1_2 = TriggerClientEvent
      L2_2 = "radioClient:updateSirenList"
      L3_2 = -1
      L4_2 = L10_1
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = TriggerClientEvent
      L2_2 = "radioClient:updateHeliList"
      L3_2 = -1
      L4_2 = L11_1
      L1_2(L2_2, L3_2, L4_2)
      L1_2 = log
      L2_2 = "Cleaned up siren and helicopter status for dropped player "
      L3_2 = L0_2
      L2_2 = L2_2 .. L3_2
      L3_2 = 3
      L1_2(L2_2, L3_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:gunshotDuringTransmission"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:gunshotDuringTransmission"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L2_2 = source
    L3_2 = Config
    L3_2 = L3_2.playTransmissionEffects
    if not L3_2 then
      return
    end
    L3_2 = log
    L4_2 = "\240\159\148\171 SERVER: Received gunshot during transmission from player "
    L5_2 = L2_2
    L6_2 = " with distance: "
    L7_2 = tostring
    L8_2 = A1_2
    L7_2 = L7_2(L8_2)
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = log
    L4_2 = "\240\159\148\171 SERVER: Gunshot event details - serverId: "
    L5_2 = tostring
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    L6_2 = ", distance: "
    L7_2 = tostring
    L8_2 = A1_2
    L7_2 = L7_2(L8_2)
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = TriggerClientEvent
    L4_2 = "radioClient:gunshotDuringTransmission"
    L5_2 = -1
    L6_2 = A0_2
    L7_2 = A1_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = log
    L4_2 = "\240\159\148\171 SERVER: Broadcasted gunshot to all clients"
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = TriggerEvent
    L4_2 = "radio:webSocketBroadcast"
    L5_2 = "gunshotDuringTransmission"
    L6_2 = {}
    L6_2.serverId = A0_2
    L6_2.distance = A1_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = log
    L4_2 = "\240\159\148\171 SERVER: Sent gunshot to dispatch panel via WebSocket"
    L5_2 = 4
    L3_2(L4_2, L5_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = Citizen
  L12_1 = L12_1.CreateThread
  function L13_1()
    local L0_2, L1_2, L2_2, L3_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 1000
      L0_2(L1_2)
      L0_2 = TriggerEvent
      L1_2 = "radio:webSocketBroadcast"
      L2_2 = "updateSirenList"
      L3_2 = L10_1
      L0_2(L1_2, L2_2, L3_2)
      L0_2 = TriggerEvent
      L1_2 = "radio:webSocketBroadcast"
      L2_2 = "updateHeliList"
      L3_2 = L11_1
      L0_2(L1_2, L2_2, L3_2)
    end
  end
  L12_1(L13_1)
  L12_1 = table
  function L13_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L2_2 = type
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if "table" == L2_2 then
      L2_2 = type
      L3_2 = A1_2
      L2_2 = L2_2(L3_2)
      if "table" == L2_2 then
        goto lbl_13
      end
    end
    L2_2 = false
    do return L2_2 end
    ::lbl_13::
    L2_2 = pairs
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = A1_2[L6_2]
      if L8_2 ~= L7_2 then
        L8_2 = false
        return L8_2
      end
    end
    L2_2 = pairs
    L3_2 = A1_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = A0_2[L6_2]
      if L8_2 ~= L7_2 then
        L8_2 = false
        return L8_2
      end
    end
    L2_2 = true
    return L2_2
  end
  L12_1.equals = L13_1
  L12_1 = RegisterNetEvent
  L13_1 = "radioServer:playToneOnChannel"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radioServer:playToneOnChannel"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    L2_2 = Radio
    L2_2 = L2_2.getClientsInChannel
    L3_2 = convertFreq
    L4_2 = A0_2
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2(L4_2)
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
    L3_2 = ipairs
    L4_2 = L2_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = TriggerClientEvent
      L10_2 = "radioClient:playTone"
      L11_2 = L8_2
      L12_2 = A1_2
      L9_2(L10_2, L11_2, L12_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radioServer:sendAlertOnChannel"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radioServer:sendAlertOnChannel"
  function L14_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
    L4_2 = Radio
    L4_2 = L4_2.getClientsInChannel
    L5_2 = convertFreq
    L6_2 = A0_2
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L5_2(L6_2)
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L5_2 = ipairs
    L6_2 = L4_2
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = TriggerClientEvent
      L12_2 = "radioClient:showAlert"
      L13_2 = L10_2
      L14_2 = A1_2
      L15_2 = A2_2
      L16_2 = A3_2
      L11_2(L12_2, L13_2, L14_2, L15_2, L16_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "setSignal100OnChannel"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L2_2 = IsDuplicityVersion
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = nil
      return L2_2
    end
    L2_2 = Config
    L2_2 = L2_2.alerts
    if L2_2 then
      L2_2 = Config
      L2_2 = L2_2.alerts
      L2_2 = L2_2[1]
    end
    L3_2 = TriggerEvent
    L4_2 = "radioServer:setAlertOnChannel"
    L5_2 = A0_2
    L6_2 = A1_2
    L7_2 = L2_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = true
    return L3_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "playToneOnChannel"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = IsDuplicityVersion
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = nil
      return L2_2
    end
    L2_2 = TriggerEvent
    L3_2 = "radioServer:playToneOnChannel"
    L4_2 = A0_2
    L5_2 = A1_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = true
    return L2_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "playToneOnSource"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = IsDuplicityVersion
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = nil
      return L2_2
    end
    L2_2 = TriggerClientEvent
    L3_2 = "radioClient:playTone"
    L4_2 = A0_2
    L5_2 = A1_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = true
    return L2_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DPlayTone"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DPlayTone"
  function L14_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
    L3_2 = source
    L4_2 = GetPlayerPed
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = DoesEntityExist
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    if not L5_2 then
      return
    end
    L5_2 = GetEntityCoords
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    L6_2 = log
    L7_2 = "Player "
    L8_2 = L3_2
    L9_2 = " played tone: "
    L10_2 = A0_2
    L11_2 = " at coords: "
    L12_2 = tostring
    L13_2 = L5_2
    L12_2 = L12_2(L13_2)
    L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2
    L8_2 = 4
    L6_2(L7_2, L8_2)
    L6_2 = nil
    if A2_2 then
      L7_2 = L0_1
      L7_2 = L7_2[L3_2]
      if L7_2 == A2_2 then
        L7_2 = NetworkGetEntityFromNetworkId
        L8_2 = A2_2
        L7_2 = L7_2(L8_2)
        L8_2 = DoesEntityExist
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if L8_2 then
          L8_2 = GetEntityCoords
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
          L6_2 = L8_2
        else
          L8_2 = L0_1
          L8_2[L3_2] = nil
          L8_2 = log
          L9_2 = "Vehicle entity for player "
          L10_2 = L3_2
          L11_2 = " no longer exists, removing ownership"
          L9_2 = L9_2 .. L10_2 .. L11_2
          L10_2 = 4
          L8_2(L9_2, L10_2)
        end
      end
    end
    L7_2 = GetNearbyPlayers
    L8_2 = L5_2
    L9_2 = 150
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = L2_1
    L8_2 = L8_2[L3_2]
    if L8_2 then
      L8_2 = doesTableContain
      L9_2 = L7_2
      L10_2 = tonumber
      L11_2 = L3_2
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L10_2(L11_2)
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      if not L8_2 then
        L8_2 = table
        L8_2 = L8_2.insert
        L9_2 = L7_2
        L10_2 = tonumber
        L11_2 = L3_2
        L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L10_2(L11_2)
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      end
    end
    L8_2 = ipairs
    L9_2 = L7_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      if L13_2 == L3_2 then
        L14_2 = L2_1
        L14_2 = L14_2[L3_2]
        if not L14_2 then
          goto lbl_90
        end
      end
      L14_2 = TriggerClientEvent
      L15_2 = "radio:receive3DTone"
      L16_2 = L13_2
      L17_2 = L3_2
      L18_2 = A0_2
      L19_2 = A1_2
      L20_2 = L5_2
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      ::lbl_90::
    end
    if L6_2 then
      L8_2 = L5_2 - L6_2
      L8_2 = #L8_2
      if L8_2 > 5 then
        L9_2 = GetNearbyPlayers
        L10_2 = L6_2
        L11_2 = 150
        L9_2 = L9_2(L10_2, L11_2)
        L10_2 = ipairs
        L11_2 = L9_2
        L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
        for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
          if L15_2 == L3_2 then
            L16_2 = L2_1
            L16_2 = L16_2[L3_2]
            if not L16_2 then
              goto lbl_124
            end
          end
          L16_2 = L3_2 + 100000
          L17_2 = TriggerClientEvent
          L18_2 = "radio:receive3DTone"
          L19_2 = L15_2
          L20_2 = L16_2
          L21_2 = A0_2
          L22_2 = A1_2
          L23_2 = L6_2
          L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
          ::lbl_124::
        end
        L10_2 = log
        L11_2 = "Also broadcasting 3D tone from vehicle location for "
        L12_2 = #L9_2
        L13_2 = " players"
        L11_2 = L11_2 .. L12_2 .. L13_2
        L12_2 = 4
        L10_2(L11_2, L12_2)
      end
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DVoiceStarted"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DVoiceStarted"
  function L14_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
    L3_2 = source
    L4_2 = GetPlayerPed
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = GetEntityCoords
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    L6_2 = L1_1
    L6_2 = L6_2[L3_2]
    if not L6_2 then
      L6_2 = L1_1
      L7_2 = {}
      L6_2[L3_2] = L7_2
    end
    L6_2 = L1_1
    L6_2 = L6_2[L3_2]
    L7_2 = {}
    L7_2.type = "voice"
    L8_2 = GetGameTimer
    L8_2 = L8_2()
    L7_2.startTime = L8_2
    L7_2.frequency = A0_2
    L7_2.coords = L5_2
    L7_2.vehicle = A2_2
    L6_2.voice = L7_2
    L6_2 = log
    L7_2 = "Player "
    L8_2 = L3_2
    L9_2 = " started transmission on "
    L10_2 = A0_2
    L11_2 = " at coords: "
    L12_2 = tostring
    L13_2 = L5_2
    L12_2 = L12_2(L13_2)
    L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2
    L8_2 = 4
    L6_2(L7_2, L8_2)
    L6_2 = nil
    if A2_2 then
      L7_2 = L0_1
      L7_2 = L7_2[L3_2]
      if L7_2 == A2_2 then
        L7_2 = NetworkGetEntityFromNetworkId
        L8_2 = A2_2
        L7_2 = L7_2(L8_2)
        L8_2 = DoesEntityExist
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if L8_2 then
          L8_2 = GetEntityCoords
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
          L6_2 = L8_2
          L8_2 = log
          L9_2 = "Player "
          L10_2 = L3_2
          L11_2 = " has owned vehicle at coords: "
          L12_2 = tostring
          L13_2 = L6_2
          L12_2 = L12_2(L13_2)
          L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
          L10_2 = 4
          L8_2(L9_2, L10_2)
        else
          L8_2 = L0_1
          L8_2[L3_2] = nil
          L8_2 = log
          L9_2 = "Vehicle entity for player "
          L10_2 = L3_2
          L11_2 = " no longer exists, removing ownership"
          L9_2 = L9_2 .. L10_2 .. L11_2
          L10_2 = 4
          L8_2(L9_2, L10_2)
        end
      end
    end
    L7_2 = GetNearbyPlayers
    L8_2 = L5_2
    L9_2 = 200
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = log
    L9_2 = "Found "
    L10_2 = #L7_2
    L11_2 = " nearby players for 3D voice from player "
    L12_2 = L3_2
    L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
    L10_2 = 4
    L8_2(L9_2, L10_2)
    L8_2 = L2_1
    L8_2 = L8_2[L3_2]
    if L8_2 then
      L8_2 = doesTableContain
      L9_2 = L7_2
      L10_2 = tonumber
      L11_2 = L3_2
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L10_2(L11_2)
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
      if not L8_2 then
        L8_2 = table
        L8_2 = L8_2.insert
        L9_2 = L7_2
        L10_2 = tonumber
        L11_2 = L3_2
        L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2 = L10_2(L11_2)
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
        L8_2 = log
        L9_2 = "Added source player "
        L10_2 = L3_2
        L11_2 = " to nearby players due to debug mode"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      end
    end
    L8_2 = ipairs
    L9_2 = L7_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      if L13_2 == L3_2 then
        L14_2 = L2_1
        L14_2 = L14_2[L3_2]
        if not L14_2 then
          goto lbl_144
        end
      end
      L14_2 = log
      L15_2 = "Sending 3D voice start to player "
      L16_2 = L13_2
      L17_2 = " from source "
      L18_2 = L3_2
      L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2
      L16_2 = 4
      L14_2(L15_2, L16_2)
      L14_2 = TriggerClientEvent
      L15_2 = "radio:receive3DVoiceStarted"
      L16_2 = L13_2
      L17_2 = L3_2
      L18_2 = A0_2
      L19_2 = A1_2
      L20_2 = L5_2
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2, L20_2)
      goto lbl_151
      ::lbl_144::
      L14_2 = log
      L15_2 = "Skipping 3D voice send to source player "
      L16_2 = L13_2
      L17_2 = " (debug disabled)"
      L15_2 = L15_2 .. L16_2 .. L17_2
      L16_2 = 4
      L14_2(L15_2, L16_2)
      ::lbl_151::
    end
    if L6_2 then
      L8_2 = L5_2 - L6_2
      L8_2 = #L8_2
      if L8_2 > 5 then
        L9_2 = GetNearbyPlayers
        L10_2 = L6_2
        L11_2 = 200
        L9_2 = L9_2(L10_2, L11_2)
        L10_2 = ipairs
        L11_2 = L9_2
        L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
        for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
          if L15_2 == L3_2 then
            L16_2 = L2_1
            L16_2 = L16_2[L3_2]
            if not L16_2 then
              goto lbl_185
            end
          end
          L16_2 = L3_2 + 100000
          L17_2 = TriggerClientEvent
          L18_2 = "radio:receive3DVoiceStarted"
          L19_2 = L15_2
          L20_2 = L16_2
          L21_2 = A0_2
          L22_2 = A1_2
          L23_2 = L6_2
          L17_2(L18_2, L19_2, L20_2, L21_2, L22_2, L23_2)
          ::lbl_185::
        end
        L10_2 = log
        L11_2 = "Also broadcasting 3D voice from vehicle location for "
        L12_2 = #L9_2
        L13_2 = " players"
        L11_2 = L11_2 .. L12_2 .. L13_2
        L12_2 = 4
        L10_2(L11_2, L12_2)
      end
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DVoiceStopped"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DVoiceStopped"
  function L14_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
    L3_2 = source
    L4_2 = GetPlayerPed
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = GetEntityCoords
    L6_2 = L4_2
    L5_2 = L5_2(L6_2)
    L6_2 = L1_1
    L6_2 = L6_2[L3_2]
    if L6_2 then
      L6_2 = L1_1
      L6_2 = L6_2[L3_2]
      L6_2.voice = nil
    end
    L6_2 = log
    L7_2 = "Player "
    L8_2 = L3_2
    L9_2 = " stopped transmission on "
    L10_2 = A0_2
    L11_2 = " at coords: "
    L12_2 = tostring
    L13_2 = L5_2
    L12_2 = L12_2(L13_2)
    L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2
    L8_2 = 4
    L6_2(L7_2, L8_2)
    L6_2 = nil
    if A2_2 then
      L7_2 = L0_1
      L7_2 = L7_2[L3_2]
      if L7_2 == A2_2 then
        L7_2 = NetworkGetEntityFromNetworkId
        L8_2 = A2_2
        L7_2 = L7_2(L8_2)
        L8_2 = DoesEntityExist
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if L8_2 then
          L8_2 = GetEntityCoords
          L9_2 = L7_2
          L8_2 = L8_2(L9_2)
          L6_2 = L8_2
        else
          L8_2 = L0_1
          L8_2[L3_2] = nil
          L8_2 = log
          L9_2 = "Vehicle entity for player "
          L10_2 = L3_2
          L11_2 = " no longer exists, removing ownership"
          L9_2 = L9_2 .. L10_2 .. L11_2
          L10_2 = 4
          L8_2(L9_2, L10_2)
        end
      end
    end
    L7_2 = GetNearbyPlayers
    L8_2 = L5_2
    L9_2 = 200
    L7_2 = L7_2(L8_2, L9_2)
    L8_2 = log
    L9_2 = "Found "
    L10_2 = #L7_2
    L11_2 = " nearby players for 3D voice stop from player "
    L12_2 = L3_2
    L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
    L10_2 = 4
    L8_2(L9_2, L10_2)
    L8_2 = L2_1
    L8_2 = L8_2[L3_2]
    if L8_2 then
      L8_2 = doesTableContain
      L9_2 = L7_2
      L10_2 = tonumber
      L11_2 = L3_2
      L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L10_2(L11_2)
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      if not L8_2 then
        L8_2 = table
        L8_2 = L8_2.insert
        L9_2 = L7_2
        L10_2 = tonumber
        L11_2 = L3_2
        L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L10_2(L11_2)
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
        L8_2 = log
        L9_2 = "Added source player "
        L10_2 = L3_2
        L11_2 = " to nearby players for voice stop due to debug mode"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      end
    end
    L8_2 = ipairs
    L9_2 = L7_2
    L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
    for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
      if L13_2 == L3_2 then
        L14_2 = L2_1
        L14_2 = L14_2[L3_2]
        if not L14_2 then
          goto lbl_120
        end
      end
      L14_2 = log
      L15_2 = "Sending 3D voice stop to player "
      L16_2 = L13_2
      L17_2 = " from source "
      L18_2 = L3_2
      L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2
      L16_2 = 4
      L14_2(L15_2, L16_2)
      L14_2 = TriggerClientEvent
      L15_2 = "radio:receive3DVoiceStopped"
      L16_2 = L13_2
      L17_2 = L3_2
      L18_2 = A0_2
      L19_2 = L5_2
      L14_2(L15_2, L16_2, L17_2, L18_2, L19_2)
      goto lbl_127
      ::lbl_120::
      L14_2 = log
      L15_2 = "Skipping 3D voice stop send to source player "
      L16_2 = L13_2
      L17_2 = " (debug disabled)"
      L15_2 = L15_2 .. L16_2 .. L17_2
      L16_2 = 4
      L14_2(L15_2, L16_2)
      ::lbl_127::
    end
    if L6_2 then
      L8_2 = GetNearbyPlayers
      L9_2 = L6_2
      L10_2 = 200
      L8_2 = L8_2(L9_2, L10_2)
      L9_2 = ipairs
      L10_2 = L8_2
      L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
      for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
        if L14_2 == L3_2 then
          L15_2 = L2_1
          L15_2 = L15_2[L3_2]
          if not L15_2 then
            goto lbl_155
          end
        end
        L15_2 = L3_2 + 100000
        L16_2 = TriggerClientEvent
        L17_2 = "radio:receive3DVoiceStopped"
        L18_2 = L14_2
        L19_2 = L15_2
        L20_2 = A0_2
        L21_2 = L5_2
        L16_2(L17_2, L18_2, L19_2, L20_2, L21_2)
        ::lbl_155::
      end
      L9_2 = log
      L10_2 = "Also stopping 3D voice from vehicle location for "
      L11_2 = #L8_2
      L12_2 = " players"
      L10_2 = L10_2 .. L11_2 .. L12_2
      L11_2 = 4
      L9_2(L10_2, L11_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DSirenStarted"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DSirenStarted"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
    L1_2 = source
    L2_2 = Config
    L2_2 = L2_2.playTransmissionEffects
    if not L2_2 then
      return
    end
    L2_2 = GetPlayerPed
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = DoesEntityExist
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      return
    end
    L3_2 = GetEntityCoords
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    if not L4_2 then
      L4_2 = L1_1
      L5_2 = {}
      L4_2[L1_2] = L5_2
    end
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    L5_2 = {}
    L5_2.type = "siren"
    L6_2 = GetGameTimer
    L6_2 = L6_2()
    L5_2.startTime = L6_2
    L5_2.coords = L3_2
    L5_2.vehicle = A0_2
    L4_2.siren = L5_2
    L4_2 = log
    L5_2 = "Player "
    L6_2 = L1_2
    L7_2 = " started siren at coords: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = nil
    if A0_2 then
      L5_2 = L0_1
      L5_2 = L5_2[L1_2]
      if L5_2 == A0_2 then
        L5_2 = NetworkGetEntityFromNetworkId
        L6_2 = A0_2
        L5_2 = L5_2(L6_2)
        L6_2 = DoesEntityExist
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = GetEntityCoords
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          L4_2 = L6_2
        else
          L6_2 = L0_1
          L6_2[L1_2] = nil
          L6_2 = log
          L7_2 = "Vehicle entity for player "
          L8_2 = L1_2
          L9_2 = " no longer exists, removing ownership"
          L7_2 = L7_2 .. L8_2 .. L9_2
          L8_2 = 4
          L6_2(L7_2, L8_2)
        end
      end
    end
    L5_2 = GetNearbyPlayers
    L6_2 = L3_2
    L7_2 = 800
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = L2_1
    L6_2 = L6_2[L1_2]
    if L6_2 then
      L6_2 = doesTableContain
      L7_2 = L5_2
      L8_2 = tonumber
      L9_2 = L1_2
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L8_2(L9_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      if not L6_2 then
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L5_2
        L8_2 = tonumber
        L9_2 = L1_2
        L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L8_2(L9_2)
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      end
    end
    L6_2 = ipairs
    L7_2 = L5_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      if L11_2 == L1_2 then
        L12_2 = L2_1
        L12_2 = L12_2[L1_2]
        if not L12_2 then
          goto lbl_105
        end
      end
      L12_2 = TriggerClientEvent
      L13_2 = "radio:receive3DSirenStarted"
      L14_2 = L11_2
      L15_2 = L1_2
      L16_2 = L3_2
      L12_2(L13_2, L14_2, L15_2, L16_2)
      ::lbl_105::
    end
    if L4_2 then
      L6_2 = L3_2 - L4_2
      L6_2 = #L6_2
      if L6_2 > 5 then
        L7_2 = GetNearbyPlayers
        L8_2 = L4_2
        L9_2 = 800
        L7_2 = L7_2(L8_2, L9_2)
        L8_2 = ipairs
        L9_2 = L7_2
        L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
        for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
          if L13_2 == L1_2 then
            L14_2 = L2_1
            L14_2 = L14_2[L1_2]
            if not L14_2 then
              goto lbl_137
            end
          end
          L14_2 = L1_2 + 100000
          L15_2 = TriggerClientEvent
          L16_2 = "radio:receive3DSirenStarted"
          L17_2 = L13_2
          L18_2 = L14_2
          L19_2 = L4_2
          L15_2(L16_2, L17_2, L18_2, L19_2)
          ::lbl_137::
        end
        L8_2 = log
        L9_2 = "Also broadcasting 3D siren from vehicle location for "
        L10_2 = #L7_2
        L11_2 = " players"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      end
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DSirenStopped"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DSirenStopped"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
    L1_2 = source
    L2_2 = GetPlayerPed
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = DoesEntityExist
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    if not L3_2 then
      return
    end
    L3_2 = GetEntityCoords
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    if L4_2 then
      L4_2 = L1_1
      L4_2 = L4_2[L1_2]
      L4_2.siren = nil
    end
    L4_2 = log
    L5_2 = "Player "
    L6_2 = L1_2
    L7_2 = " stopped siren at coords: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = nil
    if A0_2 then
      L5_2 = L0_1
      L5_2 = L5_2[L1_2]
      if L5_2 == A0_2 then
        L5_2 = NetworkGetEntityFromNetworkId
        L6_2 = A0_2
        L5_2 = L5_2(L6_2)
        L6_2 = DoesEntityExist
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = GetEntityCoords
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          L4_2 = L6_2
        else
          L6_2 = L0_1
          L6_2[L1_2] = nil
          L6_2 = log
          L7_2 = "Vehicle entity for player "
          L8_2 = L1_2
          L9_2 = " no longer exists, removing ownership"
          L7_2 = L7_2 .. L8_2 .. L9_2
          L8_2 = 4
          L6_2(L7_2, L8_2)
        end
      end
    end
    L5_2 = GetNearbyPlayers
    L6_2 = L3_2
    L7_2 = 800
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = L2_1
    L6_2 = L6_2[L1_2]
    if L6_2 then
      L6_2 = doesTableContain
      L7_2 = L5_2
      L8_2 = tonumber
      L9_2 = L1_2
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L8_2(L9_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      if not L6_2 then
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L5_2
        L8_2 = tonumber
        L9_2 = L1_2
        L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L8_2(L9_2)
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      end
    end
    L6_2 = ipairs
    L7_2 = L5_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      if L11_2 == L1_2 then
        L12_2 = L2_1
        L12_2 = L12_2[L1_2]
        if not L12_2 then
          goto lbl_93
        end
      end
      L12_2 = TriggerClientEvent
      L13_2 = "radio:receive3DSirenStopped"
      L14_2 = L11_2
      L15_2 = L1_2
      L16_2 = L3_2
      L12_2(L13_2, L14_2, L15_2, L16_2)
      ::lbl_93::
    end
    if L4_2 then
      L6_2 = GetNearbyPlayers
      L7_2 = L4_2
      L8_2 = 800
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = ipairs
      L8_2 = L6_2
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        if L12_2 == L1_2 then
          L13_2 = L2_1
          L13_2 = L13_2[L1_2]
          if not L13_2 then
            goto lbl_120
          end
        end
        L13_2 = L1_2 + 100000
        L14_2 = TriggerClientEvent
        L15_2 = "radio:receive3DSirenStopped"
        L16_2 = L12_2
        L17_2 = L13_2
        L18_2 = L3_2
        L14_2(L15_2, L16_2, L17_2, L18_2)
        ::lbl_120::
      end
      L7_2 = log
      L8_2 = "Also stopping 3D siren from vehicle location for "
      L9_2 = #L6_2
      L10_2 = " players"
      L8_2 = L8_2 .. L9_2 .. L10_2
      L9_2 = 4
      L7_2(L8_2, L9_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DHeliStarted"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DHeliStarted"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
    L1_2 = source
    L2_2 = Config
    L2_2 = L2_2.playTransmissionEffects
    if not L2_2 then
      return
    end
    L2_2 = log
    L3_2 = "3D Helicopter event received from player "
    L4_2 = L1_2
    L3_2 = L3_2 .. L4_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = GetPlayerPed
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = GetEntityCoords
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = log
    L5_2 = "Player "
    L6_2 = L1_2
    L7_2 = " coords: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    if not L4_2 then
      L4_2 = L1_1
      L5_2 = {}
      L4_2[L1_2] = L5_2
    end
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    L5_2 = {}
    L5_2.type = "heli"
    L6_2 = GetGameTimer
    L6_2 = L6_2()
    L5_2.startTime = L6_2
    L5_2.coords = L3_2
    L5_2.vehicle = A0_2
    L4_2.heli = L5_2
    L4_2 = log
    L5_2 = "Player "
    L6_2 = L1_2
    L7_2 = " started heli at coords: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = nil
    if A0_2 then
      L5_2 = L0_1
      L5_2 = L5_2[L1_2]
      if L5_2 == A0_2 then
        L5_2 = NetworkGetEntityFromNetworkId
        L6_2 = A0_2
        L5_2 = L5_2(L6_2)
        L6_2 = DoesEntityExist
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = GetEntityCoords
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          L4_2 = L6_2
        else
          L6_2 = L0_1
          L6_2[L1_2] = nil
          L6_2 = log
          L7_2 = "Vehicle entity for player "
          L8_2 = L1_2
          L9_2 = " no longer exists, removing ownership"
          L7_2 = L7_2 .. L8_2 .. L9_2
          L8_2 = 4
          L6_2(L7_2, L8_2)
        end
      end
    end
    L5_2 = GetNearbyPlayers
    L6_2 = L3_2
    L7_2 = 1000
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = L2_1
    L6_2 = L6_2[L1_2]
    if L6_2 then
      L6_2 = doesTableContain
      L7_2 = L5_2
      L8_2 = tonumber
      L9_2 = L1_2
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L8_2(L9_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      if not L6_2 then
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L5_2
        L8_2 = tonumber
        L9_2 = L1_2
        L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L8_2(L9_2)
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
        L6_2 = log
        L7_2 = "Added source player "
        L8_2 = L1_2
        L9_2 = " to nearby players list for 3D heli (debug mode)"
        L7_2 = L7_2 .. L8_2 .. L9_2
        L8_2 = 4
        L6_2(L7_2, L8_2)
      end
    end
    L6_2 = log
    L7_2 = "Broadcasting 3D heli start to "
    L8_2 = #L5_2
    L9_2 = " players. Debug state for "
    L10_2 = L1_2
    L11_2 = ": "
    L12_2 = tostring
    L13_2 = L2_1
    L13_2 = L13_2[L1_2]
    L12_2 = L12_2(L13_2)
    L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2
    L8_2 = 4
    L6_2(L7_2, L8_2)
    L6_2 = ipairs
    L7_2 = L5_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      if L11_2 == L1_2 then
        L12_2 = L2_1
        L12_2 = L12_2[L1_2]
        if not L12_2 then
          goto lbl_149
        end
      end
      L12_2 = log
      L13_2 = "Sending 3D heli start to player "
      L14_2 = L11_2
      L15_2 = " from source "
      L16_2 = L1_2
      L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2
      L14_2 = 4
      L12_2(L13_2, L14_2)
      L12_2 = TriggerClientEvent
      L13_2 = "radio:receive3DHeliStarted"
      L14_2 = L11_2
      L15_2 = L1_2
      L16_2 = L3_2
      L12_2(L13_2, L14_2, L15_2, L16_2)
      ::lbl_149::
    end
    if L4_2 then
      L6_2 = L3_2 - L4_2
      L6_2 = #L6_2
      if L6_2 > 5 then
        L7_2 = GetNearbyPlayers
        L8_2 = L4_2
        L9_2 = 1000
        L7_2 = L7_2(L8_2, L9_2)
        L8_2 = ipairs
        L9_2 = L7_2
        L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
        for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
          if L13_2 == L1_2 then
            L14_2 = L2_1
            L14_2 = L14_2[L1_2]
            if not L14_2 then
              goto lbl_181
            end
          end
          L14_2 = L1_2 + 100000
          L15_2 = TriggerClientEvent
          L16_2 = "radio:receive3DHeliStarted"
          L17_2 = L13_2
          L18_2 = L14_2
          L19_2 = L4_2
          L15_2(L16_2, L17_2, L18_2, L19_2)
          ::lbl_181::
        end
        L8_2 = log
        L9_2 = "Also broadcasting 3D heli from vehicle location for "
        L10_2 = #L7_2
        L11_2 = " players"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      end
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DGunshot"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DGunshot"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
    L2_2 = source
    L3_2 = Config
    L3_2 = L3_2.playTransmissionEffects
    if not L3_2 then
      return
    end
    L3_2 = log
    L4_2 = "3D Gunshot event received from player "
    L5_2 = L2_2
    L6_2 = " with volume "
    L7_2 = A0_2
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = GetPlayerPed
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = DoesEntityExist
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if not L4_2 then
      return
    end
    L4_2 = GetEntityCoords
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    L5_2 = log
    L6_2 = "Player "
    L7_2 = L2_2
    L8_2 = " gunshot coords: "
    L9_2 = tostring
    L10_2 = L4_2
    L9_2 = L9_2(L10_2)
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
    L7_2 = 4
    L5_2(L6_2, L7_2)
    L5_2 = L1_1
    L5_2 = L5_2[L2_2]
    if not L5_2 then
      L5_2 = L1_1
      L6_2 = {}
      L5_2[L2_2] = L6_2
    end
    L5_2 = L1_1
    L5_2 = L5_2[L2_2]
    L6_2 = {}
    L6_2.type = "gunshot"
    L7_2 = GetGameTimer
    L7_2 = L7_2()
    L6_2.startTime = L7_2
    L6_2.coords = L4_2
    L6_2.vehicle = A1_2
    L6_2.volume = A0_2
    L5_2.gunshot = L6_2
    L5_2 = log
    L6_2 = "Player "
    L7_2 = L2_2
    L8_2 = " fired gunshot at coords: "
    L9_2 = tostring
    L10_2 = L4_2
    L9_2 = L9_2(L10_2)
    L10_2 = " with volume: "
    L11_2 = A0_2
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2
    L7_2 = 4
    L5_2(L6_2, L7_2)
    L5_2 = nil
    L6_2 = log
    L7_2 = "Checking vehicle for gunshot - vehicle: "
    L8_2 = tostring
    L9_2 = A1_2
    L8_2 = L8_2(L9_2)
    L9_2 = ", vehicleOwners[source]: "
    L10_2 = tostring
    L11_2 = L0_1
    L11_2 = L11_2[L2_2]
    L10_2 = L10_2(L11_2)
    L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2
    L8_2 = 4
    L6_2(L7_2, L8_2)
    if A1_2 then
      L6_2 = L0_1
      L6_2 = L6_2[L2_2]
      if L6_2 == A1_2 then
        L6_2 = NetworkGetEntityFromNetworkId
        L7_2 = A1_2
        L6_2 = L6_2(L7_2)
        L7_2 = DoesEntityExist
        L8_2 = L6_2
        L7_2 = L7_2(L8_2)
        if L7_2 then
          L7_2 = GetEntityCoords
          L8_2 = L6_2
          L7_2 = L7_2(L8_2)
          L5_2 = L7_2
          L7_2 = log
          L8_2 = "Vehicle exists for gunshot, coords: "
          L9_2 = tostring
          L10_2 = L5_2
          L9_2 = L9_2(L10_2)
          L8_2 = L8_2 .. L9_2
          L9_2 = 4
          L7_2(L8_2, L9_2)
        else
          L7_2 = L0_1
          L7_2[L2_2] = nil
          L7_2 = log
          L8_2 = "Vehicle entity for player "
          L9_2 = L2_2
          L10_2 = " no longer exists, removing ownership"
          L8_2 = L8_2 .. L9_2 .. L10_2
          L9_2 = 4
          L7_2(L8_2, L9_2)
        end
    end
    else
      L6_2 = log
      L7_2 = "No vehicle or ownership mismatch for gunshot"
      L8_2 = 4
      L6_2(L7_2, L8_2)
    end
    L6_2 = GetNearbyPlayers
    L7_2 = L4_2
    L8_2 = 300
    L6_2 = L6_2(L7_2, L8_2)
    L7_2 = L2_1
    L7_2 = L7_2[L2_2]
    if L7_2 then
      L7_2 = doesTableContain
      L8_2 = L6_2
      L9_2 = tonumber
      L10_2 = L2_2
      L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L9_2(L10_2)
      L7_2 = L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      if not L7_2 then
        L7_2 = table
        L7_2 = L7_2.insert
        L8_2 = L6_2
        L9_2 = tonumber
        L10_2 = L2_2
        L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L9_2(L10_2)
        L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
      end
    end
    L7_2 = ipairs
    L8_2 = L6_2
    L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
    for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
      if L12_2 == L2_2 then
        L13_2 = L2_1
        L13_2 = L13_2[L2_2]
        if not L13_2 then
          goto lbl_153
        end
      end
      L13_2 = TriggerClientEvent
      L14_2 = "radio:receive3DGunshot"
      L15_2 = L12_2
      L16_2 = L2_2
      L17_2 = A0_2
      L18_2 = L4_2
      L13_2(L14_2, L15_2, L16_2, L17_2, L18_2)
      ::lbl_153::
    end
    if L5_2 then
      L7_2 = L4_2 - L5_2
      L7_2 = #L7_2
      L8_2 = log
      L9_2 = "Vehicle distance for gunshot: "
      L10_2 = L7_2
      L11_2 = " (threshold: 5), debug enabled: "
      L12_2 = tostring
      L13_2 = L2_1
      L13_2 = L13_2[L2_2]
      L12_2 = L12_2(L13_2)
      L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
      L10_2 = 4
      L8_2(L9_2, L10_2)
      if L7_2 > 5 then
        L8_2 = GetNearbyPlayers
        L9_2 = L5_2
        L10_2 = 300
        L8_2 = L8_2(L9_2, L10_2)
        L9_2 = log
        L10_2 = "Found "
        L11_2 = #L8_2
        L12_2 = " nearby players at vehicle location for gunshot"
        L10_2 = L10_2 .. L11_2 .. L12_2
        L11_2 = 4
        L9_2(L10_2, L11_2)
        L9_2 = ipairs
        L10_2 = L8_2
        L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
        for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
          if L14_2 == L2_2 then
            L15_2 = L2_1
            L15_2 = L15_2[L2_2]
            if not L15_2 then
              goto lbl_204
            end
          end
          L15_2 = L2_2 + 100000
          L16_2 = TriggerClientEvent
          L17_2 = "radio:receive3DGunshot"
          L18_2 = L14_2
          L19_2 = L15_2
          L20_2 = A0_2
          L21_2 = L5_2
          L16_2(L17_2, L18_2, L19_2, L20_2, L21_2)
          ::lbl_204::
        end
        L9_2 = log
        L10_2 = "Also broadcasting 3D gunshot from vehicle location for "
        L11_2 = #L8_2
        L12_2 = " players"
        L10_2 = L10_2 .. L11_2 .. L12_2
        L11_2 = 4
        L9_2(L10_2, L11_2)
      else
        L8_2 = log
        L9_2 = "Vehicle too close to player ("
        L10_2 = L7_2
        L11_2 = " <= 10) and debug not enabled, not sending vehicle gunshot"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      end
    else
      L7_2 = log
      L8_2 = "No vehicle coordinates available for gunshot"
      L9_2 = 4
      L7_2(L8_2, L9_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DHeliStopped"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DHeliStopped"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
    L1_2 = source
    L2_2 = GetPlayerPed
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = GetEntityCoords
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    if L4_2 then
      L4_2 = L1_1
      L4_2 = L4_2[L1_2]
      L4_2.heli = nil
    end
    L4_2 = log
    L5_2 = "Player "
    L6_2 = L1_2
    L7_2 = " stopped heli at coords: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = nil
    L5_2 = log
    L6_2 = "Checking vehicle for heli stop - vehicle: "
    L7_2 = tostring
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = ", vehicleOwners[source]: "
    L9_2 = tostring
    L10_2 = L0_1
    L10_2 = L10_2[L1_2]
    L9_2 = L9_2(L10_2)
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
    L7_2 = 4
    L5_2(L6_2, L7_2)
    if A0_2 then
      L5_2 = L0_1
      L5_2 = L5_2[L1_2]
      if L5_2 == A0_2 then
        L5_2 = NetworkGetEntityFromNetworkId
        L6_2 = A0_2
        L5_2 = L5_2(L6_2)
        L6_2 = DoesEntityExist
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = GetEntityCoords
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          L4_2 = L6_2
          L6_2 = log
          L7_2 = "Vehicle exists, coords: "
          L8_2 = tostring
          L9_2 = L4_2
          L8_2 = L8_2(L9_2)
          L7_2 = L7_2 .. L8_2
          L8_2 = 5
          L6_2(L7_2, L8_2)
        else
          L6_2 = L0_1
          L6_2[L1_2] = nil
          L6_2 = log
          L7_2 = "Vehicle entity for player "
          L8_2 = L1_2
          L9_2 = " no longer exists, removing ownership"
          L7_2 = L7_2 .. L8_2 .. L9_2
          L8_2 = 4
          L6_2(L7_2, L8_2)
        end
    end
    else
      L5_2 = log
      L6_2 = "No vehicle or ownership mismatch for heli stop"
      L7_2 = 4
      L5_2(L6_2, L7_2)
    end
    L5_2 = GetNearbyPlayers
    L6_2 = L3_2
    L7_2 = 1000
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = L2_1
    L6_2 = L6_2[L1_2]
    if L6_2 then
      L6_2 = doesTableContain
      L7_2 = L5_2
      L8_2 = tonumber
      L9_2 = L1_2
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L8_2(L9_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      if not L6_2 then
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L5_2
        L8_2 = tonumber
        L9_2 = L1_2
        L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L8_2(L9_2)
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      end
    end
    L6_2 = ipairs
    L7_2 = L5_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      if L11_2 == L1_2 then
        L12_2 = L2_1
        L12_2 = L12_2[L1_2]
        if not L12_2 then
          goto lbl_119
        end
      end
      L12_2 = TriggerClientEvent
      L13_2 = "radio:receive3DHeliStopped"
      L14_2 = L11_2
      L15_2 = L1_2
      L16_2 = L3_2
      L12_2(L13_2, L14_2, L15_2, L16_2)
      ::lbl_119::
    end
    if L4_2 then
      L6_2 = GetNearbyPlayers
      L7_2 = L4_2
      L8_2 = 1000
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = ipairs
      L8_2 = L6_2
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        if L12_2 == L1_2 then
          L13_2 = L2_1
          L13_2 = L13_2[L1_2]
          if not L13_2 then
            goto lbl_146
          end
        end
        L13_2 = L1_2 + 100000
        L14_2 = TriggerClientEvent
        L15_2 = "radio:receive3DHeliStopped"
        L16_2 = L12_2
        L17_2 = L13_2
        L18_2 = L3_2
        L14_2(L15_2, L16_2, L17_2, L18_2)
        ::lbl_146::
      end
      L7_2 = log
      L8_2 = "Also stopping 3D heli from vehicle location for "
      L9_2 = #L6_2
      L10_2 = " players"
      L8_2 = L8_2 .. L9_2 .. L10_2
      L9_2 = 4
      L7_2(L8_2, L9_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DTransmissionStarted"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DTransmissionStarted"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
    L1_2 = source
    L2_2 = GetPlayerPed
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = log
    L4_2 = "Server received 3DTransmissionStarted from player "
    L5_2 = L1_2
    L6_2 = " with vehicle: "
    L7_2 = tostring
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = GetEntityCoords
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    if not L4_2 then
      L4_2 = L1_1
      L5_2 = {}
      L4_2[L1_2] = L5_2
    end
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    L5_2 = {}
    L5_2.type = "transmission"
    L6_2 = GetGameTimer
    L6_2 = L6_2()
    L5_2.startTime = L6_2
    L5_2.coords = L3_2
    L5_2.vehicle = A0_2
    L4_2.transmission = L5_2
    L4_2 = log
    L5_2 = "Player "
    L6_2 = L1_2
    L7_2 = " started transmission at coords: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = nil
    L5_2 = log
    L6_2 = "Vehicle ownership check - vehicle: "
    L7_2 = tostring
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = ", vehicleOwners[source]: "
    L9_2 = tostring
    L10_2 = L0_1
    L10_2 = L10_2[L1_2]
    L9_2 = L9_2(L10_2)
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
    L7_2 = 4
    L5_2(L6_2, L7_2)
    if A0_2 then
      L5_2 = L0_1
      L5_2 = L5_2[L1_2]
      if L5_2 == A0_2 then
        L5_2 = log
        L6_2 = "Vehicle ownership matched, getting entity from network ID: "
        L7_2 = A0_2
        L6_2 = L6_2 .. L7_2
        L7_2 = 4
        L5_2(L6_2, L7_2)
        L5_2 = NetworkGetEntityFromNetworkId
        L6_2 = A0_2
        L5_2 = L5_2(L6_2)
        L6_2 = log
        L7_2 = "Vehicle entity: "
        L8_2 = tostring
        L9_2 = L5_2
        L8_2 = L8_2(L9_2)
        L9_2 = ", exists: "
        L10_2 = tostring
        L11_2 = DoesEntityExist
        L12_2 = L5_2
        L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L11_2(L12_2)
        L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
        L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2
        L8_2 = 4
        L6_2(L7_2, L8_2)
        L6_2 = DoesEntityExist
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = GetEntityCoords
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          L4_2 = L6_2
          L6_2 = log
          L7_2 = "Got vehicle coords: "
          L8_2 = tostring
          L9_2 = L4_2
          L8_2 = L8_2(L9_2)
          L7_2 = L7_2 .. L8_2
          L8_2 = 4
          L6_2(L7_2, L8_2)
        else
          L6_2 = L0_1
          L6_2[L1_2] = nil
          L6_2 = log
          L7_2 = "Vehicle entity for player "
          L8_2 = L1_2
          L9_2 = " no longer exists, removing ownership"
          L7_2 = L7_2 .. L8_2 .. L9_2
          L8_2 = 4
          L6_2(L7_2, L8_2)
        end
    end
    else
      L5_2 = log
      L6_2 = "Vehicle ownership mismatch or no vehicle - skipping vehicle coords"
      L7_2 = 4
      L5_2(L6_2, L7_2)
    end
    L5_2 = GetNearbyPlayers
    L6_2 = L3_2
    L7_2 = 150
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = L2_1
    L6_2 = L6_2[L1_2]
    if L6_2 then
      L6_2 = doesTableContain
      L7_2 = L5_2
      L8_2 = tonumber
      L9_2 = L1_2
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L8_2(L9_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      if not L6_2 then
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L5_2
        L8_2 = tonumber
        L9_2 = L1_2
        L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2 = L8_2(L9_2)
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
      end
    end
    L6_2 = ipairs
    L7_2 = L5_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      if L11_2 == L1_2 then
        L12_2 = L2_1
        L12_2 = L12_2[L1_2]
        if not L12_2 then
          goto lbl_161
        end
      end
      L12_2 = TriggerClientEvent
      L13_2 = "radio:receive3DTransmissionStarted"
      L14_2 = L11_2
      L15_2 = L1_2
      L16_2 = L3_2
      L12_2(L13_2, L14_2, L15_2, L16_2)
      ::lbl_161::
    end
    if L4_2 then
      L6_2 = L3_2 - L4_2
      L6_2 = #L6_2
      L7_2 = log
      L8_2 = "Vehicle transmission check - distance: "
      L9_2 = L6_2
      L10_2 = ", debug enabled: "
      L11_2 = tostring
      L12_2 = L2_1
      L12_2 = L12_2[L1_2]
      L11_2 = L11_2(L12_2)
      L8_2 = L8_2 .. L9_2 .. L10_2 .. L11_2
      L9_2 = 4
      L7_2(L8_2, L9_2)
      if L6_2 > 5 then
        L7_2 = GetNearbyPlayers
        L8_2 = L4_2
        L9_2 = 150
        L7_2 = L7_2(L8_2, L9_2)
        L8_2 = log
        L9_2 = "Found "
        L10_2 = #L7_2
        L11_2 = " nearby players for vehicle transmission"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
        L8_2 = ipairs
        L9_2 = L7_2
        L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
        for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
          if L13_2 == L1_2 then
            L14_2 = L2_1
            L14_2 = L14_2[L1_2]
            if not L14_2 then
              goto lbl_219
            end
          end
          L14_2 = L1_2 + 100000
          L15_2 = log
          L16_2 = "Sending vehicle transmission start to player "
          L17_2 = L13_2
          L18_2 = " with vehicleSourceId "
          L19_2 = L14_2
          L16_2 = L16_2 .. L17_2 .. L18_2 .. L19_2
          L17_2 = 4
          L15_2(L16_2, L17_2)
          L15_2 = TriggerClientEvent
          L16_2 = "radio:receive3DTransmissionStarted"
          L17_2 = L13_2
          L18_2 = L14_2
          L19_2 = L4_2
          L15_2(L16_2, L17_2, L18_2, L19_2)
          ::lbl_219::
        end
        L8_2 = log
        L9_2 = "Also broadcasting 3D transmission from vehicle location for "
        L10_2 = #L7_2
        L11_2 = " players"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      else
        L7_2 = log
        L8_2 = "Vehicle transmission skipped - distance: "
        L9_2 = L6_2
        L10_2 = " <= 5 and debug disabled"
        L8_2 = L8_2 .. L9_2 .. L10_2
        L9_2 = 4
        L7_2(L8_2, L9_2)
      end
    else
      L6_2 = log
      L7_2 = "No vehicle coords available for transmission"
      L8_2 = 4
      L6_2(L7_2, L8_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:3DTransmissionStopped"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:3DTransmissionStopped"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
    L1_2 = source
    L2_2 = GetPlayerPed
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = log
    L4_2 = "Server received 3DTransmissionStopped from player "
    L5_2 = L1_2
    L6_2 = " with vehicle: "
    L7_2 = tostring
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = GetEntityCoords
    L4_2 = L2_2
    L3_2 = L3_2(L4_2)
    L4_2 = L1_1
    L4_2 = L4_2[L1_2]
    if L4_2 then
      L4_2 = L1_1
      L4_2 = L4_2[L1_2]
      L4_2.transmission = nil
    end
    L4_2 = log
    L5_2 = "Player "
    L6_2 = L1_2
    L7_2 = " stopped transmission at coords: "
    L8_2 = tostring
    L9_2 = L3_2
    L8_2 = L8_2(L9_2)
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = nil
    if A0_2 then
      L5_2 = L0_1
      L5_2 = L5_2[L1_2]
      if L5_2 == A0_2 then
        L5_2 = NetworkGetEntityFromNetworkId
        L6_2 = A0_2
        L5_2 = L5_2(L6_2)
        L6_2 = DoesEntityExist
        L7_2 = L5_2
        L6_2 = L6_2(L7_2)
        if L6_2 then
          L6_2 = GetEntityCoords
          L7_2 = L5_2
          L6_2 = L6_2(L7_2)
          L4_2 = L6_2
        else
          L6_2 = L0_1
          L6_2[L1_2] = nil
          L6_2 = log
          L7_2 = "Vehicle entity for player "
          L8_2 = L1_2
          L9_2 = " no longer exists, removing ownership"
          L7_2 = L7_2 .. L8_2 .. L9_2
          L8_2 = 4
          L6_2(L7_2, L8_2)
        end
      end
    end
    L5_2 = GetNearbyPlayers
    L6_2 = L3_2
    L7_2 = 150
    L5_2 = L5_2(L6_2, L7_2)
    L6_2 = L2_1
    L6_2 = L6_2[L1_2]
    if L6_2 then
      L6_2 = doesTableContain
      L7_2 = L5_2
      L8_2 = tonumber
      L9_2 = L1_2
      L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L8_2(L9_2)
      L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      if not L6_2 then
        L6_2 = table
        L6_2 = L6_2.insert
        L7_2 = L5_2
        L8_2 = tonumber
        L9_2 = L1_2
        L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L8_2(L9_2)
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
      end
    end
    L6_2 = ipairs
    L7_2 = L5_2
    L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
    for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
      if L11_2 ~= L1_2 then
        L12_2 = TriggerClientEvent
        L13_2 = "radio:receive3DTransmissionStopped"
        L14_2 = L11_2
        L15_2 = L1_2
        L16_2 = L3_2
        L12_2(L13_2, L14_2, L15_2, L16_2)
      end
    end
    if L4_2 then
      L6_2 = GetNearbyPlayers
      L7_2 = L4_2
      L8_2 = 150
      L6_2 = L6_2(L7_2, L8_2)
      L7_2 = ipairs
      L8_2 = L6_2
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        if L12_2 ~= L1_2 then
          L13_2 = L1_2 + 100000
          L14_2 = log
          L15_2 = "Sending vehicle transmission stop to player "
          L16_2 = L12_2
          L17_2 = " with vehicleSourceId "
          L18_2 = L13_2
          L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2
          L16_2 = 4
          L14_2(L15_2, L16_2)
          L14_2 = TriggerClientEvent
          L15_2 = "radio:receive3DTransmissionStopped"
          L16_2 = L12_2
          L17_2 = L13_2
          L18_2 = L3_2
          L14_2(L15_2, L16_2, L17_2, L18_2)
        end
      end
      L7_2 = log
      L8_2 = "Also stopping 3D transmission from vehicle location for "
      L9_2 = #L6_2
      L10_2 = " players"
      L8_2 = L8_2 .. L9_2 .. L10_2
      L9_2 = 4
      L7_2(L8_2, L9_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:checkVehicleOwnership"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:checkVehicleOwnership"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
    L2_2 = source
    L3_2 = NetworkGetEntityFromNetworkId
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = DoesEntityExist
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if L4_2 then
      if A1_2 then
        L4_2 = pairs
        L5_2 = L0_1
        L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
        for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
          if L9_2 == A0_2 and L8_2 ~= L2_2 then
            L10_2 = L0_1
            L10_2[L8_2] = nil
            L10_2 = log
            L11_2 = "Transferred vehicle "
            L12_2 = A0_2
            L13_2 = " ownership from player "
            L14_2 = L8_2
            L15_2 = " to player "
            L16_2 = L2_2
            L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2 .. L16_2
            L12_2 = 4
            L10_2(L11_2, L12_2)
          end
        end
        L4_2 = L0_1
        L4_2[L2_2] = A0_2
        L4_2 = log
        L5_2 = "Player "
        L6_2 = L2_2
        L7_2 = " claimed ownership of vehicle "
        L8_2 = A0_2
        L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
        L6_2 = 4
        L4_2(L5_2, L6_2)
        L4_2 = TriggerClientEvent
        L5_2 = "radio:syncVehicleOwnership"
        L6_2 = -1
        L7_2 = L2_2
        L8_2 = A0_2
        L4_2(L5_2, L6_2, L7_2, L8_2)
      else
        L4_2 = log
        L5_2 = "Player "
        L6_2 = L2_2
        L7_2 = " attempted to claim vehicle "
        L8_2 = A0_2
        L9_2 = " but radio is not powered on"
        L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2
        L6_2 = 4
        L4_2(L5_2, L6_2)
      end
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:releaseVehicle"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:releaseVehicle"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    L1_2 = source
    L2_2 = L0_1
    L2_2 = L2_2[L1_2]
    if L2_2 == A0_2 then
      L2_2 = L0_1
      L2_2[L1_2] = nil
      L2_2 = log
      L3_2 = "Player "
      L4_2 = L1_2
      L5_2 = " released ownership of vehicle "
      L6_2 = A0_2
      L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
      L4_2 = 5
      L2_2(L3_2, L4_2)
      L2_2 = L1_2 + 100000
      L3_2 = L3_1
      L3_2 = L3_2[L1_2]
      L3_2 = nil ~= L3_2
      L4_2 = nil
      if L3_2 then
        L5_2 = L3_1
        L5_2 = L5_2[L1_2]
        L6_2 = L5_2.trunkedFreq
        L4_2 = L6_2 or L4_2
        if not L6_2 then
          L4_2 = L5_2.frequency
        end
      end
      L5_2 = GetGameTimer
      L5_2 = L5_2()
      L6_2 = "vehicle_"
      L7_2 = L2_2
      L6_2 = L6_2 .. L7_2
      L7_2 = true
      if L7_2 and not L3_2 then
        L8_2 = TriggerClientEvent
        L9_2 = "radio:forceVoiceStopped"
        L10_2 = -1
        L11_2 = L2_2
        L12_2 = L4_2
        L8_2(L9_2, L10_2, L11_2, L12_2)
        L8_2 = log
        L9_2 = "Cleaned up voice for vehicle source "
        L10_2 = L2_2
        L11_2 = " (player not talking)"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      elseif L3_2 then
        L8_2 = log
        L9_2 = "Skipped voice cleanup for vehicle source "
        L10_2 = L2_2
        L11_2 = " (player is talking on frequency "
        L12_2 = L4_2
        L13_2 = ")"
        L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
      end
      L8_2 = TriggerClientEvent
      L9_2 = "radio:forceSirenStopped"
      L10_2 = -1
      L11_2 = L2_2
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = TriggerClientEvent
      L9_2 = "radio:forceHeliStopped"
      L10_2 = -1
      L11_2 = L2_2
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = TriggerClientEvent
      L9_2 = "radio:vehicleReleased"
      L10_2 = -1
      L11_2 = A0_2
      L8_2(L9_2, L10_2, L11_2)
      L8_2 = TriggerClientEvent
      L9_2 = "radio:syncVehicleOwnership"
      L10_2 = -1
      L11_2 = L1_2
      L12_2 = nil
      L8_2(L9_2, L10_2, L11_2, L12_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = AddEventHandler
  L13_1 = "playerDropped"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    L1_2 = source
    L2_2 = L0_1
    L2_2 = L2_2[L1_2]
    if L2_2 then
      L2_2 = L0_1
      L2_2 = L2_2[L1_2]
      L3_2 = L0_1
      L3_2[L1_2] = nil
      L3_2 = log
      L4_2 = "Cleaned up vehicle ownership for disconnected player "
      L5_2 = L1_2
      L6_2 = " (vehicle: "
      L7_2 = L2_2
      L8_2 = ")"
      L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2
      L5_2 = 4
      L3_2(L4_2, L5_2)
      L3_2 = TriggerClientEvent
      L4_2 = "radio:vehicleReleased"
      L5_2 = -1
      L6_2 = L2_2
      L3_2(L4_2, L5_2, L6_2)
      L3_2 = TriggerClientEvent
      L4_2 = "radio:syncVehicleOwnership"
      L5_2 = -1
      L6_2 = L1_2
      L7_2 = nil
      L3_2(L4_2, L5_2, L6_2, L7_2)
    end
    L2_2 = L1_1
    L2_2 = L2_2[L1_2]
    if L2_2 then
      L2_2 = pairs
      L3_2 = L1_1
      L3_2 = L3_2[L1_2]
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = log
        L9_2 = "Cleaning up orphaned "
        L10_2 = L6_2
        L11_2 = " event for disconnected player "
        L12_2 = L1_2
        L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
        if "voice" == L6_2 then
          L8_2 = TriggerClientEvent
          L9_2 = "radio:forceVoiceStopped"
          L10_2 = -1
          L11_2 = L1_2
          L12_2 = L7_2.frequency
          L8_2(L9_2, L10_2, L11_2, L12_2)
        elseif "siren" == L6_2 then
          L8_2 = TriggerClientEvent
          L9_2 = "radio:forceSirenStopped"
          L10_2 = -1
          L11_2 = L1_2
          L8_2(L9_2, L10_2, L11_2)
        elseif "heli" == L6_2 then
          L8_2 = TriggerClientEvent
          L9_2 = "radio:forceHeliStopped"
          L10_2 = -1
          L11_2 = L1_2
          L8_2(L9_2, L10_2, L11_2)
        elseif "transmission" == L6_2 then
          L8_2 = TriggerClientEvent
          L9_2 = "radio:forceTransmissionStopped"
          L10_2 = -1
          L11_2 = L1_2
          L8_2(L9_2, L10_2, L11_2)
        elseif "gunshot" == L6_2 then
          L8_2 = log
          L9_2 = "Cleaning up gunshot event for disconnected player "
          L10_2 = L1_2
          L9_2 = L9_2 .. L10_2
          L10_2 = 4
          L8_2(L9_2, L10_2)
        end
      end
      L2_2 = L1_1
      L2_2[L1_2] = nil
      L2_2 = log
      L3_2 = "Cleaned up all audio events for disconnected player "
      L4_2 = L1_2
      L3_2 = L3_2 .. L4_2
      L4_2 = 4
      L2_2(L3_2, L4_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = Citizen
  L12_1 = L12_1.CreateThread
  function L13_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2, L23_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 30000
      L0_2(L1_2)
      L0_2 = GetGameTimer
      L0_2 = L0_2()
      L1_2 = 0
      L2_2 = pairs
      L3_2 = L1_1
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = GetPlayerName
        L9_2 = L6_2
        L8_2 = L8_2(L9_2)
        if not L8_2 then
          L9_2 = pairs
          L10_2 = L7_2
          L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
          for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
            L15_2 = log
            L16_2 = "Cleaning up stale "
            L17_2 = L13_2
            L18_2 = " event for non-existent player "
            L19_2 = L6_2
            L16_2 = L16_2 .. L17_2 .. L18_2 .. L19_2
            L17_2 = 2
            L15_2(L16_2, L17_2)
            if "voice" == L13_2 then
              L15_2 = L3_1
              L15_2 = L15_2[L6_2]
              L15_2 = nil ~= L15_2
              if not L15_2 then
                L16_2 = TriggerClientEvent
                L17_2 = "radio:forceVoiceStopped"
                L18_2 = -1
                L19_2 = L6_2
                L20_2 = L14_2.frequency
                L16_2(L17_2, L18_2, L19_2, L20_2)
                L16_2 = TriggerClientEvent
                L17_2 = "radio:forceVoiceStopped"
                L18_2 = -1
                L19_2 = L6_2 + 100000
                L20_2 = L14_2.frequency
                L16_2(L17_2, L18_2, L19_2, L20_2)
              else
                L16_2 = log
                L17_2 = "Skipped cleanup for active talker "
                L18_2 = L6_2
                L19_2 = " on frequency "
                L20_2 = tostring
                L21_2 = L14_2.frequency
                L20_2 = L20_2(L21_2)
                L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2
                L18_2 = 4
                L16_2(L17_2, L18_2)
              end
            elseif "siren" == L13_2 then
              L15_2 = TriggerClientEvent
              L16_2 = "radio:forceSirenStopped"
              L17_2 = -1
              L18_2 = L6_2
              L15_2(L16_2, L17_2, L18_2)
              L15_2 = TriggerClientEvent
              L16_2 = "radio:forceSirenStopped"
              L17_2 = -1
              L18_2 = L6_2 + 100000
              L15_2(L16_2, L17_2, L18_2)
            elseif "heli" == L13_2 then
              L15_2 = TriggerClientEvent
              L16_2 = "radio:forceHeliStopped"
              L17_2 = -1
              L18_2 = L6_2
              L15_2(L16_2, L17_2, L18_2)
              L15_2 = TriggerClientEvent
              L16_2 = "radio:forceHeliStopped"
              L17_2 = -1
              L18_2 = L6_2 + 100000
              L15_2(L16_2, L17_2, L18_2)
            elseif "transmission" == L13_2 then
              L15_2 = TriggerClientEvent
              L16_2 = "radio:forceTransmissionStopped"
              L17_2 = -1
              L18_2 = L6_2
              L15_2(L16_2, L17_2, L18_2)
              L15_2 = TriggerClientEvent
              L16_2 = "radio:forceTransmissionStopped"
              L17_2 = -1
              L18_2 = L6_2 + 100000
              L15_2(L16_2, L17_2, L18_2)
            elseif "gunshot" == L13_2 then
              L15_2 = log
              L16_2 = "Cleaning up stale gunshot event for player "
              L17_2 = L6_2
              L16_2 = L16_2 .. L17_2
              L17_2 = 4
              L15_2(L16_2, L17_2)
            end
            L1_2 = L1_2 + 1
          end
          L9_2 = L1_1
          L9_2[L6_2] = nil
        else
          L9_2 = pairs
          L10_2 = L7_2
          L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
          for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
            L15_2 = L14_2.startTime
            L15_2 = L0_2 - L15_2
            if "voice" == L13_2 then
              L16_2 = 120000
              if L15_2 > L16_2 then
                L16_2 = log
                L17_2 = "Cleaning up stale voice event for player "
                L18_2 = L6_2
                L19_2 = " (duration: "
                L20_2 = L15_2
                L21_2 = "ms)"
                L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2
                L18_2 = 4
                L16_2(L17_2, L18_2)
                L16_2 = L3_1
                L16_2 = L16_2[L6_2]
                L16_2 = nil ~= L16_2
                if not L16_2 then
                  L17_2 = TriggerClientEvent
                  L18_2 = "radio:forceVoiceStopped"
                  L19_2 = -1
                  L20_2 = L6_2
                  L21_2 = L14_2.frequency
                  L17_2(L18_2, L19_2, L20_2, L21_2)
                else
                  L17_2 = log
                  L18_2 = "Skipped stale cleanup for active talker "
                  L19_2 = L6_2
                  L18_2 = L18_2 .. L19_2
                  L19_2 = 4
                  L17_2(L18_2, L19_2)
                end
                L7_2[L13_2] = nil
                L1_2 = L1_2 + 1
              end
            end
            if "gunshot" == L13_2 then
              L16_2 = 5000
              if L15_2 > L16_2 then
                L16_2 = log
                L17_2 = "Cleaning up stale gunshot event for player "
                L18_2 = L6_2
                L19_2 = " (duration: "
                L20_2 = L15_2
                L21_2 = "ms)"
                L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2
                L18_2 = 4
                L16_2(L17_2, L18_2)
                L7_2[L13_2] = nil
                L1_2 = L1_2 + 1
            end
            else
              if "transmission" == L13_2 then
                L16_2 = 30000
                if L15_2 > L16_2 then
                  L16_2 = log
                  L17_2 = "Cleaning up stale transmission event for player "
                  L18_2 = L6_2
                  L19_2 = " (duration: "
                  L20_2 = L15_2
                  L21_2 = "ms)"
                  L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2
                  L18_2 = 4
                  L16_2(L17_2, L18_2)
                  L16_2 = TriggerClientEvent
                  L17_2 = "radio:forceTransmissionStopped"
                  L18_2 = -1
                  L19_2 = L6_2
                  L16_2(L17_2, L18_2, L19_2)
                  L7_2[L13_2] = nil
                  L1_2 = L1_2 + 1
              end
              elseif "siren" == L13_2 or "heli" == L13_2 then
                L16_2 = 600000
                if L15_2 > L16_2 then
                  L16_2 = log
                  L17_2 = "Cleaning up stale "
                  L18_2 = L13_2
                  L19_2 = " event for player "
                  L20_2 = L6_2
                  L21_2 = " (duration: "
                  L22_2 = L15_2
                  L23_2 = "ms)"
                  L17_2 = L17_2 .. L18_2 .. L19_2 .. L20_2 .. L21_2 .. L22_2 .. L23_2
                  L18_2 = 2
                  L16_2(L17_2, L18_2)
                  if "siren" == L13_2 then
                    L16_2 = TriggerClientEvent
                    L17_2 = "radio:forceSirenStopped"
                    L18_2 = -1
                    L19_2 = L6_2
                    L16_2(L17_2, L18_2, L19_2)
                  else
                    L16_2 = TriggerClientEvent
                    L17_2 = "radio:forceHeliStopped"
                    L18_2 = -1
                    L19_2 = L6_2
                    L16_2(L17_2, L18_2, L19_2)
                  end
                  L7_2[L13_2] = nil
                  L1_2 = L1_2 + 1
                end
              end
            end
          end
          L9_2 = next
          L10_2 = L7_2
          L9_2 = L9_2(L10_2)
          if nil == L9_2 then
            L9_2 = L1_1
            L9_2[L6_2] = nil
          end
        end
      end
      if L1_2 > 0 then
        L2_2 = log
        L3_2 = "Cleaned up "
        L4_2 = L1_2
        L5_2 = " stale audio events"
        L3_2 = L3_2 .. L4_2 .. L5_2
        L4_2 = 4
        L2_2(L3_2, L4_2)
      end
    end
  end
  L12_1(L13_1)
  L12_1 = exports
  L13_1 = "getAllChannels"
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
    L0_2 = IsDuplicityVersion
    L0_2 = L0_2()
    if not L0_2 then
      L0_2 = nil
      return L0_2
    end
    L0_2 = {}
    L1_2 = ipairs
    L2_2 = Config
    L2_2 = L2_2.zones
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = ipairs
      L8_2 = L6_2.Channels
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = table
        L13_2 = L13_2.insert
        L14_2 = L0_2
        L15_2 = {}
        L15_2.zoneId = L5_2
        L16_2 = L6_2.name
        L15_2.zoneName = L16_2
        L15_2.channelId = L11_2
        L16_2 = L12_2.name
        L15_2.name = L16_2
        L16_2 = L12_2.frequency
        L15_2.frequency = L16_2
        L16_2 = L12_2.type
        L15_2.type = L16_2
        L16_2 = L12_2.allowedNacs
        L15_2.allowedNacs = L16_2
        L16_2 = L12_2.frequencyRange
        L15_2.frequencyRange = L16_2
        L16_2 = L12_2.coverage
        L15_2.coverage = L16_2
        L13_2(L14_2, L15_2)
      end
    end
    return L0_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "getUsersInChannel"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = IsDuplicityVersion
    L1_2 = L1_2()
    if not L1_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = Radio
    L1_2 = L1_2.getClientsInChannel
    L2_2 = convertFreq
    L3_2 = A0_2
    L2_2, L3_2 = L2_2(L3_2)
    return L1_2(L2_2, L3_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "getChannelSignal"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = IsDuplicityVersion
    L1_2 = L1_2()
    if not L1_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = activeAlerts
    L2_2 = convertFreq
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L1_2 = L1_2[L2_2]
    L1_2 = nil ~= L1_2
    return L1_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "getChannelPanic"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = IsDuplicityVersion
    L1_2 = L1_2()
    if not L1_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = panicButtonChannels
    L2_2 = convertFreq
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L1_2 = L1_2[L2_2]
    if not L1_2 then
      L1_2 = {}
    end
    return L1_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "setChannelSignal"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L2_2 = IsDuplicityVersion
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = nil
      return L2_2
    end
    L2_2 = convertFreq
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = Config
    L3_2 = L3_2.alerts
    if L3_2 then
      L3_2 = Config
      L3_2 = L3_2.alerts
      L3_2 = L3_2[1]
    end
    L4_2 = TriggerEvent
    L5_2 = "radioServer:setAlertOnChannel"
    L6_2 = L2_2
    L7_2 = A1_2
    L8_2 = L3_2
    L4_2(L5_2, L6_2, L7_2, L8_2)
    L4_2 = true
    return L4_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "setChannelPanic"
  function L14_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2
    L3_2 = IsDuplicityVersion
    L3_2 = L3_2()
    if not L3_2 then
      L3_2 = nil
      return L3_2
    end
    L3_2 = TriggerEvent
    L4_2 = "radioServer:setPanicOnChannel"
    L5_2 = convertFreq
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    L6_2 = A2_2
    L7_2 = A1_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
    L3_2 = true
    return L3_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "changeUserChannel"
  function L14_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
    L2_2 = IsDuplicityVersion
    L2_2 = L2_2()
    if not L2_2 then
      L2_2 = nil
      return L2_2
    end
    L2_2 = nil
    L3_2 = ipairs
    L4_2 = Config
    L4_2 = L4_2.zones
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = ipairs
      L10_2 = L8_2.Channels
      L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
      for L13_2, L14_2 in L9_2, L10_2, L11_2, L12_2 do
        L15_2 = convertFreq
        L16_2 = L14_2.frequency
        L15_2 = L15_2(L16_2)
        L16_2 = convertFreq
        L17_2 = A1_2
        L16_2 = L16_2(L17_2)
        if L15_2 == L16_2 then
          L2_2 = L14_2
          break
        end
      end
      if L2_2 then
        break
      end
    end
    if L2_2 then
      L3_2 = L2_2.type
      if "trunked" == L3_2 then
        L3_2 = GetPlayerPed
        L4_2 = A0_2
        L3_2 = L3_2(L4_2)
        L4_2 = GetEntityCoords
        L5_2 = L3_2
        L4_2 = L4_2(L5_2)
        L5_2 = L9_1
        L6_2 = L4_2
        L7_2 = L2_2
        L5_2 = L5_2(L6_2, L7_2)
        L6_2 = Radio
        L6_2 = L6_2.setClientChannel
        L7_2 = A0_2
        L8_2 = convertFreq
        L9_2 = L5_2
        L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L8_2(L9_2)
        L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
        L6_2 = log
        L7_2 = "Export: Changed player "
        L8_2 = A0_2
        L9_2 = " to trunked frequency "
        L10_2 = L5_2
        L11_2 = " (control: "
        L12_2 = A1_2
        L13_2 = ")"
        L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
        L8_2 = 4
        L6_2(L7_2, L8_2)
    end
    else
      L3_2 = Radio
      L3_2 = L3_2.setClientChannel
      L4_2 = A0_2
      L5_2 = convertFreq
      L6_2 = A1_2
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L5_2(L6_2)
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
      L3_2 = log
      L4_2 = "Export: Changed player "
      L5_2 = A0_2
      L6_2 = " to frequency "
      L7_2 = A1_2
      L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
      L5_2 = 4
      L3_2(L4_2, L5_2)
    end
    L3_2 = TriggerClientEvent
    L4_2 = "radio:forceChannelChange"
    L5_2 = A0_2
    L6_2 = A1_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = true
    return L3_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "disconnectUser"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = IsDuplicityVersion
    L1_2 = L1_2()
    if not L1_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = Radio
    L1_2 = L1_2.setClientChannel
    L2_2 = A0_2
    L3_2 = "0"
    L1_2(L2_2, L3_2)
    L1_2 = TriggerClientEvent
    L2_2 = "radio:forceDisconnect"
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
    L1_2 = log
    L2_2 = "Export: Disconnected player "
    L3_2 = A0_2
    L4_2 = " from radio"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = true
    return L1_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "getUserNacId"
  function L14_1(A0_2)
    local L1_2, L2_2
    L1_2 = IsDuplicityVersion
    L1_2 = L1_2()
    if not L1_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = Config
    L1_2 = L1_2.getUserNacId
    L2_2 = A0_2
    return L1_2(L2_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = exports
  L13_1 = "getUserInfo"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = IsDuplicityVersion
    L1_2 = L1_2()
    if not L1_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = Config
    L1_2 = L1_2.getUserNacId
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = Config
    L2_2 = L2_2.getPlayerName
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    L3_2 = {}
    L4_2 = L2_2 or L4_2
    if not L2_2 then
      L4_2 = "Player "
      L5_2 = A0_2
      L4_2 = L4_2 .. L5_2
    end
    L3_2.name = L4_2
    L3_2.nacId = L1_2
    return L3_2
  end
  L12_1(L13_1, L14_1)
  L12_1 = log
  L13_1 = "Registering server-side radio events"
  L14_1 = 3
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:requestRadioAccess"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:requestRadioAccess"
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = log
    L1_2 = "Player "
    L2_2 = source
    L3_2 = " requesting radio access"
    L1_2 = L1_2 .. L2_2 .. L3_2
    L2_2 = 4
    L0_2(L1_2, L2_2)
    L0_2 = Config
    L0_2 = L0_2.radioAccessCheck
    L1_2 = source
    L0_2 = L0_2(L1_2)
    L1_2 = log
    L2_2 = "Player "
    L3_2 = source
    L4_2 = " radio access: "
    L5_2 = tostring
    L6_2 = L0_2
    L5_2 = L5_2(L6_2)
    L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = TriggerClientEvent
    L2_2 = "radio:receiveRadioAccess"
    L3_2 = source
    L4_2 = L0_2
    L1_2(L2_2, L3_2, L4_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:requestUserNacId"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:requestUserNacId"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L1_2 = A0_2 or nil
    if not A0_2 then
      L1_2 = source
    end
    L2_2 = Config
    L2_2 = L2_2.getUserNacId
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = log
    L4_2 = "Player "
    L5_2 = L1_2
    L6_2 = " NAC ID: "
    L7_2 = tostring
    L8_2 = L2_2
    L7_2 = L7_2(L8_2)
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = TriggerClientEvent
    L4_2 = "radio:receiveUserNacId"
    L5_2 = source
    L6_2 = L1_2
    L7_2 = L2_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:requestPlayerName"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:requestPlayerName"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L1_2 = A0_2 or nil
    if not A0_2 then
      L1_2 = source
    end
    L2_2 = Config
    L2_2 = L2_2.getPlayerName
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = TriggerClientEvent
    L4_2 = "radio:receivePlayerName"
    L5_2 = source
    L6_2 = L1_2
    L7_2 = L2_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = AddEventHandler
  L13_1 = "playerJoining"
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = source
    L1_2 = Citizen
    L1_2 = L1_2.SetTimeout
    L2_2 = 1000
    function L3_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3
      L0_3 = Config
      L0_3 = L0_3.getPlayerName
      L1_3 = L0_2
      L0_3 = L0_3(L1_3)
      L1_3 = TriggerClientEvent
      L2_3 = "radio:receivePlayerName"
      L3_3 = -1
      L4_3 = L0_2
      L5_3 = L0_3
      L1_3(L2_3, L3_3, L4_3, L5_3)
      L1_3 = log
      L2_3 = "Replicated name for joining player "
      L3_3 = L0_2
      L2_3 = L2_3 .. L3_3
      L3_3 = 4
      L1_3(L2_3, L3_3)
    end
    L1_2(L2_2, L3_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = AddEventHandler
  L13_1 = "playerDropped"
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
    L0_2 = source
    L1_2 = TriggerClientEvent
    L2_2 = "radio:playerDropped"
    L3_2 = -1
    L4_2 = L0_2
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = log
    L2_2 = "Player "
    L3_2 = L0_2
    L4_2 = " dropped, cleaning up"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = nil
    L2_2 = L3_1
    L2_2 = L2_2[L0_2]
    if L2_2 then
      L2_2 = L3_1
      L2_2 = L2_2[L0_2]
      L3_2 = L2_2.trunkedFreq
      L1_2 = L3_2 or L1_2
      if not L3_2 then
        L1_2 = L2_2.frequency
      end
    end
    L2_2 = L3_1
    L2_2[L0_2] = nil
    L2_2 = L4_1
    L2_2[L0_2] = nil
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceVoiceStopped"
    L4_2 = -1
    L5_2 = L0_2
    L6_2 = L1_2
    L2_2(L3_2, L4_2, L5_2, L6_2)
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceSirenStopped"
    L4_2 = -1
    L5_2 = L0_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceHeliStopped"
    L4_2 = -1
    L5_2 = L0_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceTransmissionStopped"
    L4_2 = -1
    L5_2 = L0_2
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceVoiceStopped"
    L4_2 = -1
    L5_2 = L0_2 + 100000
    L6_2 = L1_2
    L2_2(L3_2, L4_2, L5_2, L6_2)
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceSirenStopped"
    L4_2 = -1
    L5_2 = L0_2 + 100000
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceHeliStopped"
    L4_2 = -1
    L5_2 = L0_2 + 100000
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = TriggerClientEvent
    L3_2 = "radio:forceTransmissionStopped"
    L4_2 = -1
    L5_2 = L0_2 + 100000
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = L2_1
    L2_2 = L2_2[L0_2]
    if L2_2 then
      L2_2 = L2_1
      L2_2[L0_2] = nil
      L2_2 = log
      L3_2 = "Cleaned up debug state for disconnected player "
      L4_2 = L0_2
      L3_2 = L3_2 .. L4_2
      L4_2 = 4
      L2_2(L3_2, L4_2)
    end
    L2_2 = pairs
    L3_2 = panicButtonChannels
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = L7_2[L0_2]
      if L8_2 then
        L7_2[L0_2] = nil
        L8_2 = log
        L9_2 = "Cleared panic for player "
        L10_2 = L0_2
        L11_2 = " on channel "
        L12_2 = L6_2
        L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
        L8_2 = next
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if nil == L8_2 then
          L8_2 = panicButtonChannels
          L8_2[L6_2] = nil
          L8_2 = log
          L9_2 = "Removed empty panic channel "
          L10_2 = L6_2
          L9_2 = L9_2 .. L10_2
          L10_2 = 4
          L8_2(L9_2, L10_2)
        end
        L8_2 = TriggerClientEvent
        L9_2 = "radioClient:setPanicOnChannel"
        L10_2 = -1
        L11_2 = L6_2
        L12_2 = panicButtonChannels
        L12_2 = L12_2[L6_2]
        if not L12_2 then
          L12_2 = {}
        end
        L13_2 = L0_2
        L14_2 = false
        L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
      end
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:requestAllPlayerNames"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:requestAllPlayerNames"
  function L14_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    L0_2 = source
    L1_2 = GetPlayers
    L1_2 = L1_2()
    L2_2 = log
    L3_2 = "Player "
    L4_2 = L0_2
    L5_2 = " requesting all player names"
    L3_2 = L3_2 .. L4_2 .. L5_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = ipairs
    L3_2 = L1_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = Config
      L8_2 = L8_2.getPlayerName
      L9_2 = tonumber
      L10_2 = L7_2
      L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2)
      L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
      L9_2 = TriggerClientEvent
      L10_2 = "radio:receivePlayerName"
      L11_2 = L0_2
      L12_2 = tonumber
      L13_2 = L7_2
      L12_2 = L12_2(L13_2)
      L13_2 = L8_2
      L9_2(L10_2, L11_2, L12_2, L13_2)
    end
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:sendDispatchNotification"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:sendDispatchNotification"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = TriggerEvent
    L2_2 = "radio:webSocketBroadcast"
    L3_2 = "dispatchNotification"
    L4_2 = A0_2
    L1_2(L2_2, L3_2, L4_2)
  end
  L12_1(L13_1, L14_1)
  L12_1 = RegisterNetEvent
  L13_1 = "radio:set3DSelfHearingDebug"
  L12_1(L13_1)
  L12_1 = AddEventHandler
  L13_1 = "radio:set3DSelfHearingDebug"
  function L14_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L1_2 = source
    L2_2 = log
    L3_2 = "SERVER: Received 3D self-hearing debug event from player "
    L4_2 = L1_2
    L5_2 = " with value: "
    L6_2 = tostring
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = L2_1
    L2_2[L1_2] = A0_2
    L2_2 = log
    L3_2 = "SERVER: Player "
    L4_2 = L1_2
    L5_2 = " debug state now set to: "
    L6_2 = tostring
    L7_2 = L2_1
    L7_2 = L7_2[L1_2]
    L6_2 = L6_2(L7_2)
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
  end
  L12_1(L13_1, L14_1)
else
  L8_1 = Citizen
  L8_1 = L8_1.CreateThread
  function L9_1()
    local L0_2, L1_2, L2_2
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.type = "setLogLevel"
    L2_2 = Config
    L2_2 = L2_2.logLevel
    if not L2_2 then
      L2_2 = 3
    end
    L1_2.level = L2_2
    L0_2(L1_2)
    L0_2 = log
    L1_2 = "Radio client-side code starting up"
    L2_2 = 3
    L0_2(L1_2, L2_2)
  end
  L8_1(L9_1)
  L8_1 = RegisterNUICallback
  L9_1 = "log"
  function L10_1(A0_2, A1_2)
    local L2_2, L3_2
    L2_2 = A1_2
    L3_2 = "ok"
    L2_2(L3_2)
  end
  L8_1(L9_1, L10_1)
  radioSystemAccess = false
  L8_1 = nil
  L9_1 = {}
  radioSystemPlayerNames = L9_1
  L9_1 = {}
  L10_1 = {}
  L11_1 = {}
  L12_1 = {}
  L13_1 = {}
  L14_1 = false
  L15_1 = {}
  L16_1 = {}
  L17_1 = false
  L18_1 = 0
  L19_1 = {}
  L20_1 = {}
  L21_1 = false
  L22_1 = GetPlayerServerId
  L23_1 = PlayerId
  L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1 = L23_1()
  L22_1 = L22_1(L23_1, L24_1, L25_1, L26_1, L27_1, L28_1, L29_1, L30_1, L31_1, L32_1, L33_1, L34_1, L35_1, L36_1, L37_1, L38_1, L39_1, L40_1, L41_1, L42_1, L43_1, L44_1, L45_1, L46_1, L47_1, L48_1, L49_1, L50_1, L51_1, L52_1, L53_1, L54_1, L55_1, L56_1, L57_1, L58_1, L59_1, L60_1, L61_1, L62_1, L63_1, L64_1, L65_1, L66_1, L67_1, L68_1, L69_1, L70_1, L71_1, L72_1, L73_1, L74_1, L75_1, L76_1)
  function L23_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    L0_2 = {}
    L1_2 = ipairs
    L2_2 = Config
    L2_2 = L2_2.zones
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = L6_2.nacIds
      if L7_2 then
        L7_2 = L6_2.nacIds
        L7_2 = #L7_2
        if 0 ~= L7_2 then
          L7_2 = L8_1
          if L7_2 then
            L7_2 = ipairs
            L8_2 = L6_2.nacIds
            L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
            for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
              L13_2 = L8_1
              if L13_2 == L12_2 then
                L0_2[L5_2] = L6_2
                break
              end
            end
          end
        else
          L7_2 = radioSystemAccess
          if true == L7_2 then
            L0_2[L5_2] = L6_2
          end
        end
      else
        L7_2 = radioSystemAccess
        if true == L7_2 then
          L0_2[L5_2] = L6_2
        end
      end
    end
    return L0_2
  end
  function L24_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = table
    L1_2 = L1_2.insert
    L2_2 = L9_1
    L3_2 = A0_2
    L1_2(L2_2, L3_2)
    L1_2 = TriggerServerEvent
    L2_2 = "radio:requestRadioAccess"
    L1_2(L2_2)
  end
  function L25_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    if not A0_2 then
      L2_2 = GetPlayerServerId
      L3_2 = PlayerId
      L3_2, L4_2 = L3_2()
      L2_2 = L2_2(L3_2, L4_2)
      A0_2 = L2_2
    end
    L2_2 = GetPlayerServerId
    L3_2 = PlayerId
    L3_2, L4_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2)
    if A0_2 == L2_2 then
      L2_2 = L8_1
      if nil ~= L2_2 then
        L2_2 = A1_2
        L3_2 = L8_1
        L2_2(L3_2)
        return
      end
    end
    L2_2 = L10_1
    L2_2 = L2_2[A0_2]
    if not L2_2 then
      L2_2 = L10_1
      L3_2 = {}
      L2_2[A0_2] = L3_2
      L2_2 = TriggerServerEvent
      L3_2 = "radio:requestUserNacId"
      L4_2 = A0_2
      L2_2(L3_2, L4_2)
    end
    L2_2 = table
    L2_2 = L2_2.insert
    L3_2 = L10_1
    L3_2 = L3_2[A0_2]
    L4_2 = A1_2
    L2_2(L3_2, L4_2)
  end
  function L26_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = radioSystemPlayerNames
    L2_2 = L2_2[A0_2]
    if L2_2 then
      L2_2 = A1_2
      L3_2 = radioSystemPlayerNames
      L3_2 = L3_2[A0_2]
      L2_2(L3_2)
      return
    end
    L2_2 = L11_1
    L2_2 = L2_2[A0_2]
    if not L2_2 then
      L2_2 = L11_1
      L3_2 = {}
      L2_2[A0_2] = L3_2
      L2_2 = TriggerServerEvent
      L3_2 = "radio:requestPlayerName"
      L4_2 = A0_2
      L2_2(L3_2, L4_2)
    end
    L2_2 = table
    L2_2 = L2_2.insert
    L3_2 = L11_1
    L3_2 = L3_2[A0_2]
    L4_2 = A1_2
    L2_2(L3_2, L4_2)
  end
  L27_1 = RegisterNetEvent
  L28_1 = "radio:receiveRadioAccess"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radio:receiveRadioAccess"
  function L29_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L1_2 = log
    L2_2 = "Received radio access: "
    L3_2 = tostring
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = A0_2 or L1_2
    if not A0_2 then
      L1_2 = false
    end
    radioSystemAccess = L1_2
    L1_2 = ipairs
    L2_2 = L9_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = L6_2
      L8_2 = A0_2
      L7_2(L8_2)
    end
    L1_2 = {}
    L9_1 = L1_2
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radio:receiveUserNacId"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radio:receiveUserNacId"
  function L29_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L2_2 = log
    L3_2 = "Received NAC ID for player "
    L4_2 = A0_2
    L5_2 = ": "
    L6_2 = tostring
    L7_2 = A1_2
    L6_2 = L6_2(L7_2)
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = GetPlayerServerId
    L3_2 = PlayerId
    L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L3_2()
    L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    if A0_2 == L2_2 then
      L8_1 = A1_2
      L2_2 = L23_1
      L2_2 = L2_2()
      L3_2 = next
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = RadioState
        L3_2 = L3_2.selectedZone
        L3_2 = L2_2[L3_2]
        if not L3_2 then
          L3_2 = pairs
          L4_2 = L2_2
          L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
          for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
            L9_2 = RadioState
            L9_2.selectedZone = L7_2
            L9_2 = log
            L10_2 = "Initialized selectedZone to first accessible zone: "
            L11_2 = L7_2
            L10_2 = L10_2 .. L11_2
            L11_2 = 2
            L9_2(L10_2, L11_2)
            break
          end
        end
      end
    end
    L2_2 = L10_1
    L2_2 = L2_2[A0_2]
    if L2_2 then
      L2_2 = ipairs
      L3_2 = L10_1
      L3_2 = L3_2[A0_2]
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = L7_2
        L9_2 = A1_2
        L8_2(L9_2)
      end
      L2_2 = L10_1
      L2_2[A0_2] = nil
    end
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radio:receivePlayerName"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radio:receivePlayerName"
  function L29_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = radioSystemPlayerNames
    L3_2 = A1_2 or L3_2
    if not A1_2 then
      L3_2 = "Player "
      L4_2 = A0_2
      L3_2 = L3_2 .. L4_2
    end
    L2_2[A0_2] = L3_2
    L2_2 = log
    L3_2 = "Cached name for player "
    L4_2 = A0_2
    L5_2 = ": "
    L6_2 = radioSystemPlayerNames
    L6_2 = L6_2[A0_2]
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = L11_1
    L2_2 = L2_2[A0_2]
    if L2_2 then
      L2_2 = ipairs
      L3_2 = L11_1
      L3_2 = L3_2[A0_2]
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = L7_2
        L9_2 = radioSystemPlayerNames
        L9_2 = L9_2[A0_2]
        L8_2(L9_2)
      end
      L2_2 = L11_1
      L2_2[A0_2] = nil
    end
  end
  L27_1(L28_1, L29_1)
  function L27_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = radioSystemPlayerNames
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = radioSystemPlayerNames
      L1_2 = L1_2[A0_2]
      return L1_2
    end
    if A0_2 and A0_2 > 0 then
      L1_2 = L26_1
      L2_2 = A0_2
      function L3_2()
        local L0_3, L1_3
      end
      L1_2(L2_2, L3_2)
      L1_2 = "Player "
      L2_2 = A0_2
      L1_2 = L1_2 .. L2_2
      return L1_2
    end
    L1_2 = "DISPATCH"
    return L1_2
  end
  getPlayerName = L27_1
  L27_1 = _G
  L28_1 = getPlayerName
  L27_1.radioSystemGetPlayerName = L28_1
  L27_1 = RegisterNetEvent
  L28_1 = "radio:playerDropped"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radio:playerDropped"
  function L29_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = radioSystemPlayerNames
    L1_2[A0_2] = nil
    L1_2 = L11_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = L11_1
      L1_2[A0_2] = nil
    end
    L1_2 = L12_1
    L1_2[A0_2] = nil
    L1_2 = L13_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = SendNUIMessage
      L2_2 = {}
      L2_2.action = "stopSiren"
      L2_2.serverId = A0_2
      L1_2(L2_2)
      L1_2 = L13_1
      L1_2[A0_2] = nil
    end
    L1_2 = L15_1
    L1_2[A0_2] = nil
    L1_2 = L16_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = SendNUIMessage
      L2_2 = {}
      L2_2.action = "stopHeli"
      L2_2.serverId = A0_2
      L1_2(L2_2)
      L1_2 = L16_1
      L1_2[A0_2] = nil
    end
    L1_2 = RadioState
    L1_2 = L1_2.activeTalker
    if L1_2 == A0_2 then
      L1_2 = RadioState
      L1_2.activeTalker = nil
      L1_2 = setLED
      L2_2 = "transmit"
      L3_2 = false
      L1_2(L2_2, L3_2)
      L1_2 = SendNUIMessage
      L2_2 = {}
      L2_2.action = "setTalking"
      L2_2.talking = false
      L2_2.suppressTone = true
      L1_2(L2_2)
    end
    L1_2 = RadioState
    L1_2 = L1_2.connectedChannelTalker
    if L1_2 == A0_2 then
      L1_2 = RadioState
      L1_2.connectedChannelTalker = nil
    end
    L1_2 = RadioState
    L1_2 = L1_2.scannedChannelTalker
    if L1_2 == A0_2 then
      L1_2 = RadioState
      L1_2.scannedChannelTalker = nil
    end
    L1_2 = log
    L2_2 = "Cleaned up cache for dropped player "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radioClient:updateSirenList"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radioClient:updateSirenList"
  function L29_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = A0_2 or nil
    if not A0_2 then
      L1_2 = {}
    end
    L12_1 = L1_2
    L1_2 = 0
    L2_2 = ""
    L3_2 = pairs
    L4_2 = L12_1
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2 in L3_2, L4_2, L5_2, L6_2 do
      L1_2 = L1_2 + 1
      L8_2 = L2_2
      L9_2 = L7_2
      L10_2 = " "
      L8_2 = L8_2 .. L9_2 .. L10_2
      L2_2 = L8_2
    end
    L3_2 = log
    L4_2 = "Updated client siren cache with "
    L5_2 = L1_2
    L6_2 = " players: "
    L7_2 = L2_2
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radioClient:updateHeliList"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radioClient:updateHeliList"
  function L29_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = A0_2 or nil
    if not A0_2 then
      L1_2 = {}
    end
    L15_1 = L1_2
    L1_2 = 0
    L2_2 = ""
    L3_2 = pairs
    L4_2 = L15_1
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2 in L3_2, L4_2, L5_2, L6_2 do
      L1_2 = L1_2 + 1
      L8_2 = L2_2
      L9_2 = L7_2
      L10_2 = " "
      L8_2 = L8_2 .. L9_2 .. L10_2
      L2_2 = L8_2
    end
    L3_2 = log
    L4_2 = "Updated client helicopter cache with "
    L5_2 = L1_2
    L6_2 = " players: "
    L7_2 = L2_2
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radio:forceVoiceStopped"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radio:forceVoiceStopped"
  function L29_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    L2_2 = 100000
    L2_2 = A0_2 > L2_2
    if L2_2 then
      L3_2 = A0_2 - 100000
      if L3_2 then
        goto lbl_13
      end
    end
    L3_2 = A0_2
    ::lbl_13::
    L4_2 = A1_2
    if L2_2 then
      L5_2 = L3_1
      L5_2 = L5_2[L3_2]
      if L5_2 then
        L5_2 = GetGameTimer
        L5_2 = L5_2()
        L6_2 = L3_1
        L6_2 = L6_2[L3_2]
        L6_2 = L6_2.startTime
        L5_2 = L5_2 - L6_2
        L6_2 = 10000
        if L5_2 < L6_2 then
          L6_2 = log
          L7_2 = "Skipping premature vehicle cleanup for source "
          L8_2 = A0_2
          L9_2 = " (player "
          L10_2 = L3_2
          L11_2 = " actively talking for "
          L12_2 = L5_2
          L13_2 = "ms)"
          L7_2 = L7_2 .. L8_2 .. L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
          L8_2 = 3
          L6_2(L7_2, L8_2)
          return
        end
      end
    end
    L5_2 = log
    L6_2 = "Force voice stop for source "
    L7_2 = A0_2
    L8_2 = " on frequency "
    L9_2 = tostring
    L10_2 = L4_2 or L10_2
    if not L4_2 then
      L10_2 = "unknown"
    end
    L9_2 = L9_2(L10_2)
    L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
    L7_2 = 2
    L5_2(L6_2, L7_2)
    if L2_2 then
      L5_2 = log
      L6_2 = "Cleaning up 3D vehicle audio for player "
      L7_2 = L3_2
      L8_2 = " (vehicle source "
      L9_2 = A0_2
      L10_2 = ")"
      L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2 .. L10_2
      L7_2 = 4
      L5_2(L6_2, L7_2)
    else
      L5_2 = RadioState
      L5_2 = L5_2.activeTalker
      if L5_2 == L3_2 then
        L5_2 = RadioState
        L5_2.activeTalker = nil
        L5_2 = RadioState
        L5_2.activeTransmissionFreq = nil
        L5_2 = setLED
        L6_2 = "transmit"
        L7_2 = false
        L5_2(L6_2, L7_2)
        L5_2 = updateDisplay
        L5_2()
      end
      L5_2 = RadioState
      L5_2 = L5_2.connectedChannelTalker
      if L5_2 == L3_2 then
        L5_2 = RadioState
        L5_2.connectedChannelTalker = nil
      end
      L5_2 = RadioState
      L5_2 = L5_2.scannedChannelTalker
      if L5_2 == L3_2 then
        L5_2 = RadioState
        L5_2.scannedChannelTalker = nil
      end
    end
    L5_2 = cleanup3DSource
    L6_2 = A0_2
    L7_2 = "voice"
    L5_2(L6_2, L7_2)
    L5_2 = SendNUIMessage
    L6_2 = {}
    L6_2.action = "stop3DVoice"
    L6_2.sourceId = A0_2
    L5_2(L6_2)
    L5_2 = SendNUIMessage
    L6_2 = {}
    L6_2.action = "setTalking"
    L6_2.talking = false
    L6_2.suppressTone = true
    L5_2(L6_2)
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radio:forceSirenStopped"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radio:forceSirenStopped"
  function L29_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = log
    L2_2 = "Received forced siren stop for player "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = L13_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = SendNUIMessage
      L2_2 = {}
      L2_2.action = "stopSiren"
      L2_2.serverId = A0_2
      L1_2(L2_2)
      L1_2 = L13_1
      L1_2[A0_2] = nil
    end
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radio:forceHeliStopped"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radio:forceHeliStopped"
  function L29_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = log
    L2_2 = "Received forced heli stop for player "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = L16_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = SendNUIMessage
      L2_2 = {}
      L2_2.action = "stopHeli"
      L2_2.serverId = A0_2
      L1_2(L2_2)
      L1_2 = L16_1
      L1_2[A0_2] = nil
    end
  end
  L27_1(L28_1, L29_1)
  L27_1 = RegisterNetEvent
  L28_1 = "radioClient:gunshotDuringTransmission"
  L27_1(L28_1)
  L27_1 = AddEventHandler
  L28_1 = "radioClient:gunshotDuringTransmission"
  function L29_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = Config
    L2_2 = L2_2.playTransmissionEffects
    if not L2_2 then
      return
    end
    L2_2 = log
    L3_2 = "Received gunshot event from player "
    L4_2 = A0_2
    L5_2 = " - RadioState.talking: "
    L6_2 = tostring
    L7_2 = RadioState
    L7_2 = L7_2.talking
    L6_2 = L6_2(L7_2)
    L7_2 = " - distance: "
    L8_2 = tostring
    L9_2 = A1_2
    L8_2 = L8_2(L9_2)
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2
    L4_2 = 2
    L2_2(L3_2, L4_2)
    L2_2 = RadioState
    L2_2 = L2_2.talking
    if L2_2 then
      L2_2 = log
      L3_2 = "Ignoring gunshot - we are transmitting"
      L4_2 = 4
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = RadioState
    L2_2 = L2_2.power
    if not L2_2 then
      L2_2 = log
      L3_2 = "Ignoring gunshot - radio is off"
      L4_2 = 4
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = false
    L3_2 = RadioState
    L3_2 = L3_2.connectedChannelTalker
    if L3_2 == A0_2 then
      L2_2 = true
      L3_2 = log
      L4_2 = "Listening to transmitter on connected channel"
      L5_2 = 4
      L3_2(L4_2, L5_2)
    else
      L3_2 = RadioState
      L3_2 = L3_2.scannedChannelTalker
      if L3_2 == A0_2 then
        L2_2 = true
        L3_2 = log
        L4_2 = "Listening to transmitter on scanned channel"
        L5_2 = 4
        L3_2(L4_2, L5_2)
      end
    end
    if not L2_2 then
      L3_2 = log
      L4_2 = "Ignoring gunshot - not listening to transmitter "
      L5_2 = A0_2
      L4_2 = L4_2 .. L5_2
      L5_2 = 3
      L3_2(L4_2, L5_2)
      return
    end
    L3_2 = 0
    if A1_2 <= 10 then
      L3_2 = 1.0
    elseif A1_2 <= 25 then
      L4_2 = A1_2 - 10
      L4_2 = L4_2 / 15
      L4_2 = L4_2 * 0.99
      L5_2 = 1.0
      L3_2 = L5_2 - L4_2
    elseif A1_2 <= 100 then
      L4_2 = A1_2 - 25
      L4_2 = L4_2 / 75
      L4_2 = L4_2 * 0.9
      L5_2 = 1.0
      L4_2 = L5_2 - L4_2
      L3_2 = 0.01 * L4_2
    else
      L3_2 = 0
    end
    if L3_2 > 0 then
      L4_2 = log
      L5_2 = "Playing gunshot - we are listening at volume: "
      L6_2 = L3_2
      L7_2 = " (distance: "
      L8_2 = A1_2
      L9_2 = ")"
      L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2
      L6_2 = 4
      L4_2(L5_2, L6_2)
      L4_2 = SendNUIMessage
      L5_2 = {}
      L5_2.action = "playGunshotSound"
      L5_2.serverId = A0_2
      L5_2.volume = L3_2
      L5_2.distance = A1_2
      L4_2(L5_2)
      L4_2 = radioSystemAccess
      if L4_2 then
        L4_2 = RadioState
        L4_2 = L4_2.power
        if L4_2 then
          L4_2 = RadioState
          L4_2 = L4_2.earbudsEnabled
          if not L4_2 then
            L4_2 = nil
            L5_2 = playerOwnedVehicle
            if L5_2 then
              L5_2 = DoesEntityExist
              L6_2 = playerOwnedVehicle
              L5_2 = L5_2(L6_2)
              if L5_2 then
                L5_2 = VehToNet
                L6_2 = playerOwnedVehicle
                L5_2 = L5_2(L6_2)
                L4_2 = L5_2
              end
            end
            L5_2 = TriggerServerEvent
            L6_2 = "radio:3DGunshot"
            L7_2 = L3_2
            L8_2 = L4_2
            L5_2(L6_2, L7_2, L8_2)
          end
        end
      end
    else
      L4_2 = log
      L5_2 = "Gunshot too far away - not playing (distance: "
      L6_2 = A1_2
      L7_2 = ")"
      L5_2 = L5_2 .. L6_2 .. L7_2
      L6_2 = 4
      L4_2(L5_2, L6_2)
    end
  end
  L27_1(L28_1, L29_1)
  L27_1 = {}
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DTone"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DTone"
  function L30_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2
    L4_2 = log
    L5_2 = "Received 3D tone "
    L6_2 = A1_2
    L7_2 = " from player "
    L8_2 = A0_2
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = L27_1
    L5_2 = L27_1
    L5_2 = L5_2[A0_2]
    if not L5_2 then
      L5_2 = {}
    end
    L4_2[A0_2] = L5_2
    L4_2 = GetGameTimer
    L4_2 = L4_2()
    L5_2 = L27_1
    L5_2 = L5_2[A0_2]
    L5_2.tone = L4_2
    L5_2 = Citizen
    L5_2 = L5_2.SetTimeout
    L6_2 = 3000
    function L7_2()
      local L0_3, L1_3, L2_3
      L1_3 = A0_2
      L0_3 = L27_1
      L0_3 = L0_3[L1_3]
      if L0_3 then
        L1_3 = A0_2
        L0_3 = L27_1
        L0_3 = L0_3[L1_3]
        L0_3 = L0_3.tone
        L1_3 = L4_2
        if L0_3 == L1_3 then
          L1_3 = A0_2
          L0_3 = L27_1
          L0_3 = L0_3[L1_3]
          L0_3.tone = nil
          L0_3 = next
          L2_3 = A0_2
          L1_3 = L27_1
          L1_3 = L1_3[L2_3]
          L0_3 = L0_3(L1_3)
          if not L0_3 then
            L1_3 = A0_2
            L0_3 = L27_1
            L0_3[L1_3] = nil
          end
        end
      end
    end
    L5_2(L6_2, L7_2)
    L5_2 = SendNUIMessage
    L6_2 = {}
    L6_2.action = "play3DTone"
    L6_2.sourceId = A0_2
    L6_2.tone = A1_2
    L6_2.volume = A2_2
    L6_2.coords = A3_2
    L5_2(L6_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DVoiceStarted"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DVoiceStarted"
  function L30_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2
    L4_2 = log
    L5_2 = "Received 3D voice start from player "
    L6_2 = A0_2
    L7_2 = " on "
    L8_2 = A1_2
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 4
    L4_2(L5_2, L6_2)
    L4_2 = L27_1
    L5_2 = L27_1
    L5_2 = L5_2[A0_2]
    if not L5_2 then
      L5_2 = {}
    end
    L4_2[A0_2] = L5_2
    L4_2 = L27_1
    L4_2 = L4_2[A0_2]
    L4_2.voice = true
    L4_2 = SendNUIMessage
    L5_2 = {}
    L5_2.action = "start3DVoice"
    L5_2.sourceId = A0_2
    L5_2.frequency = A1_2
    L5_2.volume = A2_2
    L5_2.coords = A3_2
    L4_2(L5_2)
  end
  L28_1(L29_1, L30_1)
  function L28_1(A0_2, A1_2)
    local L2_2, L3_2
    L2_2 = L27_1
    L2_2 = L2_2[A0_2]
    if L2_2 then
      L2_2 = L27_1
      L2_2 = L2_2[A0_2]
      L2_2[A1_2] = nil
      L2_2 = next
      L3_2 = L27_1
      L3_2 = L3_2[A0_2]
      L2_2 = L2_2(L3_2)
      if not L2_2 then
        L2_2 = L27_1
        L2_2[A0_2] = nil
      end
    end
  end
  cleanup3DSource = L28_1
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DVoiceStopped"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DVoiceStopped"
  function L30_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2
    L3_2 = log
    L4_2 = "Received 3D voice stop from player "
    L5_2 = A0_2
    L4_2 = L4_2 .. L5_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = cleanup3DSource
    L4_2 = A0_2
    L5_2 = "voice"
    L3_2(L4_2, L5_2)
    L3_2 = SendNUIMessage
    L4_2 = {}
    L4_2.action = "stop3DVoice"
    L4_2.sourceId = A0_2
    L4_2.frequency = A1_2
    L3_2(L4_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DSirenStarted"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DSirenStarted"
  function L30_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Received 3D siren start from player "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = L27_1
    L3_2 = L27_1
    L3_2 = L3_2[A0_2]
    if not L3_2 then
      L3_2 = {}
    end
    L2_2[A0_2] = L3_2
    L2_2 = L27_1
    L2_2 = L2_2[A0_2]
    L2_2.siren = true
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "start3DSiren"
    L3_2.sourceId = A0_2
    L3_2.coords = A1_2
    L2_2(L3_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DSirenStopped"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DSirenStopped"
  function L30_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Received 3D siren stop from player "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = cleanup3DSource
    L3_2 = A0_2
    L4_2 = "siren"
    L2_2(L3_2, L4_2)
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "stop3DSiren"
    L3_2.sourceId = A0_2
    L2_2(L3_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DHeliStarted"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DHeliStarted"
  function L30_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Received 3D heli start from player "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = L27_1
    L3_2 = L27_1
    L3_2 = L3_2[A0_2]
    if not L3_2 then
      L3_2 = {}
    end
    L2_2[A0_2] = L3_2
    L2_2 = L27_1
    L2_2 = L2_2[A0_2]
    L2_2.heli = true
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "start3DHeli"
    L3_2.sourceId = A0_2
    L3_2.coords = A1_2
    L2_2(L3_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DHeliStopped"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DHeliStopped"
  function L30_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Received 3D heli stop from player "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = cleanup3DSource
    L3_2 = A0_2
    L4_2 = "heli"
    L2_2(L3_2, L4_2)
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "stop3DHeli"
    L3_2.sourceId = A0_2
    L2_2(L3_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DGunshot"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DGunshot"
  function L30_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L3_2 = log
    L4_2 = "Received 3D gunshot from player "
    L5_2 = A0_2
    L6_2 = " with volume "
    L7_2 = A1_2
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = log
    L4_2 = "Sending 3D gunshot to NUI - sourceId: "
    L5_2 = A0_2
    L6_2 = ", volume: "
    L7_2 = A1_2
    L8_2 = ", coords: "
    L9_2 = tostring
    L10_2 = A2_2
    L9_2 = L9_2(L10_2)
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2
    L5_2 = 4
    L3_2(L4_2, L5_2)
    L3_2 = SendNUIMessage
    L4_2 = {}
    L4_2.action = "play3DGunshot"
    L4_2.sourceId = A0_2
    L4_2.volume = A1_2
    L4_2.coords = A2_2
    L3_2(L4_2)
    L3_2 = log
    L4_2 = "3D gunshot message sent to NUI"
    L5_2 = 4
    L3_2(L4_2, L5_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DTransmissionStarted"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DTransmissionStarted"
  function L30_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Received 3D transmission start from player "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = L27_1
    L3_2 = L27_1
    L3_2 = L3_2[A0_2]
    if not L3_2 then
      L3_2 = {}
    end
    L2_2[A0_2] = L3_2
    L2_2 = L27_1
    L2_2 = L2_2[A0_2]
    L2_2.transmission = true
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "start3DTransmission"
    L3_2.sourceId = A0_2
    L3_2.coords = A1_2
    L2_2(L3_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:receive3DTransmissionStopped"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:receive3DTransmissionStopped"
  function L30_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Received 3D transmission stop from player "
    L4_2 = A0_2
    L3_2 = L3_2 .. L4_2
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = cleanup3DSource
    L3_2 = A0_2
    L4_2 = "transmission"
    L2_2(L3_2, L4_2)
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "stop3DTransmission"
    L3_2.sourceId = A0_2
    L2_2(L3_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:forceSirenStopped"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:forceSirenStopped"
  function L30_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = log
    L2_2 = "Force stopping 3D siren for disconnected player "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = cleanup3DSource
    L2_2 = A0_2
    L3_2 = "siren"
    L1_2(L2_2, L3_2)
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "stop3DSiren"
    L2_2.sourceId = A0_2
    L1_2(L2_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:forceHeliStopped"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:forceHeliStopped"
  function L30_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = log
    L2_2 = "Force stopping 3D heli for disconnected player "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = cleanup3DSource
    L2_2 = A0_2
    L3_2 = "heli"
    L1_2(L2_2, L3_2)
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "stop3DHeli"
    L2_2.sourceId = A0_2
    L1_2(L2_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:forceTransmissionStopped"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:forceTransmissionStopped"
  function L30_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = log
    L2_2 = "Force stopping 3D transmission for disconnected player "
    L3_2 = A0_2
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = cleanup3DSource
    L2_2 = A0_2
    L3_2 = "transmission"
    L1_2(L2_2, L3_2)
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "stop3DTransmission"
    L2_2.sourceId = A0_2
    L1_2(L2_2)
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setTalking"
    L2_2.talking = false
    L2_2.suppressTone = true
    L1_2(L2_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = RegisterNetEvent
  L29_1 = "radio:stopAll3DAudio"
  L28_1(L29_1)
  L28_1 = AddEventHandler
  L29_1 = "radio:stopAll3DAudio"
  function L30_1()
    local L0_2, L1_2, L2_2
    L0_2 = log
    L1_2 = "Received server command to stop all 3D audio"
    L2_2 = 4
    L0_2(L1_2, L2_2)
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "stopAll3DAudio"
    L0_2(L1_2)
    L0_2 = {}
    L27_1 = L0_2
    L0_2 = log
    L1_2 = "Cleared all client-side 3D audio sources"
    L2_2 = 4
    L0_2(L1_2, L2_2)
  end
  L28_1(L29_1, L30_1)
  L28_1 = Citizen
  L28_1 = L28_1.CreateThread
  function L29_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 2000
      L0_2(L1_2)
      L0_2 = next
      L1_2 = L27_1
      L0_2 = L0_2(L1_2)
      if L0_2 then
        L0_2 = PlayerPedId
        L0_2 = L0_2()
        L1_2 = GetEntityCoords
        L2_2 = L0_2
        L1_2 = L1_2(L2_2)
        L2_2 = 1000
        L3_2 = pairs
        L4_2 = L27_1
        L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
        for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
          L9_2 = L7_2
          L10_2 = 100000
          if L7_2 > L10_2 then
            L9_2 = L7_2 - 100000
          end
          L10_2 = GetPlayerFromServerId
          L11_2 = L9_2
          L10_2 = L10_2(L11_2)
          if -1 ~= L10_2 then
            L11_2 = GetPlayerPed
            L12_2 = L10_2
            L11_2 = L11_2(L12_2)
            L12_2 = DoesEntityExist
            L13_2 = L11_2
            L12_2 = L12_2(L13_2)
            if L12_2 then
              L12_2 = GetEntityCoords
              L13_2 = L11_2
              L12_2 = L12_2(L13_2)
              L13_2 = L1_2 - L12_2
              L13_2 = #L13_2
              if L2_2 < L13_2 then
                L14_2 = log
                L15_2 = "Stopping all 3D audio from player "
                L16_2 = L7_2
                L17_2 = " - too far away (distance: "
                L18_2 = math
                L18_2 = L18_2.floor
                L19_2 = L13_2
                L18_2 = L18_2(L19_2)
                L19_2 = ")"
                L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2
                L16_2 = 4
                L14_2(L15_2, L16_2)
                L14_2 = pairs
                L15_2 = L8_2
                L14_2, L15_2, L16_2, L17_2 = L14_2(L15_2)
                for L18_2, L19_2 in L14_2, L15_2, L16_2, L17_2 do
                  if "voice" == L18_2 then
                    L20_2 = SendNUIMessage
                    L21_2 = {}
                    L21_2.action = "stop3DVoice"
                    L21_2.sourceId = L7_2
                    L20_2(L21_2)
                  elseif "siren" == L18_2 then
                    L20_2 = SendNUIMessage
                    L21_2 = {}
                    L21_2.action = "stop3DSiren"
                    L21_2.sourceId = L7_2
                    L20_2(L21_2)
                  elseif "heli" == L18_2 then
                    L20_2 = SendNUIMessage
                    L21_2 = {}
                    L21_2.action = "stop3DHeli"
                    L21_2.sourceId = L7_2
                    L20_2(L21_2)
                  end
                end
                L14_2 = L27_1
                L14_2[L7_2] = nil
              end
            end
          else
            L11_2 = log
            L12_2 = "Player "
            L13_2 = L9_2
            L14_2 = " not found - cleaning up all 3D audio for sourceId "
            L15_2 = L7_2
            L12_2 = L12_2 .. L13_2 .. L14_2 .. L15_2
            L13_2 = 2
            L11_2(L12_2, L13_2)
            L11_2 = pairs
            L12_2 = L8_2
            L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
            for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
              if "voice" == L15_2 then
                L17_2 = SendNUIMessage
                L18_2 = {}
                L18_2.action = "stop3DVoice"
                L18_2.sourceId = L7_2
                L17_2(L18_2)
              elseif "siren" == L15_2 then
                L17_2 = SendNUIMessage
                L18_2 = {}
                L18_2.action = "stop3DSiren"
                L18_2.sourceId = L7_2
                L17_2(L18_2)
              elseif "heli" == L15_2 then
                L17_2 = SendNUIMessage
                L18_2 = {}
                L18_2.action = "stop3DHeli"
                L18_2.sourceId = L7_2
                L17_2(L18_2)
              end
            end
            L11_2 = L27_1
            L11_2[L7_2] = nil
          end
        end
      end
    end
  end
  L28_1(L29_1)
  L28_1 = Citizen
  L28_1 = L28_1.CreateThread
  function L29_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    while true do
      L0_2 = 50
      L1_2 = next
      L2_2 = L27_1
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = PlayerPedId
        L1_2 = L1_2()
        L2_2 = GetEntitySpeed
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        if L2_2 > 15 then
          L0_2 = 16
        elseif L2_2 > 5 then
          L0_2 = 33
        else
          L0_2 = 50
        end
        L3_2 = nil
        L4_2 = nil
        L5_2 = GetVehiclePedIsIn
        L6_2 = L1_2
        L7_2 = false
        L5_2 = L5_2(L6_2, L7_2)
        if L5_2 and 0 ~= L5_2 then
          L6_2 = GetFollowPedCamViewMode
          L6_2 = L6_2()
          if 4 == L6_2 then
            L7_2 = GetEntityCoords
            L8_2 = L5_2
            L7_2 = L7_2(L8_2)
            L3_2 = L7_2
            L7_2 = GetGameplayCamRot
            L8_2 = 0
            L7_2 = L7_2(L8_2)
            L4_2 = L7_2
          else
            L7_2 = GetGameplayCamCoord
            L7_2 = L7_2()
            L3_2 = L7_2
            L7_2 = GetGameplayCamRot
            L8_2 = 0
            L7_2 = L7_2(L8_2)
            L4_2 = L7_2
          end
        else
          L6_2 = GetEntityCoords
          L7_2 = L1_2
          L6_2 = L6_2(L7_2)
          L3_2 = L6_2
          L6_2 = GetGameplayCamRot
          L7_2 = 0
          L6_2 = L6_2(L7_2)
          L4_2 = L6_2
        end
        L6_2 = SendNUIMessage
        L7_2 = {}
        L7_2.action = "updateListenerPosition"
        L8_2 = {}
        L9_2 = L3_2.x
        L8_2.x = L9_2
        L9_2 = L3_2.y
        L8_2.y = L9_2
        L9_2 = L3_2.z
        L8_2.z = L9_2
        L7_2.coords = L8_2
        L8_2 = {}
        L9_2 = L4_2.x
        L8_2.x = L9_2
        L9_2 = L4_2.y
        L8_2.y = L9_2
        L9_2 = L4_2.z
        L8_2.z = L9_2
        L7_2.camera = L8_2
        L7_2.speed = L2_2
        L6_2(L7_2)
      end
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = L0_2
      L1_2(L2_2)
    end
  end
  L28_1(L29_1)
  L28_1 = Citizen
  L28_1 = L28_1.CreateThread
  function L29_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 1000
      L0_2(L1_2)
      L0_2 = radioSystemAccess
      if L0_2 then
        L0_2 = Config
        L0_2 = L0_2.bgSirenCheck
        L0_2 = L0_2()
        L1_2 = L14_1
        if L0_2 ~= L1_2 then
          L14_1 = L0_2
          L1_2 = TriggerServerEvent
          L2_2 = "radioServer:updateSirenStatus"
          L3_2 = L0_2
          L1_2(L2_2, L3_2)
          L1_2 = log
          L2_2 = "Sent siren status update: "
          L3_2 = tostring
          L4_2 = L0_2
          L3_2 = L3_2(L4_2)
          L2_2 = L2_2 .. L3_2
          L3_2 = 4
          L1_2(L2_2, L3_2)
        end
      end
    end
  end
  L28_1(L29_1)
  L28_1 = Citizen
  L28_1 = L28_1.CreateThread
  function L29_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
    while true do
      L0_2 = 100
      L1_2 = next
      L2_2 = L27_1
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = PlayerPedId
        L1_2 = L1_2()
        L2_2 = 0
        L3_2 = DoesEntityExist
        L4_2 = L1_2
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = GetEntitySpeed
          L4_2 = L1_2
          L3_2 = L3_2(L4_2)
          L2_2 = L3_2
          if L2_2 > 15 then
            L0_2 = 16
          elseif L2_2 > 5 then
            L0_2 = 33
          else
            L0_2 = 50
          end
        end
        L3_2 = pairs
        L4_2 = L27_1
        L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
        for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
          L9_2 = L7_2
          L10_2 = false
          L11_2 = 100000
          if L7_2 > L11_2 then
            L9_2 = L7_2 - 100000
            L10_2 = true
          end
          L11_2 = GetPlayerFromServerId
          L12_2 = L9_2
          L11_2 = L11_2(L12_2)
          if -1 ~= L11_2 then
            if L10_2 then
              L12_2 = L20_1
              L12_2 = L12_2[L9_2]
              if L12_2 then
                L12_2 = NetworkGetEntityFromNetworkId
                L13_2 = L20_1
                L13_2 = L13_2[L9_2]
                L12_2 = L12_2(L13_2)
                L13_2 = DoesEntityExist
                L14_2 = L12_2
                L13_2 = L13_2(L14_2)
                if L13_2 then
                  L13_2 = GetEntityCoords
                  L14_2 = L12_2
                  L13_2 = L13_2(L14_2)
                  L14_2 = GetEntitySpeed
                  L15_2 = L12_2
                  L14_2 = L14_2(L15_2)
                  L15_2 = SendNUIMessage
                  L16_2 = {}
                  L16_2.action = "update3DPosition"
                  L16_2.sourceId = L7_2
                  L17_2 = {}
                  L18_2 = L13_2.x
                  L17_2.x = L18_2
                  L18_2 = L13_2.y
                  L17_2.y = L18_2
                  L18_2 = L13_2.z
                  L17_2.z = L18_2
                  L16_2.coords = L17_2
                  L16_2.speed = L14_2
                  L15_2(L16_2)
                else
                  L13_2 = log
                  L14_2 = "Vehicle for player "
                  L15_2 = L9_2
                  L16_2 = " no longer exists, cleaning up audio"
                  L14_2 = L14_2 .. L15_2 .. L16_2
                  L15_2 = 4
                  L13_2(L14_2, L15_2)
                  L13_2 = SendNUIMessage
                  L14_2 = {}
                  L14_2.action = "stopAll3DFromSource"
                  L14_2.sourceId = L7_2
                  L13_2(L14_2)
                  L13_2 = cleanup3DSource
                  L14_2 = L7_2
                  L15_2 = "voice"
                  L13_2(L14_2, L15_2)
                  L13_2 = cleanup3DSource
                  L14_2 = L7_2
                  L15_2 = "siren"
                  L13_2(L14_2, L15_2)
                  L13_2 = cleanup3DSource
                  L14_2 = L7_2
                  L15_2 = "heli"
                  L13_2(L14_2, L15_2)
                  L13_2 = L20_1
                  L13_2[L9_2] = nil
                end
              else
                L12_2 = log
                L13_2 = "Player "
                L14_2 = L9_2
                L15_2 = " no longer owns vehicle, cleaning up vehicle audio"
                L13_2 = L13_2 .. L14_2 .. L15_2
                L14_2 = 2
                L12_2(L13_2, L14_2)
                L12_2 = SendNUIMessage
                L13_2 = {}
                L13_2.action = "stopAll3DFromSource"
                L13_2.sourceId = L7_2
                L12_2(L13_2)
                L12_2 = cleanup3DSource
                L13_2 = L7_2
                L14_2 = "voice"
                L12_2(L13_2, L14_2)
                L12_2 = cleanup3DSource
                L13_2 = L7_2
                L14_2 = "siren"
                L12_2(L13_2, L14_2)
                L12_2 = cleanup3DSource
                L13_2 = L7_2
                L14_2 = "heli"
                L12_2(L13_2, L14_2)
              end
            else
              L12_2 = GetPlayerPed
              L13_2 = L11_2
              L12_2 = L12_2(L13_2)
              L13_2 = DoesEntityExist
              L14_2 = L12_2
              L13_2 = L13_2(L14_2)
              if L13_2 then
                L13_2 = GetEntityCoords
                L14_2 = L12_2
                L13_2 = L13_2(L14_2)
                L14_2 = GetEntitySpeed
                L15_2 = L12_2
                L14_2 = L14_2(L15_2)
                L15_2 = SendNUIMessage
                L16_2 = {}
                L16_2.action = "update3DPosition"
                L16_2.sourceId = L7_2
                L17_2 = {}
                L18_2 = L13_2.x
                L17_2.x = L18_2
                L18_2 = L13_2.y
                L17_2.y = L18_2
                L18_2 = L13_2.z
                L17_2.z = L18_2
                L16_2.coords = L17_2
                L16_2.speed = L14_2
                L15_2(L16_2)
              else
                L13_2 = log
                L14_2 = "Player ped "
                L15_2 = L9_2
                L16_2 = " no longer exists, cleaning up audio"
                L14_2 = L14_2 .. L15_2 .. L16_2
                L15_2 = 4
                L13_2(L14_2, L15_2)
                L13_2 = SendNUIMessage
                L14_2 = {}
                L14_2.action = "stopAll3DFromSource"
                L14_2.sourceId = L7_2
                L13_2(L14_2)
                L13_2 = cleanup3DSource
                L14_2 = L7_2
                L15_2 = "voice"
                L13_2(L14_2, L15_2)
                L13_2 = cleanup3DSource
                L14_2 = L7_2
                L15_2 = "siren"
                L13_2(L14_2, L15_2)
                L13_2 = cleanup3DSource
                L14_2 = L7_2
                L15_2 = "heli"
                L13_2(L14_2, L15_2)
              end
            end
          else
            L12_2 = log
            L13_2 = "Player "
            L14_2 = L9_2
            L15_2 = " not found, cleaning up audio for sourceId "
            L16_2 = L7_2
            L13_2 = L13_2 .. L14_2 .. L15_2 .. L16_2
            L14_2 = 2
            L12_2(L13_2, L14_2)
            L12_2 = SendNUIMessage
            L13_2 = {}
            L13_2.action = "stopAll3DFromSource"
            L13_2.sourceId = L7_2
            L12_2(L13_2)
            L12_2 = cleanup3DSource
            L13_2 = L7_2
            L14_2 = "voice"
            L12_2(L13_2, L14_2)
            L12_2 = cleanup3DSource
            L13_2 = L7_2
            L14_2 = "siren"
            L12_2(L13_2, L14_2)
            L12_2 = cleanup3DSource
            L13_2 = L7_2
            L14_2 = "heli"
            L12_2(L13_2, L14_2)
          end
        end
      else
        L1_2 = false
        if L1_2 then
          L1_2 = next
          L2_2 = L27_1
          L1_2 = L1_2(L2_2)
          if L1_2 then
            L1_2 = pairs
            L2_2 = L27_1
            L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
            for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
              L7_2 = SendNUIMessage
              L8_2 = {}
              L8_2.action = "stopAll3DFromSource"
              L8_2.sourceId = L5_2
              L7_2(L8_2)
            end
            L1_2 = {}
            L27_1 = L1_2
          end
          L0_2 = 1000
        end
      end
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = L0_2
      L1_2(L2_2)
    end
  end
  L28_1(L29_1)
  L28_1 = Citizen
  L28_1 = L28_1.CreateThread
  function L29_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 1000
      L0_2(L1_2)
      L0_2 = radioSystemAccess
      if L0_2 then
        L0_2 = false
        L1_2 = PlayerPedId
        L1_2 = L1_2()
        if L1_2 and 0 ~= L1_2 then
          L2_2 = GetVehiclePedIsIn
          L3_2 = L1_2
          L4_2 = false
          L2_2 = L2_2(L3_2, L4_2)
          if L2_2 and 0 ~= L2_2 then
            L3_2 = GetEntityModel
            L4_2 = L2_2
            L3_2 = L3_2(L4_2)
            L4_2 = IsThisModelAHeli
            L5_2 = L3_2
            L4_2 = L4_2(L5_2)
            if L4_2 then
              L4_2 = GetIsVehicleEngineRunning
              L5_2 = L2_2
              L4_2 = L4_2(L5_2)
              L0_2 = L4_2
            end
          end
        end
        L2_2 = L17_1
        if L0_2 ~= L2_2 then
          L17_1 = L0_2
          L2_2 = TriggerServerEvent
          L3_2 = "radioServer:updateHeliStatus"
          L4_2 = L0_2
          L2_2(L3_2, L4_2)
          L2_2 = log
          L3_2 = "Sent helicopter status update: "
          L4_2 = tostring
          L5_2 = L0_2
          L4_2 = L4_2(L5_2)
          L3_2 = L3_2 .. L4_2
          L4_2 = 4
          L2_2(L3_2, L4_2)
        end
      end
    end
  end
  L28_1(L29_1)
  L28_1 = 0
  L29_1 = 50
  L30_1 = AddEventHandler
  L31_1 = "CEventGunShot"
  function L32_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
    L3_2 = Config
    L3_2 = L3_2.playTransmissionEffects
    if not L3_2 then
      return
    end
    L3_2 = GetGameTimer
    L3_2 = L3_2()
    L4_2 = L28_1
    L4_2 = L3_2 - L4_2
    L5_2 = L29_1
    if L4_2 < L5_2 then
      L4_2 = log
      L5_2 = "Gunshot event debounced - too soon after last event ("
      L6_2 = L28_1
      L6_2 = L3_2 - L6_2
      L7_2 = "ms)"
      L5_2 = L5_2 .. L6_2 .. L7_2
      L6_2 = 4
      L4_2(L5_2, L6_2)
      return
    end
    L28_1 = L3_2
    L4_2 = log
    L5_2 = "CEventGunShot triggered - RadioState.talking: "
    L6_2 = tostring
    L7_2 = RadioState
    L7_2 = L7_2.talking
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 2
    L4_2(L5_2, L6_2)
    L4_2 = RadioState
    L4_2 = L4_2.talking
    if L4_2 then
      L4_2 = A1_2
      L5_2 = PlayerPedId
      L5_2 = L5_2()
      L6_2 = GetSelectedPedWeapon
      L7_2 = L4_2
      L6_2 = L6_2(L7_2)
      L7_2 = {}
      L8_2 = GetHashKey
      L9_2 = "WEAPON_STUNGUN"
      L8_2 = L8_2(L9_2)
      L7_2[L8_2] = true
      L8_2 = GetHashKey
      L9_2 = "WEAPON_FLAREGUN"
      L8_2 = L8_2(L9_2)
      L7_2[L8_2] = true
      L8_2 = GetHashKey
      L9_2 = "WEAPON_FIREEXTINGUISHER"
      L8_2 = L8_2(L9_2)
      L7_2[L8_2] = true
      L8_2 = GetHashKey
      L9_2 = "WEAPON_PETROLCAN"
      L8_2 = L8_2(L9_2)
      L7_2[L8_2] = true
      L8_2 = GetHashKey
      L9_2 = "WEAPON_SNOWBALL"
      L8_2 = L8_2(L9_2)
      L7_2[L8_2] = true
      L8_2 = GetHashKey
      L9_2 = "WEAPON_BALL"
      L8_2 = L8_2(L9_2)
      L7_2[L8_2] = true
      L8_2 = GetHashKey
      L9_2 = "WEAPON_SMOKEGRENADE"
      L8_2 = L8_2(L9_2)
      L7_2[L8_2] = true
      L8_2 = L7_2[L6_2]
      if L8_2 then
        L8_2 = log
        L9_2 = "Ignoring gunshot - weapon is non-lethal (hash: "
        L10_2 = L6_2
        L11_2 = ")"
        L9_2 = L9_2 .. L10_2 .. L11_2
        L10_2 = 4
        L8_2(L9_2, L10_2)
        return
      end
      L8_2 = GetEntityCoords
      L9_2 = L4_2
      L8_2 = L8_2(L9_2)
      L9_2 = GetEntityCoords
      L10_2 = L5_2
      L9_2 = L9_2(L10_2)
      L10_2 = L8_2 - L9_2
      L10_2 = #L10_2
      L11_2 = log
      L12_2 = "Gunshot detected during transmission from distance: "
      L13_2 = L10_2
      L14_2 = " with weapon hash: "
      L15_2 = L6_2
      L12_2 = L12_2 .. L13_2 .. L14_2 .. L15_2
      L13_2 = 2
      L11_2(L12_2, L13_2)
      L11_2 = TriggerServerEvent
      L12_2 = "radio:gunshotDuringTransmission"
      L13_2 = GetPlayerServerId
      L14_2 = PlayerId
      L14_2, L15_2 = L14_2()
      L13_2 = L13_2(L14_2, L15_2)
      L14_2 = L10_2
      L11_2(L12_2, L13_2, L14_2)
    else
      L4_2 = log
      L5_2 = "Gunshot detected but not transmitting - ignoring"
      L6_2 = 4
      L4_2(L5_2, L6_2)
    end
  end
  L30_1(L31_1, L32_1)
  L30_1 = Citizen
  L30_1 = L30_1.CreateThread
  function L31_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = Citizen
    L0_2 = L0_2.Wait
    L1_2 = 1000
    L0_2(L1_2)
    L0_2 = GetPlayerServerId
    L1_2 = PlayerId
    L1_2, L2_2, L3_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2)
    L1_2 = log
    L2_2 = "Client initializing for player "
    L3_2 = L0_2
    L2_2 = L2_2 .. L3_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = log
    L2_2 = "Sending initial radio access request"
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = TriggerServerEvent
    L2_2 = "radio:requestRadioAccess"
    L1_2(L2_2)
    L1_2 = log
    L2_2 = "Sending initial NAC ID request"
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = TriggerServerEvent
    L2_2 = "radio:requestUserNacId"
    L3_2 = L0_2
    L1_2(L2_2, L3_2)
    L1_2 = log
    L2_2 = "Sending initial player name request"
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = TriggerServerEvent
    L2_2 = "radio:requestPlayerName"
    L3_2 = L0_2
    L1_2(L2_2, L3_2)
    L1_2 = log
    L2_2 = "Requesting all player names"
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = TriggerServerEvent
    L2_2 = "radio:requestAllPlayerNames"
    L1_2(L2_2)
    L1_2 = log
    L2_2 = "Initial radio info and all player names requested"
    L3_2 = 3
    L1_2(L2_2, L3_2)
  end
  L30_1(L31_1)
  L30_1 = Citizen
  L30_1 = L30_1.CreateThread
  function L31_1()
    local L0_2, L1_2, L2_2, L3_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 5000
      L0_2(L1_2)
      L0_2 = GetPlayerServerId
      L1_2 = PlayerId
      L1_2, L2_2, L3_2 = L1_2()
      L0_2 = L0_2(L1_2, L2_2, L3_2)
      L1_2 = log
      L2_2 = "Sending periodic requests for player "
      L3_2 = L0_2
      L2_2 = L2_2 .. L3_2
      L3_2 = 4
      L1_2(L2_2, L3_2)
      L1_2 = TriggerServerEvent
      L2_2 = "radio:requestRadioAccess"
      L1_2(L2_2)
      L1_2 = TriggerServerEvent
      L2_2 = "radio:requestUserNacId"
      L3_2 = L0_2
      L1_2(L2_2, L3_2)
      L1_2 = log
      L2_2 = "Periodic radio access check"
      L3_2 = 4
      L1_2(L2_2, L3_2)
    end
  end
  L30_1(L31_1)
  L30_1 = {}
  L30_1.power = false
  L30_1.open = false
  L30_1.focused = false
  L30_1.volume = 50
  L31_1 = Config
  L31_1 = L31_1.sfxVolume
  if not L31_1 then
    L31_1 = 15
  end
  L30_1.toneVolume = L31_1
  L31_1 = Config
  L31_1 = L31_1.default3DVolume
  if not L31_1 then
    L31_1 = 50
  end
  L30_1.volume3D = L31_1
  L30_1.selectedZone = 1
  L31_1 = {}
  L31_1.zoneId = nil
  L31_1.channelId = nil
  L31_1.frequency = nil
  L30_1.connectedChannel = L31_1
  L30_1.tempScannedChannels = nil
  L30_1.activeTransmissionFreq = nil
  L30_1.txToneActive = false
  L31_1 = {}
  L30_1.scannedChannels = L31_1
  L31_1 = {}
  L30_1.scannedTrunkedFreqs = L31_1
  L30_1.isChannelTrunked = false
  L30_1.lastBonkTime = 0
  L30_1.lastPTTTime = 0
  L30_1.gpsEnabled = true
  L31_1 = Config
  L31_1 = L31_1.default3DAudio
  L31_1 = not L31_1
  L30_1.earbudsEnabled = L31_1
  L30_1.panicButton = false
  L30_1.connected = false
  L30_1.moveMode = false
  L31_1 = Config
  L31_1 = L31_1.defaultLayouts
  L31_1 = L31_1.Handheld
  L30_1.handheldModel = L31_1
  L31_1 = {}
  L31_1.x = 0
  L31_1.y = 0
  L31_1.s = 0
  L30_1.handheldPos = L31_1
  L30_1.theme = "Auto"
  L30_1.activeTalker = nil
  L30_1.connectedChannelTalker = nil
  L30_1.scannedChannelTalker = nil
  L30_1.pausedScanForConnectedTransmission = false
  L31_1 = {}
  L31_1.deviceId = "default"
  L31_1.label = "Default Microphone"
  L30_1.selectedMicrophone = L31_1
  L31_1 = {}
  L30_1.availableMicrophones = L31_1
  L30_1.selectedAnimation = 2
  L30_1.pttReleaseTimer = nil
  L31_1 = {}
  L31_1.isPlaying = false
  L31_1.radioProp = nil
  L30_1.radioAnimState = L31_1
  RadioState = L30_1
  function L30_1()
    local L0_2, L1_2, L2_2
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    if L0_2 and 0 ~= L0_2 then
      L1_2 = RadioState
      L1_2 = L1_2.radioAnimState
      L1_2 = L1_2.isPlaying
      if not L1_2 then
        L1_2 = RequestAnimDict
        L2_2 = "cellphone@"
        L1_2(L2_2)
        L1_2 = Citizen
        L1_2 = L1_2.CreateThread
        function L2_2()
          local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3
          L0_3 = 0
          while true do
            L1_3 = HasAnimDictLoaded
            L2_3 = "cellphone@"
            L1_3 = L1_3(L2_3)
            if not (not L1_3 and L0_3 < 50) then
              break
            end
            L1_3 = Citizen
            L1_3 = L1_3.Wait
            L2_3 = 10
            L1_3(L2_3)
            L0_3 = L0_3 + 1
          end
          L1_3 = HasAnimDictLoaded
          L2_3 = "cellphone@"
          L1_3 = L1_3(L2_3)
          if L1_3 then
            L1_3 = IsEntityPlayingAnim
            L2_3 = L0_2
            L3_3 = "cellphone@"
            L4_3 = "cellphone_call_to_text"
            L5_3 = 3
            L1_3 = L1_3(L2_3, L3_3, L4_3, L5_3)
            if not L1_3 then
              L1_3 = TaskPlayAnim
              L2_3 = L0_2
              L3_3 = "cellphone@"
              L4_3 = "cellphone_call_to_text"
              L5_3 = 8.0
              L6_3 = 2.0
              L7_3 = -1
              L8_3 = 50
              L9_3 = 2.0
              L10_3 = false
              L11_3 = false
              L12_3 = false
              L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3)
              L1_3 = RadioState
              L1_3 = L1_3.radioAnimState
              L2_3 = CreateObject
              L3_3 = GetHashKey
              L4_3 = "prop_cs_hand_radio"
              L3_3 = L3_3(L4_3)
              L4_3 = 0
              L5_3 = 0
              L6_3 = 0
              L7_3 = true
              L8_3 = true
              L9_3 = true
              L2_3 = L2_3(L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3)
              L1_3.radioProp = L2_3
              L1_3 = AttachEntityToEntity
              L2_3 = RadioState
              L2_3 = L2_3.radioAnimState
              L2_3 = L2_3.radioProp
              L3_3 = L0_2
              L4_3 = GetPedBoneIndex
              L5_3 = L0_2
              L6_3 = 28422
              L4_3 = L4_3(L5_3, L6_3)
              L5_3 = 0.0
              L6_3 = 0.0
              L7_3 = 0.0
              L8_3 = 0.0
              L9_3 = 0.0
              L10_3 = 0.0
              L11_3 = true
              L12_3 = true
              L13_3 = false
              L14_3 = true
              L15_3 = 1
              L16_3 = true
              L1_3(L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3, L11_3, L12_3, L13_3, L14_3, L15_3, L16_3)
              L1_3 = SetEntityAsMissionEntity
              L2_3 = RadioState
              L2_3 = L2_3.radioAnimState
              L2_3 = L2_3.radioProp
              L3_3 = true
              L4_3 = true
              L1_3(L2_3, L3_3, L4_3)
              L1_3 = RadioState
              L1_3 = L1_3.radioAnimState
              L1_3.isPlaying = true
            end
          end
        end
        L1_2(L2_2)
      end
    end
  end
  function L31_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = RadioState
    L1_2 = L1_2.radioAnimState
    L1_2 = L1_2.isPlaying
    if L1_2 and L0_2 and 0 ~= L0_2 then
      L1_2 = IsEntityPlayingAnim
      L2_2 = L0_2
      L3_2 = "cellphone@"
      L4_2 = "cellphone_call_to_text"
      L5_2 = 3
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
      if L1_2 then
        L1_2 = StopAnimTask
        L2_2 = L0_2
        L3_2 = "cellphone@"
        L4_2 = "cellphone_call_to_text"
        L5_2 = -4.0
        L1_2(L2_2, L3_2, L4_2, L5_2)
      end
      L1_2 = RadioState
      L1_2 = L1_2.radioAnimState
      L1_2 = L1_2.radioProp
      if L1_2 then
        L1_2 = DeleteObject
        L2_2 = RadioState
        L2_2 = L2_2.radioAnimState
        L2_2 = L2_2.radioProp
        L1_2(L2_2)
        L1_2 = RadioState
        L1_2 = L1_2.radioAnimState
        L1_2.radioProp = nil
      end
      L1_2 = RadioState
      L1_2 = L1_2.radioAnimState
      L1_2.isPlaying = false
    end
  end
  L32_1 = AddEventHandler
  L33_1 = "onResourceStop"
  function L34_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = GetCurrentResourceName
    L1_2 = L1_2()
    if L1_2 ~= A0_2 then
      return
    end
    L1_2 = print
    L2_2 = "The resource "
    L3_2 = A0_2
    L4_2 = " was stopped."
    L2_2 = L2_2 .. L3_2 .. L4_2
    L1_2(L2_2)
    L1_2 = L31_1
    L1_2()
  end
  L32_1(L33_1, L34_1)
  L32_1 = Citizen
  L32_1 = L32_1.CreateThread
  function L33_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 1000
      L0_2(L1_2)
      L0_2 = RadioState
      L0_2 = L0_2.focused
      L1_2 = RadioState
      L1_2 = L1_2.radioAnimState
      L1_2 = L1_2.isPlaying
      if L0_2 and not L1_2 then
        L2_2 = L30_1
        L2_2()
        L2_2 = log
        L3_2 = "Synced animation ON to match radio NUI focus state"
        L4_2 = 4
        L2_2(L3_2, L4_2)
      elseif not L0_2 and L1_2 then
        L2_2 = L31_1
        L2_2()
        L2_2 = log
        L3_2 = "Synced animation OFF to match radio NUI focus state"
        L4_2 = 4
        L2_2(L3_2, L4_2)
      end
    end
  end
  L32_1(L33_1)
  function L32_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L1_2 = A0_2.allowedNacs
    if L1_2 then
      L1_2 = A0_2.allowedNacs
      L1_2 = #L1_2
      if 0 ~= L1_2 then
        goto lbl_14
      end
    end
    L1_2 = radioSystemAccess
    L1_2 = true == L1_2
    do return L1_2 end
    ::lbl_14::
    L1_2 = L8_1
    if L1_2 then
      L1_2 = ipairs
      L2_2 = A0_2.allowedNacs
      L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
      for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
        L7_2 = L8_1
        if L7_2 == L6_2 then
          L7_2 = true
          return L7_2
        end
      end
    end
    L1_2 = false
    return L1_2
  end
  function L33_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L1_2 = L32_1
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if L1_2 then
      L1_2 = true
      return L1_2
    end
    L1_2 = A0_2.scanAllowedNacs
    if L1_2 then
      L1_2 = A0_2.scanAllowedNacs
      L1_2 = #L1_2
      if L1_2 > 0 then
        L1_2 = L8_1
        if L1_2 then
          L1_2 = ipairs
          L2_2 = A0_2.scanAllowedNacs
          L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
          for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
            L7_2 = L8_1
            if L7_2 == L6_2 then
              L7_2 = true
              return L7_2
            end
          end
        end
      end
    end
    L1_2 = false
    return L1_2
  end
  L34_1 = {}
  L35_1 = {}
  L36_1 = {}
  L36_1.key = "radio_setting_gps"
  L36_1.default = true
  function L37_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2.gpsEnabled = A0_2
  end
  L36_1.onLoad = L37_1
  L35_1.gps = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_earbuds"
  L37_1 = Config
  L37_1 = L37_1.default3DAudio
  L37_1 = not L37_1
  L36_1.default = L37_1
  function L37_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2.earbudsEnabled = A0_2
  end
  L36_1.onLoad = L37_1
  L35_1.earbuds = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_volume"
  L37_1 = Config
  L37_1 = L37_1.voiceVolume
  if not L37_1 then
    L37_1 = 50
  end
  L36_1.default = L37_1
  function L37_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2.volume = A0_2
  end
  L36_1.onLoad = L37_1
  L35_1.volume = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_tone_volume"
  L37_1 = Config
  L37_1 = L37_1.sfxVolume
  if not L37_1 then
    L37_1 = 15
  end
  L36_1.default = L37_1
  function L37_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2.toneVolume = A0_2
  end
  L36_1.onLoad = L37_1
  L35_1.toneVolume = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_3d_volume"
  L37_1 = Config
  L37_1 = L37_1.default3DVolume
  if not L37_1 then
    L37_1 = 50
  end
  L36_1.default = L37_1
  function L37_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2.volume3D = A0_2
  end
  L36_1.onLoad = L37_1
  L35_1.volume3D = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_handheld_model"
  L37_1 = json
  L37_1 = L37_1.encode
  L38_1 = {}
  L39_1 = Config
  L39_1 = L39_1.defaultLayouts
  L39_1 = L39_1.Handheld
  L38_1.model = L39_1
  L38_1.x = 0
  L38_1.y = 0
  L38_1.s = 0
  L37_1 = L37_1(L38_1)
  L36_1.default = L37_1
  function L37_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = json
    L1_2 = L1_2.decode
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L2_2 = Settings
      L2_2 = L2_2.saveSetting
      L3_2 = "radioHandheldModel"
      L4_2 = Settings
      L4_2 = L4_2.definitions
      L4_2 = L4_2.radioHandheldModel
      L4_2 = L4_2.default
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = doesTableContain
    L3_2 = Config
    L3_2 = L3_2.radioLayouts
    L4_2 = L1_2.model
    L2_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      L2_2 = RadioState
      L3_2 = Config
      L3_2 = L3_2.defaultLayouts
      L3_2 = L3_2.Handheld
      L2_2.handheldModel = L3_2
    else
      L2_2 = RadioState
      L3_2 = L1_2.model
      L2_2.handheldModel = L3_2
    end
    L2_2 = RadioState
    L3_2 = {}
    L4_2 = L1_2.x
    L3_2.x = L4_2
    L4_2 = L1_2.y
    L3_2.y = L4_2
    L4_2 = L1_2.s
    L3_2.s = L4_2
    L2_2.handheldPos = L3_2
  end
  L36_1.onLoad = L37_1
  L35_1.radioHandheldModel = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_selected_microphone"
  L37_1 = json
  L37_1 = L37_1.encode
  L38_1 = {}
  L38_1.deviceId = "default"
  L38_1.label = "Default Microphone"
  L37_1 = L37_1(L38_1)
  L36_1.default = L37_1
  function L37_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = json
    L1_2 = L1_2.decode
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      L2_2 = Settings
      L2_2 = L2_2.saveSetting
      L3_2 = "selectedMicrophone"
      L4_2 = Settings
      L4_2 = L4_2.definitions
      L4_2 = L4_2.selectedMicrophone
      L4_2 = L4_2.default
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = RadioState
    L2_2.selectedMicrophone = L1_2
  end
  L36_1.onLoad = L37_1
  L35_1.selectedMicrophone = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_theme"
  L36_1.default = "Auto"
  function L37_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2.theme = A0_2
  end
  L36_1.onLoad = L37_1
  L35_1.theme = L36_1
  L36_1 = {}
  L36_1.key = "radio_setting_animation"
  L36_1.default = 2
  function L37_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = RadioState
    L2_2 = tonumber
    L3_2 = A0_2
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = 2
    end
    L1_2.selectedAnimation = L2_2
  end
  L36_1.onLoad = L37_1
  L35_1.selectedAnimation = L36_1
  L34_1.definitions = L35_1
  function L35_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = Settings
    L1_2 = L1_2.definitions
    L1_2 = L1_2[A0_2]
    if not L1_2 then
      return
    end
    L2_2 = GetResourceKvpString
    L3_2 = L1_2.key
    L2_2 = L2_2(L3_2)
    if nil == L2_2 then
      L2_2 = L1_2.default
    else
      L3_2 = type
      L4_2 = L1_2.default
      L3_2 = L3_2(L4_2)
      if "boolean" == L3_2 then
        L2_2 = "true" == L2_2
      else
        L3_2 = type
        L4_2 = L1_2.default
        L3_2 = L3_2(L4_2)
        if "number" == L3_2 then
          L3_2 = convertFreq
          L4_2 = L2_2
          L3_2 = L3_2(L4_2)
          L2_2 = L3_2
        end
      end
    end
    L3_2 = L1_2.onLoad
    if L3_2 then
      L3_2 = L1_2.onLoad
      L4_2 = L2_2
      L3_2(L4_2)
    end
    return L2_2
  end
  L34_1.loadSetting = L35_1
  function L35_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2
    L2_2 = Settings
    L2_2 = L2_2.definitions
    L2_2 = L2_2[A0_2]
    if not L2_2 then
      return
    end
    L3_2 = SetResourceKvp
    L4_2 = L2_2.key
    L5_2 = tostring
    L6_2 = A1_2
    L5_2, L6_2 = L5_2(L6_2)
    L3_2(L4_2, L5_2, L6_2)
  end
  L34_1.saveSetting = L35_1
  function L35_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L0_2 = pairs
    L1_2 = Settings
    L1_2 = L1_2.definitions
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = Settings
      L6_2 = L6_2.loadSetting
      L7_2 = L4_2
      L6_2(L7_2)
    end
  end
  L34_1.loadAll = L35_1
  function L35_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    if not A0_2 then
      return
    end
    L2_2 = "radio_"
    L3_2 = A0_2
    L4_2 = "_model"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L3_2 = SetResourceKvp
    L4_2 = L2_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
  end
  L34_1.saveVehicleSpawnCodeModel = L35_1
  function L35_1(A0_2)
    local L1_2, L2_2, L3_2
    if not A0_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = "radio_"
    L2_2 = A0_2
    L3_2 = "_model"
    L1_2 = L1_2 .. L2_2 .. L3_2
    L2_2 = GetResourceKvpString
    L3_2 = L1_2
    return L2_2(L3_2)
  end
  L34_1.loadVehicleSpawnCodeModel = L35_1
  function L35_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    if not A0_2 then
      return
    end
    L2_2 = "radio_model_"
    L3_2 = A0_2
    L4_2 = "_position"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L3_2 = {}
    L4_2 = A1_2.x
    if not L4_2 then
      L4_2 = 0
    end
    L3_2.x = L4_2
    L4_2 = A1_2.y
    if not L4_2 then
      L4_2 = 0
    end
    L3_2.y = L4_2
    L4_2 = A1_2.s
    if not L4_2 then
      L4_2 = 0
    end
    L3_2.s = L4_2
    L4_2 = SetResourceKvp
    L5_2 = L2_2
    L6_2 = json
    L6_2 = L6_2.encode
    L7_2 = L3_2
    L6_2, L7_2 = L6_2(L7_2)
    L4_2(L5_2, L6_2, L7_2)
  end
  L34_1.saveModelPosition = L35_1
  function L35_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    if not A0_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = "radio_model_"
    L2_2 = A0_2
    L3_2 = "_position"
    L1_2 = L1_2 .. L2_2 .. L3_2
    L2_2 = GetResourceKvpString
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    if L2_2 then
      L3_2 = json
      L3_2 = L3_2.decode
      L4_2 = L2_2
      return L3_2(L4_2)
    end
    L3_2 = nil
    return L3_2
  end
  L34_1.loadModelPosition = L35_1
  function L35_1(A0_2, A1_2)
    local L2_2
    if A0_2 then
      L2_2 = Config
      L2_2 = L2_2.defaultLayouts
      L2_2 = L2_2[A0_2]
      if L2_2 then
        L2_2 = Config
        L2_2 = L2_2.defaultLayouts
        L2_2 = L2_2[A0_2]
        return L2_2
      end
    end
    L2_2 = Config
    L2_2 = L2_2.defaultLayouts
    L2_2 = L2_2[A1_2]
    return L2_2
  end
  L34_1.getDefaultModelForVehicle = L35_1
  function L35_1()
    local L0_2, L1_2
    L0_2 = getCurrentVehicleType
    L0_2 = L0_2()
    if "Handheld" == L0_2 then
      L1_2 = RadioState
      L1_2 = L1_2.handheldModel
      return L1_2
    else
      L1_2 = getCurrentRadioModel
      return L1_2()
    end
  end
  L34_1.getCurrentVehicleModel = L35_1
  function L35_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2
    if "Handheld" == A0_2 then
      L2_2 = RadioState
      L2_2 = L2_2.handheldModel
      L3_2 = Settings
      L3_2 = L3_2.loadModelPosition
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if not L3_2 then
        L4_2 = {}
        L4_2.x = 0
        L4_2.y = 0
        L4_2.s = 0
        L3_2 = L4_2
      end
      L4_2 = L2_2
      L5_2 = L3_2
      return L4_2, L5_2
    end
    L2_2 = nil
    L3_2 = Settings
    L3_2 = L3_2.loadVehicleSpawnCodeModel
    L4_2 = A1_2
    L3_2 = L3_2(L4_2)
    if L3_2 then
      L4_2 = doesTableContain
      L5_2 = Config
      L5_2 = L5_2.radioLayouts
      L6_2 = L3_2
      L4_2 = L4_2(L5_2, L6_2)
      if L4_2 then
        L2_2 = L3_2
    end
    else
      L4_2 = Settings
      L4_2 = L4_2.getDefaultModelForVehicle
      L5_2 = A1_2
      L6_2 = A0_2
      L4_2 = L4_2(L5_2, L6_2)
      L2_2 = L4_2
    end
    L4_2 = Settings
    L4_2 = L4_2.loadModelPosition
    L5_2 = L2_2
    L4_2 = L4_2(L5_2)
    if not L4_2 then
      L5_2 = {}
      L5_2.x = 0
      L5_2.y = 0
      L5_2.s = 0
      L4_2 = L5_2
    end
    L5_2 = L2_2
    L6_2 = L4_2
    return L5_2, L6_2
  end
  L34_1.initializeVehicleModel = L35_1
  Settings = L34_1
  L34_1 = {}
  L34_1.currentPage = "main"
  L34_1.line1 = ""
  L34_1.line2 = ""
  L35_1 = {}
  L35_1.btn1 = ""
  L35_1.btn2 = ""
  L35_1.btn3 = ""
  L34_1.buttons = L35_1
  function L35_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L2_2 = ipairs
    L3_2 = RadioState
    L3_2 = L3_2.scannedChannels
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = L7_2.zoneId
      if L8_2 == A0_2 then
        L8_2 = L7_2.channelId
        if L8_2 == A1_2 then
          L8_2 = true
          return L8_2
        end
      end
    end
    L2_2 = false
    return L2_2
  end
  function L36_1()
    local L0_2, L1_2
    L0_2 = next
    L1_2 = RadioState
    L1_2 = L1_2.scannedChannels
    L0_2 = L0_2(L1_2)
    L0_2 = nil ~= L0_2
    return L0_2
  end
  function L37_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
    L1_2 = ipairs
    L2_2 = Config
    L2_2 = L2_2.zones
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = ipairs
      L8_2 = L6_2.Channels
      L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
      for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
        L13_2 = convertFreq
        L14_2 = L12_2.frequency
        L13_2 = L13_2(L14_2)
        L14_2 = convertFreq
        L15_2 = A0_2
        L14_2 = L14_2(L15_2)
        if L13_2 == L14_2 then
          L13_2 = {}
          L13_2.zoneId = L5_2
          L13_2.channelId = L11_2
          L13_2.channel = L12_2
          return L13_2
        end
      end
    end
    L1_2 = nil
    return L1_2
  end
  function L38_1(A0_2, A1_2)
    local L2_2
    L2_2 = Config
    L2_2 = L2_2.zones
    L2_2 = L2_2[A0_2]
    L2_2 = L2_2.Channels
    L2_2 = L2_2[A1_2]
    return L2_2
  end
  function L39_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if not L0_2 then
      L0_2 = nil
      return L0_2
    end
    L0_2 = L38_1
    L1_2 = RadioState
    L1_2 = L1_2.connectedChannel
    L1_2 = L1_2.zoneId
    L2_2 = RadioState
    L2_2 = L2_2.connectedChannel
    L2_2 = L2_2.channelId
    return L0_2(L1_2, L2_2)
  end
  function L40_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.connectedChannel
    L0_2 = L0_2.zoneId
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.connectedChannel
      L0_2 = L0_2.channelId
      if L0_2 then
        goto lbl_13
      end
    end
    L0_2 = nil
    do return L0_2 end
    ::lbl_13::
    L0_2 = Config
    L0_2 = L0_2.zones
    L1_2 = RadioState
    L1_2 = L1_2.connectedChannel
    L1_2 = L1_2.zoneId
    L0_2 = L0_2[L1_2]
    if not L0_2 then
      L1_2 = nil
      return L1_2
    end
    L1_2 = L0_2.Channels
    L2_2 = RadioState
    L2_2 = L2_2.connectedChannel
    L2_2 = L2_2.channelId
    L1_2 = L1_2[L2_2]
    return L1_2
  end
  L41_1 = nil
  function L42_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      L0_2 = dispUpdate
      L1_2 = ""
      L2_2 = ""
      L3_2 = ""
      L4_2 = ""
      L5_2 = ""
      L6_2 = ""
      L7_2 = ""
      L8_2 = ""
      L9_2 = ""
      L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
      L0_2 = setBatt
      L1_2 = "hidden"
      L0_2(L1_2)
      L0_2 = setSignal
      L1_2 = false
      L0_2(L1_2)
      L0_2 = setGPS
      L1_2 = false
      L0_2(L1_2)
      L0_2 = setTrunk
      L1_2 = false
      L0_2(L1_2)
      L0_2 = setWarn
      L1_2 = false
      L0_2(L1_2)
      L0_2 = updateTime
      L0_2()
      L0_2 = setScan
      L1_2 = false
      L0_2(L1_2)
      return
    end
    L1_2 = L34_1.currentPage
    L0_2 = L41_1
    L0_2 = L0_2[L1_2]
    L1_2 = nil
    if L0_2 then
      L2_2 = L0_2.display
      if L2_2 then
        L3_2 = L0_2
        L2_2 = L0_2.display
        L2_2 = L2_2(L3_2)
        L1_2 = L2_2
      end
    end
    L2_2 = ""
    L3_2 = ""
    L4_2 = ""
    L5_2 = ""
    if L0_2 then
      L6_2 = L0_2.buttons
      if L6_2 then
        L6_2 = L0_2.buttons
        L6_2 = L6_2.btn1
        if L6_2 then
          L6_2 = L0_2.buttons
          L6_2 = L6_2.btn1
          L6_2 = L6_2.text
          if L6_2 then
            L6_2 = type
            L7_2 = L0_2.buttons
            L7_2 = L7_2.btn1
            L7_2 = L7_2.text
            L6_2 = L6_2(L7_2)
            if "function" == L6_2 then
              L6_2 = L0_2.buttons
              L6_2 = L6_2.btn1
              L6_2 = L6_2.text
              L7_2 = L0_2
              L6_2 = L6_2(L7_2)
              if L6_2 then
                goto lbl_84
                L2_2 = L6_2 or L2_2
              end
            end
            L6_2 = L0_2.buttons
            L6_2 = L6_2.btn1
            L2_2 = L6_2.text
          end
        end
        ::lbl_84::
        L6_2 = L0_2.buttons
        L6_2 = L6_2.btn2
        if L6_2 then
          L6_2 = L0_2.buttons
          L6_2 = L6_2.btn2
          L6_2 = L6_2.text
          if L6_2 then
            L6_2 = type
            L7_2 = L0_2.buttons
            L7_2 = L7_2.btn2
            L7_2 = L7_2.text
            L6_2 = L6_2(L7_2)
            if "function" == L6_2 then
              L6_2 = L0_2.buttons
              L6_2 = L6_2.btn2
              L6_2 = L6_2.text
              L7_2 = L0_2
              L6_2 = L6_2(L7_2)
              if L6_2 then
                goto lbl_110
                L3_2 = L6_2 or L3_2
              end
            end
            L6_2 = L0_2.buttons
            L6_2 = L6_2.btn2
            L3_2 = L6_2.text
          end
        end
        ::lbl_110::
        L6_2 = L0_2.buttons
        L6_2 = L6_2.btn3
        if L6_2 then
          L6_2 = L0_2.buttons
          L6_2 = L6_2.btn3
          L6_2 = L6_2.text
          if L6_2 then
            L6_2 = type
            L7_2 = L0_2.buttons
            L7_2 = L7_2.btn3
            L7_2 = L7_2.text
            L6_2 = L6_2(L7_2)
            if "function" == L6_2 then
              L6_2 = L0_2.buttons
              L6_2 = L6_2.btn3
              L6_2 = L6_2.text
              L7_2 = L0_2
              L6_2 = L6_2(L7_2)
              if L6_2 then
                goto lbl_136
                L4_2 = L6_2 or L4_2
              end
            end
            L6_2 = L0_2.buttons
            L6_2 = L6_2.btn3
            L4_2 = L6_2.text
          end
        end
        ::lbl_136::
        L6_2 = L0_2.buttons
        L6_2 = L6_2.btn4
        if L6_2 then
          L6_2 = L0_2.buttons
          L6_2 = L6_2.btn4
          L6_2 = L6_2.text
          if L6_2 then
            L6_2 = type
            L7_2 = L0_2.buttons
            L7_2 = L7_2.btn4
            L7_2 = L7_2.text
            L6_2 = L6_2(L7_2)
            if "function" == L6_2 then
              L6_2 = L0_2.buttons
              L6_2 = L6_2.btn4
              L6_2 = L6_2.text
              L7_2 = L0_2
              L6_2 = L6_2(L7_2)
              if L6_2 then
                goto lbl_162
                L5_2 = L6_2 or L5_2
              end
            end
            L6_2 = L0_2.buttons
            L6_2 = L6_2.btn4
            L5_2 = L6_2.text
          end
        end
      end
    end
    ::lbl_162::
    L6_2 = nil
    L7_2 = nil
    L8_2 = nil
    L9_2 = nil
    L10_2 = RadioState
    L10_2 = L10_2.connected
    if not L10_2 then
      L10_2 = L41_1.main
      if L0_2 == L10_2 then
        L10_2 = L36_1
        L10_2 = L10_2()
        if not L10_2 then
          if L1_2 and L1_2.line1 then
            L6_2 = L1_2.line1
          else
            L6_2 = "NOT"
          end
          if L1_2 and L1_2.line2 then
            L7_2 = L1_2.line2
          else
            L7_2 = "CONNECTED"
          end
          L8_2 = ""
          L9_2 = ""
      end
    end
    else
      L10_2 = L36_1
      L10_2 = L10_2()
      if L10_2 then
        L10_2 = RadioState
        L10_2 = L10_2.connected
        if not L10_2 then
          L10_2 = L41_1.main
          if L0_2 == L10_2 then
            L10_2 = RadioState
            L10_2 = L10_2.activeTalker
            if L10_2 then
              L10_2 = RadioState
              L10_2 = L10_2.scannedChannelTalker
              if L10_2 then
                L10_2 = getPlayerName
                L11_2 = RadioState
                L11_2 = L11_2.activeTalker
                L10_2 = L10_2(L11_2)
                L6_2 = "SCANNING"
                L11_2 = "SC: "
                L12_2 = L10_2
                L11_2 = L11_2 .. L12_2
                L7_2 = L11_2
            end
            else
              L10_2 = {}
              L11_2 = ipairs
              L12_2 = RadioState
              L12_2 = L12_2.scannedChannels
              L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
              for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
                L17_2 = table
                L17_2 = L17_2.insert
                L18_2 = L10_2
                L19_2 = {}
                L20_2 = Config
                L20_2 = L20_2.zones
                L21_2 = L16_2.zoneId
                L20_2 = L20_2[L21_2]
                L20_2 = L20_2.name
                L19_2.zone = L20_2
                L20_2 = Config
                L20_2 = L20_2.zones
                L21_2 = L16_2.zoneId
                L20_2 = L20_2[L21_2]
                L20_2 = L20_2.Channels
                L21_2 = L16_2.channelId
                L20_2 = L20_2[L21_2]
                L20_2 = L20_2.name
                L19_2.channel = L20_2
                L17_2(L18_2, L19_2)
              end
              L11_2 = #L10_2
              if 1 == L11_2 then
                L6_2 = "SCANNING"
                L11_2 = string
                L11_2 = L11_2.format
                L12_2 = "%s-%s"
                L13_2 = L10_2[1]
                L13_2 = L13_2.zone
                L14_2 = L10_2[1]
                L14_2 = L14_2.channel
                L11_2 = L11_2(L12_2, L13_2, L14_2)
                L7_2 = L11_2
              else
                L6_2 = "SCANNING"
                L11_2 = string
                L11_2 = L11_2.format
                L12_2 = "%d CHANNELS"
                L13_2 = #L10_2
                L11_2 = L11_2(L12_2, L13_2)
                L7_2 = L11_2
              end
            end
        end
      end
      else
        if L1_2 and L1_2.line1 then
          L6_2 = L1_2.line1
        else
          L6_2 = ""
        end
        if L1_2 and L1_2.line2 then
          L7_2 = L1_2.line2
        else
          L7_2 = ""
        end
        L10_2 = Config
        L10_2 = L10_2.zones
        L11_2 = RadioState
        L11_2 = L11_2.selectedZone
        L10_2 = L10_2[L11_2]
        if L10_2 then
          L8_2 = L10_2.name or ""
        else
          L8_2 = ""
        end
        L10_2 = L40_1
        L10_2 = L10_2()
        if L10_2 and L10_2.name then
          L9_2 = L10_2.name
        else
          L9_2 = ""
        end
      end
    end
    ::lbl_290::
    L10_2 = setBatt
    L11_2 = GetBatteryDisplayLevel
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L11_2()
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L10_2 = updateTime
    L10_2()
    L10_2 = setSignal
    L11_2 = GetSignalStrength
    L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2 = L11_2()
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2)
    L10_2 = setGPS
    L11_2 = RadioState
    L11_2 = L11_2.gpsEnabled
    L10_2(L11_2)
    L10_2 = setTrunk
    L11_2 = RadioState
    L11_2 = L11_2.isChannelTrunked
    L10_2(L11_2)
    L10_2 = setScan
    L11_2 = next
    L12_2 = RadioState
    L12_2 = L12_2.scannedChannels
    L11_2 = L11_2(L12_2)
    L11_2 = nil ~= L11_2
    L10_2(L11_2)
    L10_2 = dispUpdate
    L11_2 = L2_2
    L12_2 = L3_2
    L13_2 = L4_2
    L14_2 = L5_2
    L15_2 = ""
    L16_2 = L6_2
    L17_2 = L7_2
    L18_2 = L8_2
    L19_2 = L9_2
    L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2)
  end
  function L43_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L1_2 = L41_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L34_1.currentPage = A0_2
      L1_2 = L41_1
      L1_2 = L1_2[A0_2]
      L1_2 = L1_2.init
      if L1_2 then
        L1_2 = L41_1
        L1_2 = L1_2[A0_2]
        L2_2 = L1_2
        L1_2 = L1_2.init
        L1_2(L2_2)
      end
      if "settings" == A0_2 then
        L1_2 = ipairs
        L2_2 = L41_1.settings
        L2_2 = L2_2.options
        L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
        for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
          L7_2 = L6_2.init
          if L7_2 then
            L8_2 = L6_2
            L7_2 = L6_2.init
            L7_2(L8_2)
          end
        end
      end
      L1_2 = L42_1
      L1_2()
    end
  end
  function L44_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L1_2 = 0
    L2_2 = pairs
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2 in L2_2, L3_2, L4_2, L5_2 do
      L1_2 = L1_2 + 1
    end
    return L1_2
  end
  function L45_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = IsPedInAnyVehicle
    L2_2 = L0_2
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = GetVehiclePedIsIn
      L2_2 = L0_2
      L3_2 = false
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = GetEntityModel
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      L3_2 = IsThisModelABoat
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = "Boat"
        return L3_2
      else
        L3_2 = IsThisModelAPlane
        L4_2 = L2_2
        L3_2 = L3_2(L4_2)
        if not L3_2 then
          L3_2 = IsThisModelAHeli
          L4_2 = L2_2
          L3_2 = L3_2(L4_2)
          if not L3_2 then
            goto lbl_37
          end
        end
        L3_2 = "Air"
        do return L3_2 end
        goto lbl_39
        ::lbl_37::
        L3_2 = "Vehicle"
        return L3_2
      end
    end
    ::lbl_39::
    L1_2 = "Handheld"
    return L1_2
  end
  function L46_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = IsPedInAnyVehicle
    L2_2 = L0_2
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    if L1_2 then
      L1_2 = GetVehiclePedIsIn
      L2_2 = L0_2
      L3_2 = false
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = GetEntityModel
      L3_2 = L1_2
      L2_2 = L2_2(L3_2)
      L3_2 = GetDisplayNameFromVehicleModel
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      L4_2 = L3_2
      L3_2 = L3_2.lower
      return L3_2(L4_2)
    end
    L1_2 = nil
    return L1_2
  end
  function L47_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
    L0_2 = L45_1
    L0_2 = L0_2()
    if "Handheld" == L0_2 then
      L1_2 = RadioState
      L1_2 = L1_2.handheldModel
      return L1_2
    else
      L1_2 = L46_1
      L1_2 = L1_2()
      if L1_2 then
        L2_2 = Settings
        L2_2 = L2_2.loadVehicleSpawnCodeModel
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L3_2 = doesTableContain
          L4_2 = Config
          L4_2 = L4_2.radioLayouts
          L5_2 = L2_2
          L3_2 = L3_2(L4_2, L5_2)
          if L3_2 then
            return L2_2
          end
        end
        L3_2 = Config
        L3_2 = L3_2.defaultLayouts
        L3_2 = L3_2[L1_2]
        if L3_2 then
          L3_2 = Config
          L3_2 = L3_2.defaultLayouts
          L3_2 = L3_2[L1_2]
          return L3_2
        end
      end
      L2_2 = Config
      L2_2 = L2_2.defaultLayouts
      L2_2 = L2_2[L0_2]
      return L2_2
    end
    L1_2 = Config
    L1_2 = L1_2.defaultLayouts
    L1_2 = L1_2[L0_2]
    return L1_2
  end
  function L48_1(A0_2)
    local L1_2, L2_2
    if "Auto" == A0_2 then
      L1_2 = GetClockHours
      L1_2 = L1_2()
      if L1_2 >= 20 or L1_2 < 6 then
        L2_2 = "Dark"
        return L2_2
      else
        L2_2 = "Light"
        return L2_2
      end
    end
    return A0_2
  end
  function L49_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L2_2 = ipairs
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      if L7_2 == A1_2 then
        return L6_2
      end
    end
    L2_2 = 1
    return L2_2
  end
  function L50_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L1_2 = L1_2[A0_2]
    L2_2 = {}
    L3_2 = L1_2.nacIds
    if L3_2 then
      L3_2 = L1_2.nacIds
      L3_2 = #L3_2
      if L3_2 > 0 then
        L3_2 = false
        L4_2 = L8_1
        if L4_2 then
          L4_2 = ipairs
          L5_2 = L1_2.nacIds
          L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
          for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
            L10_2 = L8_1
            if L10_2 == L9_2 then
              L3_2 = true
              break
            end
          end
        end
        if not L3_2 then
          return L2_2
        end
    end
    else
      L3_2 = radioSystemAccess
      if true ~= L3_2 then
        return L2_2
      end
    end
    L3_2 = ipairs
    L4_2 = L1_2.Channels
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = L32_1
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if L9_2 then
        L2_2[L7_2] = L8_2
      end
    end
    return L2_2
  end
  function L51_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L1_2 = L1_2[A0_2]
    L2_2 = {}
    L3_2 = L1_2.nacIds
    if L3_2 then
      L3_2 = L1_2.nacIds
      L3_2 = #L3_2
      if L3_2 > 0 then
        L3_2 = false
        L4_2 = L8_1
        if L4_2 then
          L4_2 = ipairs
          L5_2 = L1_2.nacIds
          L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
          for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
            L10_2 = L8_1
            if L10_2 == L9_2 then
              L3_2 = true
              break
            end
          end
        end
        if not L3_2 then
          return L2_2
        end
    end
    else
      L3_2 = radioSystemAccess
      if true ~= L3_2 then
        return L2_2
      end
    end
    L3_2 = ipairs
    L4_2 = L1_2.Channels
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = L33_1
      L10_2 = L8_2
      L9_2 = L9_2(L10_2)
      if L9_2 then
        L2_2[L7_2] = L8_2
      end
    end
    return L2_2
  end
  function L52_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    L1_2 = setWarn
    L2_2 = false
    L1_2(L2_2)
    L1_2 = RadioState
    L1_2 = L1_2.power
    if not L1_2 then
      return
    end
    L1_2 = radioSystemAccess
    if true ~= L1_2 then
      return
    end
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "stopAllTransmissions"
    L1_2(L2_2)
    L1_2 = RadioState
    L1_2 = L1_2.pttReleaseTimer
    if L1_2 then
      L1_2 = Citizen
      L1_2 = L1_2.ClearTimeout
      L2_2 = RadioState
      L2_2 = L2_2.pttReleaseTimer
      L1_2(L2_2)
      L1_2 = RadioState
      L1_2.pttReleaseTimer = nil
      L1_2 = SendNUIMessage
      L2_2 = {}
      L2_2.action = "setTalking"
      L2_2.talking = false
      L2_2.suppressTone = true
      L1_2(L2_2)
      L1_2 = TriggerEvent
      L2_2 = "radio:stopAllSirens"
      L1_2(L2_2)
      L1_2 = RadioState
      L1_2 = L1_2.tempScannedChannels
      if L1_2 then
        L1_2 = ipairs
        L2_2 = RadioState
        L2_2 = L2_2.tempScannedChannels
        L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
        for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
          L7_2 = Config
          L7_2 = L7_2.zones
          L8_2 = L6_2.zoneId
          L7_2 = L7_2[L8_2]
          if L7_2 then
            L7_2 = Config
            L7_2 = L7_2.zones
            L8_2 = L6_2.zoneId
            L7_2 = L7_2[L8_2]
            L7_2 = L7_2.Channels
            L8_2 = L6_2.channelId
            L7_2 = L7_2[L8_2]
          end
          if L7_2 then
            L8_2 = Radio
            L8_2 = L8_2.addListeningChannel
            L9_2 = convertFreq
            L10_2 = L7_2.frequency
            L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2)
            L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
            L8_2 = L7_2.type
            if "trunked" == L8_2 then
              L8_2 = RadioState
              L8_2 = L8_2.scannedTrunkedFreqs
              if L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.scannedTrunkedFreqs
                L9_2 = L6_2.channelId
                L8_2 = L8_2[L9_2]
                if L8_2 then
                  L8_2 = Radio
                  L8_2 = L8_2.addListeningChannel
                  L9_2 = convertFreq
                  L10_2 = RadioState
                  L10_2 = L10_2.scannedTrunkedFreqs
                  L11_2 = L6_2.channelId
                  L10_2 = L10_2[L11_2]
                  L9_2, L10_2, L11_2, L12_2, L13_2 = L9_2(L10_2)
                  L8_2(L9_2, L10_2, L11_2, L12_2, L13_2)
                end
              end
            end
          end
        end
        L1_2 = RadioState
        L1_2.tempScannedChannels = nil
      end
    end
    L1_2 = setLED
    L2_2 = "transmit"
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = RadioState
    L1_2.activeTalker = nil
    L1_2 = RadioState
    L1_2.connectedChannelTalker = nil
    L1_2 = RadioState
    L1_2.scannedChannelTalker = nil
    L1_2 = RadioState
    L1_2.activeTransmissionFreq = nil
    L1_2 = RadioState
    L1_2.pausedScanForConnectedTransmission = false
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "stopAllTransmissions"
    L1_2(L2_2)
    L1_2 = RadioState
    L1_2 = L1_2.connected
    if L1_2 then
      L1_2 = RadioState
      L1_2 = L1_2.connectedChannel
      L1_2 = L1_2.frequency
      if L1_2 then
        L1_2 = TriggerServerEvent
        L2_2 = "radioServer:setPanicOnChannel"
        L3_2 = RadioState
        L3_2 = L3_2.connectedChannel
        L3_2 = L3_2.frequency
        L4_2 = false
        L1_2(L2_2, L3_2, L4_2)
      end
      L1_2 = Radio
      L1_2 = L1_2.removeListeningChannel
      L2_2 = convertFreq
      L3_2 = RadioState
      L3_2 = L3_2.connectedChannel
      L3_2 = L3_2.frequency
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L2_2(L3_2)
      L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L1_2 = RadioState
      L1_2 = L1_2.isChannelTrunked
      if L1_2 then
        L1_2 = Config
        L1_2 = L1_2.zones
        L2_2 = RadioState
        L2_2 = L2_2.connectedChannel
        L2_2 = L2_2.zoneId
        L1_2 = L1_2[L2_2]
        L2_2 = L1_2 or L2_2
        if L1_2 then
          L2_2 = L1_2.Channels
          L3_2 = RadioState
          L3_2 = L3_2.connectedChannel
          L3_2 = L3_2.channelId
          L2_2 = L2_2[L3_2]
        end
        if L2_2 then
          L3_2 = Radio
          L3_2 = L3_2.removeListeningChannel
          L4_2 = convertFreq
          L5_2 = L2_2.frequency
          L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2(L5_2)
          L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
          L3_2 = RadioState
          L3_2 = L3_2.scannedTrunkedFreqs
          if L3_2 then
            L3_2 = RadioState
            L3_2 = L3_2.scannedTrunkedFreqs
            L4_2 = RadioState
            L4_2 = L4_2.connectedChannel
            L4_2 = L4_2.channelId
            L3_2 = L3_2[L4_2]
            if L3_2 then
              L3_2 = Radio
              L3_2 = L3_2.removeListeningChannel
              L4_2 = convertFreq
              L5_2 = RadioState
              L5_2 = L5_2.scannedTrunkedFreqs
              L6_2 = RadioState
              L6_2 = L6_2.connectedChannel
              L6_2 = L6_2.channelId
              L5_2 = L5_2[L6_2]
              L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L4_2(L5_2)
              L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
              L3_2 = RadioState
              L3_2 = L3_2.scannedTrunkedFreqs
              L4_2 = RadioState
              L4_2 = L4_2.connectedChannel
              L4_2 = L4_2.channelId
              L3_2[L4_2] = nil
            end
          end
          L3_2 = RadioState
          L3_2 = L3_2.scannedChannels
          L3_2 = #L3_2
          L4_2 = 1
          L5_2 = -1
          for L6_2 = L3_2, L4_2, L5_2 do
            L7_2 = RadioState
            L7_2 = L7_2.scannedChannels
            L7_2 = L7_2[L6_2]
            L8_2 = L7_2.zoneId
            L9_2 = RadioState
            L9_2 = L9_2.connectedChannel
            L9_2 = L9_2.zoneId
            if L8_2 == L9_2 then
              L8_2 = L7_2.channelId
              L9_2 = RadioState
              L9_2 = L9_2.connectedChannel
              L9_2 = L9_2.channelId
              if L8_2 == L9_2 then
                L8_2 = table
                L8_2 = L8_2.remove
                L9_2 = RadioState
                L9_2 = L9_2.scannedChannels
                L10_2 = L6_2
                L8_2(L9_2, L10_2)
                break
              end
            end
          end
          L3_2 = setTrunk
          L4_2 = false
          L3_2(L4_2)
          L3_2 = RadioState
          L3_2.isChannelTrunked = false
          L3_2 = RadioState
          L4_2 = {}
          L4_2.zoneId = nil
          L4_2.channelId = nil
          L4_2.frequency = nil
          L3_2.connectedChannel = L4_2
        end
      end
    end
    L1_2 = L37_1
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      return
    end
    L2_2 = L1_2.zoneId
    L3_2 = L1_2.channelId
    L4_2 = L1_2.channel
    L5_2 = RadioState
    L5_2.selectedZone = L2_2
    L5_2 = RadioState
    L5_2 = L5_2.connectedChannel
    L5_2.zoneId = L2_2
    L5_2 = RadioState
    L5_2 = L5_2.connectedChannel
    L5_2.channelId = L3_2
    L5_2 = ipairs
    L6_2 = RadioState
    L6_2 = L6_2.scannedChannels
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = L10_2.zoneId
      if L11_2 == L2_2 then
        L11_2 = L10_2.channelId
        if L11_2 == L3_2 then
          L11_2 = Radio
          L11_2 = L11_2.removeListeningChannel
          L12_2 = convertFreq
          L13_2 = A0_2
          L12_2, L13_2 = L12_2(L13_2)
          L11_2(L12_2, L13_2)
          L11_2 = RadioState
          L11_2 = L11_2.scannedTrunkedFreqs
          if L11_2 then
            L11_2 = RadioState
            L11_2 = L11_2.scannedTrunkedFreqs
            L11_2 = L11_2[L3_2]
            if L11_2 then
              L11_2 = Radio
              L11_2 = L11_2.removeListeningChannel
              L12_2 = convertFreq
              L13_2 = RadioState
              L13_2 = L13_2.scannedTrunkedFreqs
              L13_2 = L13_2[L3_2]
              L12_2, L13_2 = L12_2(L13_2)
              L11_2(L12_2, L13_2)
              L11_2 = RadioState
              L11_2 = L11_2.scannedTrunkedFreqs
              L11_2[L3_2] = nil
            end
          end
          L11_2 = table
          L11_2 = L11_2.remove
          L12_2 = RadioState
          L12_2 = L12_2.scannedChannels
          L13_2 = L9_2
          L11_2(L12_2, L13_2)
          break
        end
      end
    end
    L5_2 = RadioState
    L6_2 = {}
    L6_2.zoneId = L2_2
    L6_2.channelId = L3_2
    L6_2.frequency = A0_2
    L5_2.connectedChannel = L6_2
    L5_2 = L4_2.type
    if "trunked" == L5_2 then
      L5_2 = L4_2.frequency
      if L5_2 then
        L5_2 = L4_2.frequencyRange
        if L5_2 then
          L5_2 = L4_2.coverage
          if L5_2 then
            goto lbl_322
          end
        end
      end
      L5_2 = showAlert
      L6_2 = "INVALID TRUNKED CONFIG"
      L7_2 = "#ba0000"
      L5_2(L6_2, L7_2)
      do return end
      ::lbl_322::
      L5_2 = GetEntityCoords
      L6_2 = PlayerPedId
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2()
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L6_2 = RadioState
      L6_2.isChannelTrunked = true
      L6_2 = setTrunk
      L7_2 = true
      L6_2(L7_2)
      L6_2 = Radio
      L6_2 = L6_2.addListeningChannel
      L7_2 = convertFreq
      L8_2 = L4_2.frequency
      L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L7_2(L8_2)
      L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L6_2 = table
      L6_2 = L6_2.insert
      L7_2 = RadioState
      L7_2 = L7_2.scannedChannels
      L8_2 = {}
      L8_2.zoneId = L2_2
      L8_2.channelId = L3_2
      L9_2 = L4_2.frequency
      L8_2.frequency = L9_2
      L6_2(L7_2, L8_2)
      L6_2 = RadioState
      L6_2 = L6_2.scannedTrunkedFreqs
      if not L6_2 then
        L6_2 = RadioState
        L7_2 = {}
        L6_2.scannedTrunkedFreqs = L7_2
      end
      L6_2 = TriggerServerEvent
      L7_2 = "radio:requestTrunkedFrequency"
      L8_2 = L4_2
      L9_2 = L5_2
      L6_2(L7_2, L8_2, L9_2)
      L6_2 = RadioState
      L6_2.connected = true
      L6_2 = setLED
      L7_2 = "connected"
      L8_2 = true
      L6_2(L7_2, L8_2)
      L6_2 = showAlert
      L7_2 = "Connecting to trunked channel..."
      L6_2(L7_2)
      L6_2 = setScan
      L7_2 = RadioState
      L7_2 = L7_2.scannedChannels
      L7_2 = #L7_2
      L7_2 = L7_2 > 0
      L6_2(L7_2)
      L6_2 = Radio
      L6_2 = L6_2.playTone
      L7_2 = "PTT"
      L6_2(L7_2)
      L6_2 = L42_1
      L6_2()
      return
    else
      L5_2 = Radio
      L5_2 = L5_2.setChannel
      L6_2 = convertFreq
      L7_2 = A0_2
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
    end
    L5_2 = RadioState
    L5_2.connected = true
    L5_2 = setLED
    L6_2 = "connected"
    L7_2 = true
    L5_2(L6_2, L7_2)
    L5_2 = showAlert
    L6_2 = "ON: "
    L7_2 = convertFreq
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    L8_2 = " MHz"
    L6_2 = L6_2 .. L7_2 .. L8_2
    L5_2(L6_2)
    L5_2 = setScan
    L6_2 = RadioState
    L6_2 = L6_2.scannedChannels
    L6_2 = #L6_2
    L6_2 = L6_2 > 0
    L5_2(L6_2)
    L5_2 = convertFreq
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    L6_2 = panicButtonChannels
    L6_2 = L6_2[L5_2]
    if L6_2 then
      L6_2 = next
      L7_2 = panicButtonChannels
      L7_2 = L7_2[L5_2]
      L6_2 = L6_2(L7_2)
      if L6_2 then
        L6_2 = next
        L7_2 = panicButtonChannels
        L7_2 = L7_2[L5_2]
        L6_2 = L6_2(L7_2)
        L7_2 = showAlert
        L8_2 = "PANIC "
        L9_2 = getPlayerName
        L10_2 = L6_2
        L9_2 = L9_2(L10_2)
        L8_2 = L8_2 .. L9_2
        L9_2 = "#ba0000"
        L7_2(L8_2, L9_2)
        L7_2 = Radio
        L7_2 = L7_2.playTone
        L8_2 = "panic"
        L7_2(L8_2)
        L7_2 = setWarn
        L8_2 = true
        L7_2(L8_2)
    end
    else
      L6_2 = activeAlerts
      L6_2 = L6_2[L5_2]
      if L6_2 then
        L6_2 = setWarn
        L7_2 = true
        L6_2(L7_2)
        L6_2 = activeAlerts
        L6_2 = L6_2[L5_2]
        L7_2 = showAlert
        L8_2 = L6_2.name
        L9_2 = L6_2.color
        L7_2(L8_2, L9_2)
      end
    end
    L6_2 = Radio
    L6_2 = L6_2.playTone
    L7_2 = "PTT"
    L6_2(L7_2)
    L6_2 = L42_1
    L6_2()
  end
  function L53_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L0_2 = RadioState
    L0_2.power = false
    L0_2 = setTheme
    L1_2 = "Dark"
    L0_2(L1_2)
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if L0_2 then
      L0_2 = TriggerServerEvent
      L1_2 = "radioServer:setPanicOnChannel"
      L2_2 = L40_1
      L2_2 = L2_2()
      L2_2 = L2_2.frequency
      L3_2 = false
      L0_2(L1_2, L2_2, L3_2)
      L0_2 = Radio
      L0_2 = L0_2.setChannel
      L1_2 = 0
      L0_2(L1_2)
      L0_2 = RadioState
      L0_2.connected = false
    end
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "stopAllTransmissions"
    L0_2(L1_2)
    L0_2 = ipairs
    L1_2 = RadioState
    L1_2 = L1_2.scannedChannels
    L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
    for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
      L6_2 = Config
      L6_2 = L6_2.zones
      L7_2 = L5_2.zoneId
      L6_2 = L6_2[L7_2]
      L6_2 = L6_2.Channels
      L7_2 = L5_2.channelId
      L6_2 = L6_2[L7_2]
      L7_2 = Radio
      L7_2 = L7_2.removeListeningChannel
      L8_2 = convertFreq
      L9_2 = L6_2.frequency
      L8_2, L9_2, L10_2 = L8_2(L9_2)
      L7_2(L8_2, L9_2, L10_2)
      L7_2 = L6_2.type
      if "trunked" == L7_2 then
        L7_2 = RadioState
        L7_2 = L7_2.scannedTrunkedFreqs
        if L7_2 then
          L7_2 = RadioState
          L7_2 = L7_2.scannedTrunkedFreqs
          L8_2 = L5_2.channelId
          L7_2 = L7_2[L8_2]
          if L7_2 then
            L7_2 = Radio
            L7_2 = L7_2.removeListeningChannel
            L8_2 = convertFreq
            L9_2 = RadioState
            L9_2 = L9_2.scannedTrunkedFreqs
            L10_2 = L5_2.channelId
            L9_2 = L9_2[L10_2]
            L8_2, L9_2, L10_2 = L8_2(L9_2)
            L7_2(L8_2, L9_2, L10_2)
          end
        end
      end
    end
    L0_2 = RadioState
    L1_2 = {}
    L0_2.scannedChannels = L1_2
    L0_2 = RadioState
    L0_2 = L0_2.scannedTrunkedFreqs
    if L0_2 then
      L0_2 = RadioState
      L1_2 = {}
      L0_2.scannedTrunkedFreqs = L1_2
    end
    L0_2 = RadioState
    L1_2 = {}
    L1_2.zoneId = nil
    L1_2.channelId = nil
    L1_2.frequency = nil
    L0_2.connectedChannel = L1_2
    L0_2 = RadioState
    L0_2.isChannelTrunked = false
    L0_2 = RadioState
    L0_2 = L0_2.pttReleaseTimer
    if L0_2 then
      L0_2 = Citizen
      L0_2 = L0_2.ClearTimeout
      L1_2 = RadioState
      L1_2 = L1_2.pttReleaseTimer
      L0_2(L1_2)
      L0_2 = RadioState
      L0_2.pttReleaseTimer = nil
      L0_2 = SendNUIMessage
      L1_2 = {}
      L1_2.action = "setTalking"
      L1_2.talking = false
      L1_2.suppressTone = true
      L0_2(L1_2)
      L0_2 = TriggerEvent
      L1_2 = "radio:stopAllSirens"
      L0_2(L1_2)
      L0_2 = SendNUIMessage
      L1_2 = {}
      L1_2.action = "stopAllTransmissions"
      L0_2(L1_2)
      L0_2 = RadioState
      L0_2 = L0_2.tempScannedChannels
      if L0_2 then
        L0_2 = ipairs
        L1_2 = RadioState
        L1_2 = L1_2.tempScannedChannels
        L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
        for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
          L6_2 = Config
          L6_2 = L6_2.zones
          L7_2 = L5_2.zoneId
          L6_2 = L6_2[L7_2]
          if L6_2 then
            L6_2 = Config
            L6_2 = L6_2.zones
            L7_2 = L5_2.zoneId
            L6_2 = L6_2[L7_2]
            L6_2 = L6_2.Channels
            L7_2 = L5_2.channelId
            L6_2 = L6_2[L7_2]
          end
          if L6_2 then
            L7_2 = Radio
            L7_2 = L7_2.addListeningChannel
            L8_2 = convertFreq
            L9_2 = L6_2.frequency
            L8_2, L9_2, L10_2 = L8_2(L9_2)
            L7_2(L8_2, L9_2, L10_2)
            L7_2 = L6_2.type
            if "trunked" == L7_2 then
              L7_2 = RadioState
              L7_2 = L7_2.scannedTrunkedFreqs
              if L7_2 then
                L7_2 = RadioState
                L7_2 = L7_2.scannedTrunkedFreqs
                L8_2 = L5_2.channelId
                L7_2 = L7_2[L8_2]
                if L7_2 then
                  L7_2 = Radio
                  L7_2 = L7_2.addListeningChannel
                  L8_2 = convertFreq
                  L9_2 = RadioState
                  L9_2 = L9_2.scannedTrunkedFreqs
                  L10_2 = L5_2.channelId
                  L9_2 = L9_2[L10_2]
                  L8_2, L9_2, L10_2 = L8_2(L9_2)
                  L7_2(L8_2, L9_2, L10_2)
                end
              end
            end
          end
        end
        L0_2 = RadioState
        L0_2.tempScannedChannels = nil
      end
    end
    L0_2 = RadioState
    L0_2.panicButton = false
    L0_2 = RadioState
    L0_2.activeTalker = nil
    L0_2 = RadioState
    L0_2.connectedChannelTalker = nil
    L0_2 = RadioState
    L0_2.scannedChannelTalker = nil
    L0_2 = RadioState
    L0_2.pausedScanForConnectedTransmission = false
    L0_2 = RadioState
    L0_2.activeTransmissionFreq = nil
    L0_2 = RadioState
    L0_2.tempScannedChannels = nil
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "stopAll3DAudio"
    L0_2(L1_2)
    L0_2 = setTrunk
    L1_2 = false
    L0_2(L1_2)
    L0_2 = setWarn
    L1_2 = false
    L0_2(L1_2)
    L0_2 = setBatt
    L1_2 = "hidden"
    L0_2(L1_2)
    L0_2 = setScan
    L1_2 = false
    L0_2(L1_2)
    L34_1.currentPage = "main"
    L34_1.line1 = ""
    L34_1.line2 = ""
    L0_2 = {}
    L0_2.btn1 = ""
    L0_2.btn2 = ""
    L0_2.btn3 = ""
    L34_1.buttons = L0_2
    L0_2 = updateTime
    L0_2()
    L0_2 = setLED
    L1_2 = "connected"
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = setLED
    L1_2 = "transmit"
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = setLED
    L1_2 = "power"
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = L42_1
    L0_2()
  end
  function L54_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = RadioState
    L0_2.power = true
    L0_2 = L45_1
    L0_2 = L0_2()
    L1_2 = nil
    if "Handheld" == L0_2 then
      L2_2 = RadioState
      L1_2 = L2_2.handheldTheme
    else
      L1_2 = "Auto"
    end
    if L1_2 then
      L2_2 = setTheme
      L3_2 = L1_2
      L2_2(L3_2)
    end
    L2_2 = setLED
    L3_2 = "power"
    L4_2 = true
    L2_2(L3_2, L4_2)
    L2_2 = setSignal
    L3_2 = GetSignalStrength
    L3_2, L4_2 = L3_2()
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
  end
  function L55_1()
    local L0_2, L1_2, L2_2
    L0_2 = SetNuiFocus
    L1_2 = false
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = RadioState
    L0_2.focused = false
    L0_2 = L31_1
    L0_2()
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "stopAll3DAudio"
    L0_2(L1_2)
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "stopAllTransmissions"
    L0_2(L1_2)
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "close"
    L0_2(L1_2)
  end
  L56_1 = Citizen
  L56_1 = L56_1.CreateThread
  function L57_1()
    local L0_2, L1_2
    while true do
      L0_2 = RadioState
      L0_2 = L0_2.power
      if L0_2 then
        L0_2 = L6_1
        if L0_2 < 30 then
          L0_2 = Citizen
          L0_2 = L0_2.Wait
          L1_2 = 40000
          L0_2(L1_2)
          L0_2 = Radio
          L0_2 = L0_2.playTone
          L1_2 = "chirp"
          L0_2(L1_2)
        else
          L0_2 = L6_1
          if L0_2 < 50 then
            L0_2 = Citizen
            L0_2 = L0_2.Wait
            L1_2 = 80000
            L0_2(L1_2)
            L0_2 = Radio
            L0_2 = L0_2.playTone
            L1_2 = "chirp"
            L0_2(L1_2)
          else
            L0_2 = Citizen
            L0_2 = L0_2.Wait
            L1_2 = 5000
            L0_2(L1_2)
          end
        end
      else
        L0_2 = Citizen
        L0_2 = L0_2.Wait
        L1_2 = 5000
        L0_2(L1_2)
      end
    end
  end
  L56_1(L57_1)
  L56_1 = Citizen
  L56_1 = L56_1.CreateThread
  function L57_1()
    local L0_2, L1_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 1000
      L0_2(L1_2)
      L0_2 = updateTime
      L0_2()
    end
  end
  L56_1(L57_1)
  L56_1 = nil
  L57_1 = Citizen
  L57_1 = L57_1.CreateThread
  function L58_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 30000
      L0_2(L1_2)
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = L45_1
        L0_2 = L0_2()
        L1_2 = nil
        L2_2 = RadioState
        L2_2 = L2_2.theme
        L1_2 = L2_2 or L1_2
        if not L2_2 then
          L1_2 = "Auto"
        end
        if "Auto" == L1_2 then
          L2_2 = L48_1
          L3_2 = L1_2
          L2_2 = L2_2(L3_2)
          L3_2 = L56_1
          if L3_2 ~= L2_2 then
            L56_1 = L2_2
            L3_2 = setTheme
            L4_2 = L1_2
            L3_2(L4_2)
            L3_2 = log
            L4_2 = "Auto theme changed to: "
            L5_2 = L2_2
            L4_2 = L4_2 .. L5_2
            L5_2 = 4
            L3_2(L4_2, L5_2)
          end
        end
      end
    end
  end
  L57_1(L58_1)
  L57_1 = RegisterNetEvent
  L58_1 = "radio:receiveTrunkedFrequency"
  L57_1(L58_1)
  L57_1 = AddEventHandler
  L58_1 = "radio:receiveTrunkedFrequency"
  function L59_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = setLED
    L2_2 = "transmit"
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = RadioState
    L1_2.activeTalker = nil
    L1_2 = RadioState
    L1_2.connectedChannelTalker = nil
    L1_2 = RadioState
    L1_2.scannedChannelTalker = nil
    L1_2 = RadioState
    L1_2.activeTransmissionFreq = nil
    L1_2 = RadioState
    L1_2.pausedScanForConnectedTransmission = false
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "stopAll3DAudio"
    L1_2(L2_2)
    L1_2 = Radio
    L1_2 = L1_2.setChannel
    L2_2 = convertFreq
    L3_2 = A0_2
    L2_2, L3_2, L4_2 = L2_2(L3_2)
    L1_2(L2_2, L3_2, L4_2)
    L1_2 = RadioState
    L1_2.connected = true
    L1_2 = RadioState
    L1_2.isChannelTrunked = true
    L1_2 = setLED
    L2_2 = "connected"
    L3_2 = true
    L1_2(L2_2, L3_2)
    L1_2 = setTrunk
    L2_2 = true
    L1_2(L2_2)
    L1_2 = setScan
    L2_2 = RadioState
    L2_2 = L2_2.scannedChannels
    L2_2 = #L2_2
    L2_2 = L2_2 > 0
    L1_2(L2_2)
    L1_2 = showAlert
    L2_2 = "ON: "
    L3_2 = convertFreq
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L4_2 = " MHz (TRUNKED)"
    L2_2 = L2_2 .. L3_2 .. L4_2
    L3_2 = "#126300"
    L1_2(L2_2, L3_2)
    L1_2 = L42_1
    L1_2()
  end
  L57_1(L58_1, L59_1)
  L57_1 = RegisterNetEvent
  L58_1 = "radio:receiveTrunkedScanFrequency"
  L57_1(L58_1)
  L57_1 = AddEventHandler
  L58_1 = "radio:receiveTrunkedScanFrequency"
  function L59_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = RadioState
    L2_2 = L2_2.scannedTrunkedFreqs
    if not L2_2 then
      L2_2 = RadioState
      L3_2 = {}
      L2_2.scannedTrunkedFreqs = L3_2
    end
    L2_2 = RadioState
    L2_2 = L2_2.activeTransmissionFreq
    if L2_2 then
      L2_2 = RadioState
      L2_2 = L2_2.scannedTrunkedFreqs
      L2_2 = L2_2[A1_2]
      if L2_2 then
        L2_2 = convertFreq
        L3_2 = RadioState
        L3_2 = L3_2.activeTransmissionFreq
        L2_2 = L2_2(L3_2)
        L3_2 = convertFreq
        L4_2 = RadioState
        L4_2 = L4_2.scannedTrunkedFreqs
        L4_2 = L4_2[A1_2]
        L3_2 = L3_2(L4_2)
        if L2_2 == L3_2 then
          L2_2 = setLED
          L3_2 = "transmit"
          L4_2 = false
          L2_2(L3_2, L4_2)
          L2_2 = RadioState
          L2_2.activeTalker = nil
          L2_2 = RadioState
          L2_2.connectedChannelTalker = nil
          L2_2 = RadioState
          L2_2.scannedChannelTalker = nil
          L2_2 = RadioState
          L2_2.activeTransmissionFreq = nil
          L2_2 = RadioState
          L2_2.pausedScanForConnectedTransmission = false
        end
      end
    end
    L2_2 = RadioState
    L2_2 = L2_2.scannedTrunkedFreqs
    L2_2 = L2_2[A1_2]
    if L2_2 then
      L2_2 = Radio
      L2_2 = L2_2.removeListeningChannel
      L3_2 = convertFreq
      L4_2 = RadioState
      L4_2 = L4_2.scannedTrunkedFreqs
      L4_2 = L4_2[A1_2]
      L3_2, L4_2, L5_2 = L3_2(L4_2)
      L2_2(L3_2, L4_2, L5_2)
    end
    L2_2 = RadioState
    L2_2 = L2_2.scannedTrunkedFreqs
    L2_2[A1_2] = A0_2
    L2_2 = Radio
    L2_2 = L2_2.addListeningChannel
    L3_2 = convertFreq
    L4_2 = A0_2
    L3_2, L4_2, L5_2 = L3_2(L4_2)
    L2_2(L3_2, L4_2, L5_2)
    L2_2 = showAlert
    L3_2 = "SCAN: "
    L4_2 = convertFreq
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = " MHz"
    L3_2 = L3_2 .. L4_2 .. L5_2
    L4_2 = "#126300"
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
  end
  L57_1(L58_1, L59_1)
  L57_1 = Citizen
  L57_1 = L57_1.CreateThread
  function L58_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 2000
      L0_2(L1_2)
      L0_2 = RadioState
      L0_2 = L0_2.connected
      if L0_2 then
        L0_2 = RadioState
        L0_2 = L0_2.connectedChannel
        if L0_2 then
          L0_2 = RadioState
          L0_2 = L0_2.connectedChannel
          L0_2 = L0_2.zoneId
          if L0_2 then
            L0_2 = RadioState
            L0_2 = L0_2.connectedChannel
            L0_2 = L0_2.channelId
            if L0_2 then
              L0_2 = Config
              L0_2 = L0_2.zones
              L1_2 = RadioState
              L1_2 = L1_2.connectedChannel
              L1_2 = L1_2.zoneId
              L0_2 = L0_2[L1_2]
              L1_2 = L0_2 or L1_2
              if L0_2 then
                L1_2 = L0_2.Channels
                L2_2 = RadioState
                L2_2 = L2_2.connectedChannel
                L2_2 = L2_2.channelId
                L1_2 = L1_2[L2_2]
              end
              if L1_2 then
                L2_2 = L1_2.type
                if "trunked" == L2_2 then
                  L2_2 = RadioState
                  L2_2 = L2_2.isChannelTrunked
                  if L2_2 then
                    L2_2 = false
                    L3_2 = ipairs
                    L4_2 = RadioState
                    L4_2 = L4_2.scannedChannels
                    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
                    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
                      L9_2 = L8_2.zoneId
                      L10_2 = RadioState
                      L10_2 = L10_2.connectedChannel
                      L10_2 = L10_2.zoneId
                      if L9_2 == L10_2 then
                        L9_2 = L8_2.channelId
                        L10_2 = RadioState
                        L10_2 = L10_2.connectedChannel
                        L10_2 = L10_2.channelId
                        if L9_2 == L10_2 then
                          L2_2 = true
                          break
                        end
                      end
                    end
                    if L2_2 then
                      L3_2 = GetEntityCoords
                      L4_2 = PlayerPedId
                      L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2 = L4_2()
                      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2)
                      L4_2 = TriggerServerEvent
                      L5_2 = "radio:updateTrunkedLocation"
                      L6_2 = L1_2
                      L7_2 = L3_2
                      L4_2(L5_2, L6_2, L7_2)
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
  end
  L57_1(L58_1)
  L57_1 = Citizen
  L57_1 = L57_1.CreateThread
  function L58_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 2000
      L0_2(L1_2)
      L0_2 = next
      L1_2 = RadioState
      L1_2 = L1_2.scannedChannels
      L0_2 = L0_2(L1_2)
      if L0_2 then
        L0_2 = GetEntityCoords
        L1_2 = PlayerPedId
        L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
        L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        L1_2 = ipairs
        L2_2 = RadioState
        L2_2 = L2_2.scannedChannels
        L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
        for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
          L7_2 = Config
          L7_2 = L7_2.zones
          L8_2 = L6_2.zoneId
          L7_2 = L7_2[L8_2]
          L7_2 = L7_2.Channels
          L8_2 = L6_2.channelId
          L7_2 = L7_2[L8_2]
          if L7_2 then
            L8_2 = L7_2.type
            if "trunked" == L8_2 then
              L8_2 = RadioState
              L8_2 = L8_2.connected
              if L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.isChannelTrunked
                if L8_2 then
                  L8_2 = RadioState
                  L8_2 = L8_2.connectedChannel
                  L8_2 = L8_2.channelId
                  L9_2 = L6_2.channelId
                  if L8_2 == L9_2 then
                    goto lbl_52
                  end
                end
              end
              L8_2 = TriggerServerEvent
              L9_2 = "radio:updateTrunkedScanLocation"
              L10_2 = L7_2
              L11_2 = L0_2
              L12_2 = L6_2.channelId
              L8_2(L9_2, L10_2, L11_2, L12_2)
            end
          end
          ::lbl_52::
        end
      end
    end
  end
  L57_1(L58_1)
  L57_1 = Citizen
  L57_1 = L57_1.CreateThread
  function L58_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
    L0_2 = nil
    L1_2 = nil
    while true do
      L2_2 = Citizen
      L2_2 = L2_2.Wait
      L3_2 = 500
      L2_2(L3_2)
      L2_2 = radioSystemAccess
      if true ~= L2_2 then
        L2_2 = RadioState
        L2_2 = L2_2.power
        if L2_2 then
          L2_2 = L53_1
          L2_2()
        end
        L2_2 = RadioState
        L2_2 = L2_2.open
        if L2_2 then
          L2_2 = L55_1
          L2_2()
        end
      end
      L2_2 = RadioState
      L2_2 = L2_2.open
      if L2_2 then
        L2_2 = L45_1
        L2_2 = L2_2()
        L3_2 = L46_1
        L3_2 = L3_2()
        if L2_2 ~= L0_2 or "Handheld" ~= L2_2 and L3_2 ~= L1_2 then
          L4_2 = RadioState
          L4_2 = L4_2.activeTalker
          L5_2 = GetPlayerServerId
          L6_2 = PlayerId
          L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2 = L6_2()
          L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2)
          L4_2 = L4_2 == L5_2
          L5_2 = nil
          L6_2 = RadioState
          L6_2 = L6_2.pttReleaseTimer
          L6_2 = nil ~= L6_2
          if L4_2 then
            L7_2 = {}
            L8_2 = RadioState
            L8_2 = L8_2.activeTalker
            L7_2.activeTalker = L8_2
            L8_2 = RadioState
            L8_2 = L8_2.connectedChannelTalker
            L7_2.connectedChannelTalker = L8_2
            L8_2 = RadioState
            L8_2 = L8_2.scannedChannelTalker
            L7_2.scannedChannelTalker = L8_2
            L8_2 = RadioState
            L8_2 = L8_2.activeTransmissionFreq
            L7_2.activeTransmissionFreq = L8_2
            L8_2 = RadioState
            L8_2 = L8_2.connected
            L7_2.connected = L8_2
            L8_2 = table
            L8_2 = L8_2.deepcopy
            L9_2 = RadioState
            L9_2 = L9_2.connectedChannel
            L8_2 = L8_2(L9_2)
            L7_2.connectedChannel = L8_2
            L7_2.hadPendingRelease = L6_2
            L5_2 = L7_2
          end
          L7_2 = RadioState
          L7_2 = L7_2.pttReleaseTimer
          if L7_2 then
            L7_2 = Citizen
            L7_2 = L7_2.ClearTimeout
            L8_2 = RadioState
            L8_2 = L8_2.pttReleaseTimer
            L7_2(L8_2)
            L7_2 = RadioState
            L7_2.pttReleaseTimer = nil
            L7_2 = SendNUIMessage
            L8_2 = {}
            L8_2.action = "setTalking"
            L8_2.talking = false
            L8_2.suppressTone = true
            L7_2(L8_2)
            L7_2 = TriggerEvent
            L8_2 = "radio:stopAllSirens"
            L7_2(L8_2)
            L7_2 = RadioState
            L7_2 = L7_2.tempScannedChannels
            if L7_2 then
              L7_2 = ipairs
              L8_2 = RadioState
              L8_2 = L8_2.tempScannedChannels
              L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
              for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
                L13_2 = Config
                L13_2 = L13_2.zones
                L14_2 = L12_2.zoneId
                L13_2 = L13_2[L14_2]
                if L13_2 then
                  L13_2 = Config
                  L13_2 = L13_2.zones
                  L14_2 = L12_2.zoneId
                  L13_2 = L13_2[L14_2]
                  L13_2 = L13_2.Channels
                  L14_2 = L12_2.channelId
                  L13_2 = L13_2[L14_2]
                end
                if L13_2 then
                  L14_2 = Radio
                  L14_2 = L14_2.addListeningChannel
                  L15_2 = convertFreq
                  L16_2 = L13_2.frequency
                  L15_2, L16_2, L17_2 = L15_2(L16_2)
                  L14_2(L15_2, L16_2, L17_2)
                  L14_2 = L13_2.type
                  if "trunked" == L14_2 then
                    L14_2 = RadioState
                    L14_2 = L14_2.scannedTrunkedFreqs
                    if L14_2 then
                      L14_2 = RadioState
                      L14_2 = L14_2.scannedTrunkedFreqs
                      L15_2 = L12_2.channelId
                      L14_2 = L14_2[L15_2]
                      if L14_2 then
                        L14_2 = Radio
                        L14_2 = L14_2.addListeningChannel
                        L15_2 = convertFreq
                        L16_2 = RadioState
                        L16_2 = L16_2.scannedTrunkedFreqs
                        L17_2 = L12_2.channelId
                        L16_2 = L16_2[L17_2]
                        L15_2, L16_2, L17_2 = L15_2(L16_2)
                        L14_2(L15_2, L16_2, L17_2)
                      end
                    end
                  end
                end
              end
              L7_2 = RadioState
              L7_2.tempScannedChannels = nil
            end
          end
          L7_2 = nil
          L8_2 = nil
          L9_2 = L46_1
          L9_2 = L9_2()
          L10_2 = Settings
          L10_2 = L10_2.initializeVehicleModel
          L11_2 = L2_2
          L12_2 = L9_2
          L10_2, L11_2 = L10_2(L11_2, L12_2)
          L8_2 = L11_2
          L7_2 = L10_2
          if L7_2 then
            L10_2 = setRadioConfig
            L11_2 = L7_2
            L10_2(L11_2)
            if L5_2 then
              L10_2 = RadioState
              L11_2 = L5_2.activeTalker
              L10_2.activeTalker = L11_2
              L10_2 = RadioState
              L11_2 = L5_2.connectedChannelTalker
              L10_2.connectedChannelTalker = L11_2
              L10_2 = RadioState
              L11_2 = L5_2.scannedChannelTalker
              L10_2.scannedChannelTalker = L11_2
              L10_2 = RadioState
              L11_2 = L5_2.activeTransmissionFreq
              L10_2.activeTransmissionFreq = L11_2
              L10_2 = RadioState
              L11_2 = L5_2.connected
              L10_2.connected = L11_2
              L10_2 = RadioState
              L11_2 = L5_2.connectedChannel
              L10_2.connectedChannel = L11_2
            end
            L10_2 = L34_1.currentPage
            if "settings" == L10_2 then
              L10_2 = L41_1.settings
              L10_2 = L10_2.getCurrentOption
              L10_2 = L10_2()
              L11_2 = L10_2.init
              if L11_2 then
                L12_2 = L10_2
                L11_2 = L10_2.init
                L11_2(L12_2)
              end
              L11_2 = L42_1
              L11_2()
            else
              L10_2 = L42_1
              L10_2()
            end
          end
          if L8_2 then
            L10_2 = setRadioPosition
            L11_2 = L8_2
            L10_2(L11_2)
          end
          L0_2 = L2_2
          L1_2 = L3_2
        end
      end
    end
  end
  L57_1(L58_1)
  L57_1 = {}
  L58_1 = {}
  function L59_1()
    local L0_2, L1_2
  end
  L58_1.init = L59_1
  L59_1 = {}
  L60_1 = {}
  L61_1 = "ZN"
  L60_1.text = L61_1
  L61_1 = "action"
  function L62_1()
    local L0_2, L1_2
    L0_2 = L43_1
    L1_2 = "zones"
    L0_2(L1_2)
  end
  L60_1[L61_1] = L62_1
  L59_1.btn1 = L60_1
  L60_1 = "btn2"
  L61_1 = {}
  L62_1 = "CH"
  L61_1.text = L62_1
  L62_1 = "action"
  function L63_1()
    local L0_2, L1_2
    L0_2 = L43_1
    L1_2 = "channels"
    L0_2(L1_2)
  end
  L61_1[L62_1] = L63_1
  L59_1[L60_1] = L61_1
  L60_1 = "btn3"
  L61_1 = {}
  L62_1 = "ST"
  L61_1.text = L62_1
  L62_1 = "action"
  function L63_1()
    local L0_2, L1_2
    L0_2 = L43_1
    L1_2 = "settings"
    L0_2(L1_2)
  end
  L61_1[L62_1] = L63_1
  L59_1[L60_1] = L61_1
  L58_1.buttons = L59_1
  L59_1 = "display"
  function L60_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
    L0_2 = RadioState
    L0_2 = L0_2.activeTalker
    if L0_2 then
      L0_2 = getPlayerName
      L1_2 = RadioState
      L1_2 = L1_2.activeTalker
      L0_2 = L0_2(L1_2)
      if L0_2 then
        goto lbl_12
      end
    end
    L0_2 = nil
    ::lbl_12::
    L1_2 = nil
    L2_2 = nil
    L3_2 = RadioState
    L3_2 = L3_2.connected
    if L3_2 then
      L3_2 = Config
      L3_2 = L3_2.zones
      L4_2 = RadioState
      L4_2 = L4_2.connectedChannel
      L4_2 = L4_2.zoneId
      L1_2 = L3_2[L4_2]
      L2_2 = L1_2 or L2_2
      if L1_2 then
        L3_2 = L1_2.Channels
        L2_2 = L3_2 or L2_2
        if L3_2 then
          L3_2 = L1_2.Channels
          L4_2 = RadioState
          L4_2 = L4_2.connectedChannel
          L4_2 = L4_2.channelId
          L2_2 = L3_2[L4_2]
        end
      end
    else
      L3_2 = Config
      L3_2 = L3_2.zones
      L4_2 = RadioState
      L4_2 = L4_2.selectedZone
      L1_2 = L3_2[L4_2]
      L2_2 = nil
    end
    L3_2 = ""
    L4_2 = GetPlayerServerId
    L5_2 = PlayerId
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
    L5_2 = RadioState
    L5_2 = L5_2.activeTalker
    if L5_2 then
      L5_2 = RadioState
      L5_2 = L5_2.activeTalker
      if L5_2 == L4_2 then
        L3_2 = "TX: "
      else
        L5_2 = false
        L6_2 = RadioState
        L6_2 = L6_2.activeTransmissionFreq
        L7_2 = RadioState
        L7_2 = L7_2.connected
        if L7_2 then
          L7_2 = RadioState
          L7_2 = L7_2.connectedChannel
          L7_2 = L7_2.frequency
          if L7_2 and L6_2 then
            L7_2 = L40_1
            L7_2 = L7_2()
            if L7_2 then
              L8_2 = RadioState
              L8_2 = L8_2.isChannelTrunked
              if L8_2 then
                L8_2 = convertFreq
                L9_2 = L7_2.frequency
                L8_2 = L8_2(L9_2)
                L9_2 = Radio
                L9_2 = L9_2.getChannel
                L9_2 = L9_2()
                L10_2 = convertFreq
                L11_2 = L6_2
                L10_2 = L10_2(L11_2)
                L5_2 = L10_2 == L8_2
              else
                L8_2 = convertFreq
                L9_2 = L6_2
                L8_2 = L8_2(L9_2)
                L9_2 = convertFreq
                L10_2 = RadioState
                L10_2 = L10_2.connectedChannel
                L10_2 = L10_2.frequency
                L9_2 = L9_2(L10_2)
                L5_2 = L8_2 == L9_2
              end
            end
          end
        end
        if L5_2 then
          L3_2 = "RX: "
        else
          L7_2 = false
          if L6_2 then
            L8_2 = ipairs
            L9_2 = RadioState
            L9_2 = L9_2.scannedChannels
            L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
            for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
              L14_2 = Config
              L14_2 = L14_2.zones
              L15_2 = L13_2.zoneId
              L14_2 = L14_2[L15_2]
              if L14_2 then
                L14_2 = Config
                L14_2 = L14_2.zones
                L15_2 = L13_2.zoneId
                L14_2 = L14_2[L15_2]
                L14_2 = L14_2.Channels
                L15_2 = L13_2.channelId
                L14_2 = L14_2[L15_2]
              end
              if L14_2 then
                L15_2 = convertFreq
                L16_2 = L6_2
                L15_2 = L15_2(L16_2)
                L16_2 = convertFreq
                L17_2 = L14_2.frequency
                L16_2 = L16_2(L17_2)
                if L15_2 == L16_2 then
                  L7_2 = true
                  break
                end
                L15_2 = L14_2.type
                if "trunked" == L15_2 then
                  L15_2 = RadioState
                  L15_2 = L15_2.scannedTrunkedFreqs
                  if L15_2 then
                    L15_2 = RadioState
                    L15_2 = L15_2.scannedTrunkedFreqs
                    L16_2 = L13_2.channelId
                    L15_2 = L15_2[L16_2]
                    if L15_2 then
                      L15_2 = convertFreq
                      L16_2 = L6_2
                      L15_2 = L15_2(L16_2)
                      L16_2 = convertFreq
                      L17_2 = RadioState
                      L17_2 = L17_2.scannedTrunkedFreqs
                      L18_2 = L13_2.channelId
                      L17_2 = L17_2[L18_2]
                      L16_2 = L16_2(L17_2)
                      if L15_2 == L16_2 then
                        L7_2 = true
                        break
                      end
                    end
                  end
                end
              end
            end
          end
          if L7_2 then
            L8_2 = "SC: "
            if L8_2 then
              goto lbl_180
              L3_2 = L8_2 or L3_2
            end
          end
          L3_2 = "RX: "
        end
      end
    end
    ::lbl_180::
    L5_2 = {}
    if L1_2 then
      L6_2 = L1_2.name
      if L6_2 then
        goto lbl_188
      end
    end
    L6_2 = "NO ZONE"
    ::lbl_188::
    L5_2.line1 = L6_2
    L6_2 = RadioState
    L6_2 = L6_2.activeTalker
    if L6_2 then
      L6_2 = L3_2
      L7_2 = L0_2
      L6_2 = L6_2 .. L7_2
      if L6_2 then
        goto lbl_204
      end
    end
    if L2_2 then
      L6_2 = L2_2.name
      if L6_2 then
        goto lbl_204
      end
    end
    L6_2 = "NOT CONNECTED"
    ::lbl_204::
    L5_2.line2 = L6_2
    return L5_2
  end
  L58_1[L59_1] = L60_1
  L57_1.main = L58_1
  L58_1 = "zones"
  L59_1 = {}
  L60_1 = "state"
  L61_1 = {}
  L62_1 = "tempZone"
  L63_1 = nil
  L61_1[L62_1] = L63_1
  L59_1[L60_1] = L61_1
  L60_1 = "hasZoneAccess"
  function L61_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = Config
    L2_2 = L2_2.zones
    L2_2 = L2_2[A1_2]
    if not L2_2 then
      L3_2 = false
      return L3_2
    end
    L3_2 = L2_2.nacIds
    if L3_2 then
      L3_2 = L2_2.nacIds
      L3_2 = #L3_2
      if 0 ~= L3_2 then
        goto lbl_21
      end
    end
    L3_2 = radioSystemAccess
    L3_2 = true == L3_2
    do return L3_2 end
    ::lbl_21::
    L3_2 = L8_1
    if L3_2 then
      L3_2 = ipairs
      L4_2 = L2_2.nacIds
      L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = L8_1
        if L9_2 == L8_2 then
          L9_2 = true
          return L9_2
        end
      end
    end
    L3_2 = false
    return L3_2
  end
  L59_1[L60_1] = L61_1
  function L60_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L1_2 = L23_1
    L1_2 = L1_2()
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L2_2 = L1_2[L2_2]
    if L2_2 then
      L2_2 = A0_2.state
      L3_2 = RadioState
      L3_2 = L3_2.selectedZone
      L2_2.tempZone = L3_2
    else
      L2_2 = pairs
      L3_2 = L1_2
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = A0_2.state
        L8_2.tempZone = L6_2
        break
      end
      L2_2 = A0_2.state
      L2_2 = L2_2.tempZone
      if not L2_2 then
        L2_2 = A0_2.state
        L3_2 = RadioState
        L3_2 = L3_2.selectedZone
        L2_2.tempZone = L3_2
      end
    end
  end
  L59_1.init = L60_1
  L60_1 = {}
  L61_1 = "btn2"
  L62_1 = {}
  L63_1 = "SEL"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = A0_2.state
    L1_2 = L1_2.tempZone
    if L1_2 then
      L2_2 = A0_2
      L1_2 = A0_2.hasZoneAccess
      L3_2 = A0_2.state
      L3_2 = L3_2.tempZone
      L1_2 = L1_2(L2_2, L3_2)
      if L1_2 then
        L1_2 = RadioState
        L2_2 = A0_2.state
        L2_2 = L2_2.tempZone
        L1_2.selectedZone = L2_2
        L1_2 = showAlert
        L2_2 = "Zone Selected"
        L1_2(L2_2)
        L1_2 = L43_1
        L2_2 = "main"
        L1_2(L2_2)
    end
    else
      L1_2 = showAlert
      L2_2 = "UNABLE"
      L3_2 = "#ba0000"
      L1_2(L2_2, L3_2)
    end
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L61_1 = "btnLeft"
  L62_1 = {}
  L63_1 = "\226\134\144"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = A0_2.state
    L1_2 = L1_2.tempZone
    repeat
      L1_2 = L1_2 - 1
      if L1_2 < 1 then
        L2_2 = L44_1
        L3_2 = Config
        L3_2 = L3_2.zones
        L2_2 = L2_2(L3_2)
        L1_2 = L2_2
      end
      L3_2 = A0_2
      L2_2 = A0_2.hasZoneAccess
      L4_2 = L1_2
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        break
      end
      L2_2 = A0_2.state
      L2_2 = L2_2.tempZone
    until L1_2 == L2_2
    L2_2 = A0_2.state
    L2_2.tempZone = L1_2
    L2_2 = L42_1
    L2_2()
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L61_1 = "btnRight"
  L62_1 = {}
  L63_1 = "\226\134\146"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = A0_2.state
    L1_2 = L1_2.tempZone
    repeat
      L1_2 = L1_2 + 1
      L2_2 = L44_1
      L3_2 = Config
      L3_2 = L3_2.zones
      L2_2 = L2_2(L3_2)
      if L1_2 > L2_2 then
        L1_2 = 1
      end
      L3_2 = A0_2
      L2_2 = A0_2.hasZoneAccess
      L4_2 = L1_2
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        break
      end
      L2_2 = A0_2.state
      L2_2 = L2_2.tempZone
    until L1_2 == L2_2
    L2_2 = A0_2.state
    L2_2.tempZone = L1_2
    L2_2 = L42_1
    L2_2()
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L59_1.buttons = L60_1
  L60_1 = "display"
  function L61_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L2_2 = A0_2.state
    L2_2 = L2_2.tempZone
    L1_2 = L1_2[L2_2]
    L3_2 = A0_2
    L2_2 = A0_2.hasZoneAccess
    L4_2 = A0_2.state
    L4_2 = L4_2.tempZone
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = {}
    L3_2.line1 = "Select Zone"
    L4_2 = L1_2.name
    if L2_2 then
      L5_2 = ""
      if L5_2 then
        goto lbl_20
      end
    end
    L5_2 = " [NO ACCESS]"
    ::lbl_20::
    L4_2 = L4_2 .. L5_2
    L3_2.line2 = L4_2
    return L3_2
  end
  L59_1[L60_1] = L61_1
  L57_1[L58_1] = L59_1
  L58_1 = "channels"
  L59_1 = {}
  L60_1 = "state"
  L61_1 = {}
  L62_1 = "tempChannel"
  L63_1 = nil
  L61_1[L62_1] = L63_1
  L62_1 = "accessibleChannels"
  L63_1 = {}
  L61_1[L62_1] = L63_1
  L59_1[L60_1] = L61_1
  function L60_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L1_2 = L23_1
    L1_2 = L1_2()
    L2_2 = A0_2.state
    L3_2 = L51_1
    L4_2 = RadioState
    L4_2 = L4_2.selectedZone
    L3_2 = L3_2(L4_2)
    L2_2.accessibleChannels = L3_2
    L2_2 = RadioState
    L2_2 = L2_2.connected
    if L2_2 then
      L2_2 = RadioState
      L2_2 = L2_2.connectedChannel
      L2_2 = L2_2.zoneId
      L3_2 = RadioState
      L3_2 = L3_2.selectedZone
      if L2_2 == L3_2 then
        L2_2 = RadioState
        L2_2 = L2_2.connectedChannel
        L2_2 = L2_2.channelId
        if L2_2 then
          L2_2 = Config
          L2_2 = L2_2.zones
          L3_2 = RadioState
          L3_2 = L3_2.connectedChannel
          L3_2 = L3_2.zoneId
          L2_2 = L2_2[L3_2]
          if L2_2 then
            L2_2 = Config
            L2_2 = L2_2.zones
            L3_2 = RadioState
            L3_2 = L3_2.connectedChannel
            L3_2 = L3_2.zoneId
            L2_2 = L2_2[L3_2]
            L2_2 = L2_2.Channels
            L3_2 = RadioState
            L3_2 = L3_2.connectedChannel
            L3_2 = L3_2.channelId
            L2_2 = L2_2[L3_2]
          end
          if L2_2 then
            L3_2 = A0_2.state
            L4_2 = RadioState
            L4_2 = L4_2.connectedChannel
            L4_2 = L4_2.channelId
            L3_2.tempChannel = L4_2
            L3_2 = A0_2.state
            L3_2 = L3_2.accessibleChannels
            L4_2 = RadioState
            L4_2 = L4_2.connectedChannel
            L4_2 = L4_2.channelId
            L3_2[L4_2] = L2_2
          else
            L3_2 = pairs
            L4_2 = A0_2.state
            L4_2 = L4_2.accessibleChannels
            L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
            for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
              L9_2 = A0_2.state
              L9_2.tempChannel = L7_2
              break
            end
          end
      end
    end
    else
      L2_2 = A0_2.state
      L2_2 = L2_2.tempChannel
      if L2_2 then
        L2_2 = A0_2.state
        L2_2 = L2_2.accessibleChannels
        L3_2 = A0_2.state
        L3_2 = L3_2.tempChannel
        L2_2 = L2_2[L3_2]
        if L2_2 then
          goto lbl_92
        end
      end
      L2_2 = pairs
      L3_2 = A0_2.state
      L3_2 = L3_2.accessibleChannels
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = A0_2.state
        L8_2.tempChannel = L6_2
        break
      end
    end
    ::lbl_92::
    L2_2 = next
    L3_2 = A0_2.state
    L3_2 = L3_2.accessibleChannels
    L2_2 = L2_2(L3_2)
    if not L2_2 then
      L2_2 = A0_2.state
      L2_2.tempChannel = nil
    end
  end
  L59_1.init = L60_1
  L60_1 = {}
  L61_1 = {}
  L62_1 = "CON"
  L61_1.text = L62_1
  L62_1 = "action"
  function L63_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L1_2 = L1_2[L2_2]
    L2_2 = L1_2.Channels
    L3_2 = RadioState
    L3_2 = L3_2.connectedChannel
    L3_2 = L3_2.channelId
    L2_2 = L2_2[L3_2]
    L3_2 = L1_2.Channels
    L4_2 = A0_2.state
    L4_2 = L4_2.tempChannel
    L3_2 = L3_2[L4_2]
    L4_2 = L32_1
    L5_2 = L3_2
    L4_2 = L4_2(L5_2)
    if not L4_2 then
      L4_2 = showAlert
      L5_2 = "UNABLE"
      L6_2 = "#ba0000"
      L4_2(L5_2, L6_2)
      return
    end
    L4_2 = L52_1
    L5_2 = L3_2.frequency
    L4_2(L5_2)
    L4_2 = Radio
    L4_2 = L4_2.playTone
    L5_2 = "PTT"
    L4_2(L5_2)
    L4_2 = L42_1
    L4_2()
  end
  L61_1[L62_1] = L63_1
  L60_1.btn1 = L61_1
  L61_1 = "btn2"
  L62_1 = {}
  L63_1 = "DSC"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if L0_2 then
      L0_2 = Config
      L0_2 = L0_2.zones
      L1_2 = RadioState
      L1_2 = L1_2.selectedZone
      L0_2 = L0_2[L1_2]
      L1_2 = L0_2.Channels
      L2_2 = RadioState
      L2_2 = L2_2.connectedChannel
      L2_2 = L2_2.channelId
      L1_2 = L1_2[L2_2]
      L2_2 = RadioState
      L2_2 = L2_2.connectedChannel
      L2_2 = L2_2.frequency
      if L2_2 then
        L2_2 = TriggerServerEvent
        L3_2 = "radioServer:setPanicOnChannel"
        L4_2 = RadioState
        L4_2 = L4_2.connectedChannel
        L4_2 = L4_2.frequency
        L5_2 = false
        L2_2(L3_2, L4_2, L5_2)
      end
      L2_2 = SendNUIMessage
      L3_2 = {}
      L3_2.action = "stopAllTransmissions"
      L2_2(L3_2)
      L2_2 = L1_2.type
      if "trunked" == L2_2 then
        L2_2 = RadioState
        L2_2 = L2_2.isChannelTrunked
        if L2_2 then
          L2_2 = Radio
          L2_2 = L2_2.removeListeningChannel
          L3_2 = convertFreq
          L4_2 = L1_2.frequency
          L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
          L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
          L2_2 = RadioState
          L2_2 = L2_2.scannedTrunkedFreqs
          if L2_2 then
            L2_2 = RadioState
            L2_2 = L2_2.scannedTrunkedFreqs
            L3_2 = RadioState
            L3_2 = L3_2.connectedChannel
            L3_2 = L3_2.channelId
            L2_2 = L2_2[L3_2]
            if L2_2 then
              L2_2 = Radio
              L2_2 = L2_2.removeListeningChannel
              L3_2 = convertFreq
              L4_2 = RadioState
              L4_2 = L4_2.scannedTrunkedFreqs
              L5_2 = RadioState
              L5_2 = L5_2.connectedChannel
              L5_2 = L5_2.channelId
              L4_2 = L4_2[L5_2]
              L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2 = L3_2(L4_2)
              L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2)
              L2_2 = RadioState
              L2_2 = L2_2.scannedTrunkedFreqs
              L3_2 = RadioState
              L3_2 = L3_2.connectedChannel
              L3_2 = L3_2.channelId
              L2_2[L3_2] = nil
            end
          end
          L2_2 = RadioState
          L2_2 = L2_2.scannedChannels
          L2_2 = #L2_2
          L3_2 = 1
          L4_2 = -1
          for L5_2 = L2_2, L3_2, L4_2 do
            L6_2 = RadioState
            L6_2 = L6_2.scannedChannels
            L6_2 = L6_2[L5_2]
            L7_2 = L6_2.zoneId
            L8_2 = RadioState
            L8_2 = L8_2.connectedChannel
            L8_2 = L8_2.zoneId
            if L7_2 == L8_2 then
              L7_2 = L6_2.channelId
              L8_2 = RadioState
              L8_2 = L8_2.connectedChannel
              L8_2 = L8_2.channelId
              if L7_2 == L8_2 then
                L7_2 = table
                L7_2 = L7_2.remove
                L8_2 = RadioState
                L8_2 = L8_2.scannedChannels
                L9_2 = L5_2
                L7_2(L8_2, L9_2)
                break
              end
            end
          end
          L2_2 = setTrunk
          L3_2 = false
          L2_2(L3_2)
          L2_2 = RadioState
          L2_2.isChannelTrunked = false
        end
      end
      L2_2 = Radio
      L2_2 = L2_2.setChannel
      L3_2 = 0
      L2_2(L3_2)
      L2_2 = RadioState
      L2_2.panicButton = false
      L2_2 = RadioState
      L2_2.connected = false
      L2_2 = setWarn
      L3_2 = false
      L2_2(L3_2)
      L2_2 = showAlert
      L3_2 = "Disconnected"
      L2_2(L3_2)
      L2_2 = setLED
      L3_2 = "connected"
      L4_2 = false
      L2_2(L3_2, L4_2)
      L2_2 = setScan
      L3_2 = RadioState
      L3_2 = L3_2.scannedChannels
      L3_2 = #L3_2
      L3_2 = L3_2 > 0
      L2_2(L3_2)
      L2_2 = L42_1
      L2_2()
    end
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L61_1 = "btn3"
  L62_1 = {}
  function L63_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L1_2 = L1_2[L2_2]
    L1_2 = L1_2.Channels
    L2_2 = A0_2.state
    L2_2 = L2_2.tempChannel
    L1_2 = L1_2[L2_2]
    if L1_2 then
      L2_2 = L1_2.type
      if "trunked" == L2_2 then
        L2_2 = RadioState
        L2_2 = L2_2.connected
        if L2_2 then
          L2_2 = RadioState
          L2_2 = L2_2.connectedChannel
          L2_2 = L2_2.channelId
          L3_2 = A0_2.state
          L3_2 = L3_2.tempChannel
          if L2_2 == L3_2 then
            L2_2 = RadioState
            L2_2 = L2_2.isChannelTrunked
            if L2_2 then
              L2_2 = Radio
              L2_2 = L2_2.getChannel
              L2_2 = L2_2()
              L3_2 = convertFreq
              L4_2 = L1_2.frequency
              L3_2 = L3_2(L4_2)
              L4_2 = false
              L5_2 = ipairs
              L6_2 = RadioState
              L6_2 = L6_2.scannedChannels
              L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
              for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
                L11_2 = L10_2.zoneId
                L12_2 = RadioState
                L12_2 = L12_2.connectedChannel
                L12_2 = L12_2.zoneId
                if L11_2 == L12_2 then
                  L11_2 = L10_2.channelId
                  L12_2 = RadioState
                  L12_2 = L12_2.connectedChannel
                  L12_2 = L12_2.channelId
                  if L11_2 == L12_2 then
                    L4_2 = true
                    break
                  end
                end
              end
              L5_2 = false
              L6_2 = L8_1
              if L6_2 then
                L6_2 = Config
                L6_2 = L6_2.dispatchNacId
                if L6_2 then
                  L6_2 = L8_1
                  L7_2 = Config
                  L7_2 = L7_2.dispatchNacId
                  L5_2 = L6_2 == L7_2
                end
              end
              if L5_2 then
                if L4_2 then
                  L6_2 = "CT"
                  return L6_2
                else
                  L6_2 = "TK"
                  return L6_2
                end
              else
                L6_2 = "SCN"
                return L6_2
              end
          end
        end
        else
          L2_2 = "SCN"
          return L2_2
        end
    end
    else
      L2_2 = false
      L3_2 = Config
      L3_2 = L3_2.alerts
      if L3_2 then
        L3_2 = Config
        L3_2 = L3_2.alerts
        L3_2 = L3_2[1]
        if L3_2 then
          L3_2 = Config
          L3_2 = L3_2.alerts
          L3_2 = L3_2[1]
          L4_2 = L3_2.nacIds
          if not L4_2 then
            L2_2 = true
          else
            L4_2 = L8_1
            if L4_2 then
              L4_2 = ipairs
              L5_2 = L3_2.nacIds
              L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
              for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
                L10_2 = L8_1
                if L10_2 == L9_2 then
                  L2_2 = true
                  break
                end
              end
            end
          end
        end
      end
      L3_2 = RadioState
      L3_2 = L3_2.connected
      if L3_2 then
        L3_2 = RadioState
        L3_2 = L3_2.connectedChannel
        if not L3_2 then
          L2_2 = false
        else
          L3_2 = RadioState
          L3_2 = L3_2.connectedChannel
          L3_2 = L3_2.zoneId
          L4_2 = RadioState
          L4_2 = L4_2.selectedZone
          if L3_2 ~= L4_2 then
            L2_2 = false
          else
            L3_2 = RadioState
            L3_2 = L3_2.connectedChannel
            L3_2 = L3_2.channelId
            L4_2 = A0_2.state
            L4_2 = L4_2.tempChannel
            if L3_2 ~= L4_2 then
              L2_2 = false
            end
          end
        end
      else
        L2_2 = false
      end
      if L2_2 then
        L3_2 = "SGN"
        if L3_2 then
          goto lbl_129
        end
      end
      L3_2 = "SCN"
      ::lbl_129::
      return L3_2
    end
  end
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L1_2 = L1_2[L2_2]
    L1_2 = L1_2.Channels
    L2_2 = A0_2.state
    L2_2 = L2_2.tempChannel
    L1_2 = L1_2[L2_2]
    L2_2 = false
    L3_2 = Config
    L3_2 = L3_2.alerts
    if L3_2 then
      L3_2 = Config
      L3_2 = L3_2.alerts
      L3_2 = L3_2[1]
      if L3_2 then
        L3_2 = Config
        L3_2 = L3_2.alerts
        L3_2 = L3_2[1]
        L4_2 = L3_2.nacIds
        if not L4_2 then
          L2_2 = true
        else
          L4_2 = L8_1
          if L4_2 then
            L4_2 = ipairs
            L5_2 = L3_2.nacIds
            L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
            for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
              L10_2 = L8_1
              if L10_2 == L9_2 then
                L2_2 = true
                break
              end
            end
          end
        end
      end
    end
    L3_2 = false
    L4_2 = ""
    if L1_2 then
      L5_2 = L1_2.type
      if "trunked" == L5_2 then
        L5_2 = RadioState
        L5_2 = L5_2.connected
        if L5_2 then
          L5_2 = RadioState
          L5_2 = L5_2.connectedChannel
          L5_2 = L5_2.channelId
          L6_2 = A0_2.state
          L6_2 = L6_2.tempChannel
          if L5_2 == L6_2 then
            L5_2 = RadioState
            L5_2 = L5_2.isChannelTrunked
            if L5_2 then
              goto lbl_68
            end
          end
        end
        L3_2 = true
        L4_2 = "disconnected_trunked"
    end
    ::lbl_68::
    else
      if L1_2 then
        L5_2 = L1_2.type
        if "trunked" == L5_2 then
          L5_2 = RadioState
          L5_2 = L5_2.connected
          if L5_2 then
            L5_2 = RadioState
            L5_2 = L5_2.connectedChannel
            L5_2 = L5_2.channelId
            L6_2 = A0_2.state
            L6_2 = L6_2.tempChannel
            if L5_2 == L6_2 then
              L5_2 = RadioState
              L5_2 = L5_2.isChannelTrunked
              if L5_2 and not L2_2 then
                L3_2 = true
                L4_2 = "no_control_access"
            end
          end
        end
      end
      elseif L1_2 then
        L5_2 = L1_2.type
        if "trunked" ~= L5_2 and not L2_2 then
          L3_2 = true
          L4_2 = "no_signal_access"
        end
      end
    end
    if L3_2 then
      L5_2 = RadioState
      L5_2 = L5_2.connected
      if L5_2 then
        L5_2 = RadioState
        L5_2 = L5_2.connectedChannel
        L5_2 = L5_2.zoneId
        L6_2 = RadioState
        L6_2 = L6_2.selectedZone
        if L5_2 == L6_2 then
          L5_2 = RadioState
          L5_2 = L5_2.connectedChannel
          L5_2 = L5_2.channelId
          L6_2 = A0_2.state
          L6_2 = L6_2.tempChannel
          if L5_2 == L6_2 then
            L5_2 = showAlert
            L6_2 = "UNABLE"
            L7_2 = "#ba0000"
            L5_2(L6_2, L7_2)
            return
          end
        end
      end
      L5_2 = L35_1
      L6_2 = RadioState
      L6_2 = L6_2.selectedZone
      L7_2 = A0_2.state
      L7_2 = L7_2.tempChannel
      L5_2 = L5_2(L6_2, L7_2)
      if L5_2 then
        L5_2 = RadioState
        L5_2 = L5_2.scannedChannels
        L5_2 = #L5_2
        L6_2 = 1
        L7_2 = -1
        for L8_2 = L5_2, L6_2, L7_2 do
          L9_2 = RadioState
          L9_2 = L9_2.scannedChannels
          L9_2 = L9_2[L8_2]
          L10_2 = L9_2.zoneId
          L11_2 = RadioState
          L11_2 = L11_2.selectedZone
          if L10_2 == L11_2 then
            L10_2 = L9_2.channelId
            L11_2 = A0_2.state
            L11_2 = L11_2.tempChannel
            if L10_2 == L11_2 then
              L10_2 = Radio
              L10_2 = L10_2.removeListeningChannel
              L11_2 = convertFreq
              L12_2 = L1_2.frequency
              L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L11_2(L12_2)
              L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
              L10_2 = RadioState
              L10_2 = L10_2.scannedTrunkedFreqs
              if L10_2 then
                L10_2 = RadioState
                L10_2 = L10_2.scannedTrunkedFreqs
                L11_2 = A0_2.state
                L11_2 = L11_2.tempChannel
                L10_2 = L10_2[L11_2]
                if L10_2 then
                  L10_2 = Radio
                  L10_2 = L10_2.removeListeningChannel
                  L11_2 = convertFreq
                  L12_2 = RadioState
                  L12_2 = L12_2.scannedTrunkedFreqs
                  L13_2 = A0_2.state
                  L13_2 = L13_2.tempChannel
                  L12_2 = L12_2[L13_2]
                  L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L11_2(L12_2)
                  L10_2(L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
                  L10_2 = RadioState
                  L10_2 = L10_2.scannedTrunkedFreqs
                  L11_2 = A0_2.state
                  L11_2 = L11_2.tempChannel
                  L10_2[L11_2] = nil
                end
              end
              L10_2 = table
              L10_2 = L10_2.remove
              L11_2 = RadioState
              L11_2 = L11_2.scannedChannels
              L12_2 = L8_2
              L10_2(L11_2, L12_2)
              break
            end
          end
        end
        if "disconnected_trunked" == L4_2 then
          L5_2 = showAlert
          L6_2 = "Removed from scan"
          L5_2(L6_2)
        elseif "no_control_access" == L4_2 then
          L5_2 = showAlert
          L6_2 = "Removed from scan (Control)"
          L5_2(L6_2)
        else
          L5_2 = showAlert
          L6_2 = "Removed from scan"
          L5_2(L6_2)
        end
      else
        L5_2 = RadioState
        L5_2 = L5_2.scannedTrunkedFreqs
        if not L5_2 then
          L5_2 = RadioState
          L6_2 = {}
          L5_2.scannedTrunkedFreqs = L6_2
        end
        L5_2 = Radio
        L5_2 = L5_2.addListeningChannel
        L6_2 = convertFreq
        L7_2 = L1_2.frequency
        L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L6_2(L7_2)
        L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
        L5_2 = table
        L5_2 = L5_2.insert
        L6_2 = RadioState
        L6_2 = L6_2.scannedChannels
        L7_2 = {}
        L8_2 = RadioState
        L8_2 = L8_2.selectedZone
        L7_2.zoneId = L8_2
        L8_2 = A0_2.state
        L8_2 = L8_2.tempChannel
        L7_2.channelId = L8_2
        L8_2 = L1_2.frequency
        L7_2.frequency = L8_2
        L5_2(L6_2, L7_2)
        L5_2 = GetEntityCoords
        L6_2 = PlayerPedId
        L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L6_2()
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
        L6_2 = TriggerServerEvent
        L7_2 = "radio:requestTrunkedScanFrequency"
        L8_2 = L1_2
        L9_2 = L5_2
        L10_2 = A0_2.state
        L10_2 = L10_2.tempChannel
        L6_2(L7_2, L8_2, L9_2, L10_2)
        if "disconnected_trunked" == L4_2 then
          L6_2 = showAlert
          L7_2 = "Added to scan (Control)"
          L6_2(L7_2)
        elseif "no_control_access" == L4_2 then
          L6_2 = showAlert
          L7_2 = "Added to scan (Control)"
          L6_2(L7_2)
        elseif "no_signal_access" == L4_2 then
          L6_2 = showAlert
          L7_2 = "Added to scan"
          L6_2(L7_2)
        else
          L6_2 = showAlert
          L7_2 = "Added to scan"
          L6_2(L7_2)
        end
      end
      L5_2 = setScan
      L6_2 = RadioState
      L6_2 = L6_2.scannedChannels
      L6_2 = #L6_2
      L6_2 = L6_2 > 0
      L5_2(L6_2)
      L5_2 = L42_1
      L5_2()
      return
    end
    L5_2 = L1_2.type
    if "trunked" == L5_2 then
      L5_2 = RadioState
      L5_2 = L5_2.connected
      if L5_2 then
        L5_2 = RadioState
        L5_2 = L5_2.connectedChannel
        if L5_2 then
          L5_2 = RadioState
          L5_2 = L5_2.connectedChannel
          L5_2 = L5_2.channelId
          L6_2 = A0_2.state
          L6_2 = L6_2.tempChannel
          if L5_2 == L6_2 then
            L5_2 = RadioState
            L5_2 = L5_2.isChannelTrunked
            if L5_2 then
              L5_2 = Config
              L5_2 = L5_2.zones
              L6_2 = RadioState
              L6_2 = L6_2.connectedChannel
              L6_2 = L6_2.zoneId
              L5_2 = L5_2[L6_2]
              L6_2 = L5_2.Channels
              L7_2 = RadioState
              L7_2 = L7_2.connectedChannel
              L7_2 = L7_2.channelId
              L6_2 = L6_2[L7_2]
              L7_2 = false
              L8_2 = ipairs
              L9_2 = RadioState
              L9_2 = L9_2.scannedChannels
              L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
              for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
                L14_2 = L13_2.zoneId
                L15_2 = RadioState
                L15_2 = L15_2.connectedChannel
                L15_2 = L15_2.zoneId
                if L14_2 == L15_2 then
                  L14_2 = L13_2.channelId
                  L15_2 = RadioState
                  L15_2 = L15_2.connectedChannel
                  L15_2 = L15_2.channelId
                  if L14_2 == L15_2 then
                    L7_2 = true
                    break
                  end
                end
              end
              if L7_2 then
                L8_2 = false
                L9_2 = L8_1
                if L9_2 then
                  L9_2 = Config
                  L9_2 = L9_2.dispatchNacId
                  if L9_2 then
                    L9_2 = L8_1
                    L10_2 = Config
                    L10_2 = L10_2.dispatchNacId
                    L8_2 = L9_2 == L10_2
                  end
                end
                if not L8_2 then
                  L9_2 = showAlert
                  L10_2 = "UNABLE"
                  L11_2 = "#ba0000"
                  L9_2(L10_2, L11_2)
                  return
                end
                L9_2 = RadioState
                L9_2 = L9_2.scannedTrunkedFreqs
                if L9_2 then
                  L9_2 = RadioState
                  L9_2 = L9_2.scannedTrunkedFreqs
                  L10_2 = RadioState
                  L10_2 = L10_2.connectedChannel
                  L10_2 = L10_2.channelId
                  L9_2 = L9_2[L10_2]
                  if L9_2 then
                    L9_2 = Radio
                    L9_2 = L9_2.removeListeningChannel
                    L10_2 = convertFreq
                    L11_2 = RadioState
                    L11_2 = L11_2.scannedTrunkedFreqs
                    L12_2 = RadioState
                    L12_2 = L12_2.connectedChannel
                    L12_2 = L12_2.channelId
                    L11_2 = L11_2[L12_2]
                    L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L10_2(L11_2)
                    L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
                    L9_2 = RadioState
                    L9_2 = L9_2.scannedTrunkedFreqs
                    L10_2 = RadioState
                    L10_2 = L10_2.connectedChannel
                    L10_2 = L10_2.channelId
                    L9_2[L10_2] = nil
                  end
                end
                L9_2 = Radio
                L9_2 = L9_2.setChannel
                L10_2 = convertFreq
                L11_2 = L6_2.frequency
                L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L10_2(L11_2)
                L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
                L9_2 = Radio
                L9_2 = L9_2.removeListeningChannel
                L10_2 = convertFreq
                L11_2 = L6_2.frequency
                L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L10_2(L11_2)
                L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
                L9_2 = RadioState
                L9_2 = L9_2.scannedChannels
                L9_2 = #L9_2
                L10_2 = 1
                L11_2 = -1
                for L12_2 = L9_2, L10_2, L11_2 do
                  L13_2 = RadioState
                  L13_2 = L13_2.scannedChannels
                  L13_2 = L13_2[L12_2]
                  L14_2 = L13_2.zoneId
                  L15_2 = RadioState
                  L15_2 = L15_2.connectedChannel
                  L15_2 = L15_2.zoneId
                  if L14_2 == L15_2 then
                    L14_2 = L13_2.channelId
                    L15_2 = RadioState
                    L15_2 = L15_2.connectedChannel
                    L15_2 = L15_2.channelId
                    if L14_2 == L15_2 then
                      L14_2 = table
                      L14_2 = L14_2.remove
                      L15_2 = RadioState
                      L15_2 = L15_2.scannedChannels
                      L16_2 = L12_2
                      L14_2(L15_2, L16_2)
                      break
                    end
                  end
                end
                L9_2 = showAlert
                L10_2 = "CONTROL"
                L11_2 = "#126300"
                L9_2(L10_2, L11_2)
                L9_2 = setWarn
                L10_2 = true
                L9_2(L10_2)
                L9_2 = setScan
                L10_2 = RadioState
                L10_2 = L10_2.scannedChannels
                L10_2 = #L10_2
                L10_2 = L10_2 > 0
                L9_2(L10_2)
                L9_2 = L42_1
                L9_2()
              else
                L8_2 = GetEntityCoords
                L9_2 = PlayerPedId
                L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L9_2()
                L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
                L9_2 = Radio
                L9_2 = L9_2.addListeningChannel
                L10_2 = convertFreq
                L11_2 = L6_2.frequency
                L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2 = L10_2(L11_2)
                L9_2(L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
                L9_2 = table
                L9_2 = L9_2.insert
                L10_2 = RadioState
                L10_2 = L10_2.scannedChannels
                L11_2 = {}
                L12_2 = RadioState
                L12_2 = L12_2.connectedChannel
                L12_2 = L12_2.zoneId
                L11_2.zoneId = L12_2
                L12_2 = RadioState
                L12_2 = L12_2.connectedChannel
                L12_2 = L12_2.channelId
                L11_2.channelId = L12_2
                L12_2 = L6_2.frequency
                L11_2.frequency = L12_2
                L9_2(L10_2, L11_2)
                L9_2 = TriggerServerEvent
                L10_2 = "radio:requestTrunkedFrequency"
                L11_2 = L6_2
                L12_2 = L8_2
                L9_2(L10_2, L11_2, L12_2)
                L9_2 = showAlert
                L10_2 = "TRUNKED"
                L11_2 = "#126300"
                L9_2(L10_2, L11_2)
                L9_2 = setWarn
                L10_2 = false
                L9_2(L10_2)
                L9_2 = setScan
                L10_2 = RadioState
                L10_2 = L10_2.scannedChannels
                L10_2 = #L10_2
                L10_2 = L10_2 > 0
                L9_2(L10_2)
                L9_2 = L42_1
                L9_2()
              end
              return
            end
          end
        end
      end
    end
    L5_2 = L1_2.type
    if "trunked" ~= L5_2 then
      L5_2 = false
      L6_2 = Config
      L6_2 = L6_2.alerts
      if L6_2 then
        L6_2 = Config
        L6_2 = L6_2.alerts
        L6_2 = L6_2[1]
        if L6_2 then
          L6_2 = Config
          L6_2 = L6_2.alerts
          L6_2 = L6_2[1]
          L7_2 = L6_2.nacIds
          if not L7_2 then
            L5_2 = true
          else
            L7_2 = L8_1
            if L7_2 then
              L7_2 = ipairs
              L8_2 = L6_2.nacIds
              L7_2, L8_2, L9_2, L10_2 = L7_2(L8_2)
              for L11_2, L12_2 in L7_2, L8_2, L9_2, L10_2 do
                L13_2 = L8_1
                if L13_2 == L12_2 then
                  L5_2 = true
                  break
                end
              end
            end
          end
        end
      end
      if not L5_2 then
        L6_2 = showAlert
        L7_2 = "UNABLE"
        L8_2 = "#ba0000"
        L6_2(L7_2, L8_2)
        return
      end
      L6_2 = Config
      L6_2 = L6_2.alerts
      if L6_2 then
        L6_2 = Config
        L6_2 = L6_2.alerts
        L6_2 = L6_2[1]
        if L6_2 then
          goto lbl_560
        end
      end
      L6_2 = showAlert
      L7_2 = "NO ALERTS CONFIGURED"
      L8_2 = "#ba0000"
      L6_2(L7_2, L8_2)
      do return end
      ::lbl_560::
      L6_2 = Config
      L6_2 = L6_2.alerts
      L6_2 = L6_2[1]
      L7_2 = activeAlerts
      L8_2 = convertFreq
      L9_2 = L1_2.frequency
      L8_2 = L8_2(L9_2)
      L7_2 = L7_2[L8_2]
      L8_2 = TriggerServerEvent
      L9_2 = "radioServer:setAlertOnChannel"
      L10_2 = L1_2.frequency
      L11_2 = not L7_2
      L12_2 = L6_2
      L8_2(L9_2, L10_2, L11_2, L12_2)
      if L7_2 then
        L8_2 = showAlert
        L9_2 = "DEACTIVATED"
        L10_2 = "#0066cc"
        L8_2(L9_2, L10_2)
      else
        L8_2 = showAlert
        L9_2 = "ACTIVATED"
        L10_2 = L6_2.color
        if not L10_2 then
          L10_2 = "#ba0000"
        end
        L8_2(L9_2, L10_2)
      end
    else
      L5_2 = showAlert
      L6_2 = "UNABLE"
      L7_2 = "#ba0000"
      L5_2(L6_2, L7_2)
    end
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L61_1 = "btn4"
  L62_1 = {}
  function L63_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L1_2 = L1_2[L2_2]
    L1_2 = L1_2.Channels
    L2_2 = A0_2.state
    L2_2 = L2_2.tempChannel
    L1_2 = L1_2[L2_2]
    L2_2 = false
    L3_2 = Config
    L3_2 = L3_2.alerts
    if L3_2 then
      L3_2 = Config
      L3_2 = L3_2.alerts
      L3_2 = L3_2[1]
      if L3_2 then
        L3_2 = Config
        L3_2 = L3_2.alerts
        L3_2 = L3_2[1]
        L4_2 = L3_2.nacIds
        if not L4_2 then
          L2_2 = true
        else
          L4_2 = L8_1
          if L4_2 then
            L4_2 = ipairs
            L5_2 = L3_2.nacIds
            L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
            for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
              L10_2 = L8_1
              if L10_2 == L9_2 then
                L2_2 = true
                break
              end
            end
          end
        end
      end
    end
    L3_2 = false
    if L1_2 then
      L4_2 = L1_2.type
      if "trunked" == L4_2 then
        L4_2 = RadioState
        L4_2 = L4_2.connected
        if L4_2 then
          L4_2 = RadioState
          L4_2 = L4_2.connectedChannel
          L4_2 = L4_2.channelId
          L5_2 = A0_2.state
          L5_2 = L5_2.tempChannel
          if L4_2 == L5_2 then
            L4_2 = RadioState
            L4_2 = L4_2.isChannelTrunked
            if L4_2 then
              goto lbl_66
            end
          end
        end
        L3_2 = true
    end
    ::lbl_66::
    else
      if L1_2 then
        L4_2 = L1_2.type
        if "trunked" == L4_2 then
          L4_2 = RadioState
          L4_2 = L4_2.connected
          if L4_2 then
            L4_2 = RadioState
            L4_2 = L4_2.connectedChannel
            L4_2 = L4_2.channelId
            L5_2 = A0_2.state
            L5_2 = L5_2.tempChannel
            if L4_2 == L5_2 then
              L4_2 = RadioState
              L4_2 = L4_2.isChannelTrunked
              if L4_2 then
                L4_2 = L8_1
                if L4_2 then
                  L4_2 = Config
                  L4_2 = L4_2.dispatchNacId
                  if L4_2 then
                    L4_2 = L8_1
                    L5_2 = Config
                    L5_2 = L5_2.dispatchNacId
                    if L4_2 == L5_2 then
                      goto lbl_100
                    end
                  end
                end
                L3_2 = true
            end
          end
        end
      end
      ::lbl_100::
      elseif L1_2 then
        L4_2 = L1_2.type
        if "trunked" ~= L4_2 and not L2_2 then
          L3_2 = true
        end
      end
    end
    if L3_2 then
      L4_2 = ""
      return L4_2
    else
      L4_2 = "SCN"
      return L4_2
    end
  end
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    L1_2 = Config
    L1_2 = L1_2.zones
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L1_2 = L1_2[L2_2]
    L1_2 = L1_2.Channels
    L2_2 = A0_2.state
    L2_2 = L2_2.tempChannel
    L1_2 = L1_2[L2_2]
    L2_2 = false
    L3_2 = Config
    L3_2 = L3_2.alerts
    if L3_2 then
      L3_2 = Config
      L3_2 = L3_2.alerts
      L3_2 = L3_2[1]
      if L3_2 then
        L3_2 = Config
        L3_2 = L3_2.alerts
        L3_2 = L3_2[1]
        L4_2 = L3_2.nacIds
        if not L4_2 then
          L2_2 = true
        else
          L4_2 = L8_1
          if L4_2 then
            L4_2 = ipairs
            L5_2 = L3_2.nacIds
            L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
            for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
              L10_2 = L8_1
              if L10_2 == L9_2 then
                L2_2 = true
                break
              end
            end
          end
        end
      end
    end
    L3_2 = false
    if L1_2 then
      L4_2 = L1_2.type
      if "trunked" == L4_2 then
        L4_2 = RadioState
        L4_2 = L4_2.connected
        if L4_2 then
          L4_2 = RadioState
          L4_2 = L4_2.connectedChannel
          L4_2 = L4_2.channelId
          L5_2 = A0_2.state
          L5_2 = L5_2.tempChannel
          if L4_2 == L5_2 then
            L4_2 = RadioState
            L4_2 = L4_2.isChannelTrunked
            if L4_2 then
              goto lbl_66
            end
          end
        end
        L3_2 = true
    end
    ::lbl_66::
    else
      if L1_2 then
        L4_2 = L1_2.type
        if "trunked" == L4_2 then
          L4_2 = RadioState
          L4_2 = L4_2.connected
          if L4_2 then
            L4_2 = RadioState
            L4_2 = L4_2.connectedChannel
            L4_2 = L4_2.channelId
            L5_2 = A0_2.state
            L5_2 = L5_2.tempChannel
            if L4_2 == L5_2 then
              L4_2 = RadioState
              L4_2 = L4_2.isChannelTrunked
              if L4_2 then
                L4_2 = L8_1
                if L4_2 then
                  L4_2 = Config
                  L4_2 = L4_2.dispatchNacId
                  if L4_2 then
                    L4_2 = L8_1
                    L5_2 = Config
                    L5_2 = L5_2.dispatchNacId
                    if L4_2 == L5_2 then
                      goto lbl_100
                    end
                  end
                end
                L3_2 = true
            end
          end
        end
      end
      ::lbl_100::
      elseif L1_2 then
        L4_2 = L1_2.type
        if "trunked" ~= L4_2 and not L2_2 then
          L3_2 = true
        end
      end
    end
    if L3_2 then
      return
    end
    L4_2 = RadioState
    L4_2 = L4_2.connected
    if L4_2 then
      L4_2 = RadioState
      L4_2 = L4_2.connectedChannel
      L4_2 = L4_2.zoneId
      L5_2 = RadioState
      L5_2 = L5_2.selectedZone
      if L4_2 == L5_2 then
        L4_2 = RadioState
        L4_2 = L4_2.connectedChannel
        L4_2 = L4_2.channelId
        L5_2 = A0_2.state
        L5_2 = L5_2.tempChannel
        if L4_2 == L5_2 then
          L4_2 = showAlert
          L5_2 = "UNABLE"
          L6_2 = "#ba0000"
          L4_2(L5_2, L6_2)
          return
        end
      end
    end
    if not L1_2 then
      L4_2 = showAlert
      L5_2 = "INVALID CHANNEL"
      L6_2 = "#ba0000"
      L4_2(L5_2, L6_2)
      return
    end
    L4_2 = L33_1
    L5_2 = L1_2
    L4_2 = L4_2(L5_2)
    if not L4_2 then
      L4_2 = showAlert
      L5_2 = "UNABLE"
      L6_2 = "#ba0000"
      L4_2(L5_2, L6_2)
      return
    end
    L4_2 = L35_1
    L5_2 = RadioState
    L5_2 = L5_2.selectedZone
    L6_2 = A0_2.state
    L6_2 = L6_2.tempChannel
    L4_2 = L4_2(L5_2, L6_2)
    if L4_2 then
      L5_2 = RadioState
      L5_2 = L5_2.scannedChannels
      L5_2 = #L5_2
      L6_2 = 1
      L7_2 = -1
      for L8_2 = L5_2, L6_2, L7_2 do
        L9_2 = RadioState
        L9_2 = L9_2.scannedChannels
        L9_2 = L9_2[L8_2]
        L10_2 = L9_2.zoneId
        L11_2 = RadioState
        L11_2 = L11_2.selectedZone
        if L10_2 == L11_2 then
          L10_2 = L9_2.channelId
          L11_2 = A0_2.state
          L11_2 = L11_2.tempChannel
          if L10_2 == L11_2 then
            L10_2 = Radio
            L10_2 = L10_2.removeListeningChannel
            L11_2 = convertFreq
            L12_2 = L1_2.frequency
            L11_2, L12_2, L13_2 = L11_2(L12_2)
            L10_2(L11_2, L12_2, L13_2)
            L10_2 = L1_2.type
            if "trunked" == L10_2 then
              L10_2 = RadioState
              L10_2 = L10_2.scannedTrunkedFreqs
              if L10_2 then
                L10_2 = RadioState
                L10_2 = L10_2.scannedTrunkedFreqs
                L11_2 = A0_2.state
                L11_2 = L11_2.tempChannel
                L10_2 = L10_2[L11_2]
                if L10_2 then
                  L10_2 = Radio
                  L10_2 = L10_2.removeListeningChannel
                  L11_2 = convertFreq
                  L12_2 = RadioState
                  L12_2 = L12_2.scannedTrunkedFreqs
                  L13_2 = A0_2.state
                  L13_2 = L13_2.tempChannel
                  L12_2 = L12_2[L13_2]
                  L11_2, L12_2, L13_2 = L11_2(L12_2)
                  L10_2(L11_2, L12_2, L13_2)
                  L10_2 = RadioState
                  L10_2 = L10_2.scannedTrunkedFreqs
                  L11_2 = A0_2.state
                  L11_2 = L11_2.tempChannel
                  L10_2[L11_2] = nil
                end
              end
            end
            L10_2 = table
            L10_2 = L10_2.remove
            L11_2 = RadioState
            L11_2 = L11_2.scannedChannels
            L12_2 = L8_2
            L10_2(L11_2, L12_2)
            break
          end
        end
      end
      L5_2 = showAlert
      L6_2 = "Removed "
      L7_2 = convertFreq
      L8_2 = L1_2.frequency
      L7_2 = L7_2(L8_2)
      L8_2 = " MHz from scan"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L5_2(L6_2)
    else
      L5_2 = log
      L6_2 = "Adding scan channel: "
      L7_2 = tostring
      L8_2 = L1_2.frequency
      L7_2 = L7_2(L8_2)
      L8_2 = " converted: "
      L9_2 = tostring
      L10_2 = convertFreq
      L11_2 = L1_2.frequency
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      L9_2 = L9_2(L10_2, L11_2, L12_2, L13_2)
      L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
      L7_2 = 3
      L5_2(L6_2, L7_2)
      L5_2 = Radio
      L5_2 = L5_2.addListeningChannel
      L6_2 = convertFreq
      L7_2 = L1_2.frequency
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2(L7_2)
      L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
      L5_2 = table
      L5_2 = L5_2.insert
      L6_2 = RadioState
      L6_2 = L6_2.scannedChannels
      L7_2 = {}
      L8_2 = RadioState
      L8_2 = L8_2.selectedZone
      L7_2.zoneId = L8_2
      L8_2 = A0_2.state
      L8_2 = L8_2.tempChannel
      L7_2.channelId = L8_2
      L8_2 = L1_2.frequency
      L7_2.frequency = L8_2
      L5_2(L6_2, L7_2)
      L5_2 = L1_2.type
      if "trunked" == L5_2 then
        L5_2 = RadioState
        L5_2 = L5_2.scannedTrunkedFreqs
        if not L5_2 then
          L5_2 = RadioState
          L6_2 = {}
          L5_2.scannedTrunkedFreqs = L6_2
        end
        L5_2 = GetEntityCoords
        L6_2 = PlayerPedId
        L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2 = L6_2()
        L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2)
        L6_2 = TriggerServerEvent
        L7_2 = "radio:requestTrunkedScanFrequency"
        L8_2 = L1_2
        L9_2 = L5_2
        L10_2 = A0_2.state
        L10_2 = L10_2.tempChannel
        L6_2(L7_2, L8_2, L9_2, L10_2)
      end
      L5_2 = showAlert
      L6_2 = "ADDED "
      L7_2 = convertFreq
      L8_2 = L1_2.frequency
      L7_2 = L7_2(L8_2)
      L8_2 = " MHz TO LIST"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L7_2 = "#126300"
      L5_2(L6_2, L7_2)
      L5_2 = setScan
      L6_2 = true
      L5_2(L6_2)
      L5_2 = L42_1
      L5_2()
    end
    L5_2 = setScan
    L6_2 = RadioState
    L6_2 = L6_2.scannedChannels
    L6_2 = #L6_2
    L6_2 = L6_2 > 0
    L5_2(L6_2)
    L5_2 = L42_1
    L5_2()
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L61_1 = "btnLeft"
  L62_1 = {}
  L63_1 = "\226\134\144"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = {}
    L2_2 = pairs
    L3_2 = A0_2.state
    L3_2 = L3_2.accessibleChannels
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L1_2
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
    end
    L2_2 = table
    L2_2 = L2_2.sort
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = 1
    L3_2 = ipairs
    L4_2 = L1_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = A0_2.state
      L9_2 = L9_2.tempChannel
      if L8_2 == L9_2 then
        L2_2 = L7_2
        break
      end
    end
    L3_2 = L2_2 - 1
    if L3_2 < 1 then
      L3_2 = #L1_2
    end
    L4_2 = A0_2.state
    L5_2 = L1_2[L3_2]
    L4_2.tempChannel = L5_2
    L4_2 = L42_1
    L4_2()
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L61_1 = "btnRight"
  L62_1 = {}
  L63_1 = "\226\134\146"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = {}
    L2_2 = pairs
    L3_2 = A0_2.state
    L3_2 = L3_2.accessibleChannels
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L1_2
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
    end
    L2_2 = table
    L2_2 = L2_2.sort
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = 1
    L3_2 = ipairs
    L4_2 = L1_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = A0_2.state
      L9_2 = L9_2.tempChannel
      if L8_2 == L9_2 then
        L2_2 = L7_2
        break
      end
    end
    L3_2 = L2_2 + 1
    L4_2 = #L1_2
    if L3_2 > L4_2 then
      L3_2 = 1
    end
    L4_2 = A0_2.state
    L5_2 = L1_2[L3_2]
    L4_2.tempChannel = L5_2
    L4_2 = L42_1
    L4_2()
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L59_1.buttons = L60_1
  L60_1 = "display"
  function L61_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L1_2 = A0_2.state
    L1_2 = L1_2.tempChannel
    if not L1_2 then
      L1_2 = {}
      L2_2 = Config
      L2_2 = L2_2.zones
      L3_2 = RadioState
      L3_2 = L3_2.selectedZone
      L2_2 = L2_2[L3_2]
      L2_2 = L2_2.name
      L1_2.line1 = L2_2
      L1_2.line2 = "No Channels"
      return L1_2
    end
    L1_2 = L38_1
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L3_2 = A0_2.state
    L3_2 = L3_2.tempChannel
    L1_2 = L1_2(L2_2, L3_2)
    if not L1_2 then
      L2_2 = {}
      L3_2 = Config
      L3_2 = L3_2.zones
      L4_2 = RadioState
      L4_2 = L4_2.selectedZone
      L3_2 = L3_2[L4_2]
      L3_2 = L3_2.name
      L2_2.line1 = L3_2
      L2_2.line2 = "No Access"
      return L2_2
    end
    L2_2 = RadioState
    L2_2 = L2_2.connected
    if L2_2 then
      L2_2 = RadioState
      L2_2 = L2_2.connectedChannel
      L2_2 = L2_2.zoneId
      L3_2 = RadioState
      L3_2 = L3_2.selectedZone
      L2_2 = L2_2 == L3_2
    end
    L3_2 = false
    L4_2 = ipairs
    L5_2 = RadioState
    L5_2 = L5_2.scannedChannels
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = L9_2.zoneId
      L11_2 = RadioState
      L11_2 = L11_2.selectedZone
      if L10_2 == L11_2 then
        L10_2 = L9_2.channelId
        L11_2 = A0_2.state
        L11_2 = L11_2.tempChannel
        if L10_2 == L11_2 then
          L3_2 = true
          break
        end
      end
    end
    L4_2 = L32_1
    L5_2 = L1_2
    L4_2 = L4_2(L5_2)
    L5_2 = L33_1
    L6_2 = L1_2
    L5_2 = not L4_2 and L5_2
    if L2_2 then
      L6_2 = " [CON]"
      if L6_2 then
        goto lbl_98
      end
    end
    if L3_2 then
      L6_2 = " [SCN]"
      if L6_2 then
        goto lbl_98
      end
    end
    L6_2 = ""
    ::lbl_98::
    L7_2 = {}
    L8_2 = Config
    L8_2 = L8_2.zones
    L9_2 = RadioState
    L9_2 = L9_2.selectedZone
    L8_2 = L8_2[L9_2]
    L8_2 = L8_2.name
    L7_2.line1 = L8_2
    L8_2 = L1_2.name
    L9_2 = L6_2
    L8_2 = L8_2 .. L9_2
    L7_2.line2 = L8_2
    return L7_2
  end
  L59_1[L60_1] = L61_1
  L57_1[L58_1] = L59_1
  L58_1 = "settings"
  L59_1 = {}
  L60_1 = {}
  L61_1 = "btnLeft"
  L62_1 = {}
  L63_1 = "\226\134\144"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = L41_1.settings
    L0_2 = L0_2.currentOption
    if not L0_2 then
      L0_2 = 1
    end
    L1_2 = L0_2 - 1
    if L1_2 < 1 then
      L2_2 = L41_1.settings
      L2_2 = L2_2.options
      L1_2 = #L2_2
    end
    L2_2 = L41_1.settings
    L2_2 = L2_2.display
    L3_2 = {}
    L3_2.selectedOption = L1_2
    L2_2(L3_2)
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L61_1 = "btnRight"
  L62_1 = {}
  L63_1 = "\226\134\146"
  L62_1.text = L63_1
  L63_1 = "action"
  function L64_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = L41_1.settings
    L0_2 = L0_2.currentOption
    if not L0_2 then
      L0_2 = 1
    end
    L1_2 = L0_2 + 1
    L2_2 = L41_1.settings
    L2_2 = L2_2.options
    L2_2 = #L2_2
    if L1_2 > L2_2 then
      L1_2 = 1
    end
    L2_2 = L41_1.settings
    L2_2 = L2_2.display
    L3_2 = {}
    L3_2.selectedOption = L1_2
    L2_2(L3_2)
  end
  L62_1[L63_1] = L64_1
  L60_1[L61_1] = L62_1
  L59_1.buttons = L60_1
  function radioPromptCallsign()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = 16
    L1_2 = Config
    if L1_2 then
      L1_2 = Config.callsign
      if L1_2 and L1_2.maxLength then
        L0_2 = L1_2.maxLength
      end
    end
    L1_2 = AddTextEntry
    L2_2 = "RADIO_CALLSIGN"
    L3_2 = "Enter Callsign"
    L1_2(L2_2, L3_2)
    L1_2 = DisplayOnscreenKeyboard
    L2_2 = 1
    L3_2 = "RADIO_CALLSIGN"
    L1_2(L2_2, L3_2, "", "", "", "", "", L0_2)
    while true do
      L1_2 = UpdateOnscreenKeyboard
      L1_2 = L1_2()
      if 0 ~= L1_2 then
        break
      end
      L1_2 = DisableAllControlActions
      L2_2 = 0
      L1_2(L2_2)
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = 0
      L1_2(L2_2)
    end
    L1_2 = UpdateOnscreenKeyboard
    L1_2 = L1_2()
    if 1 == L1_2 then
      L1_2 = GetOnscreenKeyboardResult
      L1_2 = L1_2()
      if L1_2 and "" ~= L1_2 then
        return L1_2
      end
    end
    L1_2 = nil
    return L1_2
  end
  L60_1 = "options"
  L61_1 = {}
  L62_1 = {}
  L63_1 = "name"
  L64_1 = "GPS"
  L62_1[L63_1] = L64_1
  L63_1 = "value"
  L64_1 = _ENV
  L65_1 = "Settings"
  L64_1 = L64_1[L65_1]
  L65_1 = "loadSetting"
  L64_1 = L64_1[L65_1]
  L65_1 = "gps"
  L64_1 = L64_1(L65_1)
  L62_1[L63_1] = L64_1
  L63_1 = {}
  L64_1 = "btn2"
  L65_1 = {}
  L66_1 = "TGL"
  L65_1.text = L66_1
  L66_1 = "action"
  function L67_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = L1_2.value
    L2_2 = not L2_2
    L1_2.value = L2_2
    L2_2 = RadioState
    L3_2 = L1_2.value
    L2_2.gpsEnabled = L3_2
    L2_2 = setGPS
    L3_2 = L1_2.value
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "gps"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = L1_2.value
    if L3_2 then
      L3_2 = "GPS Enabled"
      if L3_2 then
        goto lbl_26
      end
    end
    L3_2 = "GPS Disabled"
    ::lbl_26::
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
  end
  L65_1[L66_1] = L67_1
  L63_1[L64_1] = L65_1
  L62_1.buttons = L63_1
  L63_1 = {}
  L64_1 = "name"
  L65_1 = "Earbuds"
  L63_1[L64_1] = L65_1
  L64_1 = "value"
  L65_1 = _ENV
  L66_1 = "Settings"
  L65_1 = L65_1[L66_1]
  L66_1 = "loadSetting"
  L65_1 = L65_1[L66_1]
  L66_1 = "earbuds"
  L65_1 = L65_1(L66_1)
  L63_1[L64_1] = L65_1
  L64_1 = {}
  L65_1 = "btn2"
  L66_1 = {}
  L67_1 = "TGL"
  L66_1.text = L67_1
  L67_1 = "action"
  function L68_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = L1_2.value
    L2_2 = not L2_2
    L1_2.value = L2_2
    L2_2 = RadioState
    L3_2 = L1_2.value
    L2_2.earbudsEnabled = L3_2
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "earbuds"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = L1_2.value
    if L3_2 then
      L3_2 = "Earbuds Enabled"
      if L3_2 then
        goto lbl_23
      end
    end
    L3_2 = "Earbuds Disabled"
    ::lbl_23::
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
    L2_2 = L1_2.value
    if L2_2 then
      L2_2 = nil
      L3_2 = playerOwnedVehicle
      if L3_2 then
        L3_2 = DoesEntityExist
        L4_2 = playerOwnedVehicle
        L3_2 = L3_2(L4_2)
        if L3_2 then
          L3_2 = VehToNet
          L4_2 = playerOwnedVehicle
          L3_2 = L3_2(L4_2)
          L2_2 = L3_2
        end
      end
      L3_2 = L19_1.voice
      if L3_2 then
        L3_2 = TriggerServerEvent
        L4_2 = "radio:3DVoiceStopped"
        L5_2 = L19_1.voice
        L5_2 = L5_2.frequency
        L6_2 = L19_1.voice
        L6_2 = L6_2.volume
        L7_2 = L2_2
        L3_2(L4_2, L5_2, L6_2, L7_2)
        L19_1.voice = nil
      end
      L3_2 = L19_1.siren
      if L3_2 then
        L3_2 = TriggerServerEvent
        L4_2 = "radio:3DSirenStopped"
        L5_2 = L2_2
        L3_2(L4_2, L5_2)
        L19_1.siren = nil
      end
      L3_2 = L19_1.heli
      if L3_2 then
        L3_2 = TriggerServerEvent
        L4_2 = "radio:3DHeliStopped"
        L5_2 = L2_2
        L3_2(L4_2, L5_2)
        L19_1.heli = nil
      end
      L3_2 = log
      L4_2 = "Sent stop events for active 3D audio due to earbuds being enabled"
      L5_2 = 4
      L3_2(L4_2, L5_2)
    end
  end
  L66_1[L67_1] = L68_1
  L64_1[L65_1] = L66_1
  L63_1.buttons = L64_1
  L64_1 = {}
  L65_1 = "name"
  L66_1 = "VC Vol"
  L64_1[L65_1] = L66_1
  L65_1 = "value"
  L66_1 = _ENV
  L67_1 = "Settings"
  L66_1 = L66_1[L67_1]
  L67_1 = "loadSetting"
  L66_1 = L66_1[L67_1]
  L67_1 = "volume"
  L66_1 = L66_1(L67_1)
  L64_1[L65_1] = L66_1
  L65_1 = {}
  L66_1 = {}
  L67_1 = "DWN"
  L66_1.text = L67_1
  L67_1 = "action"
  function L68_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = math
    L2_2 = L2_2.max
    L3_2 = 0
    L4_2 = L1_2.value
    L4_2 = L4_2 - 10
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.value = L2_2
    L2_2 = setVolume
    L3_2 = L1_2.value
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
  end
  L66_1[L67_1] = L68_1
  L65_1.btn1 = L66_1
  L66_1 = "btn3"
  L67_1 = {}
  L68_1 = "UP"
  L67_1.text = L68_1
  L68_1 = "action"
  function L69_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = math
    L2_2 = L2_2.min
    L3_2 = 100
    L4_2 = L1_2.value
    L4_2 = L4_2 + 10
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.value = L2_2
    L2_2 = setVolume
    L3_2 = L1_2.value
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
  end
  L67_1[L68_1] = L69_1
  L65_1[L66_1] = L67_1
  L64_1.buttons = L65_1
  L65_1 = {}
  L66_1 = "name"
  L67_1 = "SFX Vol"
  L65_1[L66_1] = L67_1
  L66_1 = "value"
  L67_1 = _ENV
  L68_1 = "Settings"
  L67_1 = L67_1[L68_1]
  L68_1 = "loadSetting"
  L67_1 = L67_1[L68_1]
  L68_1 = "toneVolume"
  L67_1 = L67_1(L68_1)
  L65_1[L66_1] = L67_1
  L66_1 = {}
  L67_1 = {}
  L68_1 = "DWN"
  L67_1.text = L68_1
  L68_1 = "action"
  function L69_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = math
    L2_2 = L2_2.max
    L3_2 = 0
    L4_2 = L1_2.value
    L4_2 = L4_2 - 5
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.value = L2_2
    L2_2 = setToneVolume
    L3_2 = L1_2.value
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "toneVolume"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
  end
  L67_1[L68_1] = L69_1
  L66_1.btn1 = L67_1
  L67_1 = "btn3"
  L68_1 = {}
  L69_1 = "UP"
  L68_1.text = L69_1
  L69_1 = "action"
  function L70_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = math
    L2_2 = L2_2.min
    L3_2 = 100
    L4_2 = L1_2.value
    L4_2 = L4_2 + 5
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.value = L2_2
    L2_2 = setToneVolume
    L3_2 = L1_2.value
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "toneVolume"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
  end
  L68_1[L69_1] = L70_1
  L66_1[L67_1] = L68_1
  L65_1.buttons = L66_1
  L66_1 = {}
  L67_1 = "name"
  L68_1 = "3D Vol"
  L66_1[L67_1] = L68_1
  L67_1 = "value"
  L68_1 = _ENV
  L69_1 = "Settings"
  L68_1 = L68_1[L69_1]
  L69_1 = "loadSetting"
  L68_1 = L68_1[L69_1]
  L69_1 = "volume3D"
  L68_1 = L68_1(L69_1)
  L66_1[L67_1] = L68_1
  L67_1 = "display"
  function L68_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = string
    L1_2 = L1_2.format
    L2_2 = "%.1f"
    L3_2 = A0_2.value
    return L1_2(L2_2, L3_2)
  end
  L66_1[L67_1] = L68_1
  L67_1 = {}
  L68_1 = {}
  L69_1 = "DWN"
  L68_1.text = L69_1
  L69_1 = "action"
  function L70_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = math
    L2_2 = L2_2.max
    L3_2 = 0
    L4_2 = L1_2.value
    L4_2 = L4_2 - 5
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.value = L2_2
    L2_2 = set3DVolume
    L3_2 = L1_2.value
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume3D"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
  end
  L68_1[L69_1] = L70_1
  L67_1.btn1 = L68_1
  L68_1 = "btn3"
  L69_1 = {}
  L70_1 = "UP"
  L69_1.text = L70_1
  L70_1 = "action"
  function L71_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = math
    L2_2 = L2_2.min
    L3_2 = 100
    L4_2 = L1_2.value
    L4_2 = L4_2 + 5
    L2_2 = L2_2(L3_2, L4_2)
    L1_2.value = L2_2
    L2_2 = set3DVolume
    L3_2 = L1_2.value
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume3D"
    L4_2 = L1_2.value
    L2_2(L3_2, L4_2)
    L2_2 = L42_1
    L2_2()
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
  end
  L69_1[L70_1] = L71_1
  L67_1[L68_1] = L69_1
  L66_1.buttons = L67_1
  L67_1 = {}
  L68_1 = "name"
  L69_1 = "Style"
  L67_1[L68_1] = L69_1
  L68_1 = "value"
  L69_1 = nil
  L67_1[L68_1] = L69_1
  function L68_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = L45_1
    L1_2 = L1_2()
    if "Handheld" == L1_2 then
      L2_2 = RadioState
      L2_2 = L2_2.handheldModel
      A0_2.value = L2_2
    else
      L2_2 = L47_1
      L2_2 = L2_2()
      A0_2.value = L2_2
    end
    L2_2 = A0_2.value
    if L2_2 then
      L2_2 = doesTableContain
      L3_2 = Config
      L3_2 = L3_2.radioLayouts
      L4_2 = A0_2.value
      L2_2 = L2_2(L3_2, L4_2)
      if L2_2 then
        goto lbl_30
      end
    end
    L2_2 = L46_1
    L2_2 = L2_2()
    L3_2 = Settings
    L3_2 = L3_2.getDefaultModelForVehicle
    L4_2 = L2_2
    L5_2 = L1_2
    L3_2 = L3_2(L4_2, L5_2)
    A0_2.value = L3_2
    ::lbl_30::
  end
  L67_1.init = L68_1
  L68_1 = {}
  L69_1 = {}
  L70_1 = "\226\134\144"
  L69_1.text = L70_1
  L70_1 = "action"
  function L71_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = L49_1
    L3_2 = Config
    L3_2 = L3_2.radioLayouts
    L4_2 = L1_2.value
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L2_2 - 1
    if L3_2 < 1 then
      L4_2 = Config
      L4_2 = L4_2.radioLayouts
      L3_2 = #L4_2
    end
    L4_2 = nil
    while L3_2 >= 1 do
      L5_2 = Config
      L5_2 = L5_2.radioLayouts
      L4_2 = L5_2[L3_2]
      if nil ~= L4_2 then
        break
      end
      L3_2 = L3_2 - 1
    end
    if nil == L4_2 then
      L5_2 = Config
      L5_2 = L5_2.radioLayouts
      L3_2 = #L5_2
      while L3_2 >= 1 do
        L5_2 = Config
        L5_2 = L5_2.radioLayouts
        L4_2 = L5_2[L3_2]
        if nil ~= L4_2 then
          break
        end
        L3_2 = L3_2 - 1
      end
    end
    if nil == L4_2 then
      return
    end
    L1_2.value = L4_2
    L5_2 = L45_1
    L5_2 = L5_2()
    if "Handheld" == L5_2 then
      L6_2 = RadioState
      L6_2 = L6_2.handheldPos
      if not L6_2 then
        L6_2 = {}
        L6_2.x = 0
        L6_2.y = 0
        L6_2.s = 0
      end
      L7_2 = Settings
      L7_2 = L7_2.saveSetting
      L8_2 = "radioHandheldModel"
      L9_2 = json
      L9_2 = L9_2.encode
      L10_2 = {}
      L10_2.model = L4_2
      L11_2 = L6_2.x
      L10_2.x = L11_2
      L11_2 = L6_2.y
      L10_2.y = L11_2
      L11_2 = L6_2.s
      L10_2.s = L11_2
      L9_2, L10_2, L11_2 = L9_2(L10_2)
      L7_2(L8_2, L9_2, L10_2, L11_2)
      L7_2 = RadioState
      L7_2.handheldModel = L4_2
    else
      L6_2 = L46_1
      L6_2 = L6_2()
      if L6_2 then
        L7_2 = Settings
        L7_2 = L7_2.saveVehicleSpawnCodeModel
        L8_2 = L6_2
        L9_2 = L4_2
        L7_2(L8_2, L9_2)
      end
      L7_2 = Settings
      L7_2 = L7_2.loadModelPosition
      L8_2 = L4_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L8_2 = {}
        L8_2.x = 0
        L8_2.y = 0
        L8_2.s = 0
        L7_2 = L8_2
      end
      L8_2 = setRadioPosition
      L9_2 = L7_2
      L8_2(L9_2)
    end
    L6_2 = L42_1
    L6_2()
    L6_2 = setRadioConfig
    L7_2 = L4_2
    L6_2(L7_2)
  end
  L69_1[L70_1] = L71_1
  L68_1.btn1 = L69_1
  L69_1 = "btn3"
  L70_1 = {}
  L71_1 = "\226\134\146"
  L70_1.text = L71_1
  L71_1 = "action"
  function L72_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = L49_1
    L3_2 = Config
    L3_2 = L3_2.radioLayouts
    L4_2 = L1_2.value
    L2_2 = L2_2(L3_2, L4_2)
    L3_2 = L2_2 + 1
    L4_2 = Config
    L4_2 = L4_2.radioLayouts
    L4_2 = #L4_2
    if L3_2 > L4_2 then
      L3_2 = 1
    end
    L4_2 = nil
    while true do
      L5_2 = Config
      L5_2 = L5_2.radioLayouts
      L5_2 = #L5_2
      if not (L3_2 <= L5_2) then
        break
      end
      L5_2 = Config
      L5_2 = L5_2.radioLayouts
      L4_2 = L5_2[L3_2]
      if nil ~= L4_2 then
        break
      end
      L3_2 = L3_2 + 1
    end
    if nil == L4_2 then
      L3_2 = 1
      while true do
        L5_2 = Config
        L5_2 = L5_2.radioLayouts
        L5_2 = #L5_2
        if not (L3_2 <= L5_2) then
          break
        end
        L5_2 = Config
        L5_2 = L5_2.radioLayouts
        L4_2 = L5_2[L3_2]
        if nil ~= L4_2 then
          break
        end
        L3_2 = L3_2 + 1
      end
    end
    if nil == L4_2 then
      return
    end
    L1_2.value = L4_2
    L5_2 = L45_1
    L5_2 = L5_2()
    if "Handheld" == L5_2 then
      L6_2 = RadioState
      L6_2 = L6_2.handheldPos
      if not L6_2 then
        L6_2 = {}
        L6_2.x = 0
        L6_2.y = 0
        L6_2.s = 0
      end
      L7_2 = Settings
      L7_2 = L7_2.saveSetting
      L8_2 = "radioHandheldModel"
      L9_2 = json
      L9_2 = L9_2.encode
      L10_2 = {}
      L10_2.model = L4_2
      L11_2 = L6_2.x
      L10_2.x = L11_2
      L11_2 = L6_2.y
      L10_2.y = L11_2
      L11_2 = L6_2.s
      L10_2.s = L11_2
      L9_2, L10_2, L11_2 = L9_2(L10_2)
      L7_2(L8_2, L9_2, L10_2, L11_2)
      L7_2 = RadioState
      L7_2.handheldModel = L4_2
    else
      L6_2 = L46_1
      L6_2 = L6_2()
      if L6_2 then
        L7_2 = Settings
        L7_2 = L7_2.saveVehicleSpawnCodeModel
        L8_2 = L6_2
        L9_2 = L4_2
        L7_2(L8_2, L9_2)
      end
      L7_2 = Settings
      L7_2 = L7_2.loadModelPosition
      L8_2 = L4_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L8_2 = {}
        L8_2.x = 0
        L8_2.y = 0
        L8_2.s = 0
        L7_2 = L8_2
      end
      L8_2 = setRadioPosition
      L9_2 = L7_2
      L8_2(L9_2)
    end
    L6_2 = L42_1
    L6_2()
    L6_2 = setRadioConfig
    L7_2 = L4_2
    L6_2(L7_2)
  end
  L70_1[L71_1] = L72_1
  L68_1[L69_1] = L70_1
  L67_1.buttons = L68_1
  L68_1 = {}
  L69_1 = "name"
  L70_1 = "DISP"
  L68_1[L69_1] = L70_1
  L69_1 = "value"
  L70_1 = nil
  L68_1[L69_1] = L70_1
  function L69_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2 = L1_2.theme
    if not L1_2 then
      L1_2 = "Auto"
    end
    A0_2.value = L1_2
  end
  L68_1.init = L69_1
  L69_1 = {}
  L70_1 = {}
  L71_1 = "\226\134\144"
  L70_1.text = L71_1
  L71_1 = "action"
  function L72_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = {}
    L3_2 = "Auto"
    L4_2 = "Light"
    L5_2 = "Dark"
    L2_2[1] = L3_2
    L2_2[2] = L4_2
    L2_2[3] = L5_2
    L3_2 = 1
    L4_2 = ipairs
    L5_2 = L2_2
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = L1_2.value
      if L9_2 == L10_2 then
        L3_2 = L8_2
        break
      end
    end
    L4_2 = L3_2 - 1
    if L4_2 < 1 then
      L4_2 = #L2_2
    end
    L5_2 = L2_2[L4_2]
    L1_2.value = L5_2
    L6_2 = RadioState
    L6_2.theme = L5_2
    L6_2 = Settings
    L6_2 = L6_2.saveSetting
    L7_2 = "theme"
    L8_2 = L5_2
    L6_2(L7_2, L8_2)
    L6_2 = L42_1
    L6_2()
    L6_2 = setTheme
    L7_2 = L5_2
    L6_2(L7_2)
  end
  L70_1[L71_1] = L72_1
  L69_1.btn1 = L70_1
  L70_1 = "btn3"
  L71_1 = {}
  L72_1 = "\226\134\146"
  L71_1.text = L72_1
  L72_1 = "action"
  function L73_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = {}
    L3_2 = "Auto"
    L4_2 = "Light"
    L5_2 = "Dark"
    L2_2[1] = L3_2
    L2_2[2] = L4_2
    L2_2[3] = L5_2
    L3_2 = 1
    L4_2 = ipairs
    L5_2 = L2_2
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = L1_2.value
      if L9_2 == L10_2 then
        L3_2 = L8_2
        break
      end
    end
    L4_2 = L3_2 + 1
    L5_2 = #L2_2
    if L4_2 > L5_2 then
      L4_2 = 1
    end
    L5_2 = L2_2[L4_2]
    L1_2.value = L5_2
    L6_2 = RadioState
    L6_2.theme = L5_2
    L6_2 = Settings
    L6_2 = L6_2.saveSetting
    L7_2 = "theme"
    L8_2 = L5_2
    L6_2(L7_2, L8_2)
    L6_2 = L42_1
    L6_2()
    L6_2 = setTheme
    L7_2 = L5_2
    L6_2(L7_2)
  end
  L71_1[L72_1] = L73_1
  L69_1[L70_1] = L71_1
  L68_1.buttons = L69_1
  L69_1 = {}
  L70_1 = "name"
  L71_1 = "Move"
  L69_1[L70_1] = L71_1
  L70_1 = "value"
  L71_1 = _ENV
  L72_1 = "RadioState"
  L71_1 = L71_1[L72_1]
  L71_1 = L71_1.moveMode
  L69_1[L70_1] = L71_1
  L70_1 = {}
  L71_1 = {}
  L72_1 = "CHG"
  L71_1.text = L72_1
  L72_1 = "action"
  function L73_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = RadioState
    L1_2 = L1_2.moveMode
    L1_2 = not L1_2
    L2_2 = setMoveMode
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = A0_2.getCurrentOption
    L2_2 = L2_2()
    L2_2.value = L1_2
    L2_2 = L42_1
    L2_2()
  end
  L71_1[L72_1] = L73_1
  L70_1.btn1 = L71_1
  L71_1 = "btn2"
  L72_1 = {}
  L73_1 = "RST"
  L72_1.text = L73_1
  L73_1 = "action"
  function L74_1(A0_2)
    local L1_2, L2_2
    L1_2 = setMoveMode
    L2_2 = false
    L1_2(L2_2)
    L1_2 = setRadioPosition
    L2_2 = {}
    L2_2.x = 0
    L2_2.y = 0
    L2_2.s = 0
    L1_2(L2_2)
  end
  L72_1[L73_1] = L74_1
  L70_1[L71_1] = L72_1
  L69_1.buttons = L70_1
  L70_1 = {}
  L71_1 = "name"
  L72_1 = "MIC"
  L70_1[L71_1] = L72_1
  L71_1 = "value"
  L72_1 = nil
  L70_1[L71_1] = L72_1
  function L71_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L1_2 = RadioState
    L1_2 = L1_2.selectedMicrophone
    if L1_2 then
      L2_2 = L1_2.label
      if L2_2 then
        L2_2 = L1_2.label
        L3_2 = string
        L3_2 = L3_2.match
        L4_2 = L2_2
        L5_2 = "Microphone %(([^%)]+)%)"
        L3_2 = L3_2(L4_2, L5_2)
        if not L3_2 then
          L4_2 = string
          L4_2 = L4_2.match
          L5_2 = L2_2
          L6_2 = "%(([^%)]+)%) %([^%)]+%)$"
          L4_2 = L4_2(L5_2, L6_2)
          L3_2 = L4_2
        end
        if not L3_2 then
          L4_2 = string
          L4_2 = L4_2.gsub
          L5_2 = L2_2
          L6_2 = "^%- Microphone "
          L7_2 = ""
          L4_2 = L4_2(L5_2, L6_2, L7_2)
          L3_2 = L4_2
          L4_2 = string
          L4_2 = L4_2.gsub
          L5_2 = L3_2
          L6_2 = "^Microphone "
          L7_2 = ""
          L4_2 = L4_2(L5_2, L6_2, L7_2)
          L3_2 = L4_2
        end
        L2_2 = L3_2 or L2_2
        if not L3_2 then
          L2_2 = "Unknown"
        end
        L4_2 = string
        L4_2 = L4_2.len
        L5_2 = L2_2
        L4_2 = L4_2(L5_2)
        if L4_2 > 10 then
          L4_2 = string
          L4_2 = L4_2.sub
          L5_2 = L2_2
          L6_2 = 1
          L7_2 = 7
          L4_2 = L4_2(L5_2, L6_2, L7_2)
          L5_2 = "..."
          L4_2 = L4_2 .. L5_2
          L2_2 = L4_2
        end
        A0_2.value = L2_2
    end
    else
      A0_2.value = "Default"
    end
  end
  L70_1.init = L71_1
  L71_1 = {}
  L72_1 = {}
  L73_1 = "\226\134\144"
  L72_1.text = L73_1
  L73_1 = "action"
  function L74_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = RadioState
    L2_2 = L2_2.availableMicrophones
    if not L2_2 then
      L2_2 = {}
    end
    L3_2 = #L2_2
    if 0 == L3_2 then
      L3_2 = showAlert
      L4_2 = "No mics found. Check mic in settings."
      L3_2(L4_2)
      L3_2 = SendNUIMessage
      L4_2 = {}
      L4_2.action = "setupMicrophone"
      L3_2(L4_2)
      return
    end
    L3_2 = RadioState
    L3_2 = L3_2.selectedMicrophone
    L4_2 = 1
    L5_2 = ipairs
    L6_2 = L2_2
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = L10_2.deviceId
      L12_2 = L3_2.deviceId
      if L11_2 == L12_2 then
        L4_2 = L9_2
        break
      end
    end
    L5_2 = L4_2 - 1
    if L5_2 < 1 then
      L5_2 = #L2_2
    end
    L6_2 = L2_2[L5_2]
    L7_2 = RadioState
    L7_2.selectedMicrophone = L6_2
    L7_2 = Settings
    L7_2 = L7_2.saveSetting
    L8_2 = "selectedMicrophone"
    L9_2 = json
    L9_2 = L9_2.encode
    L10_2 = L6_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    L7_2 = L6_2.label
    L8_2 = string
    L8_2 = L8_2.match
    L9_2 = L7_2
    L10_2 = "Microphone %(([^%)]+)%)"
    L8_2 = L8_2(L9_2, L10_2)
    if not L8_2 then
      L9_2 = string
      L9_2 = L9_2.match
      L10_2 = L7_2
      L11_2 = "%(([^%)]+)%) %([^%)]+%)$"
      L9_2 = L9_2(L10_2, L11_2)
      L8_2 = L9_2
    end
    if not L8_2 then
      L9_2 = string
      L9_2 = L9_2.gsub
      L10_2 = L7_2
      L11_2 = "^%- Microphone "
      L12_2 = ""
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L8_2 = L9_2
      L9_2 = string
      L9_2 = L9_2.gsub
      L10_2 = L8_2
      L11_2 = "^Microphone "
      L12_2 = ""
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L8_2 = L9_2
    end
    L7_2 = L8_2 or L7_2
    if not L8_2 then
      L7_2 = "Unknown"
    end
    L9_2 = string
    L9_2 = L9_2.len
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    if L9_2 > 10 then
      L9_2 = string
      L9_2 = L9_2.sub
      L10_2 = L7_2
      L11_2 = 1
      L12_2 = 7
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L10_2 = "..."
      L9_2 = L9_2 .. L10_2
      L7_2 = L9_2
    end
    L1_2.value = L7_2
    L9_2 = L42_1
    L9_2()
    L9_2 = SendNUIMessage
    L10_2 = {}
    L10_2.action = "setupMicrophone"
    L9_2(L10_2)
  end
  L72_1[L73_1] = L74_1
  L71_1.btn1 = L72_1
  L72_1 = "btn3"
  L73_1 = {}
  L74_1 = "\226\134\146"
  L73_1.text = L74_1
  L74_1 = "action"
  function L75_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = RadioState
    L2_2 = L2_2.availableMicrophones
    if not L2_2 then
      L2_2 = {}
    end
    L3_2 = #L2_2
    if 0 == L3_2 then
      L3_2 = showAlert
      L4_2 = "No mics found. Check mic in settings."
      L3_2(L4_2)
      L3_2 = SendNUIMessage
      L4_2 = {}
      L4_2.action = "setupMicrophone"
      L3_2(L4_2)
      return
    end
    L3_2 = RadioState
    L3_2 = L3_2.selectedMicrophone
    L4_2 = 1
    L5_2 = ipairs
    L6_2 = L2_2
    L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
    for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
      L11_2 = L10_2.deviceId
      L12_2 = L3_2.deviceId
      if L11_2 == L12_2 then
        L4_2 = L9_2
        break
      end
    end
    L5_2 = L4_2 + 1
    L6_2 = #L2_2
    if L5_2 > L6_2 then
      L5_2 = 1
    end
    L6_2 = L2_2[L5_2]
    L7_2 = RadioState
    L7_2.selectedMicrophone = L6_2
    L7_2 = Settings
    L7_2 = L7_2.saveSetting
    L8_2 = "selectedMicrophone"
    L9_2 = json
    L9_2 = L9_2.encode
    L10_2 = L6_2
    L9_2, L10_2, L11_2, L12_2 = L9_2(L10_2)
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2)
    L7_2 = L6_2.label
    L8_2 = string
    L8_2 = L8_2.match
    L9_2 = L7_2
    L10_2 = "Microphone %(([^%)]+)%)"
    L8_2 = L8_2(L9_2, L10_2)
    if not L8_2 then
      L9_2 = string
      L9_2 = L9_2.match
      L10_2 = L7_2
      L11_2 = "%(([^%)]+)%) %([^%)]+%)$"
      L9_2 = L9_2(L10_2, L11_2)
      L8_2 = L9_2
    end
    if not L8_2 then
      L9_2 = string
      L9_2 = L9_2.gsub
      L10_2 = L7_2
      L11_2 = "^%- Microphone "
      L12_2 = ""
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L8_2 = L9_2
      L9_2 = string
      L9_2 = L9_2.gsub
      L10_2 = L8_2
      L11_2 = "^Microphone "
      L12_2 = ""
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L8_2 = L9_2
    end
    L7_2 = L8_2 or L7_2
    if not L8_2 then
      L7_2 = "Unknown"
    end
    L9_2 = string
    L9_2 = L9_2.len
    L10_2 = L7_2
    L9_2 = L9_2(L10_2)
    if L9_2 > 10 then
      L9_2 = string
      L9_2 = L9_2.sub
      L10_2 = L7_2
      L11_2 = 1
      L12_2 = 7
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L10_2 = "..."
      L9_2 = L9_2 .. L10_2
      L7_2 = L9_2
    end
    L1_2.value = L7_2
    L9_2 = L42_1
    L9_2()
    L9_2 = SendNUIMessage
    L10_2 = {}
    L10_2.action = "setupMicrophone"
    L9_2(L10_2)
  end
  L73_1[L74_1] = L75_1
  L71_1[L72_1] = L73_1
  L70_1.buttons = L71_1
  L71_1 = {}
  L72_1 = "name"
  L73_1 = "Anim"
  L71_1[L72_1] = L73_1
  L72_1 = "value"
  L73_1 = nil
  L71_1[L72_1] = L73_1
  function L72_1(A0_2)
    local L1_2
    L1_2 = RadioState
    L1_2 = L1_2.selectedAnimation
    if not L1_2 then
      L1_2 = 2
    end
    A0_2.value = L1_2
  end
  L71_1.init = L72_1
  L72_1 = "display"
  function L73_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = Config
    L1_2 = L1_2.animations
    if L1_2 then
      L1_2 = Config
      L1_2 = L1_2.animations
      L2_2 = A0_2.value
      L1_2 = L1_2[L2_2]
      if L1_2 then
        L1_2 = Config
        L1_2 = L1_2.animations
        L2_2 = A0_2.value
        L1_2 = L1_2[L2_2]
        L1_2 = L1_2.name
        if not L1_2 then
          L1_2 = "Unknown"
        end
        L2_2 = string
        L2_2 = L2_2.len
        L3_2 = L1_2
        L2_2 = L2_2(L3_2)
        if L2_2 > 10 then
          L2_2 = string
          L2_2 = L2_2.sub
          L3_2 = L1_2
          L4_2 = 1
          L5_2 = 7
          L2_2 = L2_2(L3_2, L4_2, L5_2)
          L3_2 = "..."
          L2_2 = L2_2 .. L3_2
          L1_2 = L2_2
        end
        return L1_2
      end
    end
    L1_2 = "Unknown"
    return L1_2
  end
  L71_1[L72_1] = L73_1
  L72_1 = {}
  L73_1 = {}
  L74_1 = "\226\134\144"
  L73_1.text = L74_1
  L74_1 = "action"
  function L75_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = L1_2.value
    L2_2 = L2_2 - 1
    if L2_2 < 1 then
      L3_2 = Config
      L3_2 = L3_2.animations
      L2_2 = #L3_2
    end
    L1_2.value = L2_2
    L3_2 = RadioState
    L3_2.selectedAnimation = L2_2
    L3_2 = Settings
    L3_2 = L3_2.saveSetting
    L4_2 = "selectedAnimation"
    L5_2 = L2_2
    L3_2(L4_2, L5_2)
    L3_2 = L42_1
    L3_2()
    L3_2 = Radio
    L3_2 = L3_2.playTone
    L4_2 = "beep"
    L3_2(L4_2)
  end
  L73_1[L74_1] = L75_1
  L72_1.btn1 = L73_1
  L73_1 = "btn3"
  L74_1 = {}
  L75_1 = "\226\134\146"
  L74_1.text = L75_1
  L75_1 = "action"
  function L76_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = L1_2.value
    L2_2 = L2_2 + 1
    L3_2 = Config
    L3_2 = L3_2.animations
    L3_2 = #L3_2
    if L2_2 > L3_2 then
      L2_2 = 1
    end
    L1_2.value = L2_2
    L3_2 = RadioState
    L3_2.selectedAnimation = L2_2
    L3_2 = Settings
    L3_2 = L3_2.saveSetting
    L4_2 = "selectedAnimation"
    L5_2 = L2_2
    L3_2(L4_2, L5_2)
    L3_2 = L42_1
    L3_2()
    L3_2 = Radio
    L3_2 = L3_2.playTone
    L4_2 = "beep"
    L3_2(L4_2)
  end
  L74_1[L75_1] = L76_1
  L72_1[L73_1] = L74_1
  L71_1.buttons = L72_1
  L72_1 = {}
  L73_1 = "name"
  L74_1 = "Callsign"
  L72_1[L73_1] = L74_1
  L73_1 = "value"
  L74_1 = ""
  L72_1[L73_1] = L74_1
  L73_1 = "display"
  function L74_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = GetPlayerServerId
    L2_2 = PlayerId
    L2_2 = L2_2()
    L1_2 = L1_2(L2_2)
    L2_2 = getPlayerName
    L2_2 = L2_2(L1_2)
    if not L2_2 then
      L2_2 = ""
    end
    L3_2 = string
    L3_2 = L3_2.len
    L3_2 = L3_2(L2_2)
    if L3_2 > 10 then
      L3_2 = string
      L3_2 = L3_2.sub
      L2_2 = L3_2(L2_2, 1, 7) .. "..."
    end
    return L2_2
  end
  L72_1[L73_1] = L74_1
  L73_1 = {}
  L74_1 = "btn1"
  L75_1 = {}
  L76_1 = "CLR"
  L75_1.text = L76_1
  L76_1 = "action"
  function L77_1(A0_2)
    local L1_2
    L1_2 = TriggerServerEvent
    L1_2("radio:setCallsign", "")
    L1_2 = L41_1.settings
    L1_2 = L1_2.display
    L1_2()
  end
  L75_1[L76_1] = L77_1
  L73_1[L74_1] = L75_1
  L74_1 = "btn2"
  L75_1 = {}
  L76_1 = "SET"
  L75_1.text = L76_1
  L76_1 = "action"
  function L77_1(A0_2)
    local L1_2, L2_2
    L1_2 = radioPromptCallsign
    L1_2 = L1_2()
    if L1_2 then
      L2_2 = TriggerServerEvent
      L2_2("radio:setCallsign", L1_2)
      L2_2 = L41_1.settings
      L2_2 = L2_2.display
      L2_2()
    end
  end
  L75_1[L76_1] = L77_1
  L73_1[L74_1] = L75_1
  L72_1.buttons = L73_1
  L61_1[1] = L62_1
  L61_1[2] = L63_1
  L61_1[3] = L64_1
  L61_1[4] = L65_1
  L61_1[5] = L66_1
  L61_1[6] = L67_1
  L61_1[7] = L68_1
  L61_1[8] = L69_1
  L61_1[9] = L70_1
  L61_1[10] = L71_1
  L61_1[11] = L72_1
  L59_1[L60_1] = L61_1
  L60_1 = "getCurrentOption"
  function L61_1()
    local L0_2, L1_2
    L0_2 = L41_1.settings
    L0_2 = L0_2.options
    L1_2 = L41_1.settings
    L1_2 = L1_2.currentOption
    L0_2 = L0_2[L1_2]
    return L0_2
  end
  L59_1[L60_1] = L61_1
  L60_1 = "display"
  function L61_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2
    L1_2 = L41_1.settings
    L1_2 = L1_2.currentOption
    if not L1_2 then
      L1_2 = L41_1.settings
      L1_2.currentOption = 1
    end
    if A0_2 then
      L1_2 = A0_2.selectedOption
      if L1_2 then
        L1_2 = L41_1.settings
        L2_2 = A0_2.selectedOption
        L1_2.currentOption = L2_2
      end
    end
    L1_2 = L41_1.settings
    L1_2 = L1_2.getCurrentOption
    L1_2 = L1_2()
    L2_2 = L41_1.settings
    L2_2 = L2_2.buttons
    L2_2.btn1 = nil
    L2_2 = L41_1.settings
    L2_2 = L2_2.buttons
    L2_2.btn2 = nil
    L2_2 = L41_1.settings
    L2_2 = L2_2.buttons
    L2_2.btn3 = nil
    L2_2 = L41_1.settings
    L2_2 = L2_2.buttons
    L3_2 = {}
    L3_2.text = "\226\134\144"
    function L4_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = L41_1.settings
      L0_3 = L0_3.currentOption
      if not L0_3 then
        L0_3 = 1
      end
      L1_3 = L0_3 - 1
      if L1_3 < 1 then
        L2_3 = L41_1.settings
        L2_3 = L2_3.options
        L1_3 = #L2_3
      end
      L2_3 = L41_1.settings
      L2_3 = L2_3.display
      L3_3 = {}
      L3_3.selectedOption = L1_3
      L2_3(L3_3)
    end
    L3_2.action = L4_2
    L2_2.btnLeft = L3_2
    L2_2 = L41_1.settings
    L2_2 = L2_2.buttons
    L3_2 = {}
    L3_2.text = "\226\134\146"
    function L4_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = L41_1.settings
      L0_3 = L0_3.currentOption
      if not L0_3 then
        L0_3 = 1
      end
      L1_3 = L0_3 + 1
      L2_3 = L41_1.settings
      L2_3 = L2_3.options
      L2_3 = #L2_3
      if L1_3 > L2_3 then
        L1_3 = 1
      end
      L2_3 = L41_1.settings
      L2_3 = L2_3.display
      L3_3 = {}
      L3_3.selectedOption = L1_3
      L2_3(L3_3)
    end
    L3_2.action = L4_2
    L2_2.btnRight = L3_2
    L2_2 = ""
    L3_2 = ""
    L4_2 = ""
    L5_2 = L1_2.buttons
    if L5_2 then
      L5_2 = L1_2.buttons
      L5_2 = L5_2.btn1
      if L5_2 then
        L5_2 = L1_2.buttons
        L5_2 = L5_2.btn1
        L2_2 = L5_2.text
        L5_2 = L41_1.settings
        L5_2 = L5_2.buttons
        L6_2 = L1_2.buttons
        L6_2 = L6_2.btn1
        L5_2.btn1 = L6_2
      end
      L5_2 = L1_2.buttons
      L5_2 = L5_2.btn2
      if L5_2 then
        L5_2 = L1_2.buttons
        L5_2 = L5_2.btn2
        L3_2 = L5_2.text
        L5_2 = L41_1.settings
        L5_2 = L5_2.buttons
        L6_2 = L1_2.buttons
        L6_2 = L6_2.btn2
        L5_2.btn2 = L6_2
      end
      L5_2 = L1_2.buttons
      L5_2 = L5_2.btn3
      if L5_2 then
        L5_2 = L1_2.buttons
        L5_2 = L5_2.btn3
        L4_2 = L5_2.text
        L5_2 = L41_1.settings
        L5_2 = L5_2.buttons
        L6_2 = L1_2.buttons
        L6_2 = L6_2.btn3
        L5_2.btn3 = L6_2
      end
    end
    L5_2 = nil
    L6_2 = type
    L7_2 = L1_2.value
    L6_2 = L6_2(L7_2)
    if "boolean" == L6_2 then
      L6_2 = L1_2.value
      if L6_2 then
        L6_2 = "ON"
        L5_2 = L6_2 or L5_2
      end
      if not L6_2 then
        L5_2 = "OFF"
      end
    else
      L6_2 = L1_2.display
      if L6_2 then
        L6_2 = L1_2.display
        L7_2 = L1_2
        L6_2 = L6_2(L7_2)
        L5_2 = L6_2
      else
        L6_2 = L1_2.value
        if L6_2 then
          L6_2 = tostring
          L7_2 = L1_2.value
          L6_2 = L6_2(L7_2)
          if L6_2 then
            goto lbl_116
            L5_2 = L6_2 or L5_2
          end
        end
        L5_2 = ""
      end
    end
    ::lbl_116::
    L6_2 = L1_2.value
    if L6_2 then
      L6_2 = string
      L6_2 = L6_2.format
      L7_2 = "%s: %s"
      L8_2 = L1_2.name
      L9_2 = L5_2
      L6_2 = L6_2(L7_2, L8_2, L9_2)
      if L6_2 then
        goto lbl_128
      end
    end
    L6_2 = L1_2.name
    ::lbl_128::
    L7_2 = dispUpdate
    L8_2 = L2_2
    L9_2 = L3_2
    L10_2 = L4_2
    L11_2 = ""
    L12_2 = ""
    L13_2 = "Settings"
    L14_2 = L6_2
    L15_2 = 0
    L16_2 = 0
    L7_2(L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2)
    L7_2 = {}
    L7_2.line1 = "Settings"
    L7_2.line2 = L6_2
    return L7_2
  end
  L59_1[L60_1] = L61_1
  L57_1[L58_1] = L59_1
  L41_1 = L57_1
  L57_1 = AddEventHandler
  L58_1 = "radio:talkerState"
  function L59_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2
    L1_2 = A0_2.state
    L2_2 = A0_2.serverId
    L3_2 = A0_2.frequency
    L4_2 = GetPlayerServerId
    L5_2 = PlayerId
    L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L5_2()
    L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
    if not L2_2 or not L3_2 then
      L5_2 = log
      L6_2 = "Invalid talker state data received"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      return
    end
    L5_2 = false
    L6_2 = false
    L7_2 = RadioState
    L7_2 = L7_2.connected
    if L7_2 then
      L7_2 = RadioState
      L7_2 = L7_2.connectedChannel
      L7_2 = L7_2.frequency
      if L7_2 then
        L7_2 = L40_1
        L7_2 = L7_2()
        if L7_2 then
          L8_2 = RadioState
          L8_2 = L8_2.isChannelTrunked
          if L8_2 then
            L8_2 = convertFreq
            L9_2 = L7_2.frequency
            L8_2 = L8_2(L9_2)
            L9_2 = Radio
            L9_2 = L9_2.getChannel
            L9_2 = L9_2()
            L10_2 = convertFreq
            L11_2 = L3_2
            L10_2 = L10_2(L11_2)
            L6_2 = L10_2 == L8_2
            L5_2 = L6_2 or L5_2
            if not L6_2 then
              L10_2 = convertFreq
              L11_2 = L3_2
              L10_2 = L10_2(L11_2)
              L5_2 = L10_2 == L9_2
            end
          else
            L8_2 = convertFreq
            L9_2 = L3_2
            L8_2 = L8_2(L9_2)
            L9_2 = convertFreq
            L10_2 = RadioState
            L10_2 = L10_2.connectedChannel
            L10_2 = L10_2.frequency
            L9_2 = L9_2(L10_2)
            L5_2 = L8_2 == L9_2
          end
        end
      end
    end
    L7_2 = false
    if not L5_2 then
      L8_2 = log
      L9_2 = "Checking scanned channels for freq: "
      L10_2 = tostring
      L11_2 = L3_2
      L10_2 = L10_2(L11_2)
      L11_2 = " converted: "
      L12_2 = tostring
      L13_2 = convertFreq
      L14_2 = L3_2
      L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L13_2(L14_2)
      L12_2 = L12_2(L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
      L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
      L10_2 = 4
      L8_2(L9_2, L10_2)
      L8_2 = log
      L9_2 = "Total scanned channels: "
      L10_2 = tostring
      L11_2 = RadioState
      L11_2 = L11_2.scannedChannels
      L11_2 = #L11_2
      L10_2 = L10_2(L11_2)
      L9_2 = L9_2 .. L10_2
      L10_2 = 4
      L8_2(L9_2, L10_2)
      L8_2 = ipairs
      L9_2 = RadioState
      L9_2 = L9_2.scannedChannels
      L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
      for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
        L14_2 = Config
        L14_2 = L14_2.zones
        L15_2 = L13_2.zoneId
        L14_2 = L14_2[L15_2]
        if L14_2 then
          L14_2 = Config
          L14_2 = L14_2.zones
          L15_2 = L13_2.zoneId
          L14_2 = L14_2[L15_2]
          L14_2 = L14_2.Channels
          L15_2 = L13_2.channelId
          L14_2 = L14_2[L15_2]
        end
        if L14_2 then
          L15_2 = convertFreq
          L16_2 = L3_2
          L15_2 = L15_2(L16_2)
          L16_2 = convertFreq
          L17_2 = L14_2.frequency
          L16_2 = L16_2(L17_2)
          L17_2 = log
          L18_2 = "Comparing with channel: "
          L19_2 = tostring
          L20_2 = L14_2.frequency
          L19_2 = L19_2(L20_2)
          L20_2 = " converted: "
          L21_2 = tostring
          L22_2 = L16_2
          L21_2 = L21_2(L22_2)
          L18_2 = L18_2 .. L19_2 .. L20_2 .. L21_2
          L19_2 = 3
          L17_2(L18_2, L19_2)
          if L15_2 == L16_2 then
            L17_2 = log
            L18_2 = "FOUND MATCH on conventional scanned channel!"
            L19_2 = 4
            L17_2(L18_2, L19_2)
            L7_2 = true
            break
          else
            L17_2 = L14_2.type
            if "trunked" == L17_2 then
              L17_2 = RadioState
              L17_2 = L17_2.scannedTrunkedFreqs
              if L17_2 then
                L17_2 = RadioState
                L17_2 = L17_2.scannedTrunkedFreqs
                L18_2 = L13_2.channelId
                L17_2 = L17_2[L18_2]
                if L17_2 then
                  L17_2 = convertFreq
                  L18_2 = RadioState
                  L18_2 = L18_2.scannedTrunkedFreqs
                  L19_2 = L13_2.channelId
                  L18_2 = L18_2[L19_2]
                  L17_2 = L17_2(L18_2)
                  if L15_2 == L17_2 then
                    L17_2 = log
                    L18_2 = "FOUND MATCH on trunked scanned channel!"
                    L19_2 = 4
                    L17_2(L18_2, L19_2)
                    L7_2 = true
                    break
                  end
                end
              end
            end
          end
        end
      end
    end
    L8_2 = log
    L9_2 = "Results - isConnectedChannel: "
    L10_2 = tostring
    L11_2 = L5_2
    L10_2 = L10_2(L11_2)
    L11_2 = " isScannedChannel: "
    L12_2 = tostring
    L13_2 = L7_2
    L12_2 = L12_2(L13_2)
    L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
    L10_2 = 4
    L8_2(L9_2, L10_2)
    if L5_2 or L7_2 then
      if L1_2 then
        if L5_2 then
          L8_2 = RadioState
          L8_2 = L8_2.scannedChannelTalker
          if L8_2 then
            L8_2 = RadioState
            L8_2 = L8_2.pausedScanForConnectedTransmission
            if not L8_2 then
              L8_2 = RadioState
              L8_2.pausedScanForConnectedTransmission = true
              L8_2 = log
              L9_2 = "Pausing scan transmission for connected channel priority"
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = TriggerEvent
              L9_2 = "radio:stopAllSirens"
              L8_2(L9_2)
              L8_2 = SendNUIMessage
              L9_2 = {}
              L9_2.action = "stopAll3DAudio"
              L8_2(L9_2)
              L8_2 = RadioState
              L8_2 = L8_2.tempScannedChannels
              if not L8_2 then
                L8_2 = RadioState
                L9_2 = table
                L9_2 = L9_2.deepcopy
                L10_2 = RadioState
                L10_2 = L10_2.scannedChannels
                L9_2 = L9_2(L10_2)
                L8_2.tempScannedChannels = L9_2
                L8_2 = ipairs
                L9_2 = RadioState
                L9_2 = L9_2.scannedChannels
                L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
                for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
                  L14_2 = Config
                  L14_2 = L14_2.zones
                  L15_2 = L13_2.zoneId
                  L14_2 = L14_2[L15_2]
                  if L14_2 then
                    L14_2 = Config
                    L14_2 = L14_2.zones
                    L15_2 = L13_2.zoneId
                    L14_2 = L14_2[L15_2]
                    L14_2 = L14_2.Channels
                    L15_2 = L13_2.channelId
                    L14_2 = L14_2[L15_2]
                  end
                  if L14_2 then
                    L15_2 = Radio
                    L15_2 = L15_2.removeListeningChannel
                    L16_2 = convertFreq
                    L17_2 = L14_2.frequency
                    L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L16_2(L17_2)
                    L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
                    L15_2 = L14_2.type
                    if "trunked" == L15_2 then
                      L15_2 = RadioState
                      L15_2 = L15_2.scannedTrunkedFreqs
                      if L15_2 then
                        L15_2 = RadioState
                        L15_2 = L15_2.scannedTrunkedFreqs
                        L16_2 = L13_2.channelId
                        L15_2 = L15_2[L16_2]
                        if L15_2 then
                          L15_2 = Radio
                          L15_2 = L15_2.removeListeningChannel
                          L16_2 = convertFreq
                          L17_2 = RadioState
                          L17_2 = L17_2.scannedTrunkedFreqs
                          L18_2 = L13_2.channelId
                          L17_2 = L17_2[L18_2]
                          L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L16_2(L17_2)
                          L15_2(L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
          L8_2 = RadioState
          L8_2.connectedChannelTalker = L2_2
          L8_2 = RadioState
          L8_2.activeTalker = L2_2
          L8_2 = RadioState
          L8_2.activeTransmissionFreq = L3_2
          L8_2 = setLED
          L9_2 = "transmit"
          L10_2 = true
          L8_2(L9_2, L10_2)
          L8_2 = GetPlayerServerId
          L9_2 = PlayerId
          L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L9_2()
          L8_2 = L8_2(L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
          if L2_2 == L8_2 then
            L9_2 = log
            L10_2 = "Confirmed own talking state from server"
            L11_2 = 4
            L9_2(L10_2, L11_2)
          else
            L9_2 = log
            L10_2 = "Someone else started talking: "
            L11_2 = L2_2
            L10_2 = L10_2 .. L11_2
            L11_2 = 4
            L9_2(L10_2, L11_2)
          end
          if L2_2 == L8_2 then
            L9_2 = L21_1
            if not L9_2 then
              goto lbl_355
            end
          end
          L9_2 = radioSystemAccess
          if true == L9_2 then
            L9_2 = RadioState
            L9_2 = L9_2.power
            if L9_2 then
              L9_2 = RadioState
              L9_2 = L9_2.earbudsEnabled
              if not L9_2 then
                L9_2 = nil
                L10_2 = playerOwnedVehicle
                if L10_2 then
                  L10_2 = DoesEntityExist
                  L11_2 = playerOwnedVehicle
                  L10_2 = L10_2(L11_2)
                  if L10_2 then
                    L10_2 = VehToNet
                    L11_2 = playerOwnedVehicle
                    L10_2 = L10_2(L11_2)
                    L9_2 = L10_2
                  end
                end
                L10_2 = TriggerServerEvent
                L11_2 = "radio:3DVoiceStarted"
                L12_2 = L3_2
                L13_2 = RadioState
                L13_2 = L13_2.volume
                if not L13_2 then
                  L13_2 = 50
                end
                L14_2 = L9_2
                L10_2(L11_2, L12_2, L13_2, L14_2)
                L10_2 = {}
                L10_2.frequency = L3_2
                L11_2 = RadioState
                L11_2 = L11_2.volume
                if not L11_2 then
                  L11_2 = 50
                end
                L10_2.volume = L11_2
                L19_1.voice = L10_2
              end
            end
          end
          ::lbl_355::
          if L2_2 ~= L8_2 then
            L9_2 = Radio
            L9_2 = L9_2.playTone
            L10_2 = "TX_START"
            L9_2(L10_2)
            L9_2 = RadioState
            L9_2.txToneActive = true
            L9_2 = log
            L10_2 = "Checking transmission effects - analogTransmissionEffects: "
            L11_2 = tostring
            L12_2 = Config
            L12_2 = L12_2.analogTransmissionEffects
            L11_2 = L11_2(L12_2)
            L10_2 = L10_2 .. L11_2
            L11_2 = 4
            L9_2(L10_2, L11_2)
            L9_2 = Config
            L9_2 = L9_2.analogTransmissionEffects
            if L9_2 then
              L9_2 = RadioState
              L9_2 = L9_2.earbudsEnabled
              if not L9_2 then
                L9_2 = log
                L10_2 = "Starting analog transmission effects"
                L11_2 = 4
                L9_2(L10_2, L11_2)
                L9_2 = SendNUIMessage
                L10_2 = {}
                L10_2.action = "startTransmission"
                L9_2(L10_2)
                L9_2 = nil
                L10_2 = playerOwnedVehicle
                if L10_2 then
                  L10_2 = DoesEntityExist
                  L11_2 = playerOwnedVehicle
                  L10_2 = L10_2(L11_2)
                  if L10_2 then
                    L10_2 = VehToNet
                    L11_2 = playerOwnedVehicle
                    L10_2 = L10_2(L11_2)
                    L9_2 = L10_2
                  end
                end
                L10_2 = log
                L11_2 = "Triggering 3D transmission start - vehicle: "
                L12_2 = tostring
                L13_2 = L9_2
                L12_2 = L12_2(L13_2)
                L13_2 = " (type: "
                L14_2 = type
                L15_2 = L9_2
                L14_2 = L14_2(L15_2)
                L15_2 = ")"
                L11_2 = L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2
                L12_2 = 4
                L10_2(L11_2, L12_2)
                L10_2 = TriggerServerEvent
                L11_2 = "radio:3DTransmissionStarted"
                L12_2 = L9_2
                L10_2(L11_2, L12_2)
                L10_2 = log
                L11_2 = "Sent radio:3DTransmissionStarted event to server"
                L12_2 = 4
                L10_2(L11_2, L12_2)
            end
            else
              L9_2 = log
              L10_2 = "Analog transmission effects disabled or earbuds enabled"
              L11_2 = 3
              L9_2(L10_2, L11_2)
            end
          end
          L9_2 = log
          L10_2 = "Connected transmission start - Player: "
          L11_2 = L2_2
          L12_2 = ", MyID: "
          L13_2 = L8_2
          L14_2 = ", SirenList: "
          L15_2 = tostring
          L16_2 = L12_1
          L16_2 = L16_2[L2_2]
          L15_2 = L15_2(L16_2)
          L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2 .. L15_2
          L11_2 = 4
          L9_2(L10_2, L11_2)
          if L2_2 ~= L8_2 then
          L9_2 = L12_1
          L9_2 = L9_2[L2_2]
          L10_2 = Config
          L10_2 = L10_2.playTransmissionEffects
          if L9_2 and L10_2 then
              L9_2 = log
              L10_2 = "Starting background siren for player "
              L11_2 = L2_2
              L10_2 = L10_2 .. L11_2
              L11_2 = 4
              L9_2(L10_2, L11_2)
              L9_2 = SendNUIMessage
              L10_2 = {}
              L10_2.action = "startSiren"
              L10_2.serverId = L2_2
              L9_2(L10_2)
              L9_2 = L13_1
              L9_2[L2_2] = true
              L9_2 = log
              L10_2 = "Sent startSiren message to NUI for player "
              L11_2 = L2_2
              L10_2 = L10_2 .. L11_2
              L11_2 = 4
              L9_2(L10_2, L11_2)
              L9_2 = RadioState
              L9_2 = L9_2.power
              if L9_2 then
                L9_2 = nil
                L10_2 = playerOwnedVehicle
                if L10_2 then
                  L10_2 = DoesEntityExist
                  L11_2 = playerOwnedVehicle
                  L10_2 = L10_2(L11_2)
                  if L10_2 then
                    L10_2 = VehToNet
                    L11_2 = playerOwnedVehicle
                    L10_2 = L10_2(L11_2)
                    L9_2 = L10_2
                  end
                end
                L10_2 = TriggerServerEvent
                L11_2 = "radio:3DSirenStarted"
                L12_2 = L9_2
                L10_2(L11_2, L12_2)
                L19_1.siren = true
              end
          end
          else
            L9_2 = log
            L10_2 = "NOT starting siren - isMyself: "
            L11_2 = tostring
            L12_2 = L2_2 == L8_2
            L11_2 = L11_2(L12_2)
            L12_2 = ", hasSiren: "
            L13_2 = tostring
            L14_2 = L12_1
            L14_2 = L14_2[L2_2]
            L13_2 = L13_2(L14_2)
            L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2
            L11_2 = 4
            L9_2(L10_2, L11_2)
          end
          if L2_2 ~= L8_2 then
            L9_2 = L15_1
            L9_2 = L9_2[L2_2]
            L10_2 = Config
            L10_2 = L10_2.playTransmissionEffects
            if L9_2 and L10_2 then
              L9_2 = log
              L10_2 = "Starting background helicopter for player "
              L11_2 = L2_2
              L10_2 = L10_2 .. L11_2
              L11_2 = 4
              L9_2(L10_2, L11_2)
              L9_2 = SendNUIMessage
              L10_2 = {}
              L10_2.action = "startHeli"
              L10_2.serverId = L2_2
              L9_2(L10_2)
              L9_2 = L16_1
              L9_2[L2_2] = true
              L9_2 = log
              L10_2 = "Sent startHeli message to NUI for player "
              L11_2 = L2_2
              L10_2 = L10_2 .. L11_2
              L11_2 = 4
              L9_2(L10_2, L11_2)
              L9_2 = RadioState
              L9_2 = L9_2.power
              if L9_2 then
                L9_2 = nil
                L10_2 = playerOwnedVehicle
                if L10_2 then
                  L10_2 = DoesEntityExist
                  L11_2 = playerOwnedVehicle
                  L10_2 = L10_2(L11_2)
                  if L10_2 then
                    L10_2 = VehToNet
                    L11_2 = playerOwnedVehicle
                    L10_2 = L10_2(L11_2)
                    L9_2 = L10_2
                  end
                end
                L10_2 = TriggerServerEvent
                L11_2 = "radio:3DHeliStarted"
                L12_2 = L9_2
                L10_2(L11_2, L12_2)
                L19_1.heli = true
              end
          end
          else
            L9_2 = log
            L10_2 = "NOT starting helicopter - isMyself: "
            L11_2 = tostring
            L12_2 = L2_2 == L8_2
            L11_2 = L11_2(L12_2)
            L12_2 = ", hasHeli: "
            L13_2 = tostring
            L14_2 = L15_1
            L14_2 = L14_2[L2_2]
            L13_2 = L13_2(L14_2)
            L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2
            L11_2 = 4
            L9_2(L10_2, L11_2)
          end
          L9_2 = L42_1
          L9_2()
        else
          if not L7_2 then
            goto lbl_1268
          end
          L8_2 = RadioState
          L8_2 = L8_2.connectedChannelTalker
          if L8_2 then
            goto lbl_1268
          end
          L8_2 = RadioState
          L8_2.scannedChannelTalker = L2_2
          L8_2 = RadioState
          L8_2.activeTalker = L2_2
          L8_2 = RadioState
          L8_2.activeTransmissionFreq = L3_2
          L8_2 = setLED
          L9_2 = "transmit"
          L10_2 = true
          L8_2(L9_2, L10_2)
          if L2_2 == L4_2 then
            L8_2 = L21_1
            if not L8_2 then
              goto lbl_637
            end
          end
          L8_2 = radioSystemAccess
          if true == L8_2 then
            L8_2 = RadioState
            L8_2 = L8_2.power
            if L8_2 then
              L8_2 = RadioState
              L8_2 = L8_2.earbudsEnabled
              if not L8_2 then
                L8_2 = nil
                L9_2 = playerOwnedVehicle
                if L9_2 then
                  L9_2 = DoesEntityExist
                  L10_2 = playerOwnedVehicle
                  L9_2 = L9_2(L10_2)
                  if L9_2 then
                    L9_2 = VehToNet
                    L10_2 = playerOwnedVehicle
                    L9_2 = L9_2(L10_2)
                    L8_2 = L9_2
                  end
                end
                L9_2 = TriggerServerEvent
                L10_2 = "radio:3DVoiceStarted"
                L11_2 = L3_2
                L12_2 = RadioState
                L12_2 = L12_2.volume
                if not L12_2 then
                  L12_2 = 50
                end
                L13_2 = L8_2
                L9_2(L10_2, L11_2, L12_2, L13_2)
                L9_2 = {}
                L9_2.frequency = L3_2
                L10_2 = RadioState
                L10_2 = L10_2.volume
                if not L10_2 then
                  L10_2 = 50
                end
                L9_2.volume = L10_2
                L19_1.voice = L9_2
              end
            end
          end
          ::lbl_637::
          if L2_2 ~= L4_2 then
            L8_2 = Radio
            L8_2 = L8_2.playTone
            L9_2 = "TX_START"
            L8_2(L9_2)
            L8_2 = RadioState
            L8_2.txToneActive = true
          end
          L8_2 = log
          L9_2 = "Scanned transmission start - Player: "
          L10_2 = L2_2
          L11_2 = ", MyID: "
          L12_2 = L4_2
          L13_2 = ", SirenList: "
          L14_2 = tostring
          L15_2 = L12_1
          L15_2 = L15_2[L2_2]
          L14_2 = L14_2(L15_2)
          L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
          L10_2 = 2
          L8_2(L9_2, L10_2)
          if L2_2 ~= L4_2 then
          L8_2 = L12_1
          L8_2 = L8_2[L2_2]
          L9_2 = Config
          L9_2 = L9_2.playTransmissionEffects
          if L8_2 and L9_2 then
              L8_2 = log
              L9_2 = "Starting background siren for player "
              L10_2 = L2_2
              L11_2 = " on scanned channel"
              L9_2 = L9_2 .. L10_2 .. L11_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = SendNUIMessage
              L9_2 = {}
              L9_2.action = "startSiren"
              L9_2.serverId = L2_2
              L8_2(L9_2)
              L8_2 = L13_1
              L8_2[L2_2] = true
              L8_2 = log
              L9_2 = "Sent startSiren message to NUI for player "
              L10_2 = L2_2
              L11_2 = " (scanned)"
              L9_2 = L9_2 .. L10_2 .. L11_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = radioSystemAccess
              if true == L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.power
                if L8_2 then
                  L8_2 = RadioState
                  L8_2 = L8_2.earbudsEnabled
                  if not L8_2 then
                    L8_2 = nil
                    L9_2 = playerOwnedVehicle
                    if L9_2 then
                      L9_2 = DoesEntityExist
                      L10_2 = playerOwnedVehicle
                      L9_2 = L9_2(L10_2)
                      if L9_2 then
                        L9_2 = VehToNet
                        L10_2 = playerOwnedVehicle
                        L9_2 = L9_2(L10_2)
                        L8_2 = L9_2
                      end
                    end
                    L9_2 = TriggerServerEvent
                    L10_2 = "radio:3DSirenStarted"
                    L11_2 = L8_2
                    L9_2(L10_2, L11_2)
                    L19_1.siren = true
                  end
                end
              end
          end
          else
            L8_2 = log
            L9_2 = "NOT starting siren (scanned) - isMyself: "
            L10_2 = tostring
            L11_2 = L2_2 == L4_2
            L10_2 = L10_2(L11_2)
            L11_2 = ", hasSiren: "
            L12_2 = tostring
            L13_2 = L12_1
            L13_2 = L13_2[L2_2]
            L12_2 = L12_2(L13_2)
            L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
            L10_2 = 4
            L8_2(L9_2, L10_2)
          end
          if L2_2 ~= L4_2 then
            L8_2 = L15_1
            L8_2 = L8_2[L2_2]
            L9_2 = Config
            L9_2 = L9_2.playTransmissionEffects
            if L8_2 and L9_2 then
              L8_2 = log
              L9_2 = "Starting background helicopter for player "
              L10_2 = L2_2
              L11_2 = " on scanned channel"
              L9_2 = L9_2 .. L10_2 .. L11_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = SendNUIMessage
              L9_2 = {}
              L9_2.action = "startHeli"
              L9_2.serverId = L2_2
              L8_2(L9_2)
              L8_2 = L16_1
              L8_2[L2_2] = true
              L8_2 = log
              L9_2 = "Sent startHeli message to NUI for player "
              L10_2 = L2_2
              L11_2 = " (scanned)"
              L9_2 = L9_2 .. L10_2 .. L11_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = radioSystemAccess
              if true == L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.power
                if L8_2 then
                  L8_2 = RadioState
                  L8_2 = L8_2.earbudsEnabled
                  if not L8_2 then
                    L8_2 = nil
                    L9_2 = playerOwnedVehicle
                    if L9_2 then
                      L9_2 = DoesEntityExist
                      L10_2 = playerOwnedVehicle
                      L9_2 = L9_2(L10_2)
                      if L9_2 then
                        L9_2 = VehToNet
                        L10_2 = playerOwnedVehicle
                        L9_2 = L9_2(L10_2)
                        L8_2 = L9_2
                      end
                    end
                    L9_2 = TriggerServerEvent
                    L10_2 = "radio:3DHeliStarted"
                    L11_2 = L8_2
                    L9_2(L10_2, L11_2)
                    L19_1.heli = true
                  end
                end
              end
          end
          else
            L8_2 = log
            L9_2 = "NOT starting helicopter (scanned) - isMyself: "
            L10_2 = tostring
            L11_2 = L2_2 == L4_2
            L10_2 = L10_2(L11_2)
            L11_2 = ", hasHeli: "
            L12_2 = tostring
            L13_2 = L15_1
            L13_2 = L13_2[L2_2]
            L12_2 = L12_2(L13_2)
            L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2
            L10_2 = 4
            L8_2(L9_2, L10_2)
          end
          L8_2 = L42_1
          L8_2()
        end
      else
        L8_2 = RadioState
        L8_2 = L8_2.activeTalker
        if L2_2 == L8_2 then
          L8_2 = convertFreq
          L9_2 = L3_2
          L8_2 = L8_2(L9_2)
          L9_2 = convertFreq
          L10_2 = RadioState
          L10_2 = L10_2.activeTransmissionFreq
          L9_2 = L9_2(L10_2)
          if L8_2 == L9_2 then
            L8_2 = RadioState
            L8_2 = L8_2.connectedChannelTalker
            if L2_2 == L8_2 then
              L8_2 = RadioState
              L8_2.connectedChannelTalker = nil
            end
            L8_2 = RadioState
            L8_2 = L8_2.scannedChannelTalker
            if L2_2 == L8_2 then
              L8_2 = RadioState
              L8_2.scannedChannelTalker = nil
            end
            L8_2 = RadioState
            L8_2.activeTalker = nil
            L8_2 = RadioState
            L8_2.activeTransmissionFreq = nil
            L8_2 = setLED
            L9_2 = "transmit"
            L10_2 = false
            L8_2(L9_2, L10_2)
            if L2_2 == L4_2 then
              L8_2 = L21_1
              if not L8_2 then
                goto lbl_880
              end
            end
            L8_2 = radioSystemAccess
            if true == L8_2 then
              L8_2 = RadioState
              L8_2 = L8_2.power
              if L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.earbudsEnabled
                if not L8_2 then
                  L8_2 = nil
                  L9_2 = playerOwnedVehicle
                  if L9_2 then
                    L9_2 = DoesEntityExist
                    L10_2 = playerOwnedVehicle
                    L9_2 = L9_2(L10_2)
                    if L9_2 then
                      L9_2 = VehToNet
                      L10_2 = playerOwnedVehicle
                      L9_2 = L9_2(L10_2)
                      L8_2 = L9_2
                    end
                  end
                  L9_2 = TriggerServerEvent
                  L10_2 = "radio:3DVoiceStopped"
                  L11_2 = L3_2
                  L12_2 = RadioState
                  L12_2 = L12_2.volume
                  if not L12_2 then
                    L12_2 = 50
                  end
                  L13_2 = L8_2
                  L9_2(L10_2, L11_2, L12_2, L13_2)
                  L19_1.voice = nil
                end
              end
            end
            ::lbl_880::
            L8_2 = L13_1
            L8_2 = L8_2[L2_2]
            if L8_2 then
              L8_2 = log
              L9_2 = "Stopping background siren for player "
              L10_2 = L2_2
              L9_2 = L9_2 .. L10_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = SendNUIMessage
              L9_2 = {}
              L9_2.action = "stopSiren"
              L9_2.serverId = L2_2
              L8_2(L9_2)
              L8_2 = L13_1
              L8_2[L2_2] = nil
              L8_2 = radioSystemAccess
              if true == L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.power
                if L8_2 then
                  L8_2 = RadioState
                  L8_2 = L8_2.earbudsEnabled
                  if not L8_2 then
                    L8_2 = nil
                    L9_2 = playerOwnedVehicle
                    if L9_2 then
                      L9_2 = DoesEntityExist
                      L10_2 = playerOwnedVehicle
                      L9_2 = L9_2(L10_2)
                      if L9_2 then
                        L9_2 = VehToNet
                        L10_2 = playerOwnedVehicle
                        L9_2 = L9_2(L10_2)
                        L8_2 = L9_2
                      end
                    end
                    L9_2 = TriggerServerEvent
                    L10_2 = "radio:3DSirenStopped"
                    L11_2 = L8_2
                    L9_2(L10_2, L11_2)
                    L19_1.siren = nil
                  end
                end
              end
            end
            L8_2 = L16_1
            L8_2 = L8_2[L2_2]
            if L8_2 then
              L8_2 = log
              L9_2 = "Stopping background helicopter for player "
              L10_2 = L2_2
              L9_2 = L9_2 .. L10_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = SendNUIMessage
              L9_2 = {}
              L9_2.action = "stopHeli"
              L9_2.serverId = L2_2
              L8_2(L9_2)
              L8_2 = L16_1
              L8_2[L2_2] = nil
              L8_2 = radioSystemAccess
              if true == L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.power
                if L8_2 then
                  L8_2 = RadioState
                  L8_2 = L8_2.earbudsEnabled
                  if not L8_2 then
                    L8_2 = nil
                    L9_2 = playerOwnedVehicle
                    if L9_2 then
                      L9_2 = DoesEntityExist
                      L10_2 = playerOwnedVehicle
                      L9_2 = L9_2(L10_2)
                      if L9_2 then
                        L9_2 = VehToNet
                        L10_2 = playerOwnedVehicle
                        L9_2 = L9_2(L10_2)
                        L8_2 = L9_2
                      end
                    end
                    L9_2 = TriggerServerEvent
                    L10_2 = "radio:3DHeliStopped"
                    L11_2 = L8_2
                    L9_2(L10_2, L11_2)
                    L19_1.heli = nil
                  end
                end
              end
            end
            if L2_2 ~= L4_2 then
              L8_2 = RadioState
              L8_2 = L8_2.txToneActive
              if L8_2 then
                L8_2 = Radio
                L8_2 = L8_2.playTone
                L9_2 = "TX_END"
                L8_2(L9_2)
              end
              L8_2 = RadioState
              L8_2.txToneActive = false
              L8_2 = log
              L9_2 = "Checking transmission stop effects - analogTransmissionEffects: "
              L10_2 = tostring
              L11_2 = Config
              L11_2 = L11_2.analogTransmissionEffects
              L10_2 = L10_2(L11_2)
              L9_2 = L9_2 .. L10_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = Config
              L8_2 = L8_2.analogTransmissionEffects
              if L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.earbudsEnabled
                if not L8_2 then
                  L8_2 = log
                  L9_2 = "Stopping analog transmission effects"
                  L10_2 = 4
                  L8_2(L9_2, L10_2)
                  L8_2 = SendNUIMessage
                  L9_2 = {}
                  L9_2.action = "stopTransmission"
                  L8_2(L9_2)
                  L8_2 = nil
                  L9_2 = playerOwnedVehicle
                  if L9_2 then
                    L9_2 = DoesEntityExist
                    L10_2 = playerOwnedVehicle
                    L9_2 = L9_2(L10_2)
                    if L9_2 then
                      L9_2 = VehToNet
                      L10_2 = playerOwnedVehicle
                      L9_2 = L9_2(L10_2)
                      L8_2 = L9_2
                    end
                  end
                  L9_2 = log
                  L10_2 = "Triggering 3D transmission stop - vehicle: "
                  L11_2 = tostring
                  L12_2 = L8_2
                  L11_2 = L11_2(L12_2)
                  L12_2 = " (type: "
                  L13_2 = type
                  L14_2 = L8_2
                  L13_2 = L13_2(L14_2)
                  L14_2 = ")"
                  L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
                  L11_2 = 4
                  L9_2(L10_2, L11_2)
                  L9_2 = TriggerServerEvent
                  L10_2 = "radio:3DTransmissionStopped"
                  L11_2 = L8_2
                  L9_2(L10_2, L11_2)
                  L9_2 = log
                  L10_2 = "Sent radio:3DTransmissionStopped event to server"
                  L11_2 = 4
                  L9_2(L10_2, L11_2)
              end
              else
                L8_2 = log
                L9_2 = "Analog transmission effects disabled for stop or earbuds enabled"
                L10_2 = 3
                L8_2(L9_2, L10_2)
              end
            end
            L8_2 = RadioState
            L8_2 = L8_2.tempScannedChannels
            if L8_2 then
              L8_2 = RadioState
              L8_2 = L8_2.pausedScanForConnectedTransmission
              if L8_2 then
                L8_2 = SendNUIMessage
                L9_2 = {}
                L9_2.action = "stopAll3DAudio"
                L8_2(L9_2)
                L8_2 = ipairs
                L9_2 = RadioState
                L9_2 = L9_2.tempScannedChannels
                L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
                for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
                  L14_2 = Config
                  L14_2 = L14_2.zones
                  L15_2 = L13_2.zoneId
                  L14_2 = L14_2[L15_2]
                  if L14_2 then
                    L14_2 = Config
                    L14_2 = L14_2.zones
                    L15_2 = L13_2.zoneId
                    L14_2 = L14_2[L15_2]
                    L14_2 = L14_2.Channels
                    L15_2 = L13_2.channelId
                    L14_2 = L14_2[L15_2]
                  end
                  if L14_2 then
                    L15_2 = false
                    L16_2 = RadioState
                    L16_2 = L16_2.connected
                    if L16_2 then
                      L16_2 = RadioState
                      L16_2 = L16_2.isChannelTrunked
                      if L16_2 then
                        L16_2 = L40_1
                        L16_2 = L16_2()
                        if L16_2 then
                          L17_2 = L13_2.zoneId
                          L18_2 = RadioState
                          L18_2 = L18_2.connectedChannel
                          L18_2 = L18_2.zoneId
                          if L17_2 == L18_2 then
                            L17_2 = L13_2.channelId
                            L18_2 = RadioState
                            L18_2 = L18_2.connectedChannel
                            L18_2 = L18_2.channelId
                            if L17_2 == L18_2 then
                              L15_2 = true
                            end
                          end
                        end
                      end
                    end
                    if not L15_2 then
                      L16_2 = Radio
                      L16_2 = L16_2.addListeningChannel
                      L17_2 = convertFreq
                      L18_2 = L14_2.frequency
                      L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L17_2(L18_2)
                      L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
                    end
                    L16_2 = L14_2.type
                    if "trunked" == L16_2 then
                      L16_2 = RadioState
                      L16_2 = L16_2.scannedTrunkedFreqs
                      if L16_2 then
                        L16_2 = RadioState
                        L16_2 = L16_2.scannedTrunkedFreqs
                        L17_2 = L13_2.channelId
                        L16_2 = L16_2[L17_2]
                        if L16_2 and not L15_2 then
                          L16_2 = Radio
                          L16_2 = L16_2.addListeningChannel
                          L17_2 = convertFreq
                          L18_2 = RadioState
                          L18_2 = L18_2.scannedTrunkedFreqs
                          L19_2 = L13_2.channelId
                          L18_2 = L18_2[L19_2]
                          L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L17_2(L18_2)
                          L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
                      end
                    end
                    else
                      L16_2 = L14_2.type
                      if "trunked" == L16_2 and not L15_2 then
                        L16_2 = GetEntityCoords
                        L17_2 = PlayerPedId
                        L17_2, L18_2, L19_2, L20_2, L21_2, L22_2 = L17_2()
                        L16_2 = L16_2(L17_2, L18_2, L19_2, L20_2, L21_2, L22_2)
                        L17_2 = TriggerServerEvent
                        L18_2 = "radio:requestTrunkedScanFrequency"
                        L19_2 = L14_2
                        L20_2 = L16_2
                        L21_2 = L13_2.channelId
                        L17_2(L18_2, L19_2, L20_2, L21_2)
                      end
                    end
                  end
                end
                L8_2 = RadioState
                L8_2.tempScannedChannels = nil
                L8_2 = RadioState
                L8_2.pausedScanForConnectedTransmission = false
              end
            end
            L8_2 = L42_1
            L8_2()
            if L2_2 ~= L4_2 then
              L8_2 = RadioState
              L8_2 = L8_2.txToneActive
              if L8_2 then
                L8_2 = Radio
                L8_2 = L8_2.playTone
                L9_2 = "TX_END"
                L8_2(L9_2)
              end
              L8_2 = RadioState
              L8_2.txToneActive = false
              L8_2 = log
              L9_2 = "Checking transmission stop effects for receiving - analogTransmissionEffects: "
              L10_2 = tostring
              L11_2 = Config
              L11_2 = L11_2.analogTransmissionEffects
              L10_2 = L10_2(L11_2)
              L9_2 = L9_2 .. L10_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = Config
              L8_2 = L8_2.analogTransmissionEffects
              if L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.earbudsEnabled
                if not L8_2 then
                  L8_2 = log
                  L9_2 = "Stopping analog transmission effects for receiving transmission"
                  L10_2 = 4
                  L8_2(L9_2, L10_2)
                  L8_2 = SendNUIMessage
                  L9_2 = {}
                  L9_2.action = "stopTransmission"
                  L8_2(L9_2)
                  L8_2 = nil
                  L9_2 = playerOwnedVehicle
                  if L9_2 then
                    L9_2 = DoesEntityExist
                    L10_2 = playerOwnedVehicle
                    L9_2 = L9_2(L10_2)
                    if L9_2 then
                      L9_2 = VehToNet
                      L10_2 = playerOwnedVehicle
                      L9_2 = L9_2(L10_2)
                      L8_2 = L9_2
                    end
                  end
                  L9_2 = log
                  L10_2 = "Triggering 3D transmission stop for receiving - vehicle: "
                  L11_2 = tostring
                  L12_2 = L8_2
                  L11_2 = L11_2(L12_2)
                  L12_2 = " (type: "
                  L13_2 = type
                  L14_2 = L8_2
                  L13_2 = L13_2(L14_2)
                  L14_2 = ")"
                  L10_2 = L10_2 .. L11_2 .. L12_2 .. L13_2 .. L14_2
                  L11_2 = 4
                  L9_2(L10_2, L11_2)
                  L9_2 = TriggerServerEvent
                  L10_2 = "radio:3DTransmissionStopped"
                  L11_2 = L8_2
                  L9_2(L10_2, L11_2)
                  L9_2 = log
                  L10_2 = "Sent radio:3DTransmissionStopped event to server for receiving transmission"
                  L11_2 = 4
                  L9_2(L10_2, L11_2)
              end
              else
                L8_2 = log
                L9_2 = "Analog transmission effects disabled for receiving stop or earbuds enabled"
                L10_2 = 3
                L8_2(L9_2, L10_2)
              end
            end
            L8_2 = L13_1
            L8_2 = L8_2[L2_2]
            if L8_2 then
              L8_2 = log
              L9_2 = "Stopping background siren for interfering player "
              L10_2 = L2_2
              L9_2 = L9_2 .. L10_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = SendNUIMessage
              L9_2 = {}
              L9_2.action = "stopSiren"
              L9_2.serverId = L2_2
              L8_2(L9_2)
              L8_2 = L13_1
              L8_2[L2_2] = nil
            end
            L8_2 = L16_1
            L8_2 = L8_2[L2_2]
            if L8_2 then
              L8_2 = log
              L9_2 = "Stopping background helicopter for interfering player "
              L10_2 = L2_2
              L9_2 = L9_2 .. L10_2
              L10_2 = 4
              L8_2(L9_2, L10_2)
              L8_2 = SendNUIMessage
              L9_2 = {}
              L9_2.action = "stopHeli"
              L9_2.serverId = L2_2
              L8_2(L9_2)
              L8_2 = L16_1
              L8_2[L2_2] = nil
            end
          end
        end
      end
    end
    ::lbl_1268::
  end
  L57_1(L58_1, L59_1)
  L57_1 = _ENV
  L58_1 = "table"
  L57_1 = L57_1[L58_1]
  L58_1 = "deepcopy"
  function L59_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L1_2 = type
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = nil
    if "table" == L1_2 then
      L3_2 = {}
      L2_2 = L3_2
      L3_2 = next
      L4_2 = A0_2
      L5_2 = nil
      L6_2 = nil
      for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
        L9_2 = table
        L9_2 = L9_2.deepcopy
        L10_2 = L7_2
        L9_2 = L9_2(L10_2)
        L10_2 = table
        L10_2 = L10_2.deepcopy
        L11_2 = L8_2
        L10_2 = L10_2(L11_2)
        L2_2[L9_2] = L10_2
      end
      L3_2 = setmetatable
      L4_2 = L2_2
      L5_2 = table
      L5_2 = L5_2.deepcopy
      L6_2 = getmetatable
      L7_2 = A0_2
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L6_2(L7_2)
      L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L3_2(L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    else
      L2_2 = A0_2
    end
    return L2_2
  end
  L57_1[L58_1] = L59_1
  L57_1 = exports
  L58_1 = "isConnected"
  function L59_1()
    local L0_2, L1_2
    L0_2 = RadioState
    L0_2 = L0_2.connected
    return L0_2
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "isPowerOn"
  function L59_1()
    local L0_2, L1_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    return L0_2
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "isRadioOpen"
  function L59_1()
    local L0_2, L1_2
    L0_2 = RadioState
    L0_2 = L0_2.open
    return L0_2
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "getRadioState"
  function L59_1()
    local L0_2, L1_2
    L0_2 = table
    L0_2 = L0_2.deepcopy
    L1_2 = RadioState
    return L0_2(L1_2)
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "setSignalOnFreq"
  function L59_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L2_2 = Config
    L2_2 = L2_2.alerts
    if L2_2 then
      L2_2 = Config
      L2_2 = L2_2.alerts
      L2_2 = L2_2[1]
    end
    L3_2 = TriggerServerEvent
    L4_2 = "radioServer:setAlertOnChannel"
    L5_2 = A0_2
    L6_2 = A1_2
    L7_2 = L2_2
    L3_2(L4_2, L5_2, L6_2, L7_2)
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "panicButton"
  function L59_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = TriggerServerEvent
    L3_2 = "radioServer:setPanicOnChannel"
    L4_2 = A0_2
    L5_2 = A1_2
    L2_2(L3_2, L4_2, L5_2)
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "getFrequency"
  function L59_1()
    local L0_2, L1_2
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if L0_2 then
      L0_2 = L39_1
      L0_2 = L0_2()
      if L0_2 then
        goto lbl_10
      end
    end
    L0_2 = nil
    ::lbl_10::
    if L0_2 then
      L1_2 = L0_2.frequency
      if L1_2 then
        goto lbl_16
      end
    end
    L1_2 = -1
    ::lbl_16::
    return L1_2
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "getChannel"
  function L59_1()
    local L0_2, L1_2
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if L0_2 then
      L0_2 = L39_1
      L0_2 = L0_2()
      if L0_2 then
        goto lbl_11
      end
    end
    L0_2 = {}
    ::lbl_11::
    return L0_2
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "getZone"
  function L59_1()
    local L0_2, L1_2
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if L0_2 then
      L0_2 = Config
      L0_2 = L0_2.zones
      L1_2 = RadioState
      L1_2 = L1_2.connectedChannel
      L1_2 = L1_2.zoneId
      L0_2 = L0_2[L1_2]
      L0_2 = L0_2.name
      return L0_2
    else
      L0_2 = Config
      L0_2 = L0_2.zones
      L1_2 = RadioState
      L1_2 = L1_2.selectedZone
      L0_2 = L0_2[L1_2]
      L0_2 = L0_2.name
      return L0_2
    end
  end
  L57_1(L58_1, L59_1)
  L57_1 = exports
  L58_1 = "getConnectionDiagnostics"
  function L59_1()
    local L0_2, L1_2, L2_2
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "getConnectionDiagnostics"
    L0_2(L1_2)
    L0_2 = {}
    L1_2 = os
    L1_2 = L1_2.date
    L2_2 = "%Y-%m-%dT%H:%M:%SZ"
    L1_2 = L1_2(L2_2)
    L0_2.timestamp = L1_2
    L1_2 = {}
    L2_2 = RadioState
    L2_2 = L2_2.power
    L1_2.power = L2_2
    L2_2 = RadioState
    L2_2 = L2_2.connected
    L1_2.connected = L2_2
    L2_2 = RadioState
    L2_2 = L2_2.open
    L1_2.open = L2_2
    L2_2 = RadioState
    L2_2 = L2_2.emergency
    L1_2.emergency = L2_2
    L2_2 = RadioState
    L2_2 = L2_2.connected
    if L2_2 then
      L2_2 = L39_1
      L2_2 = L2_2()
      if L2_2 then
        L2_2 = L39_1
        L2_2 = L2_2()
        L2_2 = L2_2.frequency
        if L2_2 then
          goto lbl_41
        end
      end
    end
    L2_2 = nil
    ::lbl_41::
    L1_2.currentFrequency = L2_2
    L2_2 = RadioState
    L2_2 = L2_2.connected
    if L2_2 then
      L2_2 = L39_1
      L2_2 = L2_2()
      if L2_2 then
        goto lbl_51
      end
    end
    L2_2 = nil
    ::lbl_51::
    L1_2.currentChannel = L2_2
    L2_2 = RadioState
    L2_2 = L2_2.selectedZone
    L1_2.selectedZone = L2_2
    L0_2.radioState = L1_2
    L1_2 = {}
    L2_2 = Config
    L2_2 = L2_2.connectionAddr
    L2_2 = nil ~= L2_2
    L1_2.hasConnectionAddr = L2_2
    L2_2 = Config
    L2_2 = L2_2.serverPort
    L2_2 = nil ~= L2_2
    L1_2.hasServerPort = L2_2
    L2_2 = Config
    L2_2 = L2_2.authToken
    L2_2 = nil ~= L2_2
    L1_2.hasAuthToken = L2_2
    L2_2 = Config
    L2_2 = L2_2.logLevel
    L1_2.logLevel = L2_2
    L0_2.config = L1_2
    return L0_2
  end
  L57_1(L58_1, L59_1)
  L57_1 = _ENV
  L58_1 = "RegisterCommand"
  L57_1 = L57_1[L58_1]
  L58_1 = "radiodiag"
  function L59_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2
    L3_2 = radioSystemAccess
    if not L3_2 then
      L3_2 = log
      L4_2 = "Radio diagnostic command requires radio access"
      L5_2 = 2
      L3_2(L4_2, L5_2)
      return
    end
    L3_2 = log
    L4_2 = "=== RADIO CONNECTION DIAGNOSTICS ==="
    L5_2 = 1
    L3_2(L4_2, L5_2)
    L3_2 = exports
    L3_2 = L3_2.radio
    L4_2 = L3_2
    L3_2 = L3_2.getConnectionDiagnostics
    L3_2 = L3_2(L4_2)
    L4_2 = log
    L5_2 = "Timestamp: "
    L6_2 = tostring
    L7_2 = L3_2.timestamp
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "Radio State:"
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Power: "
    L6_2 = tostring
    L7_2 = L3_2.radioState
    L7_2 = L7_2.power
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Connected: "
    L6_2 = tostring
    L7_2 = L3_2.radioState
    L7_2 = L7_2.connected
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Open: "
    L6_2 = tostring
    L7_2 = L3_2.radioState
    L7_2 = L7_2.open
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Emergency: "
    L6_2 = tostring
    L7_2 = L3_2.radioState
    L7_2 = L7_2.emergency
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Current Frequency: "
    L6_2 = tostring
    L7_2 = L3_2.radioState
    L7_2 = L7_2.currentFrequency
    if not L7_2 then
      L7_2 = "None"
    end
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Selected Zone: "
    L6_2 = tostring
    L7_2 = L3_2.radioState
    L7_2 = L7_2.selectedZone
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "Configuration:"
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Has Connection Address: "
    L6_2 = tostring
    L7_2 = L3_2.config
    L7_2 = L7_2.hasConnectionAddr
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Has Server Port: "
    L6_2 = tostring
    L7_2 = L3_2.config
    L7_2 = L7_2.hasServerPort
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Has Auth Token: "
    L6_2 = tostring
    L7_2 = L3_2.config
    L7_2 = L7_2.hasAuthToken
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Log Level: "
    L6_2 = tostring
    L7_2 = L3_2.config
    L7_2 = L7_2.logLevel
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "Connection Details:"
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Address: [REDACTED]"
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Port: [REDACTED]"
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "  Resource: "
    L6_2 = tostring
    L7_2 = GetCurrentResourceName
    L7_2 = L7_2()
    L6_2 = L6_2(L7_2)
    L5_2 = L5_2 .. L6_2
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "Note: Detailed NUI diagnostics sent to browser console (F12)"
    L6_2 = 1
    L4_2(L5_2, L6_2)
    L4_2 = log
    L5_2 = "=== END RADIO DIAGNOSTICS ==="
    L6_2 = 1
    L4_2(L5_2, L6_2)
  end
  L60_1 = false
  L57_1(L58_1, L59_1, L60_1)
  L57_1 = RegisterNetEvent
  L58_1 = "radioClient:btnPress"
  L57_1(L58_1)
  L57_1 = AddEventHandler
  L58_1 = "radioClient:btnPress"
  function L59_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    L1_2 = RadioState
    L1_2 = L1_2.power
    if L1_2 or "power" == A0_2 or "close" == A0_2 then
      L1_2 = RadioState
      L1_2 = L1_2.moveMode
      if not L1_2 then
        goto lbl_14
      end
    end
    do return end
    ::lbl_14::
    if "power" == A0_2 then
      L1_2 = Radio
      L1_2 = L1_2.playTone
      L2_2 = "beep"
      L1_2(L2_2)
      L1_2 = RadioState
      L1_2 = L1_2.power
      if L1_2 then
        L1_2 = L53_1
        L1_2()
      else
        L1_2 = L54_1
        L1_2()
      end
    else
      L1_2 = RadioState
      L1_2 = L1_2.power
      if L1_2 then
        L1_2 = Radio
        L1_2 = L1_2.playTone
        L2_2 = "beep"
        L1_2(L2_2)
      end
    end
    if "home" == A0_2 then
      L1_2 = L43_1
      L2_2 = "main"
      L1_2(L2_2)
    elseif "chUp" == A0_2 then
      L1_2 = RadioState
      L1_2 = L1_2.power
      if L1_2 then
        L1_2 = RadioState
        L1_2 = L1_2.connected
        if L1_2 then
          L1_2 = Config
          L1_2 = L1_2.zones
          L2_2 = RadioState
          L2_2 = L2_2.selectedZone
          L1_2 = L1_2[L2_2]
          L2_2 = L50_1
          L3_2 = RadioState
          L3_2 = L3_2.selectedZone
          L2_2 = L2_2(L3_2)
          L3_2 = {}
          L4_2 = pairs
          L5_2 = L2_2
          L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
          for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
            L10_2 = table
            L10_2 = L10_2.insert
            L11_2 = L3_2
            L12_2 = L8_2
            L10_2(L11_2, L12_2)
          end
          L4_2 = table
          L4_2 = L4_2.sort
          L5_2 = L3_2
          L4_2(L5_2)
          L4_2 = 1
          L5_2 = ipairs
          L6_2 = L3_2
          L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
          for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
            L11_2 = RadioState
            L11_2 = L11_2.connectedChannel
            L11_2 = L11_2.channelId
            if L10_2 == L11_2 then
              L4_2 = L9_2
              break
            end
          end
          L5_2 = L4_2 + 1
          L6_2 = #L3_2
          if L5_2 > L6_2 then
            L5_2 = 1
          end
          L6_2 = L3_2[L5_2]
          L7_2 = L1_2.Channels
          L7_2 = L7_2[L6_2]
          L8_2 = L34_1.currentPage
          if "channels" == L8_2 then
            L8_2 = L41_1.channels
            L8_2 = L8_2.state
            L8_2.tempChannel = L6_2
          end
          L8_2 = RadioState
          L8_2 = L8_2.connected
          if L8_2 then
            L8_2 = L52_1
            L9_2 = L7_2.frequency
            L8_2(L9_2)
          end
          L8_2 = L42_1
          L8_2()
        else
          L1_2 = TriggerEvent
          L2_2 = "radioClient:btnPress"
          L3_2 = "btnRight"
          L1_2(L2_2, L3_2)
        end
      end
    elseif "chDwn" == A0_2 then
      L1_2 = RadioState
      L1_2 = L1_2.power
      if L1_2 then
        L1_2 = RadioState
        L1_2 = L1_2.connected
        if L1_2 then
          L1_2 = Config
          L1_2 = L1_2.zones
          L2_2 = RadioState
          L2_2 = L2_2.selectedZone
          L1_2 = L1_2[L2_2]
          L2_2 = L50_1
          L3_2 = RadioState
          L3_2 = L3_2.selectedZone
          L2_2 = L2_2(L3_2)
          L3_2 = {}
          L4_2 = pairs
          L5_2 = L2_2
          L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
          for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
            L10_2 = table
            L10_2 = L10_2.insert
            L11_2 = L3_2
            L12_2 = L8_2
            L10_2(L11_2, L12_2)
          end
          L4_2 = table
          L4_2 = L4_2.sort
          L5_2 = L3_2
          L4_2(L5_2)
          L4_2 = 1
          L5_2 = ipairs
          L6_2 = L3_2
          L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
          for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
            L11_2 = RadioState
            L11_2 = L11_2.connectedChannel
            L11_2 = L11_2.channelId
            if L10_2 == L11_2 then
              L4_2 = L9_2
              break
            end
          end
          L5_2 = L4_2 - 1
          if L5_2 < 1 then
            L5_2 = #L3_2
          end
          L6_2 = L3_2[L5_2]
          L7_2 = L1_2.Channels
          L7_2 = L7_2[L6_2]
          L8_2 = L34_1.currentPage
          if "channels" == L8_2 then
            L8_2 = L41_1.channels
            L8_2 = L8_2.state
            L8_2.tempChannel = L6_2
          end
          L8_2 = RadioState
          L8_2 = L8_2.connected
          if L8_2 then
            L8_2 = L52_1
            L9_2 = L7_2.frequency
            L8_2(L9_2)
          end
          L8_2 = L42_1
          L8_2()
        else
          L1_2 = TriggerEvent
          L2_2 = "radioClient:btnPress"
          L3_2 = "btnLeft"
          L1_2(L2_2, L3_2)
        end
      end
    elseif "emergency" == A0_2 then
      L1_2 = RadioState
      L1_2 = L1_2.power
      if L1_2 then
        L1_2 = RadioState
        L1_2 = L1_2.connected
        if L1_2 then
          L1_2 = Config
          L1_2 = L1_2.zones
          L2_2 = RadioState
          L2_2 = L2_2.connectedChannel
          L2_2 = L2_2.zoneId
          L1_2 = L1_2[L2_2]
          L2_2 = L1_2.Channels
          L3_2 = RadioState
          L3_2 = L3_2.connectedChannel
          L3_2 = L3_2.channelId
          L2_2 = L2_2[L3_2]
          L3_2 = L2_2.type
          if "trunked" ~= L3_2 then
            L3_2 = RadioState
            L4_2 = RadioState
            L4_2 = L4_2.panicButton
            L4_2 = not L4_2
            L3_2.panicButton = L4_2
            L3_2 = TriggerServerEvent
            L4_2 = "radioServer:setPanicOnChannel"
            L5_2 = L2_2.frequency
            L6_2 = RadioState
            L6_2 = L6_2.panicButton
            L3_2(L4_2, L5_2, L6_2)
          else
            L3_2 = showAlert
            L4_2 = "UNABLE"
            L5_2 = "#ba0000"
            L3_2(L4_2, L5_2)
          end
        end
      end
    elseif "close" == A0_2 then
      L1_2 = L55_1
      L1_2()
      L1_2 = RadioState
      L1_2.open = false
    elseif "btnUp" == A0_2 then
      L1_2 = TriggerEvent
      L2_2 = "radioClient:btnPress"
      L3_2 = "btnRight"
      L1_2(L2_2, L3_2)
    elseif "btnDown" == A0_2 then
      L1_2 = TriggerEvent
      L2_2 = "radioClient:btnPress"
      L3_2 = "btnLeft"
      L1_2(L2_2, L3_2)
    else
      L2_2 = L34_1.currentPage
      L1_2 = L41_1
      L1_2 = L1_2[L2_2]
      if L1_2 then
        L2_2 = L1_2.buttons
        if L2_2 then
          L2_2 = L1_2.buttons
          L2_2 = L2_2[A0_2]
          if L2_2 then
            L2_2 = L1_2.buttons
            L2_2 = L2_2[A0_2]
            L2_2 = L2_2.action
            L3_2 = L1_2
            L2_2(L3_2)
          end
        end
      end
    end
  end
  L57_1(L58_1, L59_1)
  L57_1 = RegisterNetEvent
  L58_1 = "radio:forceChannelChange"
  L57_1(L58_1)
  L57_1 = AddEventHandler
  L58_1 = "radio:forceChannelChange"
  function L59_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2
    if not A0_2 then
      return
    end
    L1_2 = nil
    L2_2 = nil
    L3_2 = nil
    L4_2 = ipairs
    L5_2 = Config
    L5_2 = L5_2.zones
    L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
    for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
      L10_2 = ipairs
      L11_2 = L9_2.Channels
      L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
      for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
        L16_2 = convertFreq
        L17_2 = L15_2.frequency
        L16_2 = L16_2(L17_2)
        L17_2 = convertFreq
        L18_2 = A0_2
        L17_2 = L17_2(L18_2)
        if L16_2 == L17_2 then
          L1_2 = L8_2
          L2_2 = L14_2
          L3_2 = L15_2
          break
        end
      end
      if L1_2 then
        break
      end
    end
    if L1_2 and L2_2 then
      L4_2 = RadioState
      L4_2.selectedZone = L1_2
      L4_2 = L3_2.type
      if "trunked" == L4_2 then
        L4_2 = Radio
        L4_2 = L4_2.getChannel
        if L4_2 then
          L4_2 = Radio
          L4_2 = L4_2.getChannel
          L4_2 = L4_2()
          if L4_2 then
            goto lbl_53
          end
        end
        L4_2 = 0
        ::lbl_53::
        if L4_2 > 0 then
          L5_2 = convertFreq
          L6_2 = A0_2
          L5_2 = L5_2(L6_2)
          if L4_2 ~= L5_2 then
            L5_2 = RadioState
            L6_2 = {}
            L6_2.zoneId = L1_2
            L6_2.channelId = L2_2
            L6_2.frequency = A0_2
            L5_2.connectedChannel = L6_2
            L5_2 = RadioState
            L5_2.isChannelTrunked = true
            L5_2 = RadioState
            L5_2.connected = true
            L5_2 = setLED
            L6_2 = "connected"
            L7_2 = true
            L5_2(L6_2, L7_2)
            L5_2 = setTrunk
            L6_2 = true
            L5_2(L6_2)
            L5_2 = false
            L6_2 = ipairs
            L7_2 = RadioState
            L7_2 = L7_2.scannedChannels
            L6_2, L7_2, L8_2, L9_2 = L6_2(L7_2)
            for L10_2, L11_2 in L6_2, L7_2, L8_2, L9_2 do
              L12_2 = L11_2.zoneId
              if L12_2 == L1_2 then
                L12_2 = L11_2.channelId
                if L12_2 == L2_2 then
                  L5_2 = true
                  break
                end
              end
            end
            if not L5_2 then
              L6_2 = Radio
              L6_2 = L6_2.addListeningChannel
              L7_2 = convertFreq
              L8_2 = L3_2.frequency
              L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2 = L7_2(L8_2)
              L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2)
              L6_2 = table
              L6_2 = L6_2.insert
              L7_2 = RadioState
              L7_2 = L7_2.scannedChannels
              L8_2 = {}
              L8_2.zoneId = L1_2
              L8_2.channelId = L2_2
              L9_2 = L3_2.frequency
              L8_2.frequency = L9_2
              L6_2(L7_2, L8_2)
            end
            L6_2 = RadioState
            L6_2 = L6_2.scannedTrunkedFreqs
            if not L6_2 then
              L6_2 = RadioState
              L7_2 = {}
              L6_2.scannedTrunkedFreqs = L7_2
            end
            L6_2 = setScan
            L7_2 = RadioState
            L7_2 = L7_2.scannedChannels
            L7_2 = #L7_2
            L7_2 = L7_2 > 0
            L6_2(L7_2)
            L6_2 = showAlert
            L7_2 = "TRUNKED"
            L8_2 = "#126300"
            L6_2(L7_2, L8_2)
            L6_2 = L42_1
            L6_2()
            L6_2 = log
            L7_2 = "Export: Already on trunked frequency, updated UI state and added control frequency scanning for "
            L8_2 = A0_2
            L7_2 = L7_2 .. L8_2
            L8_2 = 3
            L6_2(L7_2, L8_2)
            return
          end
        end
      end
      L4_2 = L52_1
      L5_2 = A0_2
      L4_2(L5_2)
      L4_2 = log
      L5_2 = "Export: Connected to frequency "
      L6_2 = A0_2
      L7_2 = " in zone "
      L8_2 = L1_2
      L9_2 = " via connectToChannel"
      L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2 .. L9_2
      L6_2 = 3
      L4_2(L5_2, L6_2)
    else
      L4_2 = log
      L5_2 = "Export: Could not find zone/channel for frequency "
      L6_2 = A0_2
      L5_2 = L5_2 .. L6_2
      L6_2 = 1
      L4_2(L5_2, L6_2)
    end
  end
  L57_1(L58_1, L59_1)
  L57_1 = RegisterNetEvent
  L58_1 = "radio:forceDisconnect"
  L57_1(L58_1)
  L57_1 = AddEventHandler
  L58_1 = "radio:forceDisconnect"
  function L59_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.connectedChannel
      L0_2 = L0_2.frequency
      if L0_2 then
        L0_2 = TriggerServerEvent
        L1_2 = "radioServer:setPanicOnChannel"
        L2_2 = RadioState
        L2_2 = L2_2.connectedChannel
        L2_2 = L2_2.frequency
        L3_2 = false
        L0_2(L1_2, L2_2, L3_2)
      end
      L0_2 = TriggerEvent
      L1_2 = "radio:stopAllSirens"
      L0_2(L1_2)
      L0_2 = Radio
      L0_2 = L0_2.setChannel
      L1_2 = 0
      L0_2(L1_2)
      L0_2 = RadioState
      L0_2.connected = false
      L0_2 = RadioState
      L0_2.isChannelTrunked = false
      L0_2 = RadioState
      L1_2 = {}
      L1_2.zoneId = nil
      L1_2.channelId = nil
      L1_2.frequency = nil
      L0_2.connectedChannel = L1_2
      L0_2 = RadioState
      L0_2.panicButton = false
      L0_2 = ipairs
      L1_2 = RadioState
      L1_2 = L1_2.scannedChannels
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        L6_2 = Radio
        L6_2 = L6_2.removeListeningChannel
        L7_2 = convertFreq
        L8_2 = L5_2.frequency
        L7_2, L8_2 = L7_2(L8_2)
        L6_2(L7_2, L8_2)
      end
      L0_2 = RadioState
      L1_2 = {}
      L0_2.scannedChannels = L1_2
      L0_2 = setWarn
      L1_2 = false
      L0_2(L1_2)
      L0_2 = setScan
      L1_2 = false
      L0_2(L1_2)
      L0_2 = L42_1
      L0_2()
      L0_2 = log
      L1_2 = "Export: Properly disconnected via existing logic"
      L2_2 = 3
      L0_2(L1_2, L2_2)
    end
  end
  L57_1(L58_1, L59_1)
  L57_1 = AddEventHandler
  L58_1 = "playerDropped"
  function L59_1()
    local L0_2, L1_2
    L0_2 = source
  end
  L57_1(L58_1, L59_1)
  L57_1 = RegisterNetEvent
  L58_1 = "radioClient:showAlert"
  L57_1(L58_1)
  L57_1 = AddEventHandler
  L58_1 = "radioClient:showAlert"
  function L59_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2
    L3_2 = showAlert
    L4_2 = A0_2
    L5_2 = A1_2
    L3_2(L4_2, L5_2)
    L3_2 = setWarn
    L4_2 = A2_2
    L3_2(L4_2)
  end
  L57_1(L58_1, L59_1)
  L57_1 = RegisterNetEvent
  L58_1 = "radioClient:playTone"
  L57_1(L58_1)
  L57_1 = AddEventHandler
  L58_1 = "radioClient:playTone"
  function L59_1(A0_2)
    local L1_2, L2_2
    L1_2 = Radio
    L1_2 = L1_2.playTone
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L57_1(L58_1, L59_1)
  L57_1 = {}
  L58_1 = RegisterNetEvent
  L59_1 = "radioClient:blockAudio"
  L58_1(L59_1)
  L58_1 = AddEventHandler
  L59_1 = "radioClient:blockAudio"
  function L60_1(A0_2, A1_2)
    local L2_2, L3_2
    if A1_2 then
      L2_2 = L57_1
      L2_2[A0_2] = true
      L2_2 = SendNUIMessage
      L3_2 = {}
      L3_2.action = "blockUser"
      L3_2.serverId = A0_2
      L3_2.block = true
      L2_2(L3_2)
    else
      L2_2 = L57_1
      L2_2[A0_2] = nil
      L2_2 = SendNUIMessage
      L3_2 = {}
      L3_2.action = "blockUser"
      L3_2.serverId = A0_2
      L3_2.block = false
      L2_2(L3_2)
    end
  end
  L58_1(L59_1, L60_1)
  L58_1 = RegisterNetEvent
  L59_1 = "radioClient:setAlertOnChannel"
  L58_1(L59_1)
  L58_1 = AddEventHandler
  L59_1 = "radioClient:setAlertOnChannel"
  function L60_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2
    L3_2 = convertFreq
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    if A1_2 and A2_2 then
      L4_2 = activeAlerts
      L4_2[L3_2] = A2_2
    else
      L4_2 = activeAlerts
      L4_2[L3_2] = nil
    end
    L4_2 = convertFreq
    L5_2 = Radio
    L5_2 = L5_2.getChannel
    L5_2 = L5_2()
    if not L5_2 then
      L5_2 = 0
    end
    L4_2 = L4_2(L5_2)
    if L3_2 == L4_2 then
      L5_2 = L42_1
      L5_2()
    end
  end
  L58_1(L59_1, L60_1)
  L58_1 = RegisterNetEvent
  L59_1 = "radioClient:setPanicOnChannel"
  L58_1(L59_1)
  L58_1 = AddEventHandler
  L59_1 = "radioClient:setPanicOnChannel"
  function L60_1(A0_2, A1_2, A2_2, A3_2)
    local L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
    L4_2 = convertFreq
    L5_2 = A0_2
    L4_2 = L4_2(L5_2)
    L5_2 = panicButtonChannels
    L5_2[L4_2] = A1_2
    L5_2 = convertFreq
    L6_2 = Radio
    L6_2 = L6_2.getChannel
    L6_2 = L6_2()
    if not L6_2 then
      L6_2 = 0
    end
    L5_2 = L5_2(L6_2)
    L6_2 = GetPlayerServerId
    L7_2 = PlayerId
    L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2 = L7_2()
    L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2)
    if A3_2 and A2_2 and L5_2 == L4_2 then
      L7_2 = showAlert
      L8_2 = "PANIC "
      L9_2 = getPlayerName
      L10_2 = A2_2
      L9_2 = L9_2(L10_2)
      L8_2 = L8_2 .. L9_2
      L9_2 = "#ba0000"
      L7_2(L8_2, L9_2)
      L7_2 = Radio
      L7_2 = L7_2.playTone
      L8_2 = "panic"
      L7_2(L8_2)
      L7_2 = setWarn
      L8_2 = true
      L7_2(L8_2)
    end
    if A2_2 == L6_2 then
      L7_2 = RadioState
      L7_2.panicButton = A3_2
    end
    L7_2 = convertFreq
    L8_2 = A0_2
    L7_2 = L7_2(L8_2)
    if L5_2 == L7_2 then
      L7_2 = 0
      if A1_2 then
        L8_2 = pairs
        L9_2 = A1_2
        L8_2, L9_2, L10_2, L11_2 = L8_2(L9_2)
        for L12_2, L13_2 in L8_2, L9_2, L10_2, L11_2 do
          if nil ~= L13_2 then
            L7_2 = L7_2 + 1
          end
        end
      end
      if L7_2 <= 0 then
        L8_2 = setWarn
        L9_2 = false
        L8_2(L9_2)
        L8_2 = RadioState
        L8_2 = L8_2.panicButton
        if L8_2 then
          L8_2 = RadioState
          L8_2.panicButton = false
        end
      else
        L8_2 = setWarn
        L9_2 = true
        L8_2(L9_2)
      end
    end
  end
  L58_1(L59_1, L60_1)
  L58_1 = _ENV
  L59_1 = "open"
  L60_1 = false
  L58_1[L59_1] = L60_1
  L58_1 = _ENV
  L59_1 = "focused"
  L60_1 = false
  L58_1[L59_1] = L60_1
  function L58_1()
    local L0_2, L1_2, L2_2
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "focus"
    L0_2(L1_2)
    L0_2 = SetNuiFocus
    L1_2 = true
    L2_2 = true
    L0_2(L1_2, L2_2)
    focused = true
    L0_2 = log
    L1_2 = "NUI focus enabled"
    L2_2 = 4
    L0_2(L1_2, L2_2)
    L0_2 = L30_1
    L0_2()
  end
  L59_1 = _ENV
  L60_1 = "setRadioConfig"
  function L61_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setRadioConfig"
    L2_2.model = A0_2
    L1_2(L2_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "setTheme"
  function L61_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = L48_1
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "setTheme"
    L3_2.theme = L1_2
    L2_2(L3_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "setRadioPosition"
  function L61_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setRadioPosition"
    L2_2.pos = A0_2
    L1_2(L2_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "setMoveMode"
  function L61_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = RadioState
    L1_2.moveMode = A0_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setMoveMode"
    L3_2 = RadioState
    L3_2 = L3_2.moveMode
    L2_2.state = L3_2
    L1_2(L2_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "setVolume"
  function L61_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setVolume"
    L2_2.volume = A0_2
    L1_2(L2_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "set3DVolume"
  function L61_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "set3DVolume"
    L2_2.volume = A0_2
    L1_2(L2_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "setToneVolume"
  function L61_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setToneVolume"
    L2_2.volume = A0_2
    L1_2(L2_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "settingsLoaded"
  L61_1 = false
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "openRadio"
  function L61_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = L45_1
    L0_2 = L0_2()
    L1_2 = nil
    L2_2 = nil
    L3_2 = settingsLoaded
    if not L3_2 then
      L3_2 = Settings
      L3_2 = L3_2.loadAll
      L3_2()
      settingsLoaded = true
    end
    L3_2 = L46_1
    L3_2 = L3_2()
    L4_2 = Settings
    L4_2 = L4_2.initializeVehicleModel
    L5_2 = L0_2
    L6_2 = L3_2
    L4_2, L5_2 = L4_2(L5_2, L6_2)
    L2_2 = L5_2
    L1_2 = L4_2
    if L1_2 then
      L4_2 = setRadioConfig
      L5_2 = L1_2
      L4_2(L5_2)
    end
    if L2_2 then
      L4_2 = setRadioPosition
      L5_2 = L2_2
      L4_2(L5_2)
    end
    L4_2 = RadioState
    L4_2 = L4_2.power
    if L4_2 then
      L4_2 = RadioState
      L4_2 = L4_2.theme
      if not L4_2 then
        L4_2 = "Auto"
      end
      if L4_2 then
        L5_2 = setTheme
        L6_2 = L4_2
        L5_2(L6_2)
      end
    else
      L4_2 = setTheme
      L5_2 = "Dark"
      L4_2(L5_2)
    end
    L4_2 = setVolume
    L5_2 = RadioState
    L5_2 = L5_2.volume
    L4_2(L5_2)
    L4_2 = setToneVolume
    L5_2 = RadioState
    L5_2 = L5_2.toneVolume
    L4_2(L5_2)
    L4_2 = set3DVolume
    L5_2 = RadioState
    L5_2 = L5_2.volume3D
    L4_2(L5_2)
    L4_2 = SendNUIMessage
    L5_2 = {}
    L5_2.action = "open"
    L4_2(L5_2)
    L4_2 = RadioState
    L5_2 = {}
    L4_2.availableMicrophones = L5_2
    L4_2 = SendNUIMessage
    L5_2 = {}
    L5_2.action = "setupMicrophone"
    L4_2(L5_2)
    L4_2 = showAlert
    L5_2 = "Setting up microphone..."
    L4_2(L5_2)
    open = true
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "updateTime"
  function L61_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = GetClockHours
      L0_2 = L0_2()
      L1_2 = GetClockMinutes
      L1_2 = L1_2()
      L2_2 = "AM"
      if L0_2 >= 12 then
        L2_2 = "PM"
        if L0_2 > 12 then
          L0_2 = L0_2 - 12
        end
      elseif 0 == L0_2 then
        L0_2 = 12
      end
      L3_2 = string
      L3_2 = L3_2.format
      L4_2 = "%02d:%02d %s"
      L5_2 = L0_2
      L6_2 = L1_2
      L7_2 = L2_2
      L3_2 = L3_2(L4_2, L5_2, L6_2, L7_2)
      L4_2 = SendNUIMessage
      L5_2 = {}
      L5_2.action = "setTime"
      L5_2.time = L3_2
      L4_2(L5_2)
    else
      L0_2 = SendNUIMessage
      L1_2 = {}
      L1_2.action = "setTime"
      L1_2.time = ""
      L0_2(L1_2)
    end
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "setWarn"
  function L61_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setWarn"
    L2_2.status = A0_2
    L1_2(L2_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "setLED"
  function L61_1(A0_2, A1_2)
    local L2_2, L3_2
    L2_2 = SendNUIMessage
    L3_2 = {}
    L3_2.action = "setLED"
    L3_2.key = A0_2
    L3_2.mode = A1_2
    L2_2(L3_2)
  end
  L59_1[L60_1] = L61_1
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "resetRadio"
  function L61_1()
    local L0_2, L1_2
    L0_2 = L31_1
    L0_2()
    L0_2 = L55_1
    L0_2()
    L0_2 = openRadio
    L0_2()
    L0_2 = setMoveMode
    L1_2 = false
    L0_2(L1_2)
    L0_2 = setRadioPosition
    L1_2 = {}
    L1_2.x = 0
    L1_2.y = 0
    L1_2.s = 0
    L0_2(L1_2)
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "set3DVol"
  function L61_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L2_2 = A1_2[1]
    if not L2_2 then
      L2_2 = TriggerEvent
      L3_2 = "chat:addMessage"
      L4_2 = {}
      L5_2 = {}
      L6_2 = 255
      L7_2 = 255
      L8_2 = 255
      L5_2[1] = L6_2
      L5_2[2] = L7_2
      L5_2[3] = L8_2
      L4_2.color = L5_2
      L4_2.multiline = true
      L5_2 = {}
      L6_2 = "Radio"
      L7_2 = "Usage: /set3DVol [0-100]"
      L5_2[1] = L6_2
      L5_2[2] = L7_2
      L4_2.args = L5_2
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = tonumber
    L3_2 = A1_2[1]
    L2_2 = L2_2(L3_2)
    if not L2_2 or L2_2 < 0 or L2_2 > 100 then
      L3_2 = TriggerEvent
      L4_2 = "chat:addMessage"
      L5_2 = {}
      L6_2 = {}
      L7_2 = 255
      L8_2 = 100
      L9_2 = 100
      L6_2[1] = L7_2
      L6_2[2] = L8_2
      L6_2[3] = L9_2
      L5_2.color = L6_2
      L5_2.multiline = true
      L6_2 = {}
      L7_2 = "Radio"
      L8_2 = "Volume must be between 0 and 100"
      L6_2[1] = L7_2
      L6_2[2] = L8_2
      L5_2.args = L6_2
      L3_2(L4_2, L5_2)
      return
    end
    L3_2 = SendNUIMessage
    L4_2 = {}
    L4_2.action = "set3DVolume"
    L4_2.volume = L2_2
    L3_2(L4_2)
    L3_2 = TriggerEvent
    L4_2 = "chat:addMessage"
    L5_2 = {}
    L6_2 = {}
    L7_2 = 100
    L8_2 = 255
    L9_2 = 100
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L6_2[3] = L9_2
    L5_2.color = L6_2
    L5_2.multiline = true
    L6_2 = {}
    L7_2 = "Radio"
    L8_2 = "3D Audio volume set to "
    L9_2 = L2_2
    L10_2 = "%"
    L8_2 = L8_2 .. L9_2 .. L10_2
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L5_2.args = L6_2
    L3_2(L4_2, L5_2)
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "TriggerEvent"
  L59_1 = L59_1[L60_1]
  L60_1 = "chat:addSuggestion"
  L61_1 = "/set3DVol"
  L62_1 = "Set 3D radio fx audio volume (0-100)"
  L63_1 = {}
  L64_1 = {}
  L65_1 = "name"
  L66_1 = "volume"
  L64_1[L65_1] = L66_1
  L65_1 = "help"
  L66_1 = "Volume level (0-100)"
  L64_1[L65_1] = L66_1
  L63_1[1] = L64_1
  L59_1(L60_1, L61_1, L62_1, L63_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "playtone"
  function L61_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = radioSystemAccess
    if true ~= L2_2 then
      L2_2 = TriggerEvent
      L3_2 = "chat:addMessage"
      L4_2 = {}
      L5_2 = {}
      L6_2 = 255
      L7_2 = 100
      L8_2 = 100
      L5_2[1] = L6_2
      L5_2[2] = L7_2
      L5_2[3] = L8_2
      L4_2.color = L5_2
      L4_2.multiline = true
      L5_2 = {}
      L6_2 = "Radio"
      L7_2 = "You don't have access to the radio system."
      L5_2[1] = L6_2
      L5_2[2] = L7_2
      L4_2.args = L5_2
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = A1_2[1]
    if not L2_2 then
      L2_2 = TriggerEvent
      L3_2 = "chat:addMessage"
      L4_2 = {}
      L5_2 = {}
      L6_2 = 255
      L7_2 = 255
      L8_2 = 255
      L5_2[1] = L6_2
      L5_2[2] = L7_2
      L5_2[3] = L8_2
      L4_2.color = L5_2
      L4_2.multiline = true
      L5_2 = {}
      L6_2 = "Radio"
      L7_2 = "Usage: /playtone [tone_name]"
      L5_2[1] = L6_2
      L5_2[2] = L7_2
      L4_2.args = L5_2
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = string
    L2_2 = L2_2.upper
    L3_2 = A1_2[1]
    L2_2 = L2_2(L3_2)
    L3_2 = Radio
    L3_2 = L3_2.playTone
    L4_2 = L2_2
    L3_2(L4_2)
    L3_2 = TriggerEvent
    L4_2 = "chat:addMessage"
    L5_2 = {}
    L6_2 = {}
    L7_2 = 100
    L8_2 = 255
    L9_2 = 100
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L6_2[3] = L9_2
    L5_2.color = L6_2
    L5_2.multiline = true
    L6_2 = {}
    L7_2 = "Radio"
    L8_2 = "Playing tone: "
    L9_2 = L2_2
    L8_2 = L8_2 .. L9_2
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L5_2.args = L6_2
    L3_2(L4_2, L5_2)
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+toggleRadio"
  function L61_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = radioSystemAccess
    if true ~= L0_2 then
      return
    end
    L0_2 = RadioState
    L0_2 = L0_2.open
    if not L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.selectedAnimation
      if not L0_2 then
        L0_2 = 2
      end
      L1_2 = Config
      L1_2 = L1_2.animations
      L1_2 = L1_2[L0_2]
      if L1_2 then
        L1_2 = Config
        L1_2 = L1_2.animations
        L1_2 = L1_2[L0_2]
        L1_2 = L1_2.onRadioOpen
        if L1_2 then
          L1_2 = pcall
          L2_2 = Config
          L2_2 = L2_2.animations
          L2_2 = L2_2[L0_2]
          L2_2 = L2_2.onRadioOpen
          L1_2, L2_2 = L1_2(L2_2)
          if not L1_2 then
            L3_2 = log
            L4_2 = "Radio animation error (radio open): "
            L5_2 = tostring
            L6_2 = L2_2
            L5_2 = L5_2(L6_2)
            L4_2 = L4_2 .. L5_2
            L5_2 = 1
            L3_2(L4_2, L5_2)
          end
        end
      end
      L1_2 = openRadio
      L1_2()
      L1_2 = L58_1
      L1_2()
      L1_2 = RadioState
      L1_2.open = true
      L1_2 = RadioState
      L1_2.focused = true
    else
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = RadioState
        L0_2 = L0_2.focused
        if not L0_2 then
          L0_2 = L58_1
          L0_2()
          L0_2 = RadioState
          L0_2.focused = true
      end
      else
        L0_2 = RadioState
        L0_2 = L0_2.open
        if L0_2 then
          L0_2 = RadioState
          L0_2 = L0_2.focused
          if L0_2 then
            L0_2 = SetNuiFocus
            L1_2 = true
            L2_2 = true
            L0_2(L1_2, L2_2)
            L0_2 = log
            L1_2 = "Re-ensured NUI focus for already opened radio"
            L2_2 = 4
            L0_2(L1_2, L2_2)
          end
        end
      end
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-toggleRadio"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Citizen"
  L59_1 = L59_1[L60_1]
  L59_1 = L59_1.CreateThread
  function L60_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 100
      L0_2(L1_2)
      L0_2 = GetPlayerServerId
      L1_2 = PlayerId
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      L1_2 = RadioState
      L1_2 = L1_2.activeTalker
      if L1_2 ~= L0_2 then
        L1_2 = RadioState
        L1_2 = L1_2.connectedChannelTalker
        if L1_2 ~= L0_2 then
          L1_2 = RadioState
          L1_2 = L1_2.scannedChannelTalker
          if L1_2 ~= L0_2 then
            L1_2 = Citizen
            L1_2 = L1_2.Wait
            L2_2 = 500
            L1_2(L2_2)
            goto lbl_179
          end
        end
      end
      L1_2 = IsPlayerDead
      L2_2 = PlayerId
      L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
      L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      if not L1_2 then
        L1_2 = IsPedSwimming
        L2_2 = PlayerPedId
        L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
        L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
        if not L1_2 then
          goto lbl_179
        end
      end
      L1_2 = log
      L2_2 = "Player died or started swimming during transmission - forcing stop"
      L3_2 = 4
      L1_2(L2_2, L3_2)
      L1_2 = setLED
      L2_2 = "transmit"
      L3_2 = false
      L1_2(L2_2, L3_2)
      L1_2 = RadioState
      L1_2 = L1_2.activeTalker
      if L1_2 == L0_2 then
        L1_2 = RadioState
        L1_2.activeTalker = nil
        L1_2 = RadioState
        L1_2.activeTransmissionFreq = nil
      end
      L1_2 = RadioState
      L1_2 = L1_2.connectedChannelTalker
      if L1_2 == L0_2 then
        L1_2 = RadioState
        L1_2.connectedChannelTalker = nil
      end
      L1_2 = RadioState
      L1_2 = L1_2.scannedChannelTalker
      if L1_2 == L0_2 then
        L1_2 = RadioState
        L1_2.scannedChannelTalker = nil
      end
      L1_2 = L42_1
      L1_2()
      L1_2 = SendNUIMessage
      L2_2 = {}
      L2_2.action = "setTalking"
      L2_2.talking = false
      L2_2.suppressTone = true
      L1_2(L2_2)
      L1_2 = RadioState
      L1_2 = L1_2.pttReleaseTimer
      if L1_2 then
        L1_2 = Citizen
        L1_2 = L1_2.ClearTimeout
        L2_2 = RadioState
        L2_2 = L2_2.pttReleaseTimer
        L1_2(L2_2)
        L1_2 = RadioState
        L1_2.pttReleaseTimer = nil
      end
      L1_2 = RadioState
      L1_2 = L1_2.tempScannedChannels
      if L1_2 then
        L1_2 = ipairs
        L2_2 = RadioState
        L2_2 = L2_2.tempScannedChannels
        L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
        for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
          L7_2 = Config
          L7_2 = L7_2.zones
          L8_2 = L6_2.zoneId
          L7_2 = L7_2[L8_2]
          if L7_2 then
            L7_2 = Config
            L7_2 = L7_2.zones
            L8_2 = L6_2.zoneId
            L7_2 = L7_2[L8_2]
            L7_2 = L7_2.Channels
            L8_2 = L6_2.channelId
            L7_2 = L7_2[L8_2]
          end
          if L7_2 then
            L8_2 = Radio
            L8_2 = L8_2.addListeningChannel
            L9_2 = convertFreq
            L10_2 = L7_2.frequency
            L9_2, L10_2, L11_2 = L9_2(L10_2)
            L8_2(L9_2, L10_2, L11_2)
            L8_2 = L7_2.type
            if "trunked" == L8_2 then
              L8_2 = RadioState
              L8_2 = L8_2.scannedTrunkedFreqs
              if L8_2 then
                L8_2 = RadioState
                L8_2 = L8_2.scannedTrunkedFreqs
                L9_2 = L6_2.channelId
                L8_2 = L8_2[L9_2]
                if L8_2 then
                  L8_2 = Radio
                  L8_2 = L8_2.addListeningChannel
                  L9_2 = convertFreq
                  L10_2 = RadioState
                  L10_2 = L10_2.scannedTrunkedFreqs
                  L11_2 = L6_2.channelId
                  L10_2 = L10_2[L11_2]
                  L9_2, L10_2, L11_2 = L9_2(L10_2)
                  L8_2(L9_2, L10_2, L11_2)
                end
              end
            end
          end
        end
        L1_2 = RadioState
        L1_2.tempScannedChannels = nil
      end
      L1_2 = TriggerEvent
      L2_2 = "radio:stopAllSirens"
      L1_2(L2_2)
      L1_2 = RadioState
      L1_2 = L1_2.selectedAnimation
      if not L1_2 then
        L1_2 = 2
      end
      L2_2 = Config
      L2_2 = L2_2.animations
      L2_2 = L2_2[L1_2]
      if L2_2 then
        L2_2 = Config
        L2_2 = L2_2.animations
        L2_2 = L2_2[L1_2]
        L2_2 = L2_2.onKeyState
        if L2_2 then
          L2_2 = pcall
          L3_2 = Config
          L3_2 = L3_2.animations
          L3_2 = L3_2[L1_2]
          L3_2 = L3_2.onKeyState
          L4_2 = false
          L2_2, L3_2 = L2_2(L3_2, L4_2)
          if not L2_2 then
            L4_2 = log
            L5_2 = "Radio animation error (forced key up): "
            L6_2 = tostring
            L7_2 = L3_2
            L6_2 = L6_2(L7_2)
            L5_2 = L5_2 .. L6_2
            L6_2 = 1
            L4_2(L5_2, L6_2)
          end
        end
      end
      ::lbl_179::
    end
  end
  L59_1(L60_1)
  L59_1 = _ENV
  L60_1 = "Citizen"
  L59_1 = L59_1[L60_1]
  L59_1 = L59_1.CreateThread
  function L60_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 1000
      L0_2(L1_2)
      L0_2 = PlayerPedId
      L0_2 = L0_2()
      L1_2 = GetVehiclePedIsIn
      L2_2 = L0_2
      L3_2 = false
      L1_2 = L1_2(L2_2, L3_2)
      L2_2 = playerOwnedVehicle
      if L2_2 then
        L2_2 = radioSystemAccess
        if L2_2 then
          L2_2 = RadioState
          L2_2 = L2_2.power
          if L2_2 then
            goto lbl_41
          end
        end
        L2_2 = DoesEntityExist
        L3_2 = playerOwnedVehicle
        L2_2 = L2_2(L3_2)
        if L2_2 then
          L2_2 = TriggerServerEvent
          L3_2 = "radio:releaseVehicle"
          L4_2 = VehToNet
          L5_2 = playerOwnedVehicle
          L4_2, L5_2, L6_2 = L4_2(L5_2)
          L2_2(L3_2, L4_2, L5_2, L6_2)
        end
        L3_2 = L22_1
        L2_2 = L20_1
        L2_2[L3_2] = nil
        playerOwnedVehicle = nil
        L2_2 = log
        L3_2 = "Released vehicle ownership due to radio state change"
        L4_2 = 4
        L2_2(L3_2, L4_2)
        goto lbl_74
        ::lbl_41::
        L2_2 = DoesEntityExist
        L3_2 = playerOwnedVehicle
        L2_2 = L2_2(L3_2)
        if not L2_2 then
          L3_2 = L22_1
          L2_2 = L20_1
          L2_2[L3_2] = nil
          playerOwnedVehicle = nil
          L2_2 = log
          L3_2 = "Released vehicle ownership - vehicle destroyed"
          L4_2 = 4
          L2_2(L3_2, L4_2)
        else
          L2_2 = GetIsVehicleEngineRunning
          L3_2 = playerOwnedVehicle
          L2_2 = L2_2(L3_2)
          if not L2_2 then
            L2_2 = TriggerServerEvent
            L3_2 = "radio:releaseVehicle"
            L4_2 = VehToNet
            L5_2 = playerOwnedVehicle
            L4_2, L5_2, L6_2 = L4_2(L5_2)
            L2_2(L3_2, L4_2, L5_2, L6_2)
            L3_2 = L22_1
            L2_2 = L20_1
            L2_2[L3_2] = nil
            playerOwnedVehicle = nil
            L2_2 = log
            L3_2 = "Released vehicle ownership - engine turned off"
            L4_2 = 4
            L2_2(L3_2, L4_2)
          end
        end
      end
      ::lbl_74::
      if 0 ~= L1_2 then
        L2_2 = GetPedInVehicleSeat
        L3_2 = L1_2
        L4_2 = -1
        L2_2 = L2_2(L3_2, L4_2)
        if L2_2 == L0_2 then
          L2_2 = GetVehicleClass
          L3_2 = L1_2
          L2_2 = L2_2(L3_2)
          if 18 == L2_2 then
            L3_2 = radioSystemAccess
            if true == L3_2 then
              L3_2 = RadioState
              L3_2 = L3_2.power
              if L3_2 then
                L3_2 = TriggerServerEvent
                L4_2 = "radio:checkVehicleOwnership"
                L5_2 = VehToNet
                L6_2 = L1_2
                L5_2 = L5_2(L6_2)
                L6_2 = RadioState
                L6_2 = L6_2.power
                L3_2(L4_2, L5_2, L6_2)
              end
            end
          end
      end
      else
        L2_2 = playerOwnedVehicle
        if L2_2 then
          L2_2 = DoesEntityExist
          L3_2 = playerOwnedVehicle
          L2_2 = L2_2(L3_2)
          if not L2_2 then
            playerOwnedVehicle = nil
            L2_2 = log
            L3_2 = "Released vehicle ownership - vehicle destroyed"
            L4_2 = 4
            L2_2(L3_2, L4_2)
          else
            L2_2 = GetIsVehicleEngineRunning
            L3_2 = playerOwnedVehicle
            L2_2 = L2_2(L3_2)
            if not L2_2 then
              L2_2 = TriggerServerEvent
              L3_2 = "radio:releaseVehicle"
              L4_2 = VehToNet
              L5_2 = playerOwnedVehicle
              L4_2, L5_2, L6_2 = L4_2(L5_2)
              L2_2(L3_2, L4_2, L5_2, L6_2)
              playerOwnedVehicle = nil
              L2_2 = log
              L3_2 = "Released vehicle ownership - engine turned off while outside vehicle"
              L4_2 = 4
              L2_2(L3_2, L4_2)
            end
          end
        end
      end
    end
  end
  L59_1(L60_1)
  L59_1 = RegisterNetEvent
  L60_1 = "radio:vehicleReleased"
  L59_1(L60_1)
  L59_1 = AddEventHandler
  L60_1 = "radio:vehicleReleased"
  function L61_1(A0_2)
    local L1_2, L2_2, L3_2
    L1_2 = playerOwnedVehicle
    if L1_2 then
      L1_2 = VehToNet
      L2_2 = playerOwnedVehicle
      L1_2 = L1_2(L2_2)
      if L1_2 == A0_2 then
        playerOwnedVehicle = nil
        L2_2 = L22_1
        L1_2 = L20_1
        L1_2[L2_2] = nil
        L1_2 = log
        L2_2 = "Released ownership of vehicle "
        L3_2 = A0_2
        L2_2 = L2_2 .. L3_2
        L3_2 = 4
        L1_2(L2_2, L3_2)
      end
    end
  end
  L59_1(L60_1, L61_1)
  L59_1 = RegisterNetEvent
  L60_1 = "radio:syncVehicleOwnership"
  L59_1(L60_1)
  L59_1 = AddEventHandler
  L60_1 = "radio:syncVehicleOwnership"
  function L61_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2
    if A1_2 then
      L2_2 = L20_1
      L2_2[A0_2] = A1_2
      L2_2 = L22_1
      if A0_2 == L2_2 then
        L2_2 = NetworkGetEntityFromNetworkId
        L3_2 = A1_2
        L2_2 = L2_2(L3_2)
        playerOwnedVehicle = L2_2
        L2_2 = log
        L3_2 = "Granted ownership of vehicle "
        L4_2 = A1_2
        L3_2 = L3_2 .. L4_2
        L4_2 = 4
        L2_2(L3_2, L4_2)
      else
        L2_2 = log
        L3_2 = "Synced vehicle ownership: Player "
        L4_2 = A0_2
        L5_2 = " owns vehicle "
        L6_2 = A1_2
        L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
        L4_2 = 4
        L2_2(L3_2, L4_2)
      end
    else
      L2_2 = L20_1
      L2_2[A0_2] = nil
      L2_2 = L22_1
      if A0_2 == L2_2 then
        playerOwnedVehicle = nil
        L2_2 = log
        L3_2 = "Released ownership of vehicle"
        L4_2 = 4
        L2_2(L3_2, L4_2)
      else
        L2_2 = log
        L3_2 = "Synced vehicle ownership: Player "
        L4_2 = A0_2
        L5_2 = " released vehicle"
        L3_2 = L3_2 .. L4_2 .. L5_2
        L4_2 = 4
        L2_2(L3_2, L4_2)
      end
    end
  end
  L59_1(L60_1, L61_1)
  L59_1 = RegisterNetEvent
  L60_1 = "radio:vehicleOwnershipResult"
  L59_1(L60_1)
  L59_1 = AddEventHandler
  L60_1 = "radio:vehicleOwnershipResult"
  function L61_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2
    if A1_2 then
      L2_2 = NetToVeh
      L3_2 = A0_2
      L2_2 = L2_2(L3_2)
      L3_2 = DoesEntityExist
      L4_2 = L2_2
      L3_2 = L3_2(L4_2)
      if L3_2 then
        L3_2 = playerOwnedVehicle
        if L3_2 then
          L3_2 = playerOwnedVehicle
          if L3_2 ~= L2_2 then
            L3_2 = DoesEntityExist
            L4_2 = playerOwnedVehicle
            L3_2 = L3_2(L4_2)
            if L3_2 then
              L3_2 = TriggerServerEvent
              L4_2 = "radio:releaseVehicle"
              L5_2 = VehToNet
              L6_2 = playerOwnedVehicle
              L5_2, L6_2 = L5_2(L6_2)
              L3_2(L4_2, L5_2, L6_2)
            end
          end
        end
        playerOwnedVehicle = L2_2
        L3_2 = log
        L4_2 = "Claimed ownership of emergency vehicle: "
        L5_2 = L2_2
        L4_2 = L4_2 .. L5_2
        L5_2 = 2
        L3_2(L4_2, L5_2)
      end
    end
  end
  L59_1(L60_1, L61_1)
  L59_1 = RegisterNetEvent
  L60_1 = "radio:vehicleReleased"
  L59_1(L60_1)
  L59_1 = AddEventHandler
  L60_1 = "radio:vehicleReleased"
  function L61_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = NetToVeh
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    L2_2 = playerOwnedVehicle
    if L2_2 == L1_2 then
      playerOwnedVehicle = nil
      L2_2 = log
      L3_2 = "Lost ownership of emergency vehicle: "
      L4_2 = L1_2
      L3_2 = L3_2 .. L4_2
      L4_2 = 2
      L2_2(L3_2, L4_2)
    end
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "toggleRadioKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+toggleRadio"
    L61_1 = "Toggle Radio"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "toggleRadioKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "talkRadioKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+talkOnRadio"
    L61_1 = "Talk on Radio"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "talkRadioKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-talkOnRadio"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+talkOnRadio"
  function L61_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2
    L0_2 = radioSystemAccess
    if true ~= L0_2 then
      return
    end
    L0_2 = IsPlayerDead
    L1_2 = PlayerId
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    if L0_2 then
      return
    end
    L0_2 = IsPedSwimming
    L1_2 = PlayerPedId
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    if L0_2 then
      return
    end
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if not L0_2 then
      return
    end
    L0_2 = GetPlayerServerId
    L1_2 = PlayerId
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
    L1_2 = GetGameTimer
    L1_2 = L1_2()
    L2_2 = RadioState
    L2_2 = L2_2.lastPTTTime
    if not L2_2 then
      L2_2 = 0
    end
    L2_2 = L1_2 - L2_2
    L3_2 = 1000
    L4_2 = RadioState
    L4_2 = L4_2.activeTalker
    L4_2 = RadioState
    L4_2 = L4_2.connectedChannelTalker
    L4_2 = RadioState
    L4_2 = L4_2 == L0_2 or L4_2
    L5_2 = RadioState
    L5_2 = L5_2.connectedChannelTalker
    if L5_2 then
      L5_2 = RadioState
      L5_2 = L5_2.connectedChannelTalker
      if L5_2 ~= L0_2 and not L4_2 then
        if L2_2 < L3_2 then
          L5_2 = log
          L6_2 = "Ignoring bonk due to grace period - potential race condition avoided (talker: "
          L7_2 = tostring
          L8_2 = RadioState
          L8_2 = L8_2.connectedChannelTalker
          L7_2 = L7_2(L8_2)
          L8_2 = ")"
          L6_2 = L6_2 .. L7_2 .. L8_2
          L7_2 = 3
          L5_2(L6_2, L7_2)
        else
          L5_2 = TriggerServerEvent
          L6_2 = "radioServer:playToneOnChannel"
          L7_2 = RadioState
          L7_2 = L7_2.connectedChannel
          L7_2 = L7_2.frequency
          L8_2 = "bonk"
          L5_2(L6_2, L7_2, L8_2)
          L5_2 = log
          L6_2 = "Blocking transmission - someone else talking on channel: "
          L7_2 = tostring
          L8_2 = RadioState
          L8_2 = L8_2.connectedChannelTalker
          L7_2 = L7_2(L8_2)
          L6_2 = L6_2 .. L7_2
          L7_2 = 3
          L5_2(L6_2, L7_2)
          return
        end
    end
    elseif L4_2 then
      L5_2 = log
      L6_2 = "Allowing PTT - we are already talking/transmitting"
      L7_2 = 4
      L5_2(L6_2, L7_2)
    end
    L5_2 = RadioState
    L5_2.lastPTTTime = L1_2
    L5_2 = RadioState
    L5_2 = L5_2.scannedChannelTalker
    if L5_2 then
      L5_2 = RadioState
      L5_2 = L5_2.tempScannedChannels
      if not L5_2 then
        L5_2 = log
        L6_2 = "Pausing scan transmission for our PTT"
        L7_2 = 4
        L5_2(L6_2, L7_2)
        L5_2 = RadioState
        L6_2 = table
        L6_2 = L6_2.deepcopy
        L7_2 = RadioState
        L7_2 = L7_2.scannedChannels
        L6_2 = L6_2(L7_2)
        L5_2.tempScannedChannels = L6_2
        L5_2 = ipairs
        L6_2 = RadioState
        L6_2 = L6_2.scannedChannels
        L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
        for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
          L11_2 = Config
          L11_2 = L11_2.zones
          L12_2 = L10_2.zoneId
          L11_2 = L11_2[L12_2]
          if L11_2 then
            L11_2 = Config
            L11_2 = L11_2.zones
            L12_2 = L10_2.zoneId
            L11_2 = L11_2[L12_2]
            L11_2 = L11_2.Channels
            L12_2 = L10_2.channelId
            L11_2 = L11_2[L12_2]
          end
          if L11_2 then
            L12_2 = Radio
            L12_2 = L12_2.removeListeningChannel
            L13_2 = convertFreq
            L14_2 = L11_2.frequency
            L13_2, L14_2, L15_2 = L13_2(L14_2)
            L12_2(L13_2, L14_2, L15_2)
            L12_2 = L11_2.type
            if "trunked" == L12_2 then
              L12_2 = RadioState
              L12_2 = L12_2.scannedTrunkedFreqs
              if L12_2 then
                L12_2 = RadioState
                L12_2 = L12_2.scannedTrunkedFreqs
                L13_2 = L10_2.channelId
                L12_2 = L12_2[L13_2]
                if L12_2 then
                  L12_2 = Radio
                  L12_2 = L12_2.removeListeningChannel
                  L13_2 = convertFreq
                  L14_2 = RadioState
                  L14_2 = L14_2.scannedTrunkedFreqs
                  L15_2 = L10_2.channelId
                  L14_2 = L14_2[L15_2]
                  L13_2, L14_2, L15_2 = L13_2(L14_2)
                  L12_2(L13_2, L14_2, L15_2)
                end
              end
            end
          end
        end
        L5_2 = RadioState
        L5_2.scannedChannelTalker = nil
      end
    end
    L5_2 = RadioState
    L5_2 = L5_2.tempScannedChannels
    if not L5_2 then
      L5_2 = RadioState
      L6_2 = table
      L6_2 = L6_2.deepcopy
      L7_2 = RadioState
      L7_2 = L7_2.scannedChannels
      L6_2 = L6_2(L7_2)
      L5_2.tempScannedChannels = L6_2
      L5_2 = ipairs
      L6_2 = RadioState
      L6_2 = L6_2.scannedChannels
      L5_2, L6_2, L7_2, L8_2 = L5_2(L6_2)
      for L9_2, L10_2 in L5_2, L6_2, L7_2, L8_2 do
        L11_2 = Config
        L11_2 = L11_2.zones
        L12_2 = L10_2.zoneId
        L11_2 = L11_2[L12_2]
        if L11_2 then
          L11_2 = Config
          L11_2 = L11_2.zones
          L12_2 = L10_2.zoneId
          L11_2 = L11_2[L12_2]
          L11_2 = L11_2.Channels
          L12_2 = L10_2.channelId
          L11_2 = L11_2[L12_2]
        end
        if L11_2 then
          L12_2 = Radio
          L12_2 = L12_2.removeListeningChannel
          L13_2 = convertFreq
          L14_2 = L11_2.frequency
          L13_2, L14_2, L15_2 = L13_2(L14_2)
          L12_2(L13_2, L14_2, L15_2)
          L12_2 = L11_2.type
          if "trunked" == L12_2 then
            L12_2 = RadioState
            L12_2 = L12_2.scannedTrunkedFreqs
            if L12_2 then
              L12_2 = RadioState
              L12_2 = L12_2.scannedTrunkedFreqs
              L13_2 = L10_2.channelId
              L12_2 = L12_2[L13_2]
              if L12_2 then
                L12_2 = Radio
                L12_2 = L12_2.removeListeningChannel
                L13_2 = convertFreq
                L14_2 = RadioState
                L14_2 = L14_2.scannedTrunkedFreqs
                L15_2 = L10_2.channelId
                L14_2 = L14_2[L15_2]
                L13_2, L14_2, L15_2 = L13_2(L14_2)
                L12_2(L13_2, L14_2, L15_2)
              end
            end
          end
        end
      end
    end
    L5_2 = RadioState
    L5_2 = L5_2.pttReleaseTimer
    if L5_2 then
      L5_2 = Citizen
      L5_2 = L5_2.ClearTimeout
      L6_2 = RadioState
      L6_2 = L6_2.pttReleaseTimer
      L5_2(L6_2)
      L5_2 = RadioState
      L5_2.pttReleaseTimer = nil
      L5_2 = log
      L6_2 = "Cancelled pending PTT release - user re-keyed PTT"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = GetPlayerServerId
      L6_2 = PlayerId
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L6_2()
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      L6_2 = GetGameTimer
      L6_2 = L6_2()
      L7_2 = RadioState
      L7_2 = L7_2.lastPTTTime
      if not L7_2 then
        L7_2 = 0
      end
      L7_2 = L6_2 - L7_2
      L8_2 = 1000
      L9_2 = RadioState
      L9_2 = L9_2.activeTalker
      L9_2 = RadioState
      L9_2 = L9_2.connectedChannelTalker
      L9_2 = RadioState
      L9_2 = L9_2 == L5_2 or L9_2
      L10_2 = RadioState
      L10_2 = L10_2.connectedChannelTalker
      if L10_2 then
        L10_2 = RadioState
        L10_2 = L10_2.connectedChannelTalker
        if L10_2 ~= L5_2 and not L9_2 then
          if L7_2 < L8_2 then
            L10_2 = log
            L11_2 = "Ignoring re-key bonk due to grace period - potential race condition avoided (talker: "
            L12_2 = tostring
            L13_2 = RadioState
            L13_2 = L13_2.connectedChannelTalker
            L12_2 = L12_2(L13_2)
            L13_2 = ")"
            L11_2 = L11_2 .. L12_2 .. L13_2
            L12_2 = 3
            L10_2(L11_2, L12_2)
          else
            L10_2 = TriggerServerEvent
            L11_2 = "radioServer:playToneOnChannel"
            L12_2 = RadioState
            L12_2 = L12_2.connectedChannel
            L12_2 = L12_2.frequency
            L13_2 = "bonk"
            L10_2(L11_2, L12_2, L13_2)
            L10_2 = log
            L11_2 = "Blocking re-key transmission - someone else talking on channel: "
            L12_2 = tostring
            L13_2 = RadioState
            L13_2 = L13_2.connectedChannelTalker
            L12_2 = L12_2(L13_2)
            L11_2 = L11_2 .. L12_2
            L12_2 = 3
            L10_2(L11_2, L12_2)
            return
          end
      end
      elseif L9_2 then
        L10_2 = log
        L11_2 = "Allowing re-key - we are already talking/transmitting"
        L12_2 = 4
        L10_2(L11_2, L12_2)
      end
      L10_2 = GetPlayerServerId
      L11_2 = PlayerId
      L11_2, L12_2, L13_2, L14_2, L15_2 = L11_2()
      L10_2 = L10_2(L11_2, L12_2, L13_2, L14_2, L15_2)
      L11_2 = RadioState
      L11_2 = L11_2.connected
      if L11_2 then
        L11_2 = RadioState
        L11_2.connectedChannelTalker = L10_2
      end
      L11_2 = RadioState
      L11_2.activeTalker = L10_2
      L11_2 = RadioState
      L12_2 = RadioState
      L12_2 = L12_2.connectedChannel
      L12_2 = L12_2.frequency
      L11_2.activeTransmissionFreq = L12_2
      L11_2 = setLED
      L12_2 = "transmit"
      L13_2 = true
      L11_2(L12_2, L13_2)
      L11_2 = L42_1
      L11_2()
    end
    L5_2 = RadioState
    L5_2 = L5_2.pttReleaseTimer
    if not L5_2 then
      L5_2 = GetPlayerServerId
      L6_2 = PlayerId
      L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2 = L6_2()
      L5_2 = L5_2(L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2)
      L6_2 = RadioState
      L6_2 = L6_2.connected
      if L6_2 then
        L6_2 = RadioState
        L6_2.connectedChannelTalker = L5_2
      end
      L6_2 = RadioState
      L6_2.activeTalker = L5_2
      L6_2 = RadioState
      L7_2 = RadioState
      L7_2 = L7_2.connectedChannel
      L7_2 = L7_2.frequency
      L6_2.activeTransmissionFreq = L7_2
      L6_2 = setLED
      L7_2 = "transmit"
      L8_2 = true
      L6_2(L7_2, L8_2)
      L6_2 = L42_1
      L6_2()
    end
    L5_2 = RadioState
    L5_2.talking = true
    L5_2 = RadioState
    L5_2 = L5_2.power
    if L5_2 then
      L5_2 = Radio
      L5_2 = L5_2.playTone
      L6_2 = "PTT"
      L5_2(L6_2)
    end
    L5_2 = Radio
    L5_2 = L5_2.setTalking
    L6_2 = true
    L5_2(L6_2)
    L5_2 = RadioState
    L5_2 = L5_2.selectedAnimation
    if not L5_2 then
      L5_2 = 2
    end
    L6_2 = Config
    L6_2 = L6_2.animations
    L6_2 = L6_2[L5_2]
    if L6_2 then
      L6_2 = Config
      L6_2 = L6_2.animations
      L6_2 = L6_2[L5_2]
      L6_2 = L6_2.onKeyState
      if L6_2 then
        L6_2 = pcall
        L7_2 = Config
        L7_2 = L7_2.animations
        L7_2 = L7_2[L5_2]
        L7_2 = L7_2.onKeyState
        L8_2 = true
        L6_2, L7_2 = L6_2(L7_2, L8_2)
        if not L6_2 then
          L8_2 = log
          L9_2 = "Radio animation error (key down): "
          L10_2 = tostring
          L11_2 = L7_2
          L10_2 = L10_2(L11_2)
          L9_2 = L9_2 .. L10_2
          L10_2 = 1
          L8_2(L9_2, L10_2)
        end
      end
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-talkOnRadio"
  function L61_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L0_2 = radioSystemAccess
    if true ~= L0_2 then
      return
    end
    L0_2 = IsPedSwimming
    L1_2 = PlayerPedId
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    if not L0_2 then
      L0_2 = IsPlayerDead
      L1_2 = PlayerId
      L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
      L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
      if not L0_2 then
        goto lbl_126
      end
    end
    L0_2 = setLED
    L1_2 = "transmit"
    L2_2 = false
    L0_2(L1_2, L2_2)
    L0_2 = GetPlayerServerId
    L1_2 = PlayerId
    L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L1_2()
    L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L1_2 = RadioState
    L1_2 = L1_2.activeTalker
    if L1_2 == L0_2 then
      L1_2 = RadioState
      L1_2.activeTalker = nil
      L1_2 = RadioState
      L1_2.activeTransmissionFreq = nil
    end
    L1_2 = RadioState
    L1_2 = L1_2.connectedChannelTalker
    if L1_2 == L0_2 then
      L1_2 = RadioState
      L1_2.connectedChannelTalker = nil
    end
    L1_2 = RadioState
    L1_2 = L1_2.scannedChannelTalker
    if L1_2 == L0_2 then
      L1_2 = RadioState
      L1_2.scannedChannelTalker = nil
    end
    L1_2 = L42_1
    L1_2()
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setTalking"
    L2_2.talking = false
    L2_2.suppressTone = true
    L1_2(L2_2)
    L1_2 = RadioState
    L1_2 = L1_2.pttReleaseTimer
    if L1_2 then
      L1_2 = Citizen
      L1_2 = L1_2.ClearTimeout
      L2_2 = RadioState
      L2_2 = L2_2.pttReleaseTimer
      L1_2(L2_2)
      L1_2 = RadioState
      L1_2.pttReleaseTimer = nil
    end
    L1_2 = RadioState
    L1_2 = L1_2.tempScannedChannels
    if L1_2 then
      L1_2 = ipairs
      L2_2 = RadioState
      L2_2 = L2_2.tempScannedChannels
      L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
      for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
        L7_2 = Config
        L7_2 = L7_2.zones
        L8_2 = L6_2.zoneId
        L7_2 = L7_2[L8_2]
        if L7_2 then
          L7_2 = Config
          L7_2 = L7_2.zones
          L8_2 = L6_2.zoneId
          L7_2 = L7_2[L8_2]
          L7_2 = L7_2.Channels
          L8_2 = L6_2.channelId
          L7_2 = L7_2[L8_2]
        end
        if L7_2 then
          L8_2 = Radio
          L8_2 = L8_2.addListeningChannel
          L9_2 = convertFreq
          L10_2 = L7_2.frequency
          L9_2, L10_2, L11_2 = L9_2(L10_2)
          L8_2(L9_2, L10_2, L11_2)
          L8_2 = L7_2.type
          if "trunked" == L8_2 then
            L8_2 = RadioState
            L8_2 = L8_2.scannedTrunkedFreqs
            if L8_2 then
              L8_2 = RadioState
              L8_2 = L8_2.scannedTrunkedFreqs
              L9_2 = L6_2.channelId
              L8_2 = L8_2[L9_2]
              if L8_2 then
                L8_2 = Radio
                L8_2 = L8_2.addListeningChannel
                L9_2 = convertFreq
                L10_2 = RadioState
                L10_2 = L10_2.scannedTrunkedFreqs
                L11_2 = L6_2.channelId
                L10_2 = L10_2[L11_2]
                L9_2, L10_2, L11_2 = L9_2(L10_2)
                L8_2(L9_2, L10_2, L11_2)
              end
            end
          end
        end
      end
      L1_2 = RadioState
      L1_2.tempScannedChannels = nil
    end
    L1_2 = TriggerEvent
    L2_2 = "radio:stopAllSirens"
    L1_2(L2_2)
    do return end
    ::lbl_126::
    L0_2 = RadioState
    L0_2 = L0_2.selectedAnimation
    if not L0_2 then
      L0_2 = 2
    end
    L1_2 = Config
    L1_2 = L1_2.animations
    L1_2 = L1_2[L0_2]
    if L1_2 then
      L1_2 = Config
      L1_2 = L1_2.animations
      L1_2 = L1_2[L0_2]
      L1_2 = L1_2.onKeyState
      if L1_2 then
        L1_2 = pcall
        L2_2 = Config
        L2_2 = L2_2.animations
        L2_2 = L2_2[L0_2]
        L2_2 = L2_2.onKeyState
        L3_2 = false
        L1_2, L2_2 = L1_2(L2_2, L3_2)
        if not L1_2 then
          L3_2 = log
          L4_2 = "Radio animation error (key up): "
          L5_2 = tostring
          L6_2 = L2_2
          L5_2 = L5_2(L6_2)
          L4_2 = L4_2 .. L5_2
          L5_2 = 1
          L3_2(L4_2, L5_2)
        end
      end
    end
    L1_2 = setLED
    L2_2 = "transmit"
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = GetPlayerServerId
    L2_2 = PlayerId
    L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2)
    L2_2 = RadioState
    L2_2 = L2_2.activeTalker
    if L2_2 == L1_2 then
      L2_2 = RadioState
      L2_2.activeTalker = nil
      L2_2 = RadioState
      L2_2.activeTransmissionFreq = nil
    end
    L2_2 = RadioState
    L2_2 = L2_2.connectedChannelTalker
    if L2_2 == L1_2 then
      L2_2 = RadioState
      L2_2.connectedChannelTalker = nil
    end
    L2_2 = RadioState
    L2_2 = L2_2.scannedChannelTalker
    if L2_2 == L1_2 then
      L2_2 = RadioState
      L2_2.scannedChannelTalker = nil
    end
    L2_2 = L42_1
    L2_2()
    L2_2 = RadioState
    L2_2 = L2_2.power
    if L2_2 then
      L2_2 = Radio
      L2_2 = L2_2.playTone
      L3_2 = "PTT_END"
      L2_2(L3_2)
    end
    L2_2 = RadioState
    L3_2 = Citizen
    L3_2 = L3_2.SetTimeout
    L4_2 = Config
    L4_2 = L4_2.pttReleaseDelay
    function L5_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
      L0_3 = RadioState
      L0_3 = L0_3.pttReleaseTimer
      if L0_3 then
        L0_3 = RadioState
        L0_3.pttReleaseTimer = nil
        L0_3 = SendNUIMessage
        L1_3 = {}
        L1_3.action = "setTalking"
        L1_3.talking = false
        L1_3.suppressTone = true
        L0_3(L1_3)
        L0_3 = TriggerEvent
        L1_3 = "radio:stopAllSirens"
        L0_3(L1_3)
        L0_3 = RadioState
        L0_3 = L0_3.tempScannedChannels
        if L0_3 then
          L0_3 = ipairs
          L1_3 = RadioState
          L1_3 = L1_3.tempScannedChannels
          L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
          for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
            L6_3 = Config
            L6_3 = L6_3.zones
            L7_3 = L5_3.zoneId
            L6_3 = L6_3[L7_3]
            if L6_3 then
              L6_3 = Config
              L6_3 = L6_3.zones
              L7_3 = L5_3.zoneId
              L6_3 = L6_3[L7_3]
              L6_3 = L6_3.Channels
              L7_3 = L5_3.channelId
              L6_3 = L6_3[L7_3]
            end
            if L6_3 then
              L7_3 = Radio
              L7_3 = L7_3.addListeningChannel
              L8_3 = convertFreq
              L9_3 = L6_3.frequency
              L8_3, L9_3, L10_3 = L8_3(L9_3)
              L7_3(L8_3, L9_3, L10_3)
              L7_3 = L6_3.type
              if "trunked" == L7_3 then
                L7_3 = RadioState
                L7_3 = L7_3.scannedTrunkedFreqs
                if L7_3 then
                  L7_3 = RadioState
                  L7_3 = L7_3.scannedTrunkedFreqs
                  L8_3 = L5_3.channelId
                  L7_3 = L7_3[L8_3]
                  if L7_3 then
                    L7_3 = Radio
                    L7_3 = L7_3.addListeningChannel
                    L8_3 = convertFreq
                    L9_3 = RadioState
                    L9_3 = L9_3.scannedTrunkedFreqs
                    L10_3 = L5_3.channelId
                    L9_3 = L9_3[L10_3]
                    L8_3, L9_3, L10_3 = L8_3(L9_3)
                    L7_3(L8_3, L9_3, L10_3)
                  end
                end
              end
            end
          end
          L0_3 = RadioState
          L0_3.tempScannedChannels = nil
        end
      else
        L0_3 = log
        L1_3 = "PTT release timer was cancelled - user re-keyed before delay expired"
        L2_3 = 4
        L0_3(L1_3, L2_3)
      end
    end
    L3_2 = L3_2(L4_2, L5_2)
    L2_2.pttReleaseTimer = L3_2
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "talkRadioKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+talkOnRadio"
    L61_1 = "Talk on Radio"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "talkRadioKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
    L59_1 = _ENV
    L60_1 = "log"
    L59_1 = L59_1[L60_1]
    L60_1 = "Registered PTT key mappings for key: "
    L61_1 = _ENV
    L62_1 = "tostring"
    L61_1 = L61_1[L62_1]
    L62_1 = _ENV
    L63_1 = "Config"
    L62_1 = L62_1[L63_1]
    L63_1 = "controls"
    L62_1 = L62_1[L63_1]
    L63_1 = "talkRadioKey"
    L62_1 = L62_1[L63_1]
    L61_1 = L61_1(L62_1)
    L60_1 = L60_1 .. L61_1
    L61_1 = 2
    L59_1(L60_1, L61_1)
  end
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-talkOnRadio"
  function L61_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = radioSystemAccess
    if true ~= L0_2 then
      return
    end
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = RadioState
    L0_2 = L0_2.connected
    if not L0_2 then
      return
    end
    L0_2 = RadioState
    L0_2 = L0_2.talking
    if not L0_2 then
      return
    end
    L0_2 = RadioState
    L0_2 = L0_2.selectedAnimation
    if not L0_2 then
      L0_2 = 2
    end
    L1_2 = Config
    L1_2 = L1_2.animations
    L1_2 = L1_2[L0_2]
    if L1_2 then
      L1_2 = Config
      L1_2 = L1_2.animations
      L1_2 = L1_2[L0_2]
      L1_2 = L1_2.onKeyState
      if L1_2 then
        L1_2 = pcall
        L2_2 = Config
        L2_2 = L2_2.animations
        L2_2 = L2_2[L0_2]
        L2_2 = L2_2.onKeyState
        L3_2 = false
        L1_2, L2_2 = L1_2(L2_2, L3_2)
        if not L1_2 then
          L3_2 = log
          L4_2 = "Radio animation error (key up): "
          L5_2 = tostring
          L6_2 = L2_2
          L5_2 = L5_2(L6_2)
          L4_2 = L4_2 .. L5_2
          L5_2 = 1
          L3_2(L4_2, L5_2)
        end
      end
    end
    L1_2 = setLED
    L2_2 = "transmit"
    L3_2 = false
    L1_2(L2_2, L3_2)
    L1_2 = GetPlayerServerId
    L2_2 = PlayerId
    L2_2, L3_2, L4_2, L5_2, L6_2 = L2_2()
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2, L6_2)
    L2_2 = RadioState
    L2_2 = L2_2.activeTalker
    if L2_2 == L1_2 then
      L2_2 = RadioState
      L2_2.activeTalker = nil
      L2_2 = RadioState
      L2_2.activeTransmissionFreq = nil
    end
    L2_2 = RadioState
    L2_2 = L2_2.connectedChannelTalker
    if L2_2 == L1_2 then
      L2_2 = RadioState
      L2_2.connectedChannelTalker = nil
    end
    L2_2 = RadioState
    L2_2 = L2_2.scannedChannelTalker
    if L2_2 == L1_2 then
      L2_2 = RadioState
      L2_2.scannedChannelTalker = nil
    end
    L2_2 = L42_1
    L2_2()
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "PTT_END"
    L2_2(L3_2)
    L2_2 = RadioState
    L3_2 = Citizen
    L3_2 = L3_2.SetTimeout
    L4_2 = Config
    L4_2 = L4_2.pttReleaseDelay
    function L5_2()
      local L0_3, L1_3, L2_3, L3_3, L4_3, L5_3, L6_3, L7_3, L8_3, L9_3, L10_3
      L0_3 = RadioState
      L0_3 = L0_3.pttReleaseTimer
      if L0_3 then
        L0_3 = RadioState
        L0_3.pttReleaseTimer = nil
        L0_3 = RadioState
        L0_3.talking = false
        L0_3 = SendNUIMessage
        L1_3 = {}
        L1_3.action = "setTalking"
        L1_3.talking = false
        L1_3.suppressTone = true
        L0_3(L1_3)
        L0_3 = TriggerEvent
        L1_3 = "radio:stopAllSirens"
        L0_3(L1_3)
        L0_3 = RadioState
        L0_3 = L0_3.tempScannedChannels
        if L0_3 then
          L0_3 = ipairs
          L1_3 = RadioState
          L1_3 = L1_3.tempScannedChannels
          L0_3, L1_3, L2_3, L3_3 = L0_3(L1_3)
          for L4_3, L5_3 in L0_3, L1_3, L2_3, L3_3 do
            L6_3 = Config
            L6_3 = L6_3.zones
            L7_3 = L5_3.zoneId
            L6_3 = L6_3[L7_3]
            if L6_3 then
              L6_3 = Config
              L6_3 = L6_3.zones
              L7_3 = L5_3.zoneId
              L6_3 = L6_3[L7_3]
              L6_3 = L6_3.Channels
              L7_3 = L5_3.channelId
              L6_3 = L6_3[L7_3]
            end
            if L6_3 then
              L7_3 = Radio
              L7_3 = L7_3.addListeningChannel
              L8_3 = convertFreq
              L9_3 = L6_3.frequency
              L8_3, L9_3, L10_3 = L8_3(L9_3)
              L7_3(L8_3, L9_3, L10_3)
              L7_3 = L6_3.type
              if "trunked" == L7_3 then
                L7_3 = RadioState
                L7_3 = L7_3.scannedTrunkedFreqs
                if L7_3 then
                  L7_3 = RadioState
                  L7_3 = L7_3.scannedTrunkedFreqs
                  L8_3 = L5_3.channelId
                  L7_3 = L7_3[L8_3]
                  if L7_3 then
                    L7_3 = Radio
                    L7_3 = L7_3.addListeningChannel
                    L8_3 = convertFreq
                    L9_3 = RadioState
                    L9_3 = L9_3.scannedTrunkedFreqs
                    L10_3 = L5_3.channelId
                    L9_3 = L9_3[L10_3]
                    L8_3, L9_3, L10_3 = L8_3(L9_3)
                    L7_3(L8_3, L9_3, L10_3)
                  end
                end
              end
            end
          end
          L0_3 = RadioState
          L0_3.tempScannedChannels = nil
        end
      else
        L0_3 = log
        L1_3 = "PTT release timer was cancelled - user re-keyed before delay expired"
        L2_3 = 4
        L0_3(L1_3, L2_3)
      end
    end
    L3_2 = L3_2(L4_2, L5_2)
    L2_2.pttReleaseTimer = L3_2
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+radio_menuUp"
  function L61_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "btnUp"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-radio_menuUp"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "menuUpKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+radio_menuUp"
    L61_1 = "Radio Menu Up"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "menuUpKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+radio_menuDown"
  function L61_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "btnDown"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-radio_menuDown"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "menuDownKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+radio_menuDown"
    L61_1 = "Radio Menu Down"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "menuDownKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+radio_menuRight"
  function L61_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "btnRight"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-radio_menuRight"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "menuRightKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+radio_menuRight"
    L61_1 = "Radio Menu Right"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "menuRightKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+radio_menuLeft"
  function L61_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "btnLeft"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-radio_menuLeft"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "menuLeftKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+radio_menuLeft"
    L61_1 = "Radio Menu Left"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "menuLeftKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+radio_menuHome"
  function L61_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "home"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-radio_menuHome"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "menuHomeKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+radio_menuHome"
    L61_1 = "Radio Menu Home"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "menuHomeKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "+radio_closeRadio"
  function L61_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.open
    if L0_2 then
      L0_2 = TriggerEvent
      L1_2 = "radioClient:btnPress"
      L2_2 = "close"
      L0_2(L1_2, L2_2)
    else
      L0_2 = SetNuiFocus
      L1_2 = false
      L2_2 = false
      L0_2(L1_2, L2_2)
      L0_2 = RadioState
      L0_2.focused = false
      L0_2 = L31_1
      L0_2()
      L0_2 = log
      L1_2 = "Emergency NUI focus release via close radio key"
      L2_2 = 4
      L0_2(L1_2, L2_2)
    end
  end
  L62_1 = false
  L59_1(L60_1, L61_1, L62_1)
  L59_1 = _ENV
  L60_1 = "RegisterCommand"
  L59_1 = L59_1[L60_1]
  L60_1 = "-radio_closeRadio"
  function L61_1()
    local L0_2, L1_2
  end
  L59_1(L60_1, L61_1)
  L59_1 = _ENV
  L60_1 = "Config"
  L59_1 = L59_1[L60_1]
  L60_1 = "controls"
  L59_1 = L59_1[L60_1]
  L60_1 = "closeRadioKey"
  L59_1 = L59_1[L60_1]
  L60_1 = nil
  if L59_1 ~= L60_1 then
    L59_1 = _ENV
    L60_1 = "RegisterKeyMapping"
    L59_1 = L59_1[L60_1]
    L60_1 = "+radio_closeRadio"
    L61_1 = "Close Radio"
    L62_1 = "keyboard"
    L63_1 = _ENV
    L64_1 = "Config"
    L63_1 = L63_1[L64_1]
    L64_1 = "controls"
    L63_1 = L63_1[L64_1]
    L64_1 = "closeRadioKey"
    L63_1 = L63_1[L64_1]
    L59_1(L60_1, L61_1, L62_1, L63_1)
  end
  L59_1 = 0
  L60_1 = nil
  L61_1 = nil
  L62_1 = false
  L63_1 = 3
  L64_1 = 1000
  L65_1 = 2000
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_emergency"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.connected
      if L0_2 then
        goto lbl_10
      end
    end
    do return end
    ::lbl_10::
    L0_2 = RadioState
    L0_2 = L0_2.panicButton
    if L0_2 then
      L1_2 = L61_1
      if L1_2 then
        L1_2 = log
        L2_2 = "Emergency deactivation blocked - in cooldown"
        L3_2 = 3
        L1_2(L2_2, L3_2)
        return
      end
      L1_2 = log
      L2_2 = "Emergency deactivation - single press"
      L3_2 = 3
      L1_2(L2_2, L3_2)
      L1_2 = TriggerEvent
      L2_2 = "radioClient:btnPress"
      L3_2 = "emergency"
      L1_2(L2_2, L3_2)
      L1_2 = Citizen
      L1_2 = L1_2.SetTimeout
      L2_2 = L65_1
      function L3_2()
        local L0_3, L1_3, L2_3
        L0_3 = nil
        L61_1 = L0_3
        L0_3 = log
        L1_3 = "Emergency cooldown ended"
        L2_3 = 4
        L0_3(L1_3, L2_3)
      end
      L1_2 = L1_2(L2_2, L3_2)
      L61_1 = L1_2
      return
    end
    L1_2 = log
    L2_2 = "Emergency activation attempt - press "
    L3_2 = L59_1
    L3_2 = L3_2 + 1
    L4_2 = "/"
    L5_2 = L63_1
    L2_2 = L2_2 .. L3_2 .. L4_2 .. L5_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = L59_1
    L1_2 = L1_2 + 1
    L59_1 = L1_2
    L1_2 = L60_1
    if L1_2 then
      L1_2 = Citizen
      L1_2 = L1_2.ClearTimeout
      L2_2 = L60_1
      L1_2(L2_2)
    end
    L1_2 = Citizen
    L1_2 = L1_2.SetTimeout
    L2_2 = L64_1
    function L3_2()
      local L0_3, L1_3, L2_3
      L0_3 = log
      L1_3 = "Emergency activation timeout - resetting counter"
      L2_3 = 4
      L0_3(L1_3, L2_3)
      L0_3 = 0
      L59_1 = L0_3
      L0_3 = nil
      L60_1 = L0_3
    end
    L1_2 = L1_2(L2_2, L3_2)
    L60_1 = L1_2
    L1_2 = L59_1
    L2_2 = L63_1
    if L1_2 >= L2_2 then
      L1_2 = log
      L2_2 = "Emergency activation - "
      L3_2 = L63_1
      L4_2 = " presses reached"
      L2_2 = L2_2 .. L3_2 .. L4_2
      L3_2 = 3
      L1_2(L2_2, L3_2)
      L1_2 = 0
      L59_1 = L1_2
      L1_2 = L60_1
      if L1_2 then
        L1_2 = Citizen
        L1_2 = L1_2.ClearTimeout
        L2_2 = L60_1
        L1_2(L2_2)
        L1_2 = nil
        L60_1 = L1_2
      end
      L1_2 = TriggerEvent
      L2_2 = "radioClient:btnPress"
      L3_2 = "emergency"
      L1_2(L2_2, L3_2)
    end
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_emergency"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "emergencyBtnKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_emergency"
    L68_1 = "Radio Emergency Button"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "emergencyBtnKey"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_channelUp"
  function L68_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = TriggerEvent
    L1_2 = "radioClient:btnPress"
    L2_2 = "chUp"
    L0_2(L1_2, L2_2)
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_channelUp"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "channelUpKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_channelUp"
    L68_1 = "Radio Channel Up"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "channelUpKey"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_channelDown"
  function L68_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = TriggerEvent
    L1_2 = "radioClient:btnPress"
    L2_2 = "chDwn"
    L0_2(L1_2, L2_2)
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_channelDown"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "channelDownKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_channelDown"
    L68_1 = "Radio Channel Down"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "channelDownKey"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_zoneUp"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = L23_1
    L0_2 = L0_2()
    L1_2 = next
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      return
    end
    L1_2 = {}
    L2_2 = pairs
    L3_2 = L0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L1_2
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
    end
    L2_2 = table
    L2_2 = L2_2.sort
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = 1
    L3_2 = ipairs
    L4_2 = L1_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = RadioState
      L9_2 = L9_2.selectedZone
      if L8_2 == L9_2 then
        L2_2 = L7_2
        break
      end
    end
    L3_2 = L2_2 + 1
    L4_2 = #L1_2
    if L3_2 > L4_2 then
      L3_2 = 1
    end
    L4_2 = L1_2[L3_2]
    L5_2 = RadioState
    L5_2.selectedZone = L4_2
    L5_2 = Config
    L5_2 = L5_2.zones
    L5_2 = L5_2[L4_2]
    L5_2 = L5_2.name
    L6_2 = showAlert
    L7_2 = "ZN: "
    L8_2 = L5_2
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = Radio
    L6_2 = L6_2.playTone
    L7_2 = "beep"
    L6_2(L7_2)
    L6_2 = L42_1
    L6_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_zoneUp"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "zoneUpKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_zoneUp"
    L68_1 = "Radio Zone Up"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "zoneUpKey"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_zoneDown"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = L23_1
    L0_2 = L0_2()
    L1_2 = next
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    if not L1_2 then
      return
    end
    L1_2 = {}
    L2_2 = pairs
    L3_2 = L0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      L8_2 = table
      L8_2 = L8_2.insert
      L9_2 = L1_2
      L10_2 = L6_2
      L8_2(L9_2, L10_2)
    end
    L2_2 = table
    L2_2 = L2_2.sort
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = 1
    L3_2 = ipairs
    L4_2 = L1_2
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = RadioState
      L9_2 = L9_2.selectedZone
      if L8_2 == L9_2 then
        L2_2 = L7_2
        break
      end
    end
    L3_2 = L2_2 - 1
    if L3_2 < 1 then
      L3_2 = #L1_2
    end
    L4_2 = L1_2[L3_2]
    L5_2 = RadioState
    L5_2.selectedZone = L4_2
    L5_2 = Config
    L5_2 = L5_2.zones
    L5_2 = L5_2[L4_2]
    L5_2 = L5_2.name
    L6_2 = showAlert
    L7_2 = "ZN: "
    L8_2 = L5_2
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = Radio
    L6_2 = L6_2.playTone
    L7_2 = "beep"
    L6_2(L7_2)
    L6_2 = L42_1
    L6_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_zoneDown"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "zoneDownKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_zoneDown"
    L68_1 = "Radio Zone Down"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "zoneDownKey"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_menuBtn1"
  function L68_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "btn1"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_menuBtn1"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "menuBtn1Key"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_menuBtn1"
    L68_1 = "Radio Menu Button 1"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "menuBtn1Key"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_menuBtn2"
  function L68_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "btn2"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_menuBtn2"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "menuBtn2Key"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_menuBtn2"
    L68_1 = "Radio Menu Button 2"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "menuBtn2Key"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_menuBtn3"
  function L68_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if L0_2 then
      L0_2 = RadioState
      L0_2 = L0_2.open
      if L0_2 then
        L0_2 = TriggerEvent
        L1_2 = "radioClient:btnPress"
        L2_2 = "btn3"
        L0_2(L1_2, L2_2)
      end
    end
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_menuBtn3"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "menuBtn3Key"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_menuBtn3"
    L68_1 = "Radio Menu Button 3"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "menuBtn3Key"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_powerBtn"
  function L68_1()
    local L0_2, L1_2, L2_2
    L0_2 = RadioState
    L0_2 = L0_2.open
    if L0_2 then
      L0_2 = TriggerEvent
      L1_2 = "radioClient:btnPress"
      L2_2 = "power"
      L0_2(L1_2, L2_2)
    end
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_powerBtn"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "powerBtnKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "RegisterKeyMapping"
    L66_1 = L66_1[L67_1]
    L67_1 = "+radio_powerBtn"
    L68_1 = "Radio Power Button"
    L69_1 = "keyboard"
    L70_1 = _ENV
    L71_1 = "Config"
    L70_1 = L70_1[L71_1]
    L71_1 = "controls"
    L70_1 = L70_1[L71_1]
    L71_1 = "powerBtnKey"
    L70_1 = L70_1[L71_1]
    L66_1(L67_1, L68_1, L69_1, L70_1)
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_voiceVolumeUp"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = Settings
    L0_2 = L0_2.loadSetting
    L1_2 = "volume"
    L0_2 = L0_2(L1_2)
    L1_2 = math
    L1_2 = L1_2.min
    L2_2 = 100
    L3_2 = L0_2 + 10
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = setVolume
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume"
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = "Voice Vol: "
    L4_2 = L1_2
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_voiceVolumeUp"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "voiceVolumeUpKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "Config"
    L66_1 = L66_1[L67_1]
    L67_1 = "controls"
    L66_1 = L66_1[L67_1]
    L67_1 = "voiceVolumeUpKey"
    L66_1 = L66_1[L67_1]
    L67_1 = ""
    if L66_1 ~= L67_1 then
      L66_1 = _ENV
      L67_1 = "RegisterKeyMapping"
      L66_1 = L66_1[L67_1]
      L67_1 = "+radio_voiceVolumeUp"
      L68_1 = "Radio Voice Volume Up"
      L69_1 = "keyboard"
      L70_1 = _ENV
      L71_1 = "Config"
      L70_1 = L70_1[L71_1]
      L71_1 = "controls"
      L70_1 = L70_1[L71_1]
      L71_1 = "voiceVolumeUpKey"
      L70_1 = L70_1[L71_1]
      L66_1(L67_1, L68_1, L69_1, L70_1)
    end
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_voiceVolumeDown"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = Settings
    L0_2 = L0_2.loadSetting
    L1_2 = "volume"
    L0_2 = L0_2(L1_2)
    L1_2 = math
    L1_2 = L1_2.max
    L2_2 = 0
    L3_2 = L0_2 - 10
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = setVolume
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume"
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = "Voice Vol: "
    L4_2 = L1_2
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_voiceVolumeDown"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "voiceVolumeDownKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "Config"
    L66_1 = L66_1[L67_1]
    L67_1 = "controls"
    L66_1 = L66_1[L67_1]
    L67_1 = "voiceVolumeDownKey"
    L66_1 = L66_1[L67_1]
    L67_1 = ""
    if L66_1 ~= L67_1 then
      L66_1 = _ENV
      L67_1 = "RegisterKeyMapping"
      L66_1 = L66_1[L67_1]
      L67_1 = "+radio_voiceVolumeDown"
      L68_1 = "Radio Voice Volume Down"
      L69_1 = "keyboard"
      L70_1 = _ENV
      L71_1 = "Config"
      L70_1 = L70_1[L71_1]
      L71_1 = "controls"
      L70_1 = L70_1[L71_1]
      L71_1 = "voiceVolumeDownKey"
      L70_1 = L70_1[L71_1]
      L66_1(L67_1, L68_1, L69_1, L70_1)
    end
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_sfxVolumeUp"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = Settings
    L0_2 = L0_2.loadSetting
    L1_2 = "toneVolume"
    L0_2 = L0_2(L1_2)
    L1_2 = math
    L1_2 = L1_2.min
    L2_2 = 100
    L3_2 = L0_2 + 5
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = setToneVolume
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "toneVolume"
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = "SFX Vol: "
    L4_2 = L1_2
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_sfxVolumeUp"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "sfxVolumeUpKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "Config"
    L66_1 = L66_1[L67_1]
    L67_1 = "controls"
    L66_1 = L66_1[L67_1]
    L67_1 = "sfxVolumeUpKey"
    L66_1 = L66_1[L67_1]
    L67_1 = ""
    if L66_1 ~= L67_1 then
      L66_1 = _ENV
      L67_1 = "RegisterKeyMapping"
      L66_1 = L66_1[L67_1]
      L67_1 = "+radio_sfxVolumeUp"
      L68_1 = "Radio SFX Volume Up"
      L69_1 = "keyboard"
      L70_1 = _ENV
      L71_1 = "Config"
      L70_1 = L70_1[L71_1]
      L71_1 = "controls"
      L70_1 = L70_1[L71_1]
      L71_1 = "sfxVolumeUpKey"
      L70_1 = L70_1[L71_1]
      L66_1(L67_1, L68_1, L69_1, L70_1)
    end
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_sfxVolumeDown"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = Settings
    L0_2 = L0_2.loadSetting
    L1_2 = "toneVolume"
    L0_2 = L0_2(L1_2)
    L1_2 = math
    L1_2 = L1_2.max
    L2_2 = 0
    L3_2 = L0_2 - 5
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = setToneVolume
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "toneVolume"
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = "SFX Vol: "
    L4_2 = L1_2
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_sfxVolumeDown"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "sfxVolumeDownKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "Config"
    L66_1 = L66_1[L67_1]
    L67_1 = "controls"
    L66_1 = L66_1[L67_1]
    L67_1 = "sfxVolumeDownKey"
    L66_1 = L66_1[L67_1]
    L67_1 = ""
    if L66_1 ~= L67_1 then
      L66_1 = _ENV
      L67_1 = "RegisterKeyMapping"
      L66_1 = L66_1[L67_1]
      L67_1 = "+radio_sfxVolumeDown"
      L68_1 = "Radio SFX Volume Down"
      L69_1 = "keyboard"
      L70_1 = _ENV
      L71_1 = "Config"
      L70_1 = L70_1[L71_1]
      L71_1 = "controls"
      L70_1 = L70_1[L71_1]
      L71_1 = "sfxVolumeDownKey"
      L70_1 = L70_1[L71_1]
      L66_1(L67_1, L68_1, L69_1, L70_1)
    end
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_volume3DUp"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = Settings
    L0_2 = L0_2.loadSetting
    L1_2 = "volume3D"
    L0_2 = L0_2(L1_2)
    L1_2 = math
    L1_2 = L1_2.min
    L2_2 = 100
    L3_2 = L0_2 + 5
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = set3DVolume
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume3D"
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = "3D Vol: "
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "%.1f"
    L6_2 = L1_2
    L4_2 = L4_2(L5_2, L6_2)
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_volume3DUp"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "volume3DUpKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "Config"
    L66_1 = L66_1[L67_1]
    L67_1 = "controls"
    L66_1 = L66_1[L67_1]
    L67_1 = "volume3DUpKey"
    L66_1 = L66_1[L67_1]
    L67_1 = ""
    if L66_1 ~= L67_1 then
      L66_1 = _ENV
      L67_1 = "RegisterKeyMapping"
      L66_1 = L66_1[L67_1]
      L67_1 = "+radio_volume3DUp"
      L68_1 = "Radio 3D Volume Up"
      L69_1 = "keyboard"
      L70_1 = _ENV
      L71_1 = "Config"
      L70_1 = L70_1[L71_1]
      L71_1 = "controls"
      L70_1 = L70_1[L71_1]
      L71_1 = "volume3DUpKey"
      L70_1 = L70_1[L71_1]
      L66_1(L67_1, L68_1, L69_1, L70_1)
    end
  end
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "+radio_volume3DDown"
  function L68_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      return
    end
    L0_2 = Settings
    L0_2 = L0_2.loadSetting
    L1_2 = "volume3D"
    L0_2 = L0_2(L1_2)
    L1_2 = math
    L1_2 = L1_2.max
    L2_2 = 0
    L3_2 = L0_2 - 5
    L1_2 = L1_2(L2_2, L3_2)
    L2_2 = set3DVolume
    L3_2 = L1_2
    L2_2(L3_2)
    L2_2 = Settings
    L2_2 = L2_2.saveSetting
    L3_2 = "volume3D"
    L4_2 = L1_2
    L2_2(L3_2, L4_2)
    L2_2 = showAlert
    L3_2 = "3D Vol: "
    L4_2 = string
    L4_2 = L4_2.format
    L5_2 = "%.1f"
    L6_2 = L1_2
    L4_2 = L4_2(L5_2, L6_2)
    L3_2 = L3_2 .. L4_2
    L2_2(L3_2)
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L3_2 = "beep"
    L2_2(L3_2)
    L2_2 = L42_1
    L2_2()
  end
  L69_1 = false
  L66_1(L67_1, L68_1, L69_1)
  L66_1 = _ENV
  L67_1 = "RegisterCommand"
  L66_1 = L66_1[L67_1]
  L67_1 = "-radio_volume3DDown"
  function L68_1()
    local L0_2, L1_2
  end
  L66_1(L67_1, L68_1)
  L66_1 = _ENV
  L67_1 = "Config"
  L66_1 = L66_1[L67_1]
  L67_1 = "controls"
  L66_1 = L66_1[L67_1]
  L67_1 = "volume3DDownKey"
  L66_1 = L66_1[L67_1]
  L67_1 = nil
  if L66_1 ~= L67_1 then
    L66_1 = _ENV
    L67_1 = "Config"
    L66_1 = L66_1[L67_1]
    L67_1 = "controls"
    L66_1 = L66_1[L67_1]
    L67_1 = "volume3DDownKey"
    L66_1 = L66_1[L67_1]
    L67_1 = ""
    if L66_1 ~= L67_1 then
      L66_1 = _ENV
      L67_1 = "RegisterKeyMapping"
      L66_1 = L66_1[L67_1]
      L67_1 = "+radio_volume3DDown"
      L68_1 = "Radio 3D Volume Down"
      L69_1 = "keyboard"
      L70_1 = _ENV
      L71_1 = "Config"
      L70_1 = L70_1[L71_1]
      L71_1 = "controls"
      L70_1 = L70_1[L71_1]
      L71_1 = "volume3DDownKey"
      L70_1 = L70_1[L71_1]
      L66_1(L67_1, L68_1, L69_1, L70_1)
    end
  end
  function L66_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L1_2 = RadioState
    L1_2 = L1_2.power
    if not L1_2 then
      return
    end
    L1_2 = L47_1
    L1_2 = L1_2()
    if not L1_2 then
      return
    end
    L2_2 = L49_1
    L3_2 = Config
    L3_2 = L3_2.radioLayouts
    L4_2 = L1_2
    L2_2 = L2_2(L3_2, L4_2)
    if not L2_2 then
      return
    end
    L3_2 = nil
    if "up" == A0_2 then
      L3_2 = L2_2 + 1
      L4_2 = Config
      L4_2 = L4_2.radioLayouts
      L4_2 = #L4_2
      if L3_2 > L4_2 then
        L3_2 = 1
      end
    else
      L3_2 = L2_2 - 1
      if L3_2 < 1 then
        L4_2 = Config
        L4_2 = L4_2.radioLayouts
        L3_2 = #L4_2
      end
    end
    L4_2 = nil
    if "up" == A0_2 then
      while true do
        L5_2 = Config
        L5_2 = L5_2.radioLayouts
        L5_2 = #L5_2
        if not (L3_2 <= L5_2) then
          break
        end
        L5_2 = Config
        L5_2 = L5_2.radioLayouts
        L4_2 = L5_2[L3_2]
        if nil ~= L4_2 then
          break
        end
        L3_2 = L3_2 + 1
      end
      if nil == L4_2 then
        L3_2 = 1
        while true do
          L5_2 = Config
          L5_2 = L5_2.radioLayouts
          L5_2 = #L5_2
          if not (L3_2 <= L5_2) then
            break
          end
          L5_2 = Config
          L5_2 = L5_2.radioLayouts
          L4_2 = L5_2[L3_2]
          if nil ~= L4_2 then
            break
          end
          L3_2 = L3_2 + 1
        end
      end
    else
      while L3_2 >= 1 do
        L5_2 = Config
        L5_2 = L5_2.radioLayouts
        L4_2 = L5_2[L3_2]
        if nil ~= L4_2 then
          break
        end
        L3_2 = L3_2 - 1
      end
      if nil == L4_2 then
        L5_2 = Config
        L5_2 = L5_2.radioLayouts
        L3_2 = #L5_2
        while L3_2 >= 1 do
          L5_2 = Config
          L5_2 = L5_2.radioLayouts
          L4_2 = L5_2[L3_2]
          if nil ~= L4_2 then
            break
          end
          L3_2 = L3_2 - 1
        end
      end
    end
    if nil == L4_2 then
      return
    end
    L5_2 = L45_1
    L5_2 = L5_2()
    if "Handheld" == L5_2 then
      L6_2 = RadioState
      L6_2 = L6_2.handheldPos
      if not L6_2 then
        L6_2 = {}
        L6_2.x = 0
        L6_2.y = 0
        L6_2.s = 0
      end
      L7_2 = Settings
      L7_2 = L7_2.saveSetting
      L8_2 = "radioHandheldModel"
      L9_2 = json
      L9_2 = L9_2.encode
      L10_2 = {}
      L10_2.model = L4_2
      L11_2 = L6_2.x
      L10_2.x = L11_2
      L11_2 = L6_2.y
      L10_2.y = L11_2
      L11_2 = L6_2.s
      L10_2.s = L11_2
      L9_2, L10_2, L11_2 = L9_2(L10_2)
      L7_2(L8_2, L9_2, L10_2, L11_2)
      L7_2 = RadioState
      L7_2.handheldModel = L4_2
    else
      L6_2 = L46_1
      L6_2 = L6_2()
      if L6_2 then
        L7_2 = Settings
        L7_2 = L7_2.saveVehicleSpawnCodeModel
        L8_2 = L6_2
        L9_2 = L4_2
        L7_2(L8_2, L9_2)
      end
      L7_2 = Settings
      L7_2 = L7_2.loadModelPosition
      L8_2 = L4_2
      L7_2 = L7_2(L8_2)
      if not L7_2 then
        L8_2 = {}
        L8_2.x = 0
        L8_2.y = 0
        L8_2.s = 0
        L7_2 = L8_2
      end
      L8_2 = setRadioPosition
      L9_2 = L7_2
      L8_2(L9_2)
    end
    L6_2 = L41_1
    if L6_2 then
      L6_2 = L41_1.settings
      if L6_2 then
        L6_2 = L41_1.settings
        L6_2 = L6_2.getCurrentOption
        if L6_2 then
          L6_2 = L41_1.settings
          L6_2 = L6_2.getCurrentOption
          L6_2 = L6_2()
          if L6_2 then
            L7_2 = L6_2.key
            if "radioModel" == L7_2 then
              L6_2.value = L4_2
            end
          end
        end
      end
    end
    L6_2 = L42_1
    L6_2()
    L6_2 = setRadioConfig
    L7_2 = L4_2
    L6_2(L7_2)
    L6_2 = showAlert
    L7_2 = "Style: "
    L8_2 = L4_2
    L7_2 = L7_2 .. L8_2
    L6_2(L7_2)
    L6_2 = Radio
    L6_2 = L6_2.playTone
    L7_2 = "beep"
    L6_2(L7_2)
  end
  L67_1 = _ENV
  L68_1 = "RegisterCommand"
  L67_1 = L67_1[L68_1]
  L68_1 = "+radio_styleUp"
  function L69_1()
    local L0_2, L1_2
    L0_2 = L66_1
    L1_2 = "up"
    L0_2(L1_2)
  end
  L70_1 = false
  L67_1(L68_1, L69_1, L70_1)
  L67_1 = _ENV
  L68_1 = "RegisterCommand"
  L67_1 = L67_1[L68_1]
  L68_1 = "-radio_styleUp"
  function L69_1()
    local L0_2, L1_2
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "Config"
  L67_1 = L67_1[L68_1]
  L68_1 = "controls"
  L67_1 = L67_1[L68_1]
  L68_1 = "styleUpKey"
  L67_1 = L67_1[L68_1]
  L68_1 = nil
  if L67_1 ~= L68_1 then
    L67_1 = _ENV
    L68_1 = "Config"
    L67_1 = L67_1[L68_1]
    L68_1 = "controls"
    L67_1 = L67_1[L68_1]
    L68_1 = "styleUpKey"
    L67_1 = L67_1[L68_1]
    L68_1 = ""
    if L67_1 ~= L68_1 then
      L67_1 = _ENV
      L68_1 = "RegisterKeyMapping"
      L67_1 = L67_1[L68_1]
      L68_1 = "+radio_styleUp"
      L69_1 = "Radio Style Up"
      L70_1 = "keyboard"
      L71_1 = _ENV
      L72_1 = "Config"
      L71_1 = L71_1[L72_1]
      L72_1 = "controls"
      L71_1 = L71_1[L72_1]
      L72_1 = "styleUpKey"
      L71_1 = L71_1[L72_1]
      L67_1(L68_1, L69_1, L70_1, L71_1)
    end
  end
  L67_1 = _ENV
  L68_1 = "RegisterCommand"
  L67_1 = L67_1[L68_1]
  L68_1 = "+radio_styleDown"
  function L69_1()
    local L0_2, L1_2
    L0_2 = L66_1
    L1_2 = "down"
    L0_2(L1_2)
  end
  L70_1 = false
  L67_1(L68_1, L69_1, L70_1)
  L67_1 = _ENV
  L68_1 = "RegisterCommand"
  L67_1 = L67_1[L68_1]
  L68_1 = "-radio_styleDown"
  function L69_1()
    local L0_2, L1_2
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "Config"
  L67_1 = L67_1[L68_1]
  L68_1 = "controls"
  L67_1 = L67_1[L68_1]
  L68_1 = "styleDownKey"
  L67_1 = L67_1[L68_1]
  L68_1 = nil
  if L67_1 ~= L68_1 then
    L67_1 = _ENV
    L68_1 = "Config"
    L67_1 = L67_1[L68_1]
    L68_1 = "controls"
    L67_1 = L67_1[L68_1]
    L68_1 = "styleDownKey"
    L67_1 = L67_1[L68_1]
    L68_1 = ""
    if L67_1 ~= L68_1 then
      L67_1 = _ENV
      L68_1 = "RegisterKeyMapping"
      L67_1 = L67_1[L68_1]
      L68_1 = "+radio_styleDown"
      L69_1 = "Radio Style Down"
      L70_1 = "keyboard"
      L71_1 = _ENV
      L72_1 = "Config"
      L71_1 = L71_1[L72_1]
      L72_1 = "controls"
      L71_1 = L71_1[L72_1]
      L72_1 = "styleDownKey"
      L71_1 = L71_1[L72_1]
      L67_1(L68_1, L69_1, L70_1, L71_1)
    end
  end
  L67_1 = _ENV
  L68_1 = "dispUpdate"
  function L69_1(A0_2, A1_2, A2_2, A3_2, A4_2, A5_2, A6_2, A7_2, A8_2)
    local L9_2, L10_2, L11_2, L12_2, L13_2, L14_2
    L12_2 = type
    function L13_2(A0_3)
      local L1_3
      if nil == A0_3 then
        return ""
      end
      L1_3 = L12_2(A0_3)
      if "function" == L1_3 then
        return ""
      end
      return tostring(A0_3)
    end
    L14_2 = A5_2
    if (nil == L14_2 or "" == L14_2) and "string" == L12_2(A7_2) and "" ~= A7_2 then
      L14_2 = A7_2
    end
    if (nil == A6_2 or "" == A6_2) and "string" == L12_2(A8_2) and "" ~= A8_2 then
      A6_2 = A8_2
    end
    L9_2 = SendNUIMessage
    L10_2 = {}
    L10_2.action = "dispUpdate"
    L11_2 = {}
    L11_2.btn01 = L13_2(A0_2)
    L11_2.btn02 = L13_2(A1_2)
    L11_2.btn03 = L13_2(A2_2)
    L11_2.btn04 = L13_2(A3_2)
    L11_2.btn05 = L13_2(A4_2)
    L11_2.ln01 = L13_2(L14_2)
    L11_2.ln02 = L13_2(A6_2)
    L10_2.display = L11_2
    L9_2(L10_2)
  end
  L67_1[L68_1] = L69_1
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setLED"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setLED"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setLED"
    L2_2.mode = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "btnPress"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = A0_2.btnID
    if not L2_2 then
      L2_2 = "home"
    end
    L3_2 = TriggerEvent
    L4_2 = "radioClient:btnPress"
    L5_2 = L2_2
    L3_2(L4_2, L5_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "savePosition"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L2_2 = L45_1
    L2_2 = L2_2()
    L3_2 = {}
    L4_2 = A0_2.x
    L3_2.x = L4_2
    L4_2 = A0_2.y
    L3_2.y = L4_2
    L4_2 = A0_2.scale
    L3_2.s = L4_2
    if "Handheld" == L2_2 then
      L4_2 = RadioState
      L4_2 = L4_2.handheldModel
      if L4_2 then
        L5_2 = Settings
        L5_2 = L5_2.saveModelPosition
        L6_2 = L4_2
        L7_2 = L3_2
        L5_2(L6_2, L7_2)
      end
    else
      L4_2 = L47_1
      L4_2 = L4_2()
      if L4_2 then
        L5_2 = Settings
        L5_2 = L5_2.saveModelPosition
        L6_2 = L4_2
        L7_2 = L3_2
        L5_2(L6_2, L7_2)
      end
    end
    L4_2 = A1_2
    L5_2 = "ok"
    L4_2(L5_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "releaseFocus"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = L31_1
    L2_2()
    L2_2 = L43_1
    L3_2 = "main"
    L2_2(L3_2)
    L2_2 = SetNuiFocus
    L3_2 = false
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = A1_2
    L3_2 = "ok"
    L2_2(L3_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "windowFocusRestored"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Window focus restored, checking radio state"
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = RadioState
    L2_2 = L2_2.open
    if L2_2 then
      L2_2 = RadioState
      L2_2 = L2_2.focused
      if L2_2 then
        L2_2 = SetNuiFocus
        L3_2 = true
        L4_2 = true
        L2_2(L3_2, L4_2)
        L2_2 = log
        L3_2 = "Restored NUI focus after window focus return"
        L4_2 = 4
        L2_2(L3_2, L4_2)
    end
    else
      L2_2 = SetNuiFocus
      L3_2 = false
      L4_2 = false
      L2_2(L3_2, L4_2)
      L2_2 = L31_1
      L2_2()
      L2_2 = log
      L3_2 = "Released NUI focus after window focus return"
      L4_2 = 4
      L2_2(L3_2, L4_2)
    end
    L2_2 = A1_2
    L3_2 = "ok"
    L2_2(L3_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "documentVisibilityRestored"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Document visibility restored, checking radio state"
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = RadioState
    L2_2 = L2_2.open
    if L2_2 then
      L2_2 = RadioState
      L2_2 = L2_2.focused
      if L2_2 then
        L2_2 = SendNUIMessage
        L3_2 = {}
        L3_2.action = "open"
        L2_2(L3_2)
        L2_2 = SetNuiFocus
        L3_2 = true
        L4_2 = true
        L2_2(L3_2, L4_2)
        L2_2 = log
        L3_2 = "Restored radio visibility and focus after document visibility return"
        L4_2 = 4
        L2_2(L3_2, L4_2)
    end
    else
      L2_2 = SendNUIMessage
      L3_2 = {}
      L3_2.action = "close"
      L2_2(L3_2)
      L2_2 = SetNuiFocus
      L3_2 = false
      L4_2 = false
      L2_2(L3_2, L4_2)
      L2_2 = L31_1
      L2_2()
      L2_2 = log
      L3_2 = "Ensured radio is hidden after document visibility return"
      L4_2 = 4
      L2_2(L3_2, L4_2)
    end
    L2_2 = A1_2
    L3_2 = "ok"
    L2_2(L3_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "releaseFocusToMain"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Escape key pressed - releasing focus and returning to main page"
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = L43_1
    L3_2 = "main"
    L2_2(L3_2)
    L2_2 = SetNuiFocus
    L3_2 = false
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = RadioState
    L2_2.focused = false
    L2_2 = L31_1
    L2_2()
    L2_2 = log
    L3_2 = "Radio remains open but focus released and returned to main page"
    L4_2 = 4
    L2_2(L3_2, L4_2)
    L2_2 = A1_2
    L3_2 = "ok"
    L2_2(L3_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "setAvailableMicrophones"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = A0_2.microphones
    if L2_2 then
      L2_2 = RadioState
      L3_2 = A0_2.microphones
      L2_2.availableMicrophones = L3_2
      L2_2 = log
      L3_2 = "Received available microphones: "
      L4_2 = json
      L4_2 = L4_2.encode
      L5_2 = A0_2.microphones
      L4_2 = L4_2(L5_2)
      L3_2 = L3_2 .. L4_2
      L4_2 = 3
      L2_2(L3_2, L4_2)
      L2_2 = A0_2.microphones
      L2_2 = #L2_2
      if 0 == L2_2 then
        L2_2 = log
        L3_2 = "No microphones available - user may need to check microphone setup"
        L4_2 = 2
        L2_2(L3_2, L4_2)
        L2_2 = showAlert
        L3_2 = "No microphones detected. Check mic setup."
        L2_2(L3_2)
      else
        L2_2 = log
        L3_2 = "Found "
        L4_2 = A0_2.microphones
        L4_2 = #L4_2
        L5_2 = " microphone(s)"
        L3_2 = L3_2 .. L4_2 .. L5_2
        L4_2 = 3
        L2_2(L3_2, L4_2)
      end
    end
    if A1_2 then
      L2_2 = A1_2
      L3_2 = "ok"
      L2_2(L3_2)
    end
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "requestSelectedMicrophone"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = RadioState
    L2_2 = L2_2.selectedMicrophone
    if not L2_2 then
      L2_2 = {}
      L2_2.deviceId = "default"
      L2_2.label = "Default Microphone"
    end
    L3_2 = A1_2
    L4_2 = L2_2
    L3_2(L4_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "microphoneError"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = A0_2.message
    if not L2_2 then
      L2_2 = "Microphone error: "
      L3_2 = A0_2.error
      if not L3_2 then
        L3_2 = "Unknown error"
      end
      L2_2 = L2_2 .. L3_2
    end
    L3_2 = log
    L4_2 = "Microphone error: "
    L5_2 = A0_2.error
    if not L5_2 then
      L5_2 = "Unknown"
    end
    L6_2 = " - "
    L7_2 = A0_2.fullError
    if not L7_2 then
      L7_2 = "No details"
    end
    L4_2 = L4_2 .. L5_2 .. L6_2 .. L7_2
    L5_2 = 1
    L3_2(L4_2, L5_2)
    L3_2 = TriggerEvent
    L4_2 = "chat:addMessage"
    L5_2 = {}
    L6_2 = {}
    L7_2 = 255
    L8_2 = 0
    L9_2 = 0
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L6_2[3] = L9_2
    L5_2.color = L6_2
    L5_2.multiline = true
    L6_2 = {}
    L7_2 = "Radio System"
    L8_2 = L2_2
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L5_2.args = L6_2
    L3_2(L4_2, L5_2)
    L3_2 = showAlert
    L4_2 = "Mic Error: "
    L5_2 = A0_2.error
    if not L5_2 then
      L5_2 = "Unknown"
    end
    L4_2 = L4_2 .. L5_2
    L3_2(L4_2)
    L3_2 = A1_2
    L4_2 = "ok"
    L3_2(L4_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "microphoneSetupComplete"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = A0_2.success
    if L2_2 then
      L2_2 = log
      L3_2 = "Microphone setup completed successfully"
      L4_2 = 3
      L2_2(L3_2, L4_2)
    else
      L2_2 = log
      L3_2 = "Microphone setup failed: "
      L4_2 = A0_2.error
      if not L4_2 then
        L4_2 = "Unknown error"
      end
      L3_2 = L3_2 .. L4_2
      L4_2 = 2
      L2_2(L3_2, L4_2)
      L2_2 = showAlert
      L3_2 = "Mic setup failed: "
      L4_2 = A0_2.error
      if not L4_2 then
        L4_2 = "Unknown"
      end
      L3_2 = L3_2 .. L4_2
      L2_2(L3_2)
    end
    if A1_2 then
      L2_2 = A1_2
      L3_2 = "ok"
      L2_2(L3_2)
    end
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "radioReconnecting"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L2_2 = A0_2.attempt
    if not L2_2 then
      L2_2 = 1
    end
    L3_2 = A0_2.maxAttempts
    if not L3_2 then
      L3_2 = 5
    end
    L4_2 = log
    L5_2 = "Radio manual reconnection attempt "
    L6_2 = L2_2
    L7_2 = "/"
    L8_2 = L3_2
    L5_2 = L5_2 .. L6_2 .. L7_2 .. L8_2
    L6_2 = 2
    L4_2(L5_2, L6_2)
    L4_2 = A1_2
    L5_2 = "ok"
    L4_2(L5_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "radioReconnected"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = log
    L3_2 = "Radio successfully reconnected after manual attempts"
    L4_2 = 3
    L2_2(L3_2, L4_2)
    L2_2 = A1_2
    L3_2 = "ok"
    L2_2(L3_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "radioPowerOff"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = A0_2.reason
    if not L2_2 then
      L2_2 = "Connection lost"
    end
    L3_2 = TriggerEvent
    L4_2 = "chat:addMessage"
    L5_2 = {}
    L6_2 = {}
    L7_2 = 255
    L8_2 = 0
    L9_2 = 0
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L6_2[3] = L9_2
    L5_2.color = L6_2
    L5_2.multiline = true
    L6_2 = {}
    L7_2 = "Radio System"
    L8_2 = "Radio powered off: "
    L9_2 = L2_2
    L8_2 = L8_2 .. L9_2
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L5_2.args = L6_2
    L3_2(L4_2, L5_2)
    L3_2 = log
    L4_2 = "Radio powered off due to connection failure: "
    L5_2 = L2_2
    L4_2 = L4_2 .. L5_2
    L5_2 = 2
    L3_2(L4_2, L5_2)
    L3_2 = RadioState
    L3_2 = L3_2.power
    if L3_2 then
      L3_2 = L53_1
      L3_2()
    end
    L3_2 = A1_2
    L4_2 = "ok"
    L3_2(L4_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "radioError"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L2_2 = A0_2.error
    if not L2_2 then
      L2_2 = "Unknown radio error"
    end
    L3_2 = string
    L3_2 = L3_2.find
    L5_2 = L2_2
    L4_2 = L2_2.lower
    L4_2 = L4_2(L5_2)
    L5_2 = "connect"
    L3_2 = L3_2(L4_2, L5_2)
    if not L3_2 then
      L3_2 = string
      L3_2 = L3_2.find
      L5_2 = L2_2
      L4_2 = L2_2.lower
      L4_2 = L4_2(L5_2)
      L5_2 = "connection"
      L3_2 = L3_2(L4_2, L5_2)
      if not L3_2 then
        L3_2 = string
        L3_2 = L3_2.find
        L5_2 = L2_2
        L4_2 = L2_2.lower
        L4_2 = L4_2(L5_2)
        L5_2 = "lost"
        L3_2 = L3_2(L4_2, L5_2)
        if not L3_2 then
          goto lbl_48
        end
      end
    end
    L3_2 = TriggerEvent
    L4_2 = "chat:addMessage"
    L5_2 = {}
    L6_2 = {}
    L7_2 = 255
    L8_2 = 165
    L9_2 = 0
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L6_2[3] = L9_2
    L5_2.color = L6_2
    L5_2.multiline = true
    L6_2 = {}
    L7_2 = "Radio System"
    L8_2 = L2_2
    L6_2[1] = L7_2
    L6_2[2] = L8_2
    L5_2.args = L6_2
    L3_2(L4_2, L5_2)
    ::lbl_48::
    L3_2 = log
    L4_2 = "Radio error: "
    L5_2 = L2_2
    L4_2 = L4_2 .. L5_2
    L5_2 = 1
    L3_2(L4_2, L5_2)
    L3_2 = A1_2
    L4_2 = "ok"
    L3_2(L4_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setRadioConfig"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setRadioConfig"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setRadioConfig
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setRadioConfig"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setRadioConfig
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setVolume"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setVolume"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setVolume
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setToneVolume"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setToneVolume"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setToneVolume
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setVolume"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setVolume
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setToneVolume"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setToneVolume
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "setBatt"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setBatt"
    L2_2.status = A0_2
    L1_2(L2_2)
  end
  L67_1[L68_1] = L69_1
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setBatt"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setBatt"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setBatt
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setBatt"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setBatt
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "setScan"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setScan"
    L2_2.status = A0_2
    L1_2(L2_2)
  end
  L67_1[L68_1] = L69_1
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setScan"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setScan"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setScan
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setScan"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setScan
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "setSignal"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setSignal"
    L2_2.status = A0_2
    L1_2(L2_2)
  end
  L67_1[L68_1] = L69_1
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setSignal"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setSignal"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setSignal
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setSignal"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setSignal
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "setGPS"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setGPS"
    L2_2.status = A0_2
    L1_2(L2_2)
  end
  L67_1[L68_1] = L69_1
  L67_1 = _ENV
  L68_1 = "setTrunk"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setTrunk"
    L2_2.status = A0_2
    L1_2(L2_2)
  end
  L67_1[L68_1] = L69_1
  L67_1 = _ENV
  L68_1 = "showAlert"
  function L69_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2
    if not A1_2 then
      A1_2 = "none"
    end
    if not A2_2 and "none" == A1_2 then
      A2_2 = "black"
    end
    if not A2_2 then
      A2_2 = "white"
    end
    L3_2 = SendNUIMessage
    L4_2 = {}
    L4_2.action = "alert"
    L4_2.message = A0_2
    L4_2.mode = A1_2
    L4_2.textColor = A2_2
    L3_2(L4_2)
  end
  L67_1[L68_1] = L69_1
  L67_1 = RegisterNetEvent
  L68_1 = "radioClient:setGPS"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radioClient:setGPS"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setGPS
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setGPS"
  function L69_1(A0_2)
    local L1_2, L2_2
    L1_2 = setGPS
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNUICallback
  L68_1 = "releaseFocus"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = L43_1
    L3_2 = "main"
    L2_2(L3_2)
    L2_2 = SetNuiFocus
    L3_2 = false
    L4_2 = false
    L2_2(L3_2, L4_2)
    L2_2 = L31_1
    L2_2()
    L2_2 = RadioState
    L2_2.moveMode = false
    L2_2 = RadioState
    L2_2.focused = false
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "GetDistanceToNearestTower"
  function L69_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = GetEntityCoords
    L2_2 = L0_2
    L1_2 = L1_2(L2_2)
    L2_2 = math
    L2_2 = L2_2.huge
    L3_2 = ipairs
    L4_2 = L5_1
    L3_2, L4_2, L5_2, L6_2 = L3_2(L4_2)
    for L7_2, L8_2 in L3_2, L4_2, L5_2, L6_2 do
      L9_2 = vector3
      L10_2 = L8_2.x
      L11_2 = L8_2.y
      L12_2 = L8_2.z
      L9_2 = L9_2(L10_2, L11_2, L12_2)
      L9_2 = L1_2 - L9_2
      L9_2 = #L9_2
      if L2_2 > L9_2 then
        L2_2 = L9_2
      end
    end
    return L2_2
  end
  L67_1[L68_1] = L69_1
  L67_1 = _ENV
  L68_1 = "GetSignalStrength"
  function L69_1()
    local L0_2, L1_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      L0_2 = "hidden"
      return L0_2
    end
    L0_2 = GetDistanceToNearestTower
    L0_2 = L0_2()
    L1_2 = 500
    if L0_2 <= L1_2 then
      L1_2 = 5
      return L1_2
    else
      L1_2 = 1000
      if L0_2 <= L1_2 then
        L1_2 = 4
        return L1_2
      else
        L1_2 = 2000
        if L0_2 <= L1_2 then
          L1_2 = 3
          return L1_2
        else
          L1_2 = 4000
          if L0_2 <= L1_2 then
            L1_2 = 2
            return L1_2
          else
            L1_2 = 1
            return L1_2
          end
        end
      end
    end
  end
  L67_1[L68_1] = L69_1
  L67_1 = _ENV
  L68_1 = "UpdateBatteryLevel"
  function L69_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L0_2 = GetGameTimer
    L0_2 = L0_2()
    L1_2 = L7_1
    L1_2 = L0_2 - L1_2
    L1_2 = L1_2 / 1000.0
    L7_1 = L0_2
    L2_2 = Config
    L2_2 = L2_2.batteryTick
    if L2_2 then
      L2_2 = type
      L3_2 = Config
      L3_2 = L3_2.batteryTick
      L2_2 = L2_2(L3_2)
      if "function" == L2_2 then
        L2_2 = Config
        L2_2 = L2_2.batteryTick
        L3_2 = L6_1
        L4_2 = L1_2
        L2_2 = L2_2(L3_2, L4_2)
        L6_1 = L2_2
        L2_2 = math
        L2_2 = L2_2.max
        L3_2 = 0.0
        L4_2 = math
        L4_2 = L4_2.min
        L5_2 = 100.0
        L6_2 = L6_1
        L4_2 = L4_2(L5_2, L6_2)
        L2_2 = L2_2(L3_2, L4_2)
        L6_1 = L2_2
      end
    end
  end
  L67_1[L68_1] = L69_1
  L67_1 = RegisterNetEvent
  L68_1 = "radio:stopAllSirens"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radio:stopAllSirens"
  function L69_1()
    local L0_2, L1_2
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "stopAllSirens"
    L0_2(L1_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "GetBatteryDisplayLevel"
  function L69_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = RadioState
    L0_2 = L0_2.power
    if not L0_2 then
      L0_2 = "hidden"
      return L0_2
    end
    L0_2 = PlayerPedId
    L0_2 = L0_2()
    L1_2 = GetVehiclePedIsIn
    L2_2 = L0_2
    L3_2 = false
    L1_2 = L1_2(L2_2, L3_2)
    if 0 ~= L1_2 then
      L2_2 = L6_1
      if L2_2 < 75 then
        L2_2 = "c"
        return L2_2
      end
    end
    L2_2 = L6_1
    if L2_2 >= 80 then
      L2_2 = 5
      return L2_2
    else
      L2_2 = L6_1
      if L2_2 >= 60 then
        L2_2 = 4
        return L2_2
      else
        L2_2 = L6_1
        if L2_2 >= 40 then
          L2_2 = 3
          return L2_2
        else
          L2_2 = L6_1
          if L2_2 >= 20 then
            L2_2 = 2
            return L2_2
          else
            L2_2 = L6_1
            if L2_2 > 0 then
              L2_2 = 1
              return L2_2
            else
              L2_2 = 0
              return L2_2
            end
          end
        end
      end
    end
  end
  L67_1[L68_1] = L69_1
  L67_1 = _ENV
  L68_1 = "Citizen"
  L67_1 = L67_1[L68_1]
  L67_1 = L67_1.CreateThread
  function L68_1()
    local L0_2, L1_2
    while true do
      L0_2 = RadioState
      L0_2 = L0_2.power
      if L0_2 then
        L0_2 = UpdateBatteryLevel
        L0_2()
        L0_2 = L42_1
        L0_2()
      end
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 5000
      L0_2(L1_2)
    end
  end
  L67_1(L68_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "getBatteryLevel"
  function L69_1()
    local L0_2, L1_2
    L0_2 = L6_1
    return L0_2
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setBatteryLevel"
  function L69_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2
    L1_2 = math
    L1_2 = L1_2.max
    L2_2 = 0.0
    L3_2 = math
    L3_2 = L3_2.min
    L4_2 = 100.0
    L5_2 = A0_2
    L3_2, L4_2, L5_2 = L3_2(L4_2, L5_2)
    L1_2 = L1_2(L2_2, L3_2, L4_2, L5_2)
    L6_1 = L1_2
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "getSignalStrength"
  function L69_1()
    local L0_2, L1_2
    L0_2 = GetSignalStrength
    return L0_2()
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "addSignalTower"
  function L69_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2
    L3_2 = table
    L3_2 = L3_2.insert
    L4_2 = L5_1
    L5_2 = {}
    L5_2.x = A0_2
    L5_2.y = A1_2
    L5_2.z = A2_2
    L3_2(L4_2, L5_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "getSignalTowers"
  function L69_1()
    local L0_2, L1_2
    L0_2 = table
    L0_2 = L0_2.deepcopy
    L1_2 = L5_1
    return L0_2(L1_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "exports"
  L67_1 = L67_1[L68_1]
  L68_1 = "setSignalTowers"
  function L69_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L1_2 = type
    L2_2 = A0_2
    L1_2 = L1_2(L2_2)
    if "table" ~= L1_2 then
      L1_2 = false
      return L1_2
    end
    L1_2 = {}
    L2_2 = ipairs
    L3_2 = A0_2
    L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
    for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
      if L7_2 and L7_2.x and L7_2.y and L7_2.z then
        L8_2 = table
        L8_2 = L8_2.insert
        L9_2 = {}
        L9_2.x = L7_2.x
        L9_2.y = L7_2.y
        L9_2.z = L7_2.z
        L8_2(L1_2, L9_2)
      end
    end
    L5_1 = L1_2
    L2_2 = true
    return L2_2
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNetEvent
  L68_1 = "radio:showDispatchAlert"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radio:showDispatchAlert"
  function L69_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L1_2 = "none"
    L2_2 = "black"
    L3_2 = A0_2.type
    if "Information Alert" == L3_2 then
      L1_2 = "#0066cc"
      L2_2 = "white"
    else
      L3_2 = A0_2.type
      if "Priority Alert" == L3_2 then
        L1_2 = "#ba8c00"
        L2_2 = "white"
      else
        L3_2 = A0_2.type
        if "Emergency Alert" == L3_2 then
          L1_2 = "#ba0000"
          L2_2 = "white"
        end
      end
    end
    L3_2 = showAlert
    L4_2 = A0_2.message
    L5_2 = L1_2
    L6_2 = L2_2
    L3_2(L4_2, L5_2, L6_2)
    L3_2 = Citizen
    L3_2 = L3_2.SetTimeout
    L4_2 = 3000
    function L5_2()
      local L0_3, L1_3, L2_3, L3_3
      L0_3 = showAlert
      L1_3 = A0_2.message
      L2_3 = L1_2
      L3_3 = L2_2
      L0_3(L1_3, L2_3, L3_3)
    end
    L3_2(L4_2, L5_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = RegisterNetEvent
  L68_1 = "radio:playTone"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radio:playTone"
  function L69_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = Radio
    L2_2 = L2_2.playTone
    L4_2 = A1_2
    L3_2 = A1_2.lower
    L3_2, L4_2 = L3_2(L4_2)
    L2_2(L3_2, L4_2)
  end
  L67_1(L68_1, L69_1)
  L67_1 = _ENV
  L68_1 = "RegisterCommand"
  L67_1 = L67_1[L68_1]
  L68_1 = "rtest3d"
  function L69_1(A0_2, A1_2, A2_2)
    local L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2
    L3_2 = A1_2[1]
    if not L3_2 then
      L4_2 = L21_1
      L4_2 = not L4_2
      L21_1 = L4_2
      L4_2 = log
      L5_2 = "3D Self-Hearing Debug Mode: "
      L6_2 = tostring
      L7_2 = L21_1
      L6_2 = L6_2(L7_2)
      L5_2 = L5_2 .. L6_2
      L6_2 = 4
      L4_2(L5_2, L6_2)
      L4_2 = TriggerEvent
      L5_2 = "chat:addMessage"
      L6_2 = {}
      L7_2 = {}
      L8_2 = 255
      L9_2 = 255
      L10_2 = 0
      L7_2[1] = L8_2
      L7_2[2] = L9_2
      L7_2[3] = L10_2
      L6_2.color = L7_2
      L6_2.multiline = true
      L7_2 = {}
      L8_2 = "Radio System"
      L9_2 = "3D Self-Hearing Debug Mode: "
      L10_2 = tostring
      L11_2 = L21_1
      L10_2 = L10_2(L11_2)
      L9_2 = L9_2 .. L10_2
      L7_2[1] = L8_2
      L7_2[2] = L9_2
      L6_2.args = L7_2
      L4_2(L5_2, L6_2)
      L4_2 = TriggerServerEvent
      L5_2 = "radio:set3DSelfHearingDebug"
      L6_2 = L21_1
      L4_2(L5_2, L6_2)
      return
    end
    L4_2 = radioSystemAccess
    if L4_2 then
      L4_2 = RadioState
      L4_2 = L4_2.power
      if L4_2 then
        L4_2 = RadioState
        L4_2 = L4_2.earbudsEnabled
        if not L4_2 then
          goto lbl_59
        end
      end
    end
    L4_2 = log
    L5_2 = "Cannot test 3D audio - radio off, earbuds enabled, or no radio access"
    L6_2 = 2
    L4_2(L5_2, L6_2)
    do return end
    ::lbl_59::
    L4_2 = nil
    L5_2 = playerOwnedVehicle
    if L5_2 then
      L5_2 = DoesEntityExist
      L6_2 = playerOwnedVehicle
      L5_2 = L5_2(L6_2)
      if L5_2 then
        L5_2 = VehToNet
        L6_2 = playerOwnedVehicle
        L5_2 = L5_2(L6_2)
        L4_2 = L5_2
      end
    end
    L5_2 = string
    L5_2 = L5_2.lower
    L6_2 = L3_2
    L5_2 = L5_2(L6_2)
    L3_2 = L5_2
    if "tone" == L3_2 or "beep" == L3_2 then
      L5_2 = TriggerServerEvent
      L6_2 = "radio:3DPlayTone"
      L7_2 = "beep"
      L8_2 = RadioState
      L8_2 = L8_2.toneVolume
      if not L8_2 then
        L8_2 = 50
      end
      L9_2 = L4_2
      L5_2(L6_2, L7_2, L8_2, L9_2)
      L5_2 = log
      L6_2 = "Triggered 3D tone test"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "chat:addMessage"
      L7_2 = {}
      L8_2 = {}
      L9_2 = 255
      L10_2 = 255
      L11_2 = 0
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L8_2[3] = L11_2
      L7_2.color = L8_2
      L7_2.multiline = true
      L8_2 = {}
      L9_2 = "Radio System"
      L10_2 = "3D Tone Test Triggered"
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L7_2.args = L8_2
      L5_2(L6_2, L7_2)
    elseif "siren" == L3_2 then
      L5_2 = TriggerServerEvent
      L6_2 = "radio:3DSirenStarted"
      L7_2 = L4_2
      L5_2(L6_2, L7_2)
      L5_2 = log
      L6_2 = "Triggered 3D siren test (5 seconds)"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "chat:addMessage"
      L7_2 = {}
      L8_2 = {}
      L9_2 = 255
      L10_2 = 255
      L11_2 = 0
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L8_2[3] = L11_2
      L7_2.color = L8_2
      L7_2.multiline = true
      L8_2 = {}
      L9_2 = "Radio System"
      L10_2 = "3D Siren Test Triggered"
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L7_2.args = L8_2
      L5_2(L6_2, L7_2)
      L5_2 = Citizen
      L5_2 = L5_2.SetTimeout
      L6_2 = 5000
      function L7_2()
        local L0_3, L1_3, L2_3
        L0_3 = TriggerServerEvent
        L1_3 = "radio:3DSirenStopped"
        L2_3 = L4_2
        L0_3(L1_3, L2_3)
      end
      L5_2(L6_2, L7_2)
    elseif "heli" == L3_2 or "helicopter" == L3_2 then
      L5_2 = TriggerServerEvent
      L6_2 = "radio:3DHeliStarted"
      L7_2 = L4_2
      L5_2(L6_2, L7_2)
      L5_2 = log
      L6_2 = "Triggered 3D helicopter test (5 seconds)"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "chat:addMessage"
      L7_2 = {}
      L8_2 = {}
      L9_2 = 255
      L10_2 = 255
      L11_2 = 0
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L8_2[3] = L11_2
      L7_2.color = L8_2
      L7_2.multiline = true
      L8_2 = {}
      L9_2 = "Radio System"
      L10_2 = "3D Helicopter Test Triggered"
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L7_2.args = L8_2
      L5_2(L6_2, L7_2)
      L5_2 = Citizen
      L5_2 = L5_2.SetTimeout
      L6_2 = 5000
      function L7_2()
        local L0_3, L1_3, L2_3
        L0_3 = TriggerServerEvent
        L1_3 = "radio:3DHeliStopped"
        L2_3 = L4_2
        L0_3(L1_3, L2_3)
      end
      L5_2(L6_2, L7_2)
    elseif "gunshot" == L3_2 or "gun" == L3_2 then
      L5_2 = TriggerServerEvent
      L6_2 = "radio:3DGunshot"
      L7_2 = 0.5
      L8_2 = L4_2
      L5_2(L6_2, L7_2, L8_2)
      L5_2 = log
      L6_2 = "Triggered 3D gunshot test"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "chat:addMessage"
      L7_2 = {}
      L8_2 = {}
      L9_2 = 255
      L10_2 = 255
      L11_2 = 0
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L8_2[3] = L11_2
      L7_2.color = L8_2
      L7_2.multiline = true
      L8_2 = {}
      L9_2 = "Radio System"
      L10_2 = "3D Gunshot Test Triggered"
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L7_2.args = L8_2
      L5_2(L6_2, L7_2)
    elseif "transmission" == L3_2 or "trans" == L3_2 then
      L5_2 = TriggerServerEvent
      L6_2 = "radio:3DTransmissionStarted"
      L7_2 = L4_2
      L5_2(L6_2, L7_2)
      L5_2 = log
      L6_2 = "Triggered 3D transmission test (3 seconds)"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "chat:addMessage"
      L7_2 = {}
      L8_2 = {}
      L9_2 = 255
      L10_2 = 255
      L11_2 = 0
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L8_2[3] = L11_2
      L7_2.color = L8_2
      L7_2.multiline = true
      L8_2 = {}
      L9_2 = "Radio System"
      L10_2 = "3D Transmission Test Triggered"
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L7_2.args = L8_2
      L5_2(L6_2, L7_2)
      L5_2 = Citizen
      L5_2 = L5_2.SetTimeout
      L6_2 = 3000
      function L7_2()
        local L0_3, L1_3, L2_3
        L0_3 = TriggerServerEvent
        L1_3 = "radio:3DTransmissionStopped"
        L2_3 = L4_2
        L0_3(L1_3, L2_3)
      end
      L5_2(L6_2, L7_2)
    else
      L5_2 = log
      L6_2 = "Unknown sound type. Available: tone, siren, heli, gunshot, transmission"
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = TriggerEvent
      L6_2 = "chat:addMessage"
      L7_2 = {}
      L8_2 = {}
      L9_2 = 255
      L10_2 = 0
      L11_2 = 0
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L8_2[3] = L11_2
      L7_2.color = L8_2
      L7_2.multiline = true
      L8_2 = {}
      L9_2 = "Radio System"
      L10_2 = "Unknown sound type. Available: tone, siren, heli, gunshot, transmission"
      L8_2[1] = L9_2
      L8_2[2] = L10_2
      L7_2.args = L8_2
      L5_2(L6_2, L7_2)
    end
  end
  L70_1 = false
  L67_1(L68_1, L69_1, L70_1)
  L67_1 = RegisterNetEvent
  L68_1 = "radio:set3DSelfHearingDebug"
  L67_1(L68_1)
  L67_1 = AddEventHandler
  L68_1 = "radio:set3DSelfHearingDebug"
  function L69_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L1_2 = source
    L2_2 = log
    L3_2 = "Received 3D self-hearing debug event from player "
    L4_2 = L1_2
    L5_2 = " with value: "
    L6_2 = tostring
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L4_2 = 1
    L2_2(L3_2, L4_2)
    L2_2 = L2_1
    L2_2[L1_2] = A0_2
    L2_2 = log
    L3_2 = "Player "
    L4_2 = L1_2
    L5_2 = " set 3D self-hearing debug to: "
    L6_2 = tostring
    L7_2 = A0_2
    L6_2 = L6_2(L7_2)
    L3_2 = L3_2 .. L4_2 .. L5_2 .. L6_2
    L4_2 = 1
    L2_2(L3_2, L4_2)
  end
  L67_1(L68_1, L69_1)
end
