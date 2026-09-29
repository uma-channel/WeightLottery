# wl:_sum_step (internal)
# ★バグ修正: weightキーが無い要素でも安全に0扱いにするため、読み込み前に0へリセットする
scoreboard players set #wl_w wl 0
execute store result score #wl_w wl run data get storage wl:io sum_tmp[0].weight
scoreboard players operation #wl_total wl += #wl_w wl
data remove storage wl:io sum_tmp[0]
function wl:_sum_loop
