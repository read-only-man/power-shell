# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# Formユーティリティライブラリ
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing")
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")

# Drawingオブジェクトのヘルパ関数
function Point {New-Object System.Drawing.Point $args}
function Size {New-Object System.Drawing.Size $args}

# Formヘルパ関数
function Form ($Control, [hashtable] $Properties)
{
    $c = New-Object "Windows.Forms.$Control"
    if ($Properties)
    {
        # Formオブジェクトの初期化
        foreach ($prop in $Properties.Keys)
        {
            $c.$prop = $Properties[$prop]
        }
    }
    $c
}

# Drawingヘルパ関数
function Drawing ([System.Windows.Forms.Control]$Control, $Constructor, [hashtable]$Properties)
{
    $c = New-Object "Drawing.$Control" $Constructor
    if ($Properties)
    {
        foreach($prop in $Properties)
        {
            $c.$prop = $Properties[$prop]
        }
    }
    $c
}

# フォーム配置ヘルパ関数
function RightEdge ([System.Windows.Forms.Control]$x, $offset) { $x.Location.X + $x.Size.Width + $offset }
function LeftEdge ([System.Windows.Forms.Control]$x) { $x.Location.X }
function BottomEdge ([System.Windows.Forms.Control]$x, $offset=1) { $x.Location.Y + $x.Size.Height + $offset }
function TopEdge ([System.Windows.Forms.Control]$x, $offset) { $x.Location.Y }

# MessageBoxヘルパ関数
function Message ( $str, $title="PowerShell Message")
{
    [System.Windows.Forms.MessageBox]::Show($str, $title)
}

# MenuStripヘルパ関数
function New-MenuStrip ([System.Windows.Forms.Form] $Form, [scriptblock] $Menu)
{
    [System.Windows.Forms.MenuStrip] $ms = Form MenuStrip
    [void] $ms.Items.AddRange((&$Menu))
    $Form.MainMenuStrip = $ms
    $ms
}

# Menuヘルパ関数
function New-Menu ($Name, [scriptblock] $Items)
{
    [System.Windows.Forms.ToolStripMenuItem] $menu = Form ToolStripMenuItem @{Text = $Name}
    [void] $menu.DropDownItems.AddRange((&$Items))
    $menu
}

# MenuItemヘルパ関数
function New-MenuItem($Name, $Actionn)
{
    [System.Windows.Forms.ToolStripMenuItem] $item = Form ToolStripMenuItem @{Text = $name}
    [void] $item.Add_Click($Actionn)
    $item
}

# メニューセパレータヘルパ関数
function New-Separator { Form ToolStripSeparator }

# レイアウトスタイルヘルパ関数
function Style ($RowOrColumn="row", $Paecent=-1)
{
    if ($Paecent -eq -1){
        $typeArgs = "AutoSize"
    }
    else
    {
        $typeArgs = "Percent",$Paecent
    }
    New-Object Windows.Forms.${RowOrColumn}Style $typeArgs
}
