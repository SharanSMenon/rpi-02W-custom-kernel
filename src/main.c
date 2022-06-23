#include "../include/uart.h"
#include "../include/mbox.h"
#include "../include/rand.h"
#include "../include/power.h"
#include "../include/lfb.h"
#include "../include/delays.h"
#include "../include/sprintf.h"

typedef enum { false, true } bool;

void main()
{
    char str[80];
    char ch = 0;

    uart_init();
    lfb_init();
    rand_init();

    int rd = rand(100, 200);

    sprintf(str, "Random Number = %d", rd);
    lfb_print(rd, 250, str);
    lfb_draw_rect(0,0,1023,763,0x03,0);

    int x = 0;
    bool decrease = false;

    while (1) {
        lfb_draw_rect(x,50,x+100,100,0x01,1);
        wait_msec_st(4000);
        lfb_draw_rect(x,50,x+100,100,0x00,1);
        if (x == 500) { decrease = true;}
        if (x == 0) { decrease = false;}
        x += decrease ? -1 : 1;
    }

    

}
