with open("scripts/menu.sh", "r") as f:
    content = f.read()

# Novo bloco limpo para a opção 4 com logs de auditoria e caminhos dinâmicos
new_case_4 = """4)
    LOG_BEFORE="$HOME/tree_before.log"
    LOG_AFTER="$HOME/tree_after.log"

    echo "=== 1. Capturando árvore pré-limpeza ==="
    ps f > "$LOG_BEFORE"
    cat "$LOG_BEFORE"

    echo "=== 2. Executando encerramento dinâmico dos alvos ==="
    while read -r line; do
        if echo "$line" | grep -qE "termux-x11|xfce4|xfwm4|xfdesktop|Thunar|dbus-launch"; then
            pid=$(echo "$line" | awk '\''{print $1}'\'')
            if [[ "$pid" =~ ^[0-9]+$ ]]; then
                kill -9 "$pid" 2>/dev/null || true
            fi
        fi
    done < "$LOG_BEFORE"

    echo "=== 3. Executando limpeza de cache e autoremove ==="
    rm -rf /tmp/.X*-lock /tmp/.X11-unix/* 2>/dev/null || true
    apt-get autoremove -y 2>/dev/null || true
    apt-get clean -y 2>/dev/null || true
    pkg clean -y 2>/dev/null || true

    echo "=== 4. Capturando árvore pós-limpeza ==="
    ps f > "$LOG_AFTER"
    cat "$LOG_AFTER"

    echo "=== 5. Comparativo e Relatório de Auditoria ==="
    if grep -qE "termux-x11|xfce4|xfwm4|xfdesktop|Thunar|dbus-launch" "$LOG_AFTER"; then
        echo "[RETORNO NEGATIVO] ⚠️ Atenção: Alguns processos gráficos ainda persistem na árvore!"
    else
        echo "[RETORNO POSITIVO] ✅ Sucesso total: Todos os processos, caches e resíduos foram eliminados!"
    fi

    read -p "Pressione Enter para voltar ao menu..."
    ;;"""

import re
pattern = re.compile(r"4\)\s*.*?\s*;;", re.DOTALL)
if pattern.search(content):
    new_content = pattern.sub(new_case_4, content)
    with open("scripts/menu.sh", "w") as f:
        f.write(new_content)
    print("Sucesso total: Opção 4 atualizada automaticamente!")
else:
    print("Erro: Bloco da opção 4 não encontrado.")
