#!/bin/bash

################################################################################
# Nombre del script: eld.sh
# Descripción: Eliminación segura de directorios (Versión Mejorada)
# Autor: Jorge Giovannelli (Modificado por Gemini CLI)
# Fecha: 3 de junio de 2023 (Mod. abr 2026)
# Versión: 2.0
# Licencia: Licencia Pública General de GNU (GNU GPL)
################################################################################

# Colores para la terminal
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

eliminar_directorio() {
  local directorio="$1"

  # Verificar si el directorio existe
  if [ -d "$directorio" ]; then
    # Obtener la cantidad total de elementos
    local total=$(find "$directorio" | wc -l)
    local current=0

    echo -e "${BLUE}Iniciando borrado seguro de: $directorio ($total elementos)${NC}"

    # Procesar elementos desde el más profundo hacia afuera (-depth) para evitar errores de rutas
    find "$directorio" -depth | while read -r item; do
      current=$((current + 1))
      local porcentaje=$((current * 100 / total))
      
      if [ -f "$item" ]; then
        echo -ne "\r${RED}[$porcentaje%]${NC} Eliminando archivo: $(basename "$item")\033[K"
        # Ejecutar scrub y shred de forma silenciosa
        scrub -f "$item" >/dev/null 2>&1
        shred -zun 3 "$item" >/dev/null 2>&1
      elif [ -d "$item" ]; then
        echo -ne "\r${RED}[$porcentaje%]${NC} Eliminando carpeta: $(basename "$item")\033[K"
        rm -rf "$item" >/dev/null 2>&1
      fi
    done

    echo -e "\n${GREEN}✓ El directorio y su contenido han sido eliminados de forma segura.${NC}"
  else
    echo -e "${RED}Error: El directorio no existe: $directorio${NC}"
  fi
}

# Verificar que se proporcione un directorio como argumento
if [ $# -lt 1 ]; then
  echo -e "${BLUE}Debes proporcionar la ruta del directorio a eliminar.${NC}"
  echo -e "Uso: bash eld.sh /ruta/al/directorio"
  exit 1
fi

# Directorio a eliminar
directorio=$1

# Llamar a la función eliminar_directorio
eliminar_directorio "$directorio"
