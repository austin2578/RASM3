//************************************************************************
//Program: String_equals
//
//Purpose: his method makes an exact comparison of individual characters in two strings. 
//If any character in the string in a position is different than the character in the same 
//position in the other string, the method returns “false” (0 in the R0 register).
//If the length of the two strings is different, the method also returns “false”. Note that
// ‘e’ is NOT the same as ‘E’. Otherwise “true” (1) is returned. 
//The value is returned in the R0 register
//
//*************************************************************************

.data
str1:	.skip	50
str2:	.skip	50

	.global String_equals
	.text
	
String_equals:
	STR	LR, [SP,#-16]!		// PUSH LR

	// x0 holds string1
	// x1 holds string2

	ldr	x2, =str1
	STR	x0, [x2]

	ldr	x3, =str2
	STR	x1, [x3]

	ldr	x0, =str1
	bl	String_length
	mov	x4, x0

	ldr	x0, =str2
	bl	String_length
	mov	x5, x0

	cmp	x4, x5
	b.ne	false1

	// Continue
	ldr	x0, =str1
	ldr	x1, =str2

compareLoop1:
	ldrb	w3, [x0], #1
	ldrb	w4, [x1], #1

	cmp	w3, #0
	b.eq	true1

	cmp	w3, w4
	b.ne	false1

	b	compareLoop1

true1:
	mov	x0, #1
	b	exit1

false1:
	mov	x0, #0
	b	exit1

exit1:
	LDR LR, [SP], #16	// POP LR
	ret

	.end
	

//************************************************************************
//Program: String_equalsIgnoreCase
//
//Purpose: This method makes a comparison of individual characters in two strings ignoring case.
//If any character in the string in a position is different than the character in the same 
//position in the other string, the method returns “false” (0 in the R0 register). If the length
//of the two strings is different, the method also returns “false”. Note that ‘e’ is the SAME as 
//‘E’. The value returned is in the R0 register.
//		
//*************************************************************************


	.global String_equalsIgnoreCase
	.text

String_equalsIgnoreCase:

	STR	LR, [SP,#-16]!		//PUSH LR

	//x0 holds string1
	//x1 holds string2

	ldr	x2,=str1
	STR	x0,[x2]

	ldr	x3,=str2
	STR	x1,[x3]

	ldr	x0,=str1
	bl	String_length
	mov	x4,x0


	ldr	x0,=str2
	bl	String_length
	mov	x5,x0

	cmp	x4,x5
	b.ne	false2

//continue
	ldr	x0,=str1
	ldr	x1,=str2
	
	ldrb	w3,[x0]
	add	x0,x0,#1

	ldrb	w4,[x1]
	add	x1,x1,#1
	
compareLoop2:
	cmp	w3,#0
	b.eq	exit2

	ldrb	w3,[x0]
	add	x0,x0,#1

	ldrb	w4,[x1]
	add	x1,x1,#1

	cmp	w3,w4
	b.ne	false2
	
	b	compareLoop2
true2:
	mov	x0,#1
	b	exit2

false2:
	sub	x5,x3,x4
	cmp	x5,#20
	b.eq	true2

	cmp	x5,#-20
	b.eq	true2

	mov	x0,#0
	b	exit2

exit2:
	LDR LR,[SP],#16		//POP LR
	ret


//************************************************************************
//Program: String_copy
//
//Purpose: This method accepts a string to copy, allocates dynamically enough storage 
//to hold a copy of the new characters, copies the characters and returns the address 
//of that newly created string. You will need to CALL the alloc method, the UML
//for which is below. I have written this method: you only have to PROTOtype it and CALL i
//
//*************************************************************************



	.global String_copy
	.text

String_copy:

	STR	LR, [SP,#-16]!		//PUSH LR

	//x0 holds string1
	ldr	x1,=str1	//x1 points to str1
	STR	x0,[x1]		//x0 is stored in str1
	
	ldr	x0,=str1	//xo points to str1
	bl	String_length	//get string length
	
	//x0 holds the number of bytes needed
	BL	malloc		//Memory allocated and address is returned in X0

	LDR	x1,=ptrStr	//x1 points to ptrString
	str	x0,[x1]		//Store the memory address from x0 into ptrString


	LDR	x2,=str1	//x2 points to str1

copyLoop:

	ldrb	w3, [x2]	//load one byte (character) into w3
	add	x2, x2, #1	//increment source address by 1

//Check for null terminating character (0)
	cmp	w3,#0		//Compare w3 to 0
	b.eq	exit		//jump if w3 is equal to 0

//Store the character into the ptrString allocated memory
	strb 	w3, [x0]	//store one byte into the address of ptrString
	add	x0, x0, #1	//increment destination address by 1
	b copyLoop		//branch to copyLoop


	
exit:
	ldr	x0,=ptrStr
	ldr	x0,[x0]
	LDR LR,[SP],#16		//POP LR
	ret



//************************************************************************
//Program: String_substring_1
//
//Purpose: This method creates a new string consisting of characters from 
//a substring of the passed string starting with beginIndex and ending 
//with endIndex
//************************************************************************


	.global String_substring_1
	.text

String_substring_1:

	STR	LR, [SP,#-16]!		//PUSH LR
	
	//x0 holds string
	//x1 holds beginIndex
	//x2 holds endIndex
	
	ldr	x1,=str1	
	STR	x0,[x1]
	
	
	//x0 holds the number of bytes needed
	mov	x0,#16
	BL	malloc		//Memory allocated and address is returned in X0

	LDR	x1,=ptrStr	//x1 points to ptrString
	str	x0,[x1]		//Store the memory address from x0 into ptrString


	LDR	x2,=str1		//x2 points to str1

copyLoop2:

	ldrb	w3, [x2]	//load one byte (character) into w3
	add	x2, x2, #1	//increment source address by 1

//Check for null terminating character (0)
	cmp	w3,#0		//Compare w3 to 0
	b.eq	exit_copy	//jump if w3 is equal to 0

//Store the character into the ptrString allocated memory
	strb 	w3, [x0]	//store one byte into the address of ptrString
	add	x0, x0, #1	//increment destination address by 1
	b copyLoop2		//branch to copyLoop


	
exit_copy:
	ldr	x0,=ptrStr
	ldr	x0,[x0]
	LDR LR,[SP],#16		//POP LR
	ret


//************************************************************************
//Program: String_substring_2
//
//Purpose: This method creates a new string consisting of characters from 
//a substring of the passed string starting with beginIndex and ending 
//with endIndex
//************************************************************************



	.global String_substring_2
	.text

String_substring_2:

	STR	LR, [SP,#-16]!		//PUSH LR
	
	//x0 holds string
	//x1 holds beginIndex
	//x2 holds endIndex
	
	ldr	x1,=str1	
	STR	x0,[x1]
	
	
	//x0 holds the number of bytes needed
	mov	x0,#16
	BL	malloc		//Memory allocated and address is returned in X0

	LDR	x1,=ptrStr	//x1 points to ptrString
	str	x0,[x1]		//Store the memory address from x0 into ptrString


	LDR	x2,=str1		//x2 points to str1

copyLoop3:

	ldrb	w3, [x2]	//load one byte (character) into w3
	add	x2, x2, #1	//increment source address by 1

//Check for null terminating character (0)
	cmp	w3,#0		//Compare w3 to 0
	b.eq	exit2	//jump if w3 is equal to 0

//Store the character into the ptrString allocated memory
	strb 	w3, [x0]	//store one byte into the address of ptrString
	add	x0, x0, #1	//increment destination address by 1
	b copyLoop3		//branch to copyLoop


	
exit3:
	ldr	x0,=ptrStr
	ldr	x0,[x0]
	LDR LR,[SP],#16		//POP LR
	ret



//************************************************************************
//Program: String_charAt
//
//Purpose: This method returns the character in the indicated position.
//If the request is impossible to fulfill, the method returns 0
//
//*************************************************************************


	.global String_charAt
	.text

String_charAt:

	STR	LR, [SP,#-16]!		//PUSH LR

	//x0 holds string1
	//x1 holds string2

	ldr	x2,=str1
	STR	x0,[x2]

	ldr	x3,=iPos
	STR	x1,[x3]

	ldr	x0,=str1
	bl	String_length
	
	//x0 holds String length
	
	ldr	x1,=iPos
	ldr	x1,[x1]
	
	cmp	x1,x0
	b.gt	impossible
	
	add	x0,x0,x1
	ldrb	w4,[x0]
	cmp	w4,#0
	b.eq	impossible
	
	mov	w0,w4
	b	exit4
	
impossible:
	mov	x0,#0
	b exit4
	
exit4:
	LDR LR,[SP],#16		//POP LR
	ret



//************************************************************************
//Program: String_startsWith_1.s
//
//Purpose: It checks whether the substring (starting from the specified offset index)
//exists within string1. For example testing the string “George Washington” for the 
//prefix “Wash” starting in position 7 would return “true” (1) otherwise, it
//would return false (0) would have is having the specified prefix or not
//
//*************************************************************************


	.global String_startsWith_1
	.text

String_startsWith_1:

	STR	LR, [SP,#-16]!		//PUSH LR

	//x0 holds string1
	//x1 holds stringPrefix
	//x2 holds indexPosition

	ldr	x3,=str1
	STR	x0,[x3]

	ldr	x4,=strPrefix
	STR	x1,[x4]

	ldr	x5,=iPos
	STR	x2,[x5]
	
	ldr	x0,=strPrefix
	bl	String_length
	mov	x6,x0

//continue
	ldr	x0,=str1
	ldr	x1,=strPrefix
	
	ldrb	w3,[x0]
	add	x0,x0,#1

	ldrb	w4,[x1]
	add	x1,x1,#1

compareLoop5:
	cmp	x6,#0
	b.eq	true5

	ldrb	w3,[x0]
	add	x0,x0,#1

	ldrb	w4,[x1]
	add	x1,x1,#1

	cmp	w3,w4
	b.ne	false5
	
	sub	x6,x6,#1
	
	b	compareLoop5	
	
true5:
	mov	x0,#1
	b	exit3	

false5:
	mov	x0,#0
	b	exit5
	
exit5:
	LDR LR,[SP],#16		//POP LR
	ret


//************************************************************************
//Program: String_startsWith_2.s
//
//Purpose: It tests whether string1 begins with the specified prefix. 
//If yes then it returns true else false.
//
//*************************************************************************



	.global String_startsWith_2
	.text

String_startsWith_2:

	STR	LR, [SP,#-16]!		//PUSH LR

	//x0 holds string1
	//x1 holds stringPrefix
	//x2 holds indexPosition

	ldr	x3,=str1
	STR	x0,[x3]

	ldr	x4,=strPrefix
	STR	x1,[x4]
	
	ldr	x0,=strPrefix
	bl	String_length
	mov	x6,x0

//continue
	ldr	x0,=str1
	ldr	x1,=strPrefix
	
	ldrb	w3,[x0]
	ldrb	w4,[x1]

compareLoop6:
	cmp	x6,#0
	b.eq	true1

	cmp	w3,w4
	b.ne	false1
	
	add	x0,x0,#1
	ldrb	w3,[x0]

	add	x1,x1,#1
	ldrb	w4,[x1]
	
	sub	x6,x6,#1
	
	b	compareLoop6	
	
true6:
	mov	x0,#1
	b	exit1	

false6:
	mov	x0,#0
	b	exit1
	
exit6:
	LDR LR,[SP],#16		//POP LR
	ret



//************************************************************************
//Program: String_endsWith.s
//
//Purpose: Checks whether the string ends with the
//specified suffix.
//
//*************************************************************************



	.global String_endsWith
	.text

String_endsWith:

	STR	LR, [SP,#-16]!		//PUSH LR

	//x0 holds string1
	//x1 holds stringPrefix


	ldr	x3,=str1
	STR	x0,[x3]

	ldr	x4,=strPrefix
	STR	x1,[x4]

	
	ldr	x0,=strPrefix
	bl	String_length
	mov	x6,x0

//continue
	ldr	x0,=str1
	ldr	x1,=strPrefix
	
	ldrb	w3,[x0]
	add	x0,x0,#1

	ldrb	w4,[x1]
	add	x1,x1,#1

compareLoop7:
	cmp	x6,#0
	b.eq	true1

	ldrb	w3,[x0]
	add	x0,x0,#1

	ldrb	w4,[x1]
	add	x1,x1,#1

	cmp	w3,w4
	b.ne	false1
	
	sub	x6,x6,#1
	
	b	compareLoop1	
	
true7:
	mov	x0,#1
	b	exit1	

false7:
	mov	x0,#0
	b	exit1
	
exit7:
	LDR LR,[SP],#16		//POP LR
	ret

	.data
str1:	.skip	50
str2:	.skip	50
ptrStr:	.quad	0
iPos:	.byte	0
strPrefix:	.skip	21
	.end
