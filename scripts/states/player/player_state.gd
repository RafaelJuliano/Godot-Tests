extends State
class_name PlayerState

const IDLE = "PlayerIdle"
const RUNNING = "PlayerRunning"
const JUMPING = "PLayerJumping"
const FALLING = "PlayerFalling"

var player: Player

func _ready() -> void:
	await owner.ready
	player = owner as Player
	assert(player != null, "The PlayerState state type must be used only in the player scene. It needs the owner to be a Player node.")
