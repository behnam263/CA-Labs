 #include <stdio.h>
#include "LPC17xx.h"                    /* LPC17xx definitions                */
#include "led/led.h"
#include "button/button.h"
#include "timer/timer.h"
#include "ADC_DAC/adc_dac.h"
//#include "binconvert.h"

unsigned int ledvalue=0;
extern unsigned int i_val ;
extern unsigned int n_val ;
extern unsigned int j_val ;
extern unsigned int array_index ;
extern int arrayarray[3000];
extern unsigned int GAP;
extern unsigned int lockbutton;
int main(void){

	
 LED_init();								/* LED Initialization */
 BUTTON_init();						/* BUTTON Initialization */
 array_index=0;
 i_val = 0;  /* i value of game */
 n_val = 1; /* n value of game */
 j_val = 0; /* j value of game */
	lockbutton=0; // lock concept for one key
GAP=0xBEBC20;  // gap for btn bouncing
//	ADC_init();
//	DAC_init();
	
//	LPC_SC->PCON |= 0x1;	/* power-down mode */								
//	LPC_SC->PCON &= 0xFFFFFFFFD; 
//	SCB->SCR |= 0x2;			/* set SLEEPONEXIT */	
	
//	ADC_start_conversion();

	init_timer(0,0xBEBC20);			/* TIMER0 Initialization              */
  init_timer(1,0x000F4240);			/* TIMER1 Initialization              */
	enable_timer(1);
	
	
	
	//__ASM("wfi"); problem with timer when sleep
	 
	 while(1){
		 
	 }
	 
	 return 0;
}
