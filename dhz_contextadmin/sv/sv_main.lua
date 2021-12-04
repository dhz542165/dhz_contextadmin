ESX = nil
TriggerEvent(Config.DefEsx, function(obj) ESX = obj end)

ESX.RegisterServerCallback('dhz_contextadmin:PermissionOuPas', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local group = xPlayer.getGroup()
	--print(GetPlayerName(source).." - "..group)
	cb(group)
end)

RegisterServerEvent("dhz_contextadmin:GiveCash")
AddEventHandler("dhz_contextadmin:GiveCash", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addMoney((total))
	sendToDisc("[Menu admin]", "**[Action]** \n**[STAFF]**: "..xPlayer.getName().."\n**[Action]**: Give de "..total.."$ d'argent liquide", "Menu admin")
end)

RegisterServerEvent("dhz_contextadmin:GiveBanque")
AddEventHandler("dhz_contextadmin:GiveBanque", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('bank', total)
	sendToDisc("[Menu admin]", "**[Action]** \n**[STAFF]**: "..xPlayer.getName().."\n**[Action]**: Give de "..total.."$ d'argent de banque", "Menu admin")
end)

RegisterServerEvent("dhz_contextadmin:GiveND")
AddEventHandler("dhz_contextadmin:GiveND", function(money)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local total = money
	
	xPlayer.addAccountMoney('black_money', total)
	sendToDisc("[Menu admin]", "**[Action]** \n**[STAFF]**: "..xPlayer.getName().."\n**[Action]**: Give de "..total.."$ d'argent sale", "Menu admin")
end)

RegisterServerEvent("dhz_contextadmin:webhook")
AddEventHandler("dhz_contextadmin:webhook", function(title, message, footer)
	local source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	sendToDisc(title, message, footer)
end)

function sendToDisc(title, message, footer)
    local embed = {}
    embed = {
        {
            ["color"] = math.random(111111,999999), 
            ["title"] = "**".. title .."**",
            ["description"] = "" .. message ..  "",
            ["footer"] = {
                ["text"] = footer,
            },
        }
    }
    PerformHttpRequest(Config.Webhook, function(err, text, headers) end, 'POST', json.encode({username = Config.NomWebhook, embeds = embed, avatar_url = Config.LogoWebhook}), { ['Content-Type'] = 'application/json' })
end

TriggerEvent('es:addGroupCommand', 'kick', "mod", function(source, args, user)
	if args[1] then
		if(tonumber(args[1]) and GetPlayerName(tonumber(args[1])))then
			local player = tonumber(args[1])

			-- User permission check
			TriggerEvent("es:getPlayerFromId", player, function(target)

				local reason = args
				table.remove(reason, 1)
				if(#reason == 0)then
					reason = "Kick: Vous avez été kick du serveur"
				else
					reason = "Kick: " .. table.concat(reason, " ")
				end

				TriggerClientEvent('chat:addMessage', -1, {
					args = {"^1ADMIN", "Le joueur ^2" .. GetPlayerName(player) .. "^0 a été kick pour (^2" .. reason .. "^0)"}
				})
				DropPlayer(player, reason)
			end)
		else
			TriggerClientEvent('chat:addMessage', source, { args = {"^1ADMIN", "ID Inexistant"}})
		end
	else
		TriggerClientEvent('chat:addMessage', source, { args = {"^1ADMIN", "ID Inexistant"}})
	end
end, function(source, args, user)
	TriggerClientEvent('chat:addMessage', source, { args = {"^1ADMIN", "Permissions insufisantes!"} })
end, {help = "Kick un joueur", params = {{name = "userid", help = "L'id du joueur"}, {name = "reason", help = "La raison de pourquoi vous voulez le kick"}}})