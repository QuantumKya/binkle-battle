extends Area3D

@export var player_manager: Node
@export var player_id: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	player_manager.add_player(player_id, self, $"../DummyAttack")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
