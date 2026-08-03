#!/bin/bash
while true; do
    clear
    echo "=================================================="
    echo "              MEU PAINEL DE AUTOMAÇÃO             "
    echo "=================================================="
    echo "1 - Atualizar o Termux (Update/Upgrade)"
    echo "2 - Entrar no Modo Texto do Kali Linux"
    echo "3 - Iniciar a Interface Gráfica (KEx)"
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
            nethunter
            read -p "Sessão encerrada. Pressione Enter para voltar ao menu..."
            ;;
        3)
            echo "Iniciando o Termux-X11 e a interface gráfica..."
            am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity &>/dev/null
            sleep 1
            XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :0 &>/dev/null &
            sleep 2
            export DISPLAY=:0
            xfce4-session &>/dev/null &
            echo "Interface acionada com sucesso!"
            read -p "Pressione Enter para continuar..."
            ;;
        4)
            echo "Capturando a árvore de processos antes da limpeza..."
            ps -ef | grep -E "termux-x11|vnc|xfce|proot" | grep -v grep > ~/tree_before.log
            
            echo "Executando o encerramento e a limpeza..."
            bash ~/kex-stop.sh
            am force-stop com.termux.x11
            
            echo "Capturando a árvore de processos após a limpeza..."
            ps -ef | grep -E "termux-x11|vnc|xfce|proot" | grep -v grep > ~/tree_after.log
            
            echo ""
            echo "=== LOG ANTERIOR (ANTES DA PARADA) ==="
            cat ~/tree_before.log
            echo "======================================"
            echo ""
            echo "=== LOG POSTERIOR (APÓS A LIMPEZA) ==="
            cat ~/tree_after.log
            echo "======================================"
            echo ""
            
            # Validação automática inteligente do log posterior
            if grep -qE "termux-x11|xfce4|Xorg|vnc" ~/tree_after.log; then
                echo "Status: Avaliação CONCLUÍDA COM FALHA (Negativo - Processos órfãos detectados)."
            else
                echo "Status: Avaliação CONCLUÍDA COM ÊXITO (Positivo - Limpeza perfeita)."
            fi
            
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
