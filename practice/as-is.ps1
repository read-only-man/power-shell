# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# -is 型検証
$true -is [bool]

# -as キャスト
# [int] "abc" -eq $null # これはエラー
("abc" -as [int]) -eq $null  # エラーにならない

# 動的なキャスト
foreach ($t in [int],[float],[double])
{
  $x = "123.45" -as $t
  "$x : $($x.GetType().FullName)"
}


$c  = [char] "A"

1..50 | foreach{
  Write-Output "$_ : $([char](([int] $c)++))"
}
