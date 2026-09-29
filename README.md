# Weight Lottery - 重み付きランダム抽選ライブラリ

| count | 動作 | 書き込み先 |
|---|---|---|
| `0` 以下 | 何も抽選しない | なし（`result`/`results`とも空） |
| `1` | 単発抽選（軽量パス。複数抽選用の足回りを一切経由しない） | `wl:io result`（単体compound） |
| `2` 以上 | 複数抽選（重複なし） | `wl:io results`（当選順の配列） |

## pool の形式
`pool[0]` は必ずメタ情報（`count`）専用の枠。`pool[1]`以降が実際の候補です。
```
pool = [
  {"count": 2},                       # ← 0番目は必ずメタ情報
  {"id":"a","weight":10, ...},        # ← 1番目以降が実際の候補
  {"id":"b","weight":3, ...},
  {"id":"c","weight":1, ...}
]
```

## 使い方

### 抽選枠の設定&抽選
```mcfunction
data modify storage wl:io pool set value [{"count":1},{"id":"a","weight":10},{"id":"b","weight":3},{"id":"c","weight":1}]
function wl:pick
```

### 抽選結果取得
```mcfunction
# 1個だけ抽選したとき（`count == 1`）
data get storage wl:io result
# 複数同時に抽選したとき（`count >= 2`）
data get storage wl:io results
```

- `results` には当選順に要素がそのまま並んだリストが入る（`[0]`が1番目に当たったもの）。
- 同じ要素が2回選ばれることはありません。要求数が候補数より多い場合、選べるだけ選んだ時点で `results` は要求数より少ない状態で止まります。
- `pool[0].count` が読み取れない（キーが無い・形式が違う等）場合は `count` は0扱いになり、`result`/`results`とも空のまま何も起きません。
- `pool` 自体は書き換わりません。何度でも同じテーブルで `wl:pick` を呼べます。

### 重複ありにしたい場合（応用）
`wl:pick`（count>=2のとき）は当選のたびに `work` からその要素を完全に取り除くことで「重複なし」を実現しています。
「同じ景品が何回でも当たってよい（10連ガチャのようなイメージ）」にしたい場合は、`_pick_multi_step.mcfunction` の先頭で
毎回 `data modify storage wl:io work set from storage wl:io pool` を実行してから抽選するように変更してください

### コマンドを直接実行したい場合（応用）
`pool` の各要素に `"cmd"` のような文字列フィールドを入れておき、結果を使う側の関数でだけマクロを使う、という形にすれば
このライブラリはマクロレスのまま、呼び出し側だけで柔軟な処理ができます。
```mcfunction
function yourpack:run_cmd with storage wl:io result
```
```mcfunction
# data/yourpack/function/run_cmd.mcfunction
$$(cmd)
```

## 動作確認デモ
```mcfunction
function wl:example        # 1個抽選（りんご60% ばなな30% メロン10%）
function wl:example_pick   # 2個を重複なしで抽選
```

## 動作バージョン
**Minecraft JE 1.20.2 以降**

## 注意点
- `pool` の要素数が極端に多い（数百〜）場合、再帰呼び出し回数がその分増えます。通常のガチャ・ドロップテーブル用途（数〜数十件）であれば全く問題ありません。

## アップデート
- マクロの未使用化
- 複数の同時抽選実装

## ライセンス
LICENSEファイルを必ず確認してください
