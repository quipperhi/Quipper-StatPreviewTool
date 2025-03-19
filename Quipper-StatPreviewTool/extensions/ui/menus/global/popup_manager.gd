extends "res://ui/menus/global/popup_manager.gd"

func quipper_stat_preview_tool_hide_mod_of_inventory(player_index:int):
    _item_popups[player_index]._panel._item_description.quipper_stat_preview_tool_show_effects_richtextlabel_and_hide_mod_label()

func _on_element_hovered(element:InventoryElement) -> void:
    ._on_element_hovered(element)
    var player_index = _get_player_index_for_control(element)
    if _item_popups[player_index]:
        quipper_stat_preview_tool_hide_mod_of_inventory(player_index)

func _on_element_focused(element:InventoryElement) -> void:
    ._on_element_focused(element)
    var player_index = _get_player_index_for_control(element)
    if _item_popups[player_index]:
        quipper_stat_preview_tool_hide_mod_of_inventory(player_index)