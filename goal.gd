extends Area3D

@onready var ball = $"/root/origin/Ball"
@onready var game_over_popup = preload("res://game_over_popup.tscn")
var popup_instance
var exit_position = Vector3(300, 46.571, 21.4)

func _ready():
	body_entered.connect(_on_body_entered)
	print("Goal initialized")
	
	# Create the popup instance
	popup_instance = game_over_popup.instantiate()
	# Hide it initially
	popup_instance.hide()
	# Add it to the scene's CanvasLayer to ensure it shows on top
	var canvas_layer = CanvasLayer.new()
	add_child(canvas_layer)
	canvas_layer.add_child(popup_instance)

func _on_body_entered(body: Node3D):
	if body == ball:
		print("Goal reached! Showing game over and teleporting ball")
		ball.position = exit_position
		
		# Reset ball physics
		if ball.has_method("set_linear_velocity"):
			ball.set_linear_velocity(Vector3.ZERO)
		if ball.has_method("set_angular_velocity"):
			ball.set_angular_velocity(Vector3.ZERO)
		
		# Show game over popup
		popup_instance.show()
		# Optional: Hide after delay
		await get_tree().create_timer(3.0).timeout
		popup_instance.hide()
