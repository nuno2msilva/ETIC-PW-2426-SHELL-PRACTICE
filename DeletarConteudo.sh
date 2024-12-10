#!/bin/bash

# Verifica se o diretório 'script_sample_folder' existe
if ! [ -d "./script_sample_folder" ]; then
    echo "O diretório 'script_sample_folder' não existe. Execute 'dir_spammer.sh' para criar os subdiretórios necessários!"
    exit 1
fi

# Verifica se existem subdiretórios dentro de 'script_sample_folder'
if [ -z "$(ls -A ./script_sample_folder)" ]; then
    echo "Não existem subdiretórios em 'script_sample_folder'. Crie pelo menos um!"
    exit 1
fi

# Verifica se há ficheiros em qualquer subdiretório
has_files=false
for dir in ./script_sample_folder/*; do
    [ -d "$dir" ] && [ "$(find "$dir" -type f)" ] && has_files=true && break
done

# Se não há ficheiros e não foi passado argumento, termina o script
if [ -z "$1" ]; then
    if ! $has_files; then
        echo "Não existem ficheiros em qualquer subdiretório de 'script_sample_folder'."
        exit 1
    fi

    # Pergunta ao utilizador se deseja apagar os ficheiros
    read -p "Isto irá apagar todos os ficheiros em todos os subdiretórios. Continuar? (Y/YES para CONFIRMAR, qualquer outra resposta para CANCELAR): " answer
    case "$answer" in
        [yY]|[yY][eE][sS])
            for dir in ./script_sample_folder/*; do
                [ -d "$dir" ] && [ "$(find "$dir" -type f)" ] && rm -rf "$dir"/* && echo "Ficheiros em '$dir' apagados."
            done
            ;;
        *)
            echo "Operação cancelada pelo utilizador."
            ;;
    esac
else
    # Se foi passado um argumento, verifica os subdiretórios correspondentes
    found_any=false
    all_empty=true
    for dir in ./script_sample_folder/"$1"*; do
        [ -d "$dir" ] || continue
        found_any=true
        if [ "$(find "$dir" -type f)" ]; then
            rm -rf "$dir"/*
            echo "Arquivos em '$dir' apagados."
            all_empty=false
        fi
    done

    # Se todos os subdiretórios estão vazios, informa o utilizador
    if $all_empty; then
        echo "Não foi encontrado conteúdo nos subdiretórios iniciados por '$1'."
        exit 1
    fi
fi