# CRIANDO UM SERVIDOR DE ARQUIVOS PARA REDE WINDOWS
Servidor de arquivos com sistema de cotas por usuário

<br>

## IMPORTANTE
Antes de prosseguir, é importante entender que **o sistema de arquivos EXT4 não permite o gerenciamento de cotas por pasta**, apenas por usuário. O sistema de arquivos XFS é o que permite o gerenciamento de cotas por pasta.

Desta forma, é recomendado ter duas partições (ou possuir dois drives), sendo um para instalar o sistema e outra para o armazenamento e compartilhamento dos arquivos.

<br>

# INSTALANDO E CONFIGURANDO O SAMBA
Instale o Samba

```
sudo apt update && sudo apt install samba -y
```

<br>

### CRIANDO OS USUÁRIOS NO SISTEMA
Para fins de segurança, todos os usuários serão criados sem a possibilidade de logar diretamente no servidor (ou via SSH) e sem pasta `/home`.

```
sudo adduser --no-create-home --disabled-login --shell /usr/sbin/nologin <nome_do_usuário>
```

<br>

Adicione quantos usuários quiser.

### CRIANDO OS USUÁRIOS NO SAMBA

```
sudo smbpasswd -a <nome_do_usuário>
```

<br>

Você será solicitado a definir a senha Samba (não precisa ser igual à do sistema).


### ATIVANDO OS USUÁRIOS NO SAMBA

```
sudo smbpasswd -e <nome_do_usuário>
```

<br>

# FORMATAÇÃO E PREPARAÇÃO DO SISTEMA XFS
Descubra qual o dispositivo de armazenamento que será formatado executndo o comando a seguir:

```bash
lsblk
```

A partição deverá aparecer como `/sda4` ou, no caso de um drive novo, `/sdb`, por exemplo.

<br>

### CRIANDO UMA NOVA PARTIÇÃO
Execute o comando a seeguir informando a partição ou drive conforme o que foi descoberto acima:

```
sudo fdisk /dev/<sdX>
```

<br>

Isso abrirá o programa `fdisk`. Nele, digite as opções abaixo, **uma por vez**:

```
g            # cria uma nova tabela de partição GPT (mais moderna e compatível com discos grandes)
n            # nova partição
1            # número da partição (padrão)
[Enter]      # aceita o primeiro setor padrão
[Enter]      # aceita o último setor (usar todo o espaço)
w            # grava e sai
```

Após isso, execute o `lsblk` novamente. Você deverá ver algo como:

Se for uma partição:
```
sdX
├ ...
└─sdX4   128G
```

Ou, se for um drive:
```
sdX
└─sdX1   128G
```

### FORMATANDO EM XFS COM PROJECT QUOTAS
Execute o comando a seguir para que a partição ou drive sejam formatados em sistema de arquivos XFS compatível com project quotas:

```
sudo mkfs.xfs -f -m crc=1,finobt=1 /dev/sdX1
```

<br>

**Crie o ponto de montagem com suporte ao project quotas.**

Recomenda-se criar as pastas do servidor de arquivos em uma pasta separada no sistema.

```
sudo mkdir -p /fileserver
sudo mount -o prjquota /dev/sdX1 /fileserver
```

<br>

**Por fim, configure a montagem automática no `fstab`**

```
sudo nano /etc/fstab
```

Adicione o seguinte ao final do arquivo:

```
/dev/sdX1   /fileserver   xfs   defaults,prjquota   0   0
```

<br>

# CRIANDO AS PASTAS COMPARTILHADAS
Crie as pastas que serão compartilhadas

```
sudo mkdir -p /fileserver/pasta-privada
sudo mkdir -p /fileserver/pasta-publica
```

### CRIANDO O ARQUIVO DE PROJETOS E ASSOCIAÇÕES
São necessárias configurações em dois arquivos para que as cotas funcionem: `/etc/projects` e `/etc/projid`

**Nota:** caso os arquivos não existam, basta criar novos.

Execute os seguintes comandos:

```
sudo nano /etc/projects
```

Insira os caminhos das pastas compartilhadas, sempre precedidas de um número (como em uma lista), que funcionará como um ID:

```
1:/fileserver/pasta-privada
2:/fileserver/pasta-publica
```

Salve, saia e execute o próximo comando:

```
sudo nano /etc/projid
```

Insira os nomes das pastas e os IDs:

```
pasta-privada:1
pasta-publica:2
```

Salve e saia

<br>

### ATRIBUINDO OS PROJETOS ÀS PASTAS
Execute os comandos abaixo para atribuir os projetos definidos anteriormente às pastas

```
sudo xfs_quota -x -c 'project -s pasta-privada' /fileserver
sudo xfs_quota -x -c 'project -s pasta-publica' /fileserver
```

