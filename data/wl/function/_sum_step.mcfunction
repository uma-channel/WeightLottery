# wl:_sum_step (internal / 内部関数)
# pool[idx] が存在する間だけ本体を呼ぶ。存在しなければ何もせず再帰終了。
$execute if data storage wl:io pool[$(idx)] run function wl:_sum_step_body with storage wl:io
