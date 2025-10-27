extends Node
class_name PlayerManager

@export var player_ui: HBoxContainer
const player_ui_block = preload("res://player_ui_block.tscn")

var player_count: int = 0
var player_states: Dictionary = {}
var player_scores: Dictionary = {}

const player_health: int = 50


func add_player(player_id: int) -> void:
	player_count = max(player_count, player_id + 1)
	player_states[player_id] = {
		"health": player_health,
		"special": 0,
	}
	player_scores[player_id] = {
		"wins": 0,
		"losses": 0,
	}
	
	var pui: Control = player_ui_block.instantiate()
	pui.set_size(Vector2(4, 4))
	pui.name = "Player " + str(player_id + 1)
	pui.player_number = player_id + 1
	player_ui.add_child(pui)

func init_attack(player_id: int, attackbox: Area3D) -> void:
	var hitmask := 0
	for i in player_count:
		if i == player_id: continue
		hitmask |= (1 << i)
	
	attackbox.collision_mask |= hitmask << 2
 
func init_hitbox(player_id: int, gethitbox: Area3D) -> void:
	gethitbox.collision_layer |= (1 << player_id) << 2

func decode_player_mask(pmask: int) -> Array[int]:
	var players: Array[int] = []
	for i in player_count:
		if pmask & (1 << i):
			players.append(i)
	return players

func deal_damage(dealer_id: int, recipient_id: int, damage: int) -> void:
	player_states[recipient_id].health -= damage
	if player_states[recipient_id].health <= 0:
		player_states[recipient_id].health = 0
		player_states[dealer_id].wins += 1
		player_states[recipient_id].losses += 1
	player_ui.find_child("Player " + str(recipient_id + 1)).set_health_value(player_states[recipient_id].health / player_health)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
