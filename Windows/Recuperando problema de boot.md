# RECUPERANDO PROBLEMA DE BOOT

Caso esteja ocorrendo erro de inicialização como o da imagem abaixo, faça o seguinte:
![2025-09-2908 29 378431472871294239873](https://github.com/user-attachments/assets/813b1830-daa9-43a4-b617-31aeff482729)

## 1. Boot em Ambiente de Recuperação

1. Crie um pendrive ou disco de boot do Windows 10/11 e inicie por ele
2. Avance na instalação até aparecer a opção "Reparar"
3. Selecione "Solução de problemas" e "Prompt de comando"
4. Digite o seguinte para abrir o gerenciador de partições:
   ```
   diskpart
   ```
5. Aguarde o Diskpart iniciar e digite
   ```
   list volume
   ```
6. Procure a partição com estas características:
   Sistema de arquivos: FAT32
   Tamanho pequeno (100–260 MB)
   Ausência de letra atribuída
   Possivelmente com rótulo "Sistema" ou sem rótulo
   
   Exemplo:
   ```
   Volume 2     FAT32     Sistema     100 MB      Saudável
   ```
7. Selecione o volume. Exemplo, suponha que seja o Volume 2:
   ```
   select volume 2
   ```
8. Atribua uma letra (exemplo: S):
   ```
   assign letter=S
   ```
9. Saia do diskpart:
   ```
   exit
   ```
10. Agora rode o comando `bcdboot`
    ```
    bcdboot C:\Windows /s S: /f UEFI
    ```

## 2. Saia do prompt de comando e desligue o sistema.

1. Se ainda estiver no prompt, saia dele
   ```
   exit
   ```
1. Na tela, escolha "Desligar o computador"
1. Remove o disco de boot e ligue o sistema novamente

# Coloquei letra no volume errado
Sem problemas! A gente resolve isso rapidinho — o diskpart permite remover e reassociar letras de unidade com segurança.

1. No prompt de comando, digite:
   ```
   diskpart
   ```
2. Listar os volumes
   ```
   list volume
   ```
   Você verá algo como
   ```
   Volume 0  E   NTFS   100 GB   ...
   Volume 1  S   FAT32  100 MB   ← talvez aqui tenha colocado a letra errada
   ```
 3. Remova a letra errada
    ```
    select volume 1
    remove letter=S
    ```

  Refaça os passos para definir a letra no volume correto e prossiga com os passos para recuperação.
