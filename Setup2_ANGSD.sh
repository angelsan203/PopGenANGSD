#!/bin/bash
### Segunda parte del setup ### 
### Indexar los documentos .bam y crear listas de .bam ###
## Crear un directorio para los bams ##

echo "Setup para nuevo análisis con ANGSD (parte 2)"

while true; do
    read -p "Escribe el path del directorio del análisis credo en el SETUP1: " path_Analysis
    if [ -d "$path_Analysis" ]; then
        break
    else
        echo "Ruta de directorio inválida. Por favor, introduce una ruta válida hacia un directorio."
    fi
done
cd "$path_Analysis" 
bams_sorted="bams_sorted"
mkdir bams_sorted

for file in "$path_Analysis"/*.bam; do
    cp "$file" "$path_Analysis/$bams_sorted"
done

for i in bams_sorted/*.bam; do
    samtools index "$i"
done 

ls bams_sorted/*.bam.bai > bam.filelist 

#Open bam_sorted.filelist with a text editor if needed
nano bam_sorted.filelist
