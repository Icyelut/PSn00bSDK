.set noreorder
.section .text

.global rename
.type rename, @function
rename:
	addiu	$t2, $0, 0xb0
	jr		$t2
	addiu	$t1, $0, 0x44
	