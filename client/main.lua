--##SKRÓTY KLAWISZOWE##

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

--##KONIEC SKRÓTY KLAWISZOWE##

ESX = nil


local przycisk = 57 --WYBIERANIE PRZYCISKU KTÓRY OTWIERA MENU(U GÓRY LISTA SKRÓTÓW)

--##URUCHOMIENIE ESX##

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

--##KONIEC ESX##

--##FUNKCJA TWORZĄCA MENU ESX##

function OtworzMenu()
    ESX.UI.Menu.CloseAll()


    ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'menu',
    {
        title   = 'Kontrola Drzwi',
        align   = 'top',
        elements =
        {
            { label = '[PRZÓD] Drzwi prawe', value = 'drz_praw_p'},
            { label = '[PRZÓD] Drzwi lewe', value = 'drz_lewe_p'},
            { label = '[TYŁ] Drzwi prawe', value = 'drz_praw_t'},
            { label = '[TYŁ] Drzwi lewe', value = 'drz_lewe_t'},
            { label = 'Maska', value = 'maska'},
            { label = 'Bagażnik', value = 'bagaz'}
        }
    },  function(data, menu)
            
            local action = data.current.value

            if action == 'drz_praw_p' then
                TriggerEvent('drz_praw_p')
            elseif action == 'drz_lewe_p' then
                TriggerEvent('drz_lewe_p')
            elseif action == 'drz_praw_t' then
                TriggerEvent('drz_praw_t')
            elseif action == 'drz_lewe_t' then
                TriggerEvent('drz_lewe_t')
            elseif action == 'maska' then
                TriggerEvent('maska')
            elseif action == 'bagaz' then
                TriggerEvent('bagaz')
            end
    
    end, function(data, menu)
            menu.close()
    end)
end

--##KONIEC MENU##


--##POCZĄTEK POSZCZEGÓLNYCH FUNKCJI##


--##OTWIERANIE PRAWYCH DRZWI Z PRZODU##
RegisterNetEvent('drz_praw_p')
AddEventHandler('drz_praw_p', function()
    local player = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(player, false)
    local czyOtwarte = GetVehicleDoorAngleRatio(playerVeh, 1)
    
    if (IsPedSittingInAnyVehicle(player)) then 
        if (GetPedInVehicleSeat(playerVeh, -1 ) == player) then
            if (czyOtwarte == 0) then
                SetVehicleDoorOpen(playerVeh, 1, false, false)
            else
                SetVehicleDoorShut(playerVeh, 1, false)
            end
        else
            TriggerEvent("pNotify:SendNotification", {text = "Musisz być kierowcą, aby to zrobić", type = "info", timeout = 4000})
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = "Musisz być w pojeździe, aby to zrobić", type = "info", timeout = 5000})
    end
end)

--##OTWIERANIE LEWYCH DRZWI Z PRZODU##
RegisterNetEvent('drz_lewe_p')
AddEventHandler('drz_lewe_p', function()
    local player = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(player, false)
    local czyOtwarte = GetVehicleDoorAngleRatio(playerVeh, 0)

    if (IsPedSittingInAnyVehicle(player)) then 
        if (GetPedInVehicleSeat(playerVeh, -1 ) == player) then
            if (czyOtwarte == 0) then
                SetVehicleDoorOpen(playerVeh, 0, false, false)
            else
                SetVehicleDoorShut(playerVeh, 0, false)
            end
        else
            TriggerEvent("pNotify:SendNotification", {text = "Musisz być kierowcą, aby to zrobić", type = "info", timeout = 4000})
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = "Musisz być w pojeździe, aby to zrobić", type = "info", timeout = 5000})
    end
end)

--##OTWIERANIE PRAWYCH DRZWI Z TYŁU##
RegisterNetEvent('drz_praw_t')
AddEventHandler('drz_praw_t', function()
    local player = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(player, false)
    local czyOtwarte = GetVehicleDoorAngleRatio(playerVeh, 3)

    if (IsPedSittingInAnyVehicle(player)) then 
        if (GetPedInVehicleSeat(playerVeh, -1 ) == player) then
            if (czyOtwarte == 0) then
                SetVehicleDoorOpen(playerVeh, 3, false, false)
            else
                SetVehicleDoorShut(playerVeh, 3, false)
            end
        else
            TriggerEvent("pNotify:SendNotification", {text = "Musisz być kierowcą, aby to zrobić", type = "info", timeout = 4000})
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = "Musisz być w pojeździe, aby to zrobić", type = "info", timeout = 5000})
    end
end)

--##OTWIERANIE LEWYCH DRZWI Z TYŁU##
RegisterNetEvent('drz_lewe_t')
AddEventHandler('drz_lewe_t', function()
    local player = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(player, false)
    local czyOtwarte = GetVehicleDoorAngleRatio(playerVeh, 2)

    if (IsPedSittingInAnyVehicle(player)) then 
        if (GetPedInVehicleSeat(playerVeh, -1 ) == player) then
            if (czyOtwarte == 0) then
                SetVehicleDoorOpen(playerVeh, 2, false, false)
            else
                SetVehicleDoorShut(playerVeh, 2, false)
            end
        else
            TriggerEvent("pNotify:SendNotification", {text = "Musisz być kierowcą, aby to zrobić", type = "info", timeout = 4000})
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = "Musisz być w pojeździe, aby to zrobić", type = "info", timeout = 5000})
    end
end)


--##OTWIERANIE MASKI##
RegisterNetEvent('maska')
AddEventHandler('maska', function()
    local player = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(player, false)
    local czyOtwarte = GetVehicleDoorAngleRatio(playerVeh, 4)

    if (IsPedSittingInAnyVehicle(player)) then 
        if (GetPedInVehicleSeat(playerVeh, -1 ) == player) then
            if (czyOtwarte == 0) then
                SetVehicleDoorOpen(playerVeh, 4, false, false)
            else
                SetVehicleDoorShut(playerVeh, 4, false)
            end
        else
            TriggerEvent("pNotify:SendNotification", {text = "Musisz być kierowcą, aby to zrobić", type = "info", timeout = 4000})
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = "Musisz być w pojeździe, aby to zrobić", type = "info", timeout = 5000})
    end
end)

--##OTWIERANIE BAGAŻNIKA##
RegisterNetEvent('bagaz')
AddEventHandler('bagaz', function()
    local player = GetPlayerPed(-1)
    local playerVeh = GetVehiclePedIsIn(player, false)
    local czyOtwarte = GetVehicleDoorAngleRatio(playerVeh, 5)

    if (IsPedSittingInAnyVehicle(player)) then 
        if (GetPedInVehicleSeat(playerVeh, -1 ) == player) then
            if (czyOtwarte == 0) then
                SetVehicleDoorOpen(playerVeh, 5, false, false)
            else
                SetVehicleDoorShut(playerVeh, 5, false)
            end
        else
            TriggerEvent("pNotify:SendNotification", {text = "Musisz być kierowcą, aby to zrobić", type = "info", timeout = 4000})
        end
    else
        TriggerEvent("pNotify:SendNotification", {text = "Musisz być w pojeździe, aby to zrobić", type = "info", timeout = 5000})
    end
end)

--##FUNKCJA URUCHAMIAJĄCA MENU PO KLIKNIĘCIU PRZYCISKU WYBRANEGO U GÓRY##
Citizen.CreateThread(function()
  while true do
    Wait(1)
    if IsControlJustReleased(0, przycisk) then
      OtworzMenu()
    end
  end
end)