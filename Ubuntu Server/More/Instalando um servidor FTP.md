# INSTALANDO O SERVIDOR FTP

## Instalação e configuração:
Execute os seguintes comandos:

```bash
sudo apt update
sudo apt install vsftpd
```

Abra o arquivo de configuração do Vsftpd:

```bash
sudo nano /etc/vsftpd.conf
```

Encontre o parâmetro anonymous_enable e defina como NO.

```conf
# Allow anonymous FTP? (Disabled by default).
anonymous_enable=NO
```

Encontre o parâmetro local_enable e descomente. Certifique-se de que seu valor esteja definido como YES.

```conf
# Uncomment this to allow local users to log in.
local_enable=YES
```

Encontre o parâmetro chroot_local_user e descomente. Certifique-se de que seu valor esteja definido como YES.

```conf
# You may restrict local users to their home directories.  See the FAQ for
# the possible risks in this before using chroot_local_user or
# chroot_list_enable below.
chroot_local_user=YES
```

Encontre o parâmetro write_enable e descomente. Certifique-se de que seu valor esteja definido como YES.

```conf
# Uncomment this to enable any form of FTP write command.
write_enable=YES
```

Na parte inferior do arquivo, adicione os seguintes parâmetros.

NOTA: No parâmetro pasv_address, informe o endereço IP público do seu servidor.c

```conf
pasv_enable=YES
pasv_address=<Public IP of your server>
pasv_min_port=12000
pasv_max_port=12100
port_enable=YES
force_dot_files=YES
allow_writeable_chroot=YES
user_sub_token=$USER
local_root=/home/$USER/userfolder
```

Salve o arquivo pressionando Ctrl + s e depois Ctrl + x para sair.

## Configurando usuários FTP

Crie um novo grupo de usuários para o FTP. Nomeie como desejar. Neste exemplo, usarei o nome ftpgroup.

```bash
sudo groupadd ftpgroup
```

Crie um novo usuário e adicione-o ao grupo criado. Nomeie como desejar. Neste exemplo, usarei o nome ftpuser.

```bash
useradd -g ftpgroup ftpuser
```

Defina uma senha para este usuário:

```bash
passwd ftpuser
```

É NECESSÁRIO criar uma pasta com o mesmo nome do usuário criado acima dentro da pasta /home. Faremos com que o usuário tenha acesso apenas a esta pasta. Execute os seguintes comandos:

NOTA: sempre substitua o nome de usuário ftpuser pelo que você criou.

```bash
cd /home
sudo mkdir ftpuser
sudo choun ftpuser:ftpgroup ftpuser
sudo chmod a-w ftpuser
sudo mkdir /home/ftpuser/public
sudo chown ftpuser:ftpgroup /home/ftpuser/userfolder

sudo service vsftpd restart
```

NOTA: A pasta userfolder será a raiz do usuário automaticamente. Ele não poderá acessar pastas fora dela. Você pode mudar o nome dessa pasta, mas precisará alterar o parâmetro local_root no arquivo /etc/vsftpd.conf para o nome que você escolher. O nome dessa pasta pública DEVE ser o mesmo para todos os usuários.

## Conectando

* **Host:** O IP do seu servidor ou o domínio
* **Port:** 21 ou deixe em branco
* **Cryptography**: Simples
* **Logon Type:** Normal
* **Username:** O nome de usuário que você criou
* **Password:** A senha que você atribuiu a esse nome de usuário
