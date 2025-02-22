// Load divisor (R1) into D
@1
D=M

// Check if divisor (y) is zero
@DIV_BY_ZERO
D;JEQ   // If y == 0, jump to DIV_BY_ZERO

// Initialize R2 (quotient) and R3 (remainder)
@2
M=0     // m = 0
@3
M=0     // q = 0
@4
M=0     // R4 = 0 (valid division)

// Load dividend (R0) into D
@0
D=M

// Store absolute value of dividend in R5
@R5
M=D
@0
D=M
@NEG_X
D;JLT   // If x < 0, jump to NEG_X

// Store absolute value of divisor in R6
@1
D=M
@NEG_Y
D;JLT   // If y < 0, jump to NEG_Y
@R6
M=D
@DIV_LOOP
0;JMP

(NEG_X) // Convert x to positive and store in R5
@0
D=M
D=-D
@R5
M=D
@DIV_LOOP
0;JMP

(NEG_Y) // Convert y to positive and store in R6
@1
D=M
D=-D
@R6
M=D

// Main Division Loop
(DIV_LOOP)
@R5
D=M
@R6
D=D-M  // D = R5 - R6

@DONE
D;JLT  // If remainder is negative, exit loop

// Subtract divisor from dividend
@R5
M=D    // R5 = R5 - R6

// Increment quotient
@2
M=M+1
@DIV_LOOP
0;JMP  // Repeat until remainder is negative

(DONE)
// Store final remainder in R3
@R5
D=M
@3
M=D

// Check if signs of x and y were different
@0
D=M
@1
D=D*M  // x * y

@POSITIVE_QUOTIENT
D;JGE  // If x * y >= 0, quotient is correct

// If x * y < 0, negate the quotient
@2
D=M
D=-D
M=D

(POSITIVE_QUOTIENT)
@END
0;JMP

(DIV_BY_ZERO) // Handle division by zero
@4
M=1    // Set error flag
@END
0;JMP

(END)
@END
0;JMP  // Infinite loop (optional)
