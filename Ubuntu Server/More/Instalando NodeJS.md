# INSTALANDO O NODEJS
O repositório do Ubuntu usa versões mais antigas do NodeJS. Aqui está uma forma de instalar a versão mais recente do NodeJS.

<br>

Execute o seguinte comando, informando a versão principal que você deseja instalar.

O comando abaixo instalará a versão 17 mais recente, mas você pode instalar qualquer versão que desejar.

```
curl -fsSL https://deb.nodesource.com/setup_17.x | sudo -E bash -
sudo apt-get install -y nodejs
```
<br>

Agora, verifique se a versão correta foi instalada. Exemplo:

```bash
node -v
# v17.9.0

npm -v
# 8.5.5
```
