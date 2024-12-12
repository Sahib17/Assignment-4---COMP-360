extends Area3D

@onready var ball = $"/root/origin/Ball"
@onready var goal_label = $"../Label"
var exit_position = Vector3(300, 46.571, 21.4)  # Much further away on X axis

func _ready():
	body_entered.connect(_on_body_entered)
	print("Goal initialized")
	if goal_label:
		goal_label.hide()

func _on_body_entered(body: Node3D):
	if body == ball:
		print("Goal reached! Teleporting ball far outside maze")
		ball.position = exit_position
		
		# Reset ball physics
		if ball.has_method("set_linear_velocity"):
			ball.set_linear_velocity(Vector3.ZERO)
		if ball.has_method("set_angular_velocity"):
			ball.set_angular_velocity(Vector3.ZERO)
			
		# Show goal message
		if goal_label:
			goal_label.show()
			await get_tree().create_timer(3.0).timeout
			goal_label.hide()
