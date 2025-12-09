  section .text
  global _start
_start:
  mov eax, data                   ;配列の先頭のアドレス
  mov ebx, data + (ndata - 1) * 4     ;配列の最後のアドレス

  call quick_sort

  mov eax, 1
  mov ebx, 0
  int 0x80

quick_sort: ;quick_sort関数のようなもの

  ;ベースケースを作る(配列の数が1のとき)
  cmp eax, ebx
  jge .done

  ;分割と基準値決め
  mov edi, eax ;基準値のアドレス
  mov esi, edi ;左端
  add esi, 4 ;左端
  mov edx, ebx ;右端

  .loop1: ;左から基準値より大きい数の探索

    mov ecx, [edi]

    ;端まで行くとループ終了
    cmp esi, ebx
    jge .end_loop1

    cmp ecx, [esi] ;基準値の中身と左端の中身の比較
    jl .end_loop1     

    add esi, 4
    jmp .loop1

  .end_loop1:

  .loop2: ;右から基準値より小さい数の探索

    cmp edx, eax
    jle .end_loop2

    mov ecx, [edi]

    cmp ecx, [edx]
    jg .end_loop2

    sub edx, 4
    jmp .loop2

  .end_loop2:

  ;端同士が通り過ぎたら分割終了
  cmp esi, edx
  jge .partition_end

  ;交換処理
  push dword [esi]
  push dword [edx]

  pop dword [esi]
  pop dword [edx]

  ;再度探索を続ける
  add esi, 4
  sub edx, 4
  jmp .loop1

.partition_end:
  ;基準値を境にする
  push dword [edi] 
  push dword [edx]

  pop dword [edi]
  pop dword [edx]

  ;再帰のための配列の端と基準値の保存
  push eax
  push ebx
  push edx

  ;左への再帰
  mov ebx, edx
  sub ebx, 4

  call quick_sort

  ;再帰から戻ってきたあとの保存の復活
  pop edx
  pop ebx
  pop eax

  ;右への再帰
  mov eax, edx
  add eax, 4

  call quick_sort

  .done: ;呼び出し元に戻る
    ret

section .data
  %include "data.inc"