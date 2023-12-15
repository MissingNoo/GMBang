function draw_window(x, y, xx, yy, title, titlesize = 25,titlePos = 15, fontsize = 1, backgroundAlpha = .35){
	draw_set_alpha(backgroundAlpha);
	draw_set_color(c_black);
	draw_rectangle(x, y, xx, yy, false);
	draw_set_alpha(1);
	draw_set_color(c_white);
	draw_rectangle(x, y, xx, titlesize, false);
	draw_rectangle(x, y, xx, yy, true);
	draw_set_color(c_teal);
	draw_set_valign(fa_middle);
	draw_text_transformed(x+10,(y + titlesize) / 2, title, fontsize,fontsize,0);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
}