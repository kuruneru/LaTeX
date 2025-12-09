#include <stdio.h>
#include "data.h" 

// 値を交換するマクロ
#define swap(type, x, y) //省略

// クイックソート関数
void quick_sort(int a[], int left, int right) {
    int pl = left;
    int pr = right;
    int x = a[(pl + pr) / 2];

    do {
        while (a[pl] < x) pl++;
        while (a[pr] > x) pr--;
        if (pl <= pr) {
            swap(int, a[pl], a[pr]);
            pl++;
            pr--;
        }
    } while (pl <= pr);

    if (left < pr) quick_sort(a, left, pr);
    if (pl < right) quick_sort(a, pl, right);
}

int main(void) {
    
    // クイックソート呼び出し
    quick_sort(data, 0, ndata - 1);

    return 0;
}