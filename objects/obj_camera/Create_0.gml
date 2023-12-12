if (room == Store or room == Cutscene or room == Cutscene_Alice_Overcame or room == Cutscene_Thanks) { exit; }

#macro cam view_camera[0]
#macro view_w camera_get_view_width(view_camera[0])
#macro view_h camera_get_view_height(view_camera[0])

aspect_ratio = display_get_width() / display_get_height();

view_height = 300;
view_width  = round(view_height * aspect_ratio);

// check if its an odd number, if it is, add 1 to it
if (view_width & 1) 
	view_width++;
if (view_height & 1)
	view_height++;
	
max_window_scale = min(floor(display_get_width() / view_width), floor(display_get_height() / view_height));
if (view_height * max_window_scale == display_get_height())
    max_window_scale--;
	
window_scale = max_window_scale;
 
window_set_size((view_width * window_scale), (view_height * window_scale));
alarm[0] = 1;

final_width = view_width * window_scale;
final_height = view_height * window_scale;

surface_resize(application_surface, final_width, final_height);
display_set_gui_size(final_width , final_height);