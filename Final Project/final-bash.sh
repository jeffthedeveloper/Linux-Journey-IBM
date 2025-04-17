#!/bin/bash

# Verifica se o nÃºmero de argumentos está correto
if [[ $# != 2 ]]; then
  echo "Uso: backup.sh diretorio_origem diretorio_destino"
  exit 1
fi

# Verifica se os argumentos são diretórios válidos
if [[ ! -d $1 ]] || [[ ! -d $2 ]]; then
  echo "Caminho de diretório inválido."
  exit 1
fi

# [TASK 1]
targetDirectory=$1
destinationDirectory=$2

# [TASK 2]
echo "Diretório de origem: $targetDirectory"
echo "Diretório de destino: $destinationDirectory"

# [TASK 3]
currentTS=$(date +%s)

# [TASK 4]
backupFileName="backup-$currentTS.tar.gz"

# [TASK 5]
origAbsPath=$(pwd)

# [TASK 6]
cd "$destinationDirectory"
destDirAbsPath=$(pwd)

# [TASK 7]
cd "$origAbsPath"
cd "$targetDirectory"

# [TASK 8]
yesterdayTS=$(($currentTS - 24 * 60 * 60))

# Array para armazenar arquivos a serem copiados
declare -a toBackup

# [TASK 9]
for file in $(ls); do
  # [TASK 10]
  file_last_modified=$(date -r "$file" +%s)
  if (( $file_last_modified > $yesterdayTS )); then
    # [TASK 11]
    toBackup+=("$file")
  fi
done

# [TASK 12]
if [[ ${#toBackup[@]} -gt 0 ]]; then
  tar -czf "$destDirAbsPath/$backupFileName" "${toBackup[@]}"
else
  echo "Nenhum arquivo modificado nas Ãºltimas 24 horas."
  exit 0
fi

# [TASK 13]
if [[ -f "$destDirAbsPath/$backupFileName" ]]; then
  echo "Backup criado com sucesso: $destDirAbsPath/$backupFileName"
else
  echo "Erro ao criar o backup."
  exit 1
fi

# Parabéns! Você concluiu o projeto final deste curso!