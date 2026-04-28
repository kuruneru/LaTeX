# --- 出力設定 ---
set terminal pdfcairo size 5,3.5 font "sans,10"
set output 'throughput_18Mb.pdf'

# --- 基本設定 ---
set grid

# 以前のグラフと横軸を揃える場合は以下のコメントアウトを外してください
# set xrange [-0.5:20.5]

# --- ラベル設定 ---
set xlabel "Time [sec]"
# 単位が確定していないため、仮のラベルにしています。適宜修正してください。
set ylabel "Throughput" 
set title "Throughput vs Time"

# --- 凡例設定 ---
set key top right
set key nobox

# --- 描画 ---
# throughput.dat の1列目(time)と2列目(throughput)をプロット
plot "throughput_18Mb.dat" using 1:2 with lines \
     lc rgb "purple" lw 1.5 \
     title "Calculated Throughput"
