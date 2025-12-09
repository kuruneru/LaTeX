# 出力設定 (PDF形式, 日本語フォント指定)
# フォントが見つからない場合は "Arial" などに変えてください
set terminal pdfcairo enhanced font "Arial,10" size 8in, 6in
set output 'graph_output.pdf'

# CSVの設定
set datafile separator ","
set key left top box

# 複数グラフのレイアウト設定 (上下2段)
set multiplot layout 2,1 title "Sorting Algorithm Performance Analysis" font ",14"

# --- 1つ目のグラフ: N=50,000までの直接比較 ---
set title "1. Comparison: Bubble Sort vs Quick Sort (N <= 50,000)"
set xlabel "Data Size (N)"
set ylabel "Time (sec)"
set grid
set xrange [0:52000]  # バブルソートがある範囲にズーム

# 線と点の設定
# using 1:3 = N vs Bubble, using 1:2 = N vs Quick
# every ::1 = 1行目(ヘッダ)をスキップ
plot "result_detailed.csv" using 1:3 every ::1 with linespoints pt 7 ps 0.5 lc rgb "red" lw 2 title "Bubble Sort (O(n^2))", \
     "result_detailed.csv" using 1:2 every ::1 with linespoints pt 5 ps 0.5 lc rgb "blue" lw 2 title "Quick Sort (O(n log n))"


# --- 2つ目のグラフ: N=5,000,000までのクイックソート ---
set title "2. Scalability: Quick Sort (Full Range up to N=5M)"
set xlabel "Data Size (N)"
set ylabel "Time (sec)"
set grid
set autoscale x       # 範囲を自動に戻す(500万まで表示)
set yrange [0:0.6]    # 縦軸を見やすく調整

# バブルソートはデータがないので描画されず、クイックソートだけ描画される
plot "result_detailed.csv" using 1:2 every ::1 with linespoints pt 5 ps 0.5 lc rgb "blue" lw 2 title "Quick Sort"

unset multiplot