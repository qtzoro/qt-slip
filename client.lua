print('Created by: qtzoro')

function Check(ped)
    return IsPedOnFoot(ped) and not IsPedSwimming(ped) and (IsPedRunning(ped) or IsPedSprinting(ped)) and not IsPedClimbing(ped) and IsPedJumping(ped) and not IsPedRagdoll(ped)
end

function Fall(ped)
    local shakeIntensity = Config.ExplosionShakeIntensity
    if shakeIntensity == false then
        shakeIntensity = 0.0
    end
    ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', shakeIntensity)
    SetPedToRagdoll(ped, 5000, 1, 2)
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        local ped = PlayerPedId()
        if Check(ped) then
            local chance_result = math.random()
            if chance_result < Config.FallChance then
                Citizen.Wait(600)
                Fall(ped)
            end
        end
    end
end)