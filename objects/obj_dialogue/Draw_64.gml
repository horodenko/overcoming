function draw_dialogue_box(_x, _y, _text, _w, _h) {
	draw_sprite(spr_dialogue_box, 0, _w / 2, _y + 10);
	draw_text_ext(_x + ((_w / 2) - 215), _y - (_h - 560), _text, 24, 430);
}

if (init) {
	var _guiWidth = display_get_gui_width();
	var _guiHeight = display_get_gui_height();

	var _xPos = 0;
	var _yPos = _guiHeight  - 100;
	
	if (room != Store) {
		var _sprite = text_grid[# Infos.Portrait, pages];
		var numberOfFrames = sprite_get_number(_sprite);
		var elapsed_time = current_time;
		// Calcular frame atual da animação da sprite (para rodar em 9 frames a animação
		var current_frame = floor(elapsed_time / 125) % 8;
	}
	
	var _text = string_copy(text_grid[# Infos.Text, pages], 0, characters);

	// guiWidth complementará toda a largura da tela, e guiHeight toda a altura disponível pelo conteúdo
	// baseado no _yPos;
 
	// metade da tela do dispositivo usado
	var _halfWidth = _guiWidth / 2;

	// Lado direito da portrait (retrato da personagem)
	if (text_grid[# Infos.Side, pages] == 0) {
		// Desenhar caixa de diálogo e texto de dentro
		draw_dialogue_box(_xPos, _yPos, _text, _guiWidth, _guiHeight);
	
		// Posicionar nome da fantasma próximo a ela na caixa de diálogo
		var _stgW = string_width(text_grid[# Infos.Name, pages]);
		
		// 'Desenhar' na tela nome da personagem, em cima da caixa de diálogo
		draw_text(((_halfWidth + 230) - _stgW), _yPos - 100, text_grid[# Infos.Name, pages]);
		
		if (room == Store) exit;
		 
		// Desenhar retrato da personagem
		draw_sprite_ext(_sprite, numberOfFrames > 2 ? current_frame : 0, (_halfWidth + 330), _guiHeight, 2.5, 2.5, 0, c_white, 1);
	} else {
		// Lado esquerdo
		draw_dialogue_box(_xPos, _yPos, _text, _guiWidth, _guiHeight);
		if (room == Store) exit;
		
		var _stgW = string_width(text_grid[# Infos.Name, pages]);
	
		draw_text(_halfWidth - 230, _yPos - 100, text_grid[# Infos.Name, pages]);
		draw_sprite_ext(_sprite, numberOfFrames > 2 ? current_frame : 0, (_halfWidth - 430), _guiHeight - 200, 2.5, 2.5, 0, c_white, 1);
	}
}
