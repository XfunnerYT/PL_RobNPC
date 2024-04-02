fx_version 'cerulean'
game 'gta5'

lua54 'yes'

author 'Polak'
description 'Sistema de robos a NPC sencillo y basico con porcentajes y cantidades.'

server_scripts {
    'server/*.lua',
}

client_scripts {
    'client/*.lua',
}

shared_scripts {
    '@ox_lib/init.lua',
    'config.lua'
}