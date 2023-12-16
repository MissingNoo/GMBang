display_set_gui_size(1366, 768);
dices = [ { face : 0, x : 520, saved : 0, y : 305 },{ face : 1, x : 555, saved : 0, y : 434 },{ face : 2, x : 661, saved : 0, y : 369 },{ face : 5, x : 804, saved : 0, y : 293 },{ face : 1, x : 823, saved : 0, y : 453 } ];
firstRoll = true;
debuginfo = { a:1, b:1, c:1};
pushingDice = -1
dropArea = [GW/2 - 268, GH/2 - 131, GW/2 - 215, GH/2 + 131];
rolling = false;
result = [];
mx = 0;
my = 0;
currentTurn = 0;
actions = 0;
//window_set_size(window_get_width()/2, window_get_height()/2);'
global.playerspos = variable_clone(global.players);