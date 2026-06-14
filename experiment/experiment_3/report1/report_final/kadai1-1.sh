#!/bin/sh
for bw in 1 2 3 4 5 6 7 8 9 10; do
  ns kadai1-g1.tcl ${bw}Mb > /dev/null 2>&1
  awk -v bw=${bw} '
    BEGIN { st = -1 }
    $3 == 2 && $4 == 3 {
      if (st == -1) st = $2; et = $2
      if ($1 == "+") sent++
      if ($1 == "d") drop++
      if ($1 == "r") recv_pkts++
    }
    END {
      printf "%d %.6f %.6f\n", bw, (recv_pkts * 1000 * 8) / (et - st) / 1000000, (sent > 0 ? (drop / sent) * 100 : 0)
    }
  ' out.tr
done
