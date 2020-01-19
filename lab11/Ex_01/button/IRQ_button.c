#include "button.h"
#include "lpc17xx.h"
#include "../led/led.h"
#include "../timer/timer.h"

extern unsigned int i_val ;
extern unsigned int n_val ;
extern unsigned int j_val ;
extern int array[];
extern unsigned int array_index ;
extern unsigned int randomvalue;
unsigned int Previous_randomvalue;
unsigned int res= 0;
unsigned int GAP=0xBEBC20; // gap for btn bouncing
extern unsigned int LED_RW(unsigned int);

unsigned int lockbutton=0; // a boolean as lock to check while a btn clicked the other one is not clicking 

/******************************************************************************
** Function name:		lost
**
** Descriptions:	 wrong button is pressed so resets every thing 
**
** parameters:			None
** Returned value:		None
**
******************************************************************************/
void lost(void)
{
		 array_index=0;   
	  	i_val=0;	
			n_val=1;
		 all_LED_on();
		enable_timer(0);
}
/******************************************************************************
** Function name:		resultchecker
**
** Descriptions:	 check the clicked button to see if it is the correct one
**
** parameters:			#0 for btn 0 | #1 for btn 2 | #2 for btn 1  because of order of leds
** Returned value:		None
**
******************************************************************************/
void resultchecker(unsigned int num){
		
	if(lockbutton==0) // a boolean as lock to check while a btn clicked the other one is not clicking
	{
		lockbutton=1;
	if(i_val==n_val) // if the click result is equal to value 
	{ 
		
		
		if(array_index==n_val) // if this is first time and we need to come back to first index
		{
		array_index=0;  
		}
	 	else            // go for the next saved position of leds
		{
		array_index++;
		}
		   
		
	
		if(array[array_index]==num) // if right button clicked
		{		
			if(array_index==n_val-1) // check if all buttons are correct and go to next level
			{
				array_index=0;
				i_val=0;	
				n_val++;					// all right buttons are pressed
				enable_timer(0);   // get the next key to check
				
			}
			
   	 
		}else
		{
		lost();
		}
		
	
	}
	else{
	i_val=0;	
	enable_timer(0); // get the next key to check
	}
	lockbutton=0;
}
}


/*----------------------------------------------------------------------------
  Functions which get the click event of button 0
 *----------------------------------------------------------------------------*/
void EINT0_IRQHandler (void)	  
{
	
	if(randomvalue -Previous_randomvalue> GAP)
		 resultchecker(0);
	Previous_randomvalue=randomvalue; // set previous random value because of bouncing effect
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}

/*----------------------------------------------------------------------------
  Functions which get the click event of button 1
 *----------------------------------------------------------------------------*/
void EINT1_IRQHandler (void)	  
{
	   
	if(randomvalue -Previous_randomvalue> GAP)
		 resultchecker(2); // because of the order of leds used 2 instead of 1
	Previous_randomvalue=randomvalue;// set previous random value because of bouncing effect
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
}
/*----------------------------------------------------------------------------
  Functions which get the click event of button 2
 *----------------------------------------------------------------------------*/
void EINT2_IRQHandler (void)	  
{
  	if(randomvalue -Previous_randomvalue> GAP)
		 resultchecker(1); // because of the order of leds used 2 instead of 1
	Previous_randomvalue=randomvalue; // set previous random value because of bouncing effect
	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */    
}


