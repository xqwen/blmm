open FILE, "pheno.id";
@list = <FILE>;
chomp @list;


#open FILE, "id_array.map";
#while(<FILE>){
#    next if $_ !~ /^\s*(\d+)\s+(\d+)/;
#    $array{$1} = $2;
#}

#print "@array{@list}\n";

open FILE, "gzip -dc geno.csv.gz |";
while(<FILE>){
    next if $_ !~ /\d/;
    next if /^\s*\-/;
    my @data = split /\,/, $_;
    if (/Chromosome/){
	@hash{@data}=(0..$#data);
	@index = @hash{@list};
	#print "@index\n";
	next;
    }
    

    #print "chr$data[0]:$data[1] @data[@index]\n";
    print "chr$data[0]:$data[1], A, T";
    foreach $i (@index){
	$g = $data[$i];
	if($g eq $data[2]){
	    print ", 1";
	}else{
	    print ", 0";
	}
    }
    print "\n";
}
