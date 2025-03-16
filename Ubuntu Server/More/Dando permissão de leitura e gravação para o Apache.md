# DANDO PERMISSÃO DE LEITURA E GRAVAÇÃO PARA O DAEMON DO APACHE (www-data)
Você verá que o Apache possui um usuário específico que interage com arquivos e pastas.

<br>

Adicione o usuário `www-data` ao mesmo grupo ao qual o seu usuário pertence. Normalmente, o nome do grupo em uma instalação EC2 (Ubuntu) é `ubuntu`.

```bash
sudo usermod -a -G ubuntu www-data
```

> **IMPORTANTE**: Certifique-se de que a pasta ou arquivo tenha o grupo do seu usuário como proprietário.
