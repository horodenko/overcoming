_guiWidth = display_get_gui_width();
_guiHeight = display_get_gui_height();

function onCreateKey(_x, _y, _w, _h, key) {
	if (global.isFading) {
		return virtual_key_add(_x, _y, _w, _h, key);
	}
}