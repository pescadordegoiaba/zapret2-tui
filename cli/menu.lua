local service = require("service")
local config = require("config")
local installer = require("installer")
local diag = require("diagnostics")
local uninstaller = require("uninstaller")
local explain = require("explain")

local menu = {}

local function clear()
    os.execute("clear")
end

local function pause()
    io.write("\nPress ENTER to continue...")
    io.read()
end

function menu.start()

while true do

clear()

print("===================================")
print("        ZAPRET CONTROL PANEL")
print("===================================")
print("")
print("1  Start protection")
print("2  Stop protection")
print("3  Restart service")
print("4  Service status")
print("")
print("5  Install / update zapret2")
print("6  Edit config")
print("")
print("7  Network diagnostics")
print("8  Uninstall zapret2 (remove tudo)")
print("9  Explicar configurações do zapret2")
print("10  Testar Sites Bloqueados          ")
print("")
print("0  Exit")
print("")

io.write("Select option: ")
local opt = io.read()

if opt == "1" then
service.start()
os.execute("echo Use CTRL+C Para voltar para o menu")
pause()

elseif opt == "2" then
service.stop()
pause()

elseif opt == "3" then
service.restart()
pause()

elseif opt == "4" then
service.status()
pause()

elseif opt == "5" then
installer.install()
pause()

elseif opt == "6" then
config.edit()
pause()

elseif opt == "7" then
diag.test_dns()
diag.test_https()
pause()

elseif opt == "8" then
uninstaller.uninstall()
pause()

elseif opt == "9" then
explain.show_list()
pause()

elseif opt == "0" then
os.exit()

end

end

end

return menu