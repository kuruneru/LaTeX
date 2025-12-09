import random

# データ数を1,000,000
N = 1000000 

# 乱数の最大値
MAX_VAL = 2147483647 

data = [random.randint(0, MAX_VAL) for _ in range(N)]

# 1. C言語用のヘッダファイル (data.h)
with open("data.h", "w") as f:
    f.write(f"int ndata = {N};\n")
    f.write("int data[] = {\n")
    f.write(", ".join(map(str, data)))
    f.write("\n};\n")

# 2. アセンブリ言語用のインクルードファイル (data.inc)
with open("data.inc", "w") as f:
    f.write("data: dd " + ", ".join(map(str, data)) + "\n")
    f.write(f"ndata equ {N}\n")

print(f"Generate {N} numbers to data.h and data.inc")