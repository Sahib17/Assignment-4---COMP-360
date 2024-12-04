extends RigidBody3D

signal ball_destroyed(count: int)

var destroyed_count = 0
var spawn_position = Vector3(0, 5, 0)

func _ready():
	var notifier = VisibleOnScreenNotifier3D.new()
	add_child(notifier)
	notifier.aabb = AABB(Vector3(-1, -1, -1), Vector3(2, 2, 2))
	notifier.screen_exited.connect(_on_screen_exited)
	print("Ball initialized at path: " + str(get_path()))
	position = spawn_position

func _physics_process(_delta):
	if position.y < -30:
		reset_ball()

func _on_screen_exited():
	print("Ball left screen!")
	reset_ball()

func reset_ball():
	destroyed_count += 1
	print("Ball reset! Times destroyed: ", destroyed_count)
	emit_signal("ball_destroyed", destroyed_count)
	
	position = spawn_position
	rotation = Vector3.ZERO
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
