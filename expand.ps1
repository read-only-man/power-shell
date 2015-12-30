# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 式展開のテスト
$foo = "Foo"
"this is a string in double quotes: $foo"
'this is a string in single quotes: $foo'

Write-Output "`n"

# かっこの前を$で指定すれば、かっこの内容が計算される。
"2 + 2 is $(2+2)"
$x = 3
"$x + 3 is $($x+3)"

Write-Output "`n"

"Numbers 1 throw 10 : $(for ($i=1;$i -le 10;$i++){$i})."

$x=0

# これは代入時に一度だけ評価される
$a = "x is $($x++; $x)"
1..3 | foreach {$a}

Write-Output "`n"

# ループごとに評価される。
1..3 | foreach {"x is $($x++; $x)"}

# ヒアドキュメント
$a = @"
Line one
Line two
Line three
"@

$a