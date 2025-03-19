extends "res://ui/menus/shop/item_description.gd"


const QUIPPER_STAT_PREVIEW_TOOL_ALLOWED_SCENES:Array = ["Shop", "CoopShop", "Main", "EndRun", "CoopEndRun"]

onready var quipper_stat_preview_tool_current_scene = get_tree().get_current_scene()
var quipper_stat_preview_tool_vboxcontainer:VBoxContainer = null
var quipper_stat_preview_tool_vboxcontainer_2:VBoxContainer = null
var quipper_stat_preview_tool_is_debug:bool = false
var quipper_stat_preview_tool_debug_version:String = "1.0.36"

var quipper_stat_preview_tool_hide_all:bool
var quipper_stat_preview_tool_show_cap:bool
var quipper_stat_preview_tool_show_armor_detail:bool
var quipper_stat_preview_tool_show_hp_regeneration_detail:bool


func _ready():
	if not quipper_stat_preview_tool_current_scene.name in QUIPPER_STAT_PREVIEW_TOOL_ALLOWED_SCENES || quipper_stat_preview_tool_current_scene == null:
		return

	quipper_stat_preview_tool_vboxcontainer = get_node("VBoxContainer/QuipperStatPreviewToolVBoxContainer")
	quipper_stat_preview_tool_vboxcontainer_2 = get_node("ScrollContainer/VBoxContainer/QuipperStatPreviewToolVBoxContainer")

	_load_quipper_stat_preview_tool_mod_options()

func on_quipper_stat_preview_tool_setting_changed(mod_option:String, value) -> void:
	var QuipperStatPreviewToolEventListener = get_node_or_null("/root/ModLoader/Quipper-StatPreviewTool/Quipper-StatPreviewTool-EventListener")

	if QuipperStatPreviewToolEventListener == null or !is_instance_valid(QuipperStatPreviewToolEventListener):
		return
	
	if mod_option == QuipperStatPreviewToolEventListener.QUIPPER_STAT_PREVIEW_TOOL_HIDE_ALL:
		quipper_stat_preview_tool_hide_all = value
		_on_quipper_stat_preview_tool_hide_all_setting_changed(value)
	if mod_option == QuipperStatPreviewToolEventListener.QUIPPER_STAT_PREVIEW_TOOL_SHOW_CAP:
		quipper_stat_preview_tool_show_cap = value
	elif mod_option == QuipperStatPreviewToolEventListener.QUIPPER_STAT_PREVIEW_TOOL_SHOW_ARMOR_DETAIL:
		quipper_stat_preview_tool_show_armor_detail = value
	elif mod_option == QuipperStatPreviewToolEventListener.QUIPPER_STAT_PREVIEW_TOOL_SHOW_HP_REGENERATION_DETAIL:
		quipper_stat_preview_tool_show_hp_regeneration_detail = value


func quipper_stat_preview_tool_show_effects_richtextlabel_and_hide_mod_label() -> void:
	get_effects().visible = not get_effects().bbcode_text.empty()
	quipper_stat_preview_tool_vboxcontainer.visible = false
	quipper_stat_preview_tool_vboxcontainer_2.visible = false

func set_item(item_data:ItemParentData, player_index:int, item_count: = 1) -> void:
	.set_item(item_data, player_index, item_count)

	if quipper_stat_preview_tool_vboxcontainer == null or quipper_stat_preview_tool_vboxcontainer_2 == null:
		return

	_hide_quipper_stat_preview_tool_vboxcontainer(quipper_stat_preview_tool_vboxcontainer)
	_hide_quipper_stat_preview_tool_vboxcontainer(quipper_stat_preview_tool_vboxcontainer_2)

	if item_data is WeaponData or item_data is CharacterData or item_data is DifficultyData:
		return

	var quipper_stat_preview_tool_debug_text:String = ""

	if quipper_stat_preview_tool_is_debug:
		quipper_stat_preview_tool_debug_text = "Quipper-Test-" + quipper_stat_preview_tool_debug_version + "\n"

	_quipper_stat_preview_tool_hide_effects_richtextlabel()

	var real_item_count:int = 1
	for duplicate_item in RunData.get_player_effect("duplicate_item", player_index):
		if duplicate_item[0] == "item_mirror":
			real_item_count += duplicate_item[1]
	
	real_item_count = int(min(real_item_count, RunData.get_remaining_max_nb_item(item_data, player_index)))

	var quipper_stat_preview_tool_after_insert_text:String = _quipper_stat_preview_tool_insert_text(item_data.get_effects_text(player_index), item_data.effects, player_index, real_item_count)

	var quipper_stat_preview_tool_test_text:String = quipper_stat_preview_tool_debug_text + quipper_stat_preview_tool_after_insert_text
	_update_quipper_stat_preview_tool_vboxcontainer(quipper_stat_preview_tool_test_text)

	_on_quipper_stat_preview_tool_hide_all_setting_changed(quipper_stat_preview_tool_hide_all)

