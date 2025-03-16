# EXECUTANDO SCRIPT NO DESLIGAMENTO (UBUNTU 22.04)

<br>

## 1. CRIAR O SCRIPT
- Abra um terminal e crie um arquivo:
```
sudo nano /usr/local/bin/shutdown_script.sh
```

- Adicione o comando que você deseja executar no desligamento:
```
#!/bin/bash
echo "Running the shutdown script" >> /var/log/shutdown_script.log
```

- Torne o script executável:
```
sudo chmod +x /usr/local/bin/shutdown_script.sh
```

<br>

## 2. CRIAR UM ARQUIVO DE SERVIÇO PARA O SYSTEMD
- Abra um terminal e crie um arquivo:
```
sudo nano /etc/systemd/system/shutdown_script.service
```

- Insira o seguinte código, salve e feche:
```
[Unit]
Description=Run a script on shutdown
DefaultDependencies=no
Before=shutdown.target reboot.target halt.target

[Service]
Type=oneshot
ExecStart=/usr/local/bin/shutdown_script.sh
RemainAfterExit=true

[Install]
WantedBy=halt.target reboot.target shutdown.target
```

- Habilite o serviço:
```
sudo systemctl enable shutdown_script.service
```

---

Se o seu script contiver o mesmo código deste exemplo, quando você desligar ou reiniciar o computador, verá que o arquivo em /var/log/shutdown_script.log terá a mensagem "Executando o script de desligamento".
