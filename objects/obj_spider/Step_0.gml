if (sprite_index == spr_spider_hit) {
	var _floorIndex = floor(image_index);
	if (_floorIndex == 8) {
		if (!audio_is_playing(snd_spider_hit)) {
			audio_play_sound(snd_spider_hit, 1, false);
		}
	}
}

if (isDead) {
	sprite_index = spr_spider_dying;

	exit;
}

state();