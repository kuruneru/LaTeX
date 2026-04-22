# --- 出力設定 ---
# PDFとして出力するための端末設定
set terminal pdfcairo size 5,3.5 font "sans,10"
set output 'throughput2-c.pdf'

# --- 基本設定 ---
set grid

# 必要に応じて軸の範囲を自動から手動に変更してください
# set xrange [0:30]
# set yrange [0:20]

# --- ラベル設定 ---
# ※データの正確な単位や意味が不明なため仮置きしています
set xlabel "X-axis (Unknown Unit)"
set ylabel "Throughput (Unknown Unit)"
set title "Throughput Result (throughput2-c.dat)"

# --- 凡例設定 ---
# 右下に配置（グラフの線と被る場合は top left 等に変更してください）
set key bottom right
set key nobox

# --- 描画 ---
# throughput2-c.datの1列目(X)と2列目(Y)を「線と点(linespoints)」でプロット
plot "throughput2-c.dat" using 1:2 with linespoints \
     lc rgb "blue" lw 1.5 pt 7 ps 0.5 \
     title "Throughput"
