instance_destroy();

if (isStraightOrb) {
	if (straightLaserBeam == noone) {
		straightLaserBeam = instance_create_layer(x, y - 20, "Boss_Power", obj_laser_beam_straight);
		
	}
} 

if (isDownwardsOrb) {
	if (downwardsLaserBeam == noone) {
		downwardsLaserBeam = instance_create_layer(x, obj_boss.y - 150, "Boss_Power", obj_laser_beam_downwards);
	}
}

