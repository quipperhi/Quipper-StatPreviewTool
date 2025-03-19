extends VBoxContainer

onready var quipper_stat_preview_tool_richtextlabel = $QuipperStatPreviewToolRichTextLabel

func set_quipper_stat_preview_tool_text(preview_text:String) -> void:
	quipper_stat_preview_tool_richtextlabel.bbcode_text = preview_text
