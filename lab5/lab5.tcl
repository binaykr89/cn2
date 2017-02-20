set ns [new Simulator]
set tf [open lab5.tr w]
$ns trace-all $tf
set nf [open lab5.nam w]
$ns namtrace-all $nf

set server [$ns node]
set client [$ns node]

$server color Blue
$client color Red
$server label "Server"
$client label "Client"

$ns duplex-link $server $client 10Mb 10ms DropTail
$ns duplex-link-op $server $client orient right
#$ns duplex-link-op $server $client color Silver

set tcp [new Agent/TCP]
$ns attach-agent $server $tcp 
$tcp set packetsize_ 1500

set sink [new Agent/TCPSink]
$ns attach-agent $client $sink 
$tcp set packetsize_ 1500

set ftp [new Application/FTP]
$ns attach-agent $client $sink
$ns connect $tcp $sink
$ftp attach-agent $tcp
$tcp set fid_ 1

#finish proc
proc finish {} {
	global ns tf nf
	$ns flush-trace
	close $tf
	close $nf
	exec nam lab5.nam &
	exec awk -f lab5transfer.awk lab5.tr &
	exec awk -f lab5convert.awk lab5.tr > convert.tr &
	exec xgraph convert.tr -geometry 800 x 400 -t "bytes_recieved at client" -x "time_in_secs" -y "bytes_in_bps" &
	exit 0
}

$ns at 0.1 "$ftp start"
$ns at 15.0 "$ftp stop"
$ns at 15.1 "finish"
$ns run 
 
