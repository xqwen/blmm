# Multiple SNP Fine Mapping Analysis of *Arabidopsis thaliana* Data


### Data Preparation 
The data used for multi-SNP fine mapping analysis is taken from a 200kb genomic region centered around the best hit single SNP association signal chr4:6392280. The data are extracted by running 
```
perl extract_fm_data.pl > fm.R.dat
```
The required input files for this step are "geno.csv.gz", "pheno.qnorm.bimbam" and "pheno.id". They are all provided in the data directory.

The next step is to perform a linear transformation of genotype and phenotype matrices to account for the relatedness in the data. This is done by running
```
Rscript pre_processing.R
```
The output "fm.sbams.dat" is ready to be input for running MCMC using the software [sbams] (http://github.com/xqwen/sbams)  


### Runing MCMC

```
sbams_mvlr -d fm.sbams.dat -g grid.fm -b 150000 -r 300000 > fm.sbams.out
```


 
 



