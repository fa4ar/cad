local L0_1, L1_1, L2_1, L3_1, L4_1, L5_1, L6_1, L7_1
L0_1 = {}
Radio = L0_1
L0_1 = {}
L1_1 = IsDuplicityVersion
L1_1 = L1_1()
if L1_1 then
  L1_1 = RegisterNetEvent
  L2_1 = "radio:channelState"
  function L3_1(A0_2)
    local L1_2, L2_2
    L1_2 = A0_2.empty
    if L1_2 then
      L2_2 = A0_2.frequency
      L1_2 = L0_1
      L1_2[L2_2] = nil
    else
      L2_2 = A0_2.frequency
      L1_2 = L0_1
      L1_2[L2_2] = A0_2
    end
  end
  L1_1(L2_1, L3_1)
  L1_1 = RegisterNetEvent
  L2_1 = "radio:talkerState"
  function L3_1(A0_2)
    local L1_2
  end
  L1_1(L2_1, L3_1)
  L1_1 = Radio
  function L2_1(A0_2)
    local L1_2
    L1_2 = L0_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = L0_1
      L1_2 = L1_2[A0_2]
      L1_2 = L1_2.speakers
      if not L1_2 then
        L1_2 = {}
      end
      return L1_2
    end
    L1_2 = {}
    return L1_2
  end
  L1_1.getClientsInChannel = L2_1
  L1_1 = Radio
  function L2_1(A0_2)
    local L1_2
    L1_2 = L0_1
    L1_2 = L1_2[A0_2]
    if L1_2 then
      L1_2 = L0_1
      L1_2 = L1_2[A0_2]
      L1_2 = L1_2.listeners
      if not L1_2 then
        L1_2 = {}
      end
      return L1_2
    end
    L1_2 = {}
    return L1_2
  end
  L1_1.getListenersInChannel = L2_1
  L1_1 = Radio
  function L2_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L0_2 = {}
    L1_2 = pairs
    L2_2 = L0_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = table
      L7_2 = L7_2.insert
      L8_2 = L0_2
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
    end
    return L0_2
  end
  L1_1.getChannels = L2_1
  L1_1 = Radio
  function L2_1(A0_2)
    local L1_2
    L1_2 = L0_1
    L1_2 = L1_2[A0_2]
    return L1_2
  end
  L1_1.getChannel = L2_1
  L1_1 = Radio
  function L2_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2
    L2_2 = TriggerClientEvent
    L3_2 = "radio:setChannel"
    L4_2 = A0_2
    L5_2 = A1_2
    L2_2(L3_2, L4_2, L5_2)
  end
  L1_1.setClientChannel = L2_1
  L1_1 = exports
  L2_1 = "getClientsInChannel"
  L3_1 = Radio
  L3_1 = L3_1.getClientsInChannel
  L1_1(L2_1, L3_1)
  L1_1 = exports
  L2_1 = "getListenersInChannel"
  L3_1 = Radio
  L3_1 = L3_1.getListenersInChannel
  L1_1(L2_1, L3_1)
  L1_1 = exports
  L2_1 = "getChannels"
  L3_1 = Radio
  L3_1 = L3_1.getChannels
  L1_1(L2_1, L3_1)
  L1_1 = exports
  L2_1 = "getChannel"
  L3_1 = Radio
  L3_1 = L3_1.getChannel
  L1_1(L2_1, L3_1)
  L1_1 = exports
  L2_1 = "setClientChannel"
  L3_1 = Radio
  L3_1 = L3_1.setClientChannel
  L1_1(L2_1, L3_1)
