extends Node
class_name PlayerManager

var player_count: int = 2


func add_player(player_id: int, gethitbox: Area3D, attackbox: Area3D) -> void:
	"""
	Initializes collision layers for both hurtbox and hitbox.
	Should be called on _ready in Player scripts.
	gethitbox = the area that gets hit
	attackbox = the area that hits others
	"""
	
	player_count = max(player_count, player_id + 1)
	
	gethitbox.collision_layer |= (1 << player_id) << 2
	var hitmask := 0
	for i in player_count:
		if i == player_id: continue
		hitmask |= (1 << i)
	
	attackbox.collision_mask |= hitmask << 2


func decode_player_mask(pmask: int) -> Array[int]:
	var players: Array[int] = []
	for i in player_count:
		if pmask & (1 << i):
			players.append(i)
	return players


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
