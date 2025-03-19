class_name QuipperStatPreviewToolEventListener
extends Node

signal quipper_stat_preview_tool_setting_changed(mod_option, value)

const QUIPPER_STAT_PREVIEW_TOOL_MODOPTIONS_MOD:String = "dami-ModOptions"
const QUIPPER_STAT_PREVIEW_TOOL_CONFIG_NAME:String = "stat_preview_tool_config"
const QUIPPER_STAT_PREVIEW_TOOL_CONFIG_FOLDER_NAME:String = "spt_config"
const QUIPPER_STAT_PREVIEW_TOOL_LOG:String = "Quipper-StatPreviewTool"

const QUIPPER_STAT_PREVIEW_TOOL_SHOW_OPTIONS:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_OPTIONS"
const QUIPPER_STAT_PREVIEW_TOOL_HIDE_ALL:String = "QUIPPER_STAT_PREVIEW_TOOL_HIDE_ALL"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_CAP:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_CAP"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR_DETAIL:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR_DETAIL"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_HP_REGENERATION_DETAIL:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_HP_REGENERATION_DETAIL"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_ADVANCED_OPTIONS:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_ADVANCED_OPTIONS"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_ATTACK_SPEED:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_ATTACK_SPEED"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_CRIT_CHANCE:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_CRIT_CHANCE"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_DODGE:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_DODGE"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_ELEMENTAL_DAMAGE:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_ELEMENTAL_DAMAGE"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_ENGINEERING:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_ENGINEERING"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_HARVESTING:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_HARVESTING"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH_REGENERATION:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH_REGENERATION"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_LIFESTEAL:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_LIFESTEAL"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_LUCK:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_LUCK"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_MELEE_DAMAGE:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_MELEE_DAMAGE"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_PERCENT_DAMAGE:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_PERCENT_DAMAGE"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGE:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGE"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGED_DAMAGE:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGED_DAMAGE"
const QUIPPER_STAT_PREVIEW_TOOL_SHOW_SPEED:String = "QUIPPER_STAT_PREVIEW_TOOL_SHOW_SPEED"

const QUIPPER_STAT_PREVIEW_TOOL_DEFAULT_SETTINGS:Dictionary = {
	QUIPPER_STAT_PREVIEW_TOOL_SHOW_OPTIONS:true,
    QUIPPER_STAT_PREVIEW_TOOL_HIDE_ALL:false,
	QUIPPER_STAT_PREVIEW_TOOL_SHOW_CAP:true,
	QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR_DETAIL:true,
	QUIPPER_STAT_PREVIEW_TOOL_SHOW_HP_REGENERATION_DETAIL:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_ADVANCED_OPTIONS:false,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_ATTACK_SPEED:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_CRIT_CHANCE:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_DODGE:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_ELEMENTAL_DAMAGE:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_ENGINEERING:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_HARVESTING:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH_REGENERATION:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_LIFESTEAL:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_LUCK:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_MELEE_DAMAGE:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_PERCENT_DAMAGE:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGE:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGED_DAMAGE:true,
    QUIPPER_STAT_PREVIEW_TOOL_SHOW_SPEED:true,
}

