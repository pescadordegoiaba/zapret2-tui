local service = {}

local function run(cmd)
    os.execute(cmd)
end

function service.start()
    run("sudo systemctl start zapret2")
end

function service.stop()
    run("sudo systemctl stop zapret2")
end

function service.restart()
    run("sudo systemctl restart zapret2")
end

function service.status()
    run("systemctl status zapret2")
end

return service