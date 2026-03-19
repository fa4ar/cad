local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1, L8_1, L9_1, L10_1, L11_1
L0_1 = {}
Blips = L0_1
L0_1 = {}
L0_1.groundSprite = 1
L0_1.carSprite = 56
L0_1.heliSprite = 422
L0_1.boatSprite = 427
L0_1.planeSprite = 423
L0_1.color = 38
L0_1.flashColor = 75
L1_1 = {}
L2_1 = "foot"
L3_1 = "car"
L1_1[1] = L2_1
L1_1[2] = L3_1
L0_1.showHeading = L1_1
gpsDefaults = L0_1
function L0_1(A0_2, A1_2)
  local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
  if A1_2 then
    L2_2 = A1_2.zone
    if L2_2 then
      L2_2 = A1_2.channel
      if L2_2 then
        goto lbl_11
      end
    end
  end
  L2_2 = false
  do return L2_2 end
  ::lbl_11::
  L2_2 = Config
  L2_2 = L2_2.zones
  L3_2 = A1_2.zone
  L2_2 = L2_2[L3_2]
  L3_2 = L2_2 or L3_2
  if L2_2 then
    L3_2 = L2_2.Channels
    L4_2 = A1_2.channel
    L3_2 = L3_2[L4_2]
  end
  if not L3_2 then
    L4_2 = false
    return L4_2
  end
  L4_2 = L3_2.gps
  if L4_2 then
    L4_2 = L3_2.gps
    L4_2 = L4_2.visibleToNacs
    if L4_2 then
      L4_2 = ipairs
      L5_2 = L3_2.gps
      L5_2 = L5_2.visibleToNacs
      L4_2, L5_2, L6_2, L7_2 = L4_2(L5_2)
      for L8_2, L9_2 in L4_2, L5_2, L6_2, L7_2 do
        L10_2 = tonumber
        L11_2 = L9_2
        L10_2 = L10_2(L11_2)
        L11_2 = tonumber
        L12_2 = A0_2
        L11_2 = L11_2(L12_2)
        if L10_2 == L11_2 then
          L10_2 = true
          return L10_2
        end
      end
      L4_2 = false
      return L4_2
    end
  end
  L4_2 = L3_2.nac
  if L4_2 then
    L4_2 = tonumber
    L5_2 = L3_2.nac
    L4_2 = L4_2(L5_2)
    L5_2 = tonumber
    L6_2 = A0_2
    L5_2 = L5_2(L6_2)
    L4_2 = L4_2 == L5_2
  end
  return L4_2
end
function L1_1(A0_2)
  local L1_2, L2_2
  if A0_2 then
    L1_2 = A0_2.id
    if L1_2 then
      goto lbl_8
    end
  end
  L1_2 = nil
  do return L1_2 end
  ::lbl_8::
  L1_2 = Config
  L1_2 = L1_2.getUserNacId
  L2_2 = A0_2.id
  return L1_2(L2_2)
