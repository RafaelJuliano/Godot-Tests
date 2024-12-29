extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var death_sound: AudioStreamPlayer2D = $DeathSound
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var game_manager: Node = %GameManager

const SPEED = 130.0
const JUMP_VELOCITY = -300.0
const MAX_JUMPS = 2

var used_double_jump = false
var is_dead = false

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	if !is_dead:
		handle_jump()
		handle_movement()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_jump() -> void:
	reset_double_jump_when_hit_floor()
	if !Input.is_action_just_pressed("jump"):
		return
	
	if is_on_floor():
		jump_sound.play()
		velocity.y = JUMP_VELOCITY
		
	if !is_on_floor() and !used_double_jump:
		used_double_jump = true
		jump_sound.play()
		velocity.y = JUMP_VELOCITY
		
func reset_double_jump_when_hit_floor() -> void:
	if is_on_floor():
		used_double_jump = false

func handle_movement() -> void:
	var direction := Input.get_axis("move_left", "move_right")
		
	if direction:
		set_is_running(direction)
	else:
		set_is_idle()
		
	move_and_slide()

func set_is_idle() -> void:
	if is_on_floor():
		animated_sprite.play("idle")
	velocity.x = move_toward(velocity.x, 0, SPEED)

func set_is_running(direction: float) -> void:
	if is_on_floor():
		animated_sprite.play("run")
	animated_sprite.flip_h = direction < 0
	velocity.x = direction * SPEED

func kill() -> void:
	is_dead = true
	death_sound.play()
	animated_sprite.play("dead")


func _on_tree_entered() -> void:
	pass
