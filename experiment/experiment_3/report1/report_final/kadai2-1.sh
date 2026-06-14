#!/bin/sh
# 帯域幅は3Mbpsで固定、バッファサイズ(b)を1から10まで変化させる
for b in 1 2 3 4 5 6 7 8 9 10; do
  ns kadai1-2-g1.tcl 3Mb ${b} > /dev/null 2>&1
  awk -v b=${b} '
    BEGIN { st = -1 }
    $3 == 2 && $4 == 3 {
      if (st == -1) st = $2; et = $2
      if ($1 == "+") sent++
      if ($1 == "d") drop++
      if ($1 == "r") recv += $6
    }
    END {
      printf "%d %.6f %.6f\n", b, (recv * 8) / (et - st) / 1000000, (sent > 0 ? (drop / sent) * 100 : 0)
    }
  ' out.tr
done
