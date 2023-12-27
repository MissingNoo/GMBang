if (DEBUG) {
draw_text(10,10, debuginfo);
}
var _tx = 30;
var _ty = 30;
var _text = "Nome: ";
var _w = string_width(_text);
var _h = string_height(_text);
draw_text(_tx, _ty, _text);
_tx += _w;
_text = global.username;
_w = string_width(_text);
_h = string_height(_text);
_text = global.username + " (clique para mudar)";
draw_text(_tx, _ty, _text);
if(DEBUG){
	draw_rectangle(_tx, _ty, _tx + _w, _ty +_h, true);
}
if(point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0),_tx, _ty, _tx + _w, _ty + _h) and device_mouse_check_button_pressed(0, mb_left)){
	uname = get_string_async("Qual seu nome?","Teste");
}
if (!joinedRoom) {
	var _x = GW/2;
	var _y = GH/2 - 150;
    draw_rectangle(_x - 120, _y, _x + 120, _y + 300, true);
	draw_set_halign(fa_center);
	draw_text_transformed(_x, _y, "GMBang!", 1, 1, 0);
	draw_set_halign(fa_left);
	_y += 50;
	if (button(_x , _y, "Criar Sala", 1)) {
	    sendMessage({ command : Network.CreateRoom });
		if (DEBUG) {
		show_debug_message("creating room");
		}
	}
	_y += 20;
	draw_set_alpha(.25);
	draw_rectangle_color(_x - 50, _y - 2, _x + 50, _y + 100, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
	draw_rectangle_color(_x - 50, _y - 2, _x + 50, _y + 100, c_white, c_white, c_white, c_white, true);
	draw_set_halign(fa_center);
	draw_text(_x, _y, "Senha");
	draw_set_halign(fa_left);
	_y += 40;
	button(_x, _y, keyboard_string, 1);
	_y += 40;
	if (button(_x, _y, "Conectar", 1)) {
	    global.password = keyboard_string;
		sendMessage({ command : Network.JoinRoom, username : global.username, password : global.password });
	}
	exit;
}
if (joinedRoom) {
	draw_text(10, 30, $"Password: {global.password} / {players}");
	var _yoffset = 0;
	for (var i = 0; i < array_length(players); ++i) {
	    draw_text(10, 45 + _yoffset, players[i].username);
		_yoffset += 15;
	}
	if (button(GW/2, GH/2, "Iniciar!", 1)) {
	    sendMessage({command : Network.StartGame});
	}
}