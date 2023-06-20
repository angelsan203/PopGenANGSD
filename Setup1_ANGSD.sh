
#!/bin/bash

#### Setup y preparación de los datos #### 

### Exportar bwa y angsd para usarlo dentro del ambiente ### 

### Bienvenida y Creación de un directorio para todo el análisis ### 

echo "Setup para nuevo análisis con ANGSD (parte 1)"

# Validación de datos para comenzar el análisis 
while true; do
    read -p "Escriba el nombre que desea asignar al nuevo análisis. Escribalo solamente usando números, letras o guiones bajos (_): " analysis_name
    if echo "$analysis_name" | grep -qE '^[[:alnum:]_]+$'; then
        break
    else
        echo "Nombre inválido. Por favor, utilice solo números, letras o guiones bajos (_)."
    fi
done

while true; do
    read -p "Escribe el path del directorio donde se encuentra tu genoma de referencia: " path_GenRef
    if [ -d "$path_GenRef" ]; then
        break
    else
        echo "Ruta de directorio inválida. Por favor, introduce una ruta válida hacia un directorio."
    fi
done

cd "$path_GenRef"
mkdir "$analysis_name"

analysis_path="$path_GenRef/$analysis_name"

cd "$analysis_path"
Genomindex="Genomindex"
mkdir Genomindex
indexpath="$analysis_path/$Genomindex"

for filename in "$path_GenRef"/*.fasta; do
    echo "$filename"
done

for filename in "$path_GenRef"/*.fna; do
    echo "$filename"
done

read -p "Escribe el nombre del archivo del genoma de referencia como se encuentra en la lista anterior: " GenomRef

cp "$path_GenRef/$GenomRef" "$indexpath"
cd "$indexpath"

if [[ ! -f "$indexpath/$GenomRef.bwt" ]]; then
    bwa index "$indexpath/$GenomRef"
else
    echo "El genoma de referencia ya ha sido indexado."
fi


### Burrows Willer Alignment ###
while true; do
    read -p "Escribe el path del directorio donde se encuentran los archivos .fastq de los genomas a analizar:  " pathfastq
    if [ -d "$pathfastq" ]; then
        break
    else
        echo "Ruta de directorio inválida. Por favor, introduce una ruta válida hacia un directorio."
    fi
done

for file in "$pathfastq"/*.fq.gz; do
    if [[ "$file" != ".rem." ]]; then
        if [[ "$file" == *".1.fq.gz" || "$file" == *".2.fq.gz" ]]; then
            cp "$file" "$analysis_path"
        fi
    fi
done

cd "$analysis_path"

#Obtener los prefijos para crear los archivos .bam 

for file in "$analysis_path"/*.fq.gz; do

    filename=$(basename "$file")
    prefix=${filename%_.*};

    bwa mem -t 6 "$indexpath/$GenomRef" "${prefix}.1.fq.gz" "${prefix}.2.fq.gz" -o "${prefix}".sam

    bamfile="${prefix}.bam"
    samtools view -b "${prefix}.sam" > "$bamfile"

    sorted_bam="${prefix}.bam"
    samtools sort "$bamfile" -o "$sorted_bam"
done
