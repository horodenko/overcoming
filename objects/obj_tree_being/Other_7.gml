switch (sprite_index) {
	case spr_tree_being_leaving:
		state = state_falling;
		break;
	case spr_tree_being_exploding:
		instance_destroy();
		break;
}