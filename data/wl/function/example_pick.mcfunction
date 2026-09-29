# wl:example_pick
# 3種類の中から重複なしで2個抽選するデモ（マクロ不使用、poolだけで完結）
data modify storage wl:io pool set value [{"count":2},{"id":"りんご","weight":60,"item":"apple"},{"id":"ばなな","weight":30,"item":"yellow_dye"},{"id":"メロン","weight":10,"item":"melon_slice"}]

function wl:pick

tellraw @s [{"text":"抽選結果(重複なし2個): ","color":"gold"},{"storage":"wl:io","nbt":"results","interpret":false}]
