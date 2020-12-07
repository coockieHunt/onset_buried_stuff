BURIED_STUFF = {}

------
-- FUNC
------
function create_buried_stuff(_playerID, _PosX, _PosY, _PosZ)
    --get value
    local Px, Py, Pz = GetPlayerLocation(_playerID)
    local timeStamp = os.time(os.date("!*t"))


    -- set iterate 
    if (BURIED_STUFF.iterate == nil) then 
        BURIED_STUFF.iterate = 0
    else
        BURIED_STUFF.iterate = BURIED_STUFF.iterate + 1
    end
    local index = BURIED_STUFF.iterate

    -- create object
    local object = CreateObject(2, Px, Py, Pz)

    -- new entry
    BURIED_STUFF[index]  = {}
    BURIED_STUFF[index].objectid = object
    BURIED_STUFF[index].createAt = timeStamp
    BURIED_STUFF[index].playerId = _playerID
    BURIED_STUFF[index].playerIsConnected = true
    BURIED_STUFF[index].x = _PosX
    BURIED_STUFF[index].y = _PosY
    BURIED_STUFF[index].z = _PosZ
end

function destroy_buried_stuff(_id)
    local index = tonumber(_id)

    if(BURIED_STUFF[index] ~= nil) then
        DestroyObject(BURIED_STUFF[index].objectid)
        BURIED_STUFF[index] = nil
    end
end

------
-- CMD
------

function cmd_buiried_manage(_player, _action, _parameter)
    if(_action == "new") then
        local pX, pY, pZ = GetPlayerLocation(_player)

        create_buried_stuff(_player, pX, pY, pZ)
    end

    if(_action == "destroy") then
        destroy_buried_stuff(_parameter)
    end

    if(_action == "list") then
        local element_count = tablelength(BURIED_STUFF) - 1
    
        print("/////////////////////////////////////////////////////////////")
        print(element_count .. " element")
    
        for i, v in pairs(BURIED_STUFF) do 
            if(type(v) == "table") then
                print("------------------------")
                print("buried id : [" .. i .. "]")
                print("connected : [" .. tostring(v.playerIsConnected) .. "]")
                print("object id : [" .. v.objectid .. "]")
                print("create at : [" .. v.createAt .. "]")
                print("player id :" .. v.playerId)
                print("x :" .. v.x)
                print("y :" .. v.y)
                print("z :" .. v.z)
            end
        end
    end
end




AddCommand("br", cmd_buiried_manage)
