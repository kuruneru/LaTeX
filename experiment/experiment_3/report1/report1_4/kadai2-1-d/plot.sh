#!/bin/bash

# 5, 10, 15, 20, 25 Mbps についてループ処理
for bw in 1 2 3 4 5; do
    echo "throughput_${bw}Mb.dat をプロットしています..."

    # gnuplotコマンドにスクリプトを直接流し込む（ヒアドキュメント）
    gnuplot << EOF
# --- 出力設定 ---
set terminal pdfcairo size 5,3.5 font "sans,10"
set output 'throughput_${bw}Mb.pdf'

# --- 基本設定 ---
set grid

# ※比較のために軸を固定したい場合は、以下のコメント(#)を外して数値を調整してください
# set xrange [-0.5:20.5]
# set yrange [0:30]

# --- ラベル設定 ---
set xlabel "Time [sec]"
set ylabel "Throughput [Mbps]"
set title "Throughput vs Time (${bw} Mbps Simulation)"

# --- 凡例設定 ---
set key top right
set key nobox

# --- 描画 ---
plot "throughput_${bw}Mb.dat" using 1:2 with lines \
     lc rgb "blue" lw 1.5 \
     title "Throughput"
EOF

done

echo "すべてのPDF作成が完了しました。"
