args = commandArgs(trailingOnly = TRUE)
file = args[1]


compute_abf<-function(z2, v2, phi){
  phi2 = phi^2
  return(sqrt(v2/(v2+phi2))*exp(0.5*phi2*z2/(phi2+v2)) )
}

grid = c(0.1,0.2,0.4,0.8,1.6)

d = read.table(file,head=T)
attach(d)

z2 = (beta/se)^2
v2 = se^2

log10_bfv = log10(sapply(1:length(z2),function(x) mean(sapply(grid, function(y) compute_abf(z2[x],v2[x],y)))))
write(file="bf.rst", t(cbind(as.character(rs),log10_bfv)), ncol=2)
