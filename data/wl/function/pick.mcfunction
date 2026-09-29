# wl:pick
#
# 重み付き抽選の唯一の入口。countの値に応じて内部で処理を分岐する。
#
# 使い方:
#   data modify storage wl:io pool set value [{"count":2},{"id":"a","weight":10},{"id":"b","weight":5},{"id":"c","weight":1}]
#   function wl:pick
#
#   count <= 0 : 何も抽選しない（wl:io result / wl:io results ともに空のまま）
#   count == 1 : 単発抽選。wl:io result に1個だけ書き込む
#                （軽量パス。複数抽選用のresults追加・カウント減算などの足回りを一切経由しない）
#   count >= 2 : 複数抽選（重複なし）。wl:io results に当選順の配列を書き込む
#
# pool[0] は必ずメタ情報（count）専用の枠。pool[1] 以降が実際の候補。
# pool 自体は変更されないので、同じテーブルで何度でも呼び出せる。マクロは一切使用していない。

data modify storage wl:io work set from storage wl:io pool

# work[0]（メタ情報）からcountを取り出してから、その要素自体は候補リストから除く
# ★先に0へリセットしてから読み込む（countが読めない場合に前回値が残るのを防ぐ）
scoreboard players set #wl_count wl 0
execute store result score #wl_count wl run data get storage wl:io work[0].count
data remove storage wl:io work[0]

data remove storage wl:io result
data modify storage wl:io results set value []

# count に応じて処理を分岐
execute if score #wl_count wl matches 1 run function wl:_pick_single
execute if score #wl_count wl matches 2.. run function wl:_pick_multi_loop
