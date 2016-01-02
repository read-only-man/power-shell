# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# ハッシュのリテラルは@{key=val;}で記載する。
# 1要素は式となるので、改行で区切ってもいい

$user = @{FirstName = "John"; LastName="Smith"; PhoneNumber="555-1212"}
$user

Write-Output ""

$user2 = @{
FirstName = "John"
LastName="Smith"
PhoneNumber="555-1212"}
$user2

Write-Output ""

$user.firstname
$user.lastname

Write-Output ""

$user["firstname"]
$user["firstname","lastname"]

Write-Output ""

$user.Keys

Write-Output ""

$user.Values

Write-Output ""

$user[$user.Keys]

Write-Output ""

$user.Keys | Sort-Object

Write-Output ""

# キーのアルファベット順に値を出力 sortの戻り値はオブジェクト型なので、String配列に変換する必要がある
$user[[String[]] ($user.Keys | Sort-Object)]
"$($user.Keys |  Sort-Object | foreach {`"$_ : $($user[$_]) `"})"

Write-Output ""

# 値のput
$user.date = Get-Date
$user

Write-Output ""

$user["city"] = "Seattle"
$user

Write-Output ""

$user.Remove("city")
$user