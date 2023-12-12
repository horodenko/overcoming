if (room == Store or room == Cutscene or room == Cutscene_Alice_Overcame or room == Cutscene_Thanks) { exit; }
camera_set_view_size(cam, view_width, view_height);

if (instance_exists(obj_player)) {
	var _x = clamp(obj_player.x  - floor(view_width / 2), 0, room_width - view_width);
	var _y = clamp(obj_player.y  - floor(view_height / 2) - 100, 0, room_height - view_height);
	
	var _current_x = view_w;
	var _current_y = view_h;
	
	var _speed = .1;
	
	camera_set_view_pos(cam, 
												lerp(_current_x, _x, _speed), 
												lerp(_current_y , _y, _speed)
											);														
}
