# Ball Escape
Ball escape is a game where you have to escape a maze and go to the blue portal to escape. you also have to avoid the robot claws or else they will throw you back to the initial position.

# How to run?
To run the game simply run the `Game.exe` file and the game will start. To control the ball movement use the up, down, left and right arrow keys, to jump use the space bar.

# Claw movement

1. **Initial Setup**

The initial setup for the claw was implemented through a ramp, the ball falling down and the robot arm catching it.

![RobotArmPhase1-ezgif com-animated-gif-maker](https://github.com/user-attachments/assets/e332f17a-cfb8-4f72-b21d-03bf5a48b4dd)

**Key Variables**

`@export var ball: RigidBody3D`

The ball to be detected, grabbed, and thrown.

`var has_ball = false`

Tracks whether the claw currently has the ball.

`@onready var animation_player = $AnimationPlayer`

Reference to the AnimationPlayer node for playing animations.

`var is_ball_nearby = false`

Tracks whether the ball is in proximity.

**Functions**

```_ready()```

Sets up the detection area, collision shape, and connects signals for detecting the ball's presence.

```_on_ball_entered(body)```

Triggered when a RigidBody3D enters the detection area. If it's the ball, plays the grab animation and attempts to grab it.

```_on_ball_exited(body)```

Triggered when the ball leaves the detection area. Resets the is_ball_nearby flag and reverts to the idle animation.

```grab_ball()```

Handles the logic for grabbing the ball, including disabling its physics, reparenting it to the claw, and positioning it correctly.

```throw_ball()```

Throws the ball by re-enabling physics, applying an impulse, and reparenting it to the main scene.
