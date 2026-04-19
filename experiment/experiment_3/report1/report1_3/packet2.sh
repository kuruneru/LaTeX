#!/bin/sh

QUEUE=2

while [ $(echo "${QUEUE} <= 32" | bc) -eq 1 ]
do
  NUM=1
  while [ $(echo "${NUM} <= 10" | bc) -eq 1 ]
  do
    ns kadai1-2.tcl ${NUM}Mb ${QUEUE}

    sleep 2

    start=$(awk '$3 == 2 && $4 == 3 {print $2}' out.tr | head -n 1)
    end=$(awk '$3 == 2 && $4 == 3 {print $2}' out.tr | tail -n 1)
    time=$(echo "scale=6; ${end} - ${start}" | bc)

    re_packet=$(awk '$1 == "r" && $3 == 2 && $4 == 3' out.tr | wc -l)
    packet_size=$(awk '$1 == "r" && $3 == 2 && $4 == 3 {sum+=$6} END {print sum}' out.tr)

    packet_size=$(echo "scale=6; ${packet_size} * 8" | bc)
    throu_put=$(echo "scale=6; ${packet_size} / ${time} / 1000000" | bc)
    
    sent_packet=$(awk '$1 == "+" && $3 == 2 && $4 == 3' out.tr | wc -l)
    drop_packet=$(awk '$1 == "d" && $3 == 2 && $4 == 3' out.tr | wc -l)

    drop_rate=$(echo "scale=6; ${drop_packet} / ${sent_packet} * 100" | bc)

    echo "${NUM} ${QUEUE} ${throu_put} ${drop_rate}" >> kadai1-2-${QUEUE}.dat
    NUM=$(echo "${NUM} + 1" | bc)
  done
  QUEUE=$(echo "${QUEUE} * 4" | bc)
done
