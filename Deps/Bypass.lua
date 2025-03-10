local OriginalGetFenv; OriginalGetFenv = hookfunction(getrenv().getfenv, newcclosure(function(Level)
    if not checkcaller() then
        task.wait(15e15)
        return {sigma = function() return 0 end, balls = 1, tablehooked = {}}
    end
    return OriginalGetFenv(Level)
end))
