ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

Freeze = {F1 = 0, F2 = 0, F3 = 0, F4 = 0, F5 = 0, F6 = 0}
Check = {F1 = false, F2 = false, F3 = false, F4 = false, F5 = false, F6 = false}
LootCheck = {
    F1 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F2 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F3 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F4 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F5 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false},
    F6 = {Stop = false, Loot1 = false, Loot2 = false, Loot3 = false}
}
local disableinput = false
local initiator = false
local startdstcheck = false
local currentname = nil
local currentcoords = nil
local done = true

Citizen.CreateThread(function() while true do local enabled = false Citizen.Wait(1) if disableinput then enabled = true DisableControl() end if not enabled then Citizen.Wait(500) end end end)
function DrawText3D(x, y, z, text, scale) local onScreen, _x, _y = World3dToScreen2d(x, y, z) local pX, pY, pZ = table.unpack(GetGameplayCamCoords()) SetTextScale(scale, scale) SetTextFont(4) SetTextProportional(1) SetTextEntry("STRING") SetTextCentre(true) SetTextColour(255, 255, 255, 215) AddTextComponentString(text) DrawText(_x, _y) local factor = (string.len(text)) / 700 DrawRect(_x, _y + 0.0150, 0.095 + factor, 0.03, 41, 11, 41, 100) end
function DisableControl() DisableControlAction(0, 73, false) DisableControlAction(0, 24, true) DisableControlAction(0, 257, true) DisableControlAction(0, 25, true) DisableControlAction(0, 263, true) DisableControlAction(0, 32, true) DisableControlAction(0, 34, true) DisableControlAction(0, 31, true) DisableControlAction(0, 30, true) DisableControlAction(0, 45, true) DisableControlAction(0, 22, true) DisableControlAction(0, 44, true) DisableControlAction(0, 37, true) DisableControlAction(0, 23, true) DisableControlAction(0, 288, true) DisableControlAction(0, 289, true) DisableControlAction(0, 170, true) DisableControlAction(0, 167, true) DisableControlAction(0, 73, true) DisableControlAction(2, 199, true) DisableControlAction(0, 47, true) DisableControlAction(0, 264, true) DisableControlAction(0, 257, true) DisableControlAction(0, 140, true) DisableControlAction(0, 141, true) DisableControlAction(0, 142, true) DisableControlAction(0, 143, true) end
function ShowTimer() SetTextFont(0) SetTextProportional(0) SetTextScale(0.42, 0.42) SetTextDropShadow(0, 0, 0, 0,255) SetTextEdge(1, 0, 0, 0, 255) SetTextEntry("STRING") AddTextComponentString("~r~"..UTK.timer.."~w~") DrawText(0.682, 0.96) end

RegisterNetEvent("utk_fh:openDoor_c")
AddEventHandler("utk_fh:openDoor_c", function(coords, method)
    if method == 1 then
        local obj = GetClosestObjectOfType(coords, 2.0, GetHashKey(UTK.vaultdoor), false, false, false)
        local count = 0

        repeat
            local heading = GetEntityHeading(obj) - 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    elseif method == 2 then
        local obj = GetClosestObjectOfType(UTK.Banks.F4.doors.startloc.x, UTK.Banks.F4.doors.startloc.y, UTK.Banks.F4.doors.startloc.z, 2.0, UTK.Banks.F4.hash, false, false, false)
        local count = 0
        repeat
            local heading = GetEntityHeading(obj) - 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    elseif method == 3 then
        local obj = GetClosestObjectOfType(coords, 2.0, GetHashKey(UTK.door), false, false, false)

        FreezeEntityPosition(obj, false)
    elseif method == 4 then
        local obj = GetClosestObjectOfType(coords, 2.0, GetHashKey(UTK.vaultdoor), false, false, false)
        local count = 0

        repeat
            local heading = GetEntityHeading(obj) + 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    elseif method == 5 then
        local obj = GetClosestObjectOfType(UTK.Banks.F4.doors.startloc.x, UTK.Banks.F4.doors.startloc.y, UTK.Banks.F4.doors.startloc.z, 2.0, UTK.Banks.F4.hash, false, false, false)
        local count = 0

        repeat
            local heading = GetEntityHeading(obj) + 0.10

            SetEntityHeading(obj, heading)
            count = count + 1
            Citizen.Wait(10)
        until count == 900
    end
end)

