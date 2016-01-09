# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

$l=0;foreach ($f in dir *.txt){$l+=$f.length}
$l

$c=$l=0
$l=0;foreach ($f in dir *.txt){$c++;$l+=$f.length}
$c
$l

$c=$l=0
dir *.txt | ForEach-Object {$c++; $l += $_.Length}
$c
$l

# [void]で出力を抑止する。
foreach($i in 1..20) {[void] $foreach.moveNext(); $i + $foreach.current}

# $foreachのメンバ
[System.Collections.IEnumerator].GetMembers() | foreach {"$_"}

# スカラー値は1回のオブジェクトとして処理される。$nullも
foreach($i in "a"){"hi"}
foreach($i in $null){"hi"}
foreach($i in $false){"hi"}
foreach($i in @()){"hi"}    # 実行されず
foreach($i in @{}){"hi"}    # 実行されず

# foreach-objectコマンドレットのエイリアスは%
gps svchost | % {$t=0}{$t+=$_.handles}{$t}