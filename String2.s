    .global String2
String2:

.global String_indexOf_1
String_indexOf_1:
    mov x2, #0   // Initialize the index to 0
    mov w3, #0   // Initialize the character count to 0

indexOf_char_loop_1:
    ldrb w1, [x0]  // Load the byte at the current index into w1
    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq not_found_1     // If it's a null terminator, the character is not found

    cmp w1, w8         // Compare w1 (current character) with the specified character (w8)
    b.eq found_1         // If they are equal, we found the character

    add x2, x2, #1     // Increment the index
    add x0, x0, #1
    b indexOf_char_loop_1 // Continue looping to check the next character

found_1:
    mov x0, x2   // Move the index to x0 for return
    ret

not_found_1:
    mov x0, #-1   // Character not found, return -1
    ret

.global String_indexOf_2
String_indexOf_2:
    mov x2, x1   // Initialize the index to 0
    mov w3, #0   // Initialize the character count to 0
    add x0, x0, x2
indexOf_char_loop_2:
    ldrb w1, [x0]  // Load the byte at the current index into w1
    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq not_found_2     // If it's a null terminator, the character is not found

    cmp w1, w8         // Compare w1 (current character) with the specified character (w8)
    b.eq found_2         // If they are equal, we found the character

    add x2, x2, #1     // Increment the index
    add x0, x0, #1
    b indexOf_char_loop_2 // Continue looping to check the next character

found_2:
    mov x0, x2   // Move the index to x0 for return
    ret

not_found_2:
    mov x0, #-1   // Character not found, return -1
    ret

.global String_indexOf_3
String_indexOf_3:
    mov x2, #0         // Initialize the index to 0

    cmp x0, #0         // Check if string1 is empty
    b.eq not_found_3   // If it is, the substring is not found

    cmp x1, #0         // Check if the substring is empty
    b.eq found_3       // If it is, it's found at the beginning

indexOf_substr_loop_3:
    ldrb w1, [x0]     // Load the byte at the current index into w1
    ldrb w4, [x1]     // Load the byte from the substring into w4

    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq not_found_3  // If it's a null terminator in the string, the substring is not found

    cmp w1, w4         // Compare w1 (current character) with the first character of the substring
    b.ne next_char_3   // If they are not equal, continue to the next character in the string

    // Check if the rest of the substring matches
    mov x3, x0         // Store the current index of string1
    mov x2, x0         // Initialize the index to the current index
indexOf_char_loop_3:
    ldrb w1, [x0]     // Load the byte at the current index into w1
    ldrb w4, [x1]     // Load the byte from the substring into w4

    cmp w4, #0         // Compare the character from the substring with 0 (null terminator)
    b.eq found_3       // If it's null terminator, the entire substring is found

    cmp w1, w4         // Compare w1 (current character) with the corresponding character from the substring
    b.ne next_char_3   // If they are not equal, move to the next character in the string

    add x1, x1, #1     // Move to the next character in the substring
    add x0, x0, #1     // Move to the next character in the string
    b indexOf_char_loop_3 // Continue checking the next character in the substring

next_char_3:
    // Reset index for the substring
    mov x1, x3
    add x2, x2, #1     // Increment the index for string1
    add x0, x2, x1    // Move to the next character in the string1
    b indexOf_substr_loop_3

found_3:
    mov x0, x2   // Move the index to x0 for return
    ret

not_found_3:
    mov x0, #-1   // Substring not found, return -1
    ret
.global String_lastIndexOf_1
String_lastIndexOf_1:
    mov x2, x1   // Initialize the index to the length of the string
    sub x2, x2, #1 // Adjust the index to point to the last character
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

.global String_lastIndexOf_2
String_lastIndexOf_2:
    mov x2, x1   // Initialize the index to the specified starting index
    mov w3, #0   // Initialize the character count to 0

