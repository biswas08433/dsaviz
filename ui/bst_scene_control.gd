extends CanvasLayer

signal submitted(value: int, op: String)
signal view_reset
signal tree_reset

@onready var line_edit = $Control/InputMarginContainer/HBoxContainer/LineEdit
@onready var option_button = $Control/InputMarginContainer/HBoxContainer/OptionButton


func _on_submit_button_pressed():
	submitted.emit(line_edit.text, option_button.text)


func _on_tree_reset_button_pressed():
	tree_reset.emit()


func _on_view_reset_button_pressed():
	view_reset.emit()
