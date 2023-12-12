if (init) {
	if (characters <  string_length(text_grid[# Infos.Text, pages])) {
		if (!audio_is_playing(snd_conversation)) {
			audio_play_sound(snd_conversation, 1, 0);
		}
		characters++;		
		alarm[0] = 1;
	}
} 