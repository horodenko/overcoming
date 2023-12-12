var sound_to_play = choose(snd_laser_beam_1, snd_laser_beam_2,snd_laser_beam_3, snd_laser_beam_4, snd_laser_beam_5);
hasPlayedSndLaserDown = false;

if (!hasPlayedSndLaserDown) {
	if (!audio_is_playing(sound_to_play)) {
		hasPlayedSndLaserDown = true;
		audio_play_sound(sound_to_play, 1, false);
	}
}

cannotDamagePlayer = false;

obj_boss.image_index = obj_boss.image_number - 1;
obj_boss.image_speed = 0;