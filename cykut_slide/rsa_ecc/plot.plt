# -----------------------------------------------------
# 楕円曲線 y^2 = x^3 - x + 1 のPDF出力用スクリプト (隙間修正版)
# -----------------------------------------------------
set terminal pdfcairo size 5,4 font "Sans,12"
set output "elliptic_curve.pdf"

set title "Elliptic Curve: y^2 = x^3 - x + 1" font ",14"
set grid
set size square
set xrange [-2:3]
set yrange [-4:4]
set xzeroaxis lt -1 lw 1.5
set yzeroaxis lt -1 lw 1.5

# ★ここを追加！描画する点の数を増やして曲線を滑らかに（隙間を埋める）
set samples 10000

# f(x) の定義（ルートの中がマイナスの場合は描画をスキップ）
f(x) = (x**3 - x + 1 >= 0) ? sqrt(x**3 - x + 1) : 1/0

plot [-2:3] f(x) lc rgb "blue" lw 2 title "y^2 = x^3 - x + 1", \
           -f(x) lc rgb "blue" lw 2 notitle

unset output