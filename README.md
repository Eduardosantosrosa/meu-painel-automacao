# Meu Painel de Automação - Termux & Kali Linux

Painel interativo em Bash para gerenciamento completo do ambiente, controle gráfico e processos.

## Visão Geral do Projeto
Este repositório reúne um conjunto estruturado de scripts modulares em Bash, desenvolvidos para automatizar e otimizar rotinas no Termux e Kali Linux através de uma arquitetura full modular.

## Padrões e Lógica de Programação
- **Arquitetura Modular**: Separação clara de responsabilidades entre o script principal de navegação e os submódulos de automação.
- **Validação de Ambiente**: Verificação rigorosa de dependências, caminhos e permissões antes da execução dos comandos críticos.
- **Tratamento de Erros**: Estruturas de controle defensivas para garantir estabilidade e feedback direto no terminal.

## Arquitetura e Modularidade do Projeto ( scripts/menu.sh )

O painel opera em arquivo único dividido estritamente nos seguintes blocos funcionais:

1. **Bloco 1:** Gerencia a atualização de pacotes base do Termux (pkg update && pkg upgrade) e sincroniza automaticamente o repositório do projeto via git pull origin main.
2. **Bloco 2:** Aciona o ambiente Kali Linux em modo texto via `proot-distro`.
3. **Bloco 3:** Inicializa o servidor gráfico e a sessão do XFCE.
4. **Bloco 4:** Captura a árvore de processos, realiza o encerramento dinâmico de resíduos órfãos e limpa arquivos temporários.
5. **Bloco 5:** Sair com segurança do painel interativo.

## Documentação do Projeto

- **Instalação:** Instruções de clonagem do repositório, configuração inicial e preparação do ambiente base no Termux.
- **Atualização:** Diretrizes sobre o fluxo de atualização do sistema e sincronização automatizada das novas versões do painel diretamente do repositório remoto.
- **Autorização:** Gestão de permissões de execução (`chmod +x`) e liberação de acessos necessários para o funcionamento correto dos scripts.
- **Como Iniciar:** Comando para executar a aplicação e abrir o painel interativo:
  ```bash
  ./scripts/menu.sh
