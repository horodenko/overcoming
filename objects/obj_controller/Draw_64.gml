var _x = 60;
var _y = _guiHeight - 550;

if (room == Final_Level) {
	if (global.dialogue) exit;
	if (instance_exists(obj_boss)) {
		if (obj_boss.state == obj_boss.state_dead) {
			exit;
		}
	} else { exit; }
}

if (
	!global.dialogue
	and global.isFading 
	and !obj_player.isDead
	and !obj_player._hasFinishedLevel
) {
	draw_mobile_inputs(spr_arrow_left, 50, 450)
	draw_mobile_inputs(spr_arrow_right, 190, 450);
	
	if (global.has_power) {
		if (room != First_Level) {
			if (global.tripleShoot) {
				draw_mobile_inputs(spr_attack_triple, _guiWidth - 340, 430);
			} else if (global.hugeOrb) {
				draw_mobile_inputs(spr_attack_huge, _guiWidth - 340, 430);
			} else {
				draw_mobile_inputs(spr_attack, _guiWidth - 340, 430);
			}
		} else {
			draw_mobile_inputs(spr_attack, _guiWidth - 340, 430);
		}
	}
	
	if (room != Final_Level) {
		draw_mobile_inputs(spr_interact, _guiWidth - 140, 385);
	}
	draw_mobile_inputs(spr_arrow_up, _guiWidth - 190, 450);
}

switch (room) {
	case First_Level:
		if (obj_player._canDrawHud and !obj_player.isDead and !obj_player._hasFinishedLevel) {
			repeat(obj_player.hp) {
				draw_heart(_x, _y, 0.75, 0.75, spr_health);		
				_x += 40;
			}	
			
			draw_heart(75, _y + 70,  0.40, 0.40, spr_orb);
			draw_text(110, _y + 50, global.orbs);
		}
		break;
	case Underground:
		if (!obj_player.isDead and global.isFading and !obj_player._hasFinishedLevel) {
			repeat(obj_player.hp) {
				draw_heart(_x, _y,  0.75, 0.75, spr_health);		
				_x += 40;
			}				
					
			draw_heart(75, _y + 70,  0.40, 0.40, spr_orb);
			draw_text(110, _y + 50, global.orbs);
		}
		break;
	case Second_Level: 
		if (!obj_player.isDead and global.isFading and !obj_player._hasFinishedLevel) {
			repeat(obj_player.hp) {
				draw_heart(_x, _y,  0.75, 0.75, spr_health);		
				_x += 40;
			}				
					
			draw_heart(75, _y + 70,  0.40, 0.40, spr_orb);
			draw_text(110, _y + 50, global.orbs);
		}
		break;
	case Final_Level:
		if (!obj_player.isDead and global.isFading and !obj_player._hasFinishedLevel) {
			repeat(obj_player.hp) {
				draw_heart(_x, _y,  0.75, 0.75, spr_health);		
				_x += 40;
			}							
		}
		break;
}