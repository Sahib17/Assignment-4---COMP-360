extends Node3D

@onready var ball = $"../../../Ball" # Modern GDScript syntax for onready
var distance_threshold: float = 2.0  # Exposed as variable for easier tweaking

func _ready() -> void:
	if not ball:
		push_error("Ball node not found. Please check the node path: ../../../Ball")
		return
		
	print("Ball teleporter initialized. Will use ball's internal spawn position.")

func _process(_delta: float) -> void:
	if not ball:
		return
		
	if is_ball_near():
		reset_ball()

func is_ball_near() -> bool:
	if not ball:
		return false
		
	var distance = global_transform.origin.distance_to(ball.global_transform.origin)
	return distance < distance_threshold

func reset_ball() -> void:
	if not ball:
		return
		
	# Call the ball's own reset function instead of trying to manage it ourselves
	if ball.has_method("reset_ball"):
		ball.reset_ball()
	else:
		push_error("Ball node does not have a reset_ball method!")
