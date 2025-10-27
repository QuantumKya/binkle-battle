extends Control

@export var player_number: int = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fname = "res://sprites/ui/p" + str(player_number) + ".png"
	$PlayerText.texture = load(fname)

func set_health_value(val: float) -> void:
	$AspectRatioContainer/HealthBar.value = val


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
