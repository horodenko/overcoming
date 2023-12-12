var elapsed_time = current_time
var current_frame = floor(elapsed_time / 125) % 12;
	
if (room == Store) {	
	draw_sprite_ext(spr_orb, current_frame, 80, y + 500, 1, 1, 0, c_white, 1);	
	draw_text(120, y + 465, global.orbs);
}
