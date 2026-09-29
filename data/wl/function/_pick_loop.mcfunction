# wl:_pick_loop (internal)
# work[0] が存在する間だけ判定を続ける（マクロ不使用）
execute if data storage wl:io work[0] run function wl:_pick_step
