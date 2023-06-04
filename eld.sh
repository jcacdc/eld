#!/bin/bash

################################################################################
# Nombre del script: eld.sh
# Descripción: Este script se utiliza para eliminar directorio de forma segura
# Autor: Jorge Giovannelli
# Fecha: 3 de junio de 2023
# Versión: 1.0
# Licencia: Licencia Pública General de GNU (GNU GPL)
################################################################################

eliminar_directorio() {
  directorio=$1

  # Verificar si el directorio existe
  if [ -d "$directorio" ]; then
    # Obtener la cantidad total de archivos y directorios dentro del directorio
    total=$(find "$directorio" -type f -o -type d | wc -l)
    current=0

    # Eliminar todos los archivos y directorios dentro del directorio de forma segura
    find "$directorio" -type f -exec scrub -f {} \; -exec shred -zun 10 -v {} \; -exec bash -c 'echo -ne "Eliminando archivo: $(basename "$0")\r"; current=$((current + 1)); printf "Progreso: %d/%d\r" "$current" "$total";' {} \;
    find "$directorio" -type d -exec bash -c 'rm -rf "$0" && echo -ne "Eliminando directorio: $0\r"; current=$((current + 1)); printf "Progreso: %d/%d\r" "$current" "$total";' {} \;
    
    echo "Se ha eliminado el directorio y su contenido de forma segura: $directorio"
  else
    echo "El directorio no existe: $directorio"
  fi
}

# Verificar que se proporcione un directorio como argumento
if [ $# -lt 1 ]; then
  echo "Debes proporcionar la ruta del directorio a eliminar."
  echo "Uso: bash eliminar_directorio.sh /ruta/al/directorio"
  exit 1
fi

# Directorio a eliminar
directorio=$1

# Llamar a la función eliminar_directorio
eliminar_directorio "$directorio"

