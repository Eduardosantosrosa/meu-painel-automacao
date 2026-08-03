#!/bin/bash
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
            nethunter
            read -p "Sessão encerrada. Pressione Enter para voltar ao menu..."
            ;;
        3)
            echo "Iniciando o Termux-X11 e a interface XFCE..."
            am start --user 0 -n com.termux.x11/com.termux.x11.MainActivity > /dev/null 2>&1
            sleep 1
            XDG_RUNTIME_DIR=${TMPDIR} termux-x11 :0 > /dev/null 2>&1 &
            sleep 2
            export DISPLAY=:0
            xfce4-session > /dev/null 2>&1 &
            echo "Interface acionada com sucesso!"
            read -p "Pressione Enter para continuar..."
            ;;
        4)
            echo "Executando o encerramento e a limpeza..."
            bash ~/meu-painel-automacao/scripts/kex-stop.sh
            am force-stop com.termux.x11
            read -p "Limpeza concluída! Pressione Enter para voltar ao menu..."
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
