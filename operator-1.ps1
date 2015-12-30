# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 左のオペランドにキャストされる例
2 + "123"
"123" + 2
# 2 + "abc" # これはエラー
"abc" + 2
2 + "0xabc"

Write-Output ""

# 配列の型　型指定をすると、その方の配列を作れる。　要素を追加して新しい配列を作ると、object型にもできる。
$a = [int[]] @(1,2,3,4)
$a.GetType().FullName

$a[0] = 10
# $a[0] = "Hello" # これはエラー
$a += "hello" # これは新規配列になるのでOK
$a.GetType().FullName

Write-Output ""

# ハッシュの加算
$left = @{
one=1
two=2
three=3}
$right = @{
four=4
five=5}

$new = $left + $right
$new