var quipper_stat_preview_tool_effect_key_blacklist_dict:Dictionary = {
    "stat_armor":QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR,
    "stat_attack_speed":QUIPPER_STAT_PREVIEW_TOOL_SHOW_ATTACK_SPEED,
    "stat_crit_chance":QUIPPER_STAT_PREVIEW_TOOL_SHOW_CRIT_CHANCE,
    "stat_dodge":QUIPPER_STAT_PREVIEW_TOOL_SHOW_DODGE,
    "stat_elemental_damage":QUIPPER_STAT_PREVIEW_TOOL_SHOW_ELEMENTAL_DAMAGE,
    "stat_engineering":QUIPPER_STAT_PREVIEW_TOOL_SHOW_ENGINEERING,
    "stat_harvesting":QUIPPER_STAT_PREVIEW_TOOL_SHOW_HARVESTING,
    "stat_max_hp":QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH,
    "stat_hp_regeneration":QUIPPER_STAT_PREVIEW_TOOL_SHOW_HEALTH_REGENERATION,
    "stat_lifesteal":QUIPPER_STAT_PREVIEW_TOOL_SHOW_LIFESTEAL,
    "stat_luck":QUIPPER_STAT_PREVIEW_TOOL_SHOW_LUCK,
    "stat_melee_damage":QUIPPER_STAT_PREVIEW_TOOL_SHOW_MELEE_DAMAGE,
    "stat_percent_damage":QUIPPER_STAT_PREVIEW_TOOL_SHOW_PERCENT_DAMAGE,
    "stat_range":QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGE,
    "stat_ranged_damage":QUIPPER_STAT_PREVIEW_TOOL_SHOW_RANGED_DAMAGE,
    "stat_speed":QUIPPER_STAT_PREVIEW_TOOL_SHOW_SPEED,
}

var quipper_stat_preview_tool_save_path:String = ""
var quipper_stat_preview_tool_settings_dict:Dictionary = QUIPPER_STAT_PREVIEW_TOOL_DEFAULT_SETTINGS.duplicate()
var quipper_stat_preview_tool_is_mod_options_loaded:bool = false
var quipper_stat_preview_tool_setting_container:VBoxContainer = null

func _ready():
	call_deferred("_load_quipper_stat_preview_tool_settings")
	call_deferred("_save_quipper_stat_preview_tool_settings")

func get_quipper_stat_preview_tool_hide_all() -> bool:
    return quipper_stat_preview_tool_settings_dict[QUIPPER_STAT_PREVIEW_TOOL_HIDE_ALL]

func get_quipper_stat_preview_tool_show_cap() -> bool:
    return quipper_stat_preview_tool_settings_dict[QUIPPER_STAT_PREVIEW_TOOL_SHOW_CAP]

func get_quipper_stat_preview_tool_show_armor_detail() -> bool:
    return quipper_stat_preview_tool_settings_dict[QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR_DETAIL]

func get_quipper_stat_preview_tool_show_hp_regeneration_detail() -> bool:
    return quipper_stat_preview_tool_settings_dict[QUIPPER_STAT_PREVIEW_TOOL_SHOW_HP_REGENERATION_DETAIL]


func quipper_stat_preview_tool_on_setting_changed(setting_name:String, value:bool, mod_name:String) -> void:
    if mod_name != QUIPPER_STAT_PREVIEW_TOOL_LOG:
        return

    quipper_stat_preview_tool_settings_dict[setting_name] = value

    match setting_name:
        QUIPPER_STAT_PREVIEW_TOOL_SHOW_OPTIONS:
            _quipper_stat_preview_tool_options_set_collapse_setting(value)
        QUIPPER_STAT_PREVIEW_TOOL_HIDE_ALL:
            emit_signal("quipper_stat_preview_tool_setting_changed", QUIPPER_STAT_PREVIEW_TOOL_HIDE_ALL, value)
        QUIPPER_STAT_PREVIEW_TOOL_SHOW_CAP:
            emit_signal("quipper_stat_preview_tool_setting_changed", QUIPPER_STAT_PREVIEW_TOOL_SHOW_CAP, value)
        QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR_DETAIL:
            emit_signal("quipper_stat_preview_tool_setting_changed", QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR_DETAIL, value)
        QUIPPER_STAT_PREVIEW_TOOL_SHOW_HP_REGENERATION_DETAIL:
            emit_signal("quipper_stat_preview_tool_setting_changed", QUIPPER_STAT_PREVIEW_TOOL_SHOW_HP_REGENERATION_DETAIL, value)
        QUIPPER_STAT_PREVIEW_TOOL_SHOW_ADVANCED_OPTIONS:
            _quipper_stat_preview_tool_advanced_options_set_collapse_setting(value)

    _save_quipper_stat_preview_tool_settings()

