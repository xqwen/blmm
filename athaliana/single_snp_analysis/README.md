# Single SNP Analysis of *Arabidopsis thaliana* Data


### Frequentist Analysis

The frequentist single SNP analysis is performed by using software package [GEMMA] (http://www.xzlab.org/software.html). For single SNP Wald statistics,
```
gmmea -g athaliana.bimbam.geno -p pheno.qnorm.bimbam -k kinship.matrix -lmm 1
```

For single SNP score statistics
```
gmmea -g athaliana.bimbam.geno -p pheno.qnorm.bimbam -k kinship.matrix -lmm 2
```




### Bayesian Analysis

Based on the output from GEMMA, namely the MLE of beta and its standard error, the R script "single_SNP.R" computes the corresponding Bayes factors. The usage is 
```
Rscript single_SNP.R gemma_single_SNP_output_file
```
The output is written to a text file named "bf.rst".

Alternatively, for fast processing large-scale GWAS data, one can use software package [MeSH] (https://github.com/xqwen/mesh/). To do so, first convert the gemma output to MeSH input by running
```
perl convert2mesh.pl gemma_single_SNP_output_file > mesh_input.dat
```
then run the following command
```
mesh -d mesh_input.dat -g grid -min_info > bf.out
```
where the grid file is provided in this directory.

In both cases, "gemma_single_SNP_output_file" represents either wald or score test output from the frequentist analysis.

 
 



