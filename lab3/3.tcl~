set ns [new Simulator]

set cw [open graph.tr w]
set cw2 [open graph2.tr w]

set tf [open lab3.tr w]
$ns trace-all $tf

set nf [open lab3.nam w]
$ns namtrace-all $nf

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]
set n6 [$ns node]
set n7 [$ns node]
set n8 [$ns node]
set n9 [$ns node]

set lan [$ns newLan "$n0 $n1 $n2 $n3 $n4 $n5 $n6 $n7 $n8 $n9" 10Mb 2ms LL DropTail Channel]

$ns duplex-link $n5 $n6 1Mb 10ms DropTail

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1
set tcp8 [new Agent/TCPSink]
$ns attach-agent $n8 $tcp8
$ns connect $tcp1 $tcp8
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ns at 0.5 "$ftp1 start"

set tcp7 [new Agent/TCP]
$ns attach-agent $n7 $tcp7
set tcp3 [new Agent/TCPSink]
$ns attach-agent $n3 $tcp3
$ns connect $tcp7 $tcp3
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp7
$ns at 1.5 "$ftp2 start" 

$ns at 0.5 "plot $tcp1 $cw"
$ns at 0.5 "plot $tcp7 $cw2"

proc plot {tcpSource filename} {
	global ns
	set now [$ns now]
	set cwnd [$tcpSource set cwnd_]
	puts $filename "$now $cwnd"
	$ns at [expr $now + 0.01] "plot $tcpSource $filename"
}

proc finish {} {
	global ns nf tf cw cw2
	$ns flush-trace
	close $nf
	close $tf
	close $cw
	close $cw2
	exec nam lab3.nam &
	exit 0
}

$ns at 5.0 "finish"
$ns run
