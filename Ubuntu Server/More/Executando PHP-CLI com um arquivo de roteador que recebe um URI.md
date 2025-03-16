# EXECUTANDO PHP-CLI COM UM ARQUIVO DE ROTEADOR QUE RECEBE UM URI
Às vezes, precisamos rodar um script PHP no modo CLI (linha de comando) usando um arquivo de roteador que recebe um URI e executa o código correspondente.

> Exemplo: Eu tenho um arquivo router.php que recebe o URI da requisição do usuário e redireciona para o arquivo de controlador apropriado. Esse arquivo controlador terá o comando que precisa ser executado. Vamos supor que o URI seja /app/route/execute-command e ele precise ser passado como a requisição URI para o arquivo router.php.

Para fazer isso, basta usar o seguinte exemplo:
```bash
# | Este é o URI que será passado para o arquivo route.php.
# |
# |                                    | Isso chama o PHP. Você pode especificar o caminho absoluto para o binário do PHP.
# |                                    |
# |                                    |    | Este é o arquivo de roteador que receberá e resolverá o URI.
# v                                    v    v
REQUEST_URI=/app/route/execute-command php "route.php"
```
