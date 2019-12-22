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
unsigned int GAP=0xBEBC20;
extern int converttobinary(unsigned int num);
extern unsigned int LED_RW(unsigned int);

unsigned int lockbutton=0;

unsigned int test_val ;

void lost(void)
{
		 array_index=0;   // wrong button is pressed
	  	i_val=0;	
			n_val=1;
		 all_LED_on();
		enable_timer(0);
}

int resultchecker(unsigned int num){
		
	if(lockbutton==0)
	{
		lockbutton=1;
	if(i_val==n_val)
	{ 
		
		
		if(array_index==n_val)
		{
		array_index=0;
		test_val=1;
		}
	 	else
		{	array_index++;
		test_val=2;
		}
		   
		
	
		if(array[array_index]==num)
		{		test_val=3;
			if(array_index==n_val-1)
			{
					test_val=4;
			//	LED_RW(converttobinary(n_val));
				array_index=0;
				i_val=0;	
				n_val++;					// all right buttons are pressed
				enable_timer(0);   // get the next key to check
					test_val=5;
				
			}
			
   	 
		}else
		{
		lost();
		}
		
	
	}
	else{
	i_val=0;	
	enable_timer(0);
	}
	lockbutton=0;
}
}



void EINT0_IRQHandler (void)	  
{
	
	if(randomvalue -Previous_randomvalue> GAP)
		 res=resultchecker(0);
	Previous_randomvalue=randomvalue;
	LPC_SC->EXTINT |= (1 << 0);     /* clear pending interrupt         */
}


void EINT1_IRQHandler (void)	  
{
	   
	if(randomvalue -Previous_randomvalue> GAP)
		 res=resultchecker(2); // because of the order of leds used 2 instead of 1
	Previous_randomvalue=randomvalue;
	LPC_SC->EXTINT |= (1 << 1);     /* clear pending interrupt         */
}

void EINT2_IRQHandler (void)	  
{
  	if(randomvalue -Previous_randomvalue> GAP)
		 res=resultchecker(1); // because of the order of leds used 2 instead of 1
	Previous_randomvalue=randomvalue;
	LPC_SC->EXTINT |= (1 << 2);     /* clear pending interrupt         */    
}


