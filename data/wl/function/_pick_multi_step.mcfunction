# wl:_pick_multi_step (internal)

# 残っている work の合計weightを毎回計算し直す（既に当選した分は work から消えているため）
data modify storage wl:io sum_tmp set from storage wl:io work
scoreboard players set #wl_total wl 0
function wl:_sum_loop

execute if score #wl_total wl matches 1.. store result score #wl_rand wl run random value 0..1000000000
execute if score #wl_total wl matches 1.. run scoreboard players operation #wl_rand wl %= #wl_total wl

scoreboard players set #wl_cumulative wl 0
execute if score #wl_total wl matches 1.. run function wl:_pick_loop

execute if data storage wl:io result run data modify storage wl:io results append from storage wl:io result
data remove storage wl:io result

scoreboard players remove #wl_count wl 1
function wl:_pick_multi_loop
