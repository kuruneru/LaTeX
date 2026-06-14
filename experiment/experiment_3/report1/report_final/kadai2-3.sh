#!/bin/sh

for b in 2 4 8 16 32 64 128 256 512 1024; do
  ns kadai1-2-g1.tcl 1.0Mb ${b} > /dev/null 2>&1
  
  awk -v b=${b} '
    $3 == 2 && $4 == 3 {
      if ($1 == "+") sent++
      if ($1 == "d") drop++
    }
    END {
      printf "%d\t\t\t%.6f\n", b, (sent > 0 ? (drop / sent) * 100 : 0)
    }
  ' out.tr
done
