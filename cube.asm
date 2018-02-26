#include "p16f84a.inc"

 __CONFIG _FOSC_XT & _WDTE_OFF & _PWRTE_OFF & _CP_OFF

 
    
 CBLOCK 	0x20 			;start of general purpose registers
    count1 			;These three are
    counta 			;used in delay routine 
    countb 			;you could also use count1 equ 0x20 etc
ENDC
    
    
MAIN_PROG CODE                      ; let linker place main program
 
START

	    ORG		0x00
	    BSF		STATUS,RP0 ;CONFIG BANK 1- I/O
	    
	    MOVLW	0x00 ; 11001100 -> 0xCC
	    MOVWF	TRISB
	    MOVLW	0x00
	    MOVWF	TRISA
	    
	    ;_________________
	    BCF		STATUS,RP0;CONFIG BANK 0
	    
	    
	    MOVLW	0x0
	    MOVWF	TRISB
	    CALL	DELAY
	    CALL	DELAY
	    CALL	DELAY
	    
	    
SEC1	    MOVLW	0xF
	    MOVWF	TRISA
	    CALL	ONESEC
	    GOTO	SEC2


SEC2	    CALL	COLUMN
	    MOVLW	0x1
	    MOVWF	TRISB
	    CALL	ONESEC
	    GOTO	SEC3

SEC3	    MOVLW	0x2
	    MOVWF	TRISB
	    CALL	ONESEC
	    GOTO	SEC4

SEC4	    MOVLW	0x4
	    MOVWF	TRISB
	    CALL	ONESEC
	    GOTO	SEC5

SEC5	    MOVLW	0x8
	    MOVWF	TRISB
	    CALL	ONESEC
	    GOTO	SEC6

SEC6	    MOVLW	0x10
	    MOVWF	TRISB
	    CALL	ONESEC
	    GOTO	SEC7	    

SEC7	    MOVLW	0x20
	    MOVWF	TRISB
	    CALL	ONESEC
	    GOTO	SEC8
	    
SEC8	    MOVLW	0x40
	    MOVWF	TRISB
	    CALL	ONESEC
	    
	    
	    GOTO	START
	    
	
	    


COLUMN	    
	    MOVLW	0xE
	    MOVWF	TRISA
	    RETURN
	   

ONESEC	    
	    CALL	DELAY
	    CALL	DELAY
	    CALL	DELAY
	    CALL	DELAY
	    RETLW	0x00 
	    
DELAY	MOVLW	d'250'		;delay 250 ms (4 MHz clock)
 	MOVWF	count1
 D1	MOVLW	0xC7
 	MOVWF	counta
 	MOVLW	0x01
 	MOVWF	countb
 DELAY_0
 	DECFSZ	counta, f
 	GOTO	$+2
 	DECFSZ	countb, f
 	GOTO	DELAY_0
 	DECFSZ	count1	,f
 	GOTO	D1
	RETLW	0x00
	END
	
	  