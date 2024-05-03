rolling = false;
//for (var i = 0; i < array_length(dices); ++i) {
//	dices[i][$ "face"] = floor(dices[i][$ "face"]);
//}

for (var i = 0; i < array_length(result); ++i) {
	//if (!dices[i][$ "saved"]) {
	//if (result[i] != -1) {
	    dices[i][$ "face"] = result[i];
	//}
	if(myposition != currentTurn){continue;}
	switch (dices[i][$ "face"]) {
	    case Faces.Arrow:
			if (!dices[i][$ "saved"]) {
			    sendMessage({ command : Network.AddArrow, amount : 1, port : global.players[myposition][$ "port"] });
				instance_create_depth(0, 0, 0, oEffect, {shootarrow : true, target : [oGame.positions[oGame.currentTurn][0], oGame.positions[oGame.currentTurn][1]]});
			}
	        break;
	    case Faces.Bomb:
	        dices[i][$ "saved"] = true;
			sendMessage({ command : Network.SaveDice, number : i, saved : dices[i][$ "saved"] });
	        break;
		case Faces.Hit1:
		case Faces.Hit2:
			if(global.players[myposition][$ "character"] == Characters.SuzyLafayette){
				suzyRolled = true;
			}
			break;
	    default:
	        // code here
	        break;
	}
}