switch (sprite_index) {
	case spr_boss_straight_attack:
		image_index = image_number - 2;
		image_speed = 0;
		break;
	case spr_boss_straight_angry:
		image_index = image_number - 2;
		image_speed = 0;
		break;
	case spr_boss_dying:
		image_speed = 1;
		has_died = true;
		obj_player._hasFinishedLevel = true;
		obj_player.on_reset_level();
		
		game_set_speed(10, gamespeed_fps);
		break;
}