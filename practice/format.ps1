# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# フォーマットの確認
Get-Command format-*

Get-Command format-* | ft name

Get-Item C:\

Get-Item C:\ | Format-Table

# -autosizeで最適な幅になるが、処理的には少し重くなる
Get-Item C:\ | Format-Table -AutoSize

Get-Item C:\ | Format-List

# 複数ある場合は一連のリストとして表示される
Get-Item C:\,D:\ | Format-List

Get-Process s*

Get-Process s* | Format-Wide

Get-Process s* | Format-Wide -Column 8

Get-Process s* | Format-Wide -Column 8 id
