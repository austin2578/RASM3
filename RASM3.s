.equ MAX_BYTES, 512 //Max string size

    .global _start
_start:

    //INPUT
    ldr x0, =szPrompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =s1  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input

    ldr x0, =szPrompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =s2  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input

    ldr x0, =szPrompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =s3  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    
    ldr x0, =s1_length_str  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    ldr x0, =s1
    bl String_length
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =s2_length_str  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    ldr x0, =s2
    bl String_length
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =s3_length_str  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    ldr x0, =s3
    bl String_length
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

test0:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	
	ldr	x0,=strEquals1	//x0 hold address
	bl	putstring	//prints string

	ldr	x0,=s1	//x0 hold address
	ldr	x1,=s3	//x0 hold address
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
	
// ************************************* Test for String_equals(s1,s1)
test1:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	
	ldr	x0,=strEquals2	//x0 points to
	bl	putstring	//prints string

	ldr	x0,=s1	//x0 points to
	ldr	x1,=s1	//x0 points to
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


// ************************************* Test for String_equalsIgnoreCase(s1,s3)
test2:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strEqIgno1	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=s1	//x0 points to
	ldr	x1,=s3	//x0 points to
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
	
// ************************************* Test for String_equalsIgnoreCase(s1,s2)
test3:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strEqIgno2	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=s1		//x0 points to
	ldr	x1,=s2		//x0 points to
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


// ************************************* Test for String_copy(s1)
test4:

	ldr	x0,=strCopy	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=strS1Copy	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=s1	//x0 points to
	bl	putstring	//prints string
    ldr x0, =newline
    bl putch
    ldr	x0,=strS4Copy	//x0 points to
	bl	putstring	//prints string
    ldr x0, =s1
    bl String_length
    bl malloc
    // Store the address in ptrString
    ldr x1, =s4
    str x0, [x1]
    // Copy szX to the allocated memory
    ldr x2, =s1
    bl String_copy
    // Print the resulting string
    ldr x0, =s4
    ldr x0, [x0]
    bl putstring
    // Step 4: Free the allocated memory
    ldr x0, =s4
    ldr x0, [x0]
    bl free
    ldr x0, =newline
    bl putch
		
// ************************************* Test for String_substring_1
test7:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strSub1	//x0 points to
	bl	putstring	//prints string
	
	ldr	x0,=s1		//x0 points to
	ldr	x1,=iBegin	//x0 points to
	ldr	x2,=iEnd	//x0 points to
	bl	String_substring_1
	
	ldr	x1,=s4	//x0 points to
	str	x0,[x1]
	
	ldr	x0,=s4	//x0 points to
	bl	putstring	//prints string
	
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
// ************************************* Test for String_substring_2
test8:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strSub2	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=s1	//x0 points to
	ldr	x1,=iBegin2	//x0 points to
	bl	String_substring_2
	
	ldr	x1,=s4	//x0 points to
	str 	x0,[x1]
	
	ldr	x0,=s4	//x0 points to
	bl	putstring	//prints string

	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
// ************************************* Test for String_charAt
test9:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strChar	//x0 points to
	bl	putstring	//prints string
    ldr x0, =s2
    bl String_charAt
    ldr x1, =stringChar
    strb w0, [x1]
    bl putch
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
// ************************************* Test for String_startsWith_1
test10:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strStarts1	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=s1	//x0 points to
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
	

// ************************************* Test for String_startsWith_2
test11:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strStarts2	//x0 points to
	bl	putstring
	
	ldr	x0,=s1	//x0 points to
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

// ************************************* Test for String_endsWith(s1,"in the hat")
test12:
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	ldr	x0,=strEnds	//x0 points to
	bl	putstring	//prints string
	
	ldr	x0,=s1	//x0 points to
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
	b 	continue1
	
printFalse12:
	ldr	x0,=szFalse	//x0 points to
	bl	putstring	//prints string
	ldr	x0,=chLF	//x0 points to chLF
	bl	putch		//prints carriage return
	b	continue1

