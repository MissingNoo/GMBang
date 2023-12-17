if (DEBUG) {
	draw_text(10,10, $"{debuginfo} {global.playerid}");
}
var _currentPlayer = global.players[currentTurn].username;
draw_text(10, 30, $"Turno de: {_currentPlayer}");
draw_rectangle(GW/2 - 268, GH/2 - 131, GW/2 + 268, GH/2 + 131, true);
//draw_rectangle(GW/9.30, GH/6.20, GW/1.12, GH/1.185, true);
var _totalSaved = 0;
for (var i = 0; i < array_length(dices); ++i) {
    if (dices[i].saved) {
	    _totalSaved += 1;
	}
}
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
		    draw_sprite_ext(sDice, dices[i].face, dices[i].x, dices[i].y, 1, 1, 0, (resolvePhase and resolvingDice == i) ? c_green : c_white, pushingDice == i ? .5 : 1);
		}
	}
	var _yoffset = 0;
	for (var i = 0; i < array_length(dices); ++i) {
	    if (dices[i].saved) {
			var _w = sprite_get_width(sDice) / 2 + 6;
		    draw_sprite_ext(sDice, dices[i].face, dropArea[0] + _w, dropArea[1] + _w + _yoffset, 1, 1, 0, (resolvePhase and resolvingDice == i) ? c_green : c_white, pushingDice == i ? .5 : 1);
			_yoffset += 53;
		}
	}
}
if (pushingDice != -1) {
	draw_sprite_ext(sDice, dices[pushingDice].face, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, c_white, 1);
}
if (!rolling and global.players[currentTurn].port == global.playerid and global.players[currentTurn][$ "bombs"] >= 3 and button(GW/2 - 242, GH/2 - 150, $"Pular turno!", 1)) {
    sendMessage({ command : Network.NextTurn });
}
if (!rolling and global.players[currentTurn].port == global.playerid and global.players[currentTurn][$ "rolls"] > 0 and _totalSaved != array_length(dices) and global.players[currentTurn][$ "bombs"] < 3 and button(GW/2 - 242, GH/2 - 150, $"Rolar ({global.players[currentTurn][$ "rolls"]})", 1) ) {
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
if (!rolling and global.players[currentTurn].port == global.playerid and (global.players[currentTurn][$ "rolls"] == 0 or _totalSaved == array_length(dices)) and global.players[currentTurn][$ "bombs"] < 3 and !actions and button(GW/2 - 242, GH/2 - 150, $"Finalizar turno!", 1)) {
	var _gatling = 0;
	for (var i = 0; i < array_length(dices); ++i) {
		if (dices[i].face == Faces.Gatling) {
		    _gatling++;
		}
	    if (dices[i].face != Faces.Arrow and dices[i].face != Faces.Bomb and dices[i].face != Faces.Gatling) {
		    actions=true;
			resolvePhase = true;
			resolvingDice = 0;
		}
	}
	//sendMessage({ command : Network.NextTurn });
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
//for (var i = 0; i < array_length(positions); ++i) {
//	if (positions[i][0] == 0) {
//	    continue;
//	}
//	draw_rectangle(positions[i][0], positions[i][1], positions[i][0] + 100, positions[i][1] + 50, true);
//}
for (var i = 0; i < array_length(global.players); ++i) {
	//if (global.playerspos[i][$ "x"] != undefined) {
	var _x = positions[i][0];
	var _y = positions[i][1];
	if (global.playerspos[i][$ "endx"] == undefined) {
	    global.playerspos[i][$ "endx"] = _x;
		global.playerspos[i][$ "endy"] = _y;
	}
	var _color = i == currentTurn ? c_green : c_white;
	if(_color == c_green and currentTurn != myposition) { _color = c_yellow; }
	draw_rectangle_color(_x - 2, _y - 2, global.playerspos[i][$ "endx"], global.playerspos[i][$ "endy"], _color, _color, _color, _color, true);
	draw_rectangle(_x, _y, _x + 64, _y + 64, true);
	draw_sprite_stretched(sCharacters, global.players[i][$ "character"], _x, _y, 64, 64);
	_x += 74;
	var _name = global.players[i].username;
	draw_text(_x, _y, _name);
	draw_rectangle(_x, _y + string_height(_name), global.playerspos[i][$ "endx"] - 2, _y + string_height(_name) + 1, false);
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
	_y += 25;
	_x += string_width(_name) + 80;
	global.playerspos[i][$ "endx"] = _x + 2;
	global.playerspos[i][$ "endy"] = _y + 2;
	//}
}
#endregion

#region Resolve Phase
if (resolvePhase) {
	switch (dices[resolvingDice].face) {
	    case Faces.Hit1:
			if (global.players[canhit1[0]].life <= 0) {
			    canhit1[0]++;
				if (canhit1[0] == myposition) {
				    canhit1[0]++;
				}
			}
			if (global.players[canhit1[1]].life <= 0) {
			    canhit1[1]--;
				if (canhit1[1] == myposition) {
				    canhit1[1]--;
				}
			}
	        var _x = positions[canhit1[0]][0];
			var _xx = global.playerspos[canhit1[0]][$ "endx"];
			var _y = positions[canhit1[0]][1];
			var _yy = global.playerspos[canhit1[0]][$ "endy"];
			draw_rectangle_color(_x - 2, _y - 2, _xx, _yy, c_green , c_green , c_green , c_green, true);
			if (device_mouse_check_button_pressed(0, mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _xx, _yy)) {
			    sendMessage({ command : Network.Damage, port : global.players[canhit1[0]][$ "port"] });
				resolvingDice++;
				break;
			}
	        _x = positions[canhit1[1]][0];
			_xx = global.playerspos[canhit1[1]][$ "endx"];
			_y = positions[canhit1[1]][1];
			_yy = global.playerspos[canhit1[1]][$ "endy"];
			draw_rectangle_color(_x - 2, _y - 2, _xx, _yy, c_green , c_green , c_green , c_green, true);
			if (device_mouse_check_button_pressed(0, mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _xx, _yy)) {
			    sendMessage({ command : Network.Damage, port : global.players[canhit1[1]][$ "port"] });
				resolvingDice++;
				break;
			}
	        break;
	    case Faces.Hit2:
			if (global.players[canhit2[0]].life <= 0) {
			    canhit2[0]++;
				if (canhit2[0] == myposition) {
				    canhit2[0]++;
				}
			}
			if (global.players[canhit2[1]].life <= 0) {
			    canhit2[1]--;
				if (canhit2[1] == myposition) {
				    canhit2[1]--;
				}
			}
	        _x = positions[canhit2[0]][0];
			_xx = global.playerspos[canhit2[0]][$ "endx"];
			_y = positions[canhit2[0]][1];
			_yy = global.playerspos[canhit2[0]][$ "endy"];
			draw_rectangle_color(_x - 2, _y - 2, _xx, _yy, c_green , c_green , c_green , c_green, true);
			if (device_mouse_check_button_pressed(0, mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _xx, _yy)) {
			    sendMessage({ command : Network.Damage, port : global.players[canhit2[0]][$ "port"] });
				resolvingDice++;
				break;
			}
	        _x = positions[canhit2[1]][0];
			_xx = global.playerspos[canhit2[1]][$ "endx"];
			_y = positions[canhit2[1]][1];
			_yy = global.playerspos[canhit2[1]][$ "endy"];
			draw_rectangle_color(_x - 2, _y - 2, _xx, _yy, c_green , c_green , c_green , c_green, true);
			if (device_mouse_check_button_pressed(0, mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _xx, _yy)) {
			    sendMessage({ command : Network.Damage, port : global.players[canhit2[1]][$ "port"] });
				resolvingDice++;
				break;
			}
	        break;
		case Faces.Bomb:
			resolvingDice++;
			break;
		case Faces.Gatling:
			resolvingDice++;
			break;
		case Faces.Arrow:
			resolvingDice++;
			break;
		case Faces.Beer:
			for (var i = 0; i < array_length(global.players); ++i) {
			    _x = positions[i][0];
				_xx = global.playerspos[i][$ "endx"];
				_y = positions[i][1];
				_yy = global.playerspos[i][$ "endy"];
				draw_rectangle_color(_x - 2, _y - 2, _xx, _yy, c_green , c_green , c_green , c_green, true);
				if (device_mouse_check_button_pressed(0, mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _xx, _yy)) {
				    sendMessage({ command : Network.Heal, port : global.players[i][$ "port"] });
					resolvingDice++;
					break;
				}
			}
			break;
	    default:
	        // code here
	        break;
	}
	if (resolvingDice == array_length(dices)) {
		resolvePhase = false;
	    sendMessage({ command : Network.NextTurn });
	}
}
#endregion