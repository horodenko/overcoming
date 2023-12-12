enum Infos {
	Text,
	Portrait,
	Side,
	Name
}

text_grid = ds_grid_create(4, 0);

npc_name =  "";
pages = 0;
init = false;

characters = 0;
alarm[0] = 1;
text_length = 0;