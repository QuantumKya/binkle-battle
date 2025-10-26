extends CharacterBody3D
class_name Player

const SPEED = 5.0
const JUMP_VELOCITY = 4.5

const player_id: int = 0
@export var player_manager: Node

var attacking: bool = false
@onready var attack_timer = $AttackTimer

@onready var attack_hitbox = $AttackHitbox
@onready var gethit_hitbox = $GetHitBox


func _ready() -> void:
	player_manager.add_player(player_id, gethit_hitbox, attack_hitbox)

func _process(delta: float) -> void:
	if Input.is_action_pressed("attack1") && not attacking:
		attacking = true
		var target: int = hit_check()
		
		attack_timer.start()
		Globals.log("Attack Missed!" if target == 0 else "Attack Landed!")

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_axis("move_left", "move_right")
	if input_dir < 0:
		set_flip(-1)
	elif input_dir > 0:
		set_flip(1)
	
	var direction := (transform.basis * Vector3(input_dir, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func hit_check() -> int:
	var mask: int = 0
	for area in attack_hitbox.get_overlapping_areas():
		mask |= (area.collision_layer >> 2)
	
	if mask != 0:
		var hit_players = player_manager.decode_player_mask(mask)
		Globals.log("Players hit: ")
		Globals.log(str(hit_players.map(func(a): return a+1)))
	return mask

func set_flip(scl: float):
	$Sprite3D.scale.x = scl
	attack_hitbox.scale.x = scl
	gethit_hitbox.scale.x = scl

func _on_attack_timer_timeout() -> void:
	attacking = false
