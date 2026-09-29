# wl:_pick_single (internal)
# count==1 のときの軽量パス。複数抽選用の足回り（results追加・カウント減算・再帰判定）を経由しない。
# 結果はそのまま wl:io result に書き込まれる（_pick_hit が行う）。

data modify storage wl:io sum_tmp set from storage wl:io work
scoreboard players set #wl_total wl 0
function wl:_sum_loop

execute if score #wl_total wl matches 1.. store result score #wl_rand wl run random value 0..1000000000
execute if score #wl_total wl matches 1.. run scoreboard players operation #wl_rand wl %= #wl_total wl

scoreboard players set #wl_cumulative wl 0
execute if score #wl_total wl matches 1.. run function wl:_pick_loop
