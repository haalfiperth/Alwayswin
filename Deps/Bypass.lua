task.spawn(function()
    local ProxyTable = {}
    local OldProxy

    OldProxy = hookfunction(getrenv().newproxy,function(...)
        local proxy = OldProxy(...)
        table.insert(ProxyTable,proxy)
        return proxy
    end)
    
    game:GetService("RunService").Stepped:Connect(function()
        for i,v in pairs(ProxyTable) do
            if v == nil then
                ProxyTable[i] = nil
            end
        end
    end)
end)

task.spawn(function()
    repeat Wait() until game:IsLoaded()

    local Amplitude = 200
    local RandomValue = {-200,200}
    local RandomTime = {.1,1}

    local floor = math.floor
    local cos = math.cos
    local sin = math.sin
    local acos = math.acos
    local pi = math.pi

    local Maxima = 0

    while Wait() do
        if gcinfo() >= Maxima then
            Maxima = gcinfo()
        else
            break
        end
    end

    Wait(0.30)

    local OldGcInfo = gcinfo() + Amplitude
    local tick = 0

    local function getreturn()
        local Formula = ((acos(cos(pi * (tick))) / pi * (Amplitude * 2)) + -Amplitude)
        return floor(OldGcInfo + Formula)
    end

    local Old
    Old = hookfunction(getrenv().gcinfo,function(...)
        return getreturn()
    end)

    local Old2
    Old2 = hookfunction(getrenv().collectgarbage,function(arg,...)
        local suc,err = pcall(Old2,arg,...)
        if suc and arg == "count" then
            return getreturn()
        end
        return Old2(arg,...)
    end)

    game:GetService("RunService").Stepped:Connect(function()
        local Formula = ((acos(cos(pi * (tick))) / pi * (Amplitude * 2)) + -Amplitude)
        if Formula > ((acos(cos(pi * (tick) + .01)) / pi * (Amplitude * 2)) + -Amplitude) then
            tick = tick + .07
        else
            tick = tick + 0.01
        end
    end)

    local old1 = Amplitude
    for i,v in next,RandomTime do
        RandomTime[i] = v * 10000
    end

    local RandomTimeValue = math.random(RandomTime[1],RandomTime[2]) / 10000

    while wait(RandomTime) do
        Amplitude = math.random(old1 + RandomValue[1],old1 + RandomValue[2])
        RandomTimeValue = math.random(RandomTime[1],RandomTime[2]) / 10000
    end
end)

task.spawn(function()
    repeat Wait() until game:IsLoaded()

    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")

    local CurrMem = Stats:GetTotalMemoryUsageMb()
    local Rand = 0

    RunService.Stepped:Connect(function()
        local random = math.random
        Rand = random(-10,10)
    end)

    local function GetReturn()
        return CurrMem + Rand
    end

    local _MemBypass
    _MemBypass = hookmetamethod(game,"__namecall",function(self,...)
        local method = getnamecallmethod()

        if not checkcaller() then
            if typeof(self) == "Instance" and (method == "GetTotalMemoryUsageMb" or method == "getTotalMemoryUsageMb") and self.ClassName == "Stats" then
                return GetReturn()
            end
        end

        return _MemBypass(self,...)
    end)
end)

task.spawn(function()
    repeat Wait() until game:IsLoaded()

    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")

    local CurrMem = Stats:GetMemoryUsageMbForTag(Enum.DeveloperMemoryTag.Gui)
    local Rand = 0

    RunService.Stepped:Connect(function()
        local random = math.random
        Rand = random(-0.1,0.1)
    end)

    local function GetReturn()
        return CurrMem + Rand
    end

    local _MemBypass
    _MemBypass = hookmetamethod(game,"__namecall",function(self,...)
        local method = getnamecallmethod()

        if not checkcaller() then
            if typeof(self) == "Instance" and (method == "GetMemoryUsageMbForTag" or method == "getMemoryUsageMbForTag") and self.ClassName == "Stats" then
                return GetReturn()
            end
        end

        return _MemBypass(self,...)
    end)
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

    local blockedMethods = {"TeleportDetect","CHECKER_1","CHECKER","GUI_CHECK","OneMoreTime","checkingSPEED","BANREMOTE","PERMAIDBAN","KICKREMOTE","BR_KICKPC","BR_KICKMOBILE"}

    if table.find(blockedMethods,methodName) then return end

    return old(self,...)
end)
