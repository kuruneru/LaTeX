# kadai2-2-B.gp
# フォントサイズを14に拡大し、キャンバスサイズを少し大きめに設定
set terminal pdfcairo size 16cm, 12cm font ",14"
set grid

set output "kadai2-2-B_plot.pdf"

set title "Simulation Results (kadai2-2-B)"
set xlabel "Parameter (e.g., Node Count)"
set ylabel "Value (e.g., Throughput)"

# データに合わせて軸の範囲と目盛りを固定
set xrange [0:30]
set yrange [0:20]
set xtics 5  # X軸の目盛りを5刻みにする

# --- パターン1: 見やすい線と点（こちらを有効化しています） ---
# pt 7 (丸), ps 2 (点のサイズを2倍), lw 3 (線の太さ3)
plot "kadai2-2-B.dat" using 1:2 with linespoints pt 7 ps 2 lw 3 lc rgb "blue" title "Measured Data"

# --- パターン2: 棒グラフの方が見やすい場合は、上のplotを消して以下を使ってください ---
# set boxwidth 2.5
# set style fill solid 0.5 border -1
# plot "kadai2-2-B.dat" using 1:2 with boxes lc rgb "blue" title "Measured Data"
