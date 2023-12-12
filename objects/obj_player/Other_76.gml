// Checar se animação de fade (da tela preta) finalizou
var _message = event_data[? "message"];
if event_data[? "event_type"] == "sequence event" {
    switch (_message) {
        case "Fade_End":
			if (room == First_Level) {
			     titleIn = layer_sequence_create(
					"Sequence_Title", 
					(obj_controller._guiWidth / 4),
					y - 130, 
					sq_title_in
				);
			} else if (room == Underground) {
				global.isFading = true;
			} else if (room == Second_Level) {
				global.isFading = true;
			} else if (room == Final_Level) {
				global.isFading = true;
				
			}
            break;			
		case "Title_Fade_In_End":
			layer_sequence_headdir(titleIn, -1);			
			layer_sequence_play(titleIn);		
			
			_titleInPlayed = true;
			break;			
		case "Title_Fade_In_Start":
			if (_titleInPlayed and room == First_Level) {
				layer_sequence_destroy(titleIn);
				_titleOutPlayed = true;
			}			
			break;			
		case "Fade_In_End":
			if (isDead) {
				layer_sequence_destroy(fade);
				audio_stop_all();
				room_restart();
			} else if (_hasFinishedLevel) {
				_hasFinishedLevel = false;
				global.isFading = false;
				layer_sequence_destroy(fade);

				switch (room) {
					case First_Level:
						if (!has_gone_underground) {
							global.storeProceed = 1;
						}
					
						room_goto(Store);
						break;
					case Underground:
						global.storeProceed = 1;
						room_goto(Store);
						break;
					case Second_Level:
						global.storeProceed = 2;
						room_goto(Store);						
						break;
					case Final_Level:
						room_goto(Cutscene);
						break;
				}
			}
			break;
    }
}