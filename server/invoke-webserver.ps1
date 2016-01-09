param($port=18080)

# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# socketライブラリの読み込み
[void][System.Reflection.Assembly]::LoadWithPartialName("System.Net.Sockets")

# htmlジェネレータ
function html ($content, $title= "Exsample PowerShell Web Server Page")
{
    @"
    <html>
        <head>
            <title>$title</title>
        </head>
        <body>
            $content
        </body>
    </html>
"@
}

function sendResponse ([System.Net.Sockets.Socket] $sock,[String] $str){
    if($sock.connected){

    }
}
