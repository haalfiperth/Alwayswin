local OriginalNameCall = nil; OriginalNameCall = hookmetamethod(Game, "__namecall", function(Object, ...)
    local Arguments = {...}
    local NameCallMethod = tostring(getnamecallmethod())
    local CallingScript = getcallingscript()
    local CallingFromExecutor = checkcaller()
    
    if Object.Name == "Remote" and NameCallMethod == "FireServer" and #Arguments > 0 and CallingScript.Parent.ClassName == "Model" then
        if string.lower(tostring(Arguments[1])) == "aclog" then
            return nil
        end
    end
    
    return OriginalNameCall(Object, ...)
end)

local Hooked = {}
local Detected,Kill
setthreadidentity(2)
for i,v in getgc(true) do
    if typeof(v) == 'table' then
        local DetectFunc = rawget(v,'Detected')
        local KillFunc = rawget(v,'Kill')
        if typeof(DetectFunc) == 'function' and not Detected then
            Detected = DetectFunc
            local Old; Old = hookfunction(Detected,newcclosure(function(Action,Info,NoCrash)
                return true
            end))
            table.insert(Hooked,Detected)
        end
        if rawget(v,'Variables') and rawget(v,'Process') and typeof(KillFunc) == 'function' and not Kill then
            Kill = KillFunc
            local Old; Old = hookfunction(Kill,newcclosure(function(Info)
            end))
            table.insert(Hooked,Kill)
        end
    end
end

setthreadidentity(7)

assert(getrawmetatable)
grm = getrawmetatable(game)
setreadonly(grm,false)
old = grm.__namecall

grm.__namecall = newcclosure(function(self,...)
    local args = {...}  
    local methodName = tostring(args[1])

    local blockedMethods = {"TeleportDetect","CHECKER_1","CHECKER_4","CHECKER","GUI_CHECK","OneMoreTime","checkingSPEED","BANREMOTE","PERMAIDBAN","KICKREMOTE","BR_KICKPC","BR_KICKMOBILE"}

    if table.find(blockedMethods,methodName) then return end

    return old(self,...)
end)
