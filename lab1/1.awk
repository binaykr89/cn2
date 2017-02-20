BEGIN {
	tcp_r_count = 0;
	tcp_d_count = 0;
	cbr_r_count = 0;
	cbr_d_count = 0;
}

{
	if($1 == "r" && $5 == "tcp")
		tcp_r_count++;
	if($1 == "d" && $5 == "tcp")
		tcp_d_count++;
	if($1 == "r" && $5 == "cbr")
		cbr_r_count++;
	if($1 == "d" && $5 == "cbr")
		cbr_d_count++;
}

END {
	printf("TCP packets received: %d\n", tcp_r_count);
	printf("TCP packets dropped: %d\n", tcp_d_count);
	printf("UDP packets recieved: %d\n", cbr_r_count);
	printf("UDP packets dropped: %d\n", cbr_d_count);
}	
		

