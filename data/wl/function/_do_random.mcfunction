# wl:_do_random (internal / 内部関数)
# storage wl:io の "max" (= 合計weight-1) を使って 0..max の乱数を1回振る
$execute store result score #wl_rand wl run random value 0..$(max)
