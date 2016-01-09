# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

$scriptPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path -Parent $scriptPath

. "$($(Resolve-Path $scriptPath).Path)\create-fancy.ps1"

# [System.Xml.XmlReader] | gm

function Dump-Doc ($doc="$($(Resolve-Path $scriptPath).Path)\fancy.xml")
{
    $settings = New-Object System.Xml.XmlReaderSettings
    $doc = (Resolve-Path $doc).ProviderPath
    $reader = [ System.Xml.XmlReader ]::Create($doc ,$settings)
    $indent=0
    
    function indent ($s){ "    " * $indent + $s}

    while($reader.Read()){
        if($reader.NodeType -eq [System.Xml.XmlNodeType]::Element)
        {

            $close = $(if ($reader.isEmptyElement) { "/>" } else{ ">" })
            if($reader.HasAttribute)
            {
                $s = "<$($reader.name) "
                [void] $reader.movetoFirstAttribute()
                do {
                    $s += "$($reader.Name) = `"$($reader.Value)`""
                }
                while($reader.movetoFirstAttribute())
                "$s$close"
            }
            else
            {
                indent "<$($reader.Name)$close"
            }
            if($close -ne '/>'){$indent++}
        }
        elseif ($reader.NodeType -eq [System.Xml.XmlNodeType]::EndElement){
            $indent--
            indent "</$($reader.Name)>"
        }
        elseif ($reader.NodeType -eq [System.Xml.XmlNodeType]::Text){
            indent "$($reader.Value)"
        }
    }
    $reader.Close()
}

Dump-Doc "$($(Resolve-Path $scriptPath).ProviderPath)\fancy.xml"
