ESX = exports["es_extended"]:getSharedObject()

RegisterNetEvent('sc_lc:checkJobAndOpenMenu')
AddEventHandler('sc_lc:checkJobAndOpenMenu', function()
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer and xPlayer.job.name == Config.Job and xPlayer.job.grade >= Config.Grade then
        TriggerClientEvent('sc_lc:open', source)
    else
        TriggerClientEvent('esx:showNotification', _source, Translation[Config.Locale]['no_perms'])
    end
end)

ESX.RegisterServerCallback('sc_lc:getPlayerName', function(source, cb, playerID)
    local xPlayer = ESX.GetPlayerFromId(playerID)
    if xPlayer then
        cb(xPlayer.getName())
    else
        cb(nil)
    end
end)

local allLicenses = Config.Types

RegisterServerEvent('sc_lc:checklicense')
AddEventHandler('sc_lc:checklicense', function(playerID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(playerID)

    if xPlayer then
        local licenses = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE owner = @owner", {
            ['@owner'] = xPlayer.identifier
        })

        local licenseNames = {}
        for _, license in ipairs(licenses) do
            table.insert(licenseNames, license.type)
        end

        local playerName = xPlayer.getName()
        TriggerClientEvent('sc_lc:showLicenses', src, playerName, playerID, licenseNames)
    else
        TriggerClientEvent('sc_lc:showLicenses', src, Translation[Config.Locale]['unk'], {Translation[Config.Locale]['no_id']})
    end
end)


RegisterServerEvent('sc_lc:fetchLicenses')
AddEventHandler('sc_lc:fetchLicenses', function(playerID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(playerID)

    if xPlayer then
        local licenses = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE owner = @owner", {
            ['@owner'] = xPlayer.identifier
        })

        local ownedLicenses = {}
        for _, license in ipairs(licenses) do
            ownedLicenses[license.type] = true
        end

        local availableLicenses = {}
        for _, license in ipairs(allLicenses) do
            if not ownedLicenses[license] then
                table.insert(availableLicenses, license)
            end
        end

        TriggerClientEvent('sc_lc:askPay', src, playerID, availableLicenses)
    else
        TriggerClientEvent('sc_lc:showLicenses', src, {Translation[Config.Locale]['no_id']})
    end
end)

RegisterServerEvent('sc_lc:addlicense')
AddEventHandler('sc_lc:addlicense', function(playerID, licenseType, price, paymentMethod)
    local xPlayer = ESX.GetPlayerFromId(playerID)
    local src = source

    if xPlayer then
        local playerIdentifier = xPlayer.identifier
        local jobName = xPlayer.job.name

        if paymentMethod == 'cash' then
            if xPlayer.getMoney() >= price then
                xPlayer.removeMoney(price)
            else
                TriggerClientEvent('ox_lib:notify', playerID, {
                    title = Translation[Config.Locale]['menu_name'],
                    description = Translation[Config.Locale]['no_mo_money'],
                    type = 'error'
                })
                return
            end
        elseif paymentMethod == 'bank' then
            local bankAccount = xPlayer.getAccount('bank')
            if bankAccount.money >= price then
                xPlayer.removeAccountMoney('bank', price, Config.BName)
            else
                TriggerClientEvent('ox_lib:notify', playerID, {
                    title = Translation[Config.Locale]['menu_name'],
                    description = Translation[Config.Locale]['no_ba_money'],
                    type = 'error'
                })
                return
            end
        end

        MySQL.Sync.execute("INSERT INTO user_licenses (type, owner) VALUES (@type, @owner)", {
            ['@type'] = licenseType,
            ['@owner'] = playerIdentifier
        })

        TriggerClientEvent('ox_lib:notify', playerID, {
            id = 'invoice_1',
            title = Translation[Config.Locale]['pay_liz'],
            description = Translation[Config.Locale]['pur_1'] .. licenseType .. Translation[Config.Locale]['pur_2'] .. price .. Translation[Config.Locale]['money'],
            duration = 5000,
            position = 'top-right',
            icon = 'file-circle-plus',
            iconColor = '#12b886'
        })

        TriggerClientEvent('ox_lib:notify', src, {
            title = Translation[Config.Locale]['add_license'],
            description = Translation[Config.Locale]['add_li1'] .. licenseType .. Translation[Config.Locale]['add_li2'],
            type = 'success'
        })
    else
        TriggerClientEvent('ox_lib:notify', playerID, {
            title = Translation[Config.Locale]['menu_name'],
            description = Translation[Config.Locale]['no_id'],
            type = 'error'
        })
    end
end)

RegisterServerEvent('sc_lc:fetchLicensesForRemoval')
AddEventHandler('sc_lc:fetchLicensesForRemoval', function(playerID)
    local src = source
    local xPlayer = ESX.GetPlayerFromId(playerID)

    if xPlayer then
        local licenses = MySQL.Sync.fetchAll("SELECT * FROM user_licenses WHERE owner = @owner", {
            ['@owner'] = xPlayer.identifier
        })

        local ownedLicenses = {}
        for _, license in ipairs(licenses) do
            table.insert(ownedLicenses, license.type)
        end

        TriggerClientEvent('sc_lc:selectLicenseForRemoval', src, playerID, ownedLicenses)
    else
        TriggerClientEvent('sc_lc:showLicenses', src, {Translation[Config.Locale]['no_id']})
    end
end)

RegisterServerEvent('sc_lc:removelicense')
AddEventHandler('sc_lc:removelicense', function(playerID, license)
    TriggerClientEvent('ox_lib:notify', source, {
        title = Translation[Config.Locale]['rem_li'],
        description = Translation[Config.Locale]['rem_li1'] .. license .. Translation[Config.Locale]['rem_li2'],
        type = 'success'
    })
    local xPlayer = ESX.GetPlayerFromId(playerID)

    if xPlayer then
        MySQL.Sync.execute("DELETE FROM user_licenses WHERE type = @type AND owner = @owner", {
            ['@type'] = license,
            ['@owner'] = xPlayer.identifier
        })
    end
    TriggerClientEvent('ox_lib:notify', playerID, {
        id = 'invoice_2',
        title = Translation[Config.Locale]['rem_li'],
        description = Translation[Config.Locale]['rem_li3'] .. license .. Translation[Config.Locale]['rem_li4'],
        duration = 5000,
        position = 'top-right',
        icon = 'file-circle-minus',
        iconColor = '#e06666'
    })
end)

ESX.RegisterServerCallback('sc_lc:getJob', function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer then
        cb(xPlayer.job.name)
    else
        cb(nil)
    end
end)

