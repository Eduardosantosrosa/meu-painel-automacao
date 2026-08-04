#!/bin/bash
verificar_base_release() {
    git pull origin main
}
bloco_1() {
    verificar_base_release
    pkg update && pkg upgrade -y
}
bloco_2() {
    proot-distro login kali
}
bloco_3() {
    echo "Iniciando XFCE..."
}
bloco_4() {
    echo "Limpando..."
}
bloco_5() {
    exit 0
}
while true; do
    clear
    echo "=== MEU PAINEL ==="
    echo "1. Atualizar"
    echo "2. Kali Linux"
    echo "3. XFCE"
    echo "4. Limpar"
    echo "5. Sair"
    read -p "Opcao: " opcao
    case $opcao in
        1) bloco_1 ;;
        2) bloco_2 ;;
        3) bloco_3 ;;
        4) bloco_4 ;;
        5) bloco_5 ;;
        *) echo "Invalido!" ;;
    esac
    read -p "Enter para continuar..."
done
