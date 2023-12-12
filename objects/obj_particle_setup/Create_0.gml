particle_system = part_system_create();

particle_dust = part_type_create();

part_type_sprite(particle_dust, spr_walking_particle, 0, 0, 1)
part_type_size(particle_dust, 0.1, 0.8, 0.001, 0);

part_type_direction(particle_dust, 0, 0, 0, 1);
part_type_speed(particle_dust, 0.1, 0.2, -0.004, 0);

part_type_life(particle_dust, 10, 80);

part_type_orientation(particle_dust, 0, 180, 1, 1, 0);

part_type_alpha3(particle_dust, 1, 2, 0.01);