extends Node

@export var initial_state: State
@onready var current_state: State = (func get_initial_state() -> State:
	return initial_state if initial_state != null else get_child(0)
).call()
var states: Dictionary = {}

func _ready() -> void:
	for state_node: State in find_children("*", "State"):
		states[state_node.name.to_lower()] = state_node
		state_node.transitioned.connect(on_state_node_transition)
	
	await owner.ready
	initial_state.enter()

func _process(delta: float) -> void:
	if current_state:
		current_state.update(delta)
		
func _physics_process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func on_state_node_transition(state, target_state):
	if state != current_state:
		return
	
	var next_state = states.get(target_state.to_lower())
	if !next_state:
		return
	
	if current_state:
		current_state.exit()
		
	next_state.enter()
	current_state = next_state
