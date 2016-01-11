# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# プロセスビューア

$scriptPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path -Parent $scriptPath

. "$((Resolve-Path $scriptPath).ProviderPath)\winform.ps1"

[System.Windows.Forms.Form] $form = Form Form @{
    AutoSize=$true
    Text = "PowerShell Graphical Process Viewer"
}

$sortCriteria = "ProcessName"

[System.Windows.Forms.TableLayoutPanel] $table = Form TableLayoutPanel @{
    columncount = 6
    Dock = "fill"
    AutoSizeMode = "GrowOnly"
    AutoSize = $true
}
$form.Controls.Add($table)

# スタイルの設定
[void] $table.RowStyles.Add((Style))
[void] $table.RowStyles.Add((Style -Paecent 50))
1..3 | %{ [void] $table.RowStyles.Add((Style))}
1..4 | %{ [void] $table.ColumnStyles.Add((Style "column" 17))}

# メニュー
[System.Windows.Forms.MenuStrip] $menu =  New-MenuStrip $form {
    New-Menu File {
        New-MenuItem "Update" { update }
        New-Separator
        New-MenuItem "QUit" { $form.Close() }
    }
    New-Menu Help {
        New-MenuItem "About" {
            Message @"
            PowerShell Process Viewer
            Windows Forms Demo Applet
            From Windows PowerShell in Action
            Manning Pubkications Co, 2006
"@
        }
    }
}
$table.Controls.Add($menu)
$table.SetColumnSpan($menu, 6)

# グリッドコントロール
[System.Windows.Forms.DataGrid] $grid = Form DataGrid @{
    Dock ="fill"
    CaptionText = "PowerShell Graphical Process iewer"
}
$table.Controls.Add($grid)
$table.SetColumnSpan($grid, 6)

function New-Button ($label, $action)
{
    [System.Windows.Forms.Button] $b = Form Button @{Text = $label;Anchor = "left,right"}
    $b.Add_Click($action)
    $table.Controls.Add($b)
}

# ボタン作成
New-Button "Name" {update "ProcessName"}
New-Button "Id" {update "Id"}
New-Button "Handles" {update "Handles"}
New-Button "WorkingSet(WS)" {update "WS"}
New-Button "CPU" {update "CPU"}

$status = Form Label @{
    dock = "fill"
    flatstyle = "popup"
    borderstyle = "fixed3d"
}
$table.Controls.Add($status)
$table.SetColumnSpan($status, 6)

# 更新処理
function update ($sortCriteria="ProcessName")
{
    $grid.DataSource = New-Object System.Collections.ArrayList (,(Get-Process | sort $sortCriteria | select name, id, handles, workingset, cpu))
    $grid.CaptionText = "Process Data Sorted by $sortCriteria"
    $status.Text = "Last Updated on $(Get-Date | Out-String)" -replace "`n"
}

update
$form.Add_Shown(($form.Activate()))
[void] $form.ShowDialog()
