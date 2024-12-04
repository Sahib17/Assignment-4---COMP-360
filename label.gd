extends Label

# Add a variable to track if we're already connected
var is_connected = false

func _ready():
	text = "Balls Destroyed: 0"
	
	# Use the correct path for the ball
	var ball = get_node("/root/origin/Ball")
	if ball and !is_connected:
		# Disconnect any existing connections first
		if ball.is_connected("ball_destroyed", Callable(self, "_on_ball_destroyed")):
			ball.disconnect("ball_destroyed", Callable(self, "_on_ball_destroyed"))
		
		# Make new connection
		ball.connect("ball_destroyed", Callable(self, "_on_ball_destroyed"))
		is_connected = true
		print("Connected to ball successfully!")
	else:
		print("Failed to find ball or already connected")

func _on_ball_destroyed(count: int):
	print("Signal received! Count: ", count)
	text = "Balls Destroyed: " + str(count)
