#!/bin/sh
awk '
  BEGIN { count = 0; seq_list = "" }
  $1 == "d" && $5 == "tcp" {
      count++
      seq_list = seq_list $11 " "
  }
  END {
      if (count > 0) {
          print "ドロップ総数: " count
          print "シーケンス番号: " seq_list
      } else {
          print "ドロップしたパケットはありません。"
      }
  }
' out.tr
