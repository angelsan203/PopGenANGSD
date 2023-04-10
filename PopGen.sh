#!/bin/bash 

#### Análisis con ANGSD #### 
### Alelle frequencies ###

./angsd -b lista1 -anc GenomRef.fasta -out pop1fst -dosaf 1 -GL 1 

# Se hace una vez por cada lista de población "lista 1, lista 2, lista 3 ..." # 

## Si se toman en cuenta dos poblaciones se calculan 2d sfs ##

./angsd/misc/realSFS pop1fst.saf.idx pop2.saf.idx - sfs pop1.pop2.ml -fstout pop1_2

### Estimados globales ###

./angsd -bam_sorted.filelist -GL 1 -doMajorMinor 1 - doMaf 2 -P6 -minMapQ 30 -minQ 20 min.maf 0.05

### Beagle Likelihood ### 

./angsd -GL 1 out Genom1GL -nthreads 6 - do GLF 2 -doMajorminor 1 -SNP_pval 1e-6 -doMaf 1 -bam bam_sorted.filelist 

### Admixture ### 

./angsd/misc/NGSadmix -likes Genom1.GL.beagle.gz -k3 -P 4 -O Genom1Admix -minMaf 0.05 






