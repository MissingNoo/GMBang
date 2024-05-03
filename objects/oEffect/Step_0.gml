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
            audio_play_sound(glass_break, 1, false, 1);
        }
        break;
}