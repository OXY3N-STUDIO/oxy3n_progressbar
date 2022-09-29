fx_version 'cerulean'
game 'gta5'
lua54 'yes'


description "Add progressBars in your server"
author "OXY3N STUDIO"
version "1.0.0"

ui_page('html/index.html') 

client_scripts {
    'client/main.lua',
}

shared_scripts {
    'shared/config.lua',
    'shared/translations.lua',
}

server_scripts {
    'server/s_versioncheck.lua'
}

files {
    'html/index.html',
    'html/css/style.css',
    'html/js/script.js',
    'shared/config.js',

    'html/css/bootstrap.min.css',
    'html/js/jquery.min.js',
}

exports {
    'Progress',
    'ProgressWithStartEvent',
    'ProgressWithTickEvent',
    'ProgressWithStartAndTick'
}
