# Script de instalação
* O jeito mais rápido de baixar e rodar o script de instalação é o seguinte:
  ```
  (source <(curl -s <url>))
  ```

<br>

# Shell Script
* Muito cuidado com manipulação de strings que contenham espaços (whitespaces). Quando for utilizá-las para exibir um texto, ou aplica em um nome de arquivo, por exemplo, utilize sempre aspas duplas, pois o shell script irá detectar o espaço como um segundo comando ou uma quebra de linha.
  Exemplo:
  ```
  texto="Meu texto"
  notify-send $texto
  ```
  Resulta em<br>
  `Meu`<br>
  `texto`
  
  ```
  texto="Meu texto"
  notify-send "$texto"
  ```
  Resulta em<br>
  `Meu texto`

<br>

## SED
* Substituir caracteres ou palavras uma única vez
  ```bash
  # Comando: sed "s/<busca>/<substituto>/"

  echo "Meu texto" | sed "s/e/a/"
  # Resultado: Mau texto

  echo "Meu texto" | sed "s/texto/comando/"
  # Resultado: Meu comando
  ```
  <br>

* Substituir caracteres ou palavras uma única vez começando a busca de trás pra frente
  ```bash
  # Comando: sed "s/\(.*\)<busca>/\1<substituto>/"

  echo "Meu texto" | sed "s/\(.*\)e/\1a/"
  # Resultado: Meu taxto
  ```
  <br>

* Substituir caracteres ou palavras uma única vez, mas na Xª ocorrência
  ```bash
  # Comando: sed "s/<busca>/<substituto>/<ocorrência>"

  echo "Pato Gato Rato" | sed "s/to/ta/2"
  # Resultado: Pato Gata Rato
  ```
  <br>

* Substituir caracteres ou palavras em todas as ocorrências
  ```bash
  # Comando: sed "s/<busca>/<substituto>/g"

  echo "Meu texto" | sed "s/e/a/g"
  # Resultado: Mau taxto
  ```

* Substituir caracteres ou palavras em todas as ocorrências, mas somente à partir da na Xª ocorrência
  ```bash
  # Comando: sed "s/<busca>/<substituto>/g<ocorrência>"

  echo "Pato Gato Rato" | sed "s/to/ta/g2"
  # Resultado: Pato Gata Rata
  ```
  <br>

* Substituir caracteres ou palavras ignorando se estão em maiúsculas ou minúsculas
  ```bash
  # Comando: sed "s/<busca>/<substituto>/i"

  echo "MEU texto" | sed "s/e/a/i"
  # Resultado: MaU texto
  ```

<br>

# Nemo
## Definindo emblema por linha de comando
```
gio set -t stringv <caminho da pasta/arquivo> metadata::emblems <emblema>
```

## Removendo opção Delete e deixando apenas a Mover para Lixeira
* É necessário desabilitar a opção de deletar permanentemente alterando via Dconf (não é possível alterar via preferências):
  ```
  gsettings set org.nemo.preferences enable-delete false
  ```
* O problema é que isso desabilita também o atalho **Shift + Delete** para excluir permanentemente.
  * Pra dar um jeito nisso, é necessário fazer um outro atalho no Openbox (**Control + Shift + Delete**, por exemplo)
    ```
    <keybind key="C-S-Delete">
      <action name="Execute">
        <command>permanently-delete.sh</command>
      </action>
    </keybind>
    ```
  * Este atalho roda o script **permanently-delete.sh**, cujo conteúdo deve fazer uma troca rápida entre ativar e desativar a configuração `gsettings set org.nemo.preferences enable-delete` e automaticamente executar o atalho **Shift + Delete** via linha de comando com o `xdotool`
    ```sh
    #!/bin/sh

    gsettings set org.nemo.preferences enable-delete true
    sleep 0.2
    xdotool keyup Control
    xdotool keyup Delete
    xdotool keydown Shift+Delete
    sleep 0.2
    gsettings set org.nemo.preferences enable-delete false
    xdotool keyup Delete
    xdotool keyup Shift
    ```

<br>

