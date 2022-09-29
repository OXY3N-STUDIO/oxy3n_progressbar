newVersions = true
watermark = [[  
    ^6 ██████╗ ██╗  ██╗██╗   ██╗██████╗ ███╗   ██╗
    ^6██╔═══██╗╚██╗██╔╝╚██╗ ██╔╝╚════██╗████╗  ██║
    ^6██║   ██║ ╚███╔╝  ╚████╔╝  █████╔╝██╔██╗ ██║
    ^6██║   ██║ ██╔██╗   ╚██╔╝   ╚═══██╗██║╚██╗██║ 
    ^6╚██████╔╝██╔╝ ██╗   ██║   ██████╔╝██║ ╚████║
    ^6 ╚═════╝ ╚═╝  ╚═╝   ╚═╝   ╚═════╝ ╚═╝  ╚═══╝
        ^6███████╗████████╗██╗   ██╗██████╗ ██╗ ██████╗ 
        ^6██╔════╝╚══██╔══╝██║   ██║██╔══██╗██║██╔═══██╗
        ^6███████╗   ██║   ██║   ██║██║  ██║██║██║   ██║
        ^6╚════██║   ██║   ██║   ██║██║  ██║██║██║   ██║
        ^6███████║   ██║   ╚██████╔╝██████╔╝██║╚██████╔╝
        ^6╚══════╝   ╚═╝    ╚═════╝ ╚═════╝ ╚═╝ ╚═════╝                                                                                                              
]]

if newVersions then
    Citizen.CreateThread(function()
        Citizen.Wait(5000)
        local function ToNumber(cd) return tonumber(cd) end
        resource_name = GetCurrentResourceName()
        current_version = GetResourceMetadata(resource_name, 'version', 0)
        PerformHttpRequest('https://raw.githubusercontent.com/OXY3N-STUDIO/check_version_information/main/'..resource_name..'.txt',function(errorCode, resultData, resultHeaders)
            if not resultData then print('^1Version check disabled because GITHUB.com is down.^0') return end
            local result = json.decode(resultData:sub(1, -2))
            if ToNumber(result.version:gsub('%.', '')) > ToNumber(current_version:gsub('%.', '')) then
                print(watermark)
                print('\t\t^2[' .. resource_name .. '] Loaded - New update available now!^0\n\t\tCurrent Version: ^5' ..current_version..'^0.\n\t\tNew Version: ^5' ..result.version..'^0.\n\t\tNotes: ^5' ..result.notes..'^0.\n\n\t\t^5Download it now on your keymaster.fivem.net^0.')
            else
                print(watermark)
                print('\t\t^2[' .. resource_name .. '] Loaded - Current version: ^5' ..current_version..'^0.')
            end
        end,'GET')
    end)
end