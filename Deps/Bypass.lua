local OldGetFenv; OldGetFenv = hookfunction(getrenv().getfenv, function(...)
      if not checkcaller() then
          return coroutine.yield()
      end
      return OldGetFenv(...)
  end)
