# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# begin 初期処理
# process 要素ごとの処理
# end 終了処理

function my-cmdlet ($x){
    begin   {$c=0; "In begin, c is $c, x is $x"}
    process {$c++; "In process, c is $c, x is $x, `$_ is $_"}
    end     {"In end, c is $c, x is $x"}
}

1..10 | my-cmdlet 20