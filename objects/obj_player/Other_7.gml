switch (sprite_index) {
	case sprite_states.isDowned:
		if (_titleOutPlayed) {
			sprite_index = sprite_states.isGettingUp;
		};
		break;
	case sprite_states.isGettingUp:
		global.isFading = true;	
		
		_pressToWalk = layer_sequence_create(
			obj_controller._pressToWalkId, 
			(obj_controller._guiWidth / 2) - 50, 
			505, 
			sq_press_to_walk
		);
		
		_canWalkReverse = true;
		break;
	case sprite_states.isDead: 
		image_index = image_number - 2;
		on_reset_level();
		break;
	case sprite_states.isAttacking:
		stop_sprite_looping(sprite_states.isAttacking);		
		
		global.cooldown = true;
		hasAttacked = false;
		state = state_free;			
		break;	
	case spr_char_attacking_tamarin:
		stop_sprite_looping(spr_char_attacking_tamarin);
		
		global.cooldown = true;
		hasAttacked = false;
		state = state_free;		
	case sprite_states.isHit:		
		if (!wasGrabbed) {
			stop_sprite_looping(sprite_states.isHit);	
			change_to_tamarin_sprite(spr_char_idle_tamarin, spr_char_idle);	
		} else {
			image_index = 1;
		}
		break;
	case spr_char_hit_tamarin:
		if (!wasGrabbed) {
			stop_sprite_looping(spr_char_hit_tamarin);
			change_to_tamarin_sprite(spr_char_idle_tamarin, spr_char_idle);
		} else { image_index = 1; }
}

if (velV < 0) {
	if (room != First_Level) {
		if (global.hasTamarin) {
			stop_sprite_looping(spr_char_jump_up_tamarin);
		} else {
			stop_sprite_looping(sprite_states.isJumpUpIdle);
		}
	} else {
			stop_sprite_looping(sprite_states.isJumpUpIdle);
	}	
}

if (velV > 0) {
	isRepeating = true;
	isAnimationFinished = true;
	
	if (sprite_index == sprite_states.isJumpDownIdle or sprite_index == spr_char_jump_down_tamarin) {
		image_index = 3;	
	} 
}