continue1:
    ldr x0, =szIndex1Prompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szString_index_1
    bl putstring
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    ldrb w8, [x0]
    ldr x0, =s2
    bl String_indexOf_1
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =szIndex2Prompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szIndex2Prompt2  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szString_index_2
    bl putstring
    ldr x0, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl ascint64   // Convert x0 to a string
    ldr x1, =starting_index
    str x0, [x1]
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    ldrb w8, [x0]
    ldr x0, =s2
    ldr x1, =starting_index
    ldr x1, [x1]
    bl String_indexOf_2
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =szIndex3Prompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =subString  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szString_index_3
    bl putstring
    ldr x0, =s2
    ldr x1, =subString
    bl String_indexOf_3
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =szLastIndex1Prompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szString_lastIndex_1
    bl putstring
    ldr x0, =s2
    bl String_length
    mov x1, x0
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    ldrb w8, [x0]
    ldr x0, =s2
    bl String_lastIndexOf_1
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =szLastIndex2Prompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szIndex2Prompt2  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szString_lastIndex_2
    bl putstring
    ldr x0, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl ascint64   // Convert x0 to a string
    ldr x1, =starting_index
    str x0, [x1]
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    ldrb w8, [x0]
    ldr x0, =s2
    ldr x1, =starting_index
    ldr x1, [x1]
    bl String_lastIndexOf_2
    ldr x1, =iLimitNum  // Load the address of the iLimitNum variable into x0
    bl int64asc   // Convert x0 to a string
    ldr x0, =iLimitNum
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =szIndex3Prompt  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =subString  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szString_lastIndex_3
    bl putstring
    ldr x0, =s2
    ldr x1, =subString

    ldr x0, =newline
    bl putch

    ldr x0, =szReplace1  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =starting_index  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szReplace2  // Load the address of the input prompt into x1
    bl putstring  // Display the input prompt
    mov x1, MAX_BYTES   //Move max byte size into x1
    ldr x0, =index  // Load the address of the iLimitNum variable into x0
    bl getstring  // Call the getstring function to get user input
    ldr x0, =szString_replace
    bl putstring
    ldr x0, =s1
    ldr x1, =starting_index
    ldr w1, [x1]
    ldr x2, =index
    ldr w2, [x2]
    bl String_replace
    ldr x0, =s1
    bl putstring 
    ldr x0, =newline
    bl putch

    ldr x0, =s1
    bl String_toLowerCase
    ldr x0, =szString_toLowerCase
    bl putstring
    ldr x0, =s1
    bl putstring
    ldr x0, =newline
    bl putch
    ldr x0, =s1
    bl String_toUpperCase
    ldr x0, =szString_toUpperCase
    bl putstring
    ldr x0, =s1
    bl putstring
    ldr x0, =newline
    bl putch

    ldr x0, =szString_concat1
    bl putstring
    ldr x0, =s2
    bl String_length
    bl malloc
    ldr x1, =ptrString
    str x0, [x1]
    ldr x2, =s1
    bl String_concat
    //concat spacebar press 
    mov x3, #' '
    strb w3, [x0]
    add x0, x0, #1
    //concat string2 to string 1
    ldr x2, =s2
    bl String_concat
    ldr x0, =newline
    bl putch
    ldr x0, =szString_concat2
    bl putstring
    // Print the resulting string
    ldr x0, =ptrString
    ldr x0, [x0]
    bl putstring
    // Step 4: Free the allocated memory
    ldr x0, =ptrString
    ldr x0, [x0]
    bl free
    ldr x0, =newline
    bl putch

    // Exit the program
    mov x8, 93  // syscall number for exit
    mov x0, 0   // exit status
    svc 0

    .data
s1:   .space 50
s2:   .space 50
s3:   .space 50
s4:   .space 50
index: .space 50
starting_index: .space 50
subString: .space 50
s1_length_str:   .asciz "s1.length() = "
s2_length_str:   .asciz "s2.length() = "
s3_length_str:   .asciz "s3.length() = "
equals_result_str:   .asciz "String_equals(s1, s3) = "
equals_ignore_case_result_str:   .asciz "String_equalsIgnoreCase(s1, s2) = "
substring_result_str:   .asciz "String_substring_1(s3,4,14) = "
szPrompt: .asciz "Please enter a string: "
szIndex1Prompt: .asciz "Please enter character to find index in s2: "
szLastIndex1Prompt: .asciz "Please enter character to find last index in s2: "
szIndex2Prompt: .asciz "Please enter character to find in s2: "
szIndex2Prompt2: .asciz "Please enter starting index: "
szLastIndex2Prompt: .asciz "Please enter character to find last occurrence in s2: "
szLastIndex3Prompt: .asciz "String_lastIndexOf_3(s2,'egg') = "
szIndex3Prompt: .asciz "Please enter substring of s2: "
szString_index_1: .asciz "String_indexOf_1(s2,'g') = "
szString_index_2: .asciz "String_indexOf_2(s2,'g',9) = "
szString_index_3: .asciz "String_indexOf_3(s2,'eggs') = "
szString_lastIndex_1: .asciz "String_lastIndexOf_1(s2,'g') = "
szString_lastIndex_2: .asciz "String_lastIndexOf_2(s2,'g',9) = "
szString_lastIndex_3: .asciz "String_lastIndexOf_3(s2,'eggs') = "
szString_replace: .asciz "String_replace(s1,'a','o') = "
szString_toLowerCase: .asciz "String_toLowerCase(s1) = "
szString_toUpperCase: .asciz "String_toUpperCase(s1) = "
szString_concat1: .asciz "String_concat(s1,' ') = "
szString_concat2: .asciz "String_concat(s1,s2) = "
szReplace1: .asciz "Please enter character to replace: "
szReplace2: .asciz "Please enter replacement character: "
strEquals1:	.asciz	"String_equals(s1,s3) = "
strEquals2:	.asciz	"String_equals(s1,s1) = "
strEqIgno1:	.asciz	"String_equalsIgnoreCase(s1,s3) = "
strEqIgno2:	.asciz	"String_equalsIgnoreCase(s1,s2) = "
strCopy:	.asciz	"s4 = String_copy(s1)\n"
strS1Copy:		.asciz	"s1 = "
strS4Copy:		.asciz	"s4 = "
strSub1:	.asciz	"String_substring_1(s3,4,14) = "
strSub2:	.asciz	"String_substring_2(s3,7) = "
strChar:	.asciz	"String_charAt(s2,4) = "
strStarts1:	.asciz	"String_startsWith_1(s1,11,'hat') = "
strStarts2:	.asciz	"String_startsWith_1(s1,'Cat') = "
strEnds:	.asciz	"String_endsWith(s1,'in the hat.') = "
stringSpace: .asciz " "
szPrefix:	.asciz	"in the hat."
szPrefix2:	.asciz	"the hat."
szSuffix:	.asciz	"in the hat."
szEnter:	.asciz	"Enter a string: "
szTrue:		.asciz	"true"
szFalse:	.asciz	"false"
chLF:	.byte	0xa	//carriage return
iBegin:	.byte	4
iEnd:	.byte	14
iBegin2:.byte	7
iPosition:	.byte	4
szTemp:	.skip	21
newline: .byte 10
iLimitNum: .quad 0    // The limit for entering numeric strings
ptrString: .quad 0
stringChar: .quad 0

