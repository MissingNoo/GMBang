rolling = false;
for (var i = 0; i < array_length(dices); ++i) {
	dices[i][$ "face"] = floor(dices[i][$ "face"]);
}
for (var i = 0; i < array_length(result); ++i) {
	if (!dices[i].saved) {
	    dices[i][$ "face"] = result[i];
	}    
	switch (dices[i][$ "face"]) {
	    case Faces.Arrow:
			if (global.players[currentTurn][$ "port"] == global.playerid) {
			    sendMessage({ command : Network.AddArrow });
			}
	        break;
	    case Faces.Bomb:
	        dices[i][$ "saved"] = true;
			sendMessage({ command : Network.SaveDice, number : i, saved : dices[i][$ "saved"] });
	        break;
	    default:
	        // code here
	        break;
	}
}