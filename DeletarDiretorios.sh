#!/bin/bash

# Verifica se 'script_sample_folder' existe
if ! [ -d "./script_sample_folder" ]; then
    echo "O diretório 'script_sample_folder' não existe. Execute 'dir_spammer.sh' para criar os subdiretórios necessários!"
    exit 1
fi

# Verifica se há subdiretórios em 'script_sample_folder'
if [ -z "$(ls -A ./script_sample_folder)" ]; then
    echo "Não existem subdiretórios em 'script_sample_folder'! Crie pelo menos um subdiretório!"
    exit 1
fi

# Verifica se um argumento foi fornecido
if [ -z "$1" ]; then
    echo "Erro: Argumento booleano não especificado!"
    echo "Exemplo: ./DeletarDiretorios.sh true OU ./DeletarDiretorios.sh false"
    exit 1
fi

# Se o argumento for 'true', apaga todos os subdiretórios
if [ "$1" == "true" ]; then
    for dir in ./script_sample_folder/*; do
        if [ -d "$dir" ]; then
            rm -rf "$dir"
            echo "O subiretório '$dir' foi eliminado com sucesso!"
        fi
    done

# Se o argumento for 'false', apaga apenas subdiretórios com ficheiros
elif [ "$1" == "false" ]; then
    for dir in ./script_sample_folder/*; do
        if [ -d "$dir" ] && [ "$(ls -A "$dir")" ]; then
            rm -rf "$dir"
            echo "O subdiretório '$dir' foi eliminado com sucesso!"
        fi
    done

# Caso o argumento não seja nem 'true' nem 'false'
else
    echo "O argumento '$1' é inválido. Use apenas 'true' ou 'false'."
    exit 1
fi
