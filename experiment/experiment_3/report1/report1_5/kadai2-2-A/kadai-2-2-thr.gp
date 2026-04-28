# kadai2-2.gp
# 時間(Time)とスループット(Throughput)の比較グラフを生成するスクリプト

set terminal pdfcairo size 21cm, 10cm
set grid

# 出力ファイル名の設定（シェルスクリプトから渡される bw 変数を使用）
set output "result_BW".bw."_throughput.pdf"

# グラフのタイトルと各軸のラベル設定
set title "Throughput Analysis (BW: ".bw."Mb)"
set xlabel "Time [s]"
set ylabel "Throughput [packets/s]"

# y軸の下限を0に固定して見やすくする
set yrange [0:*]

# データをプロット
# infile の 1列目(x)と2列目(y)で実測値を描画
# infile の 1列目(x)と3列目(y)で理論値を赤い破線で描画
plot infile using 1:2 with lines title "Measured Throughput", \
     infile using 1:3 with lines lt 2 lc rgb "red" title "Theoretical Max"
