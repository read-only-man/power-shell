# $aにもっとも大きいファイルを格納する。
$a = dir D:\Users\ryuichi\Documents\GitHub\clisp\landoflisp\20150508 | sort -property length -desc | select-object -first 1
echo $a

$a = dir D:\Users\ryuichi\Documents\GitHub\clisp\landoflisp\20150508 | sort -property length -desc | select-object -first 1 -property directory
echo $a
# $a = dir D:\Users\ryuichi\Documents\GitHub\clisp\landoflisp\20150508 | sort -property length -desc | select-object -first 1 -property file
# echo $a

$a = dir D:\Users\ryuichi\Documents\GitHub\clisp\landoflisp | foreach-object { $_.name }
echo $a

echo ""
$total = 0
dir D:\Users\ryuichi\Documents\GitHub\clisp\landoflisp\20150508 | foreach-object{$total += $_.length}
echo $total

