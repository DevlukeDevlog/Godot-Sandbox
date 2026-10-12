class_name Run
extends State

const MOVE_SPEED := 300.0
const ACCELERATION := 40.0
const FRICTION := 40.0

var player: CharacterBody2D

func Enter() -> void:
	player = State_Machine.get_parent()

func Physics_Update(delta: float) -> void:
	_move(delta)
	player.move_and_slide()

func _get_direction() -> Vector2:
	var input_x := Input.get_axis("move_left", "move_right")
	var input_y := Input.get_axis("move_up", "move_down")
	
	return Vector2(input_x, input_y)

func _move(delta) -> void:
	var direction := _get_direction()
	if direction != Vector2.ZERO:
		player.velocity = lerp(player.velocity, direction * MOVE_SPEED, delta * ACCELERATION)
	else:
		player.velocity = lerp(player.velocity, Vector2.ZERO, delta * FRICTION)
		if player.velocity.length_squared() < 1.0: 
			player.velocity = Vector2.ZERO
			State_Machine.Change_State("Idle")
