stop_sprite_looping = function(desired_sprite) {
	if (sprite_index == desired_sprite)	{
		image_speed = 0; 
		image_index = image_number - 1;
	}
	
	image_speed = 1;
}

reset_index = function(desired_sprite) {
		if (sprite_index != desired_sprite) 
		{
			image_index = 0;
		}
	}

canGrab_timer = room_speed * 2;

has_played_snd_vacuum = false;
state_grabbed = function() {
	var vacuum_snd = choose(snd_grabber_vacuum_1, snd_grabber_vacuum_2, snd_grabber_vacuum_3);
	if (!has_played_snd_vacuum) {
		audio_play_sound(vacuum_snd, 1, false);
		has_played_snd_vacuum = true;
	}
	
	reset_index(spr_grabber_arms_grabbed);
	sprite_index = spr_grabber_arms_grabbed;
	
	obj_player.x = self.x;
	obj_player.y = self.y - 20;
	obj_player.velV =	0;
	obj_player.velH =	0;
	obj_player.wasGrabbed = true;
}

has_played_sound_preparing = false;
state_preparing = function() {
	canGrab_timer = room_speed * 2;
	
	reset_index(spr_grabber_arms_preparing);
	sprite_index = spr_grabber_arms_preparing;
	
	if (floor(image_index) == 7) {
		if (!has_played_sound_preparing) {
			audio_play_sound(snd_grabber_grabbing, 1, false);
			has_played_sound_preparing = true;
		}
		
		if( distance_to_object(obj_player) < 5) {
			state = state_grabbed;
		}
	}
}

state_free = function() {
	reset_index(spr_grabber_arms_idle);
	sprite_index = spr_grabber_arms_idle;
	
	canGrab_timer -= 1;
	if (canGrab_timer <= 0) {		
		canGrab_timer = 0;
		if (distance_to_object(obj_player) < 50) {
			state = state_preparing;
		}
	}
}

state = state_free;