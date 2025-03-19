extends Node

const QUIPPER_STAT_PREVIEW_TOOL_DIR:String = "Quipper-StatPreviewTool/"
const QUIPPER_STAT_PREVIEW_TOOL_LOG:String = "Quipper-StatPreviewTool"
const QUIPPER_STAT_PREVIEW_TOOL_EVENT_LISTENER_NAME:String = "Quipper-StatPreviewTool-EventListener"

var quipper_stat_preview_tool_dir:String = ""
var quipper_stat_preview_tool_extensions_dir:String = ""
var quipper_stat_preview_tool_translations_dir:String = ""
var quipper_stat_preview_tool_supported_languages: Array = ["en", "zh_Hans_CN", "zh_Hant_TW"]

func _init():
	ModLoaderLog.info("Init!", QUIPPER_STAT_PREVIEW_TOOL_LOG)
	quipper_stat_preview_tool_dir = ModLoaderMod.get_unpacked_dir().plus_file(QUIPPER_STAT_PREVIEW_TOOL_DIR)
	quipper_stat_preview_tool_extensions_dir = quipper_stat_preview_tool_dir.plus_file("extensions")
	quipper_stat_preview_tool_translations_dir = quipper_stat_preview_tool_dir.plus_file("translations")
	
	# _quipper_stat_preview_tool_install_script_extensions()
	# _quipper_stat_preview_tool_add_translations()

func _enter_tree():
	ModLoaderLog.info("Entered Tree!", QUIPPER_STAT_PREVIEW_TOOL_LOG)
	# _quipper_stat_preview_tool_append_nodes()

func _ready():
	ModLoaderLog.info("Ready!", QUIPPER_STAT_PREVIEW_TOOL_LOG)
	# _quipper_stat_preview_tool_add_event_listener()

func _quipper_stat_preview_tool_append_nodes() -> void:
	_quipper_stat_preview_tool_modify_item_description_node("VBoxContainer")
	_quipper_stat_preview_tool_modify_item_description_node("ScrollContainer/VBoxContainer")

func _quipper_stat_preview_tool_modify_item_description_node(quipper_stat_preview_tool_child_node_name:String) -> void:
	ModLoaderLog.info("------------------APPENDING NODES------------------", QUIPPER_STAT_PREVIEW_TOOL_LOG)
	var quipper_stat_preview_tool:String = "QuipperStatPreviewToolVBoxContainer"
	var quipper_stat_preview_tool_scene:String = quipper_stat_preview_tool_extensions_dir.plus_file("ui/menus/shop/quipper_stat_preview_tool.tscn")

	var quipper_stat_preview_tool_item_description_res:String = "res://ui/menus/shop/item_description.tscn"
	var quipper_stat_preview_tool_item_description_instance = load(quipper_stat_preview_tool_item_description_res).instance()

	ModLoaderLog.info("ITEM_DESCRIPTION INSTANCE: " + str(quipper_stat_preview_tool_item_description_instance.name), QUIPPER_STAT_PREVIEW_TOOL_LOG)
	ModLoaderMod.append_node_in_scene(quipper_stat_preview_tool_item_description_instance, quipper_stat_preview_tool, quipper_stat_preview_tool_child_node_name, quipper_stat_preview_tool_scene)
	ModLoaderMod.save_scene(quipper_stat_preview_tool_item_description_instance, quipper_stat_preview_tool_item_description_res)

func _quipper_stat_preview_tool_add_event_listener() -> void:
	var quipper_stat_preview_tool_event_listener_dir:String = quipper_stat_preview_tool_dir.plus_file("quipper_stat_preview_tool_event_listener.gd")
	var quipper_stat_preview_tool_event_listener = load(quipper_stat_preview_tool_event_listener_dir).new()
	quipper_stat_preview_tool_event_listener.name = QUIPPER_STAT_PREVIEW_TOOL_EVENT_LISTENER_NAME
	add_child(quipper_stat_preview_tool_event_listener)

func _quipper_stat_preview_tool_install_script_extensions() -> void:
	var quipper_stat_preview_tool_extensions:Array = [
		"ui/menus/shop/item_description.gd",
		"ui/menus/global/popup_manager.gd",
		"ui/menus/pages/menu_choose_options.gd"
	]

	for quipper_stat_preview_tool_extension in quipper_stat_preview_tool_extensions:
		ModLoaderMod.install_script_extension(quipper_stat_preview_tool_extensions_dir.plus_file(quipper_stat_preview_tool_extension))

func _quipper_stat_preview_tool_add_translations() -> void:
	for language in quipper_stat_preview_tool_supported_languages:
		ModLoaderMod.add_translation(quipper_stat_preview_tool_translations_dir.plus_file("Quipper-StatPreviewTool.%s.translation" % language))