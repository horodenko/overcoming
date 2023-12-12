if (!instance_exists(obj_boss)) { 
	exit; 
} else if (obj_boss.has_died) exit;

if (!cannotDamagePlayer and !obj_player.wasHitBySomething) {
	obj_player.wasHitBySomething = true;
	cannotDamagePlayer = true;
}
