------
-- CMD
------
function cmd_get_detector(_player)
    attach_mesh_detector(_player)
end

function cmd_destroy_attached(_player)
    detach_mesh_detector(_player)
end

AddCommand("get", cmd_get_detector)
AddCommand("destroy", cmd_destroy_attached)

------
-- FUNC
------

-- atach detector to player
function attach_mesh_detector(_player)
    if(not IfDetectorAttachedOnPlayer(_player)) then
        local Px, Py, Pz = GetPlayerLocation(_player)
        local object = CreateObject(1039, Px, Py, Pz)
        SetPlayerPropertyValue(_player, "detector", object, true)
        SetObjectAttached(object, ATTACH_PLAYER, _player, -96, 17.5, -30, 290, 10, -25.0, "hand_r")

        print("detector equiped")
    else
        print("already")
    end

end

-- detroy detector attached to player
function detach_mesh_detector(_player)
    if(IfDetectorAttachedOnPlayer(_player)) then
        DestroyObject(GetPlayerPropertyValue(_player, "detector"))
        SetPlayerPropertyValue(_player, "detector", nil, true)
        print("detector destroy")
    else
        print("player not detector")
    end
    
end

function IfDetectorAttachedOnPlayer(_player)
    if(GetPlayerPropertyValue(_player, "detector") ~= nil) then
        return true
    end
    return false
end

