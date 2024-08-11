local botCount = 30 -- Number of bots to create
local botPeds = {}

RegisterCommand('spawnBots', function(source, args, rawCommand)
    for i = 1, botCount do
        TriggerClientEvent('cert_bots:createBot', -1)
    end
end, true)

RegisterNetEvent('cert_bots:storeBot')
AddEventHandler('cert_bots:storeBot', function(botNetId)
    local playerId = source
    if not botPeds[playerId] then
        botPeds[playerId] = {}
    end
    table.insert(botPeds[playerId], botNetId)
end)

AddEventHandler('playerDropped', function()
    local playerId = source
    if botPeds[playerId] then
        for _, botNetId in ipairs(botPeds[playerId]) do
            TriggerClientEvent('cert_bots:removeBot', -1, botNetId)
        end
        botPeds[playerId] = nil
    end
end)




