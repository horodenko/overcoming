if (floor(image_index) == image_number - 7) { 
	global.hitExplosion = true;
}

if (floor(image_index) == image_number - 5) {
	if (!audio_is_playing(snd_power_hitting_enemy)) {
		audio_play_sound(snd_power_hitting_enemy, 1, false);
	}
	
	if (room == Final_Level) {
		if (!instance_exists(obj_boss)) exit;
		if (!has_played_snd_boss_hit and obj_boss.state != obj_boss.state_dead) {
			instance_create_layer(obj_boss.x, obj_boss.y + 5, "Boss_Hit", obj_boss_hit_effect);
			
			audio_play_sound(snd_boss_hit, 1, false);
			has_played_snd_boss_hit = true;
		}
	}
}