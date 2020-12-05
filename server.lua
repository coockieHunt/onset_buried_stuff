-- author = coockie_hunt (https://github.com/coockieHunt?tab=repositories)
-- for = weon team (no public git)
-- utils buried stuff

local ATTACHED_OBJECT = nil
local BURIED_LIST = {}

-- atach detector to player
function cmd_get_detector(_player)
    if(ATTACHED_OBJECT == nil) then
        local Px, Py, Pz = GetPlayerLocation(_player)
        local object = CreateObject(1039, Px, Py, Pz)
        ATTACHED_OBJECT = object
        SetObjectAttached(object, ATTACH_PLAYER, _player, -96, 17.5, -30, 290, 10, -25.0, "hand_r")
    else
        AddPlayerChat(_player, "already attached, please destroy use /destroy")
    end
end

-- detroy detector attached to player
function cmd_destroy_attached(_player)
    if(ATTACHED_OBJECT ~= nil) then
        DestroyObject(ATTACHED_OBJECT)
        ATTACHED_OBJECT = nil
    else
        AddPlayerChat(_player, "attached nil, please attach use /get")
    end
end

-- create buried stuff
function cmd_buried_stuff(_player)
    -- create object
    local Px, Py, Pz = GetPlayerLocation(_player)
    local object = CreateObject(2, Px, Py, Pz)

    -- register bs
    new_registry_buried_stuff(_player, Px, Py, Pz)
    
end

-- teleport to burieed stuff
function cmd_buried_teleport(_player, _id)
    local identifier = tonumber(_id)
    if(BURIED_LIST[identifier] == nil) then 
        AddPlayerChat(_player, "invalid identifier")
        return nil
    end

    local element = BURIED_LIST[identifier]
    SetPlayerLocation(_player, element.x, element.y, element.z)
    AddPlayerChat(_player, "OK teleport")
end


AddCommand("get", cmd_get_detector)
AddCommand("destroy", cmd_destroy_attached)
AddCommand("new_buried", cmd_buried_stuff)
AddCommand("tp_buried", cmd_buried_teleport)

-- FUNC
-- registry buried
function new_registry_buried_stuff(_playerID, _PosX, _PosY, _PosZ)
    if(_playerID == nil or _PosX == nil or _PosY == nil or _PosZ == nil) then
        Print("[buried_Stuff] registry error nill parameter")
        return nil
    end

    local index_id = tablelength(BURIED_LIST) + 1
    print("-> new registry buried stuff : ", index_id, _playerID, _PosX, _PosY, _PosZ)
    BURIED_LIST[index_id]= {}
    BURIED_LIST[index_id].createAt = os.time(os.date("!*t"))
    BURIED_LIST[index_id].playerId = _playerID
    BURIED_LIST[index_id].x = _PosX
    BURIED_LIST[index_id].y = _PosY
    BURIED_LIST[index_id].z = _PosZ
end


--DEBUG
function cmd_view_bureied_stuff(_player)
    local element_count = tablelength(BURIED_LIST)
    AddPlayerChat(_player, element_count .. " element")

    for i, v in pairs(BURIED_LIST) do 
        AddPlayerChat(_player, "------------------------")
        AddPlayerChat(_player, "buried id : [" .. i .. "]")
        AddPlayerChat(_player, "create at : [" .. v.createAt .. "]")
        AddPlayerChat(_player, "player id :" .. v.playerId)
        AddPlayerChat(_player, "x :" .. v.x)
        AddPlayerChat(_player, "y :" .. v.y)
        AddPlayerChat(_player, "z :" .. v.z)
    end
end
AddCommand("list_buried", cmd_view_bureied_stuff)

--UTILS
function tablelength(T)
    local count = 0
    for _ in pairs(T) do count = count + 1 end
    return count
  end