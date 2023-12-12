if (room == Store) exit;

if (global.dialogue and !keyboard_check_released(ord("F"))) {
	if (characters <  text_length) {
		characters =  text_length;
	} else {	
		// Resetar alarme para letras serem escritas lentamente de novo a cada página
		alarm[0] = 1;
		characters = 0;
		
		if (pages < ds_grid_height(text_grid) - 1) {
			pages++;
		} else {
			global.dialogue = false;
			instance_destroy(obj_dialogue);
			
			global.is_dialogue_finished = true;
			if (room == Final_Level) { 
				obj_boss.start_dialogue = false;
				if (!audio_is_playing(snd_boss_music)) {
					audio_play_sound(snd_boss_music, 1, true);
				}
			}
			
			obj_player.state = obj_player.state_power;
		}	
	}
}