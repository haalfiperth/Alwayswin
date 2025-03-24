local OriginalGetFenv; OriginalGetFenv = hookfunction(getrenv().getfenv, newcclosure(function(Level)
    if not checkcaller() then
        task.wait(15e15)
        return {sigma = function() return 0 end, balls = 1, tablehooked = {}}
    end
    return OriginalGetFenv(Level)
end))

local Old; Old = hookfunction(getrenv().debug.info, newcclosure(function(...)
    local LevelOrFunc, Info = ...
    if ( Detected and LevelOrFunc == Detected ) then
        return coroutine.yield(coroutine.running())
    end
    return Old(...)
end))

local getinfo = getinfo or debug.getinfo
local DEBUG = false
local Hooked = {}
local Detected, Kill
for i, v in getgc(true) do
    if ( typeof(v) == 'table' ) then
        local DetectFunc = rawget(v, 'Detected')
        local KillFunc = rawget(v, 'Kill')
        if ( typeof(DetectFunc) == 'function' and not Detected ) then
            Detected = DetectFunc
            local Old; Old = hookfunction(Detected, newcclosure(function(Action, Info, NoCrash)
                if ( Action ~= '_' ) then
                    end
                return true
            end))
            table.insert(Hooked, Detected)
        end
        if ( rawget(v, 'Variables') and rawget(v, 'Process') and typeof(KillFunc) == 'function' and not Kill ) then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill, newcclosure(function(Info)
            end))
            table.insert(Hooked, Kill)
        end
    end
end

assert(getrawmetatable)
grm = getrawmetatable(game)
setreadonly(grm, false)
old = grm.__namecall

grm.__namecall = newcclosure(function(self, ...)
    local args = {...}  

    local methodName = tostring(args[1])

    local blockedMethods = {"TeleportDetect", "CHECKER_1", "CHECKER", "GUI_CHECK", "OneMoreTime", "checkingSPEED", "BANREMOTE", "PERMAIDBAN", "KICKREMOTE", "BR_KICKPC", "BR_KICKMOBILE"}

    if table.find(blockedMethods, methodName) then return end

    return old(self, ...)
end)
