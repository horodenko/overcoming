sprite_index = spr_orb_catch;

if (!hasPickedUp) {
	global.orbs += 1;
	hasPickedUp = true;
}

if (!audio_is_playing(snd_orb_fading)) {
	audio_play_sound(snd_orb_fading, 1, false);
} else {
	audio_stop_sound(snd_orb_fading);
	audio_play_sound(snd_orb_fading, 1, false);	
}