# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 配列はカンマで区切ればよい。
$a = 1,2,3
$a.GetType().FullName
$a.Length
$a[0]

Write-Output ""

# 配列の追加、加算すると新しい配列を返す
$b = $a + 10,20
$a
$b

Write-Output ""

# 配列リテラル 1要素の場合
$a = ,1
$a.Length

# 配列リテラル @()形式でサイズ0も作れる
$a = @()
$a.Length
