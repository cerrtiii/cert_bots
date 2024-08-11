local function createBot()
    local model = GetHashKey("a_m_y_business_01") -- You can change the model
    RequestModel(model)

    while not HasModelLoaded(model) do
        Wait(1)
    end

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local botPed = CreatePed(4, model, playerCoords.x + math.random(-10, 10), playerCoords.y + math.random(-10, 10), playerCoords.z, 0.0, true, false)
    
    -- Make the bot wander
    TaskWanderStandard(botPed, 10.0, 10)

    -- Add bot to the player list (this is a simulated approach)
    NetworkRegisterEntityAsNetworked(botPed)
    SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(botPed), true)
    SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(botPed), true)

    -- Store bot ped for removal later
    TriggerServerEvent('cert_bots:storeBot', NetworkGetNetworkIdFromEntity(botPed))
end

RegisterNetEvent('cert_bots:createBot')
AddEventHandler('cert_bots:createBot', function()
    createBot()
end)

RegisterNetEvent('cert_bots:removeBot')
AddEventHandler('cert_bots:removeBot', function(botNetId)
    if NetworkDoesNetworkIdExist(botNetId) then
        local botPed = NetworkGetEntityFromNetworkId(botNetId)
        DeleteEntity(botPed)
    end
end)
