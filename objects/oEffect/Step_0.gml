if(variable_instance_exists(self, "arrows")) {
    for (var i = 0; i < array_length(arrow); i += 1) {
        arrow[i][1] += 25;
    }
}
if(variable_instance_exists(self, "myturn")) {
    myturnsize = lerp(myturnsize, 3, 0.1);
    if(myturnsize == 3) {instance_destroy();}
}
switch(sprite_index){
    case sBullet:
        if (variable_instance_exists(self, "ex")){
            var _ex = variable_instance_get(self, "ex");
            var _ey = variable_instance_get(self, "ey");
            if (distance_to_point(_ex, _ey) < 10){
                instance_destroy();
            }
        }
        break;
    case sBeerBreak:
        if(!played){
            played = true;
            audio_play_sound(snd_glass_break, 1, false, 1);
        }
        break;
    case sArrowShoot:
        if(!played){
			oGame.arrowsLastTurn = oGame.arrows;
            played = true;
			x = choose(0, room_width);
			y = choose(0, room_height);
			direction = point_direction(x, y, target[0] + 32, target[1] + 32);
			image_angle = direction;
			speed = 20;
        }
		if (distance_to_point(target[0] + 32, target[1] + 32) < 10) {
		    audio_play_sound(snd_arrow_hit, 1, false, 1);
			instance_destroy();
		}
        break;
}