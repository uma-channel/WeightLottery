# wl:_pick_select (internal / 内部関数)
# 当選した要素をまるごと storage wl:io result にコピーする
$data modify storage wl:io result set from storage wl:io pool[$(idx)]
