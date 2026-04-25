##### kadai2.tcl #####
#
# This script is used for problem 2.
#  ※ Since TCP trace isnot used in problem 2, comment out these scripts
#  ※  Since it is no need data for Nam, comment out these scripts
# 　　using comment out, the simulation time is decreased
#
# Topology,in () is name of Agent
#
#   (tcp)                          (sink)
#     n0                             n4
#       \                           /
#    5ms \                         / 5ms
#  25Mbps \                       / 25Mbps
#          \          bw         /
#          n2-------------------n3
#          /         d          \    
#  25Mbps /                       \ 25Mbps
#    5ms /                         \ 5ms
#       /                           \
#     n1                             n5
#   (tcp)                          (sink) 
#
# (Notice) It is possible to set bandwidth of link, CBR rate to Kb,Mb,Gb.
#       Kb-->Kbps, 1Kb=1000bps
#       Mb-->Mbps, 1Mb=1000Kb
#       Gb-->Gbps, 1Gb=1000Mb
#
# (Notice) In this simulation 1[kbytes]=1000[bytes]
#

##### Input parameter
# input bw and d for simulation. if bw=10Mbps and d=20ms, use command {ns kadai2-1.tcl 10Mb 20ms}
set bw "[lindex $argv 0]"
set d "[lindex $argv 1]"

##### Declare Simulator 
set ns [new Simulator]

##### Setting output file
set file [open out.tr w]
$ns trace-all $file
set namfile [open out.nam w]
$ns namtrace-all $namfile
set tcpfile [open out.tcp w]
Agent/TCP set trace_all_oneline_ true

##### Setting Queue(donot modify for all case)
Queue/DropTail set queue_in_bytes_ true
Queue/DropTail set mean_pktsize_ 1000

##### Setting Node
set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]
set n5 [$ns node]

##### Setting Link
$ns duplex-link $n0 $n2 25Mb  5ms DropTail
$ns duplex-link $n1 $n2 25Mb  5ms DropTail
$ns duplex-link $n2 $n3  $bw $d DropTail  ;#bottleneck link
$ns duplex-link $n3 $n4 25Mb  5ms DropTail
$ns duplex-link $n3 $n5 25Mb  5ms DropTail
$ns duplex-link-op $n0 $n2 orient right-down
$ns duplex-link-op $n1 $n2 orient right-up
$ns duplex-link-op $n2 $n3 orient right
$ns duplex-link-op $n3 $n4 orient right-up
$ns duplex-link-op $n3 $n5 orient right-down
$ns duplex-link-op $n2 $n3 queuePos 0.5

##### Setting queue size
$ns queue-limit $n2 $n3 32  ;#bottleneck queue size[kbytes]

##### Setting UDP Agent 
#set udp [new Agent/UDP]
#$ns attach-agent $n0 $udp
#set null [new Agent/Null]
#$ns attach-agent $n4 $null
#$ns connect $udp $null
#$udp set fid_ 0
#$ns color 0 blue

##### setting CBR Application 
#set cbr [new Application/Traffic/CBR]
#$cbr attach-agent $udp
### setting CBR parameter
#$cbr set rate_ 8Mb         ;# CBR transmission rate
#$cbr set packetSize_ 1000  ;# CBR data size [bytes]

##### setting TCP Agent
### setting TCP Agent parameter
Agent/TCP set packetSize_ 1000 ;#TCP packet size(not include 40[bytes] header)[bytes]
Agent/TCP set window_ 64       ;#TCP maximum window size[packets]
### setting TCP Agent
### Flow1
#set tcp [new Agent/TCP]
set tcp [new Agent/TCP/Reno]
#set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n0 $tcp
set sink [new Agent/TCPSink]
$ns attach-agent $n4 $sink
$ns connect $tcp $sink
$tcp set fid_ 0
$ns color 0 blue
### setting output of TCP Agent
$tcp attach-trace $tcpfile
$tcp trace cwnd_

### Flow2
#set tcp2 [new Agent/TCP/Reno]
#$ns attach-agent $n1 $tcp2
#set sink2 [new Agent/TCPSink]
#$ns attach-agent $n5 $sink2
#$ns connect $tcp2 $sink2
#$tcp2 set fid_ 1
#$ns color 1 red
### setting output of TCP Agent
#$tcp2 attach-trace $tcpfile2
#$tcp2 trace cwnd_

##### setting FTP Application 
set ftp [new Application/FTP]
$ftp attach-agent $tcp

##### Setting time schedule of simulation
### comment out cbr,ftp as you want
#$ns at  0.0 "$cbr start"
#$ns at 20.0 "$cbr stop"
$ns at  0.0 "$ftp start"
$ns at 20.0 "$ftp stop"
$ns at 20.0 "finish"
proc finish {} {
    global ns file namfile tcpfile
    $ns flush-trace
    close $file
    close $namfile
    close $tcpfile
    exit 0
}

#####  Finish setting and start simulation
$ns run