func _on_quipper_stat_preview_tool_hide_all_setting_changed(value:bool) -> void:
	if value:
		quipper_stat_preview_tool_show_effects_richtextlabel_and_hide_mod_label()
	else:
		quipper_stat_preview_tool_show_mod_label_and_hide_effects_richtextlabel()

func quipper_stat_preview_tool_show_mod_label_and_hide_effects_richtextlabel():
	_effects.visible = false
	_effects_scrolled.visible = false
	quipper_stat_preview_tool_vboxcontainer.visible = true
	quipper_stat_preview_tool_vboxcontainer_2.visible = true

func _load_quipper_stat_preview_tool_mod_options() -> void:
	var QuipperStatPreviewToolEventListener = get_node_or_null("/root/ModLoader/Quipper-StatPreviewTool/Quipper-StatPreviewTool-EventListener")

	if QuipperStatPreviewToolEventListener == null or !is_instance_valid(QuipperStatPreviewToolEventListener):
		return

	if !QuipperStatPreviewToolEventListener.quipper_stat_preview_tool_is_mod_options_loaded:
		return

	quipper_stat_preview_tool_hide_all = QuipperStatPreviewToolEventListener.get_quipper_stat_preview_tool_hide_all()
	quipper_stat_preview_tool_show_cap = QuipperStatPreviewToolEventListener.get_quipper_stat_preview_tool_show_cap()
	quipper_stat_preview_tool_show_armor_detail = QuipperStatPreviewToolEventListener.get_quipper_stat_preview_tool_show_armor_detail()
	quipper_stat_preview_tool_show_hp_regeneration_detail = QuipperStatPreviewToolEventListener.get_quipper_stat_preview_tool_show_hp_regeneration_detail()

	QuipperStatPreviewToolEventListener.connect("quipper_stat_preview_tool_setting_changed", self, "on_quipper_stat_preview_tool_setting_changed")

func _hide_quipper_stat_preview_tool_vboxcontainer(local_quipper_stat_preview_tool_vboxcontainer:VBoxContainer) -> void:
	if local_quipper_stat_preview_tool_vboxcontainer.visible:
		local_quipper_stat_preview_tool_vboxcontainer.visible = false

func _quipper_stat_preview_tool_hide_effects_richtextlabel() -> void:
	_effects.visible = false
	_effects_scrolled.visible = false

func _update_quipper_stat_preview_tool_vboxcontainer(preview_text:String) -> void:
	if quipper_stat_preview_tool_vboxcontainer != null:
		_show_quipper_stat_preview_tool_vboxcontainer(quipper_stat_preview_tool_vboxcontainer)
		quipper_stat_preview_tool_vboxcontainer.set_quipper_stat_preview_tool_text(preview_text)

	if quipper_stat_preview_tool_vboxcontainer_2 != null:
		_show_quipper_stat_preview_tool_vboxcontainer(quipper_stat_preview_tool_vboxcontainer_2)
		quipper_stat_preview_tool_vboxcontainer_2.set_quipper_stat_preview_tool_text(preview_text)

func _show_quipper_stat_preview_tool_vboxcontainer(local_quipper_stat_preview_tool_vboxcontainer:VBoxContainer) -> void:
	if !local_quipper_stat_preview_tool_vboxcontainer.visible:
		local_quipper_stat_preview_tool_vboxcontainer.visible = true

