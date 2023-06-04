##################################
#Jorge Giovannelli 04/06/2023 ####
##################################

#!/bin/bash

mostrar_menu() {
  echo "Menú:"
  echo "1. Realizar respaldo"
  echo "2. Restaurar respaldo"
  echo "3. Salir"
}

realizar_respaldo() {
  read -p "Directorio de origen: " directorio_origen
  read -p "Directorio de destino: " directorio_destino

  # Genera el nombre del archivo de respaldo basado en la fecha actual
  nombre_archivo="respaldo_$(date +%Y%m%d_%H%M%S).tar.gz"

  # Crea el archivo de respaldo comprimido, excluyendo los directorios especificados
  tar -czvpf "$directorio_destino/$nombre_archivo" --exclude="$directorio_origen/.cache" --exclude="$directorio_origen/tmp" -C "$directorio_origen" .

  # Verifica si el respaldo se ha creado correctamente
  if [ $? -eq 0 ]; then
    echo "El respaldo se ha creado correctamente en $directorio_destino/$nombre_archivo"
  else
    echo "Ha ocurrido un error al crear el respaldo"
  fi
}

restaurar_respaldo() {
  read -p "Archivo de respaldo: " archivo_respaldo
  read -p "Directorio de destino: " directorio_destino

  # Verifica que el archivo de respaldo exista
  if [ ! -f "$archivo_respaldo" ]; then
    echo "El archivo de respaldo $archivo_respaldo no existe"
    return
  fi

  # Extrae el contenido del archivo de respaldo en el directorio destino
  tar -xzvpf "$archivo_respaldo" -C "$directorio_destino"

  # Verifica si la recuperación se ha realizado correctamente
  if [ $? -eq 0 ]; then
    echo "La recuperación se ha realizado correctamente en $directorio_destino"
  else
    echo "Ha ocurrido un error al realizar la recuperación"
  fi
}

ejecutar_script() {
  while true; do
    mostrar_menu

    read -p "Selecciona una opción: " opcion

    case $opcion in
      1)
        realizar_respaldo
        ;;
      2)
        restaurar_respaldo
        ;;
      3)
        echo "Saliendo del script..."
        break
        ;;
      *)
        echo "Opción inválida. Por favor, selecciona una opción válida."
        ;;
    esac

    echo ""
  done
}

ejecutar_script

