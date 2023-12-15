rolling = false;
for (var i = 0; i < array_length(result); ++i) {
	if (!dices[i].saved) {
	    dices[i][$ "face"] = result[i];
	}    
	switch (dices[i][$ "face"]) {
	    case Faces.Arrow:
	        // code here
	        break;
	    case Faces.Bomb:
	        dices[i][$ "saved"] = true;
			sendMessage({ command : Network.SaveDice, number : i, saved : dices[i][$ "saved"]});
	        break;
	    default:
	        // code here
	        break;
	}
}