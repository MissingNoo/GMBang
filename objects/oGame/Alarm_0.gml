rolling = false;
//for (var i = 0; i < array_length(dices); ++i) {
//	dices[i][$ "face"] = floor(dices[i][$ "face"]);
//}

for (var i = 0; i < array_length(result); ++i) {
	//if (!dices[i][$ "saved"]) {
	if (result[i] != -1) {
	    dices[i][$ "face"] = result[i];
	}
	if(myposition != currentTurn){exit;}
	switch (dices[i][$ "face"]) {
	    case Faces.Arrow:
			if (!dices[i][$ "saved"]) {

			    sendMessage({ command : Network.AddArrow, amount : 1, port : global.players[myposition][$ "port"] });
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