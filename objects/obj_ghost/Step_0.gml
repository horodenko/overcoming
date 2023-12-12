if (global.is_dialogue_finished and bAlpha > 0) {
	sprite_index = spr_ghost_eyes_closed;
	image_alpha = bAlpha;
	
	velH += 0.03;
	bAlpha -= 0.01;
}