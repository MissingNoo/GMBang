if(variable_instance_exists(self, "shootarrow")) {
	image_xscale = 2;
	image_yscale = 2;
	sprite_index = sArrowShoot;
}
if(variable_instance_exists(self, "arrows")) {
    for (var i = 0; i < array_length(arrow); i += 1) {
        draw_sprite_ext(sArrow, 0, arrow[i][0], arrow[i][1], arrow[i][2], arrow[i][2], 220, c_white, 1);
    }
}
else if(variable_instance_exists(self, "myturn")) {
	draw_sprite_ext(sTurn, 0, GW/2, GH/2, myturnsize, myturnsize, 0, c_white, 1);
    //draw_set_halign(fa_center);
    //draw_set_valign(fa_middle);
    //draw_text_transformed(GW/2, GH/2, "Seu Turno!", myturnsize, myturnsize, 0);
    //draw_set_halign(fa_left);
    //draw_set_valign(fa_top);
}
else {draw_self();}