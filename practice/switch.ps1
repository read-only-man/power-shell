# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

switch(2){
    1{"one"}
    2{"two"}
    3{"three"}
}

Write-Output ""

switch(2){
    1{"one"}
    2{"two"}
    2{"two"}
}

Write-Output ""

switch(2){
    1{"one"}
    2{"two";break}
    2{"two"}
}

Write-Output ""

switch(5){
    1{"one"}
    2{"two"}
    3{"three"}
    default{"other"}
}

Write-Output ""

# 文字列は-caseで大文字、小文字比較
switch ("abc"){
    "abc" {"one"}
    "ABC" {"two"}
}

Write-Output ""

switch -case ("abc"){
    "abc" {"one"}
    "ABC" {"two"}
}

Write-Output ""

# ワイルドカード $_で一致した表現を取得できる。
switch -case -Wildcard ("abc"){
    a* {"a* : $_"}
    *c {"*c : $_"}
}

Write-Output ""

# 正規表現
Switch -Regex ("abc") {
 ^a {"^a : $_"}
 c$ {"c`$ : $_"}
}

Write-Output ""

Switch -Regex ("abc") {
 "(^a)(.+$)" {$matches}
}

Write-Output ""

# 条件式 {}で条件を作るのに注意
switch (5) {
    {$_ -lt 5}{"less than 5"}
    {$_ -ge 5}{"greater equal 5"}
}

Write-Output ""

switch(1..10){
 {!($_ % 2)} {"Even : $_";continue}
 {!($_ % 3)} {"Nabeatsu";continue}
 default {"Odd : $_"}
}

$dll=$txt=$log=0

Write-Output ""

switch -Wildcard (dir C:\Windows){
    *.log {$log++}
    *.txt {$txt++}
    *.dll {$dll++}
}
"dll=$('{0:d5}' -f ,$dll), txt=$('{0:d5}' -f ,$txt), log=$('{0:d5}' -f ,$log)"

Write-Output ""

# ファイル検索
$au = $du = $su =0
switch -Regex -File C:\Windows\WindowsUpdate.log {
    'START.*Finding updates.*AutomaticUpdates' {$au++;continue}
    'START.*Finding updates.*Defender' {$du++;continue}
    'START.*Finding updates.*SMS' {$su++;continue}
}
"Automatic:$au Defenger:$du SMS:$su"