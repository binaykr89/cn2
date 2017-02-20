BEGIN {
	count = 0;
}

{
	if($1 == "r" && $5 == "tcp" && $4 == "3")
		count += $6
}

END {
	printf("Throughput is: %d\n", (count * 8) / 1000000);
}	
