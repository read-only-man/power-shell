# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

$i=0
while($true){
    if($i++ -ge 5){
        break
     }
        $i
}

Write-Output ""

foreach ($i in 1..10){
    if($i % 2)
    {
        continue
    }
    $i
}

Write-Output ""

# 大域脱出 ラベルを付ける。
:outer while(1){
    while(1){
        break outer
    }
}

# ラベルは変数でも可能
$target = "foo"
:foo foreach($i in 1..10){
    if(!($i % 2)){
        continue $target
    }
    $i
}

