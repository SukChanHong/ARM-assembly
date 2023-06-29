; ARM assembler

		AREA text, CODE
		; This section is called "text", and contains code
		ENTRY

start
			eor r7, r7, r7
			eor r8, r8, r8
			eor r9, r9, r9
			eor r10, r10, r10
			eor r11, r11, r11
			mov r1, #10		
			mov r12, #1	
			
			
num1		;scan num1
			bl	scan ;; "branch+link" = subroutine call, scan num1
			bl print_char
			mov r1, #10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;if this is not exist, r1 has waste value because of  print_char
			cmp r0, #' '		;get char until get 'space'
			beq final_num1
			cmp r0, #'-'
			beq store_sign1			
			sub	r2, r0, #'0'	;ASCII to integer
			mla r7, r1, r7, r2	;decimal number
			b	num1
			
store_sign1	mov r12, r0
			eor r0, r0, r0
			mov r12, #-1
			b num1
			
final_num1				
			mul r3, r7, r12
			mov r7, r3
			mov r12, #1
			b num2
			
					
num2

			bl	scan ;; "branch+link" = subroutine call, scan num1
			bl print_char
			mov r1, #10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;if this is not exist, r1 has waste value because of  print_char
			cmp r0, #' '		;get char until get 'space'
			beq final_num2
			cmp r0, #'-'
			beq store_sign2			
			sub	r3, r0, #'0'	;ASCII to integer
			mla r8, r1, r8, r3	;decimal number
			b	num2
			
store_sign2	mov r12, r0
			eor r0, r0, r0
			mov r12, #-1
			b num2
			
			
final_num2				
			mul r4, r8, r12
			mov r8, r4
			mov r12, #1
			b num3
			
						
			
num3

			bl	scan ;; "branch+link" = subroutine call, scan num1
			bl print_char
			mov r1, #10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;if this is not exist, r1 has waste value because of  print_char
			cmp r0, #' '		;get char until get 'space'
			beq final_num3
			cmp r0, #'-'
			beq store_sign3			
			sub	r4, r0, #'0'	;ASCII to integer
			mla r9, r1, r9, r4	;decimal number
			b	num3
			
store_sign3	mov r12, r0
			eor r0, r0, r0
			mov r12, #-1
			b num3
			
			
final_num3				
			mul r5, r9, r12
			mov r9, r5
			mov r12, #1
			b num4			
			
			
num4
			bl	scan ;; "branch+link" = subroutine call, scan num1
			bl print_char
			mov r1, #10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;if this is not exist, r1 has waste value because of  print_char
			cmp r0, #' '		;get char until get 'space'
			beq final_num4
			cmp r0, #'-'
			beq store_sign4			
			sub	r5, r0, #'0'	;ASCII to integer
			mla r10, r1, r10, r5	;decimal number
			b	num4
			
store_sign4	mov r12, r0
			eor r0, r0, r0
			mov r12, #-1
			b num4


final_num4				
			mul r6, r10, r12
			mov r10, r6
			mov r12, #1
			b num5	

			
num5
			bl	scan ;; "branch+link" = subroutine call, scan num1
			bl print_char
			mov r1, #10 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;if this is not exist, r1 has waste value because of  print_char
			cmp r0, #' '		;get char until get 'space'
			beq final_num5
			cmp r0, #'-'
			beq store_sign5		
			sub	r6, r0, #'0'	;ASCII to integer
			mla r11, r1, r11, r6	;decimal number
			b	num5
			
store_sign5	mov r12, r0
			eor r0, r0, r0
			mov r12, #-1
			b num5
			
final_num5				
			mul r2, r11, r12  ;fuck i cant use sam reg
			mov r11, r2
			b scan_end
			
			
								
scan_end	
			






AS1
		cmp r7, r8
		bgt change1
		b AS2
		
change1
		mov r12, r7
		mov r7, r8
		mov r8, r12
		b AS2


AS2
		cmp r8, r9
		bgt change2
		b AS3
		
change2
		mov r12, r8
		mov r8, r9
		mov r9, r12
		b AS3
		
AS3
		cmp r7, r8
		bgt change3
		b AS4
		
change3
		mov r12, r7
		mov r7, r8
		mov r8, r12
		b AS4
		
