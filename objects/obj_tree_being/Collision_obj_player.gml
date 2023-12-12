if (state != state_exploding) {
	obj_player.wasHitByBeing = true;
	if (!has_played_snd_laugh) {
		audio_play_sound(snd_tree_being_laugh, 1, false);
		has_played_snd_laugh = true;
	}
}

state = state_exploding;






