-- cli/explain.lua
local explain = {}

local explanations = {
    MODE = {
        title = "MODE (Modo de operação)",
        desc = [[
Define como o zapret2 intercepta e modifica pacotes.

Valores comuns:
- nfq     → Usa NFQUEUE (recomendado para Linux desktop como Mint, mais flexível)
- ipset   → Usa listas de IP dinâmicas (bom para roteadores)
- tproxy  → Redirecionamento transparente (avançado)

Recomendado para iniciantes: nfq
Implicação: nfq requer regras em iptables ou nftables para redirecionar tráfego.
        ]],
        example = "MODE=nfq"
    },
    
    NFQWS_OPT = {
        title = "NFQWS_OPT (Parâmetros do nfqws2)",
        desc = [[
String com opções passadas diretamente para o nfqws2 (o motor principal de bypass).

Exemplos comuns:
--filter-tcp=80,443             → Processa apenas HTTP/HTTPS
--filter-l7=tls,http            → Apenas TLS e HTTP
--payload=tls_client_hello      → Aplica desync só no ClientHello TLS
--lua-desync=fake:blob=fake_default_tls:tcp_md5  → Envia fake TLS + MD5 para enganar DPI

No Brasil (Vivo/Claro/TIM), estratégias comuns incluem:
fake + tcp_md5 + tls_mod=rnd,rndsni
ou multisplit + fooling=md5sig

Cuidado: opções erradas podem piorar a conexão ou causar CPU alta.
        ]],
        example = 'NFQWS_OPT="--qnum 200 --filter-tcp=80,443 --lua-desync=fake:blob=fake_default_tls"'
    },
    
    HOSTLIST = {
        title = "HOSTLIST (Lista de domínios a proteger)",
        desc = [[
Caminho para arquivo txt com domínios bloqueados (um por linha).

Ex: youtube.com
    googlevideo.com
    discord.com

O zapret aplica desync apenas nesses hosts → mais eficiente, menos overhead.
Use HOSTLIST_EXCLUDE para exceções (ex: sites brasileiros que quebram).
        ]],
        example = "HOSTLIST=/opt/zapret/my-hosts.txt"
    },
    
    -- Adicione mais: IPSET, TPWS_OPT (se Windows), --blob, --lua-desync tipos (fake, multisplit, etc.)
    -- Veja manual.en.md para lista completa
}

function explain.show_list()
    print("===================================")
    print("     EXPLICAÇÕES DAS CONFIGURAÇÕES")
    print("===================================")
    print("")
    
    local keys = {}
    for k in pairs(explanations) do table.insert(keys, k) end
    table.sort(keys)
    
    for i, key in ipairs(keys) do
        print(string.format("%2d  %s", i, explanations[key].title))
    end
    print("")
    print("0  Voltar")
    print("")
    
    io.write("Digite o número para ver detalhes (ou 0): ")
    local choice = tonumber(io.read())
    
    if choice and choice >= 1 and choice <= #keys then
        local selected = keys[choice]
        clear()
        print("[" .. explanations[selected].title .. "]")
        print("")
        print(explanations[selected].desc)
        if explanations[selected].example then
            print("")
            print("Exemplo:")
            print(explanations[selected].example)
        end
        pause()
    end
end

return explain