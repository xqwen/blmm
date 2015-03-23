# *Arabidopsis thaliana* Data Processing


### Download

The zipped file "geno.csv.gz" contains the *Arabidopsis thaliana* genotype data downloaded from [here] (https://easygwas.tuebingen.mpg.de/data/public/dataset/view/1/)

The sodium phenotype file is downloaded from the supplementary materials of [Baxter *et al*, 2010] (http://journals.plos.org/plosgenetics/article?id=10.1371/journal.pgen.1001193)


The software package GEMMA used to estimate kinship matrix and perform Freqentist analysis can be downloaed freely from [this site] (http://www.xzlab.org/software.html). 


### Processing

336 individuals with both genotype and phenotype data available are selected for the analysis. In addition, a qunatile normalization is performed with respect to the original phenotype measurements (sodium.dat) to prevent the influence of potential outliers. The output from the quantile normalization step is formated into bimbam format and ready to be processed by GEMMA (pheno.qnorm.bimbam). 

The csv genotype file is converted to bimbam format and ready to be processed by GEMMA:
```
perl convert_geno_to_bimbam.pl > athaliana.bimbam.geno
```
Note, running this script requires files "geno.csv.gz" and "pheno.id" in the working directory. To save space, the processed genotype file is not provided in the repo.



### Estimating Kinship Matrix

The kinship matrix is estimated by GEMMA using the following command
```
gemma -g athaliana.bimbam.geno -p pheno.qnorm.bimbam -gk 1 -o kinship
```
The output is provided as a text file "kinship.matrix"

