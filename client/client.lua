ESX = exports["es_extended"]:getSharedObject()

local function getMarkersFromConfig()
    local markers = {}
    for i = 1, #Config.Coords, 3 do
        local marker = vector3(Config.Coords[i], Config.Coords[i + 1], Config.Coords[i + 2])
        table.insert(markers, marker)
    end
    return markers
end

local markers = getMarkersFromConfig()

local playerJob = nil

Citizen.CreateThread(function()
    while true do
        ESX.TriggerServerCallback('sc_lc:getJob', function(job)
            playerJob = job
        end)
        Citizen.Wait(5000)
    end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if playerJob == 'police' then
            local playerPed = PlayerPedId()
            local playerCoords = GetEntityCoords(playerPed)

            for _, marker in ipairs(markers) do
                local distance = GetDistanceBetweenCoords(playerCoords, marker.x, marker.y, marker.z, true)

                if distance < 5.0 then
                    DrawMarker(1, marker.x, marker.y, marker.z - 1.0, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 0.5, 36, 144, 218, 0.8, false, true, 2, nil, nil, false)

                    if distance < 1.0 then
                        exports.sc_textUI:showUI(Config.KeyText, Translation[Config.Locale]['open_menu'])

                        if IsControlJustPressed(0, Config.Key) then
                            exports.sc_textUI:hideUI()
                            TriggerServerEvent('sc_lc:checkJobAndOpenMenu')
                        end
                    else
                        exports.sc_textUI:hideUI()
                    end
                end
            end
        end
    end
end)

RegisterCommand('lcm', function()
    TriggerServerEvent('sc_lc:checkJobAndOpenMenu')
end)

RegisterNetEvent('sc_lc:open')
AddEventHandler('sc_lc:open', function()
    lib.showContext('license_menu')
end)

function ShowInputNotification(text)
	SetTextComponentFormat('STRING')
	AddTextComponentString(text)
	EndTextCommandDisplayHelp(0, 0, 1, -1)
end

lib.registerContext({
    id = 'license_menu',
    title = Translation[Config.Locale]['menu_title'],
    options = {
      {
        title = Translation[Config.Locale]['menu_check'],
        icon = 'file-circle-question',
        iconColor = '#6fa8dc',
        onSelect = function()
          TriggerEvent('sc_lc:openDialog')
        end,
      },
      {
        title = Translation[Config.Locale]['menu_add'],
        icon = 'file-circle-plus',
        iconColor = '#93c47d',
        onSelect = function()
            TriggerEvent('sc_lc:openplus')
        end,
      },
      {
        title = Translation[Config.Locale]['menu_remove'],
        icon = 'file-circle-minus',
        iconColor = '#e06666',
        onSelect = function()
            TriggerEvent('sc_lc:openminus')
        end,
      }
    }
  })


--Licensecheck

RegisterNetEvent('sc_lc:openDialog')
AddEventHandler('sc_lc:openDialog', function()
    local input = lib.inputDialog(Translation[Config.Locale]['menu_check'], {
        {type = 'number', label = Translation[Config.Locale]['dia_sub'], icon = 'hashtag', description = '', required = true},
    })

    if not input then return end
    TriggerServerEvent('sc_lc:checklicense', input[1])
end)

RegisterNetEvent('sc_lc:showLicenses')
AddEventHandler('sc_lc:showLicenses', function(playerName, playerID, licenses)
    local licenseList = ""
    for i, license in ipairs(licenses) do
        if i > 1 then
            licenseList = licenseList .. ", "
        end
        licenseList = licenseList .. "**" .. license .. "**"
    end

    local alert = lib.alertDialog({
        header = Translation[Config.Locale]['alert_header'] .. " " .. playerName .. " [" .. playerID .. "]",
        content = licenseList,
        centered = true,
        cancel = false
    })
end)


--Add License

RegisterNetEvent('sc_lc:openplus')
AddEventHandler('sc_lc:openplus', function()
    local input = lib.inputDialog(Translation[Config.Locale]['dia_add'], {
        {type = 'number', label = Translation[Config.Locale]['dia_sub'], icon = 'hashtag', required = true}
    })

    if not input then return end
    TriggerServerEvent('sc_lc:fetchLicenses', input[1])
end)

RegisterNetEvent('sc_lc:askPay')
AddEventHandler('sc_lc:askPay', function(playerID, availableLicenses)
    local options = {}
    for _, license in ipairs(availableLicenses) do
        table.insert(options, {value = license, label = license})
    end

    local input = lib.inputDialog(Translation[Config.Locale]['dia_add'], {
        {type = 'number', label = Translation[Config.Locale]['dia_enter'], icon = 'user', required = true},
        {type = 'select', label = Translation[Config.Locale]['dia_license'], icon = 'id-card', options = options, required = true},
        {type = 'select', label = 'Payment Method', icon = 'cash-register', options = {
            {value = 'cash', label = 'Cash'},
            {value = 'bank', label = 'Bank Account'}
        }, required = true}
    })

    if not input then return end

    local price = tonumber(input[1])
    local selectedLicense = input[2]
    local paymentMethod = input[3]

    TriggerServerEvent('sc_lc:addlicense', playerID, selectedLicense, price, paymentMethod)
end)

--Remove License

RegisterNetEvent('sc_lc:openminus')
AddEventHandler('sc_lc:openminus', function()
    local input = lib.inputDialog(Translation[Config.Locale]['dia_rem'], {
        {type = 'number', label = Translation[Config.Locale]['dia_sub'], icon = 'hashtag', required = true}
    })

    if not input then return end
    TriggerServerEvent('sc_lc:fetchLicensesForRemoval', input[1])
end)

RegisterNetEvent('sc_lc:selectLicenseForRemoval')
AddEventHandler('sc_lc:selectLicenseForRemoval', function(playerID, ownedLicenses)
    local options = {}
    for _, license in ipairs(ownedLicenses) do
        table.insert(options, {value = license, label = license})
    end

    local input = lib.inputDialog(Translation[Config.Locale]['dia_rem'], {
        {type = 'select', label = Translation[Config.Locale]['dia_license'], icon = 'id-card', options = options, required = true}
    })

    if not input then return end
    TriggerServerEvent('sc_lc:removelicense', playerID, input[1])
end)
