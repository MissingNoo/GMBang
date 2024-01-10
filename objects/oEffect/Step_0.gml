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