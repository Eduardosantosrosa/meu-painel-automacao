#!/bin/bash

# ==========================================
# ROTINA DE AUTOCORREÇÃO E LIMPEZA INICIAL
# ==========================================
export XDG_RUNTIME_DIR="$TMPDIR"
export DISPLAY=":0"

rm -rf /tmp/.X*-lock /tmp/.X11-unix/* 2>/dev/null || true
mkdir -p "$HOME"

while true; do
    clear
    echo "=================================================="
    echo "          MEU PAINEL DE AUTOMAÇÃO v1.0            "
    echo "=================================================="
    echo "1 - Atualizar o Termux (Update/Upgrade)"
    echo "2 - Entrar no Modo Texto do Kali Linux"
    echo "3 - Iniciar a Interface Gráfica (Termux-X11)"
    echo "4 - Parar a Interface Gráfica e Limpar"
    echo "5 - Sair"
    echo "=================================================="
    read -p "Escolha uma opção (1-5): " opcao

    case $opcao in
        1)
            pkg update && pkg upgrade -y
            ;;
        2)
            echo "Entrando no modo texto do Kali Linux..."
            proot-distro login kali || bash
            read -p "Sessão encerrada. Pressione Enter para voltar ao menu..."
            ;;
        3)
            echo "Iniciando o Termux-X11 e a interface XFCE..."
            killall -9 termux-x11 Xwayland xfce4-session 2>/dev/null || true
            sleep 1
            termux-x11 :0 >/dev/null 2>&1 &
            sleep 2
            am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity >/dev/null 2>&1 || true
            xfce4-session >/dev/null 2>&1 &
            echo "Interface acionada com sucesso!"
            read -p "Pressione Enter para continuar..."
            ;;
        4)
            echo "Capturando a árvore de processos antes da limpeza..."
            ps f > "$HOME/tree_before.log"
            cat "$HOME/tree_before.log"

            echo "Executando o encerramento dinâmico e limpeza cirúrgica..."
            while read -r line; do
                if echo "$line" | grep -qE "termux-x11|xfce4|xfwm4|xfdesktop|Thunar|dbus-launch|Xwayland"; then
                    pid=$(echo "$line" | awk '{print $1}')
                    if [[ "$pid" =~ ^[0-9]+$ ]]; then
                        kill -9 "$pid" 2>/dev/null || true
                    fi
                fi
            done < "$HOME/tree_before.log"

            rm -rf /tmp/.X*-lock /tmp/.X11-unix/* 2>/dev/null || true
            pkill -9 -f termux-x11 2>/dev/null || true
            pkill -9 -f xfce4-session 2>/dev/null || true

            echo "Capturando a árvore de processos após a limpeza..."
            ps f > "$HOME/tree_after.log"
            cat "$HOME/tree_after.log"

            echo ""
            echo "=== RELATÓRIO DE AUDITORIA DE LIMPEZA ==="
            if grep -qE "termux-x11|xfce4|xfwm4|xfdesktop|Thunar|dbus-launch|Xwayland" "$HOME/tree_after.log"; then
                echo "[RETORNO NEGATIVO] ⚠️ Atenção: Alguns processos gráficos ainda persistem!"
            else
                echo "[RETORNO POSITIVO] ✅ Sucesso total: Todos os processos, caches e resíduos foram eliminados!"
            fi
            echo "========================================="
            read -p "Pressione Enter para voltar ao menu..."
            ;;
        5)
            echo "Saindo do painel..."
            break
            ;;
        *)
            echo "Opção inválida!"
            sleep 1
            ;;
    esac
done
