if (room == Final_Level) {
	if (instance_exists(obj_boss)) {
		if (obj_boss.state == obj_boss.state_dead) {
			sprite_index = sprite_states.isIdle; 
			velH = 0; 
			velV = 0; 
			hp = 100;
			exit;
		}
	} else { sprite_index = sprite_states.isIdle; velH = 0; velV = 0; hp = 100;  exit;}
}

if (room == First_Level) {
	if  (x > 600 and   _canWalkReverse) {
		layer_sequence_headdir(_pressToWalk, -1);		
		layer_sequence_play(_pressToWalk);
				
		_canWalkReverse = false;
	}

	if (x  > 1100 and _canJumpReversed) {
		layer_sequence_headdir(_pressToJump, -1);		
		layer_sequence_play(_pressToJump);
				
		_canJumpReversed = false;
	}
	
	if (global.dialogue and _canInteractReversed) {
		layer_sequence_headdir(_pressToInteract, -1);		
		layer_sequence_play(_pressToInteract);
				
		_canInteractReversed = false;
	}
}

if (global.isFading and !isDead) {
	if (room == First_Level) {
		if (x > 800 and message_states.firstMessage == message_states.allowFirstMessage) {
			_pressToJump  = layer_sequence_create(
				obj_controller._pressToJumpId, 
				x + 200, 
				455, 
				sq_press_to_jump
			);						
									
			message_states.firstMessage = true;
			_canJumpReversed = true;
		}
		
		if (x > 1400 and message_states.secondMessage == message_states.allowSecondMessage) {	
			_pressToInteract = layer_sequence_create(
				obj_controller._pressToInteractId, 
				x + 200, 
				455, 
				sq_press_to_interact
			);
			
			message_states.secondMessage = true;
			_canInteractReversed = true;
		}
		
		if (global.is_dialogue_finished and message_states.thirdMessage == message_states.allowThirdMessage) {
			_pressToAttack = layer_sequence_create(
				obj_controller._pressToAttackId,
				x,
				455,
				sq_press_to_attack
			);
			
			message_states.thirdMessage = true;
			_canAttackReversed = true;
		}
	}		
	
	state();
}

if (room == Second_Level) {
	var _treeBeing = instance_nearest(self.x, self.y, obj_tree_being);
	if (instance_exists(_treeBeing)) { 
		if (point_distance(self.x, self.y, _treeBeing.x, self.y) < 80 and _treeBeing.state == _treeBeing.state_leaving) {
			_treeBeing.playerClose = true;
		}		
	}	
}

var _enemy = instance_nearest(x, y, obj_enemy_parent);	

if (hp == 0) {
	sprite_index = spr_char_dead;
	isDead = true;
	
	velH = 0;
	velV = 0;
	self.y = obj_ground.y;
}

if (damage_timer > 0) {
	velH = 0;
	damage_timer--;
}

if (invincibility_timer > 0 and sprite_index != sprite_states.isDead) {
	invincibility_timer--;
	image_alpha = .5;
} else {
	image_alpha = 1;
}

if (instance_exists(_enemy)) {
	if (_enemy.canDamagePlayer and invincibility_timer <= 0 and sprite_index != sprite_states.isDead) {	
		wasHit();
		_enemy.canDamagePlayer = false;
	}
} 

if (wasHitBySomething and invincibility_timer <= 0 and sprite_index != sprite_states.isDead) {
	wasHitBySomething = false;
	wasHit();
}

if (wasHitByBeing and invincibility_timer <= 0 and sprite_index != sprite_states.isDead) {
	wasHitByBeing = false;
	wasHit(true);
}

if (wasGrabbed and invincibility_timer <= 0 and sprite_index != sprite_states.isDead) {
	wasHit(false, true);
}