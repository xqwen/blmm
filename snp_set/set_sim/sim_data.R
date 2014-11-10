args = commandArgs(trailingOnly = TRUE)

num = args[1]
model = as.numeric(args[2])
index = args[3]


infile = paste("../sim_geno/geno.",num,sep="")
outfile = paste("sim_data/gene.",index,".dat", sep="")

Z = as.matrix(read.table(infile))

n = dim(Z)[1]
p = dim(Z)[2]

cov1 = rnorm(n)
err = rnorm(n)
y = cov1 + err

if(model !=0){
  freq = apply(Z,2, function(x) 1- sum(x)/(2*n))
  snp_set = which(freq>1/n&freq<=0.05)

  c = 0.1 
  prop = 0.25
  eff_set = sample(snp_set,size = floor(prop*length(snp_set)))
  bv = rep(0,p)
  bv[eff_set] = abs(log10(freq[eff_set]))*c

 if(model == 2){
   sign = sample(c(-1,1), size=length(eff_set), replace=T, prob=c(0.25,0.75))
   bv[eff_set] = bv[eff_set]*sign
 }

 if(model == 3){
    mf = max(freq)
    index = sample(which(freq<=mf&freq>0.5*mf),1)
    bv = rep(0,p)
    bv[index] = rnorm(1)
 }    



 y = y+(2-Z)%*%bv
}

y = qnorm(rank(y)/(n+1))



dv = cbind(y,cov1,2-Z)
write(file = outfile, t(dv), ncol = dim(dv)[2])


