ESX = exports['es_extended']:getSharedObject()

require('config')

RegisterServerEvent('daritemrobado')
AddEventHandler('daritemrobado', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    local randomNumber = math.random(100)
    local cumulativePercentage = 0

    for i, item in ipairs(Config.Items) do
        cumulativePercentage = cumulativePercentage + item.percentage
        if randomNumber <= cumulativePercentage then
            local amount = math.random(item.amount.min, item.amount.max) -- Genera una cantidad aleatoria dentro del rango
            xPlayer.addInventoryItem(item.name, amount)
            break
        end
    end
end)