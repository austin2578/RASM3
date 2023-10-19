    .global String2
String2:

String_indexOf_1:
    mov x2, #0   // Initialize the index to 0
    mov w3, #0   // Initialize the character count to 0

indexOf_char_loop_1:
    ldrb w1, [x0, x2]  // Load the byte at the current index into w1
    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq not_found_1     // If it's a null terminator, the character is not found

    cmp w1, w8         // Compare w1 (current character) with the specified character (w8)
    b.eq found_1         // If they are equal, we found the character

    add x2, x2, #1     // Increment the index
    b indexOf_char_loop_1 // Continue looping to check the next character

found_1:
    mov x0, x2   // Move the index to x0 for return
    ret

not_found_1:
    mov x0, #-1   // Character not found, return -1
    ret

String_indexOf_2:
    cmp x2, #0
    b.lt not_found   // If fromIndex is negative, return -1

    mov x1, x2  // Set x1 to the specified fromIndex

indexOf_char_loop_2:
    ldrb w1, [x0, x1]  // Load the byte at the current index into w1
    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq not_found_1     // If it's a null terminator, the character is not found

    cmp w1, w8         // Compare w1 (current character) with the specified character (w8)
    b.eq found_2       // If they are equal, we found the character

    add x1, x1, #1     // Increment the index
    b indexOf_char_loop_2 // Continue looping to check the next character

found_2:
    mov x0, x1   // Move the index to x0 for return
    ret

