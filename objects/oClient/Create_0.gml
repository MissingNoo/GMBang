randomize();
//global.serverip = "127.0.0.1";
global.serverip = "140.238.187.191";
global.port = 8888;
global.username = $"test {irandom(999)}";
global.roomname = "";
global.password = 0;
if (instance_number(oClient) > 1) { instance_destroy(); }

client = network_create_socket(network_socket_udp);
clientBuffer = buffer_create(4098, buffer_fixed, 1);
//connected = undefined;
try{
		connected = network_connect_raw(client, global.serverip, global.port);
		sendMessage({command : Network.Connection, username : global.username});
		keepalive = time_source_create(time_source_game, 5, time_source_units_seconds,function(){ sendMessage({command : Network.KeepAlive, roomname : global.roomname, username : global.username})}, [], -1);
		time_source_start(keepalive);
}
catch(error){
	show_message(error);
	show_message("Server not found!");
}