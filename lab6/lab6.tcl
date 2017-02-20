set ns [new Simulator]
set tf [open lab6.tr w]
$ns trace-all $tf
set nf [open lab6.nam w]
$ns namtrace-all $nf
#nodes
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
#cwnd
set cw1 [open cw61.tr w]
set cw2 [open cw62.tr w]
set cw3 [open cw63.tr w]
set cw4 [open cw64.tr w]
#links
$ns duplex-link $n2 $n0 10Mb 10ms DropTail
$ns duplex-link $n3 $n0 10Mb 10ms DropTail
$ns duplex-link $n4 $n0 10Mb 10ms DropTail
$ns duplex-link $n0 $n1 7Kb 20ms RED
#tcp
set tcp [new Agent/TCP]
set sink [new Agent/TCPSink]
$ns attach-agent $n2 $tcp
$ns attach-agent $n0 $sink
$ns connect $tcp $sink
set ftp [new Application/FTP]
$ftp attach-agent $tcp

$ns at 1.0 "$ftp start"

#tcp1
set tcp1 [new Agent/TCP]
set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $tcp1
$ns attach-agent $n0 $sink1
$ns connect $tcp1 $sink1
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1

$ns at 1.2 "$ftp1 start"
#tcp2
set tcp2 [new Agent/TCP]
set sink2 [new Agent/TCPSink]
$ns attach-agent $n4 $tcp2
$ns attach-agent $n0 $sink2
$ns connect $tcp2 $sink2
set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
#tcp2
set tcp3 [new Agent/TCP]
set sink3 [new Agent/TCPSink]
$ns attach-agent $n1 $tcp3
$ns attach-agent $n0 $sink3
$ns connect $tcp3 $sink3
set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ns at 1.6 "$ftp3 start"

proc plot {src agent} {
global ns
set now [$ns now]
set cwnd [$agent set cwnd_]
puts $src "$now $cwnd"
$ns at [expr $now + 0.1] "plot $src $agent"
}
proc finish {} {
global ns tf nf cw1 cw2 cw3 cw4
$ns flush-trace
close $tf
close $nf
close $cw1
close $cw2
close $cw3
close $cw4
exec nam lab6.nam &
exec xgraph cw61.tr &
exec xgraph cw62.tr &
exec xgraph cw63.tr &
exec xgraph cw64.tr &
exit 0
}
$ns at 1.0 "plot $cw1 $tcp"
$ns at 1.2 "plot $cw2 $tcp1"
$ns at 1.4 "plot $cw3 $tcp2"
$ns at 1.6 "plot $cw4 $tcp3"
$ns at 3.0 "finish"
$ns run
