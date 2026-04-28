#!bin/sh

for BW in 1 2 3 4 5 9 18
do
  ns kadai2-2.tcl ${BW}Mb 5ms

  sleep 2

  awk '{print $2, $18, $20}' out.tcp > kadai2-2-tcp.dat

  # plot: cwnd vs time (add Max window size) and ssthresh vs time
  gnuplot -e "infile='kadai2-2-tcp.dat'; bw='${BW}'" kadai2-2.gp

  # time and throughput
  awk '{
    time=$2; cwnd=$18; rtt=$24;
    
    if(rtt <= 0) rtt=0.005; 
    
    win = (cwnd <= 64) ? 64 : cwnd;
    meas = win / rtt;
    
    theo = 64 / 0.005;
    
    print time, meas, theo
  }' out.tcp > kadai2-2-thr.dat

done
