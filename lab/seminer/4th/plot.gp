# PDF出力の設定
set terminal pdfcairo size 8in, 5in
set output 'jamming_merged.pdf'

# グラフの設定
set title "BPSK Signal Overlap with Increasing Jamming Power"
set xlabel "Received Signal y"
set ylabel "Probability Density"
set grid
set key outside

# パラメータ
A = 2.0
# ガウス分布関数: f(x, mean, sigma)
f(x, m, s) = (1.0 / (sqrt(2*pi)*s)) * exp(-(x - m)**2 / (2*s**2))

# 判定境界線
set arrow from 0,0 to 0,0.8 nohead lc rgb "black" lw 2 dt 2

# 複数のノイズレベルをプロット
# sigma = 0.5 (Low), 1.0 (Medium), 1.5 (High)
plot [-6:6] [0:0.8] \
     f(x, -A, 0.5) lc rgb "blue" title "Low Noise (-A)", \
     f(x,  A, 0.5) lc rgb "blue" title "Low Noise (+A)", \
     f(x, -A, 1.0) lc rgb "green" title "Med Noise (-A)", \
     f(x,  A, 1.0) lc rgb "green" title "Med Noise (+A)", \
     f(x, -A, 1.5) lc rgb "red" title "High Noise (-A)", \
     f(x,  A, 1.5) lc rgb "red" title "High Noise (+A)"