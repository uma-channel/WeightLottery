# --- カウンタ初期化 ---
scoreboard players set #wl_total wl 0
scoreboard players set #wl_idx wl 0
data modify storage wl:io idx set value 0
data remove storage wl:io result

# --- 合計 weight を計算する（再帰） ---
function wl:_sum_step with storage wl:io

# --- 0 〜 (合計-1) の乱数を1回だけ振る ---
execute if score #wl_total wl matches 1.. run scoreboard players operation #wl_max wl = #wl_total wl
execute if score #wl_total wl matches 1.. run scoreboard players remove #wl_max wl 1
execute if score #wl_total wl matches 1.. store result storage wl:io max int 1 run scoreboard players get #wl_max wl
execute if score #wl_total wl matches 1.. run function wl:_do_random with storage wl:io

# --- 乱数に対応する要素を探す（再帰） ---
scoreboard players set #wl_idx wl 0
scoreboard players set #wl_cumulative wl 0
data modify storage wl:io idx set value 0
execute if score #wl_total wl matches 1.. run function wl:_pick_step with storage wl:io
