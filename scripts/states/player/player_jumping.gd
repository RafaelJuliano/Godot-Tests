extends PlayerState
class_name PlayerJumping

func enter() -> void:
	player.jump_sound.play()
	player.animated_sprite.play("jump")
	
func physics_update(delta: float) -> void:
	process_physisc(delta)
	change_state()
	
func process_physisc(delta: float) -> void:
	player.apply_gravity(delta)
	player.velocity.x = player.moving_x_input * player.SPEED
	if player.is_on_floor():
		player.velocity.y = player.JUMP_VELOCITY
	player.move_and_slide()

func change_state() -> void:
	transitioned.emit(self, FALLING)
