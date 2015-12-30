# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# doubleにあわされる
2 + 3.0 + "4"
(2 + 3.0 + "4").GetType().FullName

# int
(6/3)
(6/3).GetType().FullName

# double
(6/4)
(6/4).GetType().FullName

# まるめが発生する
1e300
1e300　+ 100
(1e300　+ 100).GetType().FullName
