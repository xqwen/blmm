use List::Util 'shuffle';

$count = 0;
@list = shuffle((1..5000));
$count = 0;
$str = "Rscript sim_data.R ";
foreach $g (@list){
    $count++;
    if($count<=250){
	print "$str $g 1 $count\n";
	push @burden, $g;
	next;
	
    }
    if($count<=625){
	print "$str $g 2 $count\n";
	push @skat, $g;
	next;
    }

    if($count<=2500){
	print "$str $g 3 $count\n";
	push @cv, $g;
	next;
    }
    
    print "$str $g 0 $count\n";
    push @null, $g;
}
 