RegisterNetEvent("utk_fh:resetDoorState")
AddEventHandler("utk_fh:resetDoorState", function(name)
    Freeze[name] = 0
end)

RegisterNetEvent("utk_fh:lootup_c")
AddEventHandler("utk_fh:lootup_c", function(var, var2)
    LootCheck[var][var2] = true
end)

RegisterNetEvent("utk_fh:outcome")
AddEventHandler("utk_fh:outcome", function(oc, arg)
    for i = 1, #Check, 1 do
        Check[i] = false
    end
    for i = 1, #LootCheck, 1 do
        for j = 1, #LootCheck[i] do
            LootCheck[i][j] = false
        end
    end
    if oc then
        Check[arg] = true
        TriggerEvent("utk_fh:startheist", UTK.Banks[arg], arg)
    elseif not oc then
        exports["mythic_notify"]:SendAlert("error", arg)
    end
end)

RegisterNetEvent("utk_fh:startLoot_c")
AddEventHandler("utk_fh:startLoot_c", function(data, name)
    --local check = true
    --[[while check do
        local pedcoords = GetEntityCoords(PlayerPedId())
        local dst = GetDistanceBetweenCoords(pedcoords, data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z, true)

        if dst < 50 or LootCheck[name].Stop then
            check = false
        end
        Citizen.Wait(1000)
    end]]
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    if not LootCheck[name].Stop then
        Citizen.CreateThread(function()
            while true do
                local pedcoords = GetEntityCoords(PlayerPedId())
                local dst = GetDistanceBetweenCoords(pedcoords, data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z, true)

                if dst < 40 then
                    if not LootCheck[name].Loot1 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley1.x, data.trolley1.y, data.trolley1.z + 1, true)

                        if dst1 < 5 then
                            DrawText3D(data.trolley1.x, data.trolley1.y, data.trolley1.z+1, "[~r~E~w~] Recoger dinero", 0.40)
                            if dst1 < 0.75 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("utk_fh:lootup", name, "Loot1")
                                StartGrab(name)
                            end
                        end
                    end

                    if not LootCheck[name].Loot2 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley2.x, data.trolley2.y, data.trolley2.z+1, true)

                        if dst1 < 5 then
                            DrawText3D(data.trolley2.x, data.trolley2.y, data.trolley2.z+1, "[~r~E~w~] Recoger dinero", 0.40)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("utk_fh:lootup", name, "Loot2")
                                StartGrab(name)
                            end
                        end
                    end

                    if not LootCheck[name].Loot3 then
                        local dst1 = GetDistanceBetweenCoords(pedcoords, data.trolley3.x, data.trolley3.y, data.trolley3.z+1, true)

                        if dst1 < 5 then
                            DrawText3D(data.trolley3.x, data.trolley3.y, data.trolley3.z+1, "[~r~E~w~] Recoger dinero", 0.40)
                            if dst1 < 1 and IsControlJustReleased(0, 38) then
                                TriggerServerEvent("utk_fh:lootup", name, "Loot3")
                                StartGrab(name)
                            end
                        end
                    end

                    if LootCheck[name].Stop or (LootCheck[name].Loot1 and LootCheck[name].Loot2 and LootCheck[name].Loot3) then
                        LootCheck[name].Stop = false
                        if initiator then
                            TriggerEvent("utk_fh:reset", name, data)
                            return
                        end
                        return
                    end
                    Citizen.Wait(1)
                else
                    Citizen.Wait(1000)
                end
            end
        end)
    end
end)

RegisterNetEvent("utk_fh:stopHeist_c")
AddEventHandler("utk_fh:stopHeist_c", function(name)
    LootCheck[name].Stop = true
end)

