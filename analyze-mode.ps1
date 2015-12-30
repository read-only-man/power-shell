# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 解析モードのテスト、式モードとコマンドモード

# 式モード　結果は4
2+2

# コマンドモード　結果は"2+2"
Write-Output 2+2

# 式モード
Write-Output (2+2)

# 式モード
$a=2+2
Write-Output $a.Equals(4)

# コマンドモード
Write-Output $a/foo.txt
