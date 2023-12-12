_canWalkReverse = false;
_canJumpReversed = false;
_canInteractReversed = false;
_canAttackReversed = false;

#region Criando inputs de movimento
	inputs = {
		left: ord("A"),
		right: ord("D"),
		jump: vk_space
	}
#endregion

#region Sprites
	sprite_states = {
		isRunning: spr_char_running,
		isIdle: spr_char_idle,
		isJumpUpIdle: spr_char_jump_up_idle,
		isJumpDownIdle: spr_char_jump_down_idle,
		isHit: spr_char_hit,
		isFogEntering: spr_char_fog_enter,
		isBeingKnockedBack: spr_char_knocked_back,
		isGettingUp: spr_char_getting_up,
		isDowned: spr_char_downed,
		isDead: spr_char_dead,
		isAttacking: spr_char_attacking,
		isHanging: spr_char_hanging,
		
		isIdleTamarin: spr_char_idle_tamarin,
	};
#endregion

#region Definir variáveis específicas aqui
	event_inherited();

	alarm[0] = 5;

	_titleInPlayed = false;
	_titleOutPlayed = false;
	hasEnteredFog = false;

	//image_speed = 0;
	other.image_xscale = 1;
	
	canEmitDust = true;
#endregion

#region Definição de velocidades
	velH = 0;
	velV = 0;
	velJump = 5;

	vel = 4;
	grav = .11;
#endregion

#region Controlar dano tomado da personagem
	hp = 5;
	if (room != First_Level) {
		if (global.hasTamarin) {
			hp = 7;
		} else hp = 5;
	}

	isDead = false;

	// O player pode levar dano por um segundo
	damage_duration = room_speed * .5
	damage_timer = 0;

	// Tempo que o jogador fica invulnerável
	invincibility_duration = room_speed * 2;
	invincibility_timer = 0;
#endregion

#region Controlar mensagens de dica
	message_states = {
		firstMessage: false,
		allowFirstMessage: false,
	
		secondMessage: false,
		allowSecondMessage: false,
		
		thirdMessage: false,
		allowThirdMessage: false
	};
#endregion

#region Funções
	on_reset_level = function() {
		global.isFading = false;

		fade = layer_sequence_create(
			obj_controller._fadeId,
			x,
			y,
			sq_fade_in
		);		
	}

	// resetar index da atual sprite para 0 sempre que ela for trocada
	reset_index = function(desired_sprite) {
		if (sprite_index != desired_sprite) 
		{
			image_index = 0;
		}
	}

	//  parar animações de sprites para que não repitam
	isAnimationFinished = false;
	stop_sprite_looping = function(desired_sprite) {
		if (sprite_index == desired_sprite)	{
			image_speed = 0;
			image_index = image_number - 1;
		}
		
		// fazer o check de troca de sprite no step apenas se a animação terminou
		if (sprite_index == sprite_states.isJumpUpIdle or sprite_index == spr_char_jump_up_tamarin) {
			if (velV > 0) {
				isAnimationFinished = true;
			}
		}
	
		image_speed = 1;
	}
	
	change_to_tamarin_sprite = function(_sprite_tamarin, _default_sprite) {
		if (room != First_Level) {
			if (global.hasTamarin) {
				sprite_index = _sprite_tamarin;
			} else {
				sprite_index = _default_sprite;
			}
		}  else {
				sprite_index = _default_sprite;
		}
	}
	
	reset_tamarin_sprite = function(_sprite_tamarin, _default_sprite) { 
		if (room != First_Level) {
			if (global.hasTamarin) {
				reset_index(_sprite_tamarin);
			} else {
				reset_index(_default_sprite);
			}
		}  else {
				reset_index(_default_sprite);
		}
	}

	_hasFinishedLevel = false;
	_canDrawHud = false;
	_reverseMessage = false;
	_pressToAttack = noone;
	onEnterFog = function() {
		if (!_reverseMessage and !is_undefined(_pressToAttack)) {
			_reverseMessage = true;
			
			layer_sequence_headdir(_pressToAttack, -1);		
			layer_sequence_play(_pressToAttack);
				
			_canAttackReversed = false;
		}
		
		if (room != First_Level) hasEnteredFog = true;
		
		if (hasEnteredFog) {
			if (
				distance_to_object(obj_fog) < 80
				or 
				distance_to_object(obj_last_fog) < 80
			) {
				velH = 0;
				move_towards_point(x + 20, y, 2);	
			
			} else {
				speed = 0;		
				_canDrawHud = true;
			
				state = state_free;
			}
		} else {
			if (room == First_Level) {
				var destination_x = obj_ghost.x - 10;
				if (point_distance(x, y, destination_x, y) > speed) {
					velH = 0;
					move_towards_point(destination_x, y, 2);	
				} else { 
					speed = 0;
					x = destination_x;
					state = state_free; 
				} 
			}			
		}	
	}
		
	wasHit = function(_treeBeing = false, _grabbed = false) {
		reset_index(sprite_states.isHit);
		if (!audio_is_playing(snd_player_hit)) {
			audio_play_sound(snd_player_hit, 1, false);
		}
	
		velV = 0;
		
		if (!_grabbed) {
			switch (room) {
				case First_Level: 
					self.y = obj_ground.y;
					break;
				case Underground: 
					self.y = obj_ground.y;
					break;
				case Second_Level:
					if (_treeBeing) {
						break;
					} else {
						self.y = obj_ground_2.y;
					}
					break;
				case Final_Level:
					self.y = obj_ground.y;
					break;
			}
		}
	
		
		change_to_tamarin_sprite(spr_char_hit_tamarin, spr_char_hit);
		hp--;		
		damage_timer = damage_duration;
		invincibility_timer = invincibility_duration;	
	}

	function onSummonGrass(_index) {
		return _index == 1 or _index == 3 or _index == 4;
	};	
		
	if (room == Underground or room == Second_Level or room == Final_Level) {
		change_to_tamarin_sprite(spr_char_idle_tamarin, spr_char_idle);
		global.has_power = true;		
	} 
	
