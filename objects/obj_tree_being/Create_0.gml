velV = 0;
playerClose = false;

hasPlayedSndLeaving = false;
has_played_snd_laugh = false;
state_leaving = function() {
	image_xscale = 0.3;
	image_yscale = 0.3;
	sprite_index = spr_tree_being_leaving;
	
	if (playerClose) {
		image_speed = 1;
		if (!hasPlayedSndLeaving) {
			audio_play_sound(snd_tree_being_leaving, 1, false);
			hasPlayedSndLeaving = true;
		}
	} else {
		image_speed = 0;		
	}
}

state_falling = function() {
	hasPlayedSndLeaving = false;
	image_xscale = 0.3;
	image_yscale = 0.3;
	sprite_index = spr_tree_being_falling;
	velV = 5;
	
	if (floor(image_index) == image_number - 1) {
		image_index = image_number - 5;
	}
}

state_exploding = function() {
	image_xscale = 0.3;
	image_yscale = 0.3;
	sprite_index = spr_tree_being_exploding;
	velV = 0;
}

state = state_leaving;