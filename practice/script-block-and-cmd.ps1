# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

get-command Get-ChildItem

$d = Get-Command Get-Date
Write-Output ""
$d.CommandType
Write-Output ""
$d.Name
Write-Output ""
# 実行 & をつける
& $d
Write-Output ""
& "get-date"
