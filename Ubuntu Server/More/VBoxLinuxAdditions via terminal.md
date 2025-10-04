# HABILITANDO VBoxLinuxAdditions VIA TERMINAL

## Monte o CD de Guest Additions
1. No menu da janela do VirtualBox acesse *Dispositivos > **Inserir imagem de CD dos Adicionais para Convidado...***.

2. Dentro da VM, monte o CD:
    ```bash
    sudo mkdir -p /mnt/cdrom
    sudo mount /dev/cdrom /mnt/cdrom
    ```

4. Instale dependências necessárias
    ```bash
    sudo apt update
    sudo apt install build-essential dkms linux-headers-$(uname -r) -y
    ```

5. Rode o instalador
    ```bash
    cd /mnt/cdrom
    sudo sh VBoxLinuxAdditions.run
    ```

6. Reinicie
    ```bash
    reboot
    ```

## Configure o Virtual Box

- No VirtualBox Manager, vá em **Configurações da VM > Geral > Área de Transferência Compartilhada** `Bidirecional`

  **Nota**: Também é possível habilitar dentro da janela da máquina virtual ativa, acessando **Dispositivos > Área de Transferência Compartilhada** e marcando `Bidirecional`.
