switch (sprite_index) {
	case spr_grabber_arms_grabbed:
		obj_player.wasGrabbed = false;
		obj_player.y = obj_ground.y;
		has_played_snd_vacuum = false;
		state = state_free;
		break;
	case spr_grabber_arms_preparing:
		has_played_sound_preparing = false;
		state = state_free;
		break;
}