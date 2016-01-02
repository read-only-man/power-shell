# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# ドット演算子のテスト
# 演算子なので、変数でアクセスできる。

$str = "a quick brown fox jumps over the lazy dog"
$prop = "length"
$str.$prop

Write-Output ""

@(dir c:\windows\* *.dll)[0] | gm -type Property | foreach{$_.name}

Write-Output ""

$obj = @(dir c:\windows\* *.dll)[0]
$names = $obj | gm -type Property l* | foreach{$_.name}

$names | foreach{"$_ : $($obj.$_)"}

# :: 演算子　静的メンバアクセスも演算子なので変数化可能
$type = [string]
$type::join("+",(1,2,3))
$method = "join"
[string]::$method("+",(1,2,3))
