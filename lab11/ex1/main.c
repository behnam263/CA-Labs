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
 i_val = 0;
 n_val = 1;
 j_val = 0;
	lockbutton=0;
GAP=0xBEBC20;
//	ADC_init();
//	DAC_init();
	
//	LPC_SC->PCON |= 0x1;	/* power-down mode */								
//	LPC_SC->PCON &= 0xFFFFFFFFD; 
//	SCB->SCR |= 0x2;			/* set SLEEPONEXIT */	
	
//	ADC_start_conversion();

	init_timer(0,0xBEBC20);			/* TIMER0 Initialization              */
  init_timer(1,0x000F4240);			/* TIMER1 Initialization              */
	enable_timer(1);
	
	
	
	//__ASM("wfi");
	 
	 while(1){
		 
	 }
	 
	 return 0;
}
