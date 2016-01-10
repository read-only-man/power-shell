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

function SendResponse ([System.Net.Sockets.Socket] $sock, [String] $str){
    if($sock.connected){
        $byteSent = $sock.Send([System.Text.Encoding]::ASCII.GetBytes($str))
        if($byteSent  -eq -1)
        {
            Write-Host ("Send fail to " + $sock.RemoteEndPoint)
        }
        else
        {
            Write-Host ("Sent $byteSent byte to " + $sock.RemoteEndPoint)
        }
    }
}

function SendHeader ([System.Net.Sockets.Socket] $sock, $length, $statusCode = "200 OK", $mimeHeader = "text/html", $httpVersion = "HTTP/1.1")
{
    $response = "$httpVersion $statusCode`r`nServer: Localhost`r`nContent-Type: $mimeHeader`r`nAccept-Ranges: bytes`r`nContent-Length: $length`r`n`r`n"
    SendResponse $sock $response
    Write-Host "Header Sent"
}

[System.Net.Sockets.TcpListener] $server = [System.Net.Sockets.TcpListener] $port
$server.Start()

$buffer = New-Object byte[] 1024

Write-Host "Press any key to stop Web Server..."

while($true)
{
    if($Host.UI.RawUI.KeyAvailable)
    {
        Write-Host "Stopping server..."
        break
    }

    # リクエストをチェックする
    if($server.Pending())
    {
        [System.Net.Sockets.Socket] $sock = $server.AcceptSocket()
    }

    if($sock.Connected)
    {
        Write-Host ("Connection at {0} from {1}." -f (Get-Date), $sock.RemoteEndPoint)

        # データの取得
        [void] $sock.Receive($buffer, $buffer.Length, '0')
        $received = [System.Text.Encoding]::ASCII.GetString($buffer)

        $received = [regex]::Split($received, "`r`n")
        $received = @($received -match "GET")[0]

        $result = ""

        if ($received)
        {
            # 式を抽出する
            $expression = $received -replace "GET */" -replace 'HTTP.*$' -replace '%20',' '
            
            if($expression -match '[0-9\.]+ *[-+\*%] *[0-9\.]+')
            {
                Write-Host "Expression: $expression"
                $expressionResult = 
                . {
                    Invoke-Expression $expression
                    trap {
                        Write-Host "Expression failed: $_"
                        "error"
                        continue
                    }
                }
                Write-Host "Expression result: $expressionResult"

                $result = html @"
                        <table border="2">
                            <tr>
                                <td>Expression</td>
                                <td>$expression</td>
                            </tr>
                            <tr>
                                <td>Result</td>
                                <td>$expressionResult</td>
                            </tr>
                            <tr>
                                <td>Date</td>
                                <td>$(Get-Date)</td>
                            </tr>
                        </table>
"@
            }
            else
            {
                # エラー画面用
                $message = "Type Expression to evalute like:"
                $link = "<a href=`"http://localhost:$port/3*5`">http://localhost:$port/3*5</a>"
                $result = html @"
                        <table border="2">
                            <tr>
                                <td>$message</td>
                                <td>$link</td>
                            </tr>
                            <tr>
                                <td>Date</td>
                                <td>$(Get-Date)</td>
                            </tr>
                        </table>
"@
            }
            SendHeader $sock $result.Length
            SendResponse $sock $result
        }
        $sock.Close()
    }
    else
    {
        # 100ミリスリープ
        Start-Sleep -Milliseconds 100
    }
}

$server.Stop()
Write-Host "Server stopped..."
