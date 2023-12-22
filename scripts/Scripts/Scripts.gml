global.loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Integer accumsan velit a tellus dignissim condimentum. Nam sed lorem pulvinar, consequat justo nec, eleifend tellus. Donec id tempus arcu. Nam sem nisl, vehicula ut metus ut, efficitur malesuada tellus. Quisque ligula ligula, porttitor quis congue mollis, tempor at libero. Etiam vitae nulla luctus, porttitor augue et, aliquam arcu. Vestibulum vitae luctus metus. Nullam eu scelerisque dui. Praesent iaculis nisl dictum odio dictum, eget euismod tellus volutpat. Maecenas diam nisl, blandit ac elementum vel, sodales ac nulla. Morbi eget leo euismod, dapibus risus at, consequat dui. Donec ac tristique erat. Praesent cursus justo mi, at volutpat purus placerat sed. Integer viverra vitae sem malesuada molestie. Maecenas ornare auctor libero vitae rhoncus"
//function pause_game(){ .gamePaused = !global.gamePaused; }
//function sine_wave(time, period, amplitude, midpoint) { return sin(time * 2 * pi / period) * amplitude + midpoint; }
//function cose_wave(time, period, amplitude, midpoint) {	return cos(time * 2 * pi / period) * amplitude + midpoint; }
//function open_keyboard(_sx, _sy, _ex, _ey, _var = "nullvar", _value = 0, _varr = ""){
	/*if (DEBUG) {
		draw_set_alpha(.3);
		draw_set_color(c_purple);
	    draw_rectangle(_sx, _sy, _ex, _ey, false);
		draw_set_color(c_white);
		draw_set_alpha(1);
	}
	if (point_in_rectangle(mouse_x, mouse_y, _sx, _sy, _ex, _ey) and device_mouse_check_button_pressed(0, mb_left)) {
		if (_varr != "") {
		    keyboard_string = variable_instance_get(self, _varr);
		}
		if (_var != "nullvar") {
		    variable_instance_set(self, _var, _value);
		}		
	    keyboard_virtual_show(kbv_type_default, kbv_returnkey_default, kbv_autocapitalize_none, false);
	}*/
//}
function button(_x, _y, text, fontsize){
	if(instance_exists(oGame) and !oGame.canInteract){
		exit;
	}
	var _clicked = false;
	var _w = (string_width(text) * fontsize) / 2 + 5;
	var _h = (string_height(text) * fontsize) / 2 + 3;
	draw_set_alpha(0.5);
	draw_rectangle_color(_x - _w, _y - _h, _x  + _w, _y + _h, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	draw_rectangle_color(_x - _w, _y - _h, _x  + _w, _y + _h, c_white, c_white, c_white, c_white, true);
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text_transformed(_x, _y, text, fontsize, fontsize, 0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	if (device_mouse_check_button_pressed(0, mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x - _w, _y - _h, _x  + _w, _y + _h)) {
	    _clicked = true;
	}
	return _clicked;
}
function gui_button(_x, _y, color, size){
	if(instance_exists(oGame) and !oGame.canInteract){ exit; }
	var _clicked = false;
	_w = sprite_get_width(sGuiButtonRim) * size;
	_h = sprite_get_height(sGuiButtonRim) * size;
	var _mouseHold = device_mouse_check_button(0, mb_left);
	var _mouseRelease = device_mouse_check_button_released(0, mb_left);
	var _mouseOnButton = point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _x  + _w, _y + _h);
	var _spr = 0;
	if(_mouseOnButton and !_mouseHold){
		_spr = 1;
	}
	if(_mouseOnButton and _mouseHold){
		_spr = 2;
	}
	if(_mouseOnButton and _mouseRelease){
		_clicked = true;
	}
	var _inside = sGuiButtonConfirm;
	var _icon = 0;
	switch(color){
		case c_red:
			_inside = sGuiButtonCancel;
			_icon = 1;
			break;
		case c_green:
			_inside = sGuiButtonConfirm;
			_icon = 0;
			break;
	}
	draw_sprite_ext(_inside, _spr, _x, _y, size, size, 0, c_white, 1);
	draw_sprite_ext(sGuiButtonIcon, _icon, _x, _y, size, size, 0, c_white, 1);
	draw_sprite_ext(sGuiButtonRim, 0, _x, _y, size, size, 0, c_white, 1);
	return _clicked;
}