func _quipper_stat_preview_tool_insert_text(effects_text:String, item_effects:Array, player_index:int, item_count:int) -> String:
	var start_index:int = 0
	var regex:RegEx = RegEx.new()
	
	for item_effect in item_effects:
		if _quipper_stat_preview_tool_is_in_blacklist(item_effect.key, item_effect.custom_key):
			continue
		
		var text_func:FuncRef = _quipper_stat_preview_tool_get_funcref_for_effect(item_effect)

		if text_func == null:
			continue

		var preview_text:String = text_func.call_func(item_effect, player_index, item_count)

		var pattern:String = ""

		for c in item_effect.get_text(player_index):
			if c == "[" or c == "]" or c == "/" or c == "+" or c == "(" or c == ")":
				pattern += "\\"
			pattern += c
		regex.compile(pattern)

		var regex_match:RegExMatch = regex.search(effects_text, start_index)
		if !regex_match:
			continue
		
		var pos_to_insert = regex_match.get_end()
		
		effects_text = effects_text.insert(pos_to_insert, preview_text)
		start_index = pos_to_insert + preview_text.length()

	return effects_text

func _quipper_stat_preview_tool_is_in_blacklist(effect_key:String, custom_key:String) -> bool:
	var effect_key_banlist:Array = [
		"one_shot_trees",
		"hp_start_wave",
		"hp_start_next_wave",
		"extra_loot_aliens_next_wave",
		"gain_pct_gold_start_wave",
		"tree_turrets",
		"structures_can_crit",
		"torture",
		"item_mirror",
		"hp_regen_bonus",
		"gold_on_cursed_enemy_kill",
		"remove_speed"
	]

	var effect_custom_key_banlist:Array = [
		"structures_cooldown_reduction",
		"weapon_scaling_stats",
		"heal_on_dodge",
		"increase_tier_on_reroll",
		"gain_stats_on_reroll",
		"decaying_stats_on_hit",
		"upgrade_random_weapon"
	]

	return effect_key_banlist.has(effect_key) or effect_custom_key_banlist.has(custom_key) or _get_quipper_stat_preview_tool_is_in_effect_key_option_blacklist(effect_key)

func _get_quipper_stat_preview_tool_is_in_effect_key_option_blacklist(effect_key:String) -> bool:
	var QuipperStatPreviewToolEventListener = get_node_or_null("/root/ModLoader/Quipper-StatPreviewTool/Quipper-StatPreviewTool-EventListener")

	if QuipperStatPreviewToolEventListener == null or !is_instance_valid(QuipperStatPreviewToolEventListener):
		return false

	if !QuipperStatPreviewToolEventListener.quipper_stat_preview_tool_effect_key_blacklist_dict.has(effect_key):
		return false

	return !QuipperStatPreviewToolEventListener.quipper_stat_preview_tool_settings_dict[QuipperStatPreviewToolEventListener.quipper_stat_preview_tool_effect_key_blacklist_dict[effect_key]]

func _quipper_stat_preview_tool_get_funcref_for_effect(item_effect:Effect) -> FuncRef:#-> String:
	var item_effect_key:String = item_effect.key
	var item_effect_custom_key:String = item_effect.custom_key
	var item_effect_id:String = item_effect.get_id()
	var item_effect_storage_method:int = item_effect.storage_method

	if item_effect_id == "structure" or item_effect_id == "turret":
		return null
		# return funcref(self, "_quipper_stat_preview_tool_get_structure_or_turret_preview_text")
	elif item_effect_key.empty() and item_effect_custom_key.empty():
		return null
	# elif item_effect_id == "swap_max_min_stat":
	# 	return funcref(self, "_get_swap_max_min_stat_preview_text")
	elif item_effect_id == "chance_stat_damage":
		return null
		# return funcref(self, "_quipper_stat_preview_tool_get_chance_stat_damage_preview_text")
	elif item_effect_id == "gain_stat_for_every_stat":
		# return null
		return funcref(self, "_quipper_stat_preview_tool_get_gain_stat_for_every_stat_preview_text")
	elif item_effect_id == "projectile":
		# return null
		return funcref(self, "_quipper_stat_preview_tool_get_projectile_preview_text")
	elif item_effect_id == "item_exploding":
		# return null
		return funcref(self, "_quipper_stat_preview_tool_get_item_exploding_preview_text")
	elif item_effect_id == "double_value":
		# return null
		return funcref(self, "_quipper_stat_preview_tool_get_double_value_preview_text")
	elif item_effect_id == "effect":
		if item_effect_storage_method == 0:
			return funcref(self, "_quipper_stat_preview_tool_get_effect_preview_text_with_storage_method_0")
		elif item_effect_storage_method == 1:
			# return null
			return funcref(self, "_quipper_stat_preview_tool_get_effect_preview_text_with_storage_method_1")
		else:
			return null
	else:
		return null

