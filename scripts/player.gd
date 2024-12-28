extends CharacterBody2D

@onready var animated_sprite: AnimatedSprite2D = $AnimatedSprite2D

const SPEED = 130.0
const JUMP_VELOCITY = -300.0

func _physics_process(delta: float) -> void:
	handle_gravity(delta)
	handle_jump()
	handle_movement()

func handle_gravity(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

func handle_jump() -> void:
	if Input.is_action_just_pressed("jump") and is_on_floor():
		animated_sprite.play("jump")
		velocity.y = JUMP_VELOCITY
		

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
		animated_sprite.flip_h = direction < 0
		animated_sprite.play("run")
	velocity.x = direction * SPEED
