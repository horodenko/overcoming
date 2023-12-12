event_inherited();

switch (room) {
	case First_Level:
		hp = 3;
		break;
	case Second_Level:
		hp = 9;
		break;
}

if (room == First_Level) {
	vel = choose(2, -2);
} else {
	vel = choose(3, -3);
}

andando = choose(true, false);
tempo_decidir_andar = room_speed * 3;
canAttack_duration = room_speed * .5
canAttack_timer = 0;
canChase_timer = room_speed * 1.5;

state_free = function() {
	var _chao;
	switch (room) {
		case First_Level:
			_chao = place_meeting(x, y + 1, obj_ground);
			break;
		case Second_Level:
			_chao = place_meeting(x, y + 1, obj_ground_2);
			break;
	}

	if (_chao) {				
		tempo_decidir_andar -= 1;	 
		if (tempo_decidir_andar <= 0) {
			andando = choose(true, false);
		 
			// Escolhendo a direção se ele decidiu andar
			if (andando) {
				velH = choose(vel, -vel);							
			}	
			else {
				velH = 0;
			}
			
			// Resetando o tempo
			tempo_decidir_andar = room_speed * 3;
		}
		
		canChase_timer--;
		if (canChase_timer <= 0) {
			canChase_timer = 0;
		}
		
		if	((
					!obj_player._branch 
					and 
					obj_player._chao
					and 
					obj_player.sprite_index != spr_char_hanging_tamarin
					and obj_player.state != obj_player.state_jump
			  )
			) 
		{
			if (distance_to_object(obj_player) < distance) {
				state = state_chase;			
			}
		}				
		
		if (isCollidingWithWall()) {
			velH *= -1;
		}
	 
		// Controlando a animação do inimigo
		if (velH != 0) {
		    sprite_index = spr_spider_walking;
			image_xscale = sign(velH);
		} else {
		    sprite_index = spr_spider_idle;
		}
	}	else {   
			//Se eu estou no chão, eu aplico a gravidade
			velV += grav;
	
			velH = 0;
	
			if (velH != 0) {
				image_xscale = sign(velH);	
			}
	}
}
	
state_chase = function() {		
	if (isCollidingWithWall()) state = state_free;
	tempo_decidir_andar = room_speed * 3;

	if ((
			obj_player._branch 
			and
			!obj_player._chao)
			or 
			(obj_player._chao and obj_player.sprite_index == spr_char_hanging_tamarin)
		) state = state_free;
	
	if (distance_to_object(obj_player) > distance) {		
		state = state_free;
	}	
	
	if (distance_to_object(obj_player) < 1 and canChase_timer <= 0) {		
		audio_play_sound(snd_spider_attacking, 1, false);
		state = state_attack;		
	} else {	
		if (isCollidingWithWall()) {
			canChase_timer = room_speed * 1.5;
			state = state_free;
		}
		
		if (canChase_timer <= 0) {			
			if (onSummonGrass(floor(image_index))) {
				part_particles_create(obj_particle_setup.particle_system, x, y, obj_particle_setup.particle_dust, 1);
				
				if (!audio_is_playing(snd_spider_walking)) {
					audio_play_sound(snd_spider_walking, 1, false);
				}
			}
			
			vir = sign(obj_player.x - x);
			velH = vir * 2;
		
			sprite_index = spr_spider_walking;
			image_xscale = sign(velH);
		}	else { state = state_free; }
	}	
}

state_attack = function() {	
	reset_index(spr_spider_attack);
	
	velH = 0;
	sprite_index = spr_spider_attack;		
	
	if (floor(image_index) == image_number - 1)
	{
		if (obj_player.invincibility_timer <= 0) {
			canDamagePlayer = true;	
		}
	}
}

state_hit = function() {
	reset_index(spr_spider_hit);
	
	if (hp <= 0) {
		state = state_dead;
	} else {		
		velH = 0;
		sprite_index = spr_spider_hit;			
		
		if (floor(image_index) == 4 and !global.hitExplosion) {
			image_speed = 0;
		}
		
		if (global.hitExplosion) {
			image_speed = 1;
		}
	}
}

_play_sound_dead = false;
state_dead = function() {	
	if (!audio_is_playing(snd_spider_dying) and !_play_sound_dead) {
		_play_sound_dead = true;
		audio_play_sound(snd_spider_dying, 1, false);
	}
	
	velH = 0;
	sprite_index = spr_spider_dying;
}

state = state_free;

function isCollidingWithWall() {
	return place_meeting(velH > 0 ? x + 200 : x - 200, y, obj_enemy_restriction);					
}

function onSummonGrass(_index) {
	return _index % 2 == 0;
};