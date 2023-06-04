# Script para eliminar directorio de forma segura

Este script de Bash tiene como objetivo eliminar de forma segura un directorio y todos sus archivos y subdirectorios.

## Uso

1. Asegúrate de tener Bash instalado en tu sistema.

2. Descarga el archivo `eld.sh`.

3. Abre una terminal y navega hasta la ubicación donde se encuentra el archivo descargado.

4. Ejecuta el siguiente comando:

   ```bash
   bash eld.sh /ruta/al/directorio

Asegúrate de reemplazar /ruta/al/directorio con la ruta del directorio que deseas eliminar.

Descripción del script

El script consta de varias partes:

    Verifica si el directorio especificado existe.
    Cuenta el número total de archivos y directorios dentro del directorio.
    Elimina de forma segura todos los archivos dentro del directorio, sobrescribiéndolos con datos aleatorios y eliminándolos varias veces.
    Elimina los subdirectorios de forma recursiva.
    Imprime mensajes de progreso durante el proceso de eliminación.

Si el directorio se elimina exitosamente, se mostrará un mensaje indicando que se ha eliminado de forma segura. En caso de que el directorio no exista, se mostrará un mensaje de error correspondiente.

Recuerda tener precaución al utilizar este script, ya que eliminará permanentemente el directorio y su contenido de forma segura.

¡Utilízalo con responsabilidad!
