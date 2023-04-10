#### Se indexa el genoma de referencia ####

bwa index GenomRef.fasta

#### Burrows Willer Alignment ####

bwa mem GenomRef.fasta Genom1.1.fasta Genom1.2.fasta -o Genom.1.sam

#### Transformar .sam a .bam ####

samtools view Genom.1.sam -o Genom.1.bam 

#### Sortear los documentos .bam ####

samtools sort Genom.1.bam -o Genom.1_sorted.bam

#### Indexar los documentos .bam y crear listas de .bam ####

### Crear un directorio para los bams ###

mkdir bams_sorted

for i in bams_sorted/*.bam; do samtools index $; done 

ls bams/*.bam > bam.filelist 

nano bam_sorted.filelist 

/your/path/Genom.1_sorted.bam
