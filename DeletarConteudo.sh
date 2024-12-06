#!/bin/bash

# Deletar conteúdo
# O script deve ser capaz de:
# - Deletar todo o conteúdo de um determinada diretório de script_sample_folder;
# - Receber um caracter qualquer como argumento de quem evoca o script;
# - Aplicar a deleção de conteúdo somente em diretórios de script_sample_folder que contenham o dado caracter.

# Verifica a ausência do diretório 'script_sample_folder'
if ! [ -d ./script_sample_folder ]; then

    # Imprime uma mensagem de erro, neste caso, se o diretório do 'script_sample_folder' não existir
    echo "A pasta 'script_sample_folder' não existe. Execute primeiro o 'dir_spammer.sh'!"

    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

#Indica o fim da condição 'if' iniciada acima
fi

# Verifica se o diretório 'script_sample_folder' NÃO tem diretórios dentro do mesmo
if ! find ./script_sample_folder -mindepth 2 -print -quit | grep -q .; then

    # Como é que vamos apagar diretórios se eles não existem?
    echo "Nenhum directório com conteúdos a apagar! Execute primeiro o script 'CriarTXT' para criar um ficheiro de texto, ou crie pelo menos um ficheiro de texto manualmente!"

    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

# Indica o fim da condição 'if' iniciada acima
fi

# Para cada diretório dentro de 'script_sample_folder'
for dir in ./script_sample_folder/*; do

    # Se for um diretório existente
    if [ -d "$dir" ]; then

        # E se contém qualquer diretório e/ou ficheiro dentro dele
        if [[ "$(basename "$dir")" == *"$1"* ]]; then

            # Apaga qualquer diretório e/ou ficheiro dentro dele
            rm -rf "$dir"/*
            
            # Imprime a mensagem que se estes continham alguma coisa, foi agora eliminado.
            echo "Se o diretório '$dir' tinha algum diretório e/ou ficheiro, ele foi agora eliminado com sucesso!"
        # Indica o fim da condição 'if' iniciada acima    
        fi
    # Indica o fim da condição 'if' iniciada acima    
    fi

# Indica o fim do loop 'for' iniciado acima    
done