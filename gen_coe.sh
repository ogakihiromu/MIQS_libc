#!/bin/bash

cat $1.asm |\
awk '/./' |\
#空白行削除
sed '/^[^ ]/d' |\
#行頭に空白文字が含まれない行は削除
awk '{print $2}' |\
#バイナリを抽出
sed -e '1s/^/memory_initialization_vector=\n/' |\
# 行の最初に特定文字列挿入
sed -e '1s/^/memory_initialization_radix=16;\n/' |\
# 行の最初に特定文字列挿入
sed -e '$a ;' > $1.coe
# 最後の行に;を挿入