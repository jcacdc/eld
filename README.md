# eld - Borrado Seguro de Directorios (Multi-Shell)

`eld` es una herramienta de línea de comandos para eliminar directorios y archivos de forma permanente y segura en sistemas Linux. A diferencia de un borrado convencional, `eld` sobreescribe los datos utilizando patrones avanzados para evitar su recuperación.

## 🚀 Características
- **Borrado Seguro:** Combina `scrub` (patrones NNSA) y `shred` (3 pasadas) para una máxima seguridad.
- **Soporte Multi-Shell:** Compatible con **Bash**, **Zsh** y **Fish**.
- **Progreso en tiempo real:** Visualización elegante del porcentaje y el archivo actual siendo procesado.
- **Recursivo y Robusto:** Borra desde el interior hacia afuera para evitar errores de rutas.
- **Colores:** Interfaz visual clara en la terminal.

## 📋 Requisitos
El script depende de las siguientes herramientas:
- `shred` (incluido en `coreutils`)
- `scrub` (puede requerir instalación manual, ej: `paru -S scrub` en Arch/CachyOS)

## 🔧 Instalación y Alias (Opcional)
Para usarlo como un comando global (`eld`), añade esto a tu archivo de configuración del shell (`.bashrc` o `.zshrc`):

```bash
alias eld='/ruta/donde/hayas/clonado/eld.sh'
```

O si usas **Fish**, crea una función:
```fish
function eld
    /ruta/donde/hayas/clonado/eld.sh $argv
end
```

## 💻 Uso
Simplemente ejecuta el comando seguido de la ruta del directorio que deseas eliminar:

```bash
eld /ruta/al/directorio
```

## ⚠️ Advertencia
Este script elimina los datos de forma **irreversible**. No es posible recuperar los archivos una vez el proceso haya comenzado. Úsalo con responsabilidad.

---
**Autor:** Jorge Giovannelli (Actualizado por Gemini CLI)
**Licencia:** GNU GPL
