fx_version 'cerulean'
game 'gta5'
lua54 'yes'

name "sc_licensemanager"
author "ScubeScripts"
description "A simple script to check, assign or remove licenses."
version "1.0.4"

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/*.lua'
}
  
client_scripts {
    'client/*.lua'
}
  
shared_script {
    '@ox_lib/init.lua',
    'config.lua'
}
  
dependencies {
    'es_extended',
    'ox_lib',
    'oxmysql',
    'sc_textUI'
}
