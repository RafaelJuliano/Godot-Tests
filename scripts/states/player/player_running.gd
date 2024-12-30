extends PlayerState
class_name PlayerRunning

func enter() -> void:
	player.animated_sprite.play("run")
	
func physics_update(delta: float) -> void:
	process_physisc(delta)
	change_state()
	
func process_physisc(delta: float) -> void:
	player.velocity.x = player.moving_x_input * player.SPEED
	player.move_and_slide()

func change_state() -> void:
	if not player.is_on_floor():
		transitioned.emit(self, FALLING)
	elif player.jumping_input:
		transitioned.emit(self, JUMPING)
	elif is_equal_approx(player.moving_x_input, 0.0):
		transitioned.emit(self, IDLE)
