# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# パラメータ設定など
function subtruct($from, $to){
    $from - $to
}

subtruct 5 3
subtruct -from 5  -to 3
subtruct -to 5 -from 3
subtruct -to 5 3

Write-Output ""

# 型指定
function add ($x, $y){$x + $y}
function nadd ([int]$x, [int]$y){$x + $y}
add "1" "2"
nadd "1" "2"

# ※オーバロードはできない

Write-Output ""

# 可変引数
function arg-test($x,$y){
    "x is $x"
    "y is $y"
    "args is $args"
}

arg-test 1
arg-test 1 2
arg-test 1 2 3
arg-test 1 2 3 4 5

Write-Output ""

# 引数の初期化
function dow([datetime] $d = $(Get-Date)){
    $d.DayOfWeek
}

dow
dow "jun 2, 2001"

# パラメータチェック
function zed ($x=$(throw "need x")){
    "x is $x"
}

zed 12
# zed 例外を発生する。

Write-Output ""

# スイッチパラメータ
function get-soup(
    [switch] $please,
    [string] $soup = "chicken noodle"){
    if($please) {
        "Here's your $soup soup"
    }
    else{
        "No soup for you."
    }
}

get-soup
get-soup -please
get-soup -please "tomato"
