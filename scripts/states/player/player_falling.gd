extends PlayerState
class_name PlayerFalling

func enter() -> void:
	player.animated_sprite.play("jump")
	
func physics_update(delta: float) -> void:
	process_physisc(delta)
	change_state()
	
func process_physisc(delta: float) -> void:
	player.apply_gravity(delta)
	player.velocity.x = player.moving_x_input * player.SPEED
	player.move_and_slide()

func change_state() -> void:
	if player.is_on_floor():
		if is_equal_approx(player.moving_x_input, 0.0):
			transitioned.emit(self, IDLE)
		else:
			transitioned.emit(self, RUNNING)
