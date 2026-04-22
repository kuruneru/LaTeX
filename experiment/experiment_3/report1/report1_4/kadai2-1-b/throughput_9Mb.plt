# --- 出力設定 ---
set terminal pdfcairo size 5,3.5 font "sans,10"
set output 'throughput_9Mb.pdf'

# --- 基本設定 ---
set grid

# 必要に応じてX軸・Y軸の範囲を指定してください
# set xrange [0:20]
# set yrange [0:10]

# --- ラベル設定 ---
set xlabel "Time [sec]"
# ※2列目の値の正確な単位が不明なため、仮置きしています
set ylabel "Throughput (Unit Unknown)" 
set title "Throughput vs Time (9 Mbps Simulation)"

# --- 凡例設定 ---
set key top right
set key nobox

# --- 描画 ---
# throughput_9Mb.datの1列目(時間)と2列目(スループット)を線(lines)でプロット
plot "throughput_9Mb.dat" using 1:2 with lines \
     lc rgb "blue" lw 1.5 \
     title "Throughput"
