#!/bin/bash

# Deletar diretórios
# O script deve ser capaz de:
# - Deletar diretórios de script_sample_folder;
# - Receber um argumento booleano de quem evoca o script;
# - Caso o argumento booleano seja passado, deletar todos os diretórios de script_sample_folder;
# - Caso o argumento booleano não seja passado, deletar somente aqueles diretórios que têm conteúdo dentro.

# Verifica a ausência do diretório 'script_sample_folder'
if ! [ -d ./script_sample_folder ]; then

    # Imprime uma mensagem de erro, neste caso, se o diretório do 'script_sample_folder' não existir
    echo "A pasta 'script_sample_folder' não existe. Corra primeiro o 'dir_spammer.sh'!"

    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

#Indica o fim da condição 'if' iniciada acima
fi

# Verifica se o diretório 'script_sample_folder' NÃO tem diretórios dentro do mesmo
if ! find ./script_sample_folder -mindepth 1 -type d | grep -q .; then

    # Como é que vamos apagar diretórios se eles não existem?
    echo "Não existem directórios a apagar! Corra primeiro o script 'dir_spammer.sh' para criar os diretórios necessários, ou cria pelo menos um diretório manualmente!"

    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

# Indica o fim da condição 'if' iniciada acima
fi

# Verifica se o utilizador que executa o script especificou um argumento ($1)
# O '-z' verifica se o argumento está vazio
if [ -z "$1" ]; then

    # Imprime uma mensagem de erro a informar que não foi definido um argumento, e um exemplo de como executar o mesmo
    echo "Erro: Não foi especificado um argumento booleano!"
    echo "Exemplo de execução: ./DeletarDiretorios.sh true OU ./DeletarDiretorios.sh false"
    echo ""
    echo "OBSERVAÇÃO: Um argumento verdadeiro (true), vai apagar TODOS os diretórios existentes em script_sample_folder"
    echo "Um argumento falso (false), vai apagar os diretórios APENAS com diretórios e/ou ficheiros dentro deles"
    
    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando
    exit 1

#Indica o fim da condição 'if' iniciada acima
fi

# Verifica se o argumento booleano escrito é verdadeiro ('true')
if [ "$1" == "true" ]; then

    # Verifica para cada diretório dentro de ./script_sample_folder
    for dir in ./script_sample_folder/*; do

        # Se $dir for um diretório existente
        if [ -d "$dir" ]; then
        
            # Elimina o mesmo
            rm -rf "$dir"

            # Imprime a mensagem a confirmar a eliminação do diretório
            echo "O diretório '$dir' foi eliminado com sucesso!"
        
        #Indica o fim da condição 'if' iniciada acima
        fi
    
    # Indica o fim do loop 'for' iniciado acima
    done

# Verifica se o argumento booleano escrito é falso ('false')
elif [ "$1" == "false" ]; then
    
    #Verifica para cada diretório dentro de ./script_sample_folder
    for dir in ./script_sample_folder/*; do
        
        # Se $dir for um diretório existente
        if [ -d "$dir" ]; then
            
            # E este conter algum diretório e/ou ficheiro dentro dele
            if [ "$(ls -A "$dir")" ]; then
                
                # Elimina o mesmo
                rm -rf "$dir"
                
                # Imprime a mensagem a confirmar a eliminação do diretório, e indica que continha diretórios e/ou ficheiros dentro dele
                echo "O diretório '$dir', que continha diretórios e/ou ficheiros dentro do mesmo, foi eliminado com sucesso!"
            
            #Indica o fim da condição 'if' iniciada acima
            fi
        
        #Indica o fim da condição 'if' iniciada acima
        fi
    
    # Indica o fim do loop 'for' iniciado acima
    done

# Se o argumento escrito não for nem verdadeiro ('true') ou falso ('false')
else

    # Imprime a seguinte mensagem de erro, a informar que o argumento escrito é invalido (texto que não seja booleanos ('true' ou 'false'))
    echo "O argumento que escreveu é inválido. Passe apenas 'true' ou 'false'."
    echo ""
    echo "OBSERVAÇÃO: Um argumento verdadeiro (true), vai apagar TODOS os diretórios existentes em script_sample_folder"
    echo "Um argumento falso (false), vai apagar os diretórios APENAS com diretórios e/ou ficheiros dentro deles"
    
    # Encerra o script com um código de erro 1, indicando um erro com uma cruzinha vermelha no lado esquerdo do comando#
    exit 1

#Indica o fim da condição 'if' iniciada acima   
fi