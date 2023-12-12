instance_destroy();

if (instance_exists(obj_boss)) { 
	if (!obj_boss.has_died) {
		obj_boss.state = obj_boss.state_free;
	}
}