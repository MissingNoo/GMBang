display_set_gui_size(1366, 768);
canInteract = true;
turnHP = 0;
ability = -1;
jobalpha = 1;
gatling = 0;
arrows = 0;
waiting = false;
waitingPlayer = -1;
dices = [ { face : 0, x : 520, saved : 0, y : 305 },{ face : 1, x : 555, saved : 0, y : 434 },{ face : 2, x : 661, saved : 0, y : 369 },{ face : 5, x : 804, saved : 0, y : 293 },{ face : 1, x : 823, saved : 0, y : 453 } ];
firstRoll = true;
myposition = 0;
for (var i = 0; i < array_length(global.players); ++i) {
	if (global.players[i].port == global.playerid) {
		myposition = i;
	}
}
canhit = [0,0];
function can_hit(distance){
	var _alive = 0;
	for (var i = 0; i < array_length(global.players); ++i) {
		if (global.players[i].life > 0) {
			_alive++;
		}
	    if (global.players[i].port == global.playerid) {
		    myposition = i;
		}
	}
	if(_alive <= 3){
		distance = 1;
	}

	var lastplayer = array_length(global.players) - 1;
	var firstplayer = 0;
	canhit[0] = myposition + distance;
	//if (canhit[0] > lastplayer){
	//	canhit[0] = firstplayer;
	//}
	if (canhit[0] > lastplayer){
		switch (distance){
			case 1:
				canhit[0] = firstplayer;
				break;
			case 2:
				if(canhit[0] == lastplayer + 1){
					canhit[0] = firstplayer;
				}
				else{
					canhit[0] = firstplayer + 1;
				}
				break;
		}
	}
	var loop = 0;
	if(global.players[canhit[0]].life <= 0){
		do {
			canhit[0]++;
			if (canhit[0] > lastplayer){
				canhit[0] = firstplayer;
			}
			loop++;
			if (loop > 30){
				show_message_async("infinite loop");
				break;
			}
		} until (canhit[0] != myposition and global.players[canhit[0]].life > 0);
	}
	draw_text(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0), $"me: {myposition} + {distance} = {myposition + distance} == {canhit[0]}");
	canhit[1] = myposition - distance;
	if (canhit[1] < firstplayer){
		switch (distance){
			case 1:
				canhit[1] = lastplayer;
				break;
			case 2:
				if(canhit[1] == -1){
					canhit[1] = lastplayer;
				}
				else{
					canhit[1] = lastplayer -1;
				}
				
				break;
		}
	}
	var loop = 0;
	if(global.players[canhit[1]].life <= 0){
		do {
			canhit[1]--;
			if (canhit[1] < firstplayer){
				canhit[1] = lastplayer;
			}
			loop++;
			if (loop > 30){
				show_message_async("infinite loop");
				break;
			}
		} until (canhit[1] != myposition and global.players[canhit[1]].life > 0);
	}
	draw_text(device_mouse_x_to_gui(0), device_mouse_y_to_gui(0) + 15, $"me: {myposition} - {distance} = {myposition - distance} == {canhit[1]}");
}
updateHit = function(){
	for (var i = 0; i < array_length(global.players); ++i) {
	    if (global.players[i].port == global.playerid) {
		    myposition = i;
			canhit1 = [myposition + 1, myposition - 1];
			canhit2 = [myposition + 2, myposition - 2];
			if (canhit1[0] == array_length(global.players)) { canhit1[0] -= array_length(global.players); }
			if (canhit1[1] < 0) { canhit1[1] = array_length(global.players) + canhit1[1]; }
			if (canhit2[0] >= array_length(global.players)) { canhit2[0] -= array_length(global.players); }
			if (canhit2[1] < 0) { canhit2[1] = array_length(global.players) + canhit2[1]; }
			if (array_length(global.players) == 3) {
				canhit1 = [myposition + 1, myposition - 1];
				canhit2 = [myposition + 1, myposition - 1];
				if (canhit1[0] == array_length(global.players)) { canhit1[0] = 0; }
				if (canhit1[1] < 0) { canhit1[1] = array_length(global.players) + canhit1[1]; }
				if (canhit2[0] == array_length(global.players)) { canhit2[0] = 1; }
				if (canhit2[1] < 0) { canhit2[1] = array_length(global.players) + canhit2[1]; }
			}
		}
	}
}
debuginfo = { a:1, b:1, c:1};
pushingDice = -1
dropArea = [GW/2 - 268, GH/2 - 131, GW/2 - 215, GH/2 + 131];
rolling = false;
result = [];
mx = 0;
my = 0;
currentTurn = 0;
actions = 0;
resolvingDice = 0;
resolvePhase = false;
//window_set_size(window_get_width()/2, window_get_height()/2);
positions = [[GW/30, GH/3], [GW/4, GH/15], [GW/1.50, GH/15], [GW/1.20 - 20, GH/3], [GW/1.20 - 20, GH/1.80], [GW/1.50, GH/1.25], [GW/4, GH/1.25], [GW/30, GH/1.80]];
global.playerspos = variable_clone(global.players);
currentAction = -1;