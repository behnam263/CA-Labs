#include "button.h"
#include "lpc17xx.h"
#include "../timer/timer.h"
extern unsigned int _MAX;
extern unsigned int ItemList[];
extern unsigned int PriceList[];
extern int sequentialSearch (unsigned int *x , unsigned int *y);
extern int binarySearch (unsigned int *x , unsigned int *y);
extern int counter;

void EINT0_IRQHandler (void)	  
{
	
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}

/*-------------------------------------------------------------------------
--			name:EINT1_IRQHandler
--			description: run sequntial search function and check with max value
--									 for the beep sound
---------------------------------------------------------------------------*/
void EINT1_IRQHandler (void)	  
{
	int result = sequentialSearch(PriceList,ItemList);
	if (result>_MAX)
	{
		//warning signal lasting 2 seconds
		counter =0;
		reset_timer(0);
		init_timer(0,1592);
		enable_timer(0);
		//--------------------------------
	}
	LPC_SC->EXTINT |= (1 << 1);     // clear pending interrupt         
}
/*-------------------------------------------------------------------------
--			name:EINT2_IRQHandler
--			description: run Binary search function and check with max value
--									 for the beep sound
---------------------------------------------------------------------------*/
void EINT2_IRQHandler (void)	  
{
	int result = binarySearch(PriceList,ItemList);
	if (result>_MAX)
	{
		//warning signal lasting 2 seconds
		counter =0;
		reset_timer(0);
		init_timer(0,1062);
		enable_timer(0);
		//--------------------------------
	}
	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */    
}