### DEFININDO AS COTAS

```
sudo xfs_quota -x -c 'limit -p bhard=25g pasta-privada' /fileserver
sudo xfs_quota -x -c 'limit -p bhard=25g pasta-publica' /fileserver
```

Verifique se as cotas foram criadas corretamente:

```
sudo xfs_quota -x -c 'report -p' /fileserver
```

Você verá algo como o relatório abaixo:

```
Project quota on /fileserver (/dev/sdX1)
                               Blocks
Project ID   Project name      Used    Soft    Hard
----------   -------------     ----    ----    ----
1            pasta-privada     0       0       26214400
2            pasta-publica     0       0       26214400
```
**Nota: 26214400 blocos de 1K = exatamente 25 GB**

<br>

# DEFININDO PERMISSÕES DE ACESSO
Com as pastas e cotas criadas e definidas, agora é hora de dar permissões de acesso às pastas.

A `pasta-privada` será exclusiva para uso de um usuário específico, enquanto a `pasta-publica` será acessível por todos os usuários, mas ainda exigindo autenticação (ou seja, sem acesso anônimo).

Supondo que o usuário seja `usuario`, execute:

```
sudo chown usuario:usuario /fileserver/pasta-privada
sudo chmod -R 700 /fileserver/pasta-privada
```

Altere o `usuario` pelo usuário real.

Agora vamos criar um grupo que irá compartilhar da mesma pasta pública:

```
sudo groupadd fileserverusers
sudo chown root:fileserverusers /fileserver/pasta-publica
sudo chmod -R 2770 /fileserver/pasta-publica

sudo usermod -aG fileserverusers usuario
```

## CONFIGURANDA O SAMBA PARA COMPARTILHAR
Execute o comando:

```
sudo nano /etc/samba/smb.conf
```

No final do arquivo, adicione o seguinte conteúdo:

```
[Pasta privada]
   path = /fileserver/pasta-privada
   valid users = usuario
   read only = no
   browsable = no

[Pasta publica]
   path = /fileserver/pasta-publica
   valid users = @fileserverusers
   read only = no
   force group = fileserverusers
   create mask = 0664
   directory mask = 2770
   force create mode = 0664
   force directory mode = 2770
   browsable = yes
```

Salve e saia

**Reinicie o serviço do Samba**

```
sudo systemctl restart smbd
```

<br>

# LIBERANDO ACESSO NO FIREWALL
Execute o comando:

```
sudo ufw allow 'Samba'
```

Esse comando usa o perfil pré-definido do UFW que libera as seguintes portas:

```
Protocolo   Porta   Descrição
TCP         139	    NetBIOS session
TCP         445     SMB direct
UDP         137     NetBIOS name svc
UDP         138     NetBIOS datagram
```

Essas são as portas usadas para comunicação SMB/CIFS com clientes Windows.

# ACESSANDO VIA REDE WINDOWS
Para garantir que o Windows se conecte exatamente com as credenciais desejadas, é preferivel executar o logon junto ao servidor de arquivos através do CMD.

Faça o seguinte:

- Abra o **CMD**
- Execute o comando a seguir:
  ```
  net use \\192.168.x.x /user:<nome_do_usuario>
  ```
- Informe a senha definida no usuário do Samba.

Isso deverá permitir o acesso aos arquivos do servidor através das credenciais do usuário informado.

- Abra o **Explorador de Arquivos**
- Na barra de endereço, digite **`\\192.168.x.x`**

Você verá a **`Pasta comum`**, mas não verá a **`Pasta privada`**, pois ela foi ocultada nas configurações do Samba via `browsable = no`.

Você pode acessá-la via barra de endereços **`\\192.168.x.x\Pasta privada`**, ou alterando `browsable = no` para `browsable = yes`


## LIMPANDO CREDENCIAIS DE ACESSO
O Windows tem grande dificuldade em lidar com acesso a certas redes de arquivos, principalmente Linux.

Pode ocorrer casos em que se quer remover as credenciais de acesso, seja por mudança de senha ou usuário, seja por digitação incorreta dos dados, e isso tende a ser confuso de se lidar.

Nestes casos, feche todas as janelas do Explorer e execute um dos comandos abaixo, com base na situação:

| Situação | Comando | 
| --- | --- |
| ❗ Limpar todas as conexões SMB abertas (e cache temporário) | `net use * /delete /y` | 
| Desconectar uma pasta de rede mapeada (ex: Z:) | `net use Z: /delete` |
| Remover cache de uma conexão UNC ativa (sem unidade mapeada) | `net use \\192.168.x.x\compartilhamento /delete` |
| Remover credencial salva permanentemente | `cmdkey /delete:Domain:192.168.x.x` |
| Ver todas as credenciais salvas no sistema | `cmdkey /list` |
