//mxn = device_mouse_x_to_gui(0);
//myn = device_mouse_y_to_gui(0);
//if (mxn != mx or myn != myn) {
var _sprite = -1;
if (pushingDice != -1) {
    _sprite = dices[pushingDice].face;
}
sendMessage({ command : Network.Mouse, x : mx, y : my, sprite : _sprite });
//}