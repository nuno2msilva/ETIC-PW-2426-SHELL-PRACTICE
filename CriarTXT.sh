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

# Verifica e processa cada subdiretório dentro de 'script_sample_folder'
for path in ./script_sample_folder/*; do
    if [ -d "$path" ]; then
        dirname=$(basename "$path")
        expected_filename="script_sample_folder-$dirname.txt"
        expected_filepath="$path/$expected_filename"

        # Verifica se existe algum ficheiro txt, e cria ou corrige conforme necessário
        txt_file=$(find "$path" -maxdepth 1 -type f -name "*.txt")
        
        if [ -z "$txt_file" ]; then
            echo "Foi criado o ficheiro $expected_filename no subdiretório $dirname!"
            echo "$expected_filepath" > "$expected_filepath"
        else
            current_filename=$(basename "$txt_file")

            if [ "$current_filename" != "$expected_filename" ]; then
                echo "O nome do ficheiro $current_filename está desatualizado! Foi corrigido para $expected_filename."
                mv "$txt_file" "$expected_filepath"
                echo "$expected_filepath" > "$expected_filepath"
            else
                content=$(cat "$txt_file")
                if [ "$content" != "$expected_filepath" ]; then
                    echo "O conteúdo do ficheiro $expected_filename está incorreto, e foi corrigido!"
                    echo "$expected_filepath" > "$expected_filepath"
                else
                    echo "O nome e conteúdo do ficheiro $expected_filename já estão corretos!"
                    continue
                fi
            fi
        fi
    fi
done

