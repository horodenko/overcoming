if (!instance_exists(obj_player)) exit;

if (isDrop) {
	move_towards_point(obj_player.x, obj_player.y - 10, 7);
}

if (room == Store) instance_destroy();