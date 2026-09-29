# wl:example
data modify storage wl:io pool set value [{"count":1},{"id":"りんご","weight":60,"item":"apple"},{"id":"ばなな","weight":30,"item":"yellow_dye"},{"id":"メロン","weight":10,"item":"melon_slice"}]

function wl:pick

execute if data storage wl:io result run function wl:_example_give with storage wl:io result
execute unless data storage wl:io result run tellraw @s {"text":"抽選に失敗しました","color":"red"}
