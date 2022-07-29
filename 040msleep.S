.text
.global _start
@ as -o my.o 003.S
@ ld -o my my.o
@ ./my
_start:
	fors:
		ldr r0,_adds
		ldr r7,_printf
		blx r7
		
		ldr r0,_second
		mov r6,#10
		mul r7,r0,r6
		mov r0,r7
		ldr r7,_msleep
		blx r7

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
_strcpy:
.word _strcpys
_puts:
.word _putss 
_putc:
.word _putcc
_len:
.word _lens 
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
_fills:
	@ r1=string
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	mov r3,r0
	fillss:
		strb r1,[r3]
		add r3,r3,#1
		sub r2,r2,#1
		cmp r2,#0
		bne fillss
	fillsss:
	sub sp,fp,#4
	pop {fp,pc}
_findchars:
	@ r0=adds
	@ r1=chr
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r3,#0
	_findchars2:
		ldrb r4,[r0]
		cmp r4,r1
		bne _findchars4
		mov r0,r3
		b _findchars3
		_findchars4:
		cmp r4,#0
		beq _findchars5
		add r0,r0,#1
		add r3,r3,#1
		b _findchars2
		_findchars5:
		mov r0,#0
		sub r0,r0,#1
	_findchars3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_comps:
	@ r0=string1
	@ r1=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	_comps2:
		ldrb r3,[r0]
		ldrb r4,[r1]
		add r0,r0,#1
		add r1,r1,#1
		cmp r4,#0
		beq _comps4
		cmp r3,r4
		beq _comps2
		mov r0,#0
		sub r0,r0,#1
		b _comps3
		_comps4:
		mov r0,#0
	_comps3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_findstrs:
	@ r0=adds
	@ r1=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7,#0
	mov r3,r0
	mov r4,r1
	mov r6,#0
	sub r6,r6,#1
	_findstrs2:
		ldrb r1,[r4]
		ldr r5,_findchar
		blx r5
		cmp r0,r6
		beq _findstrs6
		add r3,r3,r0
		add r7,r7,r0
		mov r0,r3
		mov r1,r4
		ldr r5,_comp
		blx r5
		cmp r0,#0
		beq _findstrs7
		add r3,r3,#1
		mov r0,r3
		add r7,r7,#1
		b _findstrs2
		_findstrs6:
		mov r0,r6
		b _findstrs3
		_findstrs7:
		mov r0,r7
		b _findstrs3
	_findstrs3:
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
getkeys:
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
	mov r1,r0
	mov r0,#0
	mov r2,#1
	mov r7, #3              
	swi #0                  
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
_mkdirs:
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
	mov r7, #39              
	swi #0                  
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
_creates:
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
	mov r7, #8
	swi #0                  
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
_opens:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	mov r7, #5
	swi #0                  
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_closes:
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
	mov r7, #6
	swi #0                  
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
_writes:
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
	mov r7, #4
	swi #0                  
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
_reads:
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
	mov r7, #3
	swi #0                  
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
_renames:
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
	mov r7, #38
	swi #0                  
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
_chmodes:
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
	mov r7, #15
	swi #0                  
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
_chdirs:
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
	mov r7, #12
	swi #0                  
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
_getcwds:
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
	mov r7, #183
	swi #0                  
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
_execs:
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
	mov r7, #11
	swi #0                  
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
@ keyword
_second:
.word 1000000
_rnd:
.word _rnds
_starts:
.word _lens
_randomize:
.word _randomizes
_addso0:
.word _string
_addso:
.word _string2
_atoii:
.word _atois
_printff:
.word _printfs
_memncpy:
.word _memncpys
_getn:
.word _getns
_atoi:
.word _atois
_printffunc:
.word _printffuncs
_printfss:
.word _printfsss
_printf:
.word _printfs
_colorR:
.word _colorRs
_gotoR:
.word _gotoRs
_exec:
.word _execs
_getcwd:
.word _getcwds
_chdir:
.word _chdirs
_chmode:
.word _chmodes
_rename:
.word _renames
_read:
.word _reads
_write:
.word _writes
_close:
.word _closes
_open:
.word _opens
_create:
.word _creates
_mkdir:
.word _mkdirs
_getkey:
.word getkeys
_findstr:
.word _findstrs
_comp:
.word _comps
_findchar:
.word _findchars
_fill:
.word _fills
_strcat:
.word _strcats
_lcase:
.word _lcases
_ucase:
.word _ucases
_divnnn:
.word _divnnnn
_divnn:
.word _divn
_divn:
.word 100000000,10000000,1000000,100000,10000,1000,100,10,1
_str:
.word _strs
_intdiv:
.word _intdivs
_addsss:
.word _data1
_adds:
.word _string
_adds2:
.word _string2
_adds3:
.word _string3
_adds4:
.word _string4
_adds5:
.word _string5
_adds6:
.word _string6
_filesp:
.word 511
_filesp2:
.word 0
_tables:
.word 32
_memorys:
.word 16
_cols:
.word 4
_gotohead:
.word _gotoheads
_goton:
.word _gotons
_gotop:
.word _gotops
_gotoll:
.word _gotols
_gotollll:
.word _gotolls
_plist:
.word _plists
_list:
.word _lists
_sleep:
.word _sleeps
_leep:
.word 16777215
_msleep:
.word _msleeps
_gotoRs:
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
	mov r6,r0
	mov r5,r1
	ldr r0,_goton
	mov r1,r6
	push {r5}
	push {r6}
	ldr r7,_str
	blx r7
	pop {r6}
	pop {r5}	
	ldr r1,_gotohead
	ldr r0,_goton
	add r0,r0,#7
	add r1,r1,#2
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	ldr r0,_gotop
	ldr r1,_gotohead
	add r1,#4
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	mov r1,r5
	ldr r0,_goton
	push {r5}
	push {r6}
	ldr r7,_str
	blx r7
	pop {r6}
	pop {r5}	
	ldr r1,_gotohead
	ldr r0,_goton
	add r0,r0,#7
	add r1,r1,#5
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	ldr r0,_gotoll
	ldr r1,_gotohead
	add r1,#7
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	
	ldr r0,_gotohead
	ldr r7,_puts
	blx r7
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
_colorRs:
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
	mov r6,r0
	add r6,r6,#30
	mov r5,r1
	add r5,r5,#40
	ldr r0,_goton
	mov r1,r6
	push {r5}
	push {r6}
	ldr r7,_str
	blx r7
	pop {r6}
	pop {r5}	
	ldr r1,_gotohead
	ldr r0,_goton
	add r0,r0,#7
	add r1,r1,#2
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	ldr r0,_gotop
	ldr r1,_gotohead
	add r1,#4
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	mov r1,r5
	ldr r0,_goton
	push {r5}
	push {r6}
	ldr r7,_str
	blx r7
	pop {r6}
	pop {r5}	
	ldr r1,_gotohead
	ldr r0,_goton
	add r0,r0,#7
	add r1,r1,#5
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	ldr r0,_gotollll
	ldr r1,_gotohead
	add r1,#7
	push {r5}
	push {r6}
	ldr r7,_strcpy
	blx r7
	pop {r6}
	pop {r5}	
	
	ldr r0,_gotohead
	ldr r7,_puts
	blx r7
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
_printfs:
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
	mov r6,#1
	_printfs2:
		ldrb r7,[r0]
		cmp r7,#0
		beq _printfs3
		cmp r7,#37
		bne _printfs4
		add r0,r0,#1
		ldrb r7,[r0]
		cmp r7,#0
		beq _printfs3
		cmp r7,#37
		beq _printfs4
		ldr r7,_printfss
		blx r7
		add r6,r6,#1
		b _printfs33
		_printfs4:
		push {r0}
		push {r1}
		push {r2}
		push {r3}
		push {r4}
		push {r5}
		push {r6}
		push {r7}
		ldr r7,_putc
		blx r7
		pop {r7}
		pop {r6}
		pop {r5}
		pop {r4}
		pop {r3}
		pop {r2}
		pop {r1}
		pop {r0}
		_printfs33:
		add r0,r0,#1
		ldrb r7,[r0]
		cmp r7,#0
		bne _printfs2
	_printfs3:
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
_printfsss:
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
	cmp r6,#1
	bne _printfsss2
	ldr r7,_printffunc
	blx r7
	b _printfsss6
	_printfsss2:
	cmp r6,#2
	bne _printfsss3
	mov r1,r2
	ldr r7,_printffunc
	blx r7
	b _printfsss6
	_printfsss3:
	cmp r6,#3
	bne _printfsss4
	mov r1,r3
	ldr r7,_printffunc
	blx r7
	b _printfsss6
	_printfsss4:
	cmp r6,#4
	bne _printfsss5
	mov r1,r4
	ldr r7,_printffunc
	blx r7
	b _printfsss6
	_printfsss5:
	cmp r6,#5
	bne _printfsss6
	mov r1,r5
	ldr r7,_printffunc
	blx r7
	_printfsss6:
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
_printffuncs:
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
		ldrb r7,[r0]
		cmp r7,#99
		bne _printffuncs2
		ldr r7,_goton
		str r1,[r7]
		ldr r0,_goton
		ldr r7,_putc
		blx r7
		b _printffuncs22
	_printffuncs2:
		ldrb r7,[r0]
		cmp r7,#100
		bne _printffuncs3
		ldr r0,_goton
		ldr r7,_str
		blx r7
		ldr r0,_goton
		mov r6,#8
		_printffuncs27:
		b _printffuncs29
		_printffuncs28:
		add r0,r0,#1
		sub r6,r6,#1
		cmp r6,#0
		beq _printffuncs25
		_printffuncs29:
		ldrb r7,[r0]
		cmp r7,#48
		beq _printffuncs28
		_printffuncs25:
		ldr r7,_puts
		blx r7
		_printffuncs24:
		b _printffuncs22
	_printffuncs3:
		ldrb r7,[r0]
		cmp r7,#115
		bne _printffuncs4
		mov r0,r1
		ldr r7,_puts
		blx r7
	_printffuncs4:
	_printffuncs22:
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
_atois:
	@ r0=adds
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
		ldr r7,_getn
		blx r7
		ldr r1,_goton
		ldr r7,_len
		blx r7
		mov r6,r0
		ldr r0,_goton
		add r0,r0,r6
		sub r0,r0,#1
		@sub r6,r6,#1
		mov r1,#1
		mov r2,#10
		mov r3,#0
		b _atois3
		_atois2:
			mul r7,r2,r1
			mov r1,r7
			sub r0,r0,#1
		_atois3:
			ldrb r7,[r0]
			sub r7,r7,#48
			mul r4,r7,r1
			add r3,r3,r4
			sub r6,r6,#1
			cmp r6,#0
			bne _atois2
	mov r0,r3
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_getns:
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
	b _getns3
	_getns2:
		add r0,r0,#1
	_getns3:
		ldrb r7,[r0]
		cmp r7,#0
		beq _getns8
		cmp r7,#32
		beq _getns2
	_getns8:
		ldr r1,_goton
		mov r2,#9
		ldr r7,_memncpy
		blx r7
		ldr r1,_goton
		add r1,r1,#9
		mov r2,#0
		str r2,[r1]
		ldr r0,_goton
		b _getns13
	_getns12:
		add r0,r0,#1
	_getns13:
		ldrb r7,[r0]
		cmp r7,#0
		beq _getns18
		cmp r7,#48
		blt _getns122
		cmp r7,#59
		blt _getns12
	_getns122:
		mov r7,#0
		str r7,[r0]
	_getns18:
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
_memncpys:
	@ r0=string
	@ r1=string2
	@ r2=string2
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
	_memncpyss:
		ldrb r1,[r3]
		strb r1,[r4]
		add r3,r3,#1
		add r4,r4,#1
		sub r2,r2,#1
		cmp r2,#0
		bne _memncpyss
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
_date1:
.word _dates1
_date2:
.word _dates2
_rand:
.word _rands
_randff:
.word _fileff
_randomizes:
	@ r0=string
	@ r1=string2
	@ r2=string2
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
	ldr r0,_date1
	ldr r1,_date2
	mov r7,#78
	swi 0
	ldr r1,_date1
	ldr r0,[r1]
	add r0,r0,#8
	and r0,r0,#255
	ldr r1,_starts
	add r1,r1,r0
	ldr r0,_rand
	str r1,[r0]
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
_rnds:
	@ r0=string
	@ r1=string2
	@ r2=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
	ldr r1,_rand
	ldr r0,[r1]
	add r0,r0,#4
	str r0,[r1]	
	ldr r1,[r0]
	mov r4,r1
	ldr r0,_randff
	cmp r4,r0
	blt _rnds2
	ldr r1,_rand
	ldr r0,_starts
	add r0,r0,#4
	str r0,[r1]	
	_rnds2:
	mov r0,r4
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_plists:
	@ r0=string
	@ r1=string2
	@ r2=string2
	push {fp,lr}
	add fp,sp,#4
	sub sp,sp,#16
	push {r1}
	push {r2}
	push {r3}
	push {r4}
	push {r5}
	push {r6}
	push {r7}
		mov r6,r1
		mov r5,r0 
		b _plists3
		_plists2:
			add r5,r5,#4
		_plists3:
			ldr r1,[r5]
			ldr r0,_list
			ldr r7,_printf
			blx r7
			sub r6,r6,#1
			cmp r6,#0
			bne _plists2
	pop {r7}
	pop {r6}
	pop {r5}
	pop {r4}
	pop {r3}
	pop {r2}
	pop {r1}
	sub sp,fp,#4
	pop {fp,pc}
