# 出力形式とフォントの設定
set terminal pdfcairo enhanced font "Helvetica,12"
set output "convolution.pdf"

# 区間幅 d の定義（矩形の幅）
d = 2.0

# 矩形関数 x1(t) の自己畳み込み結果は三角関数（-d < t < d）
# f(t) = convolution of x1(t) with itself
f(x) = (x < -d) ? 0 : \
       (x < 0)  ? (x + d) : \
       (x < d)  ? (d - x) : 0

# 描画範囲
set xrange [-3*d:3*d]
set yrange [0:2*d]
set xlabel "t"
set ylabel "f(t)"
set title "Convolution: x₁(t) * x₁(t)"
set grid

# 関数のプロット
plot f(x) title "x₁(t) * x₁(t)" with lines lw 2 lc rgb "blue"
