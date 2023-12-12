if (global.cooldownReduction) exit;

if (global.orbs >= 10) {
	global.orbs -= 10;
	global.cooldownReduction = true;

	obj_remover_3.visible = true;
}