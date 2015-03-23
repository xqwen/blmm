
open FILE, "pheno.qnorm.bimbam";
@pheno = <FILE>;
chomp @pheno;


open FILE, "pheno.id";
@list = <FILE>;
chomp @list;


open FILE, "gzip -dc geno.csv.gz |";
my @grcd;
while(<FILE>){
    next if $_ !~ /\d/;
    next if /^\s*\-/;
    my @data = split /\,/, $_;
    if (/Chromosome/){
	@hash{@data}=(0..$#data);
	@index = @hash{@list};
	next;
    }
    
    
    next if($data[0]!=4);
    next if(abs($data[1]- 6392280) > 100000);
    chomp;
    push @snp_list, "chr$data[0]\:$data[1]";
    my @rcd;
    foreach $i (@index){
	$g = $data[$i];
	if($g eq $data[2]){
	    push @rcd, 1;
	}else{
	    push @rcd, 0;
	}
    }
    push @grcd, \@rcd;
}


print "sodium";
foreach $snp (@snp_list){
    print " $snp";
}
print "\n";

foreach $i (0..$#pheno){
    print "$pheno[$i]";
    foreach $j (0..$#grcd){
	print " $grcd[$j][$i]";
    }
    print "\n";
}

