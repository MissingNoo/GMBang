var i_d = ds_map_find_value(async_load, "id");
if (i_d == uname){
    if (ds_map_find_value(async_load, "status")){
        if (ds_map_find_value(async_load, "result") != ""){
            global.username = ds_map_find_value(async_load, "result");
        }
    }
}