lastIndexOf_char_loop_2:
    sub x2, x2, #1     // Decrement the index to move to the previous character
    ldrb w1, [x0, x2]  // Load the byte at the current index into w1
    cmp w1, #0         // Compare the character with 0 (null terminator)
    b.eq index_not_found_2   // If it's a null terminator, the character is not found

    cmp w1, w8         // Compare w1 (current character) with the specified character (w8)
    b.eq index_found_2       // If they are equal, we found the character

    b.ne lastIndexOf_char_loop_2 // Continue looping to check the next character

index_continue_loop_2:
    sub x3, x3, #1     // Decrement the index
    b lastIndexOf_char_loop_2

index_found_2:
    mov x0, x2   // Move the index to x0 for return
    ret
index_not_found_2:
    mov x0, -1   // Character not found, return -1
    ret

.global String_lastIndexOf_3
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
    b.ne index_continue_loop_3 // If it's not the end of the substring, continue checking

index_found_3:
    mov x0, x2   // Move the index to x0 for return
    ret

index_continue_loop_3:
    sub x2, x2, #1     // Decrement the index
    b lastIndexOf_substring_loop_3

index_not_found_3:
    mov x0, -1   // Substring not found, return -1
    ret

.global String_concat

String_concat:
    // Input:
    // x0: Pointer to the first string (string1)
    // x1: Pointer to the second string (string2)

    // Calculate the length of the first string (string1)
    mov x2, #0           // Initialize the index to 0
calc_str1_length:
    ldrb w3, [x0, x2]   // Load the byte at the current index into w3
    cmp w3, #0           // Compare the character with 0 (null terminator)
    b.eq concat_str      // If it's a null terminator, proceed to concatenate
    add x2, x2, #1       // Increment the index
    b calc_str1_length   // Continue looping to calculate the length

concat_str:
    // Calculate the length of the second string (string2)
    mov x2, #0           // Reset index for string1
    mov x3, #0           // Initialize the index for string2
calc_str2_length:
    ldrb w4, [x1, x3]   // Load the byte at the current index of string2 into w4
    cmp w4, #0           // Compare the character with 0 (null terminator)
    b.eq copy_str2      // If it's a null terminator, proceed to copy string2
    add x3, x3, #1       // Increment the index for string2
    b calc_str2_length   // Continue looping to calculate the length

copy_str2:
    // Copy the characters from string2 to the end of string1
    mov x3, #0           // Reset index for string2
copy_loop:
    ldrb w4, [x1, x3]   // Load the byte at the current index of string2 into w4
    strb w4, [x0, x2]   // Store the byte in string1 at the current index
    cmp w4, #0           // Compare the character with 0 (null terminator)
    b.eq null_terminate // If it's a null terminator, terminate the concatenated string
    add x2, x2, #1       // Increment the index for string1
    add x3, x3, #1       // Increment the index for string2
    b copy_loop          // Continue copying

null_terminate:
    mov w6, #0
    strb w6, [x0, x2]     // Null-terminate the concatenated string
    ret
.global String_replace
String_replace:

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
    ret
    
.global String_toLowerCase
String_toLowerCase:

toLowerCase_loop:
    ldrb w3, [x0]  // Load a character from the string into w3
    cmp w3, #0     // Compare the character with the null terminator
    b.eq end_toLowerCase // If it's the end of the string, exit the loop

    // Check if the character is an uppercase letter (ASCII range A-Z)
    cmp w3, #'A'
    blt continue_toLowerCase
    cmp w3, #'Z'
    bgt continue_toLowerCase

    // Convert to lowercase (add the ASCII difference)
    sub w3, w3, #'A' - 'a'  // Convert to lowercase
    strb w3, [x0]  // Store the lowercase character back in the string

continue_toLowerCase:
    add x0, x0, #1  // Increment the string pointer
    b toLowerCase_loop  // Repeat the loop

end_toLowerCase:
    ret
.global String_toUpperCase
String_toUpperCase:

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
    ret
.data
ptrString: .quad 0