AS4
		cmp r9, r10
		bgt change4
		b AS5
		
change4
		mov r12, r9
		mov r9, r10
		mov r10, r12
		b AS5
		
AS5
		cmp r8, r9
		bgt change5
		b AS6
		
change5
		mov r12, r8
		mov r8, r9
		mov r9, r12
		b AS6

AS6
		cmp r7, r8
		bgt change6
		b AS7
		
change6
		mov r12, r7
		mov r7, r8
		mov r8, r12
		b AS7
		
AS7
		cmp r10, r11
		bgt change7
		b AS8
		
change7
		mov r12, r10
		mov r10, r11
		mov r11, r12
		b AS8
		
AS8
		cmp r9, r10
		bgt change8
		b AS9
		
change8
		mov r12, r9
		mov r9, r10
		mov r10, r12
		b AS9
AS9
		cmp r8, r9
		bgt change9
		b AS10
		
change9
		mov r12, r8
		mov r8, r9
		mov r9, r12
		b AS10

AS10
		cmp r7, r8
		bgt change10
		b print_result
		
change10
		mov r12, r7
		mov r7, r8
		mov r8, r12
		b print_result
		
		
print_result
		mov r0, #10
		bl print_char
		mov r0, r7
		bl print_integer
		mov r0, #' '
		bl print_char
		mov r0, r8
		bl print_integer
		mov r0, #' '
		bl print_char
		mov r0, r9
		bl print_integer
		mov r0, #' '
		bl print_char
		mov r0, r10
		bl print_integer
		mov r0, #' '
		bl print_char
		mov r0, r11
		bl print_integer
		mov r0, #10
		bl print_char
		mov r0, #10
		bl print_char
		b finish




		
scan
			stmfd	sp!, {lr}
			mov		r0, #7
			swi		0x123456
			ldmfd	sp!, {pc}
			
div_mod									;divisor and modulo
			stmfd   sp!, {r3-r7,lr}		;r0 <= r1/r2 Quotient
			cmp	r2,	#0					;r1 <= r1 mod r2
			mov r0, #0
			beq	div_end
			b start_div
start_div								;subtract until r2>1
			cmp	r2, r1
			bgt div_end					;if r2>r1, r1 is remainder
			sub	r1, r1, r2
			add r0, r0, #1				;Quotient + 1
			bl	start_div
			
div_end
			ldmfd	sp!, {r3-r7,pc}
			
			
			
			
print_integer

			stmfd sp!, {r1-r7,lr}
			b print_integer1
print_integer1
			mov r5, r0
			cmp r0, #0
			blt make_pos
			mov r4, #0
			cmp r0, #10					;if r0 < 10 it is char data
			blt print_integer_2
			b	loop_div

make_pos	
			mov r0, #'-'
			bl print_char
			mov r0, r5
			mov r7, #0xFFFFFFFF
			eor r0, r0, r7
			add r0, r0, #1
			b print_integer1
			
			
print_integer_2
			add r0, r0, #'0'			;integer to ASCII
			bl	print_char
			b	print_integer_end

loop_div
			mov r1, r0
			mov r2, #10
			bl div_mod					
			add r0, r0, #'0'
			mov r4, r1;;일의 자리 r4에 저장, r1 레지스터에 쓰레기값 들어가는 것 같아서
			bl print_char
			add r4, r4, #'0'
			mov r0, r4;;일의 자리 출력
			bl print_char
			b print_integer_end

print_integer_end
			mov	r0, r5
			ldmfd sp!, {r1-r7,pc}




print_char
            
            stmfd   sp!, {r0,lr} 
                                    ; push the registers that 
                                    ; you want to save     
            adr     r1, char
            strb    r0, [r1]
            mov     r0, #3
            swi     0x123456

            ldmfd   sp!, {r0,pc} 			
			
char	    DCB     0

finish
		; Stnadard exit code : SWI 0x123456, calling routine 0x18
		; with argument 0x20026
		mov	r0, #0x18
		mov	r1, #0x20000	; build the "difficult" number
		add	r1, r1, #0x26	; in two stems
		SWI	0x123456		; "software interrupt" = sys
	
	
		END




