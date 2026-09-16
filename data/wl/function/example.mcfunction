# wl:example
# 動作確認用のデモ。プレイヤー(@s)がこの関数を実行すると重み付き抽選の結果を教えてくれる。
# りんご60% ばなな30% メロン10% くらいの体感になるテーブル例。

data modify storage wl:io pool set value [{"id":"りんご","weight":60,"item":"apple"},{"id":"ばなな","weight":30,"item":"yellow_dye"},{"id":"メロン","weight":10,"item":"melon_slice"}]

function wl:roll

execute if data storage wl:io result run function wl:_example_give with storage wl:io result
execute unless data storage wl:io result run tellraw @s {"text":"抽選に失敗しました（poolが空か、weightが全て0です）","color":"red"}