func _save_quipper_stat_preview_tool_settings() -> void:
	if quipper_stat_preview_tool_save_path.empty():
		return

	var file_dir:String = quipper_stat_preview_tool_save_path.get_base_dir()
	var dir:Directory = Directory.new()

	if !dir.dir_exists(file_dir):
		var make_dir:int = dir.make_dir_recursive(file_dir)
		if make_dir != OK:
			ModLoaderLog.info("Encountered an error (%s) when attempting to create a directory, with the path: %s" % [make_dir, file_dir], QUIPPER_STAT_PREVIEW_TOOL_LOG)
			return

	var file:File = File.new()
	var file_open:int = file.open(quipper_stat_preview_tool_save_path, File.WRITE)

	if file_open != OK:
		ModLoaderLog.info("Encountered an error (%s) when attempting to write to a file, with the path: %s" % [file_open, quipper_stat_preview_tool_save_path], QUIPPER_STAT_PREVIEW_TOOL_LOG)
		return
	
	var content:String = to_json(quipper_stat_preview_tool_settings_dict)
	file.store_string(content)
	file.flush()
	file.close()

func _load_quipper_stat_preview_tool_settings() -> void:
    quipper_stat_preview_tool_is_mod_options_loaded = ModLoaderMod.is_mod_loaded(QUIPPER_STAT_PREVIEW_TOOL_MODOPTIONS_MOD)
    var ModsConfigInterface = get_node_or_null("/root/ModLoader/dami-ModOptions/ModsConfigInterface")
	
    if ModsConfigInterface == null or !is_instance_valid(ModsConfigInterface):
        return
	
    _get_quipper_stat_preview_tool_save_path()

    if _has_quipper_stat_preview_tool_config_file():
        var load_settings_dict:Dictionary = _load_quipper_stat_preview_tool_dict_from_json_file()
        _load_quipper_stat_preview_tool_file_settings(load_settings_dict)

    for key in quipper_stat_preview_tool_settings_dict.keys():
        ModsConfigInterface.on_setting_changed(key, quipper_stat_preview_tool_settings_dict[key], QUIPPER_STAT_PREVIEW_TOOL_LOG)

    ModsConfigInterface.connect("setting_changed", self, "quipper_stat_preview_tool_on_setting_changed")

    _quipper_stat_preview_tool_add_signal_to_menu_choose_options()

func _get_quipper_stat_preview_tool_save_path() -> void:
    var base_dir:String = ProgressData.SAVE_PATH.get_base_dir()
    var config_dir:String = base_dir.plus_file(QUIPPER_STAT_PREVIEW_TOOL_CONFIG_FOLDER_NAME)
    quipper_stat_preview_tool_save_path = config_dir.plus_file(QUIPPER_STAT_PREVIEW_TOOL_CONFIG_NAME + ".json")

func _has_quipper_stat_preview_tool_config_file() -> bool:
	var file:File = File.new()
	return file.file_exists(quipper_stat_preview_tool_save_path)

func _load_quipper_stat_preview_tool_dict_from_json_file() -> Dictionary:
	var file:File = File.new()
	var err:int = file.open(quipper_stat_preview_tool_save_path, file.READ)

	if err != OK:
		ModLoaderLog.error("Fail to open file. Code: %s" % err, QUIPPER_STAT_PREVIEW_TOOL_LOG)
		return {}
	
	var content:String = file.get_as_text()
	file.close()

	var result:JSONParseResult = JSON.parse(content)
	if result.error != OK:
		ModLoaderLog.error("Fail to parse json file. Code: %s, Json: %s" % [result.error, content], QUIPPER_STAT_PREVIEW_TOOL_LOG)
		return{}
	
	return result.result

func _load_quipper_stat_preview_tool_file_settings(load_settings_dict:Dictionary) -> void:
	for key in quipper_stat_preview_tool_settings_dict.keys():
		if !load_settings_dict.has(key):
			continue
		quipper_stat_preview_tool_settings_dict[key] = load_settings_dict[key]

