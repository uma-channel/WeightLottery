# Weight Lottery

軽量・シンプルに使える、重み付き抽選（ガチャ）用のデータパックライブラリです。

---

## 使い方（基本）

1. `wl:io` の `pool` に抽選テーブルを書き込む
```
data modify storage wl:io pool set value [{id:a,weight:10},{id:b,weight:3},{id:c,weight:1}]
```
2. 抽選を実行する
```
function wl:roll
```
3. 結果を読む（`result` に当選した要素がまるごと入る）
```
data get storage wl:io result
data get storage wl:io result.id
```

- `weight` は0以上の整数。大きいほど当たりやすくなります（合計に対する割合が確率）。
- `id` 以外にも好きなキーを自由に追加できます（`item`, `command`, `count` など）。
- `weight: 0` の要素は絶対に当たりません（除外扱いに使えます）。
- pool が空、または全 `weight` が 0 のときは `result` は書き込まれません（未設定のまま）。失敗判定は
  ```
  execute unless data storage wl:io result run ...
  ```
  で行えます。

---

## 応用: 抽選結果でコマンドを直接実行する

pool の各要素に `"cmd"` のような文字列フィールドを入れておけば、抽選後にそのままコマンドとして実行できます。

```
data modify storage wl:io pool set value [{weight:10,cmd:"give @s diamond"},{weight:1,cmd:"give @s netherite_ingot"}]
function wl:roll
```

実行用の小さな関数を自作するだけです（例）:
```
function yourpack:run_cmd with storage wl:io result
```
```mcfunction
# data/yourpack/function/run_cmd.mcfunction
$$(cmd)
```

---

## 動作確認デモ

プレイヤーとして以下を実行すると、りんご60%・ばなな30%・メロン10%の抽選をして結果に応じてアイテムをくれます。
```
function wl:example
```

---

## 注意点
- `pool` はループの間破壊されません（抽選後もそのまま残ります）ので、同じテーブルで何度でも `function wl:roll` を呼べます。
- 要素数が極端に多い（数百〜）場合、再帰関数呼び出し回数がその分増えるため、あまり巨大すぎるテーブルは避けてください。

---


## 動作要件
Minecraft JE 1.20.2+


## ライセンス
LICENSEファイルを必ず確認してください
