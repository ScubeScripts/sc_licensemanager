-- ░██████╗░█████╗░██╗░░░██╗██████╗░███████╗░██████╗░█████╗░██████╗░██╗██████╗░████████╗░██████╗
-- ██╔════╝██╔══██╗██║░░░██║██╔══██╗██╔════╝██╔════╝██╔══██╗██╔══██╗██║██╔══██╗╚══██╔══╝██╔════╝
-- ╚█████╗░██║░░╚═╝██║░░░██║██████╦╝█████╗░░╚█████╗░██║░░╚═╝██████╔╝██║██████╔╝░░░██║░░░╚█████╗░
-- ░╚═══██╗██║░░██╗██║░░░██║██╔══██╗██╔══╝░░░╚═══██╗██║░░██╗██╔══██╗██║██╔═══╝░░░░██║░░░░╚═══██╗
-- ██████╔╝╚█████╔╝╚██████╔╝██████╦╝███████╗██████╔╝╚█████╔╝██║░░██║██║██║░░░░░░░░██║░░░██████╔╝
-- ╚═════╝░░╚════╝░░╚═════╝░╚═════╝░╚══════╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝╚═╝░░░░░░░░╚═╝░░░╚═════╝░   

Config = {}

Config.Locale = 'en' -- de, es, fr and en

Config.Key = 38 -- Button used for triggering (on the DrawMarker) https://docs.fivem.net/docs/game-references/controls/

Config.KeyText = 'E' -- Button letter 'E = 38'

Config.Job = 'police' -- This job sees the marker and can open the menu

Config.Grade = 4 --Everyone with or above this rank can open the menu

Config.BName = 'City of LosSantos' -- It's in the bank statement

Config.Types = {"drive", "drive_bike", "drive_truck", "weapon", "boat", "dmv", "weed_processing"} -- All licenses that your server has, you can add new ones

Config.Coords = {
    440.32, -978.88, 30.68, --LSPD MRPD
    -- You can add even more
}

