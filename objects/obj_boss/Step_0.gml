if (has_died) { instance_destroy(); exit; }
if (hp <= 0) state = state_dead;

if (!global.dialogue and !global.is_dialogue_finished) start_dialogue = true;
if (!global.isFading) exit;
else if (global.dialogue) exit;

if (!has_created_aura and can_have_aura) {
	has_created_aura = true;
	instance_create_layer(self.x, self.y, "Boss_Aura", obj_boss_aura);
}

state();