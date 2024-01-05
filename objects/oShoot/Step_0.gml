if (variable_instance_exists(self, "ex")){
    if (distance_to_point(ex, ey) < 20){
        instance_destroy();
    }
}