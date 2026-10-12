# State Machine System

## Setup & Installation

### 1. Scene Structure
1. Create a `CharacterBody2D` node for your player.
2. Add a child node extending `StateMachine.gd` to the player.
3. Add individual state nodes (e.g., `Idle`, `Run`) as children under the `StateMachine` node. Each child node must have its own custom script extending `State.gd`.

## StateMachine

### Inspector Settings
- **`Initial State`** (`Node` / `State`): The starting state node that the machine automatically transitions to upon entering the scene tree.

### API Reference

#### `Change_State(new_state: String)`
Exits the active state, looks up the target state by its node name (case-insensitive), and invokes its entry logic.
- **`new_state`** (`String`): The name of the destination state node (e.g., `"Idle"` or `"Run"`).

#### `Get_State() -> String`
Returns the name of the currently active state.

## State (Base Class)

Every custom state script must extend `State` and can override the following built-in virtual methods:

- **`Enter() -> void`**: Called automatically when the state machine switches into this state.
- **`Update(delta: float) -> void`**: Called every frame (`_process`) while this state is active.
- **`Physics_Update(delta: float) -> void`**: Called every physics frame (`_physics_process`) while this state is active.
- **`Handled_Input(event: InputEvent) -> void`**: Called when input events are processed while this state is active.
- **`Exit() -> void`**: Called automatically right before the state machine switches away from this state.

## Code Examples

### Setting up a State Script (`Idle.gd`)
```gdscript
class_name Idle
extends State

func Physics_Update(delta: float) -> void:
	# Transition to Run state if player provides movement input
	var input_x := Input.get_axis("move_left", "move_right")
	var input_y := Input.get_axis("move_up", "move_down")
	
	if input_x != 0.0 or input_y != 0.0:
		State_Machine.Change_State("Run")
```
