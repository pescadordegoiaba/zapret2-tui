-- cli/uninstaller.lua
local uninstaller = {}

local function run(cmd)
    os.execute(cmd)
end

function uninstaller.uninstall()
    print("Iniciando desinstalação do zapret2...")
    print("Isso removerá o serviço, regras de firewall e arquivos instalados.")
    print("Pressione ENTER para confirmar ou Ctrl+C para cancelar.")
    io.read()

    -- Executa o uninstall oficial (assume que está no diretório raiz do projeto)
    local status = run("sudo ./uninstall_easy.sh")

    if status == 0 then
        print("\nDesinstalação concluída com sucesso!")
        print("Recomendações:")
        print("- Reinicie o sistema para limpar regras residuais de iptables/nftables.")
        print("- Remova manualmente a pasta do projeto se desejar: rm -rf /opt/zapret (ou onde instalou).")
    else
        print("\nErro durante a desinstalação. Verifique os logs acima.")
        print("Tente executar manualmente: sudo ./uninstall_easy.sh")
    end
end

-- Função extra: remover apenas o serviço (útil se quiser manter binários para testes)
function uninstaller.remove_service_only()
    run("sudo systemctl disable --now zapret2")
    run("sudo rm -f /etc/systemd/system/zapret2.service")  -- ajuste se o nome for diferente
    print("Serviço zapret removido. Reinicie o systemd: sudo systemctl daemon-reload")
end

return uninstaller