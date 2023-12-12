// Criando objeto game control, atualizar e colocar no creation code da room INICIAL (no caso, o menu
// ou algo parecido)
if (!instance_exists(obj_controller)) {
	instance_create_depth(0, 0, 0, obj_controller)
};