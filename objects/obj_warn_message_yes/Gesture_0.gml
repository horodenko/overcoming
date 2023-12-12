if (global.clickedFirst) {
	if (global.hugeOrb) {
		global.hugeOrb = false;
	}
	
	global.orbs -= 10;
	global.tripleShoot = true;
	
	obj_remover_1.visible = true;
	obj_warn_message.visible = false;
	global.clickedFirst = false;
} else if (global.clickedSecond) {
	if (global.tripleShoot) {
		global.tripleShoot = false;
	}
	
	global.orbs -= 25;
	global.hugeOrb = true;
	
	obj_remover_2.visible = true;
	obj_warn_message.visible = false;
	global.clickedSecond = false;
}