while(<>){
    
    next if /allele/;
    my @data = split /\s+/, $_;
    shift @data until $data[0]=~/^\S/;
    printf "$data[1] 1 $data[7]  $data[8]\n";
}
