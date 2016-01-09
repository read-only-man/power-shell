# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

&{
    trap {"$_";continue} # catchして出力後、継続する
    &{
        "one"
        "two"
        throw "err"
        "three"   # 実行されない
    }
    "all done"
}
