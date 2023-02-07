// Style Sheet
// Programmer   : Jacob Campbell
// Lab #        : 6
// Purpose      : User Input
// Date         : 2/1/2023

        .EQU SIZE, 21

        .data

                szPromptA:      .asciz  "Enter A: "     // Input 100
                szPromptB:      .asciz  "Enter B: "     // Input -10000
                szPromptC:      .asciz  "Enter C: "     // Input 10000000
                szPromptD:      .asciz  "Enter D: "     // Input -10000000000
                szA:            .skip   21              // char A[21]
                szB:            .skip   21              // char B[21]
                szC:            .skip   21              // char C[21]
                szD:            .skip   21              // char D[21]
                szResult:       .skip   21              // char Result[21]
                dbSum:          .quad   0               // double sum = 0
                szPlus:         .asciz  " + "
                szMinus:        .asciz  " - "
                szEqual:        .asciz  " = "
                chLF:           .byte   0xa             // Line Feed

        .global _start
        .text
_start:

// 1) Prompt for A
        LDR     X0,=szPromptA   // *X0 = szPromptA
        BL      putstring       // Print "Enter A: "

// 2) Get A from user
        LDR     X0,=szA         //*X0 = char A[21]
        MOV     X1,#SIZE        // X1 = 21, size of max signed string

        BL      getstring       // cin >> A

// 3) Convert X0 from ASCII -> int, then store at X11
        LDR     X0,=szA         // ascint64 requires null-terminated string
        BL      ascint64        // returns 64 bit int in X0

        MOV     X11, X0         // Loads int A into X11

// 4) Prompt for B
        LDR     X0,=szPromptB   // *X0 = szPromptB
        BL      putstring       // Print "Enter B: "

// 5) Get B from user
        LDR     X0,=szB         //*X0 = char B[21]
        MOV     X1,#SIZE        // X1 = 21, size of max signed string

        BL      getstring       // cin >> B

// 6) Convert X0 from ASCII -> int, then store at X12
        LDR     X0,=szB        // ascint64 requires null-terminated string
        BL      ascint64       // returns 64 bit int in X0

        MOV     X12, X0        // Loads int B into X12

// 7) Prompt for C
        LDR     X0,=szPromptC  // *X0 = szPromptC
        BL      putstring      // Print "Enter C: "

// 8) Get C from user
        LDR     X0,=szC        //*X0 = char C[21]
        MOV     X1,#SIZE       // X1 = 21, size of max signed string

        BL      getstring      // cin >> C

// 9) Convert X0 from ASCII -> int, then store at X13
        LDR     X0,=szC        // ascint64 requires null-terminated string
        BL      ascint64       // returns 64 bit int in X0

        MOV     X13, X0        // Loads int C into X13

// 10) Prompt for D
        LDR     X0,=szPromptD  // *X0 = szPromptD
        BL      putstring      // Print "Enter D: "

// 11) Get D from user
        LDR     X0,=szD        //*X0 = char D[21]
        MOV     X1,#SIZE       // X1 = 21, size of max signed string

        BL      getstring      // cin >> D

// 12) Convert X0 from ASCII -> int, then store at X14
        LDR     X0,=szD        // ascint64 requires null-terminated string
        BL      ascint64       // returns 64 bit int in X0

        MOV     X14, X0         // Loads int B into X14

// 13) Set X0 = X11 - X12
        LDR     X0,=dbSum       // *X0 = dbSum = 0
        SUB     X0, X11, X12    // X0 = X11 - X12

// 14) Set X0 = X0 + X13
        ADD     X0, X0, X13     // X0 += X13

// 15) Set X0 = X0 - X14
        SUB     X0, X0, X14     // X0 -= X14

// 16) Convert Sum from int -> ASCII, then store in memory
        LDR     X1,=szResult    // *X1 = szResult
        BL      int64asc        // X1 points to result stored in memory
		
// 17) Print the operation and result
        LDR     X0,=szA         // *X0 = A string
        BL      putstring       // print A

        LDR     X0,=szMinus     // *X0  = -
        BL      putstring       // print " - "

        LDR     X0,=szB         // *X0 = B String
        BL      putstring       // Print B

        LDR     X0,=szPlus      // *X0 = +
        BL      putstring       // Print " + "

        LDR     X0,=szC         // *X0 = C String
        BL      putstring       // Print C

        LDR     X0,=szMinus     // *X0 = -
        BL      putstring       // Print " - "

        LDR     X0,=szD         // *X0 = D String
        BL      putstring       // Print D

        LDR     X0,=szEqual     // *X0 = =
        BL      putstring       // Print " = "

        LDR     X0,=szResult    // *X0 = Sum
        BL      putstring       // Prints Sum

        LDR     X0,=chLF        // Line Feed
        BL      putch

// Setup parameters to exit program and call Linux to do it
        MOV     X0, #0          // Use return code 0
        MOV     X8, #93         // Service command code 93
        SVC     0               // Goodbye