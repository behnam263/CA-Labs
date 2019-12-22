/*********************************************************************************************************
**--------------File Info---------------------------------------------------------------------------------
** File name:           IRQ_timer.c
** Descriptions:        interrupt handlers of Timer/Counter 0 and 1
** Correlated files:    timer.h
**--------------------------------------------------------------------------------------------------------
*********************************************************************************************************/
#include "lpc17xx.h"
#include "timer.h"
#include "../led/led.h"
unsigned int i_val  ;
unsigned int n_val  ;
unsigned int j_val  ;
int array[3000];
unsigned int array_index  ;
extern const unsigned long led_mask[] ;
unsigned int randomvalue;
unsigned int ison=0;

void ledticker(unsigned int num){
	 	
	if(i_val<n_val)
		{
			 if(ison==0 )
			{
				all_LED_off();
				LED_On(num+5);
				
				array[array_index]=num;
				i_val++;
				array_index++;
				enable_timer(0);	
				ison++;
			}
			else
			{
				ison=0;
				all_LED_off();
				if(i_val<n_val)
					enable_timer(0);
			}
		}else
		{
			ison=0;
		  all_LED_off();
		}

}


void TIMER0_IRQHandler (void)
{
	LPC_TIM0->IR = 1;			/* clear interrupt flag */
  ledticker(randomvalue%3);
  return;
}

void TIMER1_IRQHandler (void)
{
	//all_LED_off();
   randomvalue=LPC_TIM1->TC;
   //LPC_TIM1->IR = 1;			/* clear interrupt flag */
  return;
}

