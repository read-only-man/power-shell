# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# GDI+サンプル　 (GDI: Graphics Design Interface) 

param(
    $opacity = 1.0,
    $increment = 50,
    $numRevs = 20,
    $size=(500,500)
)

# 引数処理
if ($args) {
    throw 'param($opacity=1.0,$increment=50,$numRevs=50)'
}

$scriptPath = $MyInvocation.MyCommand.Path
$scriptPath = Split-Path -Parent $scriptPath

. "$((Resolve-Path $scriptPath).ProviderPath)\winform.ps1"

# teal 青緑色
$colors = red blue yellow green orange black cyan teal white purple gray
$cIndex = 0
$color = $colors[$cIndex++]

[System.Windows.Forms.Form] $form = Form Form @{
    TopMost = $true
    Opacity = $opacity
    Size = Size $size[0] $size[1]
}

[System.Drawing.SolidBrush] $myBrush = Drawing SolidBrush $color
[System.Drawing.Pen] $pen = Drawing Pen black @{Width = 3}
[System.Drawing.Rectangle] $rec = Drawing Rectangle 0,0,200,200

# Spiral
function Spiral ([System.Drawing.Graphics] $grfx)
{
    $cx,$cy = $form.ClientRectangle.Width, $form.ClientRectangle.Height
    $iNumPoints = $numRevs * 2 * ($cx + $cy)
    $cx /= 2
    $cy /= 2
    $np = $iNumPoints / $numRevs
    $fAngle = $i * 2.0 * [System.Math]::PI / $np
    $fScale = 1.0 - $i / $iNumPoints
    $x,$y = ($cx * (1.0 + $fScale * [System.Math]::Cos($fAngle))),
            ($cy * (1.0 + $fScale * [System.Math]::Sin($fAngle)))

    # 渦巻きの描画
    for ($i=0
         $i -lt $iNumPoints
         $i += 50)
    {
        $fAngle = $i * 2.0 * [System.Math]::PI / $np
        $fScale = 1.0 - $i / $iNumPoints
        $ox,$oy = $x,$y
        $x,$y = ($cx * (1.0 + $fScale * [System.Math]::Cos($fAngle))),
                ($cy * (1.0 + $fScale * [System.Math]::Sin($fAngle)))
        $grfx.DrawLine($pen, $ox, $oy, $x ,$y)
    }
}

# Timerイベントハンドラ
$handler = {
    $rec.Width = $form.Size.Width
    $rec.Height = $form.Size.Height
    $myBrush.Color = $color
    [System.Drawing.Graphics] $formGraphics = $form.CreateGraphics()
    $form.Text = "Color: $color".ToUpper()
    $color = $colors[$cIndex]

    $cIndex = $(if($cIndex -eq $null){1} else {$cIndex++})

    $cIndex = $cIndex % $colors.Length
    $pen.Color = $color
    Spiral $formGraphics
    $formGraphics.Dispose() # この Graphics によって使用されているすべてのリソースを解放します。
}

# Timerイベントの設定
[System.Windows.Forms.Timer] $timer = New-Object System.Windows.Forms.Timer
$timer.Interval = 5000
$timer.Add_Tick($handler)
$timer.Start()

# Paintイベントハンドラを追加する
$form.Add_Paint($handler)

$form.Add_Shown({$form.Activate()})
[void] $form.ShowDialog()
