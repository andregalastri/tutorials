# INSTALANDO O GITEA (APP AUTO-HOSPEDADO SEMELHANTE AO GITHUB)
Instalando e configurando o Gitea.

## DOWNLOAD
* Execute os seguintes comandos:
  
  ```bash
  wget -O gitea https://dl.gitea.io/gitea/1.17.3/gitea-1.17.3-linux-amd64;
  chmod +x gitea;
  ```

<br>

## INSTALAÇÃO
1. Vamos usar o binário como um serviço no Linux. Primeiro, precisamos adicionar um novo usuário e um grupo chamado gitea. O usuário atual também fará parte desse grupo.

   ```bash
   sudo adduser \
     --system \
     --shell /bin/bash \
     --gecos 'Git Version Control' \
     --group \
     --disabled-password \
     --home /home/gitea \
     gitea;

   sudo usermod -aG gitea $USER;
   ```

2. Crie os seguintes diretórios:

   ```bash
   sudo mkdir -p /var/lib/gitea/{custom,data,log};
   sudo chown -R gitea:gitea /var/lib/gitea/;
   sudo chmod -R 750 /var/lib/gitea/;
   sudo mkdir /etc/gitea;
   sudo chown root:gitea /etc/gitea;
   sudo chmod 770 /etc/gitea;
   ```
   
3. Mova o binário do gitea para a pasta correta:

   ```bash
   sudo mv gitea /usr/local/bin/gitea;
   ```

### Criando um serviço para rodar o Gitea

1. Precisamos criar um arquivo de serviço. Execute o seguinte comando:

   ```bash
   sudo nano /etc/systemd/system/gitea.service;
   ```

2. O editor Nano será aberto para criar o arquivo gitea.service. Cole o seguinte conteúdo no editor:

   ```ini
   [Unit]
   Description=Gitea (Git with a cup of tea)
   After=syslog.target
   After=network.target

   [Service]
   RestartSec=2s
   Type=simple
   User=gitea
   Group=gitea
   WorkingDirectory=/var/lib/gitea/
   ExecStart=/usr/local/bin/gitea web --config /etc/gitea/app.ini
   Restart=always
   Environment=USER=gitea HOME=/home/gitea GITEA_WORK_DIR=/var/lib/gitea

   [Install]
   WantedBy=multi-user.target
   ```

 3. Pressione CTRL + S para salvar e CTRL + X para fechar o Nano.
 4. Execute os seguintes comandos para rodar o Gitea como serviço:
 
    ```bash
    sudo systemctl enable gitea;
    sudo systemctl start gitea;
    ```

<br>

## PRIMEIRA EXECUÇÃO

