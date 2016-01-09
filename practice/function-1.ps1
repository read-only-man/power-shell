# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

function hello {"Hello world"}
hello;hello;hello

Write-Output ""

function hello {
 $OFS = ","
 "Hello there $args and how are you"
}

hello Bob Carol Ted Alice
hello Bob,Carol,Ted,Alice

Write-Output ""

function count-args {
 "`$args.count=" + $args.Count
 "`$args[0].count=" + $args[0].Count
}

count-args 1 2 3
count-args 1,2,3

Write-Output ""

function ql { $args }    # 配列にする
function qs { "$args" }  # 文字列にする
ql black white brown
qs this is string

function add-two {
    $x,$y = $args
    $x + $y
}

Write-Output ""

add-two 1 2