#	SwapMaxMinStatEffect
func _quipper_stat_preview_tool_get_swap_max_min_stat_preview_text(item_effect:SwapMaxMinStatEffect, player_index:int, item_count:int) -> String:
	var min_and_max_stats:Array = item_effect._find_min_max_stat_keys(player_index)
	var before_add_value:float = min_and_max_stats[0]
	var after_add_value:float = min_and_max_stats[1]
	var _item_count = item_count
	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value)

#	StructureEffect	& TurretEffect	
func _quipper_stat_preview_tool_get_structure_or_turret_preview_text(item_effect:StructureEffect, player_index:int, item_count:int) -> String:
	var structures_effects:Array = RunData.get_player_effect("structures", player_index)
	var before_add_value:float = 0

	for structure in structures_effects:
		if structure.text_key == item_effect.text_key:
			before_add_value += 1

	var after_add_value:float = before_add_value + item_count
	
	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value)

#	DoubleValueEffect
#	目前本體和DLC的DoubleValueEffect只有storage_method是0且sum_strategy是1的effect，所以只有實作這個情況下的effect
func _quipper_stat_preview_tool_get_double_value_preview_text(item_effect:DoubleValueEffect, player_index:int, item_count:int) -> String:
	if item_effect.storage_method != 0:
		return ""
	
	if item_effect.sum_strategy != 1:
		return ""

	var player_effects = RunData.get_player_effects(player_index)
	var before_add_value:float = 0
	var after_add_value:float = 0
	
	for player_effect in player_effects[item_effect.key]:
		if player_effect[1] == item_effect.value2:
			before_add_value = player_effect[0]

	after_add_value = before_add_value + item_effect.value * item_count

	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value, item_effect.key)

#	ItemExplodingEffect
func _quipper_stat_preview_tool_get_item_exploding_preview_text(item_effect:ItemExplodingEffect, player_index:int, item_count:int) -> String:
	var player_item_count:int = RunData.get_player_effect(item_effect.key, player_index).size()
	var item_effect_args:Array = item_effect.get_args(player_index)
	var item_chance:int = int(item_effect_args[0])
	var item_dmg:int = int(item_effect_args[1])
	var before_add_chance:int = item_chance * player_item_count
	var before_add_value:int = item_dmg * player_item_count
	var after_add_chance:int = before_add_chance + item_chance * item_count
	var after_add_value:int = before_add_value + item_dmg * item_count

	return _quipper_stat_preview_tool_get_colored_text(before_add_chance, after_add_chance, "%") + " &" + _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value)
	
#	ProjectileEffect
func _quipper_stat_preview_tool_get_projectile_preview_text(item_effect:ProjectileEffect, player_index:int, item_count:int) -> String:
	var projectile_effects:Array = RunData.get_player_effect(item_effect.key, player_index)
	var before_add_value:float = 0

	for projectile_effect in projectile_effects:
		before_add_value += projectile_effect[0]
	
	var after_add_value:float = before_add_value + item_effect.value * item_count

	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value)

#	GainStatForEveryStatEffect
func _quipper_stat_preview_tool_get_gain_stat_for_every_stat_preview_text(item_effect:GainStatForEveryStatEffect, player_index:int, item_count:int) -> String:
	var do_not_display_effect_with_stat_scaled:Array = [
		"living_enemy",
		"burning_enemy"
	]
	if do_not_display_effect_with_stat_scaled.has(item_effect.stat_scaled):
		return ""
	var item_value:int = int(item_effect.get_args(player_index)[4])
	var before_add_value:float = Utils.get_stat(item_effect.key, player_index)
	var modified_coef:float = RunData.get_stat_gain(item_effect.key, player_index)
	var after_add_value:float = before_add_value + item_value * modified_coef * item_count

	before_add_value = _quipper_stat_preview_tool_get_stat_cap(item_effect.key, before_add_value, player_index)
	after_add_value = _quipper_stat_preview_tool_get_stat_cap(item_effect.key, after_add_value, player_index)

	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value, item_effect.key)

