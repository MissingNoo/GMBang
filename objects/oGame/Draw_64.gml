var _x;
var _y;
var _xx;
var _yy;
var _cancel;
var _accept;
if (DEBUG) {
	draw_text(10,10, $"{debuginfo} {global.playerid}");
}
/*var _text = "";
switch(global.players[myposition][$ "job"]){
	case Roles.Sheriff:
		_text = "Sheriff";
		break;
	case Roles.Deputy:
		_text = "Deputy";
		break;
	case Roles.Outlaw:
		_text = "Outlaw";
		break;
	case Roles.Renegade:
		_text = "Renegade";
		break;
}
var _scale = 4;
draw_set_alpha(0.5);
draw_rectangle_color(GW/2 - 160, GH/2 - 50, GW/2 + 160, GH/2 + 50, c_black, c_black, c_black, c_black, false);
draw_set_alpha(1);
draw_rectangle(GW/2 - 160, GH/2 - 50, GW/2 + 160, GH/2 + 50, true);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);
draw_text_transformed(GW/2, GH/2, _text, _scale, _scale, 0);
draw_set_halign(fa_left);
draw_set_valign(fa_top);*/
var _currentPlayer = global.players[currentTurn].username;
draw_text(10, 30, $"Turno de: {_currentPlayer}");
draw_rectangle(GW/2 - 268, GH/2 - 131, GW/2 + 268, GH/2 + 131, true);
//draw_rectangle(GW/9.30, GH/6.20, GW/1.12, GH/1.185, true);
var _totalSaved = 0;
for (var i = 0; i < array_length(dices); ++i) {
    if (dices[i][$ "saved"]) {
	    _totalSaved += 1;
	}
}
draw_rectangle(dropArea[0], dropArea[1], dropArea[2], dropArea[3], true);
if (firstRoll) {
	var _yoffset = 0;
    for (var i = 0; i < array_length(dices); ++i) {
		var _w = sprite_get_width(sDice) / 2 + 6;
	    draw_sprite_ext(sDice, dices[i][$ "face"], dropArea[0] + _w, dropArea[1] + _w + _yoffset, 1, 1, 0, (resolvePhase and resolvingDice == i) ? c_green : c_white, pushingDice == i ? .5 : 1);
		_yoffset += 53;
	}
}
else {
	for (var i = 0; i < array_length(dices); ++i) {
		if (!dices[i][$ "saved"]) {
		    draw_sprite_ext(sDice, dices[i][$ "face"], dices[i][$ "x"], dices[i][$ "y"], 1, 1, 0, (resolvingDice != -1 and resolvingDice == i) ? c_green : c_white, pushingDice == i ? .5 : 1);
		}
	}
	var _yoffset = 0;
	for (var i = 0; i < array_length(dices); ++i) {
	    if (dices[i][$ "saved"]) {
			var _w = sprite_get_width(sDice) / 2 + 6;
		    draw_sprite_ext(sDice, dices[i][$ "face"], dropArea[0] + _w, dropArea[1] + _w + _yoffset, 1, 1, 0, (resolvingDice != -1 and resolvingDice == i) ? c_green : c_white, pushingDice == i ? .5 : 1);
			_yoffset += 53;
		}
	}
}
if (pushingDice != -1) {
	draw_sprite_ext(sDice, dices[pushingDice].face, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, c_white, 1);
}
if (canInteract and !rolling and global.players[currentTurn].port == global.playerid and global.players[currentTurn][$ "bombs"] >= 3 and button(GW/2 - 242, GH/2 - 150, $"Pular turno!", 1)) {
    sendMessage({ command : Network.NextTurn });
}
if (global.players[myposition][$ "life"] <= 0 and !rolling and global.players[currentTurn].port == global.playerid) {
	sendMessage({ command : Network.NextTurn });
}
if (global.players[myposition][$ "life"] > 0 and canInteract and !rolling and global.players[currentTurn].port == global.playerid and global.players[currentTurn][$ "rolls"] > 0 and _totalSaved != array_length(dices) and global.players[currentTurn][$ "bombs"] < 3 and button(GW/2 - 242, GH/2 - 150, $"Rolar ({global.players[currentTurn][$ "rolls"]})", 1) ) {
	if (!rolling) {
		switch(global.players[myposition][$ "character"]){
			case Characters.SidKetchum:
				sendMessage({ command : Network.UsedSkill });
				break;
			default:
				break;
		}
		var _saved = [];
		for (var i = 0; i < array_length(dices); ++i) {
		    if (dices[i].saved) {
			    array_push(_saved, [i, dices[i][$ "face"]]);
			}
		}
	    sendMessage({ command : Network.Roll, saved : json_stringify(_saved) });
	}
}
if (canInteract and !rolling and global.players[currentTurn].port == global.playerid and (global.players[currentTurn][$ "rolls"] == 0 or _totalSaved == array_length(dices)) and global.players[currentTurn][$ "bombs"] < 3 and !actions and !resolvePhase and button(GW/2 - 242, GH/2 - 150, $"Finalizar turno!", 1)) {
	if(global.players[myposition][$ "character"] == Characters.SuzyLafayette and !suzyRolled){
		sendMessage({ command : Network.UsedSkill });
		sendMessage({ command : Network.Heal, port : global.players[myposition][$ "port"] });
	}
	gatling = 0;
	for (var i = 0; i < array_length(dices); ++i) {
		if(dices[i][$ "face"] == Faces.Gatling){
			gatling++;
			var _gatlingMinimum = 3;
			if(global.players[myposition][$ "character"] == Characters.WillytheKid){
				_gatlingMinimum = 2;
			}
			if (gatling >= _gatlingMinimum and !usedGatling) {
				usedGatling = true;
				sendMessage({ command : Network.Gatling });
			}
		}
	    if (dices[i].face != Faces.Arrow and dices[i].face != Faces.Bomb and dices[i].face != Faces.Gatling) {
		    actions=true;
			resolvingDice = 0;
		}
		resolvePhase = true;
	}
	//sendMessage({ command : Network.NextTurn });
}
draw_sprite_ext(sArrow, 0, dropArea[0], dropArea[3] + 10, 1, 1, 0, c_white, 1);
draw_text_transformed(dropArea[0] + debuginfo.a, dropArea[3] + debuginfo.b, $": {arrows}", debuginfo.c, debuginfo.c, 0);
#region Draw Players
//for (var i = 0; i < array_length(positions); ++i) {
//	if (positions[i][0] == 0) {
//	    continue;
//	}
//	draw_rectangle(positions[i][0], positions[i][1], positions[i][0] + 100, positions[i][1] + 50, true);
//}
var characterInfo = -1;
for (var i = 0; i < array_length(global.players); ++i) {
	//if (global.playerspos[i][$ "x"] != undefined) {
	_x = positions[i][0];
	_y = positions[i][1];
	if (global.playerspos[i][$ "endx"] == undefined) {
	    global.playerspos[i][$ "endx"] = _x;
		global.playerspos[i][$ "endy"] = _y;
	}
	var _text = "";
	switch(global.players[i][$ "job"]){
		case Roles.Sheriff:
			_text = "Sheriff";
			break;
		case Roles.Deputy:
			_text = "Deputy";
			break;
		case Roles.Outlaw:
			_text = "Outlaw";
			break;
		case Roles.Renegade:
			_text = "Renegade";
			break;
	}
	var _color = i == currentTurn ? c_aqua : c_white;
	if(_color == c_aqua and currentTurn != myposition) { _color = c_aqua; }
	if(_color == c_white and _text == "Sheriff") { _color = c_yellow; }
	if(global.players[i][$ "customColor"] != undefined){ _color = global.players[i][$ "customColor"]; }
	//draw_rectangle_color(_x - 2, _y - 2, global.playerspos[i][$ "endx"], global.playerspos[i][$ "endy"], _color, _color, _color, _color, true);
	//draw_rectangle(_x, _y, _x + 64, _y + 64, true);
	draw_sprite_ext(sGuiMessage, 0, _x - 10, _y - 9, 2.58, 2, 0, c_white, 1);
	draw_sprite_stretched(sCharacters, global.players[i][$ "character"], _x, _y, 64, 64);
	if(point_in_rectangle(MX, MY, _x, _y, _x + 64, _y + 64)){
		characterInfo = i;
	}
	/* if(global.players[currentTurn][$ "mx"] != undefined){
		var _px = global.players[currentTurn][$ "mx"];
		var _py = global.players[currentTurn][$ "my"];
		if ((!rolling and resolvingDice != -1 and resolvingDice < array_length(dices)) 
			and (dices[resolvingDice][$ "face"] == Faces.Hit1 or dices[resolvingDice][$ "face"] == Faces.Hit2)
			and point_in_rectangle(_px, _py, positions[i][0], positions[i][1], global.playerspos[i][$ "endx"], global.playerspos[i][$ "endy"])) {
				_color = c_red;
		}
	} */
	draw_sprite_ext(sGuiMessage, 2, _x - 10, _y - 9, 2.58, 2, 0, _color, 1);
	if(_text == "Sheriff"){
		draw_sprite_ext(sSheriff, 0, _x, _y, 0.75, 0.75, 0, c_white, 1);
	}
	_x += 74;
	var _name = global.players[i].username;
	draw_text(_x, _y, _name);
	//draw_rectangle(_x, _y + string_height(_name), global.playerspos[i][$ "endx"] - 2, _y + string_height(_name) + 1, false);
	//draw_circle(_x + debuginfo.a, _y + debuginfo.b, debuginfo.c, true);
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
	if(i != myposition and _text != "Sheriff") {_text = "";}
	draw_text(_x - 220, _y - 25, _text);
	global.playerspos[i][$ "endx"] = _x + 2;
	global.playerspos[i][$ "endy"] = _y + 2;
	//}
	#region dice
	if ((!rolling and resolvingDice != -1 and resolvingDice < array_length(dices)) and (dices[resolvingDice][$ "face"] == Faces.Hit1 or dices[resolvingDice][$ "face"] == Faces.Hit2) and global.players[currentTurn][$ "mx"] != undefined) {
		_xx = positions[currentTurn][0];
		_yy = positions[currentTurn][1];
		var _xscale = MX >= positions[currentTurn][1] ? 2 : -2;
		draw_sprite_ext(sRevolver, 0, _xx + 32, _yy + 32, _xscale, 2, point_direction(_xx, _yy, global.players[currentTurn][$ "mx"], global.players[currentTurn][$ "my"]), c_white, 1);
	}
	#endregion
}
#endregion
//draw_sprite_ext(sMouseArrow, -1, MX, MY, 3, 3, 0, c_white, 1);
for (var i = 0; i < array_length(global.players); ++i) {
    if (i != myposition and global.players[i][$ "mx"] != undefined) {
		if (global.players[i][$ "mouseSprite"] != -1) {
		    draw_sprite_ext(sDice, global.players[i][$ "mouseSprite"], global.players[i][$ "mx"], global.players[i][$ "my"], 1, 1, 0, c_white, 0.5);
		}
		else{
			//draw_circle(global.players[i][$ "mx"], global.players[i][$ "my"], 3, false);
			draw_sprite_ext(sMouseArrow, -1, global.players[i][$ "mx"], global.players[i][$ "my"], 2, 2, 0, c_white, 1);
		}
	    
		draw_set_halign(fa_center);
		draw_text_transformed(global.players[i][$ "mx"], global.players[i][$ "my"] - 10, global.players[i][$ "username"], 0.5, 0.5, 0);
		draw_set_halign(fa_left);
	}
}
#region Resolve Phase
if (canInteract and resolvePhase) {
	if (global.players[myposition][$ "life"] <= 0) {sendMessage({ command : Network.NextTurn });}
	var _noaction = true;
	for (var i = 0; i < array_length(dices); i += 1) {
		if (dices[i][$ "face"] == Faces.Beer or dices[i][$ "face"] == Faces.Hit1 or dices[i][$ "face"] == Faces.Hit2 or (dices[i][$ "face"] == Faces.Gatling and global.players[myposition][$ "character"] == Characters.KitCarlson)){
			_noaction = false;
		}		
	}
	if (_noaction) {
		sendMessage({ command : Network.NextTurn });
	}
	var lastdice = resolvingDice;
	if(resolvingDice >= 0 and resolvingDice < array_length(dices)){
		switch (dices[resolvingDice].face) {
			case Faces.Hit1:
			case Faces.Hit2:
				var _distance = 0;
				if(dices[resolvingDice][$ "face"] == Faces.Hit1){
					_distance = 1;
				}
				if(dices[resolvingDice][$ "face"] == Faces.Hit2){
					_distance = 2;
				}
				can_hit(_distance);
				if(select_hit(dices[resolvingDice][$ "damage"])){break;}
				switch(global.players[myposition][$ "character"]){
					case Characters.RoseDoolan:
						can_hit(_distance + 1);
						if(select_hit(dices[resolvingDice][$ "damage"])){break;}
						break;
					case Characters.SlabtheKiller:
						if(global.players[myposition][$ "canUseSkill"] and have_beer() and button(GW/2, GH/2, "Dobrar Dano", 1)){
							for (var i = 0; i < array_length(dices); i += 1) {
								if(dices[i][$ "face"] == Faces.Beer and dices[i][$ "used"] == undefined){
									dices[i][$ "used"] = true;
									break;
								}							
							}
							dices[resolvingDice][$ "damage"] = 2;
							global.players[myposition][$ "canUseSkill"] = false;
							sendMessage({ command : Network.UsedSkill });
						}
						break;
				}
				break;
			case Faces.Bomb:
				resolvingDice++;
				break;
			case Faces.Gatling:
				if(global.players[myposition][$ "character"] == Characters.KitCarlson and gatling > 0){
					var _someoneHasArrows = false;
					for (var i = 0; i < array_length(global.players); ++i) {
						if(global.players[i][$ "arrows"] > 0){
							_someoneHasArrows = true;
						}
					}
					if(!_someoneHasArrows){resolvingDice++;}
					for (var i = 0; i < array_length(global.players); ++i) {
						if(global.players[i][$ "life"] <= 0 or global.players[i][$ "arrows"] <= 0){
							continue;
						}
						_x = positions[i][0];
						_xx = global.playerspos[i][$ "endx"];
						_y = positions[i][1];
						_yy = global.playerspos[i][$ "endy"];
						draw_rectangle_color(_x - 2, _y - 2, _xx, _yy, c_green , c_green , c_green , c_green, true);
						if (device_mouse_check_button_pressed(0, mb_left) and point_in_rectangle(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), _x, _y, _xx, _yy)) {
							var _amount = -1;
							if(gatling >= 3){_amount = -3};
							gatling = 0;
							sendMessage({ command : Network.AddArrow, amount : _amount, port : global.players[i][$ "port"] });
							instance_create_depth(0, 0, 0, oEffect, {shootarrow : true, target : [oGame.positions[oGame.currentTurn][0], oGame.positions[oGame.currentTurn][1]]});
							resolvingDice++;
							break;
						}
					}
				}
				else{
					resolvingDice++;
				}
				break;
			case Faces.Arrow:
				resolvingDice++;
				break;
			case Faces.Beer:
				if(global.players[myposition][$ "canUseSkill"] and global.players[myposition][$ "character"] == Characters.SlabtheKiller){
					if(button(GW/2, GH/2, "Nao usar cerveja", 1)){
						resolvingDice++;
					}
				}
				if(dices[resolvingDice][$ "used"] != undefined){ resolvingDice++; }
				beer();
				break;
			default:
				// code here
				break;
		}
	}
	if(lastdice != resolvingDice){
		sendMessage({ command : Network.CurrentDice, id : resolvingDice });
	}
	if (resolvingDice == array_length(dices)) {
		resolvePhase = false;
	    sendMessage({ command : Network.NextTurn });
	}
}
#endregion
if(waiting){
	var _username = "";
	for (var i = 0; i < array_length(global.players); i += 1) {
		if(global.players[i][$ "port"] == waitingPlayer){
			_username = global.players[i][$ "username"];
		}
	}
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);
	draw_text(GW/2, GH/2 - 50, $"Waiting for: {_username} : {ability}");
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}
#region Character Info
//draw_text(GW/2, GH/2, string(characterInfo));
if(characterInfo != -1){
	var _text = $"Personagem: {global.characterNames[global.players[characterInfo][$ "character"]]}. \n\nHabilidade:\n{global.skillsFull[global.players[characterInfo][$ "character"]]}";
	var _w = string_width_ext(_text, 15, 720);
	var _h = string_height_ext(_text, 15, 720);
	var _button = [GW/2 - (_w / 2), GH/2 - (_h / 2), _w + 50, _h + 30];
	draw_sprite_stretched(sGuiMessage, 0, _button[0], _button[1], _button[2], _button[3]);
	draw_sprite_stretched(sGuiMessage, 1, _button[0], _button[1], _button[2], _button[3]);
	draw_text_ext(_button[0] + 25, _button[1] + 15, _text, 15, 720);
}
#endregion
#region skills
if (waiting or global.players[myposition][$ "character"] == Characters.CalamityJanet or global.players[myposition][$ "character"] == Characters.SidKetchum){}
else{exit;}
switch(ability){
	case Characters.BartCassidy:
		_cancel = { command : Network.Waiting, player : global.players[myposition][$ "port"], waiting : false };
		_accept = [{ command : Network.Heal, port : global.players[myposition][$ "port"] }, 
			{ command : Network.AddArrow, amount : 1, port : global.players[myposition][$ "port"] },
			{ command : Network.Waiting, player : global.players[myposition][$ "port"], waiting : false}];
		gui_button_question(_accept, _cancel);
		break;
	case Characters.PedroRamirez:
		if(global.players[myposition][$ "arrows"] > 0){
			_cancel = { command : Network.Waiting, player : global.players[myposition][$ "port"], waiting : false};
			_accept = [
				{ command : Network.AddArrow, amount : -1, port : global.players[myposition][$ "port"] },
				{ command : Network.Waiting, player : global.players[myposition][$ "port"], waiting : false}
			];
			if (gui_button_question(_accept, _cancel)) {
			    instance_create_depth(0, 0, 0, oEffect, {shootarrow : true, target : [oGame.positions[oGame.currentTurn][0], oGame.positions[oGame.currentTurn][1]]});
			}
		}
		else{
			sendMessage({ command : Network.Waiting, player : global.players[myposition][$ "port"], waiting : false});
		}
		break;
	case Characters.CalamityJanet: // not showing button
		if(resolvingDice < 0 or resolvingDice == array_length(dices) or currentTurn != myposition){break;}
		var _face = dices[resolvingDice][$ "face"];
		if((_face == Faces.Hit1 or _face == Faces.Hit2) and resolvePhase and !rolling and button(GW/2, GH/2, "Trocar dado", 1)){
			switch (_face){
				case Faces.Hit1:
					_face = Faces.Hit2;
					break;
				case Faces.Hit2:
					_face = Faces.Hit1;
					break;
			}
			sendMessage({ command : Network.ChangeDice, id : resolvingDice, face : _face});
		}
		break;
	case Characters.SidKetchum:
		if(currentTurn != myposition){break;}
		if(global.players[myposition][$ "canUseSkill"]){
			var _button = [GW/2 - 190, GH/2 - 65, 4.50, 2];
			draw_sprite_ext(sGuiMessage, 0, _button[0], _button[1], _button[2], _button[3], 0, c_white, 1);
			draw_sprite_ext(sGuiMessage, 1, _button[0], _button[1], _button[2], _button[3], 0, c_white, 1);
			draw_text_ext_transformed(_button[0] + 25, _button[1] + 15, global.skills[global.players[myposition][$ "character"]], 15, 263, 1.5, 1.5, 0);
			if(beer()){
				global.players[myposition][$ "canUseSkill"] = false;
				sendMessage({ command : Network.UsedSkill });
			}
		}
		break;
}
#endregion