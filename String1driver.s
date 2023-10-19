//************************************************************************
//Programmer: Jocelyne Gallardo
//
//Program: RASM3
//
//Purpose: This is a driver for testing and calling the RASM 3 functions.		
//		
//*************************************************************************

	.equ	MAX_BYTES,21
	.data
strEquals1:	.asciz	"String_equals(s1,s3) = "
strEquals2:	.asciz	"String_equals(s1,s1) = "
strEqIgno1:	.asciz	"String_equalsIgnoreCase(s1,s3) = "
strEqIgno2:	.asciz	"String_equalsIgnoreCase(s1,s2) = "
strCopy:	.asciz	"s4 = String_copy(s1)\n"
strS1:		.asciz	"s1 = "
strS4:		.asciz	"s4 = "
strSub1:	.asciz	"String_substring_1(s3,4,14) = "
strSub2:	.asciz	"String_substring_2(s3,7) = "
strChar:	.asciz	"String_charAt(s2,4) = "
strStarts1:	.asciz	"String_startsWith_1(s1,11,\"hat\") = "
strStarts2:	.asciz	"String_startsWith_1(s1,\"Cat\") = "
strEnds:	.asciz	"String_endsWith(s1,\"in the hat.\" = "


szStr1:	.skip	21
szStr2:	.skip	21
szStr3:	.skip	21
szStr4:	.skip	21

iBegin:	.byte	4
iEnd:	.byte	14
iBegin2:.byte	7
iPosition:	.byte	4
szTemp:	.skip	21

szPrefix:	.asciz	"in the hat."
szPrefix2:	.asciz	"the hat."
szSuffix:	.asciz	"in the hat."

szEnter:	.asciz	"Enter a string: "



szTrue:		.asciz	"true"
szFalse:	.asciz	"false"

chLF:	.byte	0xa	//carriage return

	.global _start

	.text
_start:
//Prompt user
	ldr	x0,=szEnter	//x0 points to szEnter
	bl	putstring	//prints string
	ldr	x0,=szStr1	//x0 points to szX
	mov	x1,MAX_BYTES	//x1 gets 21 bytes
	bl	getstring	//get user input	

	ldr	x0,=szEnter	//x0 points to szEnter
	bl	putstring	//prints string
	ldr	x0,=szStr2	//x0 points to szStr2
	mov	x1,MAX_BYTES	//x1 gets 21 bytes
	bl	getstring	//get user input
	

	ldr	x0,=szEnter	//x0 points to szEnter
	bl	putstring	//prints string
	ldr	x0,=szStr3	//x0 points to szStr3
	mov	x1,MAX_BYTES	//x1 gets 21 bytes
	bl	getstring	//get user input

//************************************* Test for String_equals(s1,s3)
test0:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	
	ldr	x0,=strEquals1	//x0 hold address
	bl	putstring	//prints string

	ldr	x0,=szStr1	//x0 hold address
	ldr	x1,=szStr3	//x0 hold address
	bl	String_equals	//compare strings
	
	cmp	x0,#1		//compare
	b.eq printTrue		//jump if equal 1
	
	cmp	x0,#0		//compare
	b.eq printFalse		//jump if equal 0

printTrue:
	ldr	x0,=szTrue	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b test1			//next test
	
printFalse:
	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test1
	
//************************************* Test for String_equals(s1,s1)
test1:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	
	ldr	x0,=strEquals2	//x0 points to
	bl	putstring	//prints string

	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=szStr1	//x0 points to
	bl	String_equals
	
	cmp	x0,#1
	b.eq printTrue1
	
	cmp	x0,#0
	b.eq printFalse1

printTrue1:
	ldr	x0,=szTrue	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b test2
	
printFalse1:
	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test2


//************************************* Test for String_equalsIgnoreCase(s1,s3)
test2:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strEqIgno1	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=szStr3	//x0 points to
	bl	String_equalsIgnoreCase

	cmp	x0,#1
	b.eq printTrue2

	cmp	x0,#0
	b.eq printFalse2

printTrue2:

	ldr	x0,=szTrue	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b test3

printFalse2:

	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test3
	
//************************************* Test for String_equalsIgnoreCase(s1,s2)
test3:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strEqIgno2	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=szStr2	//x0 points to
	bl	String_equalsIgnoreCase

	cmp	x0,#1
	b.eq printTrue3

	cmp	x0,#0
	b.eq printFalse3

printTrue3:

	ldr	x0,=szTrue	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b test4

printFalse3:

	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test4


//************************************* Test for String_copy(s1)
test4:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strCopy	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=strS1	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=szStr1	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strS4	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=szStr1	//x0 points to
	bl	String_copy
	
	ldr	x1,=szStr4	//x0 points to
	str x0,[x1]
	
	ldr	x0,=szStr4	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
		
//************************************* Test for String_substring_1
test7:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strSub1	//x0 points to
	bl	putstring	//prints string
	
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=iBegin	//x0 points to
	ldr	x2,=iEnd	//x0 points to
	bl	String_substring_1
	
	ldr	x1,=szStr4	//x0 points to
	str x0,[x1]
	
	ldr	x0,=szStr4	//x0 points to
	bl	putstring	//prints string
	
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
//************************************* Test for String_substring_2
test8:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strSub2	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=iBegin2	//x0 points to
	bl	String_substring_2
	
	ldr	x1,=szStr4	//x0 points to
	str x0,[x1]
	
	ldr	x0,=szStr4	//x0 points to
	bl	putstring	//prints string

	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
//************************************* Test for String_charAt
test9:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strChar	//x0 points to
	bl	putstring	//prints string
	
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=iPosition	//x0 points to
	bl	String_charAt
	
	ldr	x1,=szTemp	//x0 points to
	bl	int64asc
	
	ldr	x0,=szTemp	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return

//************************************* Test for String_startsWith_1
test10:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strStarts1	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=szPrefix	//x0 points to
	ldr	x2,=iPosition	//x0 points to
	bl	String_startsWith_1

	cmp	x0,#0
	b.eq	printFalse10

	cmp	x0,#1
	b.eq	printTrue10


printTrue10:
	ldr	x0,=szTrue	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b 	test11
	
printFalse10:
	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test11
	

//************************************* Test for String_startsWith_2
test11:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strStarts2	//x0 points to
	bl	putstring
	
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=szPrefix2	//x0 points to

	bl	String_startsWith_2

	cmp	x0,#0
	b.eq	printFalse11

	cmp	x0,#1
	b.eq	printTrue11


printTrue11:
	ldr	x0,=szTrue	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b 	test12
	
printFalse11:
	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	test12

//************************************* Test for String_endsWith(s1,"in the hat")
test12:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strEnds	//x0 points to
	bl	putstring	//prints string
	
	ldr	x0,=szStr1	//x0 points to
	ldr	x1,=szSuffix	//x0 points to
	bl	String_endsWith
	
	cmp	x0,#0
	b.eq	printFalse12

	cmp	x0,#1
	b.eq	printTrue12
	
printTrue12:	
	ldr	x0,=szTrue	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b 	end
	
printFalse12:
	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	end
	
end:	
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return



//Set up the parameters to exit the program and then call linux to do it
	mov	x0,#0		//Use 0 return code
	mov	x8,#93		//Service code 93 terminates
	svc	0		//Call Linux to terminate

	.end
