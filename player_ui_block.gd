extends Control

@export var player_number: int = 1

const lerpPlan: Curve = preload("res://stuff/healthlerpcurve.tres")
var lerping: bool = false
var targetValue: float = 1.0
var beginValue: float = 1.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var fname = "res://sprites/ui/p" + str(player_number) + ".png"
	$PlayerText.texture = load(fname)

func set_health(val: float) -> void:
	lerping = true
	$Timer.start()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if lerping:
		$HealthBar.value = beginValue + lerpPlan.sample()


func _on_timer_timeout() -> void:
	pass # Replace with function body.
