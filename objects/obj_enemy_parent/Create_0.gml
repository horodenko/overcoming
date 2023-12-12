event_inherited();

isDead = false;
canDamagePlayer = false;

wasHitByHugeOrb = false;

distance = 200;

stop_sprite_looping = function(desired_sprite) {
	if (sprite_index == desired_sprite)	{
		image_speed = 0; 
		image_index = image_number - 1;
	}
	
	image_speed = 1;
}

reset_index = function(desired_sprite) {
	if (sprite_index != desired_sprite) 
	{
		image_index = 0;
	}
}