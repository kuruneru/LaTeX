# --- 基本設定 ---
set terminal pdfcairo
set grid
set xrange [-0.5:20.5]
set yrange [-10:300.0]
set output 'kadai2-1-a-1.pdf'

# --- ラベル設定 ---
set xlabel "Time [sec]"
set ylabel "cwnd [packet]"

# --- 凡例設定 ---
set key top left
set key nobox

# --- 描画 ---
plot "out.tcp" using 2:18 with lines \
     lc rgb "blue" lw 1 \
     title "Bw = 18Mbps", \
     64 with lines lc rgb "red" lw 2 dt 2 \
     title "max window size (64 packets)"
pause -1 "Press Enter to quit\n"
