extends Label

func _ready():
	text = "Balls Destroyed: 0"
	
	# Use the correct path for the ball
	var ball = get_node("/root/origin/Ball")
	if ball:
		# Connect with proper reference
		ball.connect("ball_destroyed", Callable(self, "_on_ball_destroyed"))
		print("Connected to ball successfully!")
	else:
		print("Failed to find ball at path: /root/Origin/Ball")
		print_debug_info()

func print_debug_info():
	print("Current Label path: ", get_path())
	var origin = get_node("/root/Origin")
	if origin:
		print("Found Origin node")
		for child in origin.get_children():
			print("Node in Origin: ", child.name)

func _on_ball_destroyed(count: int):
	print("Signal received! Count: ", count)
	text = "Balls Destroyed: " + str(count)
