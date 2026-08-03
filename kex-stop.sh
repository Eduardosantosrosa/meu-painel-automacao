#!/bin/bash
echo "Encerrando servidores gráficos e sessões..."
pkill -9 -f termux-x11
pkill -9 -f xfce4-session
pkill -9 -f Xorg
am force-stop com.termux.x11
echo "Parada e limpeza concluídas!"
