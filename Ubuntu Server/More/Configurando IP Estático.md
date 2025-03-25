# CONFIGURANDO IP ESTÁTICO
Desabilita o DHCP da placa de rede do servidor e define um IP estático.

<br>

## EDITAR O ARQUIVO DE CONFIGURAÇÃO DE REDE
Abra o arquivo de configuração do Netplan:

```
sudo nano /etc/netplan/50-cloud-init.yaml
```
<br>

Modifique a configuração para algo como:

```
network:
  ethernets:
    enp0s3:
      dhcp4: false
      addresses:
        - 192.168.1.100/24  # IP fixo e máscara
      routes:
        - to: default
          via: 192.168.1.1  # Gateway padrão
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
  version: 2
```

<br>

## APLICANDO AS CONFIGURAÇÕES
Salvar e aplique a configuração:

```bash
sudo netplan apply
```

<br>

# REVERTENDO PARA O PADRÃO
Abra o arquivo de configuração do Netplan:

```
sudo nano /etc/netplan/50-cloud-init.yaml
```
<br>

Modifique a configuração para o padrão:

```
network:
  ethernets:
    enp0s3:
      dhcp4: true  # Ativa o DHCP para IPv4
  version: 2
```
<br>

Salvar e aplique a configuração:

```bash
sudo netplan apply
```
