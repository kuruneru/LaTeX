import subprocess
import random
import re
import os

# 出力ファイル名
RESULT_FILE = "result_detailed.csv"

def generate_data_inc(n):
    # アセンブリ用のデータファイルを生成
    print(f"Generating data for N={n}...")
    with open("data.inc", "w") as f:
        # ランダムデータ生成
        data = [str(random.randint(0, 2147483647)) for _ in range(n)]
        
        f.write(f"ndata equ {n}\n")
        f.write("data:\n")  # ラベル
        
        # 1000個ずつ区切って dd 命令を書く
        chunk_size = 1000
        for i in range(0, len(data), chunk_size):
            chunk = data[i:i + chunk_size]
            f.write("  dd " + ", ".join(chunk) + "\n")

def compile_asm(filename):
    # 実行ファイル
    obj_file = filename.replace(".s", ".o")
    exe_file = filename.replace(".s", "")
    
    ret = subprocess.call(["nasm", "-f", "elf32", filename, "-o", obj_file])
    if ret != 0: return False
    
    ret = subprocess.call(["ld", "-m", "elf_i386", obj_file, "-o", exe_file])
    return ret == 0

def measure_time(exe_file):
    # timeコマンドから実行時間を取得
    try:
        cmd = f"time ./{exe_file}"
        result = subprocess.run(cmd, shell=True, stderr=subprocess.PIPE, stdout=subprocess.DEVNULL, executable="/bin/bash")
        output = result.stderr.decode("utf-8")
        
        match = re.search(r"user\s+(\d+)m(\d+\.\d+)s", output)
        if match:
            minutes = float(match.group(1))
            seconds = float(match.group(2))
            return minutes * 60 + seconds
        return 0.0
    except Exception as e:
        print(f"Error: {e}")
        return 0.0

def main():
    # CSVファイルの作成
    with open(RESULT_FILE, "w") as f:
        f.write("N,QuickSort_Time(s),BubbleSort_Time(s)\n")

    # 1. 細かい比較 (5,000刻みで 50,000 まで)
    small_range = range(5000, 50001, 5000)
    
    # 2. クイックソートのみの比較 (10万, 50万, 100万, 200万, 500万)
    large_range = [100000, 500000, 1000000, 2000000, 5000000]

    # 計測 
    
    # 1: 両方計測 (5,000 ~ 50,000)
    for n in small_range:
        generate_data_inc(n)
        
        # Quick
        if compile_asm("quick.s"): t_quick = measure_time("quick")
        else: t_quick = 0.0
            
        # Bubble
        if compile_asm("bubble.s"): t_bubble = measure_time("bubble")
        else: t_bubble = 0.0
            
        print(f"N={n:7}: Quick={t_quick:.3f}s, Bubble={t_bubble:.3f}s")
        
        with open(RESULT_FILE, "a") as f:
            f.write(f"{n},{t_quick},{t_bubble}\n")

    # 2: Quickのみ計測 (100,000 ~ )
    print("\n--- Skipping BubbleSort for large N (Too slow) ---")
    for n in large_range:
        generate_data_inc(n)
        
        # Quick
        if compile_asm("quick.s"): t_quick = measure_time("quick")
        else: t_quick = 0.0
        
        # Bubbleは計測しないので空欄にしておく
        t_bubble = "" 
        
        print(f"N={n:7}: Quick={t_quick:.3f}s, Bubble= (Skipped)")
        
        with open(RESULT_FILE, "a") as f:
            f.write(f"{n},{t_quick},\n")

    print(f"\nDone! Results saved to {RESULT_FILE}")

if __name__ == "__main__":
    main()