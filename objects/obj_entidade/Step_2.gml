var wallCollision = instance_place(x + velH, y, obj_paredes_colisoras);
var _branchCollision = instance_place(x + velH, y, obj_branch);

// Colisao horizontal
if (wallCollision) {	
	// Checar se colide com o lado direito (borda do mapa)
	if (velH > 0) {
		x = wallCollision.bbox_left + (x - bbox_right);
	}
	// Checar se colide com o lado esquerdo (borda do mapa)
	if (velH < 0) {
		x = wallCollision.bbox_right + (x - bbox_left);
	}
};

if (_branchCollision) {
	if (velH > 0) {
		x = _branchCollision.bbox_left + (x - bbox_right);
	}
	// Checar se colide com o lado esquerdo (borda do mapa)
	if (velH < 0) {
		x = _branchCollision.bbox_right + (x - bbox_left);
	}
	
	velH = 0;
}

var fogCollision = instance_place(x + velH, y, [obj_fog, obj_last_fog]);
if (fogCollision) {	
	// Checar se colide com o lado esquerdo da névoa (indo para a esquerda)
	if (velH > 0) {
		x = fogCollision.bbox_left + (x - bbox_right);
	}
	// Checar se colide com o lado direito da névoa  (indo para a direita)
	if (velH < 0) {
		x = fogCollision.bbox_right + (x - bbox_left);
		
		if (x == fogCollision.bbox_right + (x - bbox_left)) isCollidingRight = true;		
	}
};

var horizontal_ground_collision;
var vertical_ground_collision;
switch (room) {
	case First_Level:		
		vertical_ground_collision = instance_place(x, y + velV, obj_ground);
		break;
	case Underground:		
		vertical_ground_collision = instance_place(x, y + velV, obj_ground);
		break;
	case Second_Level:		
		vertical_ground_collision = instance_place(x, y + velV, obj_ground_2);
		break;
	case Final_Level:
		var bossCollision = instance_place(x + velH, y, obj_boss_barrier);
		if (bossCollision) {	
			// Checar se colide com o lado esquerdo da névoa (indo para a esquerda)
			if (velH > 0) {
				x = bossCollision.bbox_left + (x - bbox_right);
			}
			// Checar se colide com o lado direito da névoa  (indo para a direita)
			if (velH < 0) {
				x = bossCollision.bbox_right + (x - bbox_left);
			}
		};
		
		vertical_ground_collision = instance_place(x, y + velV, obj_ground);
		break;
}

x += velH;
 
if (vertical_ground_collision) velV = 0;

var _branchCollision = instance_place(x, y + velV, obj_branch);

if (_branchCollision) {
	canStepOnBranch = true;
	velV = 0;	
}
	
// Velocidade da personagem
y += velV;