end
L2_1 = IsDuplicityVersion
L2_1 = L2_1()
if L2_1 then
  L2_1 = {}
  L3_1 = AddEventHandler
  L4_1 = "playerDropped"
  function L5_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2
    L1_2 = source
    L2_2 = L1_2
    if not L2_2 or L2_2 <= 0 then
      L3_2 = log
      L4_2 = "GPS: Invalid player ID in playerDropped event: "
      L5_2 = tostring
      L6_2 = L2_2
      L5_2 = L5_2(L6_2)
      L4_2 = L4_2 .. L5_2
      L5_2 = 2
      L3_2(L4_2, L5_2)
      return
    end
    L3_2 = L2_1
    L3_2 = L3_2[L2_2]
    if L3_2 then
      L3_2 = log
      L4_2 = "GPS: Cleaning up GPS data for disconnected player "
      L5_2 = L2_2
      L4_2 = L4_2 .. L5_2
      L5_2 = 3
      L3_2(L4_2, L5_2)
      L3_2 = L2_1
      L3_2[L2_2] = nil
      L3_2 = pcall
      function L4_2()
        local L0_3, L1_3, L2_3, L3_3
        L0_3 = TriggerClientEvent
        L1_3 = "radioClient:removePlayerBlip"
        L2_3 = -1
        L3_3 = L2_2
        L0_3(L1_3, L2_3, L3_3)
      end
      L3_2, L4_2 = L3_2(L4_2)
      if not L3_2 then
        L5_2 = log
        L6_2 = "GPS: Failed to send removePlayerBlip for player "
        L7_2 = L2_2
        L8_2 = ": "
        L9_2 = tostring
        L10_2 = L4_2
        L9_2 = L9_2(L10_2)
        L6_2 = L6_2 .. L7_2 .. L8_2 .. L9_2
        L7_2 = 2
        L5_2(L6_2, L7_2)
      end
    end
  end
  L3_1(L4_1, L5_1)
  L3_1 = RegisterNetEvent
  L4_1 = "radioServer:sendGPSData"
  L3_1(L4_1)
  L3_1 = AddEventHandler
  L4_1 = "radioServer:sendGPSData"
  function L5_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2
    L1_2 = Citizen
    L1_2 = L1_2.Wait
    L2_2 = 50
    L1_2(L2_2)
    L1_2 = log
    L2_2 = "GPS: Received GPS data from player "
    if A0_2 then
      L3_2 = A0_2.id
      if L3_2 then
        goto lbl_13
      end
    end
    L3_2 = "unknown"
    ::lbl_13::
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    if A0_2 then
      L1_2 = A0_2.id
      if L1_2 then
        goto lbl_22
      end
    end
    do return end
    ::lbl_22::
    L1_2 = tonumber
    L2_2 = A0_2.id
    L1_2 = L1_2(L2_2)
    if not L1_2 or L1_2 <= 0 then
      L2_2 = log
      L3_2 = "GPS: Invalid player ID: "
      L4_2 = tostring
      L5_2 = A0_2.id
      L4_2 = L4_2(L5_2)
      L3_2 = L3_2 .. L4_2
      L4_2 = 2
      L2_2(L3_2, L4_2)
      return
    end
    L2_2 = GetPlayerName
    L3_2 = L1_2
    L2_2 = L2_2(L3_2)
    L3_2 = GetPlayerPing
    L4_2 = L1_2
    L3_2 = L3_2(L4_2)
    L4_2 = nil ~= L2_2 and L3_2 >= 0
    if not L4_2 then
      L5_2 = log
      L6_2 = "GPS: Player "
      L7_2 = L1_2
      L8_2 = " no longer exists or not fully loaded, skipping GPS update"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = L2_1
      L5_2[L1_2] = nil
      return
    end
    L5_2 = A0_2.valid
    if not L5_2 then
      L5_2 = log
      L6_2 = "GPS: Invalid GPS data from player "
      L7_2 = L1_2
      L8_2 = ", clearing"
      L6_2 = L6_2 .. L7_2 .. L8_2
      L7_2 = 4
      L5_2(L6_2, L7_2)
      L5_2 = L2_1
      L5_2[L1_2] = nil
      L5_2 = GetPlayerName
      L6_2 = L1_2
      L5_2 = L5_2(L6_2)
      if nil ~= L5_2 then
        L5_2 = 0
        L6_2 = 3
        L7_2 = false
        while not L7_2 and L5_2 < L6_2 do
          L5_2 = L5_2 + 1
          L8_2 = pcall
          function L9_2()
            local L0_3, L1_3, L2_3, L3_3
            L0_3 = TriggerClientEvent
            L1_3 = "radioClient:recieveGPS"
            L2_3 = L1_2
            L3_3 = {}
            L0_3(L1_3, L2_3, L3_3)
          end
          L8_2 = L8_2(L9_2)
          L7_2 = L8_2
          if not L7_2 and L6_2 > L5_2 then
            L8_2 = Citizen
            L8_2 = L8_2.Wait
            L9_2 = 100
            L8_2(L9_2)
          end
        end
        if not L7_2 then
          L8_2 = log
          L9_2 = "GPS: Failed to send clear GPS data to player "
          L10_2 = L1_2
          L11_2 = " after "
          L12_2 = L6_2
          L13_2 = " attempts"
          L9_2 = L9_2 .. L10_2 .. L11_2 .. L12_2 .. L13_2
          L10_2 = 2
          L8_2(L9_2, L10_2)
        end
      else
        L5_2 = log
        L6_2 = "GPS: Player "
        L7_2 = L1_2
        L8_2 = " disconnected, skipping clear GPS event"
        L6_2 = L6_2 .. L7_2 .. L8_2
        L7_2 = 4
        L5_2(L6_2, L7_2)
      end
      return
    end
    L5_2 = log
    L6_2 = "GPS: Valid GPS data from player "
    L7_2 = L1_2
    L8_2 = ", storing"
    L6_2 = L6_2 .. L7_2 .. L8_2
    L7_2 = 5
    L5_2(L6_2, L7_2)
    L5_2 = L2_1
    L5_2[L1_2] = A0_2
  end
  L3_1(L4_1, L5_1)
  L3_1 = Citizen
  L3_1 = L3_1.CreateThread
  function L4_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2, L18_2, L19_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 500
      L0_2(L1_2)
      L0_2 = 0
      L1_2 = pairs
      L2_2 = L2_1
      L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
      for L5_2 in L1_2, L2_2, L3_2, L4_2 do
        L0_2 = L0_2 + 1
      end
      L1_2 = log
      L2_2 = "GPS: Processing GPS data for "
      L3_2 = L0_2
      L4_2 = " players"
      L2_2 = L2_2 .. L3_2 .. L4_2
      L3_2 = 5
      L1_2(L2_2, L3_2)
      L1_2 = {}
      L2_2 = pairs
      L3_2 = L2_1
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        if L7_2 then
          L8_2 = L7_2.zone
          if L8_2 then
            L8_2 = L7_2.channel
            if L8_2 then
              L8_2 = L7_2.coords
              if L8_2 then
                L8_2 = Config
                L8_2 = L8_2.zones
                L9_2 = L7_2.zone
                L8_2 = L8_2[L9_2]
                L9_2 = L8_2 or L9_2
                if L8_2 then
                  L9_2 = L8_2.Channels
                  L10_2 = L7_2.channel
                  L9_2 = L9_2[L10_2]
                end
                if L8_2 and L9_2 then
                  L10_2 = L9_2.gps
                  if not L10_2 then
                    L10_2 = gpsDefaults
                  end
                  L11_2 = gpsDefaults
                  if L10_2 ~= L11_2 then
                    L11_2 = pairs
                    L12_2 = gpsDefaults
                    L11_2, L12_2, L13_2, L14_2 = L11_2(L12_2)
                    for L15_2, L16_2 in L11_2, L12_2, L13_2, L14_2 do
                      L17_2 = L10_2[L15_2]
                      if nil == L17_2 then
                        L10_2[L15_2] = L16_2
                      end
                    end
                  end
                  L11_2 = {}
                  L12_2 = L10_2.groundSprite
                  L11_2.sprite = L12_2
                  L12_2 = L10_2.color
                  L11_2.color = L12_2
                  L12_2 = L10_2.flashColor
                  L11_2.flashColor = L12_2
                  L11_2.showHeading = false
                  L12_2 = L7_2.panic
                  if L12_2 then
                    L11_2.flashColor = 1
                  end
                  L12_2 = L7_2.vehicleType
                  if "car" == L12_2 then
                    L12_2 = L10_2.carSprite
                    L11_2.sprite = L12_2
                  else
                    L12_2 = L7_2.vehicleType
                    if "heli" == L12_2 then
                      L12_2 = L10_2.heliSprite
                      L11_2.sprite = L12_2
                    else
                      L12_2 = L7_2.vehicleType
                      if "boat" == L12_2 then
                        L12_2 = L10_2.boatSprite
                        L11_2.sprite = L12_2
                      else
                        L12_2 = L7_2.vehicleType
                        if "plane" == L12_2 then
                          L12_2 = L10_2.planeSprite
                          L11_2.sprite = L12_2
                        end
                      end
                    end
                  end
                  L12_2 = ipairs
                  L13_2 = L10_2.showHeading
                  L12_2, L13_2, L14_2, L15_2 = L12_2(L13_2)
                  for L16_2, L17_2 in L12_2, L13_2, L14_2, L15_2 do
                    L18_2 = L7_2.vehicleType
                    if L18_2 == L17_2 then
                      L11_2.showHeading = true
                      break
                    end
                  end
                  L7_2.blipConfig = L11_2
                  L1_2[L6_2] = L7_2
                end
              end
            end
          end
        end
      end
      L2_2 = pairs
      L3_2 = L1_2
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = L1_1
        L9_2 = L7_2
        L8_2 = L8_2(L9_2)
        if L8_2 then
          L9_2 = {}
          L10_2 = pairs
          L11_2 = L1_2
          L10_2, L11_2, L12_2, L13_2 = L10_2(L11_2)
          for L14_2, L15_2 in L10_2, L11_2, L12_2, L13_2 do
            L16_2 = L0_1
            L17_2 = L8_2
            L18_2 = L15_2
            L16_2 = L16_2(L17_2, L18_2)
            if L16_2 then
              L9_2[L14_2] = L15_2
            end
          end
          L10_2 = GetPlayerName
          L11_2 = L6_2
          L10_2 = L10_2(L11_2)
          if nil ~= L10_2 then
            L10_2 = pcall
            function L11_2()
              local L0_3, L1_3, L2_3, L3_3
              L0_3 = TriggerClientEvent
              L1_3 = "radioClient:recieveGPS"
              L2_3 = L6_2
              L3_3 = L9_2
              L0_3(L1_3, L2_3, L3_3)
            end
            L10_2 = L10_2(L11_2)
            if not L10_2 then
              L11_2 = log
              L12_2 = "GPS: Failed to send GPS data to viewer "
              L13_2 = L6_2
              L12_2 = L12_2 .. L13_2
              L13_2 = 2
              L11_2(L12_2, L13_2)
              L11_2 = L2_1
              L11_2[L6_2] = nil
            end
          else
            L10_2 = log
            L11_2 = "GPS: Viewer "
            L12_2 = L6_2
            L13_2 = " no longer exists, removing from GPS data"
            L11_2 = L11_2 .. L12_2 .. L13_2
            L12_2 = 4
            L10_2(L11_2, L12_2)
            L10_2 = L2_1
            L10_2[L6_2] = nil
          end
        else
          L9_2 = GetPlayerName
          L10_2 = L6_2
          L9_2 = L9_2(L10_2)
          if nil ~= L9_2 then
            L9_2 = pcall
            function L10_2()
              local L0_3, L1_3, L2_3, L3_3
              L0_3 = TriggerClientEvent
              L1_3 = "radioClient:recieveGPS"
              L2_3 = L6_2
              L3_3 = {}
              L0_3(L1_3, L2_3, L3_3)
            end
            L9_2 = L9_2(L10_2)
            if not L9_2 then
              L10_2 = log
              L11_2 = "GPS: Failed to send empty GPS data to viewer "
              L12_2 = L6_2
              L11_2 = L11_2 .. L12_2
              L12_2 = 2
              L10_2(L11_2, L12_2)
              L10_2 = L2_1
              L10_2[L6_2] = nil
            end
          else
            L9_2 = log
            L10_2 = "GPS: Viewer "
            L11_2 = L6_2
            L12_2 = " no longer exists, removing from GPS data"
            L10_2 = L10_2 .. L11_2 .. L12_2
            L11_2 = 4
            L9_2(L10_2, L11_2)
            L9_2 = L2_1
            L9_2[L6_2] = nil
          end
        end
      end
      L2_2 = pairs
      L3_2 = L2_1
      L2_2, L3_2, L4_2, L5_2 = L2_2(L3_2)
      for L6_2, L7_2 in L2_2, L3_2, L4_2, L5_2 do
        L8_2 = L1_2[L6_2]
        if not L8_2 then
          L8_2 = GetPlayerName
          L9_2 = L6_2
          L8_2 = L8_2(L9_2)
          L9_2 = GetPlayerPing
          L10_2 = L6_2
          L9_2 = L9_2(L10_2)
          L10_2 = nil ~= L8_2 and L9_2 >= 0
          if L10_2 then
            L11_2 = 0
            L12_2 = 2
            L13_2 = false
            while not L13_2 and L11_2 < L12_2 do
              L11_2 = L11_2 + 1
              L14_2 = pcall
              function L15_2()
                local L0_3, L1_3, L2_3, L3_3
                L0_3 = TriggerClientEvent
                L1_3 = "radioClient:recieveGPS"
                L2_3 = L6_2
                L3_3 = {}
                L0_3(L1_3, L2_3, L3_3)
              end
              L14_2 = L14_2(L15_2)
              L13_2 = L14_2
              if not L13_2 and L12_2 > L11_2 then
                L14_2 = Citizen
                L14_2 = L14_2.Wait
                L15_2 = 50
                L14_2(L15_2)
              end
            end
            if not L13_2 then
              L14_2 = log
              L15_2 = "GPS: Failed to send empty GPS data to inactive player "
              L16_2 = L6_2
              L17_2 = " after "
              L18_2 = L12_2
              L19_2 = " attempts"
              L15_2 = L15_2 .. L16_2 .. L17_2 .. L18_2 .. L19_2
              L16_2 = 2
              L14_2(L15_2, L16_2)
              L14_2 = L2_1
              L14_2[L6_2] = nil
            end
          else
            L11_2 = log
            L12_2 = "GPS: Player "
            L13_2 = L6_2
            L14_2 = " no longer exists, removing from leoData"
            L12_2 = L12_2 .. L13_2 .. L14_2
            L13_2 = 4
            L11_2(L12_2, L13_2)
            L11_2 = L2_1
            L11_2[L6_2] = nil
          end
        end
      end
    end
  end
  L3_1(L4_1)
  L3_1 = Citizen
  L3_1 = L3_1.CreateThread
  function L4_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 30000
      L0_2(L1_2)
      L0_2 = 0
      L1_2 = pairs
      L2_2 = L2_1
      L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
      for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
        L7_2 = GetPlayerName
        L8_2 = L5_2
        L7_2 = L7_2(L8_2)
        L8_2 = GetPlayerPing
        L9_2 = L5_2
        L8_2 = L8_2(L9_2)
        if not L7_2 or L8_2 < 0 then
          L9_2 = L2_1
          L9_2[L5_2] = nil
          L0_2 = L0_2 + 1
        end
      end
      if L0_2 > 0 then
        L1_2 = log
        L2_2 = "GPS: Cleanup removed "
        L3_2 = L0_2
        L4_2 = " stale player entries"
        L2_2 = L2_2 .. L3_2 .. L4_2
        L3_2 = 4
        L1_2(L2_2, L3_2)
      end
    end
  end
  L3_1(L4_1)
