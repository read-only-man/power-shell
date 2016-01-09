# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# フィルターを定義する。
filter double{$_ * 2}
1..10 | double
