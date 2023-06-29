; ARM assembler

		AREA text, CODE
		; This section is called "text", and contains code
		ENTRY
		
	

		
		eor r0, r0, r0
		eor r1, r1, r1
		eor r2, r2, r2
		eor r3, r3, r3
		eor r4, r4, r4
		eor r5, r5, r5
		eor r6, r6, r6
		eor r7, r7, r7
		eor r8, r8, r8
		eor r9, r9, r9
		
start
		bl scan
		bl print_char
		cmp r0, #'0'
		addeq r9, r9, #1
		cmp r0, #'1'
		addeq r1, r1, #1
		cmp r0, #'2'
		addeq r2, r2, #1			
		cmp r0, #'3'
		addeq r3, r3, #1	
		cmp r0, #'4'
		addeq r4, r4, #1
		cmp r0, #'5'
		addeq r5, r5, #1	
		cmp r0, #'6'
		addeq r6, r6, #1	
		cmp r0, #'7'
		addeq r7, r7, #1
		cmp r0, #'8'
		addeq r8, r8, #1	
		cmp r0, #'9'
		addeq r6, r6, #1
		cmp r0, #' '
		beq set69
		b start
			

			
needset
		cmp r9, r1
		movlt r9, r1
		cmp r9, r2
		movlt r9, r2
		cmp r9, r3
		movlt r9, r3
		cmp r9, r4
		movlt r9, r4
		cmp r9, r5
		movlt r9, r5
		cmp r9, r6
		movlt r9, r6
		cmp r9, r7
		movlt r9, r7
		cmp r9, r8
		movlt r9, r8
		b print_needset
set69	
		add r6, r6, #1	
		mov r6, r6, LSR #1
		b needset
		
print_needset		
		mov r0, r9
		bl print_integer
		mov r0, #10
		bl print_char
		
scan
			stmfd	sp!, {lr}
			mov		r0, #7
			swi		0x123456
			ldmfd	sp!, {pc}
			
div_mod									;divisor and modulo
			
			stmfd   sp!, {r3-r9,lr}		;r0 <= r1/r2 Quotient
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
			ldmfd	sp!, {r3-r9,pc}

			
			
			
			
print_integer

			stmfd sp!, {r1-r9,lr}
			
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
			ldmfd sp!, {r1-r9,pc}




print_char
            
            stmfd   sp!, {r0-r1,lr} 
                                    ; push the registers that 
                                    ; you want to save     
            adr     r1, char
            strb    r0, [r1]
            mov     r0, #3
            swi     0x123456

            ldmfd   sp!, {r0-r1,pc} 			
			
char	    DCB     0



			


finish
		; Stnadard exit code : SWI 0x123456, calling routine 0x18
		; with argument 0x20026
		mov	r0, #0x18
		mov	r1, #0x20000	; build the "difficult" number
		add	r1, r1, #0x26	; in two stems
		SWI	0x123456		; "software interrupt" = sys
	
	
		END




			



					
			