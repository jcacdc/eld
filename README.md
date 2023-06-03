# eld
Elimina directorios con sus archivos de forma segura

A continuación, comentaré línea por línea lo que hace el script:

bash

#!/bin/bash

Esta línea indica que el script debe ser interpretado por bash.

bash

eliminar_directorio() {
  directorio=$1

Se define una función llamada eliminar_directorio que toma un argumento, que será el directorio a eliminar.

bash

  # Verificar si el directorio existe
  if [ -d "$directorio" ]; then

Se verifica si el directorio existe. Si es un directorio válido, se procede con la eliminación.

bash

    # Obtener la cantidad total de archivos y directorios dentro del directorio
    total=$(find "$directorio" -type f -o -type d | wc -l)
    current=0

Se utiliza el comando find junto con la opción -type f para buscar y contar la cantidad total de archivos (-type f) y directorios (-type d) dentro del directorio proporcionado. La cantidad total se almacena en la variable total, y se inicializa una variable current para realizar un seguimiento del progreso actual de eliminación.

bash

    # Eliminar todos los archivos y directorios dentro del directorio de forma segura
    find "$directorio" -type f -exec scrub -f {} \; -exec shred -zun 10 -v {} \; -exec bash -c 'echo -ne "Eliminando archivo: $(basename "$0")\r"; current=$((current + 1)); printf "Progreso: %d/%d\r" "$current" "$total";' {} \;

Se utiliza el comando find junto con la opción -type f para encontrar todos los archivos (-type f) dentro del directorio y se ejecutan los comandos scrub -f y shred -u en cada archivo para eliminarlo de forma segura. Además, se utiliza bash -c para mostrar el progreso de eliminación de cada archivo mediante la impresión de un mensaje con el nombre del archivo actual y el progreso actual y total.

bash

    find "$directorio" -type d -exec bash -c 'rm -rf "$0" && echo -ne "Eliminando directorio: $0\r"; current=$((current + 1)); printf "Progreso: %d/%d\r" "$current" "$total";' {} \;

Se utiliza el comando find junto con la opción -type d para encontrar todos los directorios (-type d) dentro del directorio y se ejecuta el comando rm -rf en cada directorio para eliminarlo de forma segura. Al igual que antes, se utiliza bash -c para mostrar el progreso de eliminación de cada directorio mediante la impresión de un mensaje con el nombre del directorio actual y el progreso actual y total.

bash

    echo "Se ha eliminado el directorio y su contenido de forma segura: $directorio"
  else
    echo "El directorio no existe: $directorio"
  fi
}

Se muestra un mensaje indicando que el directorio y su contenido se han eliminado de forma segura si el directorio existía. Si el directorio no existe, se muestra un mensaje correspondiente.

bash

# Verificar que se proporcione un directorio como argumento
if [ $# -lt 1 ]; then
  echo "Debes proporcionar la ruta del directorio a eliminar."
  echo "




