class_name Idle
extends State

var player: CharacterBody2D

func Enter() -> void:
	player = State_Machine.get_parent()

func Handled_Input(_event: InputEvent) -> void:
	if _is_moving(): State_Machine.Change_State("Run")

func _is_moving() -> bool:
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	return input_dir != Vector2.ZERO