else
  L1_1 = "0"
  L2_1 = {}
  L3_1 = {}
  L4_1 = RegisterNetEvent
  L5_1 = "radio:channelState"
  function L6_1(A0_2)
    local L1_2, L2_2
    L1_2 = A0_2.empty
    if L1_2 then
      L2_2 = A0_2.frequency
      L1_2 = L0_1
      L1_2[L2_2] = nil
    else
      L2_2 = A0_2.frequency
      L1_2 = L0_1
      L1_2[L2_2] = A0_2
    end
  end
  L4_1(L5_1, L6_1)
  L4_1 = RegisterNetEvent
  L5_1 = "radio:talkerState"
  function L6_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = log
    L2_2 = "Talker state: "
    L3_2 = json
    L3_2 = L3_2.encode
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
  end
  L4_1(L5_1, L6_1)
  L4_1 = RegisterNetEvent
  L5_1 = "radio:setChannel"
  function L6_1(A0_2)
    local L1_2, L2_2
    L1_2 = Radio
    L1_2 = L1_2.setChannel
    L2_2 = A0_2
    L1_2(L2_2)
  end
  L4_1(L5_1, L6_1)
  L4_1 = Radio
  function L5_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = log
    L2_2 = "Setting main speaking channel: "
    L3_2 = tostring
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_1 = A0_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setChannel"
    L2_2.frequency = A0_2
    L1_2(L2_2)
  end
  L4_1.setChannel = L5_1
  L4_1 = Radio
  function L5_1()
    local L0_2, L1_2
    L0_2 = L1_1
    return L0_2
  end
  L4_1.getChannel = L5_1
  L4_1 = Radio
  function L5_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = log
    L2_2 = "Adding listening channel: "
    L3_2 = tostring
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = L2_1
    L1_2[A0_2] = true
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "addListeningChannel"
    L2_2.frequency = A0_2
    L1_2(L2_2)
    L1_2 = log
    L2_2 = "Current listening channels: "
    L3_2 = json
    L3_2 = L3_2.encode
    L4_2 = L2_1
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
  end
  L4_1.addListeningChannel = L5_1
  L4_1 = Radio
  function L5_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2
    L1_2 = log
    L2_2 = "Removing listening channel: "
    L3_2 = tostring
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = L2_1
    L1_2[A0_2] = nil
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "removeListeningChannel"
    L2_2.frequency = A0_2
    L1_2(L2_2)
    L1_2 = log
    L2_2 = "Current listening channels after removal: "
    L3_2 = json
    L3_2 = L3_2.encode
    L4_2 = L2_1
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
  end
  L4_1.removeListeningChannel = L5_1
  L4_1 = Radio
  function L5_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L0_2 = {}
    L1_2 = pairs
    L2_2 = L2_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = table
      L7_2 = L7_2.insert
      L8_2 = L0_2
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
    end
    return L0_2
  end
  L4_1.getListeningChannels = L5_1
  L4_1 = Radio
  function L5_1(A0_2)
    local L1_2, L2_2
    L1_2 = L3_1
    L1_2[A0_2] = true
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "listenToUser"
    L2_2.serverId = A0_2
    L1_2(L2_2)
  end
  L4_1.listenToUser = L5_1
  L4_1 = Radio
  function L5_1(A0_2)
    local L1_2, L2_2
    L1_2 = L3_1
    L1_2[A0_2] = nil
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "stopListeningToUser"
    L2_2.serverId = A0_2
    L1_2(L2_2)
  end
  L4_1.stopListeningToUser = L5_1
  L4_1 = Radio
  function L5_1()
    local L0_2, L1_2, L2_2, L3_2, L4_2, L5_2, L6_2, L7_2, L8_2, L9_2
    L0_2 = {}
    L1_2 = pairs
    L2_2 = L3_1
    L1_2, L2_2, L3_2, L4_2 = L1_2(L2_2)
    for L5_2, L6_2 in L1_2, L2_2, L3_2, L4_2 do
      L7_2 = table
      L7_2 = L7_2.insert
      L8_2 = L0_2
      L9_2 = L5_2
      L7_2(L8_2, L9_2)
    end
    return L0_2
  end
  L4_1.getListenedUsers = L5_1
  L4_1 = Radio
  function L5_1(A0_2)
    local L1_2, L2_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "setTalking"
    L2_2.talking = A0_2
    L1_2(L2_2)
  end
  L4_1.setTalking = L5_1
  L4_1 = Radio
  function L5_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L1_2 = SendNUIMessage
    L2_2 = {}
    L2_2.action = "playTone"
    L2_2.tone = A0_2
    L1_2(L2_2)
    L1_2 = log
    L2_2 = "Radio.playTone called with tone: "
    L3_2 = tostring
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = log
    L2_2 = "radioSystemAccess = "
    L3_2 = tostring
    L4_2 = radioSystemAccess
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = log
    L2_2 = "RadioState.power = "
    L3_2 = tostring
    L4_2 = RadioState
    L4_2 = L4_2.power
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = log
    L2_2 = "RadioState.earbudsEnabled = "
    L3_2 = tostring
    L4_2 = RadioState
    L4_2 = L4_2.earbudsEnabled
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 4
    L1_2(L2_2, L3_2)
    L1_2 = radioSystemAccess
    if true == L1_2 then
      L1_2 = RadioState
      L1_2 = L1_2.power
      if L1_2 then
        L1_2 = RadioState
        L1_2 = L1_2.earbudsEnabled
        if not L1_2 then
          L1_2 = nil
          L2_2 = playerOwnedVehicle
          if L2_2 then
            L2_2 = DoesEntityExist
            L3_2 = playerOwnedVehicle
            L2_2 = L2_2(L3_2)
            if L2_2 then
              L2_2 = VehToNet
              L3_2 = playerOwnedVehicle
              L2_2 = L2_2(L3_2)
              L1_2 = L2_2
            end
          end
          L2_2 = log
          L3_2 = "Triggering 3D tone event for tone: "
          L4_2 = A0_2
          L3_2 = L3_2 .. L4_2
          L4_2 = 4
          L2_2(L3_2, L4_2)
          L2_2 = TriggerServerEvent
          L3_2 = "radio:3DPlayTone"
          L4_2 = A0_2
          L5_2 = RadioState
          L5_2 = L5_2.toneVolume
          if not L5_2 then
            L5_2 = 50
          end
          L6_2 = L1_2
          L2_2(L3_2, L4_2, L5_2, L6_2)
      end
    end
    else
      L1_2 = log
      L2_2 = "3D tone NOT triggered - conditions not met"
      L3_2 = 4
      L1_2(L2_2, L3_2)
    end
  end
  L4_1.playTone = L5_1
  L4_1 = Radio
  function L5_1()
    local L0_2, L1_2
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "connect"
    L0_2(L1_2)
  end
  L4_1.connect = L5_1
  L4_1 = Radio
  function L5_1()
    local L0_2, L1_2
    L0_2 = SendNUIMessage
    L1_2 = {}
    L1_2.action = "disconnect"
    L0_2(L1_2)
  end
  L4_1.disconnect = L5_1
  L4_1 = nil
  L5_1 = Citizen
  L5_1 = L5_1.CreateThread
  function L6_1()
    local L0_2, L1_2
    L0_2 = TriggerServerEvent
    L1_2 = "radio:requestConnectionInfo"
    L0_2(L1_2)
  end
  L5_1(L6_1)
  L5_1 = RegisterNUICallback
  L6_1 = "requestConnectionInfo"
  function L7_1(A0_2, A1_2)
    local L2_2, L3_2, L4_2, L5_2, L6_2, L7_2
    L2_2 = log
    L3_2 = "NUI requested connection info"
    L4_2 = 3
    L2_2(L3_2, L4_2)
    L2_2 = L4_1
    if L2_2 then
      L2_2 = log
      L3_2 = "Sending stored connection info to NUI"
      L4_2 = 3
      L2_2(L3_2, L4_2)
      L2_2 = nil
      L3_2 = nil
      L4_2 = L4_1
      if "" ~= L4_2 and nil ~= L4_2 then
        L4_2 = string
        L4_2 = L4_2.find
        L5_2 = L4_1
        L6_2 = "://"
        L4_2 = L4_2(L5_2, L6_2)
        if not L4_2 then
          L4_2 = string
          L4_2 = L4_2.find
          L5_2 = L4_1
          L6_2 = ":"
          L4_2 = L4_2(L5_2, L6_2)
        end
        if L4_2 then
          L2_2 = L4_1
          L3_2 = ""
        else
          L2_2 = L4_1
          L4_2 = Config
          L3_2 = L4_2.serverPort
        end
      else
        L4_2 = Config
        L4_2 = L4_2.connectionAddr
        if "" == L4_2 then
          L2_2 = "localhost"
          L4_2 = Config
          L3_2 = L4_2.serverPort
        else
          L4_2 = string
          L4_2 = L4_2.find
          L5_2 = Config
          L5_2 = L5_2.connectionAddr
          L6_2 = "://"
          L4_2 = L4_2(L5_2, L6_2)
          if not L4_2 then
            L4_2 = string
            L4_2 = L4_2.find
            L5_2 = Config
            L5_2 = L5_2.connectionAddr
            L6_2 = ":"
            L4_2 = L4_2(L5_2, L6_2)
          end
          if L4_2 then
            L4_2 = Config
            L2_2 = L4_2.connectionAddr
            L3_2 = ""
          else
            L4_2 = Config
            L2_2 = L4_2.connectionAddr
            L4_2 = Config
            L3_2 = L4_2.serverPort
          end
        end
      end
      L4_2 = SendNUIMessage
      L5_2 = {}
      L5_2.action = "setConnectionInfo"
      L5_2.ip = L2_2
      L5_2.port = L3_2
      L6_2 = Config
      L6_2 = L6_2.authToken
      L5_2.auth = L6_2
      L6_2 = Config
      L6_2 = L6_2.logLevel
      L5_2.logLevel = L6_2
      L6_2 = GetPlayerServerId
      L7_2 = PlayerId
      L7_2 = L7_2()
      L6_2 = L6_2(L7_2)
      L5_2.serverId = L6_2
      L6_2 = GetCurrentResourceName
      L6_2 = L6_2()
      L5_2.resourceName = L6_2
      L4_2(L5_2)
    else
      L2_2 = log
      L3_2 = "No connection info available yet, requesting from server"
      L4_2 = 3
      L2_2(L3_2, L4_2)
      L2_2 = TriggerServerEvent
      L3_2 = "radio:requestConnectionInfo"
      L2_2(L3_2)
    end
    L2_2 = A1_2
    L3_2 = "ok"
    L2_2(L3_2)
  end
  L5_1(L6_1, L7_1)
  L5_1 = RegisterNetEvent
  L6_1 = "radio:recieveConnectionInfo"
  function L7_1(A0_2)
    local L1_2, L2_2, L3_2, L4_2, L5_2, L6_2
    L4_1 = A0_2
    L1_2 = log
    L2_2 = "Received and stored connection info from server: "
    L3_2 = tostring
    L4_2 = A0_2
    L3_2 = L3_2(L4_2)
    L2_2 = L2_2 .. L3_2
    L3_2 = 3
    L1_2(L2_2, L3_2)
    L1_2 = nil
    L2_2 = nil
    if "" == A0_2 or nil == A0_2 then
      L3_2 = Config
      L3_2 = L3_2.connectionAddr
      if "" == L3_2 then
        L1_2 = "localhost"
        L3_2 = Config
        L2_2 = L3_2.serverPort
      else
        L3_2 = string
        L3_2 = L3_2.find
        L4_2 = Config
        L4_2 = L4_2.connectionAddr
        L5_2 = "://"
        L3_2 = L3_2(L4_2, L5_2)
        if not L3_2 then
          L3_2 = string
          L3_2 = L3_2.find
          L4_2 = Config
          L4_2 = L4_2.connectionAddr
          L5_2 = ":"
          L3_2 = L3_2(L4_2, L5_2)
          if not L3_2 then
            goto lbl_43
          end
        end
        L3_2 = Config
        L1_2 = L3_2.connectionAddr
        L2_2 = ""
        goto lbl_68
        ::lbl_43::
        L3_2 = Config
        L1_2 = L3_2.connectionAddr
        L3_2 = Config
        L2_2 = L3_2.serverPort
      end
    else
      L3_2 = string
      L3_2 = L3_2.find
      L4_2 = A0_2
      L5_2 = "://"
      L3_2 = L3_2(L4_2, L5_2)
      if not L3_2 then
        L3_2 = string
        L3_2 = L3_2.find
        L4_2 = A0_2
        L5_2 = ":"
        L3_2 = L3_2(L4_2, L5_2)
        if not L3_2 then
          goto lbl_65
        end
      end
      L1_2 = A0_2
      L2_2 = ""
      goto lbl_68
      ::lbl_65::
      L1_2 = A0_2
      L3_2 = Config
      L2_2 = L3_2.serverPort
    end
    ::lbl_68::
    L3_2 = SendNUIMessage
    L4_2 = {}
    L4_2.action = "setConnectionInfo"
    L4_2.ip = L1_2
    L4_2.port = L2_2
    L5_2 = Config
    L5_2 = L5_2.authToken
    L4_2.auth = L5_2
    L5_2 = Config
    L5_2 = L5_2.logLevel
    L4_2.logLevel = L5_2
    L5_2 = GetPlayerServerId
    L6_2 = PlayerId
    L6_2 = L6_2()
    L5_2 = L5_2(L6_2)
    L4_2.serverId = L5_2
    L5_2 = GetCurrentResourceName
    L5_2 = L5_2()
    L4_2.resourceName = L5_2
    L3_2(L4_2)
  end
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "setChannel"
  L7_1 = Radio
  L7_1 = L7_1.setChannel
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "getChannel"
  L7_1 = Radio
  L7_1 = L7_1.getChannel
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "addListeningChannel"
  L7_1 = Radio
  L7_1 = L7_1.addListeningChannel
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "removeListeningChannel"
  L7_1 = Radio
  L7_1 = L7_1.removeListeningChannel
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "getListeningChannels"
  L7_1 = Radio
  L7_1 = L7_1.getListeningChannels
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "setTalking"
  L7_1 = Radio
  L7_1 = L7_1.setTalking
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "playTones"
  L7_1 = Radio
  L7_1 = L7_1.playTones
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "connect"
  L7_1 = Radio
  L7_1 = L7_1.connect
  L5_1(L6_1, L7_1)
  L5_1 = exports
  L6_1 = "disconnect"
  L7_1 = Radio
  L7_1 = L7_1.disconnect
  L5_1(L6_1, L7_1)
end
