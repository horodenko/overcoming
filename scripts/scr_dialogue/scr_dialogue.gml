function scr_text(){
	switch npc_name {
		case "Friend": 
			ds_grid_add_text(
				"Quem é você? O que está acontecendo?",
				alice_line_1,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"Olá, Alice. Eu sou seu guia neste mundo desconhecido. Você está aqui para enfrentar seus medos e superá-los.",
				spr_portrait_ghost_2,
				0,
				"???"
			);
			ds_grid_add_text(
				"Eu sei que pode ser assustador, mas você tem o poder dentro de si para enfrentar tudo isso.",
				spr_portrait_ghost,
				0,
				"???"
			);
			ds_grid_add_text(
				"Poder? Que poder? Eu não entendo...",
				alice_line_2,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"Você tem o poder da luz. É algo que sempre esteve dentro de você, mas nunca teve a oportunidade de se manifestar.",
				spr_portrait_ghost_2,
				0,
				"???"
			);
			ds_grid_add_text(
				"Agora, neste mundo, você pode usá-lo para iluminar seu caminho e afastar as sombras.",
				spr_portrait_ghost_2,
				0,
				"???"
			);
			ds_grid_add_text(
				"Eu... Eu não sei como fazer isso...",
				alice_line_3,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"Feche seus olhos e concentre-se. Sinta a luz dentro de você, deixe-a crescer e se expandir.",
				spr_portrait_ghost,
				0,
				"???"
			);
			ds_grid_add_text(
				"Ok, vou tentar.", // pensar se isso será na mesma linha, requirirá um pouco de alteração no código, ou simplesmente colocar em outra linha
				alice_line_1,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"(fecha os olhos e respira fundo).", // pensar se isso será na mesma linha, requirirá um pouco de alteração no código, ou simplesmente colocar em outra linha
				alice_line_4,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"Quando abrir os olhos, aponte sua mão para onde deseja que a luz vá e ela surgirá. Você é mais forte do que imagina, Alice.",
				spr_portrait_ghost_2,
				0,
				"???"
			);
			ds_grid_add_text(
				"Lembre-se disso.",
				spr_portrait_ghost_3,
				0,
				"???"
			);
			//ds_grid_add_text(
			//	"Vá, Alice. Ilumine seu caminho e supere seus medos. Eu estarei aqui, guiando você sempre que precisar.",
			//	spr_portrait_ghost,
			//	0,
			//	"???"
			//);
			ds_grid_add_text(
				"(Abre os olhos e aponta a mão para a escuridão, de onde surge um feixe de luz brilhante).", // após terminar esta última fala, dar trigger na animação de Alice soltando o poder, e impedindo que ela se mova, pule ou faça qualquer outra coisa, até que a animação termine
				alice_line_5,
				1,
				"Alice"
			);
		break;
		case "Boss":
			ds_grid_add_text(
				"...",
				alice_line_4,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"...!",
				alice_line_5,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"Quem é você?",
				alice_line_3,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"Oh, Alice, você ainda não entendeu? Eu sou você. A parte de você que você tentou esquecer.",
				spr_portrait_boss,
				0,
				"Ileac"
			);
			ds_grid_add_text(
				"Somos todos feitos de luz e sombras. Você negou minha existência por tanto tempo, e agora estou aqui para reivindicar meu lugar.",
				spr_portrait_boss,
				0,
				"Ileac"
			);
			ds_grid_add_text(
				"Mas por que? Por que você está fazendo isso?",
				alice_line_2,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"É hora de enfrentar a si mesma, Alice. Aceite-me.",
				spr_portrait_boss,
				0,
				"Ileac"
			);
			ds_grid_add_text(
				"Não, eu não vou desistir!",
				alice_line_6,
				1,
				"Alice"
			);
			ds_grid_add_text(
				"...!",
				spr_portrait_boss,
				0,
				"Ileac"
			);
			break;
		default:
			ds_grid_add_text(
				"Me sinto diferente, mais forte...",
				noone,
				0,
				"Alice"
			);
			break;
	}
}

function ds_grid_add_row(){
	///@arg ds_grid
 
	// adicionando uma linha sempre na última posição do grid de linhas de diálogo
	var _grid = argument[0];
	ds_grid_resize(_grid, ds_grid_width(_grid), ds_grid_height(_grid) + 1);
	return (ds_grid_height(_grid) - 1);	
}

function ds_grid_add_text(){
	///@arg text
	///@arg portrait
	///@arg side
	///@arg name
 
	var _grid = text_grid;
	var _y = ds_grid_add_row(_grid);
 
	_grid[# 0, _y] = argument[0];
	_grid[# 1, _y] = argument[1];
	_grid[# 2, _y] = argument[2];
	_grid[# 3, _y] = argument[3];
}