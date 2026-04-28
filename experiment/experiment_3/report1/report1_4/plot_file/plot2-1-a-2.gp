# --- 出力設定 ---
# PDFファイルとして出力するための端末設定
set terminal pdfcairo
set output 'kadai2-1-a-2.pdf'

# --- 基本設定 ---
set grid
set xrange [-0.5:20.5]
set yrange [-10:300.0]

# --- ラベル設定 ---
set xlabel "Time [sec]"
set ylabel "Window Size [packet]"

# --- 凡例設定 ---
set key top right
set key nobox

# --- 描画 ---
# 2列目(時間)と18列目(cwnd)、および2列目(時間)と20列目(ssthresh)を描画
plot "out.tcp" using 2:18 with lines \
     lc rgb "blue" lw 1 \
     title "cwnd", \
     "out.tcp" using 2:20 with lines \
     lc rgb "green" lw 1 \
     title "ssthresh"

# PDF出力の場合はpauseコマンドは不要ですが、画面確認用（terminal qt/x11等）に残す場合は以下を使用
# pause -1 "Press Enter to quit\n"
