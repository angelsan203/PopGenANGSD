
#### Setup y preparación de los datos #### 

### Bienvenida y Creación de un directorio para todo el análisis ### 

echo "Nuevo análisis con ANGSD"
echo "Escribe el nombre del Nuevo Análisis sin espacios ni caracteres especiales" 
read analysis_name
echo "Escribe el path de la carpeta donde se encuentra tu genoma de referencia" 
read path2GenRef 
Echo "Ahora escribe el nombre de la carpeta donde se encuentra tu genoma de referencia"
read GenRefDir

cd $path2GenRef
mkdir $analysis_name 

for i in $GenRefDir/*.fasta
 do echo $filename
done 

echo "Escribe el nombre del archivo del genoma de referencia como se encuentra en la lista anterior" 
read GenomRef

### Se indexa el genoma de referencia ###

bwa index GenomRef

### Burrows Willer Alignment ###
echo "Escribe el path del directorio donde se encuentran los fasta q de los genomas a analizar" 
read pathfastq




bwa mem GenomRef Genom1.1.fasta Genom1.2.fasta -o Genom.1.sam

### Transformar .sam a .bam ###

samtools view Genom.1.sam -o Genom.1.bam 

### Sortear los documentos .bam ###

samtools sort Genom.1.bam -o Genom.1_sorted.bam

### Indexar los documentos .bam y crear listas de .bam ###

## Crear un directorio para los bams ##

mkdir bams_sorted

for i in bams_sorted/*.bam; do samtools index $; done 

ls bams/*.bam > bam.filelist 

nano bam_sorted.filelist 

/your/path/Genom.1_sorted.bam
