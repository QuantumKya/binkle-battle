extends Node
class_name PlayerManager

@export var player_ui: Control

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
	
	player_ui.add_player(player_id)

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
	Globals.log("Player " + str(dealer_id) + " hit Player " + str(recipient_id) + ", dealing " + str(damage) + " damage!")
	Globals.log("Player " + str(recipient_id) + " left with " + str(player_states[recipient_id].health) + " health.")
	if player_states[recipient_id].health <= 0:
		player_states[recipient_id].health = 0
		player_scores[dealer_id].wins += 1
		player_scores[recipient_id].losses += 1
	var recip_health_percent: float = player_states[recipient_id].health / float(player_health)
	player_ui.set_health_value(recipient_id, recip_health_percent)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
