# wl:_sum_loop (internal)
# sum_tmp が空になるまで先頭要素を消費して合計する（マクロ不使用・添字は常に固定の[0]）
execute if data storage wl:io sum_tmp[0] run function wl:_sum_step
