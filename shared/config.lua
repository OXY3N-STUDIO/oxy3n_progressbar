Config = {
    Lang = "es", -- es = Spanish, en = English
    notifiactionSystem = "okokNotify", -- pNotify, okokNotify, mainGameNotify, other or put false if you don't want to use any notification system
    cancelButton = "BACKSPACE", -- The button to cancel the action, you can change it to any button you want look bottom for more info
}

-- IF YOU WANT CHANGE THE STYLE OF PROGRESSBAR GO TO SCRIPT.JS AND CHANGE VARS IN CONFIGJS

function notifiactionStyles(msg, typeNotification, time)
    if Config.notifiactionSystem == "pNotify" then
        exports.pNotify:SendNotification({text = msg, type = typeNotification, timeout = time or 4000, layout = "centerLeft"})

    elseif Config.notifiactionSystem == "mythic_notify" then
        if typeNotification == "info" then typeNotification = "inform" end
        exports['mythic_notify']:DoHudText(typeNotification, msg)

    elseif Config.notifiactionSystem == "mainGame" then
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)

    elseif Config.notifiactionSystem == "okokNotify" then
        exports['okokNotify']:Alert(Translation[Config.Lang].progressbars_title, msg, time, typeNotification)

    elseif Config.notifiactionSystem == "other" then
        -- Your custom notification system
    end
end


--[[
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
]]