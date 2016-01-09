# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 変数関連のテスト

# 其の一 設定されていない変数は$null状態となる。
$noSuchVariable
$noSuchVariable -eq $null

Write-Output ""

# 其の二 変数が存在するかどうかは、test-pathコマンドレットをvariable名前空間に対して使う
$x = 1
Test-Path variable:noSuchVariable
Test-Path variable:x

Write-Output ""

# 其の三 変数一覧は、variable名前空間にdirをかけて取得できる。（関数等も同じやり方）
dir variable:/

Write-Output ""

# 変数の型指定
[int] $var = 2
$var
# 指定した型にキャストされる。
$var = "0123"
$var

Write-Output ""

# グローバル名前空間のアクセス
$Global:var = 100

# 環境変数のアクセス
# dir $env:SystemRoot

# スクリプトパスの取得
$scriptPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path -Parent $scriptPath

