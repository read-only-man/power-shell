# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# フィルタリング、エイリアスは"?"
1..10 | where {!($_ -band 1) }
1..10 | ? {!($_ -band 1) }

1..26 | ? {! ($_ -band 1)} | % {[string][char] ([int][char] 'A' + $_ -1 ) * $_}