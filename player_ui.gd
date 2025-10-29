extends Control

const player_ui_block: PackedScene = preload("res://player_ui_block.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func add_player(player_id: int) -> void:
	var pui: Control = player_ui_block.instantiate()
	pui.name = "Player " + str(player_id + 1)
	pui.player_number = player_id + 1
	$HBoxContainer.add_child(pui);
	for ch in $HBoxContainer.get_children():
		$HBoxContainer.move_child(ch, ch.name.split(" ")[1].to_int() - 1)

func set_health_value(player_id: int, val: float) -> void:
	if player_id < 0 or player_id > $HBoxContainer.get_children().size(): return
	$HBoxContainer.get_node("Player " + str(player_id + 1)).set_health(val)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
