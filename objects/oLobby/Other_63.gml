var i_d = ds_map_find_value(async_load, "id");
switch(i_d){
    case uname:
        if (ds_map_find_value(async_load, "status")){
            if (ds_map_find_value(async_load, "result") != ""){
                global.username = ds_map_find_value(async_load, "result");
            }
        }
        break;
    case uip:
        if (ds_map_find_value(async_load, "status")){
            if (ds_map_find_value(async_load, "result") != ""){
                global.serverip = ds_map_find_value(async_load, "result");
            }
        }
        break;
    case uport:
        if (ds_map_find_value(async_load, "status")){
            if (ds_map_find_value(async_load, "result") != ""){
                global.port = ds_map_find_value(async_load, "result");
            }
        }
        break;
}