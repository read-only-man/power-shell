# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 関数の管理
dir function:/

(dir function:/).count
function test{}
(dir function:/).count

# 削除
rm function:/test
(dir function:/).count
