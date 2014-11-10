EBF_fdr<-function(bf_vec, alpha=0.05){
  bfv = sort(bf_vec)    
  cm = cumsum(bfv)/seq(1:length(bfv))
  pi0 = which.max(cm[cm<1])/length(cm)
  fv = pi0/(pi0+(1-pi0)*bf_vec)
  sfv = sort(fv) 
  fm = cumsum(sfv)/seq(1:length(sfv))
  cutoff = which.max(fm[fm<alpha])
  slist = which(fv<=sfv[cutoff])

  return(list(pi0 = pi0, l = length(slist), reject = slist)) 
}

BF_fdr<-function(bf_vec, pi0, alpha=0.05){

  fv = pi0/(pi0+(1-pi0)*bf_vec)
  sfv = sort(fv)
  fm = cumsum(sfv)/seq(1:length(sfv))
  cutoff = which.max(fm[fm<alpha])
  slist = which(fv<=sfv[cutoff])

  return(list(pi0 = pi0, l = length(slist), reject = slist))
}