else
  L2_1 = {}
  L3_1 = {}
  L4_1 = false
  L5_1 = {}
  L6_1 = {}
  L7_1 = _ENV
  L8_1 = "SetThisScriptCanRemoveBlipsCreatedByAnyScript"
  L7_1 = L7_1[L8_1]
  L8_1 = true
  L7_1(L8_1)
  function L7_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2
    L2_2 = A0_2.blip
    if L2_2 then
      L2_2 = DoesBlipExist
      L3_2 = A0_2.blip
      L2_2 = L2_2(L3_2)
      if L2_2 then
        goto lbl_10
      end
    end
    do return end
    ::lbl_10::
    if A1_2 then
      L2_2 = L4_1
      if L2_2 then
        L2_2 = SetBlipColour
        L3_2 = A0_2.blip
        L4_2 = A0_2.flashColor
        L2_2(L3_2, L4_2)
      else
        L2_2 = SetBlipColour
        L3_2 = A0_2.blip
        L4_2 = A0_2.color
        L2_2(L3_2, L4_2)
      end
    else
      L2_2 = SetBlipColour
      L3_2 = A0_2.blip
      L4_2 = A0_2.color
      L2_2(L3_2, L4_2)
    end
  end
  function L8_1()
    local L0_2, L1_2, L2_2, L3_2
    L0_2 = GetMainPlayerBlipId
    L0_2 = L0_2()
    L1_2 = SetBlipSprite
    L2_2 = L0_2
    L3_2 = 6
    L1_2(L2_2, L3_2)
    L1_2 = SetBlipScale
    L2_2 = L0_2
    L3_2 = 0.7
    L1_2(L2_2, L3_2)
    L1_2 = SetBlipAlpha
    L2_2 = L0_2
    L3_2 = 0.9
    L1_2(L2_2, L3_2)
    L1_2 = SetBlipColour
    L2_2 = L0_2
    L3_2 = 0
    L1_2(L2_2, L3_2)
    L1_2 = SetBlipDisplay
    L2_2 = L0_2
    L3_2 = 2
    L1_2(L2_2, L3_2)
    L1_2 = ShowHeadingIndicatorOnBlip
    L2_2 = L0_2
    L3_2 = false
    L1_2(L2_2, L3_2)
  end
  L9_1 = AddEventHandler
  L10_1 = "onResourceStop"
  function L11_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    L1_2 = GetCurrentResourceName
    L1_2 = L1_2()
    if L1_2 ~= A0_2 then
      return
    end
    L1_2 = pairs
    L2_2 = L2_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = DoesBlipExist
      L8_2 = L6_2
      L7_2 = L7_2(L8_2)
      if L7_2 then
        L7_2 = RemoveBlip
        L8_2 = L6_2
        L7_2(L8_2)
      end
    end
    L1_2 = {}
    L2_1 = L1_2
    L1_2 = {}
    L3_1 = L1_2
    L1_2 = L8_1
    L1_2()
  end
  L9_1(L10_1, L11_1)
  L9_1 = RegisterNetEvent
  L10_1 = "radioClient:removePlayerBlip"
  L9_1(L10_1)
  L9_1 = AddEventHandler
  L10_1 = "radioClient:removePlayerBlip"
  function L11_1(A0_2)
    local L1_2, L2_2
    L1_2 = L2_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = DoesBlipExist
      L2_2 = L2_1
      L2_2 = L2_2[A0_2]
      L1_2 = L1_2(L2_2)
      if L1_2 then
        L1_2 = RemoveBlip
        L2_2 = L2_1
        L2_2 = L2_2[A0_2]
        L1_2(L2_2)
        L1_2 = L2_1
        L1_2[A0_2] = nil
        L1_2 = L3_1
        L1_2[A0_2] = nil
        L1_2 = L6_1
        L1_2[A0_2] = nil
      end
    end
  end
  L9_1(L10_1, L11_1)
  L9_1 = Citizen
  L9_1 = L9_1.CreateThread
  function L10_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 1000
      L0_2(L1_2)
      L0_2 = radioSystemAccess
      if true == L0_2 then
        L0_2 = RadioState
        if L0_2 then
          L0_2 = RadioState
          L0_2 = L0_2.gpsEnabled
          if L0_2 then
            L0_2 = RadioState
            L0_2 = L0_2.connected
            if L0_2 then
              L0_2 = RadioState
              L0_2 = L0_2.power
              if L0_2 then
                L0_2 = log
                L1_2 = "GPS: Sending location data for player "
                L2_2 = GetPlayerServerId
                L3_2 = PlayerId
                L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L3_2()
                L2_2 = L2_2(L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
                L1_2 = L1_2 .. L2_2
                L2_2 = 4
                L0_2(L1_2, L2_2)
                L0_2 = PlayerPedId
                L0_2 = L0_2()
                L1_2 = GetEntityCoords
                L2_2 = L0_2
                L1_2 = L1_2(L2_2)
                L2_2 = GetEntityHeading
                L3_2 = L0_2
                L2_2 = L2_2(L3_2)
                L3_2 = GetVehiclePedIsIn
                L4_2 = L0_2
                L5_2 = false
                L3_2 = L3_2(L4_2, L5_2)
                L4_2 = IsVehicleSirenOn
                L5_2 = L3_2
                L4_2 = L4_2(L5_2)
                L5_2 = "foot"
                L6_2 = GetPlayerServerId
                L7_2 = PlayerId
                L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L7_2()
                L6_2 = L6_2(L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
                L7_2 = L5_1
                L7_2 = L7_2[L6_2]
                if L7_2 then
                  L7_2 = SetBlipAlpha
                  L8_2 = GetMainPlayerBlipId
                  L8_2 = L8_2()
                  L9_2 = 0.0
                  L7_2(L8_2, L9_2)
                else
                  L7_2 = L8_1
                  L7_2()
                end
                L7_2 = IsPedInAnyVehicle
                L8_2 = L0_2
                L9_2 = false
                L7_2 = L7_2(L8_2, L9_2)
                if L7_2 then
                  L7_2 = GetEntityModel
                  L8_2 = L3_2
                  L7_2 = L7_2(L8_2)
                  L8_2 = IsThisModelAHeli
                  L9_2 = L7_2
                  L8_2 = L8_2(L9_2)
                  if L8_2 then
                    L5_2 = "heli"
                  else
                    L8_2 = IsThisModelAPlane
                    L9_2 = L7_2
                    L8_2 = L8_2(L9_2)
                    if L8_2 then
                      L5_2 = "plane"
                    else
                      L8_2 = IsThisModelABoat
                      L9_2 = L7_2
                      L8_2 = L8_2(L9_2)
                      if L8_2 then
                        L5_2 = "boat"
                      else
                        L5_2 = "car"
                      end
                    end
                  end
                end
                L7_2 = RadioState
                L7_2 = L7_2.connectedChannel
                if L7_2 then
                  L7_2 = RadioState
                  L7_2 = L7_2.connectedChannel
                  L7_2 = L7_2.zoneId
                  if L7_2 then
                    L7_2 = RadioState
                    L7_2 = L7_2.connectedChannel
                    L7_2 = L7_2.channelId
                    if L7_2 then
                      L7_2 = RadioState
                      L7_2 = L7_2.connectedChannel
                      L7_2 = L7_2.frequency
                      if L7_2 then
                        L7_2 = log
                        L8_2 = "GPS: Valid radio state, sending GPS data"
                        L9_2 = 4
                        L7_2(L8_2, L9_2)
                        L7_2 = TriggerServerEvent
                        L8_2 = "radioServer:sendGPSData"
                        L9_2 = {}
                        L10_2 = GetPlayerServerId
                        L11_2 = PlayerId
                        L11_2, L12_2 = L11_2()
                        L10_2 = L10_2(L11_2, L12_2)
                        L9_2.id = L10_2
                        L9_2.valid = true
                        L9_2.coords = L1_2
                        L9_2.heading = L2_2
                        L9_2.siren = L4_2
                        L10_2 = RadioState
                        L10_2 = L10_2.panicButton
                        if not L10_2 then
                          L10_2 = false
                        end
                        L9_2.panic = L10_2
                        L9_2.vehicleType = L5_2
                        L10_2 = RadioState
                        L10_2 = L10_2.connectedChannel
                        L10_2 = L10_2.zoneId
                        L9_2.zone = L10_2
                        L10_2 = RadioState
                        L10_2 = L10_2.connectedChannel
                        L10_2 = L10_2.channelId
                        L9_2.channel = L10_2
                        L10_2 = RadioState
                        L10_2 = L10_2.connectedChannel
                        L10_2 = L10_2.frequency
                        L9_2.frequency = L10_2
                        L10_2 = radioSystemGetPlayerName
                        L11_2 = GetPlayerServerId
                        L12_2 = PlayerId
                        L12_2 = L12_2()
                        L11_2, L12_2 = L11_2(L12_2)
                        L10_2 = L10_2(L11_2, L12_2)
                        L9_2.name = L10_2
                        L7_2(L8_2, L9_2)
                    end
                  end
                end
                else
                  L7_2 = log
                  L8_2 = "GPS: Invalid radio state, sending invalid GPS data"
                  L9_2 = 4
                  L7_2(L8_2, L9_2)
                  L7_2 = TriggerServerEvent
                  L8_2 = "radioServer:sendGPSData"
                  L9_2 = {}
                  L10_2 = GetPlayerServerId
                  L11_2 = PlayerId
                  L11_2, L12_2 = L11_2()
                  L10_2 = L10_2(L11_2, L12_2)
                  L9_2.id = L10_2
                  L9_2.valid = false
                  L7_2(L8_2, L9_2)
                end
            end
          end
        end
      end
      else
        L0_2 = log
        L1_2 = "GPS: Conditions not met - radioAccess: "
        L2_2 = tostring
        L3_2 = radioSystemAccess
        L2_2 = L2_2(L3_2)
        L3_2 = ", gpsEnabled: "
        L4_2 = tostring
        L5_2 = RadioState
        if L5_2 then
          L5_2 = RadioState
          L5_2 = L5_2.gpsEnabled
        end
        L4_2 = L4_2(L5_2)
        L5_2 = ", connected: "
        L6_2 = tostring
        L7_2 = RadioState
        if L7_2 then
          L7_2 = RadioState
          L7_2 = L7_2.connected
        end
        L6_2 = L6_2(L7_2)
        L7_2 = ", power: "
        L8_2 = tostring
        L9_2 = RadioState
        if L9_2 then
          L9_2 = RadioState
          L9_2 = L9_2.power
        end
        L8_2 = L8_2(L9_2)
        L1_2 = L1_2 .. L2_2 .. L3_2 .. L4_2 .. L5_2 .. L6_2 .. L7_2 .. L8_2
        L2_2 = 5
        L0_2(L1_2, L2_2)
        L0_2 = GetPlayerServerId
        L1_2 = PlayerId
        L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L1_2()
        L0_2 = L0_2(L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        L1_2 = L2_1
        L1_2 = L1_2[L0_2]
        if L1_2 then
          L1_2 = DoesBlipExist
          L2_2 = L2_1
          L2_2 = L2_2[L0_2]
          L1_2 = L1_2(L2_2)
          if L1_2 then
            L1_2 = L3_1
            L1_2[L0_2] = nil
          end
        end
        L1_2 = L8_1
        L1_2()
        L1_2 = TriggerServerEvent
        L2_2 = "radioServer:sendGPSData"
        L3_2 = {}
        L4_2 = GetPlayerServerId
        L5_2 = PlayerId
        L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2 = L5_2()
        L4_2 = L4_2(L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2)
        L3_2.id = L4_2
        L3_2.valid = false
        L1_2(L2_2, L3_2)
      end
    end
  end
  L9_1(L10_1)
  L9_1 = RegisterNetEvent
  L10_1 = "radioClient:recieveGPS"
  L9_1(L10_1)
  L9_1 = AddEventHandler
  L10_1 = "radioClient:recieveGPS"
  function L11_1(A0_2)
    local L1_2
    L5_1 = A0_2
  end
  L9_1(L10_1, L11_1)
  L9_1 = Citizen
  L9_1 = L9_1.CreateThread
  function L10_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2, L10_2, L11_2, L12_2, L13_2, L14_2, L15_2, L16_2, L17_2
    L0_2 = {}
    while true do
      L1_2 = Citizen
      L1_2 = L1_2.Wait
      L2_2 = 50
      L1_2(L2_2)
      L1_2 = pairs
      L2_2 = L2_1
      L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
      for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
        if L6_2 then
          L7_2 = DoesBlipExist
          L8_2 = L6_2
          L7_2 = L7_2(L8_2)
          if L7_2 then
            goto lbl_26
          end
        end
        L7_2 = L2_1
        L7_2[L5_2] = nil
        L7_2 = L3_1
        L7_2[L5_2] = nil
        L0_2[L5_2] = nil
        L7_2 = L6_1
        L7_2[L5_2] = nil
        goto lbl_61
        ::lbl_26::
        L7_2 = L5_1
        L7_2 = L7_2[L5_2]
        if not L7_2 then
          L7_2 = L6_1
          L7_2 = L7_2[L5_2]
          if not L7_2 then
            L7_2 = L6_1
            L8_2 = GetGameTimer
            L8_2 = L8_2()
            L7_2[L5_2] = L8_2
          else
            L7_2 = GetGameTimer
            L7_2 = L7_2()
            L8_2 = L6_1
            L8_2 = L8_2[L5_2]
            L7_2 = L7_2 - L8_2
            L8_2 = 5000
            if L7_2 > L8_2 then
              L7_2 = RemoveBlip
              L8_2 = L6_2
              L7_2(L8_2)
              L7_2 = L2_1
              L7_2[L5_2] = nil
              L7_2 = L3_1
              L7_2[L5_2] = nil
              L0_2[L5_2] = nil
              L7_2 = L6_1
              L7_2[L5_2] = nil
            end
          end
        else
          L7_2 = L6_1
          L7_2[L5_2] = nil
        end
        ::lbl_61::
      end
      L1_2 = radioSystemAccess
      if true == L1_2 then
        L1_2 = RadioState
        if L1_2 then
          L1_2 = RadioState
          L1_2 = L1_2.connected
          if L1_2 then
            L1_2 = pairs
            L2_2 = L5_1
            L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
            for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
              if not L6_2 then
              else
                L7_2 = L6_2.coords
                if L7_2 then
                  L7_2 = L6_2.blipConfig
                  if not L7_2 then
                  else
                    L7_2 = L2_1
                    L7_2 = L7_2[L5_2]
                    L8_2 = GetPlayerFromServerId
                    L9_2 = L5_2
                    L8_2 = L8_2(L9_2)
                    if -1 ~= L8_2 then
                      L9_2 = GetPlayerPed
                      L10_2 = L8_2
                      L9_2 = L9_2(L10_2)
                      if L9_2 then
                        goto lbl_101
                      end
                    end
                    L9_2 = 0
                    ::lbl_101::
                    L10_2 = L0_2[L5_2]
                    if not L10_2 then
                      L10_2 = {}
                    end
                    L11_2 = DoesEntityExist
                    L12_2 = L9_2
                    L11_2 = L11_2(L12_2)
                    if L11_2 and 0 ~= L9_2 then
                      L11_2 = GetEntityCoords
                      L12_2 = L9_2
                      L11_2 = L11_2(L12_2)
                      if L11_2 then
                        goto lbl_126
                      end
                    end
                    L11_2 = vector3
                    L12_2 = L6_2.coords
                    L12_2 = L12_2.x
                    L13_2 = L6_2.coords
                    L13_2 = L13_2.y
                    L14_2 = L6_2.coords
                    L14_2 = L14_2.z
                    L11_2 = L11_2(L12_2, L13_2, L14_2)
                    ::lbl_126::
                    L12_2 = DoesEntityExist
                    L13_2 = L9_2
                    L12_2 = L12_2(L13_2)
                    if L12_2 and 0 ~= L9_2 then
                      L12_2 = GetEntityHeading
                      L13_2 = L9_2
                      L12_2 = L12_2(L13_2)
                      if L12_2 then
                        goto lbl_142
                      end
                    end
                    L12_2 = L6_2.heading
                    if not L12_2 then
                      L12_2 = 0
                    end
                    ::lbl_142::
                    L18_2 = false
                    if L7_2 then
                      L13_2 = DoesBlipExist
                      L14_2 = L7_2
                      L13_2 = L13_2(L14_2)
                      if L13_2 then
                        L18_2 = true
                      end
                    end
                    if not L18_2 then
                      L13_2 = AddBlipForCoord
                      L14_2 = L11_2.x
                      L15_2 = L11_2.y
                      L16_2 = L11_2.z
                      L13_2 = L13_2(L14_2, L15_2, L16_2)
                      L7_2 = L13_2
                      if L7_2 and 0 ~= L7_2 then
                        L13_2 = L2_1
                        L13_2[L5_2] = L7_2
                        L13_2 = {}
                        L10_2 = L13_2
                      end
                    end
                    if L7_2 and 0 ~= L7_2 then
                      if L18_2 then
                        L13_2 = L10_2.coords
                        if L13_2 then
                          L13_2 = L10_2.coords
                          if L13_2 == L11_2 then
                            goto lbl_178
                          end
                        end
                        L13_2 = SetBlipCoords
                        L14_2 = L7_2
                        L15_2 = L11_2
                        L13_2(L14_2, L15_2)
                        L10_2.coords = L11_2
                        ::lbl_178::
                        L13_2 = L10_2.rotation
                        if L13_2 then
                          L13_2 = L10_2.rotation
                          if L13_2 == L12_2 then
                            goto lbl_192
                          end
                        end
                        L13_2 = SetBlipRotation
                        L14_2 = L7_2
                        L15_2 = math
                        L15_2 = L15_2.ceil
                        L16_2 = L12_2
                        L15_2, L16_2, L17_2 = L15_2(L16_2)
                        L13_2(L14_2, L15_2, L16_2, L17_2)
                        L10_2.rotation = L12_2
                      end
                      ::lbl_192::
                      L13_2 = L10_2.scale
                      if 0.9 ~= L13_2 then
                        L13_2 = SetBlipScale
                        L14_2 = L7_2
                        L15_2 = 0.9
                        L13_2(L14_2, L15_2)
                        L10_2.scale = 0.9
                      end
                      L13_2 = L10_2.alpha
                      if 1.0 ~= L13_2 then
                        L13_2 = SetBlipAlpha
                        L14_2 = L7_2
                        L15_2 = 1.0
                        L13_2(L14_2, L15_2)
                        L10_2.alpha = 1.0
                      end
                      L13_2 = L10_2.sprite
                      L14_2 = L6_2.blipConfig
                      L14_2 = L14_2.sprite
                      if L13_2 ~= L14_2 then
                        L13_2 = SetBlipSprite
                        L14_2 = L7_2
                        L15_2 = L6_2.blipConfig
                        L15_2 = L15_2.sprite
                        L13_2(L14_2, L15_2)
                        L13_2 = L6_2.blipConfig
                        L13_2 = L13_2.sprite
                        L10_2.sprite = L13_2
                      end
                      L13_2 = L10_2.shortRange
                      if true ~= L13_2 then
                        L13_2 = SetBlipAsShortRange
                        L14_2 = L7_2
                        L15_2 = true
                        L13_2(L14_2, L15_2)
                        L10_2.shortRange = true
                      end
                      L13_2 = L10_2.heading
                      L14_2 = L6_2.blipConfig
                      L14_2 = L14_2.showHeading
                      if L13_2 ~= L14_2 then
                        L13_2 = ShowHeadingIndicatorOnBlip
                        L14_2 = L7_2
                        L15_2 = L6_2.blipConfig
                        L15_2 = L15_2.showHeading
                        L13_2(L14_2, L15_2)
                        L13_2 = L6_2.blipConfig
                        L13_2 = L13_2.showHeading
                        L10_2.heading = L13_2
                      end
                      L13_2 = L10_2.display
                      if 2 ~= L13_2 then
                        L13_2 = SetBlipDisplay
                        L14_2 = L7_2
                        L15_2 = 2
                        L13_2(L14_2, L15_2)
                        L10_2.display = 2
                      end
                      L13_2 = ""
                      L14_2 = L6_2.panic
                      if L14_2 then
                        L13_2 = "~r~ "
                      end
                      L14_2 = L13_2
                      L15_2 = L6_2.name
                      if not L15_2 then
                        L15_2 = "Unknown"
                      end
                      L14_2 = L14_2 .. L15_2
                      L15_2 = BeginTextCommandSetBlipName
                      L16_2 = "STRING"
                      L15_2(L16_2)
                      L15_2 = AddTextComponentString
                      L16_2 = L14_2
                      L15_2(L16_2)
                      L15_2 = EndTextCommandSetBlipName
                      L16_2 = L7_2
                      L15_2(L16_2)
                      L15_2 = L6_2.siren
                      if not L15_2 then
                        L15_2 = L6_2.panic
                        if not L15_2 then
                          goto lbl_296
                        end
                      end
                      L15_2 = L3_1
                      L16_2 = {}
                      L16_2.blip = L7_2
                      L17_2 = L6_2.blipConfig
                      L17_2 = L17_2.color
                      if not L17_2 then
                        L17_2 = gpsDefaults
                        L17_2 = L17_2.color
                      end
                      L16_2.color = L17_2
                      L17_2 = L6_2.blipConfig
                      L17_2 = L17_2.flashColor
                      if not L17_2 then
                        L17_2 = gpsDefaults
                        L17_2 = L17_2.flashColor
                      end
                      L16_2.flashColor = L17_2
                      L15_2[L5_2] = L16_2
                      goto lbl_298
                      ::lbl_296::
                      L15_2 = L3_1
                      L15_2[L5_2] = nil
                      ::lbl_298::
                      L15_2 = L7_1
                      L16_2 = {}
                      L16_2.blip = L7_2
                      L17_2 = L6_2.blipConfig
                      L17_2 = L17_2.color
                      if not L17_2 then
                        L17_2 = gpsDefaults
                        L17_2 = L17_2.color
                      end
                      L16_2.color = L17_2
                      L17_2 = L6_2.blipConfig
                      L17_2 = L17_2.flashColor
                      if not L17_2 then
                        L17_2 = gpsDefaults
                        L17_2 = L17_2.flashColor
                      end
                      L16_2.flashColor = L17_2
                      L17_2 = L6_2.siren
                      if not L17_2 then
                        L17_2 = L6_2.panic
                      end
                      L15_2(L16_2, L17_2)
                      L0_2[L5_2] = L10_2
                    end
                  end
                end
              end
              ::lbl_322::
            end
          end
        end
      end
    end
  end
  L9_1(L10_1)
  L9_1 = Citizen
  L9_1 = L9_1.CreateThread
  function L10_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2
    while true do
      L0_2 = Citizen
      L0_2 = L0_2.Wait
      L1_2 = 500
      L0_2(L1_2)
      L0_2 = L4_1
      L0_2 = not L0_2
      L4_1 = L0_2
      L0_2 = pairs
      L1_2 = L3_1
      L0_2, L1_2, L2_2, L3_2 = L0_2(L1_2)
      for L4_2, L5_2 in L0_2, L1_2, L2_2, L3_2 do
        L6_2 = L5_2.blip
        if L6_2 then
          L6_2 = DoesBlipExist
          L7_2 = L5_2.blip
          L6_2 = L6_2(L7_2)
          if L6_2 then
            goto lbl_23
          end
        end
        L6_2 = L3_1
        L6_2[L4_2] = nil
        goto lbl_27
        ::lbl_23::
        L6_2 = L7_1
        L7_2 = L5_2
        L8_2 = true
        L6_2(L7_2, L8_2)
        ::lbl_27::
      end
    end
  end
  L9_1(L10_1)
end