func _quipper_stat_preview_tool_add_signal_to_menu_choose_options() -> void:
	var ModsConfigInterface = get_node_or_null("/root/ModLoader/dami-ModOptions/ModsConfigInterface")
	if ModsConfigInterface == null or !is_instance_valid(ModsConfigInterface):
		return
	if !ModsConfigInterface.has_user_signal("quipper_stat_preview_tool_container_ready"):
		ModsConfigInterface.add_user_signal("quipper_stat_preview_tool_container_ready")
		ModsConfigInterface.connect("quipper_stat_preview_tool_container_ready", self, "_on_quipper_stat_preview_tool_container_ready")

func _on_quipper_stat_preview_tool_container_ready(menu_choose_options_node:Node) -> void:
	call_deferred("_get_quipper_stat_preview_tool_setting_container", menu_choose_options_node)

func _get_quipper_stat_preview_tool_setting_container(menu_choose_options_node:Node) -> void:
    if menu_choose_options_node == null or !is_instance_valid(menu_choose_options_node):
        return

    var menu_mods_options_path:String = str(menu_choose_options_node.get_path()).replace("/MenuChooseOptions", "/MenuModsOptions")
    var menu_mods_options_node:Node = get_node_or_null(menu_mods_options_path)

    if menu_mods_options_node == null or !is_instance_valid(menu_mods_options_node):
        return

    var mod_list_vbox:VBoxContainer = menu_mods_options_node.get("mod_list_vbox")
    var mod_setting_lists:Array = mod_list_vbox.get_children()

    for mod_setting_list in mod_setting_lists:
        var mod_label:Label = mod_setting_list.get_child(0)
        var text:String = mod_label.text
        if text == QUIPPER_STAT_PREVIEW_TOOL_LOG:
            quipper_stat_preview_tool_setting_container = mod_setting_list.get_child(1)
            break

    _quipper_stat_preview_tool_options_set_collapse_setting(quipper_stat_preview_tool_settings_dict[QUIPPER_STAT_PREVIEW_TOOL_SHOW_OPTIONS])
    _quipper_stat_preview_tool_advanced_options_set_collapse_setting(quipper_stat_preview_tool_settings_dict[QUIPPER_STAT_PREVIEW_TOOL_SHOW_ADVANCED_OPTIONS])

func _quipper_stat_preview_tool_options_set_collapse_setting(value:bool) -> void:
    if quipper_stat_preview_tool_setting_container == null or !is_instance_valid(quipper_stat_preview_tool_setting_container):
        return
    var quipper_stat_preview_tool_options:Array = quipper_stat_preview_tool_setting_container.get_children()
    quipper_stat_preview_tool_options.remove(0)

    if value:
        for quipper_stat_preview_tool_option in quipper_stat_preview_tool_options:
            quipper_stat_preview_tool_option.visible = true
        _quipper_stat_preview_tool_advanced_options_set_collapse_setting(quipper_stat_preview_tool_settings_dict[QUIPPER_STAT_PREVIEW_TOOL_SHOW_ADVANCED_OPTIONS])
    else:
        for quipper_stat_preview_tool_option in quipper_stat_preview_tool_options:
            quipper_stat_preview_tool_option.visible = false

func _quipper_stat_preview_tool_advanced_options_set_collapse_setting(value:bool) -> void:
    if quipper_stat_preview_tool_setting_container == null or !is_instance_valid(quipper_stat_preview_tool_setting_container):
        return
    var quipper_stat_preview_tool_advanced_options:Array = quipper_stat_preview_tool_setting_container.get_children()

    for _i in range(0, 6):
        quipper_stat_preview_tool_advanced_options.remove(0)

    if value:
        for quipper_stat_preview_tool_advanced_option in quipper_stat_preview_tool_advanced_options:
            quipper_stat_preview_tool_advanced_option.visible = true
    else:
        for quipper_stat_preview_tool_advanced_option in quipper_stat_preview_tool_advanced_options:
            quipper_stat_preview_tool_advanced_option.visible = false