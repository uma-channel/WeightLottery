# wl:_pick_continue (internal / 内部関数)
scoreboard players add #wl_idx wl 1
execute store result storage wl:io idx int 1 run scoreboard players get #wl_idx wl
function wl:_pick_step with storage wl:io
