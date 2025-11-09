if (getgenv().AW_LOADED) then
	return
end
getgenv().AW_LOADED = true

loadstring(game:HttpGet("https://api.getpolsec.com/scripts/82f824cccf840240068fc9cc21df83f7.lua"))()
