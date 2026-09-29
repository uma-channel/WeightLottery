# wl:_example_give (internal)
# ライブラリ本体では使っていない、デモ専用のマクロ。
# 「当選結果に応じて任意のコマンドを実行したい」場合の書き方の一例。
$tellraw @s {"text":"抽選結果: $(id) が当たりました！","color":"gold"}
$give @s $(item) 1
