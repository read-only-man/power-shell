# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 電卓アプリケーション

$scriptPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path -Parent $scriptPath

. "$($(Resolve-Path $scriptPath).Path)\winform.ps1"

# 関数を設定する
$Script:op = ''
$Script:doClear = $false
function clr { $Script:result.text = 0 }
[decimal] $Script:value = 0

# 演算子スクリプトブロック
$handleDigit = {
    if ($Script:doClear)
    {
        $Script:result.text = 0
        $Script:doClear = $false
    }

    $key = $this.text
    $current = $Script:result.text
    if ($current -match '^0$|NaN|Infinity')
    {
        $Script:result.text = $key
    }
    else
    {
        if ($key -ne '.' -or $current -notmatch '\.')
        {
            $Script:result.text += $key
        }
    }
}

# 数字スクリプトブロック
$handleOp = {
    $Script:value = $Script:result.text
    $Script:op = $this.text
    $Script:doClear = $true
}

# キー/アクションテーブル
$keys = (
    @{name='7'; action=$handleDigit},
    @{name='8'; action=$handleDigit},
    @{name='9'; action=$handleDigit},
    @{name='/'; action=$handleOp},
    # 平方根ハンドラ
    @{name='SQRT';action= {
        trap{ $Script:result.text = 0; continue}
        $Script:result.text = [System.Math]::Sqrt([decimal] $Script:result.text)
    }},
    @{name='4'; action=$handleDigit},
    @{name='5'; action=$handleDigit},
    @{name='6'; action=$handleDigit},
    @{name='*'; action=$handleOp},
    @{name='Clr'; action=$Function:clr},
    @{name='1'; action=$handleDigit},
    @{name='2'; action=$handleDigit},
    @{name='3'; action=$handleDigit},
    @{name='-'; action=$handleOp},
    @{name='1/x'; action= {
        trap { $Script:result.text = 0; continue}
        $val = [decimal] $Script:result.text
        if ($val -ne 0){
            $Script:result.text = 1.0 / $val
        }
    }},
    @{name='0'; action=$handleDigit},
    @{name='+/-'; action= {
        trap { $Script:result.text = 0; continue}
        $Script:result.text = - ([decimal] $Script:result.text)
    }},
    @{name='.'; action=$handleDigit},
    @{name='+'; action=$handleOp},
    @{name='='; action= {
        $key = $this.text
        trap {message "Error: $key" "Error: $key"; continue}
        $operand = [decimal] $Script:result.text
        $Script:result.text = Invoke-Expression "`$value $op `$operand"
    }},
    @{name='%'; action=$handleOp},
    @{name='sin'; action= {
        trap{ $Script:result.text=0; continue}
        $Script:result.text = [System.Math]::Sin([decimal] $Script:result.text)
    }},
    @{name='cos'; action= {
        trap{ $Script:result.text=0; continue}
        $Script:result.text = [System.Math]::Cos([decimal] $Script:result.text)
    }},
    @{name='tan'; action= {
        trap{ $Script:result.text=0; continue}
        $Script:result.text = [System.Math]::Tan([decimal] $Script:result.text)
    }},
    @{name='int'; action= {
        trap{ $Script:result.text=0; continue}
        $Script:result.text = [int] $Script:result.text
    }},
    @{name='Sqr'; action= {
        trap{ $Script:result.text=0; continue}
        $Script:result.text = [System.Math]::Pow( [double] $Script:result.text, 2)
    }},
    @{name='Quit'; action={$form.close()}}
)

# 電卓の列数
$columns = 5

[System.Windows.Forms.Form] $form = Form Form @{
    Text = "PowerShell Calculator"
    TopLevel = $true
    Padding = 5
}

# トップレベルレイアウト
[System.Windows.Forms.TableLayoutPanel] $table = Form TableLayoutPanel @{
    ColumnCount = 1
    Dock = "fill"
}
$form.Controls.Add($table)

# メニュー
[System.Windows.Forms.MenuStrip] $menu = New-MenuStrip $form { 
    New-Menu File {
        New-MenuItem "Clear" {clr}
        New-Separator
        New-MenuItem "Quit" {$form.Close()}
    }
}

$table.Controls.Add($menu)

# フォント設定
[System.Drawing.Font] $cfont = New-Object System.Drawing.Font 'Lucida Console', 10.0, Regular, Point, 0

# 表示テキストボックス
[System.Windows.Forms.TextBox] $Script:result = Form TextBox @{
    Dock = "fill"
    Font = $cfont
    Text = 0
}
$table.Controls.Add($Script:result)

# ボタンレイアウトパネル
[System.Windows.Forms.TableLayoutPanel] $buttons = Form TableLayoutPanel @{
    ColumnCount = $columns
    Dock = "fill"
}

# キーアクションをバインドする
foreach ($key in $keys)
{
    [System.Windows.Forms.Button] $b = Form Button @{
        Text = $key.name
        Font = $cfont
        Size = Size 50 30
    }
    $b.add_Click($key.action)
    $buttons.Controls.Add($b)
}
$table.Controls.Add($buttons)

# フォームサイズの設定
$height = ([System.Math]::Ceiling($keys.Count / $columns)) * 40 + 100
$width = $columns * 60 + 10

$Script:result.Size = Size ($width - 10) $Script:result.Size.Height
$form.Size = Size $width $height

$form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()
