# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

1,2,1+2     # 1212
1,2,(1+2)   # 123

Write-Output ""

$a = ((1,2),(3,4),(5,6),(7,8))
$a.Length
$a[0].Length
$a[0][1]

Write-Output ""

1..3 + 5..9 # 配列の結果を得られる。
Write-Output ""
-5..1       # 負の値も使える。
Write-Output ""
"1.1"..2.6  # 整数にされる。
Write-Output ""

$a = 0..10
$a[2,3,4,5] # インデックスを複数指定して、スライスできる
Write-Output ""
$indexes = 2,3,4
$a[$indexes]     # 変数指定
Write-Output ""
$a[0..3]         # 範囲指定
Write-Output ""
$a[(2,5,6,8 | foreach{$_ + 1})] # 式指定
Write-Output ""
$a[-1]                          # 最後からとる
Write-Output ""
$a[-4..-1]
Write-Output ""
$a[($a.Length-1)..0]            # 降順
Write-Output ""
[array]::Reverse($a)            # 正規の降順のやり方
