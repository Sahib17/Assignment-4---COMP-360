extends Node3D

@export var claw_area: Area3D
@export var ball: Node3D
var patrol_position = Vector3(4, 0, 4)  # Strategic position in the solution path
var patrol_range = 3.0
var patrol_speed = 1.5  # Slightly faster for more challenge
var time = 0.0

func _ready():
	global_position = patrol_position
	claw_area.body_entered.connect(_on_claw_pickup)

func _process(delta):
	time += delta
	
	# Patrol movement
	var offset = sin(time * patrol_speed) * patrol_range
	global_position.x = patrol_position.x + offset
	global_position.z = patrol_position.z + cos(time * patrol_speed) * patrol_range
	
	# Add rotation for extra challenge
	rotation_degrees.y = sin(time * 0.8) * 90

func _on_claw_pickup(body):
	if body == ball:
		ball.get_parent().remove_child(ball)
		add_child(ball)
		ball.position = Vector3(0, 1, 0)
		await get_tree().create_timer(1.0).timeout
		drop_ball()

func drop_ball():
	if ball.get_parent() == self:
		remove_child(ball)
		get_parent().add_child(ball)
		ball.global_position = global_position + Vector3(0, -1, 2)
		ball.position.y = 1  # Ensure ball drops from a height
