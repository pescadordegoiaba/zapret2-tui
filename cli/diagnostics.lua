local diag = {}

function diag.test_dns()
    os.execute("dig google.com")
end

function diag.test_https()
    os.execute("curl -I https://google.com")
end

function diag.test_block()
    os.execute("curl -I https://example.com")
end

return diag