RegisterNetEvent("utk_fh:policenotify")
AddEventHandler("utk_fh:policenotify", function(name)
    local PlayerData = ESX.GetPlayerData()
    local blip = nil

    while PlayerData.job == nil do
        Citizen.Wait(1)
    end
    if PlayerData.job.name == "police" then
        exports["mythic_notify"]:SendAlert("inform", "Las alarmas de un banco han saltado!", 10000, {["background-color"] = "#CD472A", ["color"] = "#ffffff"})
        if not DoesBlipExist(blip) then
            blip = AddBlipForCoord(UTK.Banks[name].doors.startloc.x, UTK.Banks[name].doors.startloc.y, UTK.Banks[name].doors.startloc.z)
            SetBlipSprite(blip, 161)
            SetBlipScale(blip, 2.0)
            SetBlipColour(blip, 1)

            PulseBlip(blip)
            Citizen.Wait(240000)
            RemoveBlip(blip)
        end
    end
end)

AddEventHandler("utk_fh:freezeDoors", function()
    Citizen.CreateThread(function()
        while true do
            local pedcoords = GetEntityCoords(PlayerPedId())

            for k, v in pairs(UTK.Banks) do
                if Freeze[k] < 3 then
                    local dst = GetDistanceBetweenCoords(pedcoords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)

                    if dst < 10 then
                        local obj = ESX.Game.GetClosestObject(UTK.door, vector3(v.doors.secondloc.x, v.doors.secondloc.y, v.doors.secondloc.z))

                        FreezeEntityPosition(obj, true)
                        Freeze[k] = Freeze[k] + 1
                    end
                end
            end
            if Freeze.F1 > 3 and Freeze.F2 > 3 and Freeze.F3 > 3 and Freeze.F4 > 3 and Freeze.F5 > 3 and Freeze.F6 > 3 then
                Citizen.Wait(5000)
            end
            Citizen.Wait(500)
        end
    end)
end)

AddEventHandler("utk_fh:reset", function(name, data)
    for i = 1, #LootCheck[name], 1 do
        LootCheck[name][i] = false
    end
    Check[name] = false
    exports["mythic_notify"]:SendAlert("error", "La puerta de la camara se cerrara en 30 segundos!")
    Citizen.Wait(30000)
    exports["mythic_notify"]:SendAlert("error", "La puerta de la camara se esta cerrando!")
    if data.hash == nil then
        TriggerServerEvent("utk_fh:openDoor", vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z), 4)
    elseif not data.hash == nil then
        TriggerServerEvent("utk_fh:openDoor", vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z), 5)
    end
    TriggerEvent("utk_fh:cleanUp", data, name)
end)

AddEventHandler("utk_fh:startheist", function(data, name)
    disableinput = true
    currentname = name
    currentcoords = vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z)
    initiator = true
    RequestModel("p_ld_id_card_01")
    while not HasModelLoaded("p_ld_id_card_01") do
        Citizen.Wait(1)
    end
    local ped = PlayerPedId()

    SetEntityCoords(ped, data.doors.startloc.animcoords.x, data.doors.startloc.animcoords.y, data.doors.startloc.animcoords.z)
    SetEntityHeading(ped, data.doors.startloc.animcoords.h)
    local pedco = GetEntityCoords(PlayerPedId())
    IdProp = CreateObject(GetHashKey("p_ld_id_card_01"), pedco, 1, 1, 0)
    local boneIndex = GetPedBoneIndex(PlayerPedId(), 28422)

    AttachEntityToEntity(IdProp, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_ATM", 0, true)
    exports['progressBars']:startUI(2000, "Usando tarjeta malware")
    Citizen.Wait(1500)
    DetachEntity(IdProp, false, false)
    SetEntityCoords(IdProp, data.prop.first.coords, 0.0, 0.0, 0.0, false)
    SetEntityRotation(IdProp, data.prop.first.rot, 1, true)
    FreezeEntityPosition(IdProp, true)
    Citizen.Wait(500)
    ClearPedTasksImmediately(ped)
    disableinput = false
    Citizen.Wait(1000)
    Process(UTK.hacktime, "Hackeo en progreso")
    exports["mythic_notify"]:SendAlert("success", "Hackeo Completo!")
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    if data.hash == nil then
        TriggerServerEvent("utk_fh:openDoor", vector3(data.doors.startloc.x, data.doors.startloc.y, data.doors.startloc.z), 1)
    elseif data.hash ~= nil then
        TriggerServerEvent("utk_fh:openDoor", "anana", 2)
    end
    startdstcheck = true
    currentname = name
    exports["mythic_notify"]:SendAlert("error", "Tienes 2 minutos antes de que el sistema de seguridad se reactive.")
    SpawnTrolleys(data, name)
end)

