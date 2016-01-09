# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

#　ヘルプファイルの管理が変わった

function Select-Help($pat = "." )
{
    $cmdHlp = "Microspft.PowerShell.Commands.Management.dll-Help.xml"
    $doc = "$PSHOME\ja\$cmdHlp"

    $setting = New-Object System.Xml.XmlReaderSettings
    $setting.ProhibitDtd = $false
    $reader = [System.Xml.XmlReader]::Create($doc, $setting)

    $name = $null
    $capture_name = $false
    $capture_description = $false
    $finish_ilne = $false

    while ($reader.Read())
    {
        Switch-Certificate($reader.NodeType)
        {
            ([System.Xml.XmlNodeType]::Element)
            {
                "element"
                break
            }
            ([System.Xml.XmlNodeType]::EndElement)
            {
                "end-element"
                break
            }
            ([System.Xml.XmlNodeType]::Text)
            {
                "text"
                break
            }
        }
    }
    $reader.close()
}

Select-Help
