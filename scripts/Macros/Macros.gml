#macro DEBUG os_get_config() == "Debug"
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
enum Characters {
	BartCassidy,
    BlackJack,
    CalamityJanet,
    ElGringo,
    JesseJones,
    Jourdonnais,
    KitCarlson,
    LuckyDuke,
    PaulRegret,
    PedroRamirez,
    RoseDoolan,
    SidKetchum,
    SlabtheKiller,
    SuzyLafayette,
    VultureSam,
    WillytheKid
}

enum Roles {
	Sheriff,
	Deputy,
	Outlaw,
	Renegade
}

enum DamageType {
    Normal,
    Indian,
    Dynamite
}

global.skills = array_create(Characters.WillytheKid, "");
global.skills[Characters.BartCassidy] = "Voce pode pegar uma flecha em vez de perder um ponto de vida (exceto para Indios ou Dinamite)."
global.skills[Characters.SidKetchum] = "No inicio do seu turno, qualquer jogador a sua escolha ganha um ponto de vida.";