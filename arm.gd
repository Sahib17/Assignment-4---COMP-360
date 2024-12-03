extends Node3D

# Signals for picking up and dropping the ball
@export var claw_area: Area3D
@export var ball: Node3D

func _ready():
	# Connect the claw's area signal
	claw_area.body_entered.connect(_on_claw_pickup)

func _on_claw_pickup(body):
	if body == ball:
		ball.get_parent().remove_child(ball)
		self.add_child(ball)
		ball.translation = Vector3(0, 1, 0)  # Attach to claw center

func drop_ball():
	if ball.get_parent() == self:
		self.remove_child(ball)
		get_parent().add_child(ball)
		ball.translation = self.global_transform.origin + Vector3(0, -1, 2)  # Drop position
