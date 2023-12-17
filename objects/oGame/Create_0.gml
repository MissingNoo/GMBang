display_set_gui_size(1366, 768);
dices = [ { face : 0, x : 520, saved : 0, y : 305 },{ face : 1, x : 555, saved : 0, y : 434 },{ face : 2, x : 661, saved : 0, y : 369 },{ face : 5, x : 804, saved : 0, y : 293 },{ face : 1, x : 823, saved : 0, y : 453 } ];
firstRoll = true;
myposition = 0;
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