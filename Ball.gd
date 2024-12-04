extends RigidBody3D

signal ball_destroyed(count: int)

var destroyed_count = 0
var spawn_position = Vector3(0, 5, 0)
var is_resetting = false  # Add this to prevent double resets

func _ready():
	var notifier = VisibleOnScreenNotifier3D.new()
	add_child(notifier)
	notifier.aabb = AABB(Vector3(-1, -1, -1), Vector3(2, 2, 2))
	notifier.screen_exited.connect(_on_screen_exited)
	print("Ball initialized at path: " + str(get_path()))
	position = spawn_position

func _physics_process(_delta):
	if position.y < -30 and !is_resetting:
		reset_ball()

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
	
	# Reset the flag after a short delay
	await get_tree().create_timer(0.1).timeout
	is_resetting = false
