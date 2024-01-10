if(waitingPlayer != -1){
	var _show = true;
	if(global.players[oGame.myposition][$ "port"] == oGame.waitingPlayer){
		_show = true;
	}
	else{
		_show = false;
	}
	canInteract = _show
}
else{
	canInteract = true;
}
//updateHit();
if (keyboard_check_pressed(vk_f2)) {
    window_set_size(window_get_width()*1.25, window_get_height()*1.25);
	display_set_gui_size(1366, 768);
}
if (keyboard_check_pressed(vk_f3)) {
    window_set_size(window_get_width()*0.75, window_get_height()*0.75);
	display_set_gui_size(1366, 768);
}
var _mult = 1;
if (keyboard_check(vk_shift)) { _mult = 0.5; }
if (keyboard_check(vk_control)) { _mult = 0.01; }
if (keyboard_check(vk_alt)) { _mult = 10; }
var _a = (keyboard_check_pressed(vk_pageup) - keyboard_check_pressed(vk_pagedown)) * _mult;
debuginfo.a += _a;
var _b = (keyboard_check_pressed(vk_home) - keyboard_check_pressed(vk_end)) * _mult;
debuginfo.b += _b;
var _c = (keyboard_check_pressed(vk_insert) - keyboard_check_pressed(vk_delete)) * _mult;
debuginfo.c += _c;
var _d = (keyboard_check_pressed(vk_numpad7) - keyboard_check_pressed(vk_numpad8)) * _mult;
debuginfo.d += _d;
var _e = (keyboard_check_pressed(vk_numpad4) - keyboard_check_pressed(vk_numpad5)) * _mult;
debuginfo.e += _e;
//if (keyboard_check_pressed(vk_enter)) {
//    dices[array_length(dices)] = {
//		face : irandom_range(0, 5),
//		x : device_mouse_x_to_gui(0),
//		y : device_mouse_y_to_gui(0),
//		saved : false
//	}
//	show_debug_message(dices);
//}
if (keyboard_check_pressed(vk_f10)) {
	for (var i = 0; i < array_length(global.playerspos); ++i) {
	    global.playerspos[i][$ "x"] = undefined;
	}
}
if (keyboard_check_pressed(vk_enter)) {
    for (var i = 0; i < array_length(global.playerspos); ++i) {
	    if (global.playerspos[i][$ "x"] == undefined) {
			global.playerspos[i][$ "x"] = device_mouse_x_to_gui(0);
			global.playerspos[i][$ "y"] = device_mouse_y_to_gui(0);
			break;
		}
	}
}
if (rolling) {
    for (var i = 0; i < array_length(dices); ++i) {
		if (dices[i][$ "saved"]) {
		    continue;
		}
	    if (dices[i][$ "face"] <= sprite_get_number(sDice)) {
		    dices[i][$ "face"] += sprite_get_speed(sDice) / game_get_speed(gamespeed_fps);
		}
		if (dices[i][$ "face"] > sprite_get_number(sDice)) {
		    dices[i][$ "face"] = 0;
		}
	}
}
if (!firstRoll) {
	if (device_mouse_check_button(0, mb_left) and global.players[currentTurn].port == global.playerid) {
		var _yoffset = 0;
		for (var i = 0; i < array_length(dices); ++i) {
			var dice = dices[i];
			var _w = sprite_get_width(sDice);
			var _h = sprite_get_height(sDice);
		    if (pushingDice == -1 and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), dice[$ "x"] - _w, dice[$ "y"] - _h, dice[$ "x"] + _w, dice[$ "y"] + _h) and !dices[i].saved) {
				pushingDice = i;
			}
		}
		for (var i = 0; i < array_length(dices); ++i) {
			if (dices[i][$ "saved"]) {
			    var _w = sprite_get_width(sDice) / 2 + 6;
				var _isBomb = false;
				totalBombs = 0;
				var _callback = function(_val, _index) {
					if(_val[$ "face"] == Faces.Bomb){
						oGame.totalBombs++;
					}
				}
				array_foreach(dices, _callback);
				if(dices[i][$ "face"] == Faces.Bomb){
					if(global.players[myposition][$ "character"] == Characters.BlackJack and totalBombs < 3){
						_isBomb = false;
					}
					else{
						_isBomb = true;
					}
				}
			    if (pushingDice == -1 and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), dropArea[0], dropArea[1] + _yoffset, dropArea[0] + (_w * 2), dropArea[1] + (_w * 2) + _yoffset) and !_isBomb) {
					pushingDice = i;
				}
				_yoffset += 53;
			}
		}
	}

	if (pushingDice != -1 and device_mouse_check_button_released(0, mb_left) and global.players[currentTurn].port == global.playerid) {
		if (point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), dropArea[0], dropArea[1], dropArea[2], dropArea[3])) {
			var _alreadySaved = false;
			if(dices[pushingDice][$ "saved"]){_alreadySaved = true};
			dices[pushingDice][$ "saved"] = true;
			if(dices[pushingDice][$ "face"] == Faces.Bomb and !_alreadySaved){
				sendMessage({ command : Network.ChangeBomb, amount : 1 });
			}
			sendMessage({ command : Network.SaveDice, number : pushingDice, saved : dices[pushingDice][$ "saved"]});
		}
		else if (dices[pushingDice][$ "saved"]) {
			dices[pushingDice][$ "saved"] = false;
			if(dices[pushingDice][$ "face"] == Faces.Bomb){
				sendMessage({ command : Network.ChangeBomb, amount : -1 });
			}
			sendMessage({ command : Network.SaveDice, number : pushingDice, saved : dices[pushingDice][$ "saved"]});
		}
		pushingDice = -1;
	}
}
ability = global.players[myposition][$ "character"];
if(resolvePhase){firstRoll = true;}//pedro p2 crash