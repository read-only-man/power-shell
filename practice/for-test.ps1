# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 評価式のネスト
for($i=0;$($y=$i*2;$i -lt 5);$i++){
    $y
}

# svchostプロセスに取得されているハンドル数の合計
$svchosts = gps svchost
for($($total=0;$i=0); $i -lt $svchosts.count; $i++){
    $total += $svchosts[$i].Handles
}
$total
