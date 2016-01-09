# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

$scriptPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path -Parent $scriptPath

@'
<top BuiltBy = "Windows PowerShell">
    <a pronounced="eh">
        one
    </a>
    <b pronounced="bee">
        two
    </b>
    <c one="1" two="2" three="3">
        <one>
            1
        </one>
        <two>
            2
        </two>
        <three>
            3
        </three>
    </c>
    <d>
        Hello there world
    </d>
</top>
'@ >"$($(Resolve-Path $scriptPath).Path)\fancy.xml"
