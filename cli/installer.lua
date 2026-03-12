

local installer = {}

function installer.install()
    os.execute("sudo pacman -S --needed base-devel git make gcc pkgconf libnetfilter_queue libnfnetlink libmnl lua")
    os.execute("sudo ./install_easy.sh")
end

function installer.update()
    os.execute("git pull")
end

return installer