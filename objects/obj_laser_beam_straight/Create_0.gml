var sound_to_play = choose(snd_laser_beam_1, snd_laser_beam_2,snd_laser_beam_3, snd_laser_beam_4, snd_laser_beam_5);
hasPlayedSndLaserStraight = false;

if (!hasPlayedSndLaserStraight) {
	if (!audio_is_playing(sound_to_play)) {
		hasPlayedSndLaserStraight = true;
		audio_play_sound(sound_to_play, 1, false);
	}
}

cannotDamagePlayer = false;