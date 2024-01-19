local isOpen = false
RegisterCommand('close', function(source, args, rawCommand)
    SetNuiFocus(false, false)
    isOpen = false
end)

RegisterNetEvent('sikosz_cityhall:open')
AddEventHandler('sikosz_cityhall:open', function()
    isOpen = not isOpen
    SetNuiFocus(isOpen, isOpen)

        SendNUIMessage({
            action = 'open',
        })

        if isOpen then
            SendNUIMessage({
                type = 'toggleMenu',
                state = isOpen
            })
        end

        SetNuiFocus(true, true)
end)

RegisterNUICallback('buyItem', function(data, cb)
    TriggerServerEvent('sikosz_cityhall:purchase', data.itemId)
end)

RegisterNUICallback('setJob', function(data, cb)
    TriggerServerEvent('sikosz_cityhall:setjob', data.jobId)
end)

RegisterNUICallback('closeMenu', function()
    SetNuiFocus(false, false)
    isOpen = false
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if isOpen then
            DisableControlAction(0, 1, true)
            DisableControlAction(0, 2, true)
            DisableControlAction(0, 142, true)
            DisableControlAction(0, 106, true)
            DisableControlAction(0, 37, true)
            DisableControlAction(0, 45, true)
        end
    end
end)

Citizen.CreateThread(function()

    while true do
        Citizen.Wait(200)

            if not DoesEntityExist(elado) then
                RequestModel("a_m_m_prolhost_01")

                while not HasModelLoaded("a_m_m_prolhost_01") do
                    Citizen.Wait(200)
                end

                elado = CreatePed(4, "a_m_m_prolhost_01", config.coords)
                SetEntityAsMissionEntity(elado)
                SetEntityHeading(elado, 180.0)

                SetBlockingOfNonTemporaryEvents(elado , true)

                PlaceObjectOnGroundProperly(elado)

                FreezeEntityPosition(elado, true)
                SetEntityInvincible(elado, true)

                TaskStartScenarioInPlace(elado, "WORLD_HUMAN_CLIPBOARD")    
                SetModelAsNoLongerNeeded("a_m_m_prolhost_01") 
            end
    end
end)

local targetlabel = false

Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(5)
        if not config.oxtarget then
            if GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(-1)),  config.coords, true) < 2 then
                ESX.Game.Utils.DrawText3D(config.coords, '~b~[E] ~w~gomb a ~b~városháza ~w~megnyitásához!', 0.6)
                if (IsControlJustReleased(1, 51)) then
                    TriggerEvent('sikosz_cityhall:open')
                end
            end
        else
            if not targetlabel then
                exports.ox_target:addModel('a_m_m_prolhost_01', {
                    {
                        icon = 'fas fa-id-card',
                        label = 'Városháza',
                        distance = 1.5,
                        event = 'sikosz_cityhall:open'
                    },
                })
                targetlabel = true
            end
        end
    end
end)
