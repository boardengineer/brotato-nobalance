extends Node

var enemy_spawn_multiplier = 1
var tree_spawn_multiplier = 1
var boss_spawn_multiplier = 1

const MOD_NAME = "Pasha-NoBalance"
const CONFIG_FILENAME = "user://pasha-no-balance-options.cfg"
const CONFIG_SECTION = "options"

func _ready():
	var mod_configs_interface = get_node("/root/ModLoader/dami-ModOptions/ModsConfigInterface")
	mod_configs_interface.connect("setting_changed", self, "setting_changed")

func setting_changed(key:String, value, mod) -> void:
	print_debug(key, " ", value, " ", mod)
	if mod != MOD_NAME:
		return
		
	var lower_key = key.to_lower()
	if lower_key == "pasha_no_balance_enemy_spawn_multiplier":
		enemy_spawn_multiplier = value
	elif lower_key == "pasha_no_balance_tree_spawn_multiplier":
		tree_spawn_multiplier = value
	elif lower_key == "pasha_no_balance_boss_spawn_multiplier":
		boss_spawn_multiplier = value
	
	save_configs()

func load_configs() -> void:
	var mod_configs_interface = get_node("/root/ModLoader/dami-ModOptions/ModsConfigInterface")
	
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILENAME)
	
	if err != OK:
		return
	
	enemy_spawn_multiplier = config.get_value(CONFIG_SECTION, "pasha_no_balance_enemy_spawn_multiplier", false)
	mod_configs_interface.on_setting_changed("pasha_no_balance_enemy_spawn_multiplier".to_upper(), enemy_spawn_multiplier, MOD_NAME)
	
	tree_spawn_multiplier = config.get_value(CONFIG_SECTION, "pasha_no_balance_tree_spawn_multiplier", false)
	mod_configs_interface.on_setting_changed("pasha_no_balance_tree_spawn_multiplier".to_upper(), tree_spawn_multiplier, MOD_NAME)
	
	boss_spawn_multiplier = config.get_value(CONFIG_SECTION, "pasha_no_balance_boss_spawn_multiplier", false)
	mod_configs_interface.on_setting_changed("pasha_no_balance_boss_spawn_multiplier".to_upper(), boss_spawn_multiplier, MOD_NAME)

func save_configs() -> void:
	var config = ConfigFile.new()
	
	config.set_value(CONFIG_SECTION, "pasha_no_balance_enemy_spawn_multiplier", enemy_spawn_multiplier)
	config.set_value(CONFIG_SECTION, "pasha_no_balance_tree_spawn_multiplier", tree_spawn_multiplier)
	config.set_value(CONFIG_SECTION, "pasha_no_balance_boss_spawn_multiplier", boss_spawn_multiplier)
	
	config.save(CONFIG_FILENAME)
