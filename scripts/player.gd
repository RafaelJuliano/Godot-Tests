extends CharacterBody2D
class_name Player

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $Sounds/JumpSound
@onready var death_sound: AudioStreamPlayer2D = $Sounds/DeathSoundDeathSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_manager: Node = %GameManager

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2

var moving_x_input = 0.00
var jumping_input = false

func _process(delta: float) -> void:
	listen_inputs()
	handle_sprite_direction()

func listen_inputs() -> void:
	moving_x_input = Input.get_axis("move_left", "move_right")
	jumping_input = Input.is_action_just_pressed("jump")

func handle_sprite_direction() -> void:
	if (moving_x_input):
		animated_sprite.flip_h = moving_x_input < 0

func apply_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func kill():
	pass
