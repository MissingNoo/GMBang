#macro DEBUG os_get_config() == "Debug"
#macro GW display_get_gui_width()
#macro GH display_get_gui_height()
//#macro MX device_mouse_x_to_gui(0)
//#macro MY device_mouse_y_to_gui(0)
//#macro mouse_click device_mouse_check_button_pressed(0, mb_left)
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

global.characterNames = [
    "Bart Cassidy",
    "BlackJack",
    "Calamity Janet",
    "El Gringo",
    "Jesse Jones",
    "Jourdonnais",
    "Kit Carlson",
    "Lucky Duke",
    "Paul Regret",
    "Pedro Ramirez",
    "Rose Doolan",
    "Sid Ketchum",
    "Slab The Killer",
    "Suzy Lafayette",
    "Vulture Sam",
    "Willy The Kid"
];

global.skills = array_create(Characters.WillytheKid, "");
global.skills[Characters.BartCassidy] = "Voce pode pegar uma flecha em vez de perder um ponto de vida (exceto para Indios ou Dinamite)."
global.skills[Characters.SidKetchum] = "No inicio do seu turno, qualquer jogador a sua escolha ganha um ponto de vida.";
global.skills[Characters.PedroRamirez] = @"Cada vez que voce perde um ponto de vida, voce pode descartar uma de suas flechas.";
global.skillsFull = array_create(Characters.WillytheKid, "");
global.skillsFull[Characters.BartCassidy] = @"Voce pode pegar uma flecha em vez de perder um ponto de vida (exceto para indios ou Dinamite).

Voce nao pode usar esta habilidade se perder um ponto de vida para Indios ou Dinamite, apenas para Hit1, Hit2, ou Metralhadora. 
Voce nao pode usar esta habilidade para pegar a ultima flecha restante na pilha.";
global.skillsFull[Characters.BlackJack] = @"voce pode rolar Bomba novamente (nao se conseguir tres ou mais!). 
Se voce lançar tres ou mais Dinamites de uma vez (ou no total, se voce nao as rolou novamente), siga as regras normais (seu turno termina, etc.).";
global.skillsFull[Characters.CalamityJanet] = @"voce pode usar Hit1 como Hit2 e vice-versa.";
global.skillsFull[Characters.ElGringo] = @"Quando um jogador faz voce perder um ou mais pontos de vida, ele deve pegar uma flecha.

Os pontos de vida perdidos para indios ou dinamite nao são afetados.";
global.skillsFull[Characters.JesseJones] = @"Se voce tiver quatro pontos de vida ou menos, voce ganha dois se usar Cerveja para si mesmo.";

//Por exemplo, se voce tiver quatro pontos de vida e usar duas cervejas, voce ganha quatro pontos de vida.";
global.skillsFull[Characters.Jourdonnais] = @"voce nunca perde mais de um ponto de vida para os indios.";
global.skillsFull[Characters.KitCarlson] = @"Para cada uma Metralhadora voce pode descartar uma flecha de qualquer jogador.

Voce pode optar por descartar suas proprias flechas.
Se voce rolar tres Metralhadoras, voce descarta todas as suas proprias flechas, mais três de qualquer jogador (é claro, voce ainda causa um dano a cada outro jogador).";
global.skillsFull[Characters.LuckyDuke] = @"voce pode fazer uma nova rolagem extra.

Voce pode lançar os dados um total de quatro vezes na sua vez.";
global.skillsFull[Characters.PaulRegret] = @"voce nunca perde pontos vitais para a Metralhadora.";
global.skillsFull[Characters.PedroRamirez] = @"Cada vez que voce perde um ponto de vida, voce pode descartar uma de suas flechas.

Voce ainda perde pontos de vida ao usar essa habilidade.";
global.skillsFull[Characters.RoseDoolan] = @"voce pode usar Hit1 ou Hit2 para jogadores sentados um lugar adiante.

Com Hit1 voce pode acertar um jogador sentado a duas casas de distância, e com Hit2 voce pode acertar um jogador sentado a duas ou três casas de distância.";
global.skillsFull[Characters.SidKetchum] = @"No inicio do seu turno, qualquer jogador à sua escolha ganha um ponto de vida.

Voce também pode escolher voce mesmo.";
global.skillsFull[Characters.SlabtheKiller] = @"Uma vez por turno, voce pode usar a Cerveja para dobrar a Hit1 ou Hit2. 
Os dados que voce dobra tiram dois pontos de vida do mesmo jogador (voce nao pode escolher dois jogadores diferentes). 
Cerveja Neste caso, nao fornece nenhum ponto de vida.";
global.skillsFull[Characters.SuzyLafayette] = @"Se voce nao rolou nenhum Hit1 ou Hit2, voce ganha dois pontos de vida. Isso se aplica apenas no final do seu turno, nao durante suas novas roladas.";
global.skillsFull[Characters.VultureSam] = @"Cada vez que outro jogador e eliminado, voce ganha dois pontos de vida.";
global.skillsFull[Characters.WillytheKid] = @"voce so precisa de dois dados de Metralhadora para usar a Metralhadora.

Voce pode ativar a Metralhadora apenas uma vez por turno, mesmo se obtiver mais de dois resultados.";