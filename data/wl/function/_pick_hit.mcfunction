# wl:_pick_hit (internal)
# 当選。work[0]をresultにコピーしてから、work自体からは完全に取り除く（重複なし抽選のため）
data modify storage wl:io result set from storage wl:io work[0]
data remove storage wl:io work[0]
