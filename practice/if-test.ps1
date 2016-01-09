# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# ネストしたif文
$x = 10
if ( $( if ($x -lt 5) {$false} else {$x}) -gt 20 ) {$false} else {$true}

$x = 25
if ( $( if ($x -lt 5) {$false} else {$x}) -gt 20 ) {$false} else {$true}

$x = 4
if ( $( if ($x -lt 5) {$false} else {$x}) -gt 20 ) {$false} else {$true}
