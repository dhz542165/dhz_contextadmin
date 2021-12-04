local ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(Config.DefEsx, function(obj) ESX = obj end)
		Citizen.Wait(1000)
	end
end)

local BaseDuMenu = ContextUI:CreateMenu(1, "Personne") 

local Personnage = ContextUI:CreateSubMenu(BaseDuMenu, "Personnage")
local Argent = ContextUI:CreateSubMenu(BaseDuMenu, "Argent")
local Sanction = ContextUI:CreateSubMenu(BaseDuMenu, "Sanction")

ContextUI:IsVisible(BaseDuMenu, function(Entity)
    local LaPersonne = Entity.ServerID
    ContextUI:Button("~b~ID~s~ : "..LaPersonne, nil, function(Selected)
        if (Selected) then
        end
    end)

    ContextUI:Button("Personnage", nil, function(Selected)
        if (Selected) then
        end
    end,Personnage)

    ContextUI:Button("Argent", nil, function(Selected)
        if (Selected) then
        end
    end,Argent)

    ContextUI:Button("Sanction", nil, function(Selected)
        if (Selected) then
        end
    end,Sanction)
end)

ContextUI:IsVisible(Personnage, function(Entity)
    local LaPersonne = Entity.ServerID
    ContextUI:Button("~r~Revive", nil, function(Selected)
        if (Selected) then
            ExecuteCommand("revive "..LaPersonne)
            TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Revive l'id "..LaPersonne, "Menu Admin")
        end
    end)
    ContextUI:Button("~g~Soigner", nil, function(Selected)
        if (Selected) then
            ExecuteCommand("heal "..LaPersonne)
            TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Heal l'id "..LaPersonne, "Menu Admin")
        end
    end)
    ContextUI:Button("~b~Give un item", nil, function(Selected)
        if (Selected) then
			local objets = KeyboardInput("Objets", "", 50)
			local nombre = KeyboardInput("Nombre", "", 100)
			if objets and nombre then
				ExecuteCommand("giveitem "..LaPersonne.. " " ..objets.. " " ..nombre)
				ESX.ShowNotification("Vous venez de donner ~g~"..nombre.. " " .. objets)	
                TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Give "..nombre.."x "..objets.." à l'id "..LaPersonne, "Menu Admin")
			end
        end
    end)
    ContextUI:Button("~b~Give une arme", nil, function(Selected)
        if (Selected) then
            local weapon = KeyboardInput("WEAPON_...", "", 50)
			local ammo = KeyboardInput("Munitions", "", 100)
			if weapon and ammo then
				ExecuteCommand("giveweapon "..LaPersonne.. " " ..weapon.. " " ..ammo)
				ESX.ShowNotification("Vous venez de donner ~g~"..weapon.. " avec " .. ammo .. " munitions")	
                TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Give "..weapon.." avec "..ammo.." munitions à l'id "..LaPersonne, "Menu Admin")
			end
        end
    end)
end)

ContextUI:IsVisible(Argent, function(Entity)
    local LaPersonne = Entity.ServerID
    ContextUI:Button("Give d'argent ~g~liquide", nil, function(Selected)
        if (Selected) then
            local somme = KeyboardInput("Combien?", "", 8)
            if somme ~= nil then
                somme = tonumber(somme)
                
                if type(somme) == 'number' then
                    TriggerServerEvent('dhz_contextadmin:GiveCash', somme)
                end
            end
        end
    end)
    ContextUI:Button("Give d'argent ~b~banque", nil, function(Selected)
        if (Selected) then
            local somme = KeyboardInput("Combien?", "", 8)
            if somme ~= nil then
                somme = tonumber(somme)
                
                if type(somme) == 'number' then
                    TriggerServerEvent('dhz_contextadmin:GiveBanque', somme)
                end
            end
        end
    end)
    ContextUI:Button("Give d'argent ~r~sale", nil, function(Selected)
        if (Selected) then
            local somme = KeyboardInput("Combien?", "", 8)
            if somme ~= nil then
                somme = tonumber(somme)
                
                if type(somme) == 'number' then
                    TriggerServerEvent('dhz_contextadmin:GiveND', somme)
                end
            end
        end
    end)
end)

ContextUI:IsVisible(Sanction, function(Entity)
    local LaPersonne = Entity.ServerID
    ContextUI:Button("~o~Kick", nil, function(Selected)
        if (Selected) then
            ExecuteCommand("kick "..LaPersonne)
            TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Kick l'id "..LaPersonne, "Menu Admin")
        end
    end)
    ContextUI:Button("~b~Ban 1J", nil, function(Selected)
        if (Selected) then
            local Raison = KeyboardInput("Raison ?", "", 8)
            if Raison ~= nil then
                ExecuteCommand("sqlban "..LaPersonne.. " 1 " ..Raison)
                TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Ban l'id "..LaPersonne.." pendant 1 jour pour "..Raison, "Menu Admin")
            end
        end
    end)
    ContextUI:Button("~y~Ban 2J", nil, function(Selected)
        if (Selected) then
            local Raison = KeyboardInput("Raison ?", "", 8)
            if Raison ~= nil then
                ExecuteCommand("sqlban "..LaPersonne.. " 2 " ..Raison)
                TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Ban l'id "..LaPersonne.." pendant 2 jours pour "..Raison, "Menu Admin")
            end
        end
    end)
    ContextUI:Button("~o~Ban 7J", nil, function(Selected)
        if (Selected) then
            local Raison = KeyboardInput("Raison ?", "", 8)
            if Raison ~= nil then
                ExecuteCommand("sqlban "..LaPersonne.. " 7 " ..Raison)
                TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Ban l'id "..LaPersonne.." pendant 7 jours pour "..Raison, "Menu Admin")
            end
        end
    end)
    ContextUI:Button("~r~Ban permanant", nil, function(Selected)
        if (Selected) then
            local Raison = KeyboardInput("Raison ?", "", 8)
            if Raison ~= nil then
                ExecuteCommand("sqlban "..LaPersonne.. " 0 " ..Raison)
                TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Ban l'id "..LaPersonne.." permanent pour "..Raison, "Menu Admin")
            end
        end
    end)

    ContextUI:Button("~g~Ban durée perso", nil, function(Selected)
        if (Selected) then
            local duree = KeyboardInput("Durée ?", "", 8)
            local Raison = KeyboardInput("Raison ?", "", 8)
            if Raison ~= nil and duree ~= nil then
                ExecuteCommand("sqlban "..LaPersonne.. " "..duree.." " ..Raison)
                if duree == "0" then
                    TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Ban l'id "..LaPersonne.." permanent pour "..Raison, "Menu Admin")
                else
                    TriggerServerEvent("dhz_contextadmin:webhook", "[Menu admin]", "**[ACTION]** \n**[STAFF]**: "..GetPlayerName(PlayerId()).."\n**[ACTION]**: Ban l'id "..LaPersonne.." pendant "..duree.." jour(s) pour "..Raison, "Menu Admin")
                end
            end
        end
    end)
end)

Keys.Register("LMENU", "LMENU", "Menu contextuel", function()
    ESX.TriggerServerCallback('dhz_contextadmin:PermissionOuPas', function(group)
        playergroup = group
    end)
    if playergroup ~= nil and (playergroup == 'mod' or playergroup == 'admin' or playergroup == 'superadmin' ) then
        ContextUI.Focus = not ContextUI.Focus;
    else
        ESX.ShowNotification("Vous n'êtes ~r~pas~s~ staff")
    end

end)

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)
	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) 
	blockinput = true 
	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
		Citizen.Wait(0)
	end
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult() 
		Citizen.Wait(500) 
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end