# Programas que usam DCONF
Ocorrem erros ao abrir programas que utilizam DCONF como ROOT, algo a ver com o endereço DBUS. Pra resolver o problema, é preciso lançar o dbus-launch junto com a aplicação.

Exemplo:
```sh
sudo dbus-launch <aplicação>
# ou
pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY dbus-launch <aplicação>
```

<br>

# VIRTUALBOX
* Iniciar o Xorg sem os pacotes `virtualbox-guest-iso` e `virtualbox-guest-utils` instalados fará com que a inicialização quebre caso o host esteja com a aceleração 3D ativa.

<br>

# Estudo sobre o Openbox

## Sobre os arquivos de configuração
* Logo após a instalação, copiar os arquivos para a pasta do usuário
  ```
  mkdir -p ~/.config/openbox
  cp -r /etc/xdg/openbox/* ~/.config/openbox/
  ```

<br>

## Sobre os temas
* Precisam ser feitos para openbox também. Não adianta baixar temas para GTK, tem que ter a versão para Openbox.
* GTK2 não detecta temas localizados em `~/.local/share/themes`, apenas em `~/.themes` ou `/usr/share/themes`. Por isso é melhor deixar em `/usr/share/themes`.
* Temas não funcionam na hora, programas precisam ser fechados e reabertos para funcionar. É possível aplicar instantâneamente, mas atraves de comandos adicionais.

<br>

## Picom
* Não detecta as bordas das janelas, deixando elas *pra fora* da janela quando se aplica cantos arredondados
* ~~Programas em libadwaita possuem uma borda transparente de 1px entre a janela e a sombra~~
  > Não é um problema do Picom. O problema está no tema GTK4 que coloca uma margem de 1px na janela, o que causa o problema.

<br>

## LXappearance
* Toda vez aplica hinting RGB nas fontes ao abrir o programa. Por isso que as fontes ficam feias ao usar o programa.
* O programa `lxappearance` junto com `lxappearance-obconf` permite ajustar as bordas das janelas diretamente por ele (sem precisar do `obconf`). O problema é que esse programa é em GTK2, ou seja, a preview dele muitas vezes não coincide com o programas GTK3.
  > Existe um programa chamado `lxappearance-gtk3`, mas o plugin `lxappearance-gtk3-obconf` está bugado.

<br>

## Aplicar temas
* GTK 2
    * Criar um arquivo `~/.gtkrc-2.0` e incluir o seguinte
    ```
    gtk-theme-name="nome-do-tema"
    ```
* GTK 3
    * Criar um arquivo `~/.config/gtk-3.0/settings.ini` e incluir o seguinte
      ```
      [Settings]
      gtk-theme-name=nome-do-tema
      ```
* QT
    * O programa `kvantummanager` permite aplicar temas em aplicações QT por aplicação.
      > Os arquivos de configuração ficam em `~/.config/Kvantum`.
    * O programa `qt5ct` permite alterar as fontes
      > O arquivo de configuração fica em `~/.config/qt5ct/qt5ct.conf`
* libadwaita
    * Reconhece temas GTK4 ao iniciar com `GTK_THEME=<tema> <aplicação>`
    * Ao iniciar o computador com uma variável de ambiente `GTK_THEME` definida, abre as aplicações normalmente.
* Decorações do Openbox
    * No arquivo `~/.config/openbox/rc.xml` e incluir o seguinte
        ```
        <theme>
            <name>nome-do-tema</name>
        </theme>
        ```

> Ainda não encontrei um jeito de fazer as alterações automaticamente em QT.

<br>

## Aplicando temas instantaneamente
* Usar o programa `xsettingsd` para aplicações GTK3
    * Criar um arquivo em `~/.config/xsettingsd/xsettingsd.conf` e incluir o seguinte:
      ```
      Net/ThemeName "nome-do-tema"
      ```
    * Executar `xsettingsd` para aplicar o tema

* Usar o comando `openbox --restart` para aplicar alterações nas decorações

> Ainda não encontrei um jeito de fazer as alterações automaticamente em GTK2 e QT.