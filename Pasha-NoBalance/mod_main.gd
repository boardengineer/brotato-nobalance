extends Node

const MOD_DIR = "Pasha-NoBalance/"

var dir
var extension_dir
var translation_dir

var options_node_script = load("res://mods-unpacked/Pasha-NoBalance/no_balance_options.gd")

func _init(_modLoader = ModLoader):
	dir = ModLoaderMod.get_unpacked_dir() + MOD_DIR
	extension_dir = dir + "extensions/"
	translation_dir = dir + "translations/"
	
	ModLoaderMod.install_script_extension(extension_dir + "entities/units/neutral/neutral.gd")
	ModLoaderMod.add_translation(translation_dir + "pasha_no_balance.en.translation")

func _ready():
	ModLoaderMod.install_script_extension(extension_dir + "global/entity_spawner.gd")
	
	var options_node = options_node_script.new()
	options_node.set_name("PashaNoBalanceOptions")
	$"/root".call_deferred("add_child", options_node)
	options_node.call_deferred("load_configs")
