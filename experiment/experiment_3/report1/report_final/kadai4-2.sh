#!/bin/sh
TIME=0.011

awk -v t=$TIME '
  BEGIN { s = 0 }
  $1 == "+" && $3 == 2 && $4 == 3 && $5 == "tcp" && $2 <= t {
      s += $6 * 8
  }
  END {
      if (s > 0) {
          printf "%.6f\n", (s / t) / 1000000
      } else {
          print "課題2: 0.000000 Mbps"
      }
  }
' out.tr
