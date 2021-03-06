# Simulations for SNP Set Testing

### Software utilities

The necessary R and perl scripts are provided in this directory. [openmp_wrapper] (https://github.com/xqwen/openmp_wrapper) is a free software to perform parallel computing on a multi-core computer. [hm_em] (https://github.com/xqwen/mesh/tree/master/src/HM/) implements an EM algorithm to estimate the proportions of specified models from a mixture.


### Simulation Steps

* start simulation
```shellscript
 mkdir bf_rst sim_data skat_rst
 perl sim_data.pl > simulation.cmd
``` 
* simulate phenotype
```shellscript
openmp_wrapper -d simulation.cmd -t 10 &
```
* perform analysis
```shellscript
openmp_wrapper -d analysis.cmd -t 10 &
```
* summarize results 
```shellscript
cat skat_rst/* | sort -nk1 > skat.rst
cat bf_rst/* > bf.hm.in
sed -i 's/Inf/100/g' bf.hm.in
sed  's/snp[0-9]*_gene//g' bf.hm.in | sort -nk1 > bf.rst
hm_em -d bf.hm.in -g 3 -s 1 >/dev/null 
```
Take proportion estimate from hm_em 
```shellscript
Rscript summary.R p1 p2 p3
```

