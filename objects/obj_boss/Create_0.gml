onSummonNewPowers = function() {
	var secondPowerOrb = instance_create_layer(downwardsPowerOrb.x + 100, downwardsPowerOrb.y, "Instances", obj_orb_boss);
	secondPowerOrb.isStraightOrb = false;
	secondPowerOrb.isDownwardsOrb = true;
			
	var thirdPowerOrb = instance_create_layer(downwardsPowerOrb.x - 100, downwardsPowerOrb.y, "Instances", obj_orb_boss);
	thirdPowerOrb.isStraightOrb = false;
	thirdPowerOrb.isDownwardsOrb = true;
			
	downwardsPowerOrb.image_speed = 1.2; 
	secondPowerOrb.image_speed = 1.2;
	thirdPowerOrb.image_speed = 1.2;
}

isInThirdPhase = function() {
	if (global.hugeOrb) {
		return hp < 30;
	} else if (global.tripleShoot) {
		return hp < 15;
	} else { return hp < 7; }
}

reference_name = "Boss";
start_dialogue = false;
has_died = false;

if (global.tripleShoot) { hp = 60; } 
else if (global.hugeOrb) { hp = 100; }
else { hp = 30; }

_boss_max_hp = hp;
_health_bar_width = 200;
_health_bar_height = 30;
_health_bar_x = display_get_gui_width() - 260;
_health_bar_y = 50;

decideAttack_timer = room_speed * 2;
straightPowerOrb = noone;
downwardsPowerOrb = noone;

can_have_aura = false;
has_created_aura = false;

state_free = function() {	
	straightPowerOrb = noone;
	downwardsPowerOrb = noone;
	
	if (global.tripleShoot) {
		sprite_index = hp < 30 ? spr_boss_idle_angry : spr_boss_idle;
		if (hp < 30) can_have_aura = true;
	} 
	else if (global.hugeOrb) { 	
		sprite_index = hp < 60 ? spr_boss_idle_angry : spr_boss_idle;
		if (hp < 60) can_have_aura = true;
	} else {	
		sprite_index = hp < 15 ? spr_boss_idle_angry : spr_boss_idle;
		if (hp < 15) can_have_aura = true;
	}
	
	image_speed = 1;
	
	decideAttack_timer -= 1;	 
	if (decideAttack_timer <= 0) {
		if (!isInThirdPhase()) {
			currentAttack = choose(state_straight_attack, state_downwards_attack);	
			state = currentAttack;
		} else { state = state_hellbound; }
		
		if (global.tripleShoot) {
			decideAttack_timer = hp < 30 ? room_speed * 1.7 : room_speed * 2;	
		} else if (global.hugeOrb) { 
			decideAttack_timer = hp < 60 ? room_speed * 1.7 : room_speed * 2;	
		} else {
			decideAttack_timer = hp < 15 ? room_speed * 1.7 : room_speed * 2;		
		}	
	}	
}

state_hellbound = function() {
	sprite_index = spr_boss_straight_angry;
	
	var bossY = self.y - sprite_get_yoffset(sprite_index) + sprite_height / 2;
	if (straightPowerOrb == noone and downwardsPowerOrb == noone) {
		straightPowerOrb = instance_create_layer(x - 50, bossY + 30, "Instances", obj_orb_boss);	
		downwardsPowerOrb = instance_create_layer(obj_player.x, y - 115, "Boss_Power", obj_orb_boss);
		
		downwardsPowerOrb.isStraightOrb = false;
		downwardsPowerOrb.isDownwardsOrb = true;		
		straightPowerOrb.isStraightOrb = true;
		straightPowerOrb.isDownwardsOrb = false;
		
		if (!audio_is_playing(snd_orb_creating)) audio_play_sound(snd_orb_creating, 1, false);
		
		onSummonNewPowers();
	}
}

state_straight_attack = function() {
	if (global.tripleShoot) {
		sprite_index = hp < 30 ? spr_boss_straight_angry : spr_boss_straight_attack;
	} 
	else if (global.hugeOrb) { 	
		sprite_index = hp < 60 ? spr_boss_straight_angry : spr_boss_straight_attack;
	} else {	
		sprite_index = hp < 15 ? spr_boss_straight_angry : spr_boss_straight_attack;
	}
	
	var bossY = self.y - sprite_get_yoffset(sprite_index) + sprite_height / 2;
	if (straightPowerOrb == noone) {
		straightPowerOrb = instance_create_layer(x - 50, bossY + 30, "Instances", obj_orb_boss);		
		
		straightPowerOrb.isStraightOrb = true;
		straightPowerOrb.isDownwardsOrb = false;
		
		if (!audio_is_playing(snd_orb_creating)) audio_play_sound(snd_orb_creating, 1, false);
		
		if (global.hugeOrb) {
			if (hp < 40) straightPowerOrb.image_speed = 1.2;
		} else if (global.tripleShoot) {
			if (hp < 30) straightPowerOrb.image_speed = 1.4;
		} else if (hp < 10) straightPowerOrb.image_speed = 1.2;
	}
}

state_downwards_attack = function() {
	if (global.tripleShoot) {
		sprite_index = hp < 30 ? spr_boss_downwards_angry : spr_boss_downwards_attack;
	} 
	else if (global.hugeOrb) { 	
		sprite_index = hp < 60 ? spr_boss_downwards_angry : spr_boss_downwards_attack;
	} else {	
		sprite_index = hp < 15 ? spr_boss_downwards_angry : spr_boss_downwards_attack;
	}
	
	if (downwardsPowerOrb == noone) {
		downwardsPowerOrb = instance_create_layer(obj_player.x, y - 115, "Boss_Power", obj_orb_boss);
		downwardsPowerOrb.isStraightOrb = false;
		downwardsPowerOrb.isDownwardsOrb = true;
		
		if (!audio_is_playing(snd_orb_creating)) audio_play_sound(snd_orb_creating, 1, false);
		
		if (global.hugeOrb) {
			if (hp < 60) { 
				onSummonNewPowers();
			} 
		} else if (global.tripleShoot) {
			if (hp < 30) onSummonNewPowers();
		} else if (hp < 15) onSummonNewPowers();
	}
	
	if (floor(image_index) == image_number - 2) {
		image_index = image_number - 3;
	}
}

has_played_sound_dying = false;
state_dead = function() {
	if (!has_played_sound_dying) {
		audio_play_sound(snd_boss_dying, 1, false);
		has_played_sound_dying = true;
	}
	
	image_speed = 1;
	sprite_index = spr_boss_dying;
}

currentAttack = choose(state_straight_attack, state_downwards_attack);

state = state_free;