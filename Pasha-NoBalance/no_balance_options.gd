extends Node

var enemy_spawn_multiplier := 1.0
var tree_spawn_multiplier := 1.0
var boss_spawn_multiplier := 1.0

const MOD_NAME = "Pasha-NoBalance"
const CONFIG_FILENAME = "user://pasha-no-balance-options.cfg"
const CONFIG_SECTION = "options"

const ENEMY_MULTIPLIER_KEY = "pasha_no_balance_enemy_spawn_multiplier"
const TREE_MULTIPLIER_KEY = "pasha_no_balance_tree_spawn_multiplier"
const BOSS_MULTIPLIER_KEY = "pasha_no_balance_boss_spawn_multiplier"

func _ready():
	var mod_configs_interface = get_node("/root/ModLoader/dami-ModOptions/ModsConfigInterface")
	mod_configs_interface.connect("setting_changed", self, "setting_changed")

func setting_changed(key:String, value, mod) -> void:
	if mod != MOD_NAME:
		return
		
	var lower_key = key.to_lower()
	if lower_key == ENEMY_MULTIPLIER_KEY:
		enemy_spawn_multiplier = value
	elif lower_key == TREE_MULTIPLIER_KEY:
		tree_spawn_multiplier = value
	elif lower_key == BOSS_MULTIPLIER_KEY:
		boss_spawn_multiplier = value
	
	save_configs()

func load_configs() -> void:
	var mod_configs_interface = get_node("/root/ModLoader/dami-ModOptions/ModsConfigInterface")
	
	var config = ConfigFile.new()
	var err = config.load(CONFIG_FILENAME)
	
	if err != OK:
		return
	
	enemy_spawn_multiplier = config.get_value(CONFIG_SECTION, ENEMY_MULTIPLIER_KEY, 1.0)
	mod_configs_interface.on_setting_changed(ENEMY_MULTIPLIER_KEY.to_upper(), enemy_spawn_multiplier, MOD_NAME)
	
	tree_spawn_multiplier = config.get_value(CONFIG_SECTION, TREE_MULTIPLIER_KEY, 1.0)
	mod_configs_interface.on_setting_changed(TREE_MULTIPLIER_KEY.to_upper(), tree_spawn_multiplier, MOD_NAME)
	
	boss_spawn_multiplier = config.get_value(CONFIG_SECTION, BOSS_MULTIPLIER_KEY, 1.0)
	mod_configs_interface.on_setting_changed(BOSS_MULTIPLIER_KEY.to_upper(), boss_spawn_multiplier, MOD_NAME)

func save_configs() -> void:
	var config = ConfigFile.new()
	
	config.set_value(CONFIG_SECTION, ENEMY_MULTIPLIER_KEY, enemy_spawn_multiplier)
	config.set_value(CONFIG_SECTION, TREE_MULTIPLIER_KEY, tree_spawn_multiplier)
	config.set_value(CONFIG_SECTION, BOSS_MULTIPLIER_KEY, boss_spawn_multiplier)
	
	config.save(CONFIG_FILENAME)
