#include <time.h>
#include <stdlib.h>

#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"
extern unsigned int led_value;
unsigned int  randomnumb;
extern unsigned int counter;
extern unsigned int ReadLed(void);
extern void WriteLed(unsigned int);
unsigned int lastcounter0;
unsigned int lastcounter1;
unsigned int lastcounter2;
unsigned int Gap=0x0020000;
unsigned int check_for_all_btns;
/*-----------------------------------------------------------
--
--		name: checkbit
--		description: checks if a bit is 1
--
-------------------------------------------------------------*/
unsigned int checkbit(unsigned int test,unsigned int pos){
return(test) & (1<<pos);
}
/*------------------------------------------------------------
--
--		name: setbit
--		description: set a bit to 1
--
--------------------------------------------------------------*/
unsigned int setbit(unsigned int test,unsigned int pos){
return(test) | (1<<pos);
}
/*------------------------------------------------------------------------
--
--		name: resultboard
--		description: if the pattern is ok turns related led 101010 or 010101
--
--------------------------------------------------------------------------*/
void resultboard(void){
		LPC_GPIO2->FIOCLR = 0x00000003;
	  unsigned int rest=ReadLed();
if(((rest & 0x000000A8)==0x000000A8)||((rest & 0x00000054)==0x00000054))
			LED_On(0);
		else
			LED_On(1);	
}
/*------------------------------------------------------------------------
--
--		name: EINT0_IRQHandler
--		description:randomly turn on led 2 or 3 and call result
--
--------------------------------------------------------------------------*/
void EINT0_IRQHandler (void)	  
{	
	check_for_all_btns= setbit(check_for_all_btns,0);
	if(counter-lastcounter0>Gap )
	{
 		LPC_GPIO2->FIOCLR = 0x0000000C;
		
 		randomnumb= counter & 1;
	  if(randomnumb==0)
			LED_On(3);
		else
			LED_On(2);
				if((check_for_all_btns & 0x00000007)==0x00000007)
		resultboard();
	
 
	}	
	lastcounter0=counter; 
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}

/*------------------------------------------------------------------------
--
--		name: EINT1_IRQHandler
--		description:randomly turn on led 6 or 7 and call result
--
--------------------------------------------------------------------------*/
void EINT1_IRQHandler (void)	  
{
	
		check_for_all_btns= setbit(check_for_all_btns,1);
	if(counter-lastcounter1>Gap)
	{
		LPC_GPIO2->FIOCLR = 0x000000C0;
		
		randomnumb= counter & 1;
	  if(randomnumb==0)
			LED_On(7);
		else
			LED_On(6);	
			if((check_for_all_btns & 0x00000007)==0x00000007)
		resultboard();

	 
	}

	
	lastcounter1=counter;	
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt    */  
}
/*------------------------------------------------------------------------
--
--		name: EINT1_IRQHandler
--		description:randomly turn on led 4 or 5 and call result
--
--------------------------------------------------------------------------*/
void EINT2_IRQHandler (void)	  
{
		check_for_all_btns= setbit(check_for_all_btns,2);
	if(counter-lastcounter2>Gap )
	{
		LPC_GPIO2->FIOCLR = 0x00000030;
		
 		randomnumb= counter & 1;
	  if(randomnumb==0)
			LED_On(5);
		else
			LED_On(4);
		if((check_for_all_btns & 0x00000007)==0x00000007)
		resultboard();
 
		 
	}
	lastcounter2=counter;
	 LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}