AddEventHandler("utk_fh:cleanUp", function(data, name)
    Citizen.Wait(60000)
    for i = 1, 3, 1 do -- full trolley clean
        local obj = GetClosestObjectOfType(data.objects[i].x, data.objects[i].y, data.objects[i].z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    for j = 1, 3, 1 do -- empty trolley clean
        local obj = GetClosestObjectOfType(data.objects[j].x, data.objects[j].y, data.objects[j].z, 0.75, GetHashKey("hei_prop_hei_cash_trolly_03"), false, false, false)

        if DoesEntityExist(obj) then
            DeleteEntity(obj)
        end
    end
    if DoesEntityExist(IdProp) then
        DeleteEntity(IdProp)
    end
    if DoesEntityExist(IdProp2) then
        DeleteEntity(IdProp2)
    end
    TriggerServerEvent("utk_fh:setCooldown", name)
    initiator = false
end)

function SecondDoor(data)
    disableinput = true
    RequestModel("p_ld_id_card_01")
    while not HasModelLoaded("p_ld_id_card_01") do
        Citizen.Wait(1)
    end
    local ped = PlayerPedId()

    SetEntityCoords(ped, data.doors.secondloc.animcoords.x, data.doors.secondloc.animcoords.y, data.doors.secondloc.animcoords.z)
    SetEntityHeading(ped, data.doors.secondloc.animcoords.h)
    local pedco = GetEntityCoords(PlayerPedId())
    IdProp2 = CreateObject(GetHashKey("p_ld_id_card_01"), pedco, 1, 1, 0)
    local boneIndex = GetPedBoneIndex(PlayerPedId(), 28422)

    AttachEntityToEntity(IdProp2, ped, boneIndex, 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
    TaskStartScenarioInPlace(ped, "PROP_HUMAN_ATM", 0, true)
    exports['progressBars']:startUI(2000, "Usando Tarjeta de identificacion")
    Citizen.Wait(1500)
    DetachEntity(IdProp2, false, false)
    SetEntityCoords(IdProp2, data.prop.second.coords, 0.0, 0.0, 0.0, false)
    SetEntityRotation(IdProp2, data.prop.second.rot, 1, true)
    FreezeEntityPosition(IdProp2, true)
    Citizen.Wait(1000)
    ClearPedTasksImmediately(ped)
    disableinput = false
    Process(2000, "Accediendo al panel")
    exports["mythic_notify"]:SendAlert("success", "Acceso permitido")
    PlaySoundFrontend(-1, "ATM_WINDOW", "HUD_FRONTEND_DEFAULT_SOUNDSET")
    TriggerServerEvent("utk_fh:openDoor", vector3(data.doors.secondloc.x, data.doors.secondloc.y, data.doors.secondloc.z), 3)
    disableinput = false
end

function Process(ms, text)
    exports['progressBars']:startUI(ms, text)
    Citizen.Wait(ms)
end

function SpawnTrolleys(data, name)
    RequestModel("hei_prop_hei_cash_trolly_01")
    while not HasModelLoaded("hei_prop_hei_cash_trolly_01") do
        Citizen.Wait(1)
    end
    Trolley1 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley1.x, data.trolley1.y, data.trolley1.z, 1, 1, 0)
    Trolley2 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley2.x, data.trolley2.y, data.trolley2.z, 1, 1, 0)
    Trolley3 = CreateObject(GetHashKey("hei_prop_hei_cash_trolly_01"), data.trolley3.x, data.trolley3.y, data.trolley3.z, 1, 1, 0)
    local h1 = GetEntityHeading(Trolley1)
    local h2 = GetEntityHeading(Trolley2)
    local h3 = GetEntityHeading(Trolley3)

    SetEntityHeading(Trolley1, h1 + UTK.Banks[name].trolley1.h)
    SetEntityHeading(Trolley2, h2 + UTK.Banks[name].trolley2.h)
    SetEntityHeading(Trolley3, h3 + UTK.Banks[name].trolley3.h)
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(PlayerPedId()), 20.0)
    local missionplayers = {}
    print(tostring(players))
    for i = 1, #players, 1 do
        if players[i] ~= PlayerId() then
            table.insert(missionplayers, GetPlayerServerId(players[i]))
        end
    end
    TriggerServerEvent("utk_fh:startLoot", data, name, missionplayers)
    done = false
