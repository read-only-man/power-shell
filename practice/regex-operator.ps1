# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# 正規表現テスト
"Hello" -match "[jkl]"      # true
"Hello" -notmatch "[jkl]"  # false

"Hello" -replace "ll","ii" # Heiio
"Hello" -replace "ll"      # Heo

# $matchesで参照をハッシュにして受け取れる。
"abc"  -match "(.)(.)(.)"
$Matches

# キー名は　?<>で指定できる
"abc"  -match "(?<one>.)(?<two>.)(?<three>.)"
$Matches
