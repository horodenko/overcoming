if (global.is_dialogue_finished and state != state_dead) {
	draw_sprite(spr_boss_health_background, 0, _health_bar_x, _health_bar_y);
	draw_sprite_stretched(spr_boss_health_bar, 0, _health_bar_x, _health_bar_y, min(((hp / _boss_max_hp) * _health_bar_width) - 7), _health_bar_height - 7);
	draw_sprite(spr_boss_health_socket, 0, _health_bar_x, _health_bar_y);
}