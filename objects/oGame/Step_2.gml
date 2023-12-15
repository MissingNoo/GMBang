//mxn = device_mouse_x_to_gui(0);
//myn = device_mouse_y_to_gui(0);
//if (mxn != mx or myn != myn) {
sendMessage({ command : Network.Mouse, x : mx, y : my });
//}