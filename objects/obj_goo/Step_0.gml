if (velH != 0 and distance_to_object(obj_player) < 150) {
	if (!audio_is_playing(snd_goo_walking)) {
		audio_play_sound(snd_goo_walking, 1, false);
		has_played_snd_walking = true;
	}
}

if (isDead) {
	sprite_index = spr_spider_dying;

	exit;
}

state();