section .text
global _start

_start:
    
    mov ecx, ndata
    dec ecx
    jle .done           ; データが1個以下なら終了

.outer_loop:
    xor edx, edx        

    ; ここでは ecx が「現在のソート範囲の末尾」を表す
.inner_loop:
    cmp edx, ecx
    jge .next_outer

    ; 比較: data[j] と data[j+1]
    mov eax, data
    mov esi, [eax + edx*4]      ; data[j]
    mov edi, [eax + edx*4 + 4]  ; data[j+1]

    cmp esi, edi
    jle .no_swap                ; data[j] <= data[j+1] ならスワップしない

    ; スワップ実行
    mov [eax + edx*4], edi
    mov [eax + edx*4 + 4], esi

.no_swap:
    inc edx
    jmp .inner_loop

.next_outer:
    dec ecx
    jnz .outer_loop

.done:
    ; 終了処理
    mov eax, 1
    xor ebx, ebx
    int 0x80

section .data
    %include "data.inc"