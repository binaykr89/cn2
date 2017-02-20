BEGIN {
	count = 0;
	time = 0;
	total_bytes_sent = 0;
	total_bytes_recieved = 0;
}
{
	if($1 == "r" && $4 == 1 && $5=="tcp")
		total_bytes_recieved += $6;
	if($1 == "+" && $3 == 0 && $5=="tcp")
		total_bytes_sent += $6;
}
END {	
	system("clear");
	printf("\n Transmission time required to transer the file is %f",$2);
	printf("\n Actul data sent is %f Mbps",(total_bytes_sent)/(1000000));
	printf("\n Actul data recieved is %f Mbps",(total_bytes_recieved)/(1000000));
}