Translation = {
    ['en'] = {
        ['open_menu'] = 'Open Licensemanager',
        ['menu_title'] = 'LSPD Licensecheck',
        ['menu_error'] = 'Error',
        ['menu_check'] = 'Check license',
        ['menu_add'] = 'Add license',
        ['menu_remove'] = 'Remove license',
        ['alert_header'] = 'Licenses - ',
        ['dia_add'] = 'Add license',
        ['dia_sub'] = 'Enter Player ID',
        ['dia_enter'] = 'Enter price for license',
        ['dia_license'] = 'License',
        ['dia_rem'] = 'Remove license',
        ['dia_rem_sub'] = 'Enter Player ID',
        ['unk'] = 'Unknown',
        ['no_id'] = 'No player found with this ID',
        ['add_license'] = 'License was added',
        ['no_perms'] = 'You do not have permission to access this menu.',
        ['add_li1'] = 'The license ',
        ['add_li2'] = ' was added',
        ['rev_li'] = 'License received',
        ['rev_li1'] = "You have received the license ",
        ['pur_li'] = "Purchase of ",
        ['lic'] = " license",
        ['pay_liz'] = 'License purchased',
        ['pur_1'] = "You have purchased a ",
        ['pur_2'] = " license for ",
        ['money'] = '$',
        ['no_ba_money'] = 'You do not have enough money in your bank account to purchase this license.',
        ['no_mo_money'] = 'You do not have enough cash to purchase this license.',
        ['rem_li'] = 'License removed',
        ['rem_li1'] = 'You have the license ',
        ['rem_li2'] = ' removed.' ,
        ['rem_li3'] = "The license ",
        ['rem_li4'] = " was taken from you."
    },
    ['de'] = {
        ['open_menu'] = 'Menü öffnen',
        ['menu_title'] = 'LSPD Lizenzprüfung',
        ['menu_check'] = 'Lizenz prüfen',
        ['menu_add'] = 'Lizenz hinzufügen',
        ['menu_remove'] = 'Lizenz entfernen',
        ['alert_header'] = 'Lizenzen - ',
        ['dia_add'] = 'Lizenz hinzufügen',
        ['dia_sub'] = 'Spieler-ID eingeben',
        ['dia_enter'] = 'Preis für die Lizenz eingeben',
        ['dia_license'] = 'Lizenz',
        ['dia_rem'] = 'Lizenz entfernen',
        ['dia_rem_sub'] = 'Spieler-ID eingeben',
        ['unk'] = 'Unbekannt',
        ['no_id'] = 'Kein Spieler mit dieser ID gefunden',
        ['add_license'] = 'Lizenz wurde hinzugefügt',
        ['no_perms'] = 'Du hast keine Berechtigung, dieses Menü zu öffnen.',
        ['add_li1'] = 'Die Lizenz ',
        ['add_li2'] = ' wurde hinzugefügt',
        ['rev_li'] = 'Lizenz erhalten',
        ['rev_li1'] = 'Du hast die Lizenz ',
        ['pur_li'] = 'Kauf von ',
        ['lic'] = ' Lizenz',
        ['pay_liz'] = 'Lizenz gekauft',
        ['pur_1'] = 'Du hast eine ',
        ['pur_2'] = ' Lizenz für ',
        ['money'] = '€',
        ['no_ba_money'] = 'Du hast nicht genug Geld auf deinem Bankkonto, um diese Lizenz zu kaufen.',
        ['no_mo_money'] = 'Du hast nicht genug Bargeld, um diese Lizenz zu kaufen.',
        ['rem_li'] = 'Lizenz entfernt',
        ['rem_li1'] = 'Du hast die Lizenz ',
        ['rem_li2'] = ' entfernt.',
        ['rem_li3'] = 'Die Lizenz ',
        ['rem_li4'] = ' wurde dir entzogen.'
    },
    ['es'] = {
        ['open_menu'] = 'Abrir menú',
        ['menu_title'] = 'LSPD Verificación de licencia',
        ['menu_check'] = 'Verificar licencia',
        ['menu_add'] = 'Añadir licencia',
        ['menu_remove'] = 'Eliminar licencia',
        ['alert_header'] = 'Licencias - ',
        ['dia_add'] = 'Añadir licencia',
        ['dia_sub'] = 'Introducir ID del jugador',
        ['dia_enter'] = 'Introducir precio de la licencia',
        ['dia_license'] = 'Licencia',
        ['dia_rem'] = 'Eliminar licencia',
        ['dia_rem_sub'] = 'Introducir ID del jugador',
        ['unk'] = 'Desconocido',
        ['no_id'] = 'No se encontró jugador con este ID',
        ['add_license'] = 'Licencia añadida',
        ['no_perms'] = 'No tienes permiso para acceder a este menú.',
        ['add_li1'] = 'La licencia ',
        ['add_li2'] = ' fue añadida',
        ['rev_li'] = 'Licencia recibida',
        ['rev_li1'] = 'Has recibido la licencia ',
        ['pur_li'] = 'Compra de ',
        ['lic'] = ' licencia',
        ['pay_liz'] = 'Licencia adquirida',
        ['pur_1'] = 'Has comprado una ',
        ['pur_2'] = ' licencia por ',
        ['money'] = '$',
        ['no_ba_money'] = 'No tienes suficiente dinero en tu cuenta bancaria para comprar esta licencia.',
        ['no_mo_money'] = 'No tienes suficiente efectivo para comprar esta licencia.',
        ['rem_li'] = 'Licencia eliminada',
        ['rem_li1'] = 'Has eliminado la licencia ',
        ['rem_li2'] = '.',
        ['rem_li3'] = 'La licencia ',
        ['rem_li4'] = ' fue retirada.'
    },
    ['fr'] = {
        ['open_menu'] = 'Ouvrir le menu',
        ['menu_title'] = 'LSPD Vérification de licence',
        ['menu_check'] = 'Vérifier la licence',
        ['menu_add'] = 'Ajouter une licence',
        ['menu_remove'] = 'Supprimer la licence',
        ['alert_header'] = 'Licences - ',
        ['dia_add'] = 'Ajouter une licence',
        ['dia_sub'] = 'Entrer l\'ID du joueur',
        ['dia_enter'] = 'Entrer le prix de la licence',
        ['dia_license'] = 'Licence',
        ['dia_rem'] = 'Supprimer la licence',
        ['dia_rem_sub'] = 'Entrer l\'ID du joueur',
        ['unk'] = 'Inconnu',
        ['no_id'] = 'Aucun joueur trouvé avec cet ID',
        ['add_license'] = 'Licence ajoutée',
        ['no_perms'] = 'Vous n\'avez pas la permission d\'accéder à ce menu.',
        ['add_li1'] = 'La licence ',
        ['add_li2'] = ' a été ajoutée',
        ['rev_li'] = 'Licence reçue',
        ['rev_li1'] = 'Vous avez reçu la licence ',
        ['pur_li'] = 'Achat de ',
        ['lic'] = ' licence',
        ['pay_liz'] = 'Licence achetée',
        ['pur_1'] = 'Vous avez acheté une ',
        ['pur_2'] = ' licence pour ',
        ['money'] = '€',
        ['no_ba_money'] = "Vous n'avez pas assez d'argent sur votre compte bancaire pour acheter cette licence.",
        ['no_mo_money'] = "Vous n'avez pas assez d'argent liquide pour acheter cette licence.",
        ['rem_li'] = 'Licence supprimée',
        ['rem_li1'] = 'Vous avez supprimé la licence ',
        ['rem_li2'] = '.',
        ['rem_li3'] = 'La licence ',
        ['rem_li4'] = ' vous a été retirée.'
    },     
}