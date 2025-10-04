# OPENBOX NO UBUNTU SERVER
Permite ter uma GUI mínima para Ubuntu Server.

<br>

## INSTALAÇÃO BÁSICA

Após configurar o Ubuntu Server, seguir os passos abaixo:

1. Execute os comandos abaixo
    ```bash
    sudo apt update
    sudo apt install --no-install-recommends xorg openbox
    ```

2. Reinicie a máquina.

Apenas isso já irá acessar o Openbox. Ao reiniciar, logue em sua conta e execute
```bash
startx
```

### PROGRAMAS ÚTEIS

No Openbox é interessante ter alguns programas para poder lidar com a interface gráfica. É sugerido os seguintes:

| Programa | Descrição |
| --- | --- |
| Thunar | Gerenciador de arquivos. |
| Tint2 | Barra inferior com a lista de janelas abertas. |

Execute o seguinte para instalá-los:

```bash
sudo apt install thunar tint2
```

### ABRIR O OPENBOX AO LOGAR

É possível acessar o Openbox assim que logar no sistema, sem a necessidade de executar `startx` toda vez. Para isso é necessário rodar um comando que é baseado no `shell` que você está usando.

Logue e execute o comando conforme o seu `shell`:

#### 1. Shell BASH

1. Edite o arquivo `.profile`:
    ```bash
    nano ~/.bash_profile
    ```

2. Cole o seguinte comando no final do arquivo (é mais fácil fazer pelo LXTerminal, que permite copiar/colar ao invés do TTY).
    ```bash
    if [[ -z $DISPLAY ]] && [[ $(tty) == /dev/tty1 ]]; then
        exec startx
    fi
    ```
#### 2. Shell FISH

1. Edite o arquivo `config.fish`:
    ```bash
    nano ~/.config/fish/config.fish
    ```

2. Cole o seguinte comando no final do arquivo (é mais fácil fazer pelo LXTerminal, que permite copiar/colar ao invés do TTY).
    ```bash
    if test -z "$DISPLAY"; and test (tty) = "/dev/tty1"
        exec startx
    end
    ```
