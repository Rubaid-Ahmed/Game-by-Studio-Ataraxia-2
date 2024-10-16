extends Node2D
class_name Main_Scene

@onready var main_camera: Camera2D = $MainCamera
var selected_character: CharacterBody2D = null
var dead_characters: Array = []

func _ready():
	set_process_input(true)
	if main_camera == null:
		print("Error: MainCamera is not found.")
	else:
		print("MainCamera is set correctly.")
	
	# Connect to the sword's signal
	var sword = get_node("Sword")  # Adjust the path if necessary
	if sword:
		sword.connect("character_killed", Callable(self, "_on_character_killed"))

func _unhandled_input(event):
	if event.is_action_pressed("open_inventory") and selected_character:
		if selected_character.has_method("toggle_inventory"):
			selected_character.toggle_inventory()

func select_character(character: CharacterBody2D):
	if character.name in dead_characters:
		print("Cannot select dead character:", character.name)
		return

	if main_camera and main_camera.is_current(): 
		print("Deactivating main camera.")
		main_camera.current = false
	
	if selected_character != null:
		selected_character.deactivate_camera()
		selected_character.is_selected = false
	
	selected_character = character
	selected_character.activate_camera()
	selected_character.is_selected = true
	print("Selected character:", selected_character.name)

func deselect_character():
	if selected_character:
		selected_character.deactivate_camera()
		selected_character.is_selected = false
		selected_character = null
	
	if main_camera:
		main_camera.current = true
		print("Reactivating main camera.")

func _on_character_killed(character_name: String):
	if character_name not in dead_characters:
		dead_characters.append(character_name)
		print("Updated dead characters list:", dead_characters)
		if selected_character and selected_character.name == character_name:
			deselect_character()

func is_character_dead(character_name: String) -> bool:
	return character_name in dead_characters
