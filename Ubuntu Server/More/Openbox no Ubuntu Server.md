# OPENBOX NO UBUNTU SERVER
Permite ter uma GUI mínima para Ubuntu Server.

<br>

## INSTALAÇÃO BÁSICA

Após configurar o Ubuntu Server, seguir os passos abaixo:

1. Execute os comandos abaixo.
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

1. Edite o arquivo `.profile`.
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

1. Edite o arquivo `config.fish`.
    ```bash
    nano ~/.config/fish/config.fish
    ```

2. Cole o seguinte comando no final do arquivo (é mais fácil fazer pelo LXTerminal, que permite copiar/colar ao invés do TTY).
    ```bash
    if test -z "$DISPLAY"; and test (tty) = "/dev/tty1"
        exec startx
    end
    ```

### DEFININDO RESOLUÇÃO DA TELA

A resolução deve ser definida pelo `xrandr`.

1. Execute o comando abaixo e veja as resoluções disponíveis.
    ```bash
    xrandr
    ```
    
    As resoluções disponíveis aparecerão para o monitor disponível, mais ou menos assim
    ```bash
    Virtual-1 connected primary 800x600+0+0 (normal left inverted right x axis y axis) 0mm x 0mm
    800x600       60.00*+  60.32    56.25  
    1920x1440     60.00  
    1856x1392     60.00  
    1792x1344     60.00  
    2048x1152     60.00  
    1920x1200     59.88    59.95  
    1920x1080     60.00  
    1600x1200     60.00  
    1680x1050     59.95    59.88  
    1400x1050     59.98    59.95  
    1600x900      60.00  
    1280x1024     60.02  
    1440x900      59.89    59.90  
    1280x960      60.00  
    1366x768      59.79    60.00  
    1360x768      60.02  
    1280x800      59.81    59.91  
    1280x768      59.87    59.99  
    1280x720      60.00  
    1024x768      60.00  
    848x480       60.00  
    640x480       59.94  
    ```

2. Execute o comando para definir a resolução, por exemplo.
    ```bash
    xrandr --output Virtual-1 --mode 1366x768
    ```

3. Para tornar permanente edite o arquivo.
    ```bash
    mkdir -p ~/.config/openbox
    nano ~/.config/openbox/autostart
    ```

4. Insira o comando da resolução.
    ```bash
    xrandr --output Virtual-1 --mode 1366x768
    ```

5. Salve e reinicie.
