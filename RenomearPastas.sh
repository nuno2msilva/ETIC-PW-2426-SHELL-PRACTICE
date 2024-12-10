#!/bin/bash

# Verifica se o diretório 'script_sample_folder' existe
if ! [ -d "./script_sample_folder" ]; then
    echo "O diretório 'script_sample_folder' não existe. Execute 'dir_spammer.sh' para criar os subdiretórios necessários!"
    exit 1
fi

# Verifica se 'script_sample_folder' tem subdiretórios
if [ -z "$(ls -A ./script_sample_folder)" ]; then
    echo "Não existem subdiretórios em 'script_sample_folder'! Crie pelo menos um subdiretório!"
    exit 1
fi

# Verifica se o argumento foi fornecido
if [ -z "$1" ]; then
    echo "Erro: Argumento para renomear subdiretórios não especificado!"
    echo "Exemplo: ./RenomearPastas.sh exemplo_de_prefixo"
    exit 1
fi

# Renomeia os subdiretórios com base no prefixo fornecido
for path in ./script_sample_folder/*; do
    if [ -d "$path" ]; then
        dirname=$(basename "$path")
        mv "$path" "./script_sample_folder/$1-$dirname"
        echo "Renomeado o subdiretório '$dirname' para '$1-$dirname'"
    fi
done