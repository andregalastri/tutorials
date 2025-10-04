# BLOQUEAR SNAPD FORÇADO

A Canonical está forçando o uso do `snapd`, mesmo quando se utiliza `apt` para instalar programas.

## Firefox e Thunderbird
1. Execute o comandos abaixo para dar prioridade ao PPA da Mozilla
    ```bash
    echo '
    Package: *
    Pin: release o=LP-PPA-mozillateam
    Pin-Priority: 1001
    ' | sudo tee /etc/apt/preferences.d/mozilla

    sudo add-apt-repository -y ppa:mozillateam/ppa
    ```

2. Instale o Firefox ou Thunderbird normalmente via `apt`.