#endregion

#region Máquina de Estados

	_branch = noone;
	_chao = noone;
	ledge_instance = noone;
	ledge_count = 0;
	hasJumped = false;
	isHeld = false;
	isRepeating = false;
	wasHitBySomething = false;
	wasHitByBeing = false;
	wasGrabbed = false;
	has_gone_underground = false;
	
	state_free = function() {
		if (sprite_index == sprite_states.isHit or sprite_index == spr_char_hit_tamarin) {
			exit;
		}
		
		if (_hasFinishedLevel) {
			on_reset_level();
		}
		
		if (has_gone_underground) exit;
		
		ledge_instance = noone;
		ledge_count += 1;

		// Controle de Tiro
		key_shoot = keyboard_check_pressed(ord("X")); // Soltar poder

		// Checar se personagem está no chão 
		switch (room) {
			case First_Level:
				_chao = place_meeting(x, y + 1, obj_ground);
				break;
			case Underground:
				_chao = place_meeting(x, y + 1, obj_ground);
				break;
			case Second_Level:
				_chao = place_meeting(x, y + 1, obj_ground_2);
				break;
			case Final_Level:
				_chao = place_meeting(x, y + 1, obj_ground);
				break;
		}
		
		_branch = place_meeting(x, y + 1, obj_branch);

		var _left, _right, _jump;

		// Checando teclas pressionadas baseada nos inputs (teclas) definidas no evento Create
		_left = keyboard_check(inputs.left);
		_right = keyboard_check(inputs.right);
		_jump = keyboard_check_pressed(inputs.jump);
		
		_xInput = _right - _left;
		velV += grav;

		if (room != First_Level) {
			if (global.hasTamarin) {
				if (ledge_count > 10) {
					ledge_instance = instance_place(x + velH, y, obj_ledge);
				}				
		
				if (ledge_instance != noone) {
					isHeld = true;
					velV = 0;			
					y = ledge_instance.y + (sprite_height / 2);		
			
					_chao = true;
				}
			}		
		}		
		
		// Só posso me mexer se o damage_timer não está zerado
		if (damage_timer <= 0) {
			velH = _xInput * vel;
		}	
		
		if (_chao or (_branch and canStepOnBranch)) {			
			if (_jump) {
				if (!audio_is_playing(snd_jumping)) {
					audio_play_sound(snd_jumping, 1, false);
				}
				state = state_jump;				
			}	 
			
			if (isHeld) velH = 0;

			if (hasJumped) hasJumped = false;
			if (_chao) canStepOnBranch = false;			
			
			// Trocar para a sprite de corrida se a velocidade for diferente de 0 (menor que zero: esquerda; maior: direita (horizontalmente))
			if (velH != 0) {
				reset_tamarin_sprite(spr_char_running_tamarin, spr_char_running);
				//reset_tamarin_running();
		
				// Troca de sprite
				change_to_tamarin_sprite(spr_char_running_tamarin, spr_char_running);
				//change_to_tamarin_running();
		
				floor_index = floor(image_index);
		
				// Criar partículas da grama com base nas customizações feitas no obj_particle_setup
				if (onSummonGrass(floor_index) and canEmitDust and !_branch and (room == First_Level or room == Second_Level)) {					
					canEmitDust = false;
	
					alarm_set(0 , 8);
	
					part_particles_create(obj_particle_setup.particle_system, x, y, obj_particle_setup.particle_dust, 5);
			
					audio_play_sound(snd_step, 1, 0);
				}
						
				
				if (_branch) {
					if (!audio_is_playing(snd_step_branch)) {
						audio_play_sound(snd_step_branch, 1, false);
					}
				}
			
				// Troca de direção
				image_xscale = sign(velH);							
			} else if (!isHeld) {
				reset_tamarin_sprite(spr_char_idle_tamarin, spr_char_idle);
				//reset_tamarin_idle();
				change_to_tamarin_sprite(spr_char_idle_tamarin, spr_char_idle);
				//change_to_tamarin_idle();
			}
			
			if (isHeld) {
				sprite_index = spr_char_hanging_tamarin;
				isHeld = false;
			};
		
			if (distance_to_object(obj_fog) == 0) {		
				if (global.has_power) {										
					if (!isCollidingRight) {
						if (!audio_is_playing(snd_entering_fog)) {
							audio_play_sound(snd_entering_fog, 1, false);
						}
						
						sprite_index = sprite_states.isFogEntering;
						image_xscale = 1;		
					}
					
					if (isCollidingRight) {
						audio_play_sound(snd_knocked_by_fog, 1, false);						
						
						sprite_index = sprite_states.isBeingKnockedBack;
						image_xscale = -1;		
					}		
					
					if (!hasEnteredFog) hasEnteredFog = true;
					
					state = state_enteringFog;			
				} else {
					audio_play_sound(snd_knocked_by_fog, 1, false);										
					sprite_index = sprite_states.isBeingKnockedBack;
						
					state = state_enteringFog;			
				}
			} else if (distance_to_object(obj_last_fog) == 0) {
				if (!audio_is_playing(snd_entering_fog)) {
					audio_play_sound(snd_entering_fog, 1, false);
				}
				
				_hasFinishedLevel = true;
				sprite_index = sprite_states.isFogEntering;
				
				state = state_enteringFog;
			}
		
			if (distance_to_object(obj_par_npcs) <= 10) {		
				if (keyboard_check_released(ord("F")) and !global.dialogue and !global.is_dialogue_finished) {				
					// Iniciar conversa com NPC
					var _npc = instance_nearest(x, y, obj_par_npcs);
					var _dialogue = instance_create_layer(x, y, "Dialogue", obj_dialogue);			
					_dialogue.npc_name = _npc.reference_name;
				
					state = state_dialogue;
				}				
				
				global.is_interact_focused = true;
			} else if (room == Final_Level) {
				if (obj_boss.start_dialogue and global.isFading) {
					var _npc = instance_nearest(x, y, obj_par_npcs);
					var _dialogue = instance_create_layer(x, y, "Dialogue", obj_dialogue);			
					_dialogue.npc_name = _npc.reference_name;
					
					state = state_dialogue;
				}				
			} else {
				global.is_interact_focused = false;
			} 
		
			if (key_shoot 
					and !global.cooldown
					and !global.dialogue
					and global.has_power
			) { 
					state = state_power;
			}
		} else {		
			isRepeating = false;
			
			if (velV < 0) {		
				change_to_tamarin_sprite(spr_char_jump_up_tamarin, spr_char_jump_up_idle);
				//change_to_tamarin_jump_up();
			} 
			
			if (velV > 0 and isAnimationFinished) {		
				reset_tamarin_sprite(spr_char_jump_down_tamarin, spr_char_jump_down_idle);
				//reset_tamarin_jump_down();
				isAnimationFinished = false;
				
				change_to_tamarin_sprite(spr_char_jump_down_tamarin, spr_char_jump_down_idle);
				//change_to_tamarin_jump_down();
				
				if (isRepeating) {
					sprite_set_offset(sprite_states.isJumpDownIdle, 16, 100);	
					sprite_set_offset(sprite_states.isJumpDownIdle, 16, 100);		
				} else {
					sprite_set_offset(sprite_states.isJumpDownIdle, 16, 56);	
					sprite_set_offset(sprite_states.isJumpDownIdle, 16, 56);
				}
			} else if (velV > 0 and !hasJumped) {
				reset_tamarin_sprite(spr_char_jump_down_tamarin, spr_char_jump_up_idle);
				//reset_tamarin_jump_down();				
				change_to_tamarin_sprite(spr_char_jump_down_tamarin, spr_char_jump_up_idle);
				//change_to_tamarin_jump_down();
				
				sprite_set_offset(sprite_states.isJumpDownIdle, 16, 56);	
				sprite_set_offset(sprite_states.isJumpDownIdle, 16, 56);
			}
		
		if (ledge_instance == noone) {
			velV += grav;
		}
		
		if (velH != 0) {
				// Redefinindo / permitindo troca de direção no ar
				image_xscale = sign(velH);
			} 
		}
	}
		
	state_jump = function() {
		reset_tamarin_sprite(spr_char_jump_up_tamarin, spr_char_jump_up_idle);
		//reset_tamarin_jump_up();
		
		if (sprite_index == sprite_states.isHit) { exit; }
		
		hasJumped = true;
				
		// Pulando (eixo Y negativo é para cima, diferente do plano cartesiano)			
		velV = -velJump;		
		
		ledge_count = 0;
		
		state = state_free;
	}
	
	state_ledge = function() {
		sprite_index = spr_char_hanging;
			
		velV = 0;
		state = state_free;		
	}

	state_enteringFog = function() {			
		onEnterFog();			
	}	

	state_dialogue = function() {	
		// Parando personagem ao iniciar diálogo
		if (global.dialogue) {
			velV = 0;
			velH = 0;
			image_xscale = 1;
			
			change_to_tamarin_sprite(spr_char_idle_tamarin, spr_char_idle);
			//change_to_tamarin_idle();
		} else {
			state = state_free;
		} 		
	}

	hasAttacked = false;
	state_power = function() {
		if (sprite_index == sprite_states.isHanging) { 
			state = state_free;
		} else {
			velH = 0;
			velV = 0;
		
			reset_tamarin_sprite(spr_char_attacking_tamarin, spr_char_attacking);
			change_to_tamarin_sprite(spr_char_attacking_tamarin, spr_char_attacking);
			
			if (room != First_Level) {
				if (global.hugeOrb  and floor(image_index) < image_number - 2) {
					image_speed = 0.85;
				}	else {
					image_speed = 1;
				}
			}			
			
			if (floor(image_index) == image_number - 3 and !hasAttacked) {
				if (!audio_is_playing(snd_player_attacking)) {
					audio_play_sound(snd_player_attacking, 1, false);
				}
				
				var playPowerSnd = audio_play_sound(snd_power, 1, false);
				if (!audio_is_playing(playPowerSnd)) {
					audio_play_sound(playPowerSnd, 1, false);
				}
				
				hasAttacked = true;
				
				var _xx;
				if (other.image_xscale == 1) {
					_xx = x + lengthdir_x(20, image_angle);
				}  else {
					_xx = x + lengthdir_x(-20, image_angle);
				}
				
				if (room != First_Level) {
					if (global.tripleShoot) {						 
						var _x = 10;						
						repeat(3) {							
							var orbCreated = onCreateOrb(_xx + _x);
							_x += 15;
						}
					} else if (global.hugeOrb) {
						orbCreated = onCreateOrb(_xx);
						orbCreated.image_xscale = 2.30;
						orbCreated.image_yscale = 2.30;
					} else {
						onCreateOrb(_xx);	
					}			
				} else {
					onCreateOrb(_xx);
				}						
			}			
		}	
	}
	
	function onCreateOrb(_x, _additionalX = 0) {
		var _orbInstance = instance_create_layer(_x + _additionalX, y - 20, "Shoot", obj_shoot);
		with (_orbInstance) {
			speed = 8;
			direction = -90 + 90 * other.image_xscale;		
			image_angle = direction;
		}	
		
		return _orbInstance;
	}
		
	//state_hit = function() {
	//	if (hp == 0) {
	//		state = state_dead;	
	//	}				
		
	//	var _enemy = instance_nearest(x, y, obj_enemy_parent);
	//	if (_enemy.canDamagePlayer and invincibility_timer <= 0) {			
	//		hp--;			
	//		_enemy.canDamagePlayer = false;
			
	//		damage_timer = damage_duration;
	//		invincibility_timer = invincibility_duration;		
	//	} 
		
	//	if (damage_timer > 0) {
	//		velH = 0;
	//		damage_timer--;
	//	}		
				
	//	if (invincibility_timer > 0) {			
	//		image_alpha = .5;
	//		invincibility_timer--;			
	//	} else  {
	//		image_alpha = 1;
	//	}
		
	//	show_debug_message(invincibility_timer);
	//}
	
	state_dead = function() {
		sprite_index = sprite_states.isDead;
		velH = 0;
	}

	state = state_free;

#endregion