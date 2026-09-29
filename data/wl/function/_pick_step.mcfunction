# wl:_pick_step (internal)
# ★バグ修正: weightキーが無い要素でも安全に0扱いにするため、読み込み前に0へリセットする
scoreboard players set #wl_w wl 0
execute store result score #wl_w wl run data get storage wl:io work[0].weight
scoreboard players operation #wl_cumulative wl += #wl_w wl
execute if score #wl_rand wl < #wl_cumulative wl run function wl:_pick_hit
execute unless score #wl_rand wl < #wl_cumulative wl run function wl:_pick_miss
