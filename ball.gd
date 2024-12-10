extends RigidBody3D

signal ball_destroyed(count: int)

# Original variables
var destroyed_count = 0
var spawn_position = Vector3(-108.8, 46.571, 21.4)
var is_resetting = false

# Movement variables
var move_speed = 10.0  # Horizontal movement speed
var jump_force = 5.0  # Vertical jump force
var can_jump = true   # To prevent double jumping

func _ready():
	add_to_group("ball")
	var notifier = VisibleOnScreenNotifier3D.new()
	add_child(notifier)
	notifier.aabb = AABB(Vector3(-1, -1, -1), Vector3(2, 2, 2))
	notifier.screen_exited.connect(_on_screen_exited)
	print("Ball initialized at path: " + str(get_path()))
	position = spawn_position

	# Set physics interpolation mode for smoother movement
	physics_material_override = PhysicsMaterial.new()
	physics_material_override.friction = 1.0
	physics_material_override.bounce = 0.2

func _physics_process(_delta):
	# Original reset check
	if position.y < -30 and !is_resetting:
		reset_ball()
	
	# === MOVEMENT CONTROLS START ===
	var input = Vector3.ZERO
	
	# Horizontal movement
	if Input.is_action_pressed("ui_up"):
		input.x -= 1
	if Input.is_action_pressed("ui_down"):
		input.x += 1
	
	# Forward/backward movement
	if Input.is_action_pressed("ui_right"):
		input.z -= 1
	if Input.is_action_pressed("ui_left"):
		input.z += 1
	
	# Apply horizontal movement
	if input != Vector3.ZERO:
		apply_central_force(input.normalized() * move_speed)
	
	# Jumping
	if Input.is_action_just_pressed("ui_accept") and can_jump:  # Spacebar
		apply_central_impulse(Vector3.UP * jump_force)
		can_jump = false
		await get_tree().create_timer(1.0).timeout  # Prevent jumping for 1 second
		can_jump = true
	# === MOVEMENT CONTROLS END ===

func _on_screen_exited():
	if !is_resetting:
		print("Ball left screen!")

func reset_ball():
	if is_resetting:
		return
		
	is_resetting = true
	destroyed_count += 1
	print("Ball reset! Times destroyed: ", destroyed_count)
	emit_signal("ball_destroyed", destroyed_count)
	
	position = spawn_position
	rotation = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	
	await get_tree().create_timer(0.1).timeout
	is_resetting = false
