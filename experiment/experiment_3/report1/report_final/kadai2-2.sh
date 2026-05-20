#!/bin/sh
ns kadai1-2-g1.tcl 3Mb 10 > /dev/null 2>&1

awk '
  BEGIN { m = 0 }
  $1 == "+" && $3 == 2 && $4 == 3 { eq[$12] = $2 }
  $1 == "-" && $3 == 2 && $4 == 3 {
      if ($12 in eq) {
          d = $2 - eq[$12]
          if (d > m) m = d
      }
  }
  END {
      printf "%.6f\n", m + 0
  }
' out.tr
