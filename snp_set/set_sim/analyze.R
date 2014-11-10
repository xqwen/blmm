library(SKAT)
args = commandArgs(trailingOnly = TRUE)
num = args[1]
data_file = paste("sim_data/gene.",num,".dat",sep="")
bf_file = paste("bf_rst/gene.",num,".bf",sep="")
skat_file = paste("skat_rst/gene.",num,".skat",sep="")


d = as.matrix(read.table(data_file))
n = dim(d)[1]
p = dim(d)[2]

y = d[,1]
cov1 = d[,2]
G = d[,3:p]
obj = SKAT_Null_Model(y~ cov1,out_type="C")
pvo = SKAT(G, obj, method="optimal")$p.value


# Bayesian analysis
compute_log10_ABF<-function(Y, Xg, Xc, wv, phi, mode=1){

   n = dim(Y)[1]
   q = dim(Xc)[2]
   p = dim(Xg)[2]

   X = cbind(Xc,Xg)




   s2 = as.numeric((t(Y)%*%(diag(rep(1,n)) - Xc%*%solve(t(Xc)%*%Xc)%*%t(Xc))%*%Y)/n)

   # ES by default
   if(mode ==1){
     Wg = s2*phi^2*diag(wv)
   }
   if(mode == 2){
     wv = sqrt(wv)
     Wg = s2*phi^2*(wv%*%t(wv))
   }
   #Wg = matrix(ncol=p,rep(1,p*p))
   Vg_inv = (t(Xg)%*%Xg - t(Xg)%*%Xc%*%solve(t(Xc)%*%Xc)%*%t(Xc)%*%Xg)/s2
   vec = matrix(ncol=1, as.vector(t(Y-Xc%*%solve(t(Xc)%*%Xc)%*%t(Xc)%*%Y)))
   bVi = t(vec)%*%(Xg/s2)
   ivw = diag(rep(1,p))+Vg_inv%*%Wg
   log10_abf = (.5*bVi%*%Wg%*%solve(ivw)%*%t(bVi)-0.5*determinant(ivw)$modulus[[1]])/log(10)
   return(log10_abf)

}

compute_log10_ABF2<-function(Y,g,Xc, phiv){
   X = cbind(Xc,g)
   beta = solve(t(X)%*%X)%*%t(X)%*%Y
   bhat = beta[3,1]
   s2 = as.numeric((t(Y)%*%Y - t(beta)%*%t(X)%*%X%*%beta)/n)
   V = s2*solve(t(X)%*%X)
   v2 = V[3,3]  
   return(log10(mean(sqrt(v2/(v2+phiv))*exp(0.5*(phiv/(phiv+v2))*bhat^2/v2))))
}



phiv = c(0.1,0.2,0.4,0.8,1.6)

Y = matrix(ncol=1,y)
Xc = cbind(rep(1,n), d[,2])
snpv = apply(G,2,var)
Xg = G[,which(snpv!=0)]
freq = apply(Xg, 2, function(x) sum(x)/(2*n))
wv = dbeta(freq,1,25)
wv = wv/sum(wv)


rst1 = sapply(phiv, function(x) compute_log10_ABF(Y,Xg,Xc,wv,x, 1))
rst2 = sapply(phiv, function(x) compute_log10_ABF(Y,Xg,Xc,wv,x, 2))
log10_abf_skat = log10(mean(10^rst1))
log10_abf_burden = log10(mean(10^rst2))
rst3 = sapply(1:dim(Xg)[2], function(x) compute_log10_ABF2(Y,Xg[,x],Xc,phiv))
log10_abf_single = log10(mean(10^rst3))


skat_rst = c(num, pvo)
write(file=skat_file, skat_rst,ncol=2)

gname = paste("snp",num,"_gene",num,sep="")
bf_rst = c(gname, 1, log10_abf_skat,log10_abf_burden,log10_abf_single)
write(file=bf_file,bf_rst,ncol=5)

