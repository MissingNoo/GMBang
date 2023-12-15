#macro DEBUG if (os_get_config() == "Debug") {
#macro ENDDEBUG }
#macro GW display_get_gui_width()
#macro GH display_get_gui_height()
enum Faces {
	Arrow,
	Bomb,
	Hit1,
	Hit2,
	Beer,
	Gatling
}