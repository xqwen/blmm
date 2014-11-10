args = commandArgs(trailingOnly = TRUE)
f1 = as.numeric(args[1])
f2 = as.numeric(args[2])
f3 = as.numeric(args[3])



# skat 

library(qvalue)

d = read.table("skat.rst")
rst1 = qvalue(d$V2,fdr.level=0.05)
index = d$V1[which(rst1$sig)]
fdr = sum(index>2500)/length(index)
power = sum(index<=2500)/sum(d$V1<=2500)
print(paste("SKAT-O: ",fdr,power))


source("~/bin/BFDR.R")
d = read.table("bf.rst")

bfv1 = 10^d$V3/3.0 + 10^d$V4/3.0 + 10^d$V5/3.0
rst2 = EBF_fdr(bfv1)
index = d$V1[rst2$rej]

fdr = sum(index>2500)/length(index)
power =	sum(index<=2500)/sum(d$V1<=2500)
print(paste("Bayes-D: ",fdr,power))



bfv2 = 10^d$V3*f1 + 10^d$V4*f2 + 10^d$V5*f3
rst3 = EBF_fdr(bfv2)
index =	d$V1[rst3$rej]

fdr = sum(index>2500)/length(index)
power = sum(index<=2500)/sum(d$V1<=2500)
print(paste("Bayes-E: ",fdr,power))



