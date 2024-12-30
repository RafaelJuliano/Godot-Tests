extends PlayerState
class_name PlayerIdle

func enter() -> void:
	player.animated_sprite.play("idle")
	
func physics_update(delta: float) -> void:
	process_physisc(delta)
	change_state()
	
func process_physisc(delta: float) -> void:
	player.velocity.x = move_toward(player.velocity.x, 0, player.SPEED)
	player.move_and_slide()

func change_state() -> void:
	if not player.is_on_floor():
		transitioned.emit(self, FALLING)
	elif player.jumping_input:
		transitioned.emit(self, JUMPING)
	elif player.moving_x_input:
		transitioned.emit(self, RUNNING)
