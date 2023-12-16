DEBUG
draw_text(10,10, $"{debuginfo} {global.playerid}");
ENDDEBUG
var _currentPlayer = global.players[currentTurn].username;
draw_text(10, 30, $"Turno de: {_currentPlayer} {currentTurn}");
draw_rectangle(GW/2 - 268, GH/2 - 131, GW/2 + 268, GH/2 + 131, true);
//draw_rectangle(GW/9.30, GH/6.20, GW/1.12, GH/1.185, true);

draw_rectangle(dropArea[0], dropArea[1], dropArea[2], dropArea[3], true);
if (firstRoll) {
	var _yoffset = 0;
    for (var i = 0; i < array_length(dices); ++i) {
		var _w = sprite_get_width(sDice) / 2 + 6;
	    draw_sprite_ext(sDice, dices[i].face, dropArea[0] + _w, dropArea[1] + _w + _yoffset, 1, 1, 0, c_white, pushingDice == i ? .5 : 1);
		_yoffset += 53;
	}
}
else {
	for (var i = 0; i < array_length(dices); ++i) {
		if (!dices[i].saved) {
		    draw_sprite_ext(sDice, dices[i].face, dices[i].x, dices[i].y, 1, 1, 0, c_white, pushingDice == i ? .5 : 1);
		}
	}
	var _yoffset = 0;
	for (var i = 0; i < array_length(dices); ++i) {
	    if (dices[i].saved) {
			var _w = sprite_get_width(sDice) / 2 + 6;
		    draw_sprite_ext(sDice, dices[i].face, dropArea[0] + _w, dropArea[1] + _w + _yoffset, 1, 1, 0, c_white, pushingDice == i ? .5 : 1);
			_yoffset += 53;
		}
	}
}
if (pushingDice != -1) {
	draw_sprite_ext(sDice, dices[pushingDice].face, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, c_white, 1);
}
if (global.players[currentTurn].port == global.playerid and global.players[currentTurn][$ "bombs"] >= 3 and button(GW/2 - 242, GH/2 - 150, $"Pular turno!", 1)) {
    sendMessage({ command : Network.NextTurn });
}
if (global.players[currentTurn].port == global.playerid and global.players[currentTurn][$ "rolls"] > 0 and global.players[currentTurn][$ "bombs"] < 3 and button(GW/2 - 242, GH/2 - 150, $"Rolar ({global.players[currentTurn][$ "rolls"]})", 1) ) {
	if (!rolling) {
		var _saved = [];
		for (var i = 0; i < array_length(dices); ++i) {
		    if (dices[i].saved) {
			    array_push(_saved, i);
			}
		}
	    sendMessage({ command : Network.Roll, saved : json_stringify(_saved) });
	}
}
if (global.players[currentTurn].port == global.playerid and global.players[currentTurn][$ "rolls"] == 0 and global.players[currentTurn][$ "bombs"] < 3 and actions == 0 and button(GW/2 - 242, GH/2 - 150, $"Finalizar turno!", 1)) {
	sendMessage({ command : Network.NextTurn });
}
for (var i = 0; i < array_length(global.players); ++i) {
    if (global.players[i][$ "mx"] != undefined) {
		if (global.players[i][$ "mouseSprite"] != -1) {
		    draw_sprite_ext(sDice, global.players[i][$ "mouseSprite"], global.players[i][$ "mx"], global.players[i][$ "my"], 1, 1, 0, c_white, 0.5);
		}
		else{
			draw_circle(global.players[i][$ "mx"], global.players[i][$ "my"], 3, false);
		}
	    
		draw_set_halign(fa_center);
		draw_text_transformed(global.players[i][$ "mx"], global.players[i][$ "my"] - 10, global.players[i][$ "username"], 0.5, 0.5, 0);
		draw_set_halign(fa_left);
	}
}
#region Draw Players
for (var i = 0; i < array_length(global.players); ++i) {
	if (global.playerspos[i][$ "x"] != undefined) {
	var _x = global.playerspos[i][$ "x"];
	var _y = global.playerspos[i][$ "y"];
	if (global.playerspos[i][$ "endx"] == undefined) {
	    global.playerspos[i][$ "endx"] = _x;
		global.playerspos[i][$ "endy"] = _y;
	}
	draw_rectangle(_x - 2, _y - 2, global.playerspos[i][$ "endx"], global.playerspos[i][$ "endy"], true);
	draw_rectangle(_x, _y, _x + 64, _y + 64, true);
	_x += 74;
	var _name = global.players[i].username;
	draw_text(_x, _y, _name);
	draw_rectangle(_x, _y + string_height(_name), _x + string_width(_name), _y + string_height(_name) + 1, false);
	_y += string_height(_name) + 5;
	var _offset = 0;
	for (var j = 0; j < global.players[i][$ "life"]; ++j) {
	    draw_sprite_ext(sBullet, 0, _x + _offset, _y, .75, 0.75, 0, c_white, 1);
		_offset += 15;
	}
	_offset = 0;
	_y += 40;
	for (var j = 0; j < global.players[i][$ "arrows"]; ++j) {
	    draw_sprite_ext(sArrow, 0, _x - 10 + _offset, _y, 0.70, 0.70, 45, c_white, 1);
		_offset += 15;
	}
	_x += string_width(_name) + 80;
	global.playerspos[i][$ "endx"] = _x + 2;
	global.playerspos[i][$ "endy"] = _y + 2;
	}
}
#endregion