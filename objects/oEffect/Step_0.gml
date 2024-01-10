if (variable_instance_exists(self, "ex") and sprite_index == sBullet){
    var _ex = variable_instance_get(self, "ex");
    var _ey = variable_instance_get(self, "ey");
    if (distance_to_point(_ex, _ey) < 20){
        instance_destroy();
    }
}