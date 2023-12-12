if (instance_exists(obj_dialogue)) {
	global.dialogue = true;
}

if (room == Store) {
	exit;
}

if (room != Final_Level) {
	if (room == First_Level) {
		if (!audio_is_playing(snd_background_fade_in) and !hasPlayedBackgroundInit) {
			hasPlayedBackgroundInit = true;
			audio_play_sound(snd_background_fade_in, 1, false);
		}

		if (!audio_is_playing(snd_background_rest) and !audio_is_playing(snd_background_fade_in)) {
			audio_play_sound(snd_background_rest, 1, true);
		}
	} else if (room == Second_Level) {
		if (!has_played_second_background) {
			audio_play_sound(snd_background_second_level, 1, true);
			has_played_second_background = true;
		}
	} else if (room == Underground) {
		if (!has_played_underground_snd) {
			audio_play_sound(snd_underground, 1, true);
			has_played_underground_snd = true;
		}
		
		if (!has_played_underground_bat_snd) {
			audio_play_sound(snd_underground_bats, 1, false);
			has_played_underground_bat_snd = true;
		}
	}
}


if (global.is_dialogue_finished) {
	global.has_power = true;
}

if (text_alpha < 1) {
	text_alpha -= 0.01;
}

var background = layer_get_id("Background");

// Criar efeito parallax no background, para fazê-lo se mover mais devagar do que o resto do mapa
layer_x(background, lerp(0, camera_get_view_x(view_camera[0]), 0.8));

//layer_x(trees, lerp(0, camera_get_view_x(view_camera[0]), 0));
if (powerCountdown == 0) {
	global.cooldown = false;
	powerCountdown = shortenedCountdown;
}

if (global.cooldown) {
	powerCountdown--;
} 