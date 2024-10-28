extends "res://global/entity_spawner.gd"

func on_group_spawn_timing_reached(group_data:WaveGroupData) -> void:
	var no_balance_options = $"/root/PashaNoBalanceOptions"
	
	var enemy_multiplier = no_balance_options.enemy_spawn_multiplier
	var tree_multiplier = no_balance_options.tree_spawn_multiplier
	var boss_multiplier = no_balance_options.boss_spawn_multiplier
	
	var new_group_data = WaveGroupData.new()
	
	new_group_data.wave_units_data = []
	
	for unit_wave_data in group_data.wave_units_data:
		var duped_data = unit_wave_data.duplicate()
		
		if unit_wave_data.type == EntityType.ENEMY:
			duped_data.min_number *= enemy_multiplier
			duped_data.max_number *= enemy_multiplier
		elif unit_wave_data.type == EntityType.NEUTRAL:
			duped_data.min_number *= tree_multiplier
			duped_data.max_number *= tree_multiplier
			
		if group_data.is_boss and boss_multiplier > 1:
			group_data.repeating = boss_multiplier - 1 as int
			group_data.repeating_interval = 1
			group_data.min_repeating_interval = 1
		
		new_group_data.wave_units_data.push_back(duped_data)
	
	_current_wave_data.max_enemies = 10_000
	.on_group_spawn_timing_reached(new_group_data)

func _physics_process(_delta:float)->void :
	
	var no_balance_options = $"/root/PashaNoBalanceOptions"
	
	var max_mult = no_balance_options.enemy_spawn_multiplier
	max_mult = max(max_mult, no_balance_options.tree_spawn_multiplier)
	max_mult = max(max_mult, no_balance_options.boss_spawn_multiplier)
	
	for _i in (max_mult / SPAWN_DELAY - 1):
		# TODO something multiplayer?
		if queues_to_spawn_structures[0].size() > 0:
			spawn(queues_to_spawn_structures[0])
		if queue_to_spawn_trees.size() > 0:
			spawn(queue_to_spawn_trees)
		if queue_to_spawn_bosses.size() > 0:
			spawn(queue_to_spawn_bosses)
		if queue_to_spawn_summons.size() > 0:
			spawn(queue_to_spawn_summons)
		if queue_to_spawn.size() > 0:
			spawn(queue_to_spawn)
	
