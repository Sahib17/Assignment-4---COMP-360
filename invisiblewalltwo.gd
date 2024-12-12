extends StaticBody3D

@onready var ball = $"/root/origin/Ball"
var is_resetting = false
var teleport_position = Vector3(-108.8, 46.571, 21.4)
var contact_position = Vector3.ZERO

signal lock_controls(locked: bool)  # Add the signal definition here

func _ready():
	print("Invisible wall initialized")
	var area = Area3D.new()
	add_child(area)
	var shape = $CollisionShape3D.duplicate()
	area.add_child(shape)
	area.body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node3D):
	if body == ball and !is_resetting:
		is_resetting = true
		print("Ball touched - starting 3 second countdown...")
		
		# Store the position where ball touched
		contact_position = ball.global_position
		# Freeze the ball immediately
		ball.freeze = true
		emit_signal("lock_controls", true)  # Lock controls
		
		# Start countdown but keep ball in place
		var time_left = 3.0
		while time_left > 0:
			# Force position during countdown
			ball.global_position = contact_position
			ball.linear_velocity = Vector3.ZERO
			ball.angular_velocity = Vector3.ZERO
			
			await get_tree().create_timer(0.1).timeout
			time_left -= 0.1
			
		# After 3 seconds, teleport
		print("Teleporting now!")
		ball.global_position = teleport_position
		ball.freeze = false
		emit_signal("lock_controls", false)  # Unlock controls
		is_resetting = false
