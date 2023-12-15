DEBUG
draw_text(10,10, debuginfo);
ENDDEBUG
draw_rectangle(GW/2 - 268, GH/2 - 131, GW/2 + 268, GH/2 + 131, true);

draw_rectangle(dropArea[0], dropArea[1], dropArea[2], dropArea[3], true);
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
if (pushingDice != -1) {
    draw_sprite_ext(sDice, dices[pushingDice].face, device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), 1, 1, 0, c_white, 1);
}