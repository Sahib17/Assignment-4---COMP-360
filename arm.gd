extends Node3D

@export var ball: RigidBody3D
var has_ball = false
@onready var animation_player = $AnimationPlayer
var is_ball_nearby = false

func _ready():
	# Create Area3D for detection
	var area = Area3D.new()
	var collision_shape = CollisionShape3D.new()
	var box_shape = BoxShape3D.new()
	
	# Make detection area bigger
	box_shape.size = Vector3(2, 2, 2)
	collision_shape.shape = box_shape
	
	area.add_child(collision_shape)
	$Armature/Skeleton3D/Cube_002.add_child(area)
	
	# Position at the front of claw
	area.position = Vector3(0, 2, 1)
	
	# Connect signals
	area.body_entered.connect(_on_ball_entered)
	area.body_exited.connect(_on_ball_exited)
	
	# Start with idle animation
	animation_player.play("idle")

func _on_ball_entered(body):
	if body == ball and !has_ball:
		print("Ball nearby!")
		is_ball_nearby = true
		animation_player.play("grab")
		await animation_player.animation_finished
		
		if is_ball_nearby:
			grab_ball()

func _on_ball_exited(body):
	if body == ball and !has_ball:
		print("Ball left area!")
		is_ball_nearby = false
		animation_player.play("idle")

func grab_ball():
	if !has_ball and is_ball_nearby:
		print("Grabbing ball!")
		has_ball = true
		
		# Disable ball physics
		ball.freeze = true
		
		# Parent ball to claw
		var original_transform = ball.global_transform
		ball.get_parent().remove_child(ball)
		$Armature/Skeleton3D/Cube_002.add_child(ball)
		ball.global_transform = original_transform
		
		# Position ball relative to claw
		ball.position = Vector3(0, 2, 0)
		
		# Wait before throwing
		await get_tree().create_timer(1.0).timeout
		throw_ball()

func throw_ball():
	if has_ball:
		print("Throwing ball!")
		
		# Play letgo animation
		animation_player.play("letgo")
		await animation_player.animation_finished
		
		# Reparent ball to main scene
		var original_transform = ball.global_transform
		var parent = ball.get_parent()
		if parent:
			parent.remove_child(ball)
		get_tree().get_root().get_node("origin").add_child(ball)
		ball.global_transform = original_transform
		
		# Enable physics and throw with more force
		ball.freeze = false
		ball.apply_central_impulse(Vector3(0, 10, -40))  # Increased force
		
		has_ball = false
		is_ball_nearby = false
		
		# Return to idle
		animation_player.play("idle")
