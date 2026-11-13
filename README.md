English | [日本語](README_jp.md)

# Weight Lottery - Weighted Random Lottery Library


- This datapack is a library that performs **lotteries based on assigned weights**.

---
| count | Action | Write Destination |
|---|---|---|
| `0` or less | Performs no lottery | None (both `result` and `results` are empty) |
| `1` | Single lottery (lightweight path) | `wl:io result` (single compound) |
| `2` or more | Multiple lottery (without duplication) | `wl:io results` (array in order of winning) |

## Pool Format
`pool[0]` is exclusively reserved for meta information (`count`). `pool[1]` and onward are the actual candidates.
```
pool = [
  {count: 2},                         # Index 0 is always meta information
  {id:a, weight:10, ...},             # Index 1 and onward are actual candidates
  {id:b, weight:3, ...},
  {id:c, weight:1, ...}, ...
]
```

## Usage

### Setting the Lottery Pool & Running the Lottery
```mcfunction
data modify storage wl:io pool set value [{count:1},{id:a,weight:10},{id:b,weight:3},{id:c,weight:1}]
function wl:pick
```

### Retrieving Lottery Results
```mcfunction
# When drawing a single item (`count == 1`)
data get storage wl:io result

# When drawing multiple items simultaneously (`count >= 2`)
data get storage wl:io results
```


- `results` contains a list where items are listed in the order they were won (`[0]` is the first winner).
- The same element will never be chosen twice. If the requested count exceeds the number of candidates, `results` will stop with fewer items than requested once all available candidates are exhausted.
- If `pool[0].count` cannot be read (missing key, incorrect format, etc.), `count` is treated as `0`, and both `result` and `results` remain empty with no action taken.
- The `pool` itself is not modified. You can execute `wl:pick` multiple times using the exact same table.

### If You Want to Allow Duplications (Advanced)
`wl:pick` (when `count >= 2`) achieves "without duplication" by completely removing each selected element from `work` upon every win.
If you want "the same prize to be winnable any number of times", modify the beginning of `_pick_multi_step.mcfunction` to run:
`data modify storage wl:io work set from storage wl:io pool` before each draw.

### If You Want to Execute Commands Directly (Advanced)
By adding a string field like `"cmd"` to each element in `pool`, and using macros only in the function that uses the results, this library can remain macro-less while allowing flexible processing on the calling side.
```mcfunction
function yourpack:run_cmd with storage wl:io result
```
```mcfunction
# data/yourpack/function/run_cmd.mcfunction
$$(cmd)
```

## Demo
```mcfunction
function wl:example        # Draw 1 item (Apple 60%, Banana 30%, Melon 10%)
function wl:example_pick   # Draw 2 items without duplication
```

## Supported Versions
**Minecraft JE 1.20.2 or later**

## Notes
- If the number of elements in `pool` is extremely large (hundreds or more), the recursion depth will increase accordingly. For normal gacha or loot table use cases (a few to dozens of items), this is completely fine.

## Updates
- Removed all macro processing for lightweight performance
- Implemented multiple simultaneous lotteries

## License

See [LICENSE](LICENSE) for details.
