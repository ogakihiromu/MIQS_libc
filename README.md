# MIQS_libc
MIQSの入出力周りを動作させるためのライブラリ。vivadoでメモリに書き込むための形式として、最終的にバイナリプログラムをテキスト表記に直したcoeファイルを出力する。
## 動作環境
- [riscv_miqs_v1.0](https://github.com/project-hagane/MIQS/tree/master/hw/riscv_miqs_v1.0)・・・プログラムの実行対象プロセッサ
- [RISC-V (32bit)用クロスコンパイラ/アセンブラ環境](http://www.ced.is.utsunomiya-u.ac.jp/lecture/2023/aca/riscv-tools.html)・・・計算機アーキテクチャ特論の授業で配布されている。
- cygwin・・・Windows上にUNIXライクな環境を提供する互換レイヤー。上記のRISC-V (32bit)用クロスコンパイラ/アセンブラ環境を動作させるために必要。
## 構成
- main.c・・・自分で動作させたいプログラム。現在はserial_lib.cの関数を用いて、シリアル通信で"HelloWorld"の文字列を送信するプログラムを記述。
- serial_lib.c・・・UARTでシリアル通信をするためのライブラリ。現在は、送信だけを動作確認した。
- startup.s・・・プログラムの最初に実行されるアセンブリプログラム。mainを呼び出し、mainから復帰したら無限ループをする。
- riscy.ld・・・プログラムやデータの配置を決めるリンカスクリプト。(計算機アーキテクチャ特論
2023年度)[http://www.ced.is.utsunomiya-u.ac.jp/lecture/2023/aca/]で配布されているものを改変
- mk_asm.sh・・・以上のプログラムやリンカスクリプトから実行ファイル、逆アセンブリ結果を生成。
- gen_coe.sh・・・逆アセンブリ結果からcoeファイルを生成。
- Makefile・・・以上のシェルスクリプトを実行するメイクファイル。
## 実行方法
makeと打てば、main.coeが生成される。
## 注意点
- ~~makeで生成されたcoeファイルをそのまま[riscv_miqs_v1.0](https://github.com/project-hagane/MIQS/tree/master/hw/riscv_miqs_v1.0)で実行するとハザードが原因で動作が止まる(詳しくは[こちら](https://github.com/PEARLabo/diary/blob/master/hiromu/202308.md#202384)を参照)。下記の逆アセンブル結果部分のアドレス94番目と98番目をmain.coeで探して、nop命令00000013で上書きしてください。Uart_tx_enableとUart_rx_enableのどちらの関数にも  sw 	x15,-20(x8)とlw	x15,-20(x8)の連続した操作はあるので上書きしてください~~  
~~この動作の停止はいつか直す...。~~  
-O最適化オプションつけてコンパイルしたら無駄なスタック操作がなくなった。もし最適化かけずにserial_lib.cを再コンパイルしたかったら、上記の注意点の通りの操作を行ってください。
```
00000080 <Uart_tx_enable>:
  80:	fe010113          	addi	x2,x2,-32
  84:	00812e23          	sw	x8,28(x2)
  88:	02010413          	addi	x8,x2,32
  8c:	ffff07b7          	lui	x15,0xffff0
  90:	00878793          	addi	x15,x15,8 # ffff0008 <__global_pointer$+0xfffef67c>
  94:	fef42623          	sw	x15,-20(x8)
  98:	fec42783          	lw	x15,-20(x8)
  9c:	0007a783          	lw	x15,0(x15)
  a0:	0027f793          	andi	x15,x15,2
  a4:	00078513          	mv	x10,x15
  a8:	01c12403          	lw	x8,28(x2)
  ac:	02010113          	addi	x2,x2,32
  b0:	00008067          	ret
```