_sleeps:
	@ r0=string
	@ r1=string2
	@ r2=string2
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
	mov r6,r0
	push {r6}
	ldr r0,_date1
	ldr r1,_date2
	mov r7,#78
	swi 0
	ldr r1,_date1
	ldr r5,[r1]
	pop {r6}
		b _sleeps3
		_sleeps2:
		_sleeps3:
				push {r5}
				push {r6}
				ldr r0,_date1
				ldr r1,_date2
				mov r7,#78
				swi 0
				ldr r1,_date1
				ldr r4,[r1]
				pop {r6}
				pop {r5}
				sub r4,r4,r5
				and r4,r4,#255
				cmp r4,r6
				blt _sleeps2
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
_msleeps:
	@ r0=string
	@ r1=string2
	@ r2=string2
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
	mov r6,r0
	push {r6}
	ldr r0,_date1
	ldr r1,_date2
	mov r7,#78
	swi 0
	ldr r1,_date1
	add r1,r1,#4
	ldr r5,[r1]
	pop {r6}
		b _msleeps3
		_msleeps2:
		_msleeps3:
				push {r5}
				push {r6}
				ldr r0,_date1
				ldr r1,_date2
				mov r7,#78
				swi 0
				ldr r1,_date1
				add r1,r1,#4
				ldr r4,[r1]
				pop {r6}
				pop {r5}
				sub r4,r4,r5
				ldr r7,_leep
				and r4,r4,r7
				cmp r4,r6
				blt _msleeps2
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
.data
_rands:
.word 0
_lists:
.asciz "\033[42;30m%d\n\0\0--------------------------------\0ggg"
_gotoheads:
.asciz "\033[\0\0----------------\n\n\n\0\0--------------------------------\0"
_gotons:
.asciz "\n\n\n\0\0--------------------------------\0"
_gotops:
.asciz ";\0\0--------------------------------\0"
_gotols:
.asciz "f\0\0--------------------------------\0"
_gotolls:
.asciz "m\0\0--------------------------------\0"
_string:
.asciz "\033[42;30m\nwait\n\0\0--------------------------------\0ggg"
_string2:
.asciz "       012345!678          \n\0\0--------------------------------\0"
_string3:
.asciz "|\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0"
_string4:
.asciz "\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0"
_string5:
.asciz "\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0"
_string6:
.asciz "\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0\0--------------------------------\0"
_divnnnn:
.word 1,2,10,20,30,100,200,300,400,500,12345,800,900,6777,1233,16
_dates1:
.SPACE 32
_dates2:
.SPACE 32
_data1:
.SPACE 100000
_fileff:
