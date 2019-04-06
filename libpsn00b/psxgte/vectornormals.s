.set noreorder
.set noat

.include "gtereg.h"
.include "inline_s.h"

.section .text


.global VectorNormalS
.type VectorNormalS, @function
VectorNormalS:
	
	# Implementation ripped from Sony libs
	
	lw		$t0, 0($a0)
	lw		$t1, 4($a0)
	lw		$t2, 8($a0)
	
	mtc2	$t0, C2_IR1
	mtc2	$t1, C2_IR2
	mtc2	$t2, C2_IR3
	
	nSQR(0)
	
	mfc2	$t3, C2_MAC1
	mfc2	$t4, C2_MAC2
	mfc2	$t5, C2_MAC3
	
	add		$t3, $t4
	add		$v0, $t3, $t5
	mtc2	$v0, C2_LZCS
	nop
	nop
	mfc2	$v1, C2_LZCR
	
	addiu	$at, $0 , -2
	and		$v1, $at
	
	addiu	$t6, $0 , 0x1f
	sub		$t6, $v1
	sra		$t6, 1
	addiu	$t3, $v1, -24
	
	bltz	$t3, $value_neg
	nop
	b		$value_pos
	sllv	$t4, $v0, $t3
$value_neg:
	addiu	$t3, $0 , 24
	sub		$t3, $v1
	srav	$t4, $v0, $t3
$value_pos:
	addi	$t4, -64
	sll		$t4, 1
	
	la		$t5, _norm_table
	addu	$t5, $t4
	lh		$t5, 0($t5)
	nop
	
	mtc2	$t5, C2_IR0
	mtc2	$t0, C2_IR1
	mtc2	$t1, C2_IR2
	mtc2	$t2, C2_IR3
	
	nGPF(0)
	
	mfc2	$t0, C2_MAC1
	mfc2	$t1, C2_MAC2
	mfc2	$t2, C2_MAC3
	
	sra		$t0, $t6
	sra		$t1, $t6
	sra		$t2, $t6
	
	sh		$t0, 0($a1)
	sh		$t1, 2($a1)
	jr		$ra
	sh		$t2, 4($a1)


.section .data

_norm_table:
	.hword	0x1000, 0x0FE0, 0x0FC1, 0x0FA3, 0x0F85, 0x0F68, 0x0F4C, 0x0F30
	.hword	0x0F15, 0x0EFB, 0x0EE1, 0x0EC7, 0x0EAE, 0x0E96, 0x0E7E, 0x0E66
	.hword	0x0E4F, 0x0E38, 0x0E22, 0x0E0C, 0x0DF7, 0x0DE2, 0x0DCD, 0x0DB9
	.hword	0x0DA5, 0x0D91, 0x0D7E, 0x0D6B, 0x0D58, 0x0D45, 0x0D33, 0x0D21
	.hword	0x0D10, 0x0CFF, 0x0CEE, 0x0CDD, 0x0CCC, 0x0CBC, 0x0CAC, 0x0C9C
	.hword	0x0C8D, 0x0C7D, 0x0C6E, 0x0C5F, 0x0C51, 0x0C42, 0x0C34, 0x0C26
	.hword	0x0C18, 0x0C0A, 0x0BFD, 0x0BEF, 0x0BE2, 0x0BD5, 0x0BC8, 0x0BBB
	.hword	0x0BAF, 0x0BA2, 0x0B96, 0x0B8A, 0x0B7E, 0x0B72, 0x0B67, 0x0B5B
	.hword	0x0B50, 0x0B45, 0x0B39, 0x0B2E, 0x0B24, 0x0B19, 0x0B0E, 0x0B04
	.hword	0x0AF9, 0x0AEF, 0x0AE5, 0x0ADB, 0x0AD1, 0x0AC7, 0x0ABD, 0x0AB4
	.hword	0x0AAA, 0x0AA1, 0x0A97, 0x0A8E, 0x0A85, 0x0A7C, 0x0A73, 0x0A6A
	.hword	0x0A61, 0x0A59, 0x0A50, 0x0A47, 0x0A3F, 0x0A37, 0x0A2E, 0x0A26
	.hword	0x0A1E, 0x0A16, 0x0A0E, 0x0A06, 0x09FE, 0x09F6, 0x09EF, 0x09E7
	.hword	0x09E0, 0x09D8, 0x09D1, 0x09C9, 0x09C2, 0x09BB, 0x09B4, 0x09AD
	.hword	0x09A5, 0x099E, 0x0998, 0x0991, 0x098A, 0x0983, 0x097C, 0x0976
	.hword	0x096F, 0x0969, 0x0962, 0x095C, 0x0955, 0x094F, 0x0949, 0x0943
	.hword	0x093C, 0x0936, 0x0930, 0x092A, 0x0924, 0x091E, 0x0918, 0x0912
	.hword	0x090D, 0x0907, 0x0901, 0x08FB, 0x08F6, 0x08F0, 0x08EB, 0x08E5
	.hword	0x08E0, 0x08DA, 0x08D5, 0x08CF, 0x08CA, 0x08C5, 0x08BF, 0x08BA
	.hword	0x08B5, 0x08B0, 0x08AB, 0x08A6, 0x08A1, 0x089C, 0x0897, 0x0892
	.hword	0x088D, 0x0888, 0x0883, 0x087E, 0x087A, 0x0875, 0x0870, 0x086B
	.hword	0x0867, 0x0862, 0x085E, 0x0859, 0x0855, 0x0850, 0x084C, 0x0847
	.hword	0x0843, 0x083E, 0x083A, 0x0836, 0x0831, 0x082D, 0x0829, 0x0824
	.hword	0x0820, 0x081C, 0x0818, 0x0814, 0x0810, 0x080C, 0x0808, 0x0804
	