# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 引用符のテスト
# シングルクォートは文字として扱う
Write-Output '-InputObject'
cd 'C:\Program Files'
pwd

# ダブルクォートは式を展開する。
$v = "files"
cd "C:\Program $v"
pwd

'$v is $v'
"$v is $v"

# バッククォートでエスケープできる。
"`$v is $v"
"`$v is '$v'"

# バッククォートでエスケープシーケンスを実行できる。
"The value of `$v is:`n$v"
"`a"
