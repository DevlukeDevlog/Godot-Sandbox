class_name StateMachine
extends Node

@export var initial_state: State
var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.State_Machine = self
	
	if initial_state:
		await get_tree().process_frame
		Change_State(initial_state.name.to_lower())

func _process(delta: float) -> void:
	if current_state:
		current_state.Update(delta)

func _physics_process(delta: float) -> void:
	if current_state:
		current_state.Physics_Update(delta)

func _input(event: InputEvent) -> void:
	if current_state:
		current_state.Handled_Input(event)

func Change_State(new_state: String) -> void:
	if current_state:
		current_state.Exit()
	
	current_state = states.get(new_state.to_lower())
	print("Switched to: ", current_state.name, " state")
	
	if current_state:
		current_state.Enter()

func Get_State() -> String:
	return current_state.name
