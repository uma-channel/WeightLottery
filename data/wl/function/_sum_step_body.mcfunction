# wl:_sum_step_body (internal / 内部関数)
$execute store result score #wl_w wl run data get storage wl:io pool[$(idx)].weight
scoreboard players operation #wl_total wl += #wl_w wl
scoreboard players add #wl_idx wl 1
execute store result storage wl:io idx int 1 run scoreboard players get #wl_idx wl
function wl:_sum_step with storage wl:io