#	ChanceStatDamageEffect
func _quipper_stat_preview_tool_get_chance_stat_damage_preview_text(item_effect:ChanceStatDamageEffect, player_index:int, item_count:int) -> String:
	# var item_value:int = int(item_effect.get_args(player_index)[1])
	var custom_key_effects:Array = RunData.get_player_effect(item_effect.custom_key, player_index)
	var item_coef_value:float = 0
	var item_effect_key:float = Utils.get_stat(item_effect.key, player_index)
	# var player_item_count:int = 0

	for effect in custom_key_effects:
		if effect[0] == item_effect.key: #or effect[1] != item_effect.value or effect[2] != item_effect.chance:
			item_coef_value += effect[1]

	# var before_add_value:float = item_value * player_item_count
	var dmg_from_stat_before_add_value:int = (item_effect_key * item_coef_value  / 100) as int
	var before_add_value:float = WeaponService.apply_damage_bonus(dmg_from_stat_before_add_value, player_index) if dmg_from_stat_before_add_value > 0 else 0
	var dmg_from_stat_after_add_value:int = (item_effect_key * (item_coef_value + item_effect.value * item_count) / 100) as int
	var after_add_value:float = WeaponService.apply_damage_bonus(dmg_from_stat_after_add_value, player_index)

	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value)

#	Effect
#	storage_method = 1
#	有custom_key的Effect
func _quipper_stat_preview_tool_get_effect_preview_text_with_storage_method_1(item_effect:Effect, player_index:int, item_count:int) -> String:
	var before_add_value:float = 0
	var after_add_value:float = 0

	if item_effect.custom_key == "unique_weapon_effects":
		var unique_weapon_count:int = RunData.get_unique_weapon_ids(player_index).size()
		before_add_value = Utils.get_stat(item_effect.key, player_index)
		var modified_coef:float = RunData.get_stat_gain(item_effect.key, player_index)
		after_add_value = before_add_value + unique_weapon_count * modified_coef * item_effect.value * item_count
	else:
		var costom_key_effects:Array = RunData.get_player_effect(item_effect.custom_key, player_index)
		for effect in costom_key_effects:
			if effect[0] != item_effect.key:
				continue
			before_add_value = effect[1]
		after_add_value = before_add_value + item_effect.value * item_count

	before_add_value = _quipper_stat_preview_tool_get_stat_cap(item_effect.key, before_add_value, player_index)
	after_add_value = _quipper_stat_preview_tool_get_stat_cap(item_effect.key, after_add_value, player_index)
	
	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value, item_effect.key)

#	Effect
#	storage_method = 0
#	大部分的處理
func _quipper_stat_preview_tool_get_effect_preview_text_with_storage_method_0(item_effect:Effect, player_index:int, item_count:int) -> String:
	var before_add_value:float = Utils.get_stat(item_effect.key, player_index)
	var modified_coef:float = RunData.get_stat_gain(item_effect.key, player_index)
	var after_add_value:float = before_add_value + item_effect.value * modified_coef * item_count

	before_add_value = _quipper_stat_preview_tool_get_stat_cap(item_effect.key, before_add_value, player_index)
	after_add_value = _quipper_stat_preview_tool_get_stat_cap(item_effect.key, after_add_value, player_index)
	
	var detailed_stat:String = ""
	if item_effect.key == "stat_armor":
		detailed_stat = _quipper_stat_preview_tool_get_armor_to_damage_reduction_text(int(before_add_value), int(after_add_value))
	elif item_effect.key == "stat_hp_regeneration":
		detailed_stat = _quipper_stat_preview_tool_get_heal_per_second_text(int(before_add_value), int(after_add_value))

	return _quipper_stat_preview_tool_get_colored_text(before_add_value, after_add_value, item_effect.key) + detailed_stat