String_indexOf_3:
    ldr x4, [x0, #0]   // Load the length of the string
    ldr x6, [x1, #0]   // Load the length of the substring

    cmp x6, x4
    b.ge not_found_3  // If the substring is longer, it cannot be found in the string

    mov x2, x4         // Initialize x2 with the string length
    sub x2, x2, #1     // Adjust x2 to the last character index

indexOf_substring_loop_3:
    ldrb w4, [x0, x2]  // Load the byte at the current index in the string into w4
    cmp w4, #0         // Compare the character with 0 (null terminator)
    b.eq not_found_3   // If it's a null terminator, the substring is not found

    ldrb w5, [x1, #0]  // Load the byte at the current index in the substring into w5

    cmp w4, w5         // Compare the characters in the string and the substring
    b.ne continue_loop_3 // If they are not equal, continue the loop

    add x6, x1, #1     // Increment the substring index

    ldrb w5, [x6, #0]  // Load the next byte of the substring
    cmp w5, #0         // Compare it to the null terminator
    b.ne continue_loop_3 // If it's not the end of the substring, continue checking

found_3:
    mov x0, x2   // Move the index to x0 for return
    ret

continue_loop_3:
    sub x2, x2, #1     // Decrement the index
    b indexOf_substring_loop_3

not_found_3:
    mov x0, -1   // Substring not found, return -1
    ret

String_lastIndexOf_1:
    mov x2, #0   // Initialize the index to 0
    mov w3, #0   // Initialize the character count to 0

lastIndexOf_char_loop_1:
    ldrb w1, [x0, x2]  // Load the byte at the current index into w1
    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq index_not_found_1  // If it's a null terminator, the character is not found

    cmp w1, w8         // Compare w1 (current character) with the specified character (w8)
    b.eq index_found_1      // If they are equal, we found the character

    sub x2, x2, #1     // Decrement the index
    b lastIndexOf_char_loop_1 // Continue looping backward to check the previous character

index_found_1:
    mov x0, x2   // Move the index to x0 for return
    ret

index_not_found_1:
    mov x0, -1   // Character not found, return -1
    ret

String_lastIndexOf_2:
    cmp x2, #0
    b.lt index_not_found_2   // If fromIndex is negative, return -1
    ldr x4, [x0, #0]   // Load the length of the string
    cmp x2, x4
    b.ge index_not_found_2  // If fromIndex is greater than or equal to the string length, return -1

    mov x3, x4         // Initialize x3 with the string length
    sub x3, x3, #1     // Adjust x3 to the last character index
    sub x3, x3, x2     // Set x3 to the starting index from the end

lastIndexOf_char_loop_2:
    ldrb w1, [x0, x3]  // Load the byte at the current index into w1
    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq not_found_2   // If it's a null terminator, the character is not found

    cmp w1, w8         // Compare w1 (current character) with the specified character (w8)
    b.ne continue_loop_2 // If they are not equal, continue the loop

    mov x0, x3   // Move the last occurrence index to x0 for return
    ret

continue_loop_2:
    sub x3, x3, #1     // Decrement the index
    b lastIndexOf_char_loop_2

index_not_found_2:
    mov x0, -1   // Character not found, return -1
    ret

String_lastIndexOf_3:
    ldr x4, [x0, #0]   // Load the length of the string
    ldr x5, [x1, #0]   // Load the length of the substring

    cmp x5, x4
    b.ge index_not_found_3  // If the substring is longer, it cannot be found in the string

    mov x2, x4         // Initialize x2 with the string length
    sub x2, x2, #1     // Adjust x2 to the last character index

lastIndexOf_substring_loop_3:
    ldrb w3, [x0, x2]  // Load the byte at the current index in the string into w3
    cmp w3, #0         // Compare the character with 0 (null terminator)
    b.eq index_not_found_3   // If it's a null terminator, the substring is not found

    ldrb w1, [x1, #0]  // Load the byte at the current index in the substring into w1

    cmp w3, w1         // Compare the characters in the string and the substring
    b.ne index_continue_loop_3 // If they are not equal, continue the loop

    add x5, x1, #1     // Increment the substring index

    ldrb w1, [x5, #0]  // Load the next byte of the substring
    cmp w1, #0         // Compare it to the null terminator
    b.ne continue_loop_3 // If it's not the end of the substring, continue checking

index_found_3:
    mov x0, x2   // Move the index to x0 for return
    ret

index_continue_loop_3:
    sub x2, x2, #1     // Decrement the index
    b lastIndexOf_substring_loop_3

index_not_found_3:
    mov x0, -1   // Substring not found, return -1
    ret

String_concat:
    // Preserve the link register
    str lr, [sp, #-8]!

    // x0 contains the length of the first string (int)
    // x2 contains the address of the first string
    // x3 contains the address of the second string
    // Step 3: Call malloc to allocate memory
    bl malloc
    mov x8, x3

    // x0 now contains the address of the allocated memory

    // Store the address in ptrString
    ldr x1, =ptrString
    str x0, [x1]

    // Copy szX to the allocated memory
    bl copy_string
    mov x2, x8
    bl copy_string


    // Restore the link register
    ldr lr, [sp], #8

    ret

copy_string:
    // Preserve the link register
    str lr, [sp, #-8]!

    // Load a character from the source into x3
    ldrb w3, [x2]
    add x2, x2, #1

    // Check if the character is null (end of the string)
    cbz w3, end_copy // If it's null, exit the loop

    // Store the character in the allocated memory
    strb w3, [x0]
    add x0, x0, #1

    // Repeat the loop
    b copy_string

end_copy:
    // Restore the link register
    ldr lr, [sp], #8
    ret

String_replace:
    // Preserve the link register
    str lr, [sp, #-8]!

    // x0 contains the address of the string
    // x1 contains the character to be replaced
    // x2 contains the character to replace with

replace_loop:
    ldrb w3, [x0]  // Load a character from the string into w3
    cmp w3, #0     // Compare the character with null terminator
    b.eq end_replace // If it's the end of the string, exit the loop

    cmp w3, w1     // Compare the character with the character to be replaced
    b.ne continue_replace // If they are not equal, continue with the next character

    // Replace the character
    mov w3, w2     // Set w3 to the replacement character

    strb w3, [x0]  // Store the replaced character in the string

continue_replace:
    add x0, x0, #1  // Increment the string pointer
    b replace_loop  // Repeat the loop

end_replace:
    // Restore the link register
    ldr lr, [sp], #8
    ret

String_toLowerCase:
    // Preserve the link register
    str lr, [sp, #-8]!

    // x0 contains the address of the string

toLowerCase_loop:
    ldrb w3, [x0]  // Load a character from the string into w3
    cmp w3, #0     // Compare the character with null terminator
    b.eq end_toLowerCase // If it's the end of the string, exit the loop

    // Check if the character is an uppercase letter (ASCII range A-Z)
    cmp w3, #'A'
    blt continue_toLowerCase
    cmp w3, #'Z'
    bgt continue_toLowerCase

    // Convert to lowercase (add the ASCII difference)
    add w3, w3, 'a' - 'A'
    strb w3, [x0]  // Store the lowercase character back in the string

continue_toLowerCase:
    add x0, x0, #1  // Increment the string pointer
    b toLowerCase_loop  // Repeat the loop

end_toLowerCase:
    // Restore the link register
    ldr lr, [sp], #8

    ret

String_toUpperCase:
    // Preserve the link register
    str lr, [sp, #-8]!

    // x0 contains the address of the string

toUpperCase_loop:
    ldrb w3, [x0]  // Load a character from the string into w3
    cmp w3, #0     // Compare the character with null terminator
    b.eq end_toUpperCase // If it's the end of the string, exit the loop

    // Check if the character is a lowercase letter (ASCII range a-z)
    cmp w3, #'a'
    blt continue_toUpperCase
    cmp w3, #'z'
    bgt continue_toUpperCase

    // Convert to uppercase (subtract the ASCII difference)
    sub w3, w3, 'a' - 'A'
    strb w3, [x0]  // Store the uppercase character back in the string

continue_toUpperCase:
    add x0, x0, #1  // Increment the string pointer
    b toUpperCase_loop  // Repeat the loop

end_toUpperCase:
    // Restore the link register
    ldr lr, [sp], #8
    ret
