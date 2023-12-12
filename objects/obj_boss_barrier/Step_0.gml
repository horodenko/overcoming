if (!place_meeting(x + 1, y, obj_player)) {
	if (image_alpha >= 0) {
		image_alpha -= 0.10;
	}
} else if (image_alpha <= 10) image_alpha += 0.10;