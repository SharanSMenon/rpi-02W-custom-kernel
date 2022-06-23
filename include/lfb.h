void lfb_init();
void lfb_showpicture();
void lfb_print(int x, int y, char *s);
void lfb_pprint(int x, int y, char *s);
void lfb_draw_pixel(int x, int y, unsigned char attr);
void lfb_draw_rect(int x1, int y1, int x2, int y2, unsigned char attr, int fill);