1. Abra seu navegador e acesse seu localhost em http://localhost:3000 ou seu servidor em http://seu_ip_servidor:3000.
1. Nas configurações do banco de dados: <br>
   ![image](https://user-images.githubusercontent.com/49572917/158070145-47a6f073-d479-4bbd-9b81-c1715be9fb32.png)
   
   * Eu prefiro usar o SQLite como banco de dados, pois é mais fácil para backup.
   * Deixe o caminho do banco de dados como está.
   
1. Nas configurações gerais:<br>
   ![image](https://user-images.githubusercontent.com/49572917/158070177-285b5b7d-bfc0-45b6-8a95-cf51715fb36a.png)
   * Você pode mudar o nome do servidor para algo que você preferir. Mas pode deixar o valor padrão também.
   * Deixe o caminho do repositório, LFS root, nome de usuário, domínio do servidor e a porta SSH com seus valores padrão.
   * Se você estiver rodando o Gitea em localhost, deixe assim. Caso contrário, se estiver rodando em um servidor e acessando via IP, altere o http://localhost:3000 para http://seu_ip_servidor:3000.
   * Deixe o caminho do log com o valor padrão.
   
1. Clique no botão Instalar Gitea e pronto!

<br>

# RODANDO EM UMA URL BASEADA EM DOMÍNIO USANDO O VHOST PROXY DO APACHE
E se você quiser acessar o Gitea entrando por um domínio ou subdomínio, como http://git.meudominio.com?

Precisamos abrir o arquivo app.ini, que é o arquivo de configuração do Gitea.

1. Execute o seguinte comando:

   ```bash
   sudo nano /etc/gitea/app.ini;
   ```

2. Se perguntar se deseja editar o arquivo com ROOT, escolha Sim.
3. Encontre esta parte do código:
   
   ```ini
   ROOT_URL         = http://localhost:3000/
   ```

4. Substitua por seu domínio, como no exemplo abaixo:

   ```ini
   ROOT_URL         = http://your_gitea_domain.com/
   ```

5. Pressione CTRL + S para salvar e CTRL + X para fechar o Nano.
6. Reinicie o serviço do Gitea:

   ```bash
   sudo systemctl restart gitea;
   ```
<br>

### Criando um Vhost para redirecionar o acesso ao domínio

1. Habilite os módulos de proxy no Apache:

   ```bash
   sudo a2enmod proxy;
   sudo a2enmod proxy_http;
   ```
   
1. Execute o seguinte comando:

   ```bash
   sudo nano /etc/apache2/sites-available/gitea.conf;
   ```

1. Copie e cole o conteúdo abaixo:

   ```conf
   <VirtualHost *:80>
        ServerName your_gitea_domain.com
        ServerAlias your_gitea_domain.com
        ProxyPreserveHost On
        ProxyRequests off
        ProxyPass / http://localhost:3000/
        ProxyPassReverse / http://localhost:3000/
   </VirtualHost>
   ```
   <br>
   
   > IMPORTANTE: Altere a parte seu_dominio_gitea.com para o seu domínio.

1. Pressione CTRL + S para salvar e CTRL + X para fechar o Nano.
1. Execute os seguintes comandos:

   ```bash
   sudo a2ensite gitea;
   sudo service apache2 restart;
   ```

### Adicionando o domínio ou subdomínio no arquivo hosts

1. Abra o arquivo hosts:

   ```bash
   sudo nano /etc/hosts;
   ```

1. Adicione a linha abaixo no arquivo hosts:

   ```hosts
   127.0.0.1    your_gitea_domain.com
   ```
   <br>
   
   > IMPORTANTE: Altere a parte seu_dominio_gitea.com para o seu domínio.

<br>

# MIGRANDO PARA OUTRO SERVIDOR
**IMPORTANTE:**\
Isso só funcionará entre versões do Gitea que sejam iguais.

<br>

### Backup da sua instalação atual do Gitea
**Antes de prosseguir, certifique-se de que ninguém esteja usando o Gitea, pois vamos parar o serviço.**

1. Execute os seguintes comandos:
  ```bash
  sudo systemctl stop gitea;
  sudo mkdir -p $HOME/gitea/var/lib/gitea;
  sudo mkdir -p $HOME/gitea/etc/gitea;
  sudo cp -R /var/lib/gitea/* $HOME/gitea/var/lib/gitea/;
  sudo cp -R /etc/gitea/* $HOME/gitea/etc/gitea/;
  cd $HOME/;
  sudo tar -czf $HOME/gitea-backup.tar.gz gitea;
  sudo rm -R gitea;
  ```
1. Mova o arquivo gitea-backup.tar.gz para o novo servidor.

<br>

### Restaurando sua instalação do Gitea no novo servidor
1. No novo servidor, coloque o arquivo gitea-backup.tar.gz na pasta home do seu usuário.
1. Execute os seguintes comandos:
  ```bash
  sudo systemctl stop gitea;
  
  cd $HOME;
  sudo tar -xf gitea-backup.tar.gz;
  
  sudo mv /var/lib/gitea /var/lib/gitea_OLD;
  sudo mv /etc/gitea /etc/gitea_OLD;
  
  sudo cp -R $HOME/gitea/var/lib/gitea/ /var/lib/gitea/;
  sudo cp -R $HOME/gitea/etc/gitea/ /etc/gitea/;
  
  sudo chown -R gitea:gitea /var/lib/gitea/;
  sudo chmod -R 750 /var/lib/gitea/;
  sudo chown root:gitea /etc/gitea;
  sudo chmod 770 /etc/gitea;
  
  sudo systemctl start gitea;
  ```

Teste se tudo está funcionando. Se sim, você pode remover as pastas desnecessárias com os seguintes comandos:

```bash
sudo rm -R $HOME/gitea/;
sudo rm -R /var/lib/gitea_OLD/;
sudo rm -R /etc/gitea_OLD/;
```
