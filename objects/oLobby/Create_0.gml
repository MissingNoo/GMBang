debuginfo = { a:1, b:1, c:1};
joinedRoom = false;
ishost = 0;
chattext = "";
chatmessages = [];
clicked = false;
password = "";
keyboard_string = "";
function button(_x, _y, text, fontsize){
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