#	armor 減傷的資訊
func _quipper_stat_preview_tool_get_armor_to_damage_reduction_text(before_value:int, after_value:int) -> String:
	if !quipper_stat_preview_tool_show_armor_detail:
		return ""
	var before_taken_dmg:float = round((1.0 - RunData.get_armor_coef(before_value)) * 100.0)
	var after_taken_dmg:float = round((1.0 - RunData.get_armor_coef(after_value)) * 100.0)
	return _quipper_stat_preview_tool_get_colored_text(before_taken_dmg, after_taken_dmg, "%")

#	hp regeneration 每秒回復血量的資訊
func _quipper_stat_preview_tool_get_heal_per_second_text(before_value:int, after_value:int) -> String:
	if !quipper_stat_preview_tool_show_hp_regeneration_detail:
		return ""
	var before_hps:float = stepify(1.0 / RunData.get_hp_regeneration_timer(before_value), 0.01)
	var after_hps:float = stepify(1.0 / RunData.get_hp_regeneration_timer(after_value), 0.01)
	return _quipper_stat_preview_tool_get_colored_text(before_hps, after_hps, "/s")

func _quipper_stat_preview_tool_get_stat_cap(effect:String, value:float, player_index:int) -> float:
	if !quipper_stat_preview_tool_show_cap:
		return value
	
	var cap_name:String = ""

	match effect:
		"stat_max_hp":
			cap_name = "hp_cap"
		"stat_speed":
			cap_name = "speed_cap"
		"stat_dodge":
			cap_name = "dodge_cap"
		"stat_crit_chance":
			cap_name = "crit_chance_cap"
		_:
			return value
		
	var cap:float = RunData.get_player_effect(cap_name, player_index)
	return min(value, cap)

func _quipper_stat_preview_tool_get_colored_text(before_add_value:float, after_add_value:float, effect_key:String = "") -> String:
	var color:String = _quipper_stat_preview_tool_get_color(before_add_value, after_add_value, effect_key)
	var postfix:String = _quipper_stat_preview_tool_get_postfix(effect_key)
	var brfore_text:String = str(before_add_value) + postfix
	var after_text:String = str(after_add_value) + postfix

	return " ({0}{1}{2}{3}{4}{5}{6})".format([brfore_text, "[color=", color, "]", " -> " , after_text, "[/color]"])

#	獲取顏色
func _quipper_stat_preview_tool_get_color(before_add_value:float, after_add_value:float, effect_key:String) -> String:
	var reverse_effect_key:Array = [
		"items_price",
		"enemy_speed",
		"enemy_damage",
		"enemy_health",
		"lose_hp_per_second",
		"reroll_price",
		"loot_alien_speed"
	]

	var gray_effect_key:Array =[
		"number_of_enemies"
	]

	if gray_effect_key.has(effect_key) or before_add_value == after_add_value:
		return ""

	var is_pos_color:bool = (before_add_value > after_add_value and reverse_effect_key.has(effect_key)) or (before_add_value < after_add_value and !reverse_effect_key.has(effect_key))

	return Utils.POS_COLOR_STR if is_pos_color else Utils.NEG_COLOR_STR

#	獲取數值的後綴，像是%或是/s	
func _quipper_stat_preview_tool_get_postfix(effect_key:String) -> String:
	var percent_effect_key:Array = [
		"%",
		"stat_attack_speed",
		"stat_crit_chance",
		"stat_dodge",
		"stat_lifesteal",
		"stat_percent_damage",
		"stat_speed",
		"xp_gain",
		"number_of_enemies",
		"pickup_range",
		"piercing_damage",
		"bounce_damage",
		"items_price",
		"burning_cooldown_reduction",
		"explosion_size", 
		"explosion_damage",
		"instant_gold_attracting",
		"heal_when_pickup_gold",
		"recycling_gains",
		"chance_double_gold",
		"enemy_speed",
		"enemy_damage",
		"enemy_health",
		"damage_against_bosses",
		"heal_on_crit_kill",
		"structure_attack_speed",
		"harvesting_growth",
		"reroll_price",
		"loot_alien_chance",
		"loot_alien_speed",
		"enemy_gold_drops",
		"heal_on_kill",
		"level_upgrades_modifications",
		"accuracy",
		"curse_locked_items",
		"gold_on_crit_kill",
		"random",
		"item_pearl",
		"bonus_damage_against_targets_above_hp"
	]

	if percent_effect_key.has(effect_key):
		return "%"
	elif effect_key == "/s":
		return "/s"
	else:
		return ""
