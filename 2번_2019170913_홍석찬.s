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
num1
			bl	scan ;; "branch+link" = subroutine call, scan num1
			bl 	print_char
			mov r1, #10	
			cmp r0, #' '		;get char until get 'space'
			beq num2
			sub	r2, r0, #'0'	;ASCII to integer
			mla r7, r1, r7, r2	;decimal number
			b	num1
num2							;scan num2
			bl	scan
			bl 	print_char
			mov r1, #10	
			cmp r0, #' '
			beq num3
			sub	r3, r0, #'0'		
			mla r8, r1, r8, r3
			b	num2
			
num3							;scan num3
			bl	scan
			bl 	print_char
			mov r1, #10	
			cmp r0, #' '
			beq num4
			sub	r4, r0, #'0'		
			mla r9, r1, r9, r4
			b	num3
			
num4							;scan num4
			bl	scan
			bl 	print_char
			mov r1, #10	
			cmp r0, #' '
			beq num5
			sub	r5, r0, #'0'		
			mla r10, r1, r10, r5
			b	num4
num5							;scan num5
			bl	scan
			bl 	print_char
			mov r1, #10	
			cmp r0, #' '
			beq scan_end
			sub	r6, r0, #'0'		
			mla r11, r1, r11, r6
			b	num5
			
								
scan_end

			
			mov r0, #0
loop_num1			
			mov r2, #2
			cmp r7, #1
			beq loop_num2
num1_loop_i						;for ( i=2; i <= num1; i++ )
			mov r1, r7
			mov	r3, r0
			bl	div_mod
			mov	r0, r3
			cmp	r1, #0		;if (num1 % i == 0) 
			beq mod_num1_is_0	;break
			add	r2, r2,	#1
			b	num1_loop_i
			
mod_num1_is_0				
			cmp r7, r2		;if(num == i)
			beq count1
			b	loop_num2
count1							;count++;
			add r0, r0, #1
			b	loop_num2


loop_num2			
			mov r2, #2
			cmp r8, #1
			beq loop_num3
num2_loop_i						;for ( i=2; i <= num1; i++ )
			mov r1, r8
			mov	r3, r0
			bl	div_mod
			mov	r0, r3
			cmp	r1, #0		;if (num1 % i == 0) 
			beq mod_num2_is_0	;break
			add	r2, r2,	#1
			b	num2_loop_i
			
mod_num2_is_0				
			cmp r8, r2		;if(num == i)
			beq count2
			b	loop_num3
count2							;count++;
			add r0, r0, #1
			b	loop_num3
			

loop_num3			
			mov r2, #2
			cmp r9, #1
			beq loop_num4
num3_loop_i						;for ( i=2; i <= num1; i++ )
			mov r1, r9
			mov	r3, r0
			bl	div_mod
			mov	r0, r3
			cmp	r1, #0		;if (num1 % i == 0) 
			beq mod_num3_is_0	;break
			add	r2, r2,	#1
			b	num3_loop_i
			
mod_num3_is_0				
			cmp r9, r2		;if(num == i)
			beq count3
			b	loop_num4
count3							;count++;
			add r0, r0, #1
			b	loop_num4
			
loop_num4			
			mov r2, #2
			cmp r10, #1
			beq loop_num5
num4_loop_i						;for ( i=2; i <= num1; i++ )
			mov r1, r10
			mov	r3, r0
			bl	div_mod
			mov	r0, r3
			cmp	r1, #0		;if (num1 % i == 0) 
			beq mod_num4_is_0	;break
			add	r2, r2,	#1
			b	num4_loop_i
			
mod_num4_is_0				
			cmp r10, r2		;if(num == i)
			beq count4
			b	loop_num5
			
count4							;count++;
			add r0, r0, #1
			b	loop_num5
			
loop_num5			
			mov r2, #2
			cmp r11, #1
			beq loop_end
num5_loop_i						;for ( i=2; i <= num1; i++ )
			mov r1, r11
			mov	r3, r0
			bl	div_mod
			mov	r0, r3
			cmp	r1, #0		;if (num1 % i == 0) 
			beq mod_num5_is_0	;break
			add	r2, r2,	#1
			b	num5_loop_i
			
mod_num5_is_0				
			cmp r11, r2		;if(num == i)
			beq count5
			b	loop_end
			
count5							;count++;
			add r0, r0, #1
			b	loop_end
			

loop_end
			mov r2, r0;;count 수 저장해두기
			mov r0, #91
			bl print_char
			mov r0, r2
			bl print_integer
			mov r0, #93
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
start_div								;subtract until r2>1
			cmp	r2, r1
			bgt div_end					;if r2>r1, r1 is remainder
			sub	r1, r1, r2
			add r0, r0, #1				;Quotient + 1
			bl	start_div
			
div_end
			ldmfd	sp!, {r3-r7,pc}
			
print_integer
			stmfd sp!, {r1-r5,lr}
			mov r5, r0
			mov r4, #0
			cmp r0, #10					;if r0 < 10 it is char data
			blt print_integer_2
			b	loop_div

print_integer_2
			add r0, r0, #'0'			;integer to ASCII
			bl	print_char
			b	print_integer_end

loop_div
			mov r1, r0
			mov r2, #10
			bl div_mod					
			
			mov r3, r1					;r3 = r0 mod 10 = unit digit
			stmfd sp!, {r3}				;push unit digit
			add r4, r4, #1				;loop count +1
			cmp r0, #0					;repeat until diviend < 10
			bgt loop_div
			
loop_div_end
			cmp r4, #0					;repeat until loop count =0
			beq print_integer_end
			
			ldmfd sp!, {r3}				;pop
			add r3, r3, #'0'			;integer to ASCII
			mov r0, r3
			bl print_char				;print_char
			sub r4, r4, #1				;loop count -1
			b loop_div_end
			
print_integer_end
			mov	r0, r5
			ldmfd sp!, {r1-r5,pc}



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
		