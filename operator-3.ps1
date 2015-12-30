﻿# セキュリティ設定（要　管理者実行）
# Set-ExecutionPolicy RemoteSigned

# $
# 部分式は単一の式に制限されるのではなく、一連の文をグループ化する。
# なかに含まれた文が単一の値を返す場合、それはスカラーとして返される。
# 文が複数の値を返す場合は、配列に格納される。

# @
# 配列部分式演算子は、通常の部分式演算子と同じ方法で一連の文をグループ化するが、結果は常に配列として返される。

$("bbb","aaa","ccc" | sort)[0]
$("aaa","ccc" | sort)[0]
$("aaa" | sort)[0]                # 配列にならない

@("bbb","aaa","ccc" | sort)[0]
@("aaa","ccc" | sort)[0]
@("aaa" | sort)[0]