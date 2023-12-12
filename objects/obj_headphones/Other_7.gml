if (sprite_index == spr_headphones_fade_in) {
	image_speed = 0;
	image_index = image_number - 1;
	canChangeSprite  = true;
}

if (sprite_index == spr_headphones_fade_out) {
	room_goto(First_Level);
}