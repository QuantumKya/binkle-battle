extends CharacterBody3D


const SPEED = 5.0
const JUMP_VELOCITY = 4.5

var attacking: bool = false
@onready var attack_timer = $AttackTimer

@onready var attack_hitbox = $AttackHitbox

func _ready() -> void:
	attack_hitbox.monitorable = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("attack1") && not attacking:
		attacking = true
		attack_hitbox.monitorable = true
		attack_timer.start()
		Globals.log("Attacked!")

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
	var direction := (transform.basis * Vector3(input_dir, 0, 0)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _on_attack_timer_timeout() -> void:
	attacking = false
	attack_hitbox.monitorable = false
