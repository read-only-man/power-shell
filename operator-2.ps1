# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 論理演算　これも左オペレータの型で比較する。
01 -eq 001         # True 数値的に一緒だから
01 -eq "001"       # True 数値的に一緒だから
"1" -eq 1          # True 文字列として同じだから
"01" -eq 001       # False 文字列として違うから
[int] "01" -eq 001 # True 数値として一緒だから

Write-Output ""

# ややこしい系、実際遭遇しないと思うが。。
[int]"123" -lt 123.4        # True 右オペランドの浮動小数に拡大される
[int]"123" -lt [int]"123.4" # False
123 -lt "123.4"             # Dabuleで解釈してくれるぽい

Write-Output ""

# コレクションの演算
# arrayの-eqは一致する要素を返す。
@(1,2,3,4,5,6,1,2) -eq 2
$a=@()
1..10 | foreach{$a+=[string]$_}
Write-Output ([string]::Join( ",",$a))

$a=@(1,"02",3,02,"1")
$a -contains "02"
$a -notcontains "02"
