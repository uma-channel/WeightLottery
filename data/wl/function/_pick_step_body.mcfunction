# wl:_pick_step_body (internal / 内部関数)
$execute store result score #wl_w wl run data get storage wl:io pool[$(idx)].weight
scoreboard players operation #wl_cumulative wl += #wl_w wl
execute if score #wl_rand wl < #wl_cumulative wl run function wl:_pick_select with storage wl:io
execute unless score #wl_rand wl < #wl_cumulative wl run function wl:_pick_continue with storage wl:io
