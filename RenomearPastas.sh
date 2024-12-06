#!/bin/bash

# Renomear Pastas
# O script deve ser capaz de:
# - Renomear todos os diretórios em script_sample_folder para "<prefixo qualquer>-<nome atual da pasta>";
# - Receber um prefixo qualquer como argumento de quem evoca o script.

# Verifica se a ausência do diretório 'script_sample_folder'
if ! [ -d ./script_sample_folder ]; then

    # Imprime uma mensagem de erro, neste caso, se o diretório do 'script_sample_folder' não existir
    echo "O diretório 'script_sample_folder' não existe. Execute primeiro o script 'dir_spammer.sh' para criar os diretórios necessários!"

    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

# Indica o fim da condição 'if' iniciada acima
fi    

# Verifica se o diretório 'script_sample_folder' NÃO tem diretórios dentro do mesmo
if ! find ./script_sample_folder -mindepth 1 -type d | grep -q .; then

    # Como é que vamos renomear diretórios se estes não existem?
    echo "Não existem directórios a renomear! Execute primeiro o script 'dir_spammer.sh' para criar os diretórios necessários, ou cria pelo menos uma pasta manualmente!"

    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

#Indica o fim da condição 'if' iniciada acima
fi

# Verifica se o utilizador que executa o script especificou um argumento ($1)
# O '-z' verifica se o argumento está vazio
if [ -z "$1" ]; then

    # Imprime uma mensagem de erro a informar que não foi definido um argumento, e um exemplo de como executar o mesmo
    echo "Erro: Não foi especificado um argumento para renomear os directórios!"
    echo "Exemplo de execução: ./RenomearPastas.sh exemplo_de_prefixo"
    
    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

#Indica o fim da condição 'if' iniciada acima
fi

# Inicia um loop que vai verificar todos os diretórios diretamente* presentes no nível seguinte ao diretório 'script_sample_folder'
# * Não incluí sub-diretórios (exemplo: ./script_sample_folder/aa/outra_pasta)# Se existir, executa o código abaixo.
for path in ./script_sample_folder/*; do

    # Verifica se o caminho termina num diretório (e não num ficheiro, por exemplo), para executar a ação
    if [ -d "$path" ]; then

        # Cria e guarda na variável 'dirname' o nome atual do directório
        dirname=$(basename "$path")

        # Cria e guarda na variável 'new_dirname', o novo nome para o diretório, 
        # O novo nome será baseado argumento que definimos ($1) e coloca o mesmo no início do nome do diretório, separado com um '-'
        # Exemplo: 'XX-' + nome_antigo; novo_nome-XX (aa, ab, ac, ...)
        new_dirname="$1-$dirname"

        # Aplica a alteração de renomear os diretórios, através do comando mv (move)
        # O primeiro caminho ( $path ) indica o caminho antigo
        # O segundo caminho ( ./script_sample_folder/$new_dirname ) indica o novo caminho
        # A mudança de nome dos repositórios não irão afetar os ficheiros já existentes dentro deles
        # Para atualizar o nome e o caminho dentro deles, é necessário executar o script 'CriarTXT.sh' novamente
        mv "$path" "./script_sample_folder/$new_dirname"

        # Imprime a mensagem a indicar que o repositório mudou de nome, especificando o antigo nome, e o novo nome
        echo "Renomeado o diretório '$dirname' para '$new_dirname'"
    
    # Indica o fim da condição 'if', iniciada acima
    fi

# Indica o fim do loop 'for' iniciado acima
done