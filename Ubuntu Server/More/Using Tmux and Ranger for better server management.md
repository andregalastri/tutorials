# USANDO TMUX E RANGER PARA UM MELHOR GERENCIAMENTO DE SERVIDOR

O Ranger é um gerenciador de arquivos no terminal e o Tmux permite abrir várias janelas na mesma conexão SSH.

<br>

Acesse o servidor e instale o Ranger e o Tmux (caso não estejam instalados):
```bash
sudo apt install ranger tmux
```

<br>

## Instalar o plugin tmux-ressurect para o Tmux
1. Clone o plugin tmux-ressurect do Github usando o comando abaixo:
```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```
2. Abra/crie o arquivo tmux.conf na sua pasta home:
```bash
nano ~/.tmux.conf
```
3. Cole o seguinte código no arquivo:
```conf
# List of plugins
set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'tmux-plugins/tmux-sensible'
set -g @plugin 'tmux-plugins/tmux-resurrect'
set -g @plugin 'tmux-plugins/tmux-continuum'

set -g @continuum-restore 'on'
set -g @resurrect-processes ':all:'

# Initialize TMUX plugin manager (keep this line at the very bottom of tmux.conf)
run '~/.tmux/plugins/tpm/tpm'
```
NOTA MUITO IMPORTANTE: O set -g @resurrect-processes ':all:' salva todos os programas abertos no Tmux quando ele realiza o armazenamento da sessão. Isso pode ser perigoso se você usar programas que utilizam algum tipo de contexto e deixar aberto. Leia mais sobre isso aqui. Se preferir, desative colocando um # na frente desta linha.

4. Abra o Tmux executando o comando tmux
5. Execute tmux source ~/.tmux.conf
6. Pressione Ctrl + b e depois Shift + i. Uma mensagem aparecerá dizendo que o arquivo foi recarregado. 
   ![image](https://user-images.githubusercontent.com/49572917/129652334-e10fefb6-3948-4ab6-8996-969af3b9f75d.png)
   
7. Use o Tmux normalmente, as sessões serão salvas automaticamente a cada 15 minutos.
   * Para salvar a sessão manualmente, pressione Ctrl + b e depois Ctrl + s.
   * Para restaurar a sessão (após reiniciar o servidor, por exemplo), abra o Tmux novamente e pressione Ctrl + b e depois Ctrl + r.

<br><br>

## Conectando via SSH e rodando tmux automaticamente
Quando você se conectar via SSH, use o comando abaixo para rodar o tmux automaticamente e se conectar à sessão zero.<br> Se não houver uma sessão tmux ativa, ele criará uma nova.

> IMPORTANTE: Troque a parte your_ip_or_domain_address para o IP SSH do seu servidor ou o endereço de domínio.<br> Se o seu usuário não for ubuntu, troque-o também.


```bash
ssh ubuntu@your_ip_or_domain_address -t "tmux attach -t 0 || tmux"
```
