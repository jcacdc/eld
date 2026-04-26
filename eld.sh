#!/bin/bash

################################################################################
# Nombre del script: eld.sh
# Descripción: Eliminación segura de directorios (Versión Multi-Shell)
# Autor: Jorge Giovannelli (Modificado por Gemini CLI)
# Versión: 2.1
################################################################################

# Colores (compatibles con Bash y Zsh)
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

eliminar_directorio() {
  local directorio="$1"

  if [ -d "$directorio" ]; then
    local total=$(find "$directorio" | wc -l)
    local current=0

    printf "${BLUE}Iniciando borrado seguro de: %s (%d elementos)${NC}\n" "$directorio" "$total"

    # Procesar elementos desde el fondo (-depth)
    while IFS= read -r item; do
      current=$((current + 1))
      local porcentaje=$((current * 100 / total))
      
      if [ -f "$item" ]; then
        printf "\r${RED}[%d%%]${NC} Eliminando archivo: %s\033[K" "$porcentaje" "$(basename "$item")"
        scrub -f "$item" >/dev/null 2>&1
        shred -zun 3 "$item" >/dev/null 2>&1
      elif [ -d "$item" ]; then
        printf "\r${RED}[%d%%]${NC} Eliminando carpeta: %s\033[K" "$porcentaje" "$(basename "$item")"
        rm -rf "$item" >/dev/null 2>&1
      fi
    done <<EOF
$(find "$directorio" -depth)
EOF

    printf "\n${GREEN}✓ El directorio y su contenido han sido eliminados de forma segura.${NC}\n"
  else
    printf "${RED}Error: El directorio no existe: %s${NC}\n" "$directorio"
  fi
}

if [ $# -lt 1 ]; then
  printf "${BLUE}Uso: eld /ruta/al/directorio${NC}\n"
  exit 1
fi

eliminar_directorio "$1"
