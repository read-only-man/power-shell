# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 静的メンバへのアクセス::を使う C++ Ruby C#辺りと一緒

# 静的メンバの参照　Rubyぽい
[string] | Get-Member -Static

Write-Output ""

# joinを使ってみる
[string]::Join("+",@(1,2,3))

# 数学関数
[System.Math] | Get-Member -Static
[System.Math]::PI
[System.Math]::Sin(90)
