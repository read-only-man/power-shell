# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

[int] "0x25"

[int] [char] "a"

[int[]] [char[]] "Hello world"

Write-Output ""

# $OFSは出力フィールドセパレータ
"`$OFS is '$OFS'"

Write-Output ""

# 2001宇宙の旅の人工知能はHAL、1を足していくと
$str = "HAL"
$OFS=""
"HAL each + 1 is $([string] [char[]] ( [int[]] [char[]] $str | foreach {$_+1}))"

$data=1,2,3,4,5,6,7,8,9,10
[string] $data

$OFS="+"

"$data"

# eval
Invoke-Expression "$data"
