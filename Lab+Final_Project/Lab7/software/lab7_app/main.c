// Main.c - makes LEDG0 on DE2-115 board blink if NIOS II is set up correctly
// for ECE 385 - University of Illinois - Electrical and Computer Engineering
// Author: Zuofu Cheng

//int main()
//{
//	int i = 0;
//	volatile unsigned int *LED_PIO = (unsigned int*)0x90; //make a pointer to access the PIO block
//
//	*LED_PIO = 0; //clear all LEDs
//	while ( (1+1) != 3) //infinite loop
//	{
//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO |= 0x1; //set LSB
//		for (i = 0; i < 100000; i++); //software delay
//		*LED_PIO &= ~0x1; //clear LSB
//	}
//	return 1; //never gets here
//}


int main()
{
	volatile unsigned int *LED_PIO = (unsigned int*)0x90;
	volatile unsigned int *SW_PIO = (unsigned int*)0x80;
	volatile unsigned int *Reset_PIO = (unsigned int*)0x70;		// Reset signal corresponds to KEY[2]
	volatile unsigned int *Accum_PIO = (unsigned int*)0x60;		// Accumulation signal corresponds to KEY[3]
	int accumulator = 0;

	*LED_PIO = 0; //clear all LEDs

	while (1)
	{
		if (*Reset_PIO == 0) {
			accumulator = 0;
		} else if (*Accum_PIO == 0) {
			while (*Accum_PIO == 0) {
				continue;
			}
			accumulator += *SW_PIO;
		} else {
			continue;
		}

		*LED_PIO = accumulator;
	}

	return 1;
}
