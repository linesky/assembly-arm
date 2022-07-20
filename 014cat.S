.text
.global _start
@ as -o my.o 003.S
@ ld -o my my.o
@ ./my
_start:
		ldr r0,_adds
		ldr r1,_adds2
		ldr r3,_strcat
		blx r3
		ldr r0,_adds2
		ldr r3,_puts
		blx r3
	forss:	
_exit:
	mov r7, #1              
	swi #0                  
_lens:
	@ r1=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r0,#0
	mov r3,r1
	lenss:
		ldrb r1,[r3]
		cmp r1,#0
		beq lensss
		add r3,r3,#1
		add r0,r0,#1
		b lenss 
	lensss:
	sub sp,fp,#4
	pop {fp,pc}
_putss:
	@ r0=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r7,r0
	mov r1,r0	
	ldr r3,_len
	blx r3
	mov r2,r0
	mov r0, #1            
	mov r1,r7
	mov r7, #4              
	swi #0                  
	sub sp,fp,#4
	pop {fp,pc}
_putcc:
	@ r0=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r1,r0
	mov r2, #1
	mov r0, #1            
	mov r7, #4              
	swi #0                  
	sub sp,fp,#4
	pop {fp,pc}
	
_strcpys:
	@ r0=string
	@ r1=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r3,r0
	mov r2,r1
	_strcpyss:
		ldrb r1,[r3]
		strb r1,[r2]
		cmp r1,#0
		beq _strcpysss
		add r3,r3,#1
		add r2,r2,#1
		b _strcpyss
	_strcpysss:
	sub sp,fp,#4
	pop {fp,pc}


_intdivs:
	@ r0=number1
	@ r1=number2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r2,#0
	_intdivs2:
		cmp r0,r1
		blt _intdivs3
		sub r0,r0,r1
		add r2,r2,#1
		cmp r0,r1
		bal _intdivs2
	_intdivs3:
	mov r1,r0
	mov r0,r2
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	sub sp,fp,#4
	pop {fp,pc}
_strs:
	@ r0=adds
	@ r1=number
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r3,r0
	mov r4,r1
	ldr r5,_divnn
	_strs2:
		mov r0,r4
		ldr r1,[r5]
		ldr r2,_intdiv
		blx r2
		mov r4,r1
		add r0,r0,#48
		str r0,[r3]
		add r3,r3,#1
		ldr r1,[r5]
		cmp r1,#1
		beq _strs3
		add r5,r5,#4
		bal _strs2
	_strs3:
	mov r0,#0
	str r0,[r3]
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_lcases:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	lcases2:
			ldrb r1,[r0]
			cmp r1,#65
			blt lcases4
			cmp r1,#90
			bgt lcases4
			add r1,r1,#32
			strb r1,[r0]
		lcases4:
		cmp r1,#0
		beq lcases3
		add r0,r0,#1
		bal lcases2
	lcases3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_ucases:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r0}
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	ucases2:
			ldrb r1,[r0]
			cmp r1,#97
			blt ucases4
			cmp r1,#122
			bgt ucases4
			sub r1,r1,#32
			strb r1,[r0]
		ucases4:
		cmp r1,#0
		beq ucases3
		add r0,r0,#1
		bal ucases2
	ucases3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	pop {r0}
	sub sp,fp,#4
	pop {fp,pc}
_strcats:
	@ r0=string
	@ r1=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r7,r0
	mov r5,r1
	ldr r6,_len
	blx r6
	add r1,r5,r0
	mov r0,r7
	ldr r6,_strcpy
	blx r6
	sub sp,fp,#4
	pop {fp,pc}
_strcat:
.word _strcats
_lcase:
.word _lcases
_ucase:
.word _ucases
_divnn:
.word _divn
_divn:
.word 100000000,10000000,1000000,100000,10000,1000,100,10,1
_str:
.word _strs
_intdiv:
.word _intdivs
_strcpy:
.word _strcpys
_puts:
.word _putss 
_putc:
.word _putcc
_len:
.word _lens 
_adds:
.word _string
_adds2:
.word _string2
.data
_string:
.asciz "\033[42;30m\nhello world\n\0"
_string2:
.asciz "\0\0012345678900123456789012345678901234567890012345678901234567890\0"
