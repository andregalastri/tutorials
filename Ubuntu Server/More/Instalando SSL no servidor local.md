# INSTALANDO SSL NO SERVIDOR LOCAL
Quando se quer remover mensagens de navegação insegura em uma intranet.

<br>

## 1. INSTALANDO O mkcert
- Abra um terminal e crie um arquivo:
```
sudo apt install libnss3-tools
curl -L https://github.com/FiloSottile/mkcert/releases/latest/download/mkcert-v1.4.4-linux-amd64 -o mkcert
chmod +x mkcert
sudo mv mkcert /usr/local/bin/
mkcert -install
```

<br>

## 2. GERANDO UM CERTIFICADO SSL
Se você quer gerar **apenas para um domínio ou subdomínio específico**, então Execute o comando abaixo, substituindo pelo seu endereço local.
```
mkcert intranet.local
```

<br>

Isso cria:
* intranet.local.pem (Certificado)
* intranet.local-key.pem (Chave privada)

---

PORÉM, caso deseje incluir **tanto o domínio quanto seus subdomínios**, o comando deve conter o domínio precedido por *
```
mkcert *.intranet.local
```

<br>

Isso cria:
* _wildcard.intranet.local.pem (Certificado)
* _wildcard.intranet.local-key.pem (Chave privada)

<br>

## 3. CONFIGURANDO NO APACHE2
- Copie os arquivos para a pasta SSL do Apache.

  <br>
  
  > **IMPORTANTE: caso tenha criado certificados que incluem subdomínios, o processo é o mesmo, mas informando os arquivos `_wildcard.intranet.local.pem` e `_wildcard.intranet.local-key.pem`**.

  <br>
  
  ```
  sudo mkdir -p /etc/apache2/ssl
  sudo mv intranet.local.pem intranet.local-key.pem /etc/apache2/ssl/
  ```

- Ajuste as permissões para segurança:
  ```
  sudo chmod 600 /etc/apache2/ssl/*
  ```

- Crie ou edite um VirtualHost SSL:
  ```
  sudo nano /etc/apache2/sites-available/intranet.local.conf
  ```

- Adicione o seguinte conteúdo:
  ```
  # VirtualHost para HTTP (Porta 80) - Redireciona para HTTPS
  <VirtualHost *:80>
      ServerName intranet.local
      ServerAlias intranet.local
      
      # Redireciona todas as requisições HTTP para HTTPS
      Redirect permanent / https://intranet.local/
  </VirtualHost>
  
  # VirtualHost para HTTPS (Porta 443)
  <VirtualHost *:443>
      ServerName intranet.local
      ServerAlias intranet.local
      
      DocumentRoot "/home/ubuntu/intranet.local/public"
  
      <Directory "/home/ubuntu/intranet.local/public">
          Options Indexes FollowSymLinks
          AllowOverride All
          Require all granted
          DirectoryIndex index.html index.php
      </Directory>
  
      # Configuração do SSL
      SSLEngine on
      SSLCertificateFile /etc/apache2/ssl/intranet.local.pem
      SSLCertificateKeyFile /etc/apache2/ssl/intranet.local-key.pem
  
      # Certificado da CA, se necessário
      # SSLCACertificateFile /etc/apache2/ssl/ca.pem
  
      # Incluindo o PHP-FPM
      Include /etc/apache2/conf-available/php8.4-fpm.conf
  
      # Logs
      ErrorLog ${APACHE_LOG_DIR}/error.log
      CustomLog ${APACHE_LOG_DIR}/access.log combined
  </VirtualHost>
  ```

- Habilite o site e o SSL:
  ```
  sudo a2ensite intranet.local
  sudo a2enmod ssl
  sudo systemctl restart apache2
  ```

# O QUE FAZER SE O NAVEGADOR MOSTRAR ERRO DE CERTIFICADO NÃO CONFIÁVEL?
Se o navegador mostrar um erro de "certificado não confiável", instale a CA gerada pelo mkcert no navegador ou no sistema.

## NO WINDOWS

1. No servidor, localize o diretório onde o mkcert armazenou a CA:
    ```
    mkcert -CAROOT
    ```

2. Baixe o arquivo rootCA.pem que está a pasta localizada acima

3. O Windows pode não reconhecer o arquivo .pem como um certificado diretamente. Para garantir que o Windows reconheça, altere a extensão do arquivo de .pem para .crt. Então, renomeie o arquivo para algo como rootCA.crt.

4. Dê um duplo clique no arquivo rootCA.crt.

5. Você verá uma janela com detalhes sobre o certificado. Clique em Instalar Certificado.

6. Agora, o assistente de Importação de Certificados será aberto.
    1. Selecione a opção **"Colocar todos os certificados no repositório a seguir"**.
    2. Escolha a opção **"Autoridades de Certificação Raiz Confiáveis"**.

7. Clique em Avançar e depois em Concluir.

Após a instalação, reinicie o seu navegador e acesse novamente o site com HTTPS. O navegador deve agora reconhecer o certificado SSL gerado pelo mkcert como válido e confiável.

<br>

## NO LINUX

1. No servidor, localize o diretório onde o mkcert armazenou a CA:
    ```
    mkcert -CAROOT
    ```

2. Baixe o arquivo rootCA.pem que está a pasta localizada acima

3. No computador local, copie o rootCA.pem para a pasta abaixo
    ```
    /usr/local/share/ca-certificates/mkcert.crt/rootCA.pem
    ```

4. Atualize a lista de certificados confiáveis:
    ```
    sudo update-ca-certificates
    ```

5. Reinice o navegador ou o sistema para que a CA seja reconhecida.
