# wl:_pick_miss (internal)
# 落選。work[0]を末尾に回してから先頭を消す（実質「先頭→末尾への移動」、中身は残る）
data modify storage wl:io work append from storage wl:io work[0]
data remove storage wl:io work[0]
function wl:_pick_loop
