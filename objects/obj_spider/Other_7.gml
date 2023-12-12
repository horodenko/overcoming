switch (sprite_index) {
	case spr_spider_hit:
		state = state_chase;
		break;
	case spr_spider_attack:
		state = state_chase;			
		break;
	case spr_spider_dying:
		var _y = 10;
		repeat(3) {
			var droppedOrb = instance_create_layer(x, y - _y, "Instances", obj_orb);
			_y += 25;
			droppedOrb.sprite_index = spr_orb_dropped;
			droppedOrb.isDrop = true;
		}					
		
		instance_destroy();			
		break;
}