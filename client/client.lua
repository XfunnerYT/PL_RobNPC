local ESX = exports['es_extended']:getSharedObject()
local lastRobbed = 0

local options = {
    {
        event = 'robarped',
        icon = Config.IconFa,
        label = Config.Label1,
    },
}

local ProggresCircleData = {
    duration = Config.TiempoEspera,
    label = Config.Label1,
    useWhileDead = false,
    canCancel = true,
    position = Config.PositionCircle,
    controlDisables = {
        disableMovement = true,
        disableCarMovement = true,
        disableMouse = false,
        disableCombat = true,
    },
    anim = {
        dict = 'mini@repair',
        clip = 'fixing_a_player',
        duration = Config.TiempoEspera
    },
}

exports.ox_target:addGlobalPed(options)

RegisterNetEvent('robarped')
AddEventHandler('robarped', function()
    local ped = ESX.Game.GetClosestPed()
    if ped then
        if IsPedDeadOrDying(ped, 1) then
            ESX.ShowNotification('No puedes robar a un NPC muerto')
        elseif GetGameTimer() - lastRobbed < 300000 then -- 300000 ms son 5 minutos
            ESX.ShowNotification('Ya has robado recientemente, espera un poco')
        else
            -- Actualizamos el último momento en que se intentó robar a un ped
            lastRobbed = GetGameTimer()

            ESX.ShowNotification('Robando a un ped')
            lib.progressCircle(ProggresCircleData)
            
            local randomNumber = math.random(100)
            if randomNumber <= 50 then
                -- 50% de probabilidad de robar con éxito
                TriggerServerEvent('daritemrobado') -- Ejecutamos el trigger del servidor para dar los items
                Citizen.Wait(Config.TiempoEspera) -- Esperamos el tiempo especificado
            elseif randomNumber <= 75 then
                -- 25% de probabilidad de no poder robar
                ESX.ShowNotification('No has podido robar nada')
            else
                -- 25% de probabilidad de no poder robar y llamar a la policía
                ESX.ShowNotification('No has podido robar nada y el civil ha llamado a la policía')
                ExecuteCommand('entorno Ayuda me estan intentando robar!') -- Ejecutamos el trigger del servidor para llamar a la policía
            end
        end
    end
end)