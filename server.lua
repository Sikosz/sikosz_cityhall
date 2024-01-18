RegisterServerEvent('sikosz_cityhall:purchase')
AddEventHandler('sikosz_cityhall:purchase', function(itemId)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if itemId == config.driveritem and config.driverlicense then
        TriggerEvent('esx_license:getLicenses', _source, function(licenses)
            local hasDriverLicense = false

            for i = 1, #licenses, 1 do
                if licenses[i].type == 'drive' then
                    hasDriverLicense = true
                end
            end

            if not hasDriverLicense then
                TriggerClientEvent('esx:showNotification', _source, 'Még nem tetted le a jogosítványt!')
            else
                if xPlayer.getInventoryItem(itemId).count < 1 then
                if xPlayer.getMoney() >= config.purchasePrice then
                    xPlayer.removeMoney(config.purchasePrice)
                    xPlayer.addInventoryItem(itemId, 1)
                    xPlayer.getInventoryItem(itemId).owner = xPlayer.id
                    TriggerClientEvent('esx:showNotification', _source, 'Vettél egy ' .. itemId .. '-t')
                else
                    TriggerClientEvent('esx:showNotification', _source, 'Nincs elég pénzed a jogosítvány megvásárlásához! Még kell ' ..config.purchasePrice - xPlayer.getMoney().. '$')
                end
                else
                TriggerClientEvent('esx:showNotification', _source, 'Már van nálad '..itemId)
            end
        end
        end)
    else
        if xPlayer.getInventoryItem(itemId).count < 1 then
        if xPlayer.getMoney() >= config.purchasePrice then
            xPlayer.removeMoney(config.purchasePrice)
            xPlayer.addInventoryItem(itemId, 1)
            xPlayer.getInventoryItem(itemId).owner = xPlayer.id
            TriggerClientEvent('esx:showNotification', _source, 'Vettél egy ' .. itemId .. '-t')
        else
            TriggerClientEvent('esx:showNotification', _source, 'Nincs elég pénzed a jogosítvány megvásárlásához! Még kell ' ..config.purchasePrice - xPlayer.getMoney().. '$')
        end
        else
            TriggerClientEvent('esx:showNotification', _source, 'Már van nálad '..itemId)
        end
    end
end)

RegisterServerEvent('sikosz_cityhall:setjob')
AddEventHandler('sikosz_cityhall:setjob', function(jobId)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.setJob(jobId, 0)
end)