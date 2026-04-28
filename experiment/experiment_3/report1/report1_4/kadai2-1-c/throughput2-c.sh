#!/bin/bash

# 5, 10, 15, 20, 25 Mbps について順番にループ処理
for bw in 5 10 15 20 25; do
    echo "${bw} Mbps のシミュレーションを実行中..."

    # シミュレーション実行
    ns kadai2-1.tcl ${bw}Mb 5ms > /dev/null 2>&1

    # awkで時間ごとのスループットをMbps単位で計算
    awk '{
        time = $2
        hiack = $14
        cwnd = $18
        rtt = $24

        # cwndの上限を64に制限
        if (cwnd > 64) {
            cwnd = 64
        }

        # rttが0より大きく、hiackが前行から更新された行のみ出力
        if (rtt > 0 && hiack != prev_hiack) {
            # パケットサイズを1000バイトとした場合のMbpsへの変換
            throughput_Mbps = (cwnd * 1000 * 8) / (rtt * 1000000)
            
            # 時間と変換後のスループットを出力
            print time, throughput_Mbps
        }
        prev_hiack = hiack
    }' out.tcp > throughput_${bw}Mb.dat

    echo "-> throughput_${bw}Mb.dat を作成しました"
done

echo "すべての処理が完了しました。"
