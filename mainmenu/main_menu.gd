class_name MainMenu
extends Control


@onready var play: Button = $MarginContainer/HBoxContainer/VBoxContainer/Play
@onready var option: Button = $MarginContainer/HBoxContainer/VBoxContainer/Option
@onready var exit: Button = $MarginContainer/HBoxContainer/VBoxContainer/Exit

@export var start_level = preload("res://Main Scene/main_scene.tscn") as PackedScene

func _ready() -> void:
	handle_signals()
	
func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)
	
func on_option_pressed() -> void:
	pass
	
func on_exit_pressed() -> void:
	get_tree().quit()

func handle_signals() -> void :
	play.button_down.connect(on_start_pressed)
	option.button_down.connect(on_option_pressed)
	exit.button_down.connect(on_exit_pressed)
	
