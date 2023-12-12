reset_all_variables = function() {
	global.dialogue = false;
	global.is_dialogue_finished = false;
	global.isFading = false;
	instance_destroy(obj_player);
	instance_destroy(obj_boss);
};

hasPlayedBackgroundInit = false;
has_played_second_background = false;
has_played_underground_snd = false;
has_played_underground_bat_snd = false;


global.storeProceed = 0;

// Checando globalmente se estamos em um diálogo (para por ex. não permitir que a personagem ande
global.dialogue = false;
global.is_dialogue_finished = false;

// Controlar animação de fade no início do jogo
global.isFading = false;

draw_set_font(main_fnt);

#region Drawing HUD
// Desenhando quantidade de vidas
function draw_heart(_x, _y, _xScale, _yScale, _sprite) {
	// Pegar tempo atual da room
	var elapsed_time = current_time;
	// Calcular frame atual da animação da sprite (para rodar em 9 frames a animação
	var current_frame = floor(elapsed_time / 125) % 9;
	
	// sprite, numero de quadros (animação, 0 caso nao tenha), posicao x, posicao y, escala de tamanho x, y,
	// rotação, cor, opacidade
	draw_sprite_ext(_sprite, current_frame, _x, _y, _xScale, _yScale, 0, c_white, 1);	
}

global.is_interact_focused = false;

global.has_power = false;
global.cooldown = false;

shortenedCountdown = 0;

if (room != First_Level) {
	if (global.cooldownReduction) {
		shortenedCountdown = 30;
		powerCountdown = shortenedCountdown;
	} else {
		shortenedCountdown = 60;
		powerCountdown = shortenedCountdown;
	}
} else {
	shortenedCountdown = 60;
	powerCountdown = shortenedCountdown;
}


function draw_mobile_inputs(spr_name, _x1Fixed, _y1Fixed) {
	var sprW = sprite_get_width(spr_name) / 2;
	var sprH = sprite_get_height(spr_name) / 2;

	var _x1 = _x1Fixed + sprW;
	var _y1 = _y1Fixed + sprH;

	var elapsed_time = current_time;
	var _attackAnimation = floor(elapsed_time / 125) % 3;
	if (spr_name == spr_interact and !global.is_interact_focused) 
		return draw_sprite_ext(spr_name, 0, _x1, _y1, 1, 1, 0, c_white, 0.2);
	else if (spr_name == spr_attack and global.cooldown) {
		return draw_sprite_ext(spr_name, _attackAnimation, _x1, _y1, 1, 1, 0, c_white, 0.2);
	} else if (spr_name == spr_attack_triple and global.cooldown) {
		return draw_sprite_ext(spr_name, _attackAnimation, _x1, _y1, 1, 1, 0, c_white, 0.2);
	} else if (spr_name == spr_attack_huge and global.cooldown) {
		return draw_sprite_ext(spr_name, _attackAnimation, _x1, _y1, 1, 1, 0, c_white, 0.2);
	}
		
	if (spr_name == spr_attack or spr_name == spr_attack_triple or spr_name == spr_attack_huge) {
		draw_sprite_ext(spr_name, _attackAnimation, _x1, _y1, 1, 1, 0, c_white, 1);		
	} else {
		draw_sprite_ext(spr_name, 0, _x1, _y1, 1, 1, 0, c_white, 1);		
	}
};
#endregion

text_alpha = 1;

#region Variáveis úteis

_guiWidth = display_get_gui_width();
_guiHeight = display_get_gui_height();

#endregion

#region IDs das Sequências

_fadeId = layer_get_id("Sequence_Fade");
_fogId = layer_get_id("Sequence_Fog");
_pressToWalkId = layer_get_id("Sequence_PressToWalk");
_pressToJumpId = layer_get_id("Sequence_PressToJump");
_pressToInteractId = layer_get_id("Sequence_PressToInteract");
_pressToAttackId = layer_get_id("Sequence_PressToAttack");

#endregion

#region Sequências

layer_sequence_create(
	_fadeId,
	x,
	_guiHeight,
	sq_fade_out
);

#endregion
// change sprites according to room
switch (room) {
	case First_Level:
		obj_branch.sprite_index = spr_branch;		
		break;
	case Second_Level:
		obj_branch.sprite_index = spr_branch_2;
		break;
	case Final_Level:
		obj_ground.sprite_index = spr_ground_boss_room;
}