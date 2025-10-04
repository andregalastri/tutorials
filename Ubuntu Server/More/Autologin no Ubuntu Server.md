# AUTOLOGIN NO UBUNTU SERVER

Habilitar o login automático no Ubuntu Server

1. Edite o serviço `getty@tty1`:
    ```bash
    sudo mkdir -p /etc/systemd/system/getty@tty1.service.d
    sudo nano /etc/systemd/system/getty@tty1.service.d/override.conf
    ```

2. Coloque a configuração abaixo. Substitua SEU_USUARIO pelo seu login (ex.: ubuntu).
    ```
    [Service]
    ExecStart=
    ExecStart=-/sbin/agetty --autologin SEU_USUARIO --noclear %I $TERM
    ```

3. Salve e recarregue o systemd:
    ```
    sudo systemctl daemon-reexec
    ```

---

Agora, ao iniciar, o Ubuntu já loga automaticamente no seu usuário no tty1
