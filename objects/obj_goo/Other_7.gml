switch (sprite_index) {
	case spr_goo_hit:
		has_played_snd_hit = false;
		state = state_chase;
		break;
	case spr_goo_attacking:
		state = state_chase;			
		break;
	case spr_goo_dying:
		var _y = 10;
		repeat(2) {
			var droppedOrb = instance_create_layer(x, y - _y, "Instances", obj_orb);
			_y += 25;
			droppedOrb.sprite_index = spr_orb_dropped;
			droppedOrb.isDrop = true;
		}					
		
		instance_destroy();			
		break;
}