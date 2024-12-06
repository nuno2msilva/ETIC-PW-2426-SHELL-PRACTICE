#!/bin/bash

# Criar .txt
# O script deve ser capaz de:
# - Criar um arquivo .txt em cada repositório de script_sample_folder;
# - Cada arquivo .txt deve ter nome igual a "script_sample_folder-<nome do folder>".

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
    echo "Não existem directórios em 'script_sample_folder'! Execute primeiro o script 'dir_spammer.sh' para criar os diretórios necessários, ou cria pelo menos uma pasta manualmente!"

    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

#Indica o fim da condição 'if' iniciada acima
fi


# Inicia um loop que vai verificar todos os diretórios diretamente presentes no nível seguinte ao diretório 'script_sample_folder'
# *Não inclui subdiretórios (exemplo: ./script_sample_folder/aa/outra_pasta)
for path in ./script_sample_folder/*; do

    # Verifica se o caminho termina num diretório (e não num ficheiro, por exemplo)
    if [ -d "$path" ]; then

        # Cria a variável 'dirname' e guarda nela o nome atual do diretório
        dirname=$(basename "$path")

        # Cria a variável 'expected_filename' e guarda nela o nome previsto para o ficheiro
        expected_filename="script_sample_folder-$dirname.txt"

        # Cria a variável 'expected_filepath', e guarda nela o caminho previsto até ao ficheiro
        expected_filepath="$path/$expected_filename"

        # Verifica se existe um arquivo .txt no diretório que não corresponde ao nome esperado
        # Verifica a existência de um ficheiro txt em cada diretório em './script_sample_folder/'
        for txt_file in "$path"/*.txt; do

            # Se o ficheiro txt e o seu nome atual for diferente ao previsto para essa pasta (caso a pasta tenha sido renomeada), executa as ações
            if [ -f "$txt_file" ] && [ "$(basename "$txt_file")" != "$expected_filename" ]; then
                
                # Imprime uma mensagem a indicar que o nome do arquivo se encontra desatualizado
                echo "O nome do diretório foi alterado! A renomear $(basename "$txt_file") para $expected_filename"
                
                # Aplica a alteração de renomear dos ficheiros, através do comando mv (move)
                # O primeiro ficheiro ( $txt_file ) indica o nome do ficheiro antigo
                # O segundo ficheiro ( $expected_filepath ) indica o nome do novo ficheiro
                mv "$txt_file" "$expected_filepath"
            
            # Indica o fim da condição 'if' iniciada acima
            fi

        # Indica o fim do loop 'for' iniciado acima
        done

        # Atualiza ou cria o arquivo .txt com o nome esperado
        echo "Atualizando o arquivo $expected_filename no diretório $dirname"

        # Aplica a alteração de renomear dos ficheiros, através do comando mv (move)
        # O primeiro ficheiro ( $txt_file ) indica o nome do ficheiro antigo
        # O segundo ficheiro ( $expected_filepath ) indica o nome do novo ficheiro
        echo "$expected_filepath" > "$expected_filepath"
    
    # Indica o fim da condição 'if' iniciada acima
    fi

# Indica o fim do loop 'for' iniciado acima
done