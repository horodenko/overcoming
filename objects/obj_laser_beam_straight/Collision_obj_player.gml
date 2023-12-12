if (!instance_exists(obj_boss)) { 
	exit; 
} else if (obj_boss.has_died) exit;

if (!cannotDamagePlayer) {
	obj_player.wasHitBySomething = true;
	cannotDamagePlayer = true;
}
