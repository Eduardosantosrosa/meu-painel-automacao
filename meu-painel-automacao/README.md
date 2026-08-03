# Meu Painel de Automação - Termux & Kali Linux

Painel interativo em Bash para gerenciamento de ambiente, atualização do Termux, controle de sessão de texto do Kali Linux e inicialização/encerramento cirúrgico da interface gráfica (Termux-X11 / XFCE) com auditoria de processos (logs de árvore).

## Estrutura do Projeto
- `menu.sh`: Painel central de automação com verificação inteligente de integridade da árvore de processos.
- `kex-stop.sh`: Script auxiliar responsável pela limpeza cirúrgica e encerramento forçado dos processos gráficos e da aplicação Android do Termux-X11.

## Funcionalidades do Menu
1. Atualização do Termux (`pkg update && pkg upgrade`)
2. Acesso rápido ao modo texto do Kali Linux (`nethunter`)
3. Inicialização controlada do servidor Termux-X11 e sessão XFCE
4. Parada cirúrgica, limpeza e auditoria de integridade por logs de árvore (com verificação automática de êxito ou falha)
