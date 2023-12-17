//global.serverip = "140.238.187.191";
//global.serverip = "192.168.0.103";
//global.port = 64198;
// Feather disable GM2044
// Feather disable GM2017
enum Network {
	KeepAlive,
	Connection,
    Disconnect,
    CreateRoom,
    JoinRoom,
	StartGame,
	Roll,
	Mouse,
	SaveDice,
	NextTurn,
	AddArrow,
	UpdatePlayers,
	Damage,
	Heal
}
function clientReceivedPacket2(_response)
{
	//show_debug_message(string(_response));
	var r = json_parse(_response);
	switch (r[$ "command"]) {
	    //case Network.ListRooms:
	    //    oLobby.rooms = r[$ "rooms"];
		//	global.socket = r[$ "socket"];
		//	//show_debug_message(r[$"socket"]);
	    //    break;
		case Network.Roll:
			oGame.rolling = true;
			oGame.alarm[0] = 100;
			oGame.result = json_parse(r[$ "dicejson"]);
			oGame.firstRoll = false;
			break;
		case Network.JoinRoom:{
			global.roomname = r[$ "roomname"];
			DEBUG
			show_debug_message($"joining room {global.roomname}");
			ENDDEBUG
			oLobby.players = json_parse(r[$ "players"]);
			oLobby.ishost = r[$ "isHost"];
			oLobby.joinedRoom = true;
			//keyboard_string = "";
			//oLobby.chatmessages = [];
			break;
		}
		case Network.CreateRoom:
			global.roomname = r[$ "roomname"];
			global.password = r[$ "password"];
			DEBUG
			show_debug_message($"created room {global.roomname} password: {global.password}");
			ENDDEBUG
			sendMessage({ command : Network.JoinRoom, username : global.username, password : global.password });
			break;
		
		case Network.StartGame:{
			global.players = oLobby.players;
			global.playerid = r[$ "socket"];
			room_goto(rGame);
			break;}
			
		case Network.Mouse:
			for (var i = 0; i < array_length(global.players); ++i) {
			    if (global.players[i].port == r[$ "socket"]) {
				    global.players[i].mx = r[$ "x"];
				    global.players[i].my = r[$ "y"];
					global.players[i].mouseSprite = r[$ "sprite"];
				}
			}
			break;
		case Network.SaveDice:
			oGame.dices[r[$ "number"]][$ "saved"] = r[$ "saved"];
			break;
		case Network.NextTurn:
			oGame.currentTurn = r[$ "turn"];
			oGame.firstRoll = true;
			oGame.actions = 0;
			oGame.resolvingDice = 0;
			oGame.resolvePhase = false;
			for (var i = 0; i < array_length(oGame.dices); ++i) {
			    oGame.dices[i].saved = false;
			}
			break;
		case Network.UpdatePlayers:
			global.players = json_parse(r[$ "players"]);
			break;
		// case Network.PlayerJoined:{
		//		reset_timer();
		//		reset_pool();
		//		with (oEnemy) {
		//		    instance_destroy();
		//		}
		//		var _sockett = r[$ "socket"];
		//		var _slave = instance_create_layer(playerSpawn[0], playerSpawn[1], "Instances", oSlave);
		//		ds_map_add(socketToInstanceID, _sockett, _slave.id);
		//		//show_message(_socket);
		//		_slave.socket = _sockett;
		//		break;}
				
		//case Network.PlayerMoved:{
		//	//show_debug_message(r);
		//	var _s = r[$ "socket"];
		//	var _x = r[$ "x"];
		//	var _y = r[$ "y"];
		//	var _spr = r[$ "sprite"];
		//	var _scale = r[$ "image_xscale"];
		//	var _sock = r[$ "socket"];
		//	var _spd = r[$ "spd"];
			
		//	if (!instance_exists(oSlave)) {
		//		instance_create_layer(0,0, "Instances", oSlave,{socket : _sock});
		//	}
			
		//	//show_debug_message("S:{0} X: {1} Y:{2}", _s, _x, _y);
		//	if (instance_exists(oPlayer) and _sock != oClient.connected and instance_exists(oSlave)) {
		//		oSlave.xx = _x;
		//		oSlave.yy = _y;
		//		oSlave.spd = _spd;
		//		oSlave.sprite_index = _spr;
		//		oSlave.image_xscale = _scale;
		//	}
		//	break;
		//}
		
		//case Network.SpawnUpgrade:{
		//	var _upg = instance_create_layer(r[$ "x"], r[$ "y"], "Instances", oSlaveUpgrade);
		//	_upg.upgID = r[$ "upgID"];
		//	_upg.sprite_index = r[$ "sprite_index"];
		//	_upg.direction = r[$ "direction"];
		//	_upg.image_angle = r[$ "image_angle"];
		//	//_upg.haveafterimage = r[$ "haveafterimage"];
		//	_upg.extraInfo= json_parse(r[$ "extraInfo"]);
		//	_upg.speed = _upg.extraInfo.speed;
		//	break;
		//}
		
		//case Network.UpdateUpgrade:{
		//	var extra = json_parse(r[$ "extraInfo"]);
		//	with (oSlaveUpgrade) {
		//	    if (upgID == r[$ "upgID"]) {					
		//			for (var i = 0, _names = variable_struct_get_names(extra); i < array_length(_names); ++i) {
		//			    extraInfo[$ _names[i]] = extra[$ _names[i]];
		//			}
		//		}
		//	}
		//	//var total = instance_number(oSlaveUpgrade);
		//	//	for (var i = 0; i < total; ++i) {
		//	//		var ftotal = instance_number(oSlaveUpgrade);
		//	//		if (ftotal != total) {
		//	//		    i = 0;
		//	//			total = ftotal;
		//	//		}
		//	//	    var inst = instance_find(oSlaveUpgrade, i);
		//	//		if (inst.upgID == r[$ "upgID"]) {
		//	//			var extraInfo = json_parse(r[$ "extraInfo"]);
		//	//			for (var i = 0, _names = variable_struct_get_names(extraInfo); i < array_length(_names); ++i) {
		//	//			    inst.extraInfo[$ _names[i]] = extraInfo[$ _names[i]];
		//	//			}
		//	//		}
		//	//	}
		//	break;
		//}
		
		//case Network.DestroyUpgrade:{
		//		var total = instance_number(oSlaveUpgrade);
		//		for (var i = 0; i < total; ++i) {
		//			var ftotal = instance_number(oSlaveUpgrade);
		//			if (ftotal != total) {
		//			    i = 0;
		//				total = ftotal;
		//			}
		//		    var inst = instance_find(oSlaveUpgrade, i);
		//			if (inst.upgID == r[$ "upgID"]) { instance_destroy(inst); }
		//		}
		//		break;}
				
		// case Network.Spawn:{
		//		var enemyvars = json_parse(r[$ "sendvars"]);
		//		var enemyvarnames = variable_struct_get_names(enemyvars);
		//		var _enemy = instance_create_layer(r[$ "x"], r[$ "y"], "Instances", oEnemy);
		//		for (var i = 0; i < variable_struct_names_count(enemyvars); ++i) {
		//		    variable_instance_set(_enemy, enemyvarnames[i], variable_struct_get(enemyvars, enemyvarnames[i]));
		//		}
		//		_enemy.target = _enemy.target == oPlayer ? oSlave : oPlayer;
		//		//if (_enemy.target == oPlayer) {
				    
		//		//}33d74eef94
				
		//		//_enemy.target = instance_nearest(x,y,oSlave);
		//		with (_enemy) {
		//			try{
		//				//initiate_enemy(ds_list_find_value(global.enemyPool, variable_struct_get(enemyvars, "enemynum")));
		//				initiate_enemy(global.enemies[variable_struct_get(enemyvars, "thisEnemy")]);
		//			}
		//			catch(error){
		//				initiate_enemy(ds_list_find_value(global.enemyPool, 0));
		//			}				
		//		}
		//		//}
		//		break;}
		
		//case Network.Destroy:{
		//	//show_debug_message(string(r[$"owner"]) + ":" + string(oSlave.socket))
		//	//var candrop = true;
		//	//if (r[$"owner"] == oSlave.socket and global.shareXP) {
		//	//    candrop = false;
		//	//}
		//	if (instance_exists(oEnemy)) {
		//	    with (oEnemy) {
		//		    if (enemyID == r[$ "enemyID"]) {
		//				deathSent = true;
		//				if (r[$ "owner"] != oPlayer.socket) {
		//				    dropxp = false;
		//				}
		//			    hp = 0;
		//			}
		//		}
		//	}
		//	break;
		//}
		
		//case Network.UpdateRoom:{
		//	if (instance_exists(oLobby)) {
		//	    if (r[$ "roomname"] == global.roomname) {
		//		    oLobby.players = json_parse(r[$ "players"]);
		//			oLobby.IsHost = r[$ "isHost"];
		//		}
		//	}
		//	break;
		//}
		
		//case Network.UpdateOptions:{
		//	if (r[$ "roomname"] == global.roomname) {
		//		// Feather disable once GM1041
		//		variable_instance_set(oLobby, r[$ "option"], r[$ "value"]);
		//	}
		//	break;
		//}
		
		//case Network.ShareXP:{
		//	if (r[$ "roomname"] == global.roomname) {
		//		global.xp += r[$ "xp"];
		//	}
		//	break;
		//}
		
		//case Network.ChatMessage:{
		//	var _msg = [r[$ "username"], r[$ "text"]];
		//	array_push(oLobby.chatmessages, _msg);
		//	break;
		//}
		
		//case Network.SpawnAnvil:{
		//	if (r[$ "owner"] != global.socket) {
		//	    instance_create_depth(r[$ "x"], r[$ "y"], oPlayer.depth, oAnvil,{anvilid : r[$ "anvilid"], maxuses : r[$ "maxuses"], dontsend : true});
		//	}			
		//	break;}
			
		//case Network.UpdateAnvil:{
		//	if (!instance_exists(oAnvil)) { return; }
		//	with (oAnvil) {
		//	    if (anvilid == r[$ "anvilid"]) {
		//		    maxuses = r[$ "maxuses"];
		//		}
		//	}
		//	break;}
			
		//case Network.AddItem:{
		//	if (r[$ "type"] == "weapon") {
		//	    UPGRADES[r[$ "pos"]] = global.upgradesAvaliable[r[$ "id"]][r[$ "level"]];
		//	}
		//	if (r[$ "type"] == "item") {
		//	    playerItems[r[$ "pos"]] = ItemList[r[$ "id"]][r[$ "level"]];
		//	}
		//	break;}
			
		//case Network.InfectMob:{
		//	var _id = r[$ "id"];
		//	var _target = r[$ "target"];
		//	var _newtarget = noone;
		//	with (oEnemy) {
		//	    if (enemyID == _target) {
		//		    _newtarget = id;
		//		}
		//	}
		//	with (oEnemy) {
		//	    if (enemyID == _id) {
		//		    target = _newtarget;
		//			infected = true;
		//			hp = r[$ "hp"];
		//			baseSPD = r[$ "baseSPD"];
		//		}
		//	}			
		//	break;}
		
	    default:
	        // code here
	        break;
	}
}

/// @function                sendMessage(data)
/// @description             Data to send server
/// @param {any}     data data to send
function sendMessage(data){
	if (!instance_exists(oClient)) { return; }	
	data.roomname = global.roomname;
	buffer_seek(oClient.clientBuffer, buffer_seek_start, 0);
	var _json = json_stringify(data);
	buffer_write(oClient.clientBuffer, buffer_text, _json);	
	network_send_udp_raw(oClient.client, global.serverip, global.port, oClient.clientBuffer, buffer_tell(oClient.clientBuffer));
}