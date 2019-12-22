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
	
unsigned int checkbit(unsigned int test,unsigned int pos){
return(test) & (1<<pos);
}

void resultboard(void){
		LPC_GPIO2->FIOCLR = 0x00000003;
	  unsigned int rest=ReadLed();
if(((rest & 0x000000A8)==0x000000A8)||((rest & 0x00000054)==0x00000054))
			LED_On(0);
		else
			LED_On(1);	
}

void EINT0_IRQHandler (void)	  
{	if(counter-lastcounter0>Gap)
	{
 		LPC_GPIO2->FIOCLR = 0x0000000C;
		
 		randomnumb= counter & 1;
	  if(randomnumb==0)
			LED_On(3);
		else
			LED_On(2);
		resultboard();
	
  LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
	}	
	lastcounter0=counter;
}


void EINT1_IRQHandler (void)	  
{
	
	
	if(counter-lastcounter1>Gap)
	{
		LPC_GPIO2->FIOCLR = 0x000000C0;
		
		randomnumb= counter & 1;
	  if(randomnumb==0)
			LED_On(7);
		else
			LED_On(6);	
	resultboard();
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt    */  
	 
	}

	
	lastcounter1=counter;
}

void EINT2_IRQHandler (void)	  
{
	if(lastcounter2==counter)
	{
		LPC_GPIO2->FIOCLR = 0x00000030;
		
 		randomnumb= counter & 1;
	  if(randomnumb==0)
			LED_On(5);
		else
			LED_On(4);
		resultboard();
  LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
		 
	}
	lastcounter2=counter;
	
}




