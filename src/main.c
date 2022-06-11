#include "../include/uart.h"
#include "../include/mbox.h"
#include "../include/rand.h"
#include "../include/power.h"
#include "../include/lfb.h"

void main()
{
    uart_init();
    lfb_init();
    lfb_print(80, 80, "Hello World!");
    drawRect(150,250,400,400,0x03,0);


    while (1) {
        uart_send(uart_getc());
    }

}