end

function StartGrab(name)
    disableinput = true
    local ped = PlayerPedId()
    local model = "hei_prop_heist_cash_pile"

    Trolley = GetClosestObjectOfType(GetEntityCoords(ped), 1.0, GetHashKey("hei_prop_hei_cash_trolly_01"), false, false, false)
    local CashAppear = function()
	    local pedCoords = GetEntityCoords(ped)
        local grabmodel = GetHashKey(model)

        RequestModel(grabmodel)
        while not HasModelLoaded(grabmodel) do
            Citizen.Wait(100)
        end
	    local grabobj = CreateObject(grabmodel, pedCoords, true)

	    FreezeEntityPosition(grabobj, true)
	    SetEntityInvincible(grabobj, true)
	    SetEntityNoCollisionEntity(grabobj, ped)
	    SetEntityVisible(grabobj, false, false)
	    AttachEntityToEntity(grabobj, ped, GetPedBoneIndex(ped, 60309), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
	    local startedGrabbing = GetGameTimer()

	    Citizen.CreateThread(function()
		    while GetGameTimer() - startedGrabbing < 37000 do
			    Citizen.Wait(1)
			    DisableControlAction(0, 73, true)
			    if HasAnimEventFired(ped, GetHashKey("CASH_APPEAR")) then
				    if not IsEntityVisible(grabobj) then
					    SetEntityVisible(grabobj, true, false)
				    end
			    end
			    if HasAnimEventFired(ped, GetHashKey("RELEASE_CASH_DESTROY")) then
				    if IsEntityVisible(grabobj) then
                        SetEntityVisible(grabobj, false, false)
                        TriggerServerEvent("utk_fh:rewardCash")
				    end
			    end
		    end
		    DeleteObject(grabobj)
	    end)
    end
	local trollyobj = Trolley
    local emptyobj = GetHashKey("hei_prop_hei_cash_trolly_03")

	if IsEntityPlayingAnim(trollyobj, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 3) then
		return
    end
    local baghash = GetHashKey("hei_p_m_bag_var22_arm_s")

    RequestAnimDict("anim@heists@ornate_bank@grab_cash")
    RequestModel(baghash)
    RequestModel(emptyobj)
    while not HasAnimDictLoaded("anim@heists@ornate_bank@grab_cash") and not HasModelLoaded(emptyobj) and not HasModelLoaded(baghash) do
        Citizen.Wait(100)
    end
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	local bag = CreateObject(GetHashKey("hei_p_m_bag_var22_arm_s"), GetEntityCoords(PlayerPedId()), true, false, false)
    local scene1 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene1, "anim@heists@ornate_bank@grab_cash", "intro", 1.5, -4.0, 1, 16, 1148846080, 0)
    NetworkAddEntityToSynchronisedScene(bag, scene1, "anim@heists@ornate_bank@grab_cash", "bag_intro", 4.0, -8.0, 1)
    SetPedComponentVariation(ped, 5, 0, 0, 0)
	NetworkStartSynchronisedScene(scene1)
	Citizen.Wait(1500)
	CashAppear()
	local scene2 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene2, "anim@heists@ornate_bank@grab_cash", "grab", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene2, "anim@heists@ornate_bank@grab_cash", "bag_grab", 4.0, -8.0, 1)
	NetworkAddEntityToSynchronisedScene(trollyobj, scene2, "anim@heists@ornate_bank@grab_cash", "cart_cash_dissapear", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene2)
	Citizen.Wait(37000)
	local scene3 = NetworkCreateSynchronisedScene(GetEntityCoords(trollyobj), GetEntityRotation(trollyobj), 2, false, false, 1065353216, 0, 1.3)

	NetworkAddPedToSynchronisedScene(ped, scene3, "anim@heists@ornate_bank@grab_cash", "exit", 1.5, -4.0, 1, 16, 1148846080, 0)
	NetworkAddEntityToSynchronisedScene(bag, scene3, "anim@heists@ornate_bank@grab_cash", "bag_exit", 4.0, -8.0, 1)
	NetworkStartSynchronisedScene(scene3)
    NewTrolley = CreateObject(emptyobj, GetEntityCoords(trollyobj) + vector3(0.0, 0.0, - 0.985), true)
    --TriggerServerEvent("utk_fh:updateObj", name, NewTrolley, 2)
    SetEntityRotation(NewTrolley, GetEntityRotation(trollyobj))
	while not NetworkHasControlOfEntity(trollyobj) do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(trollyobj)
	end
	DeleteObject(trollyobj)
    PlaceObjectOnGroundProperly(NewTrolley)
	Citizen.Wait(1800)
	DeleteObject(bag)
    SetPedComponentVariation(ped, 5, 45, 0, 0)
	RemoveAnimDict("anim@heists@ornate_bank@grab_cash")
	SetModelAsNoLongerNeeded(emptyobj)
    SetModelAsNoLongerNeeded(GetHashKey("hei_p_m_bag_var22_arm_s"))
    disableinput = false
