# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

function Get-OkCancel
{
    param($question = "Is the answer to Life the Universe and Evreything 42?")

    # pointヘルパ関数
    function point ($x, $y)
    {
        New-Object System.Drawing.Point $x, $y
    }

    # 描画アセンブリの読み込み
    [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms") > $null

    # トップレベルフォーム
    [System.Windows.Forms.Form]$form = New-Object System.Windows.Forms.Form
    $form.Text = "Pick OK or Cancel"
    $form.Size = point 400 200

    # ラベル
    [System.Windows.Forms.Label] $label = New-Object System.Windows.Forms.Label
    $label.Text = $question
    $label.Location = point 50 50
    $label.Size = point 350 50
    $label.Anchor = "top"

    # OKボタンを作成する
    [System.Windows.Forms.Button] $ok = New-Object System.Windows.Forms.Button
    $ok.Text = "OK"
    $ok.Location = point 50 120
    $ok.Anchor = "bottom,left"
    $ok.add_click(
        {
            $form.DialogResult = "OK"
            $form.Close()
        }
    )

    # キャンセルボタンを作成する
    [System.Windows.Forms.Button] $cancel = New-Object System.Windows.Forms.Button
    $cancel.Text = "Cancel"
    $cancel.Location = point 275 120
    $cancel.Anchor = "bottom,right"
    $cancel.add_click(
        {
            $form.DialogResult = "Cancel"
            $form.Close()
        }
    )

    # コントロールを追加する
    $form.Controls.AddRange(@($label, $ok, $cancel))
    $form.add_Shown({$form.Activate()})
    $form.ShowDialog()
}

Get-OkCancel
