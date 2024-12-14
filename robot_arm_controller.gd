extends Node3D

@export var ball: RigidBody3D
@export var throw_force: Vector3 = Vector3(0, 10, -40)
@export var grab_height: float = 2.0
@export var detection_size: Vector3 = Vector3(2, 2, 2)

var has_ball = false
var is_ball_nearby = false
var animation_player: AnimationPlayer

func _ready():
	# Try to find AnimationPlayer
	animation_player = get_node("AnimationPlayer")
	if animation_player:
		print("Found AnimationPlayer! Available animations: ", animation_player.get_animation_list())
		# Set animation settings
		animation_player.playback_process_mode = AnimationPlayer.ANIMATION_PROCESS_PHYSICS
		animation_player.play("idle")
		print("Playing idle animation")
		print("Current animation: ", animation_player.current_animation)
		print("Is playing: ", animation_player.is_playing())
	else:
		print("Failed to find AnimationPlayer")
	
	# Create Area3D for detection
	var area = Area3D.new()
	var collision_shape = CollisionShape3D.new()
	var box_shape = BoxShape3D.new()
	
	# Make detection area bigger
	box_shape.size = detection_size
	collision_shape.shape = box_shape
	
	area.add_child(collision_shape)
	var cube = get_node("Armature/Skeleton3D/Cube_002")
	if cube:
		cube.add_child(area)
		# Position at the front of claw
		area.position = Vector3(0, grab_height, 1)
		
		# Connect signals
		area.body_entered.connect(_on_ball_entered)
		area.body_exited.connect(_on_ball_exited)
	else:
		print("Failed to find Cube_002")

func _on_ball_entered(body):
	if body == ball and !has_ball and animation_player:
		print("Ball nearby!")
		is_ball_nearby = true
		
		print("Attempting to play grab animation")
		animation_player.stop()  # Stop current animation
		animation_player.queue("grab")  # Queue the grab animation
		print("Animation queued: grab")
		print("Current animation: ", animation_player.current_animation)
		print("Is playing: ", animation_player.is_playing())
		
		await animation_player.animation_finished
		print("Animation finished signal received")
		
		if is_ball_nearby:
			grab_ball()

func _on_ball_exited(body):
	if body == ball and !has_ball and animation_player:
		print("Ball left area!")
		is_ball_nearby = false
		animation_player.stop()
		animation_player.play("idle")
		print("Playing idle animation after exit")
		print("Current animation: ", animation_player.current_animation)

func grab_ball():
	if !has_ball and is_ball_nearby:
		print("Grabbing ball!")
		has_ball = true
		
		# Disable ball physics
		ball.freeze = true
		
		# Parent ball to claw
		var original_transform = ball.global_transform
		var cube = get_node("Armature/Skeleton3D/Cube_002")
		if cube:
			ball.get_parent().remove_child(ball)
			cube.add_child(ball)
			ball.global_transform = original_transform
			
			# Position ball relative to claw
			ball.position = Vector3(0, grab_height, 0)
			
			# Wait before throwing
			await get_tree().create_timer(1.0).timeout
			throw_ball()
		else:
			print("Failed to find Cube_002 for ball grab")

func throw_ball():
	if has_ball and animation_player:
		print("Throwing ball!")
		
		print("Attempting to play letgo animation")
		animation_player.stop()
		animation_player.queue("letgo")
		print("Animation queued: letgo")
		print("Current animation: ", animation_player.current_animation)
		print("Is playing: ", animation_player.is_playing())
		
		await animation_player.animation_finished
		print("Letgo animation finished")
		
		# Reparent ball to main scene
		var original_transform = ball.global_transform
		var parent = ball.get_parent()
		if parent:
			parent.remove_child(ball)
		get_tree().get_root().get_node("origin").add_child(ball)
		ball.global_transform = original_transform
		
		# Enable physics and throw with more force
		ball.freeze = false
		ball.apply_central_impulse(throw_force)
		
		has_ball = false
		is_ball_nearby = false
		
		# Return to idle
		animation_player.stop()
		animation_player.queue("idle")
		print("Returning to idle animation")
		print("Current animation: ", animation_player.current_animation)

func _process(_delta):
	if ball and !has_ball and animation_player:
		var distance = ball.global_position.distance_to(global_position)
		if distance < 5:  # Only print when ball is close
			print("Distance to ball: ", distance)
			print("Current animation: ", animation_player.current_animation)
			print("Is animation playing: ", animation_player.is_playing())
