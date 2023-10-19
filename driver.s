//Program: RASM3
//
//Purpose: This is a driver for testing and calling the RASM 3 functions.
//		
//		
//*************************************************************************//


	.data
szString1:	.asciz	"Cat in the hat."
szString2:	.asciz	"Cat in the hat."
szString3:	.skip	50
iBegin:	.byte	2
iEnd:	.byte	7
iPosition:	.byte	5
szTemp:	.skip	21
szPrefix:	.asciz	"in"
szPrefix2:	.asciz	"Ca"

szTrue:		.asciz	"true"
szFalse:	.asciz	"false"

chLF:	.byte	0xa	//carriage return

	.global _start

	.text
_start:
//************************************* Test for String_equals

	ldr	x0,=szString1
	ldr	x1,=szString2
	bl	String_equals
		

	cmp	x0,#1
	b.eq printTrue
	
	cmp	x0,#0
	b.eq printFalse

printTrue:
	ldr	x0,=szTrue
	bl	putstring
		ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b test2
	
printFalse:
	ldr	x0,=szFalse
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test2



//************************************* Test for String_equalsIgnoreCase
test2:
	ldr	x0,=szString1
	ldr	x1,=szString2
	bl	String_equalsIgnoreCase

	cmp	x0,#1
	b.eq printTrue1
	
	cmp	x0,#0
	b.eq printFalse1
	
printTrue1:
	ldr	x0,=szTrue
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b test3
	
printFalse1:
	ldr	x0,=szFalse
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test3
	
//************************************* Test for String_copy
test3:
	ldr	x0,=szString1
	bl	String_copy
	
	ldr	x1,=szString3
	str x0,[x1]
	ldr	x0,=szString3
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
		
//************************************* Test for String_substring_1
//test4:
	//ldr	x0,=szString1
	//ldr	x1,=iBegin
	//ldr	x2,=iEnd
	//bl	String_substring_1
	
//************************************* Test for String_charAt
test5:
	ldr	x0,=szString1
	ldr	x1,=iPosition
	bl	String_charAt
	
	ldr	x1,=szTemp
	bl	int64asc
	
	ldr	x0,=szTemp
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return

//************************************* Test for String_startsWith_1
test6:
	ldr	x0,=szString1
	ldr	x1,=szPrefix
	ldr	x2,=iPosition
	bl	String_startsWith_1

	cmp	x0,#0
	b.eq	printFalse2

	cmp	x0,#1
	b.eq	printTrue2


printTrue2:
	ldr	x0,=szTrue
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b 	test7
	
printFalse2:
	ldr	x0,=szFalse
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test7
	

//************************************* Test for String_startsWith_2
test7:
	ldr	x0,=szString1
	ldr	x1,=szPrefix2

	bl	String_startsWith_2

	cmp	x0,#0
	b.eq	printFalse3

	cmp	x0,#1
	b.eq	printTrue3


printTrue3:
	ldr	x0,=szTrue
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b 	test7
	
printFalse3:
	ldr	x0,=szFalse
	bl	putstring
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test8


test8:

end:	
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return



//Set up the parameters to exit the program and then call linux to do it
	mov	x0,#0		//Use 0 return code
	mov	x8,#93		//Service code 93 terminates
	svc	0		//Call Linux to terminate

	.end
