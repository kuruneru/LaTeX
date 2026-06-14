# -----------------------------------------------------
# 楕円曲線における点の加法 (P + Q = R) のPDF出力スクリプト
# -----------------------------------------------------
set terminal pdfcairo size 5,4 font "Sans,12"
set output "ecc_addition.pdf"

set title "Elliptic Curve Addition: P + Q = R" font ",14"
set grid
set size square
set xrange [-2:3]
set yrange [-3.5:3.5]
set xzeroaxis lt -1 lw 1.5
set yzeroaxis lt -1 lw 1.5
set samples 10000

# 1. 楕円曲線の方程式 (y^2 = x^3 - x + 1)
f(x) = (x**3 - x + 1 >= 0) ? sqrt(x**3 - x + 1) : 1/0

# 2. 幾何学的な点の計算 (Gnuplot内で自動計算)
# 点P (x1, y1) を設定 (左下の点)
x1 = -0.5
y1 = -sqrt(x1**3 - x1 + 1)

# 点Q (x2, y2) を設定 (右上の点)
x2 = 1.0
y2 = sqrt(x2**3 - x2 + 1)

# PとQを通る直線の傾き m
m = (y2 - y1) / (x2 - x1)

# 第3の交点 -R (x3, y3) を計算
x3 = m**2 - x1 - x2
y3 = m * (x3 - x1) + y1

# 求める解 R = P+Q (x4, y4) はX軸に対して対称
x4 = x3
y4 = -y3

# 3. 反射する破線（矢印）の描画
# PからQを通って-Rへ向かう破線 (dt 2 = dashed type 2)
set arrow 1 from x1,y1 to x3,y3 head size 0.1,20 dt 2 lc rgb "magenta" lw 2 front
# -RからX軸に垂直に反射してRへ向かう破線
set arrow 2 from x3,y3 to x4,y4 head size 0.1,20 dt 2 lc rgb "magenta" lw 2 front

# 4. 点のマーカー（丸）の描画
set object 1 circle at x1,y1 size 0.05 fc rgb "black" fillstyle solid front
set object 2 circle at x2,y2 size 0.05 fc rgb "black" fillstyle solid front
set object 3 circle at x3,y3 size 0.05 fc rgb "black" fillstyle solid front
set object 4 circle at x4,y4 size 0.07 fc rgb "red" fillstyle solid front

# 5. ラベル（文字）の配置
set label 1 "P" at x1-0.2, y1-0.2 font ",14" front
set label 2 "Q" at x2-0.2, y2+0.3 font ",14" front
set label 3 "-R" at x3+0.1, y3+0.2 font ",14" front
set label 4 "R = P+Q" at x4+0.1, y4-0.2 font ",14" tc rgb "red" front

# 6. プロット実行
plot [-2:3] f(x) lc rgb "blue" lw 2 title "y^2 = x^3 - x + 1", \
           -f(x) lc rgb "blue" lw 2 notitle

unset output