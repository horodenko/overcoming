var _enemy = instance_place(x + 1, y, obj_enemy_parent);
if (_enemy) {	
	if (_enemy.state != _enemy.state_dead) {
		var _enemyCenterX = _enemy.x - sprite_get_xoffset(sprite_index) + sprite_width / 2;
		var _enemyCenterY = _enemy.y - sprite_get_yoffset(sprite_index) + sprite_height / 2;		
		instance_create_layer(_enemyCenterX, _enemyCenterY, "Power_Exploding", obj_power_exploding);
		
		if (room != First_Level) {
			if (global.hugeOrb) {
				if (!_enemy.wasHitByHugeOrb) {
					_enemy.hp -= 2;
					_enemy.state = _enemy.state_hit;
					_enemy.wasHitByHugeOrb = true;
				}				
			} else {
				_enemy.hp -= 1;
				_enemy.state = _enemy.state_hit;
				instance_destroy();
			}
		} else {
			_enemy.hp -= 1;
			_enemy.state = _enemy.state_hit;
			instance_destroy();
		}
	}	
} 


if (room == Final_Level) {
	var _boss = instance_place(x + 1, y, obj_boss);
	if (_boss) {
		var _bossCenterX = _boss.x - sprite_get_xoffset(sprite_index) + sprite_width / 2;
		var _bossCenterY = _boss.y - sprite_get_yoffset(sprite_index) + sprite_height / 2;		
		instance_create_layer(_bossCenterX, _bossCenterY, "Power_Exploding", obj_power_exploding);
	
		if (_boss.hp > 0) {
			if (global.hugeOrb) {
			_boss.hp -= 5;
			} else { _boss.hp -= 1; }
		}	
		
		instance_destroy();
	}
}


image_alpha -= 0.02;
if (image_alpha <= 0) {
	instance_destroy();
}