end

Citizen.CreateThread(function()
    while true do
        if startdstcheck then
            if initiator then
                local playercoord = GetEntityCoords(PlayerPedId())

                if (GetDistanceBetweenCoords(playercoord, currentcoords, true)) > 20 then
                    LootCheck[currentname].Stop = true
                    startdstcheck = false
                    TriggerServerEvent("utk_fh:stopHeist", currentname)
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if not done then
            local pedcoords = GetEntityCoords(PlayerPedId())
            local dst = GetDistanceBetweenCoords(pedcoords, UTK.Banks[currentname].doors.secondloc.x, UTK.Banks[currentname].doors.secondloc.y, UTK.Banks[currentname].doors.secondloc.z, true)

            if dst < 4 then
                DrawText3D(UTK.Banks[currentname].doors.secondloc.x, UTK.Banks[currentname].doors.secondloc.y, UTK.Banks[currentname].doors.secondloc.z, "[~r~E~w~] Usar tarjeta de empleado", 0.40)
                if dst < 0.75 and IsControlJustReleased(0 , 38) then
                    ESX.TriggerServerCallback("utk_fh:checkSecond", function(result)
                        if result then
                            done = true
                            return SecondDoor(UTK.Banks[currentname])
                        elseif not result then
                            exports["mythic_notify"]:SendAlert("error", "No tienes la tarjeta de empleado.")
                        end
                    end)
                end
            end
            if LootCheck[currentname].Stop then
                done = true
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    local resettimer = UTK.timer

    while true do
        if startdstcheck then
            if initiator then
                if UTK.timer > 0 then
                    Citizen.Wait(1000)
                    UTK.timer = UTK.timer - 1
                elseif UTK.timer == 0 then
                    startdstcheck = false
                    TriggerServerEvent("utk_fh:stopHeist", currentname)
                    UTK.timer = resettimer
                end
            end
            Citizen.Wait(1)
        else
            Citizen.Wait(1000)
        end
    end
end)

Citizen.CreateThread(function()
    while true do
        if startdstcheck then
            if initiator then
                ShowTimer()
            end
        end
        Citizen.Wait(1)
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(1)
    end
    ESX.TriggerServerCallback("utk_fh:getBanks", function(result)
        UTK.Banks = result
    end)
    TriggerEvent("utk_fh:freezeDoors")
    Citizen.Wait(1000)
    while true do
        local coords = GetEntityCoords(PlayerPedId())

        for k, v in pairs(UTK.Banks) do
            if not v.onaction then
                local dst = GetDistanceBetweenCoords(coords, v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, true)

                if dst <= 5 and not Check[k] then
                    DrawText3D(v.doors.startloc.x, v.doors.startloc.y, v.doors.startloc.z, "[~r~E~w~] Empezar robo al banco", 0.40)
                    if dst <= 1 and IsControlJustReleased(0, 38) then
                        TriggerServerEvent("utk_fh:startcheck", k)
                    end
                end
            end
        end
        Citizen.Wait(1)
    end
end)