# Ball Escape
Ball escape is a game where you have to escape a maze and go to the blue portal to escape. you also have to avoid the robot claws or else they will throw you back to the initial position.

![image](https://github.com/user-attachments/assets/fd05eb28-2588-4ed9-863b-e25d80fa9097)


**Winning Scene**

![FinalGame-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/f4043673-ce48-4a5b-bb19-af65a176ca39)


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

# Contributions

## Samardeep Singh Sidhu

Worked on Invisible wall and its placement `Node 3D` and `Collision space 3D`.

Copied and pasted claw from the initial file to the main file.

Worked in collaboration with Sahib on ball teleportation.

Updated ball code and made it not workable. when asked to fix the errors, he refused.

Teleported ball once it goes in goal.

Revolved Ramp but wasn't Implemented because it didn't align with the project

![Ramp-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/d3a4b026-9d88-4124-8793-ef1f7cf63673)


## Sahibjeet Singh

Created and implemented Ball and all the functionality of ball.

Worked with samardeep on teleportation of ball

## Paramvir Singh Thind

## Shreyas Dutt

## Shefreen Kaur

## Manpreet Singh

Created and implemented Claw functionality.

Added `Collision 3D` and `Area 3D` on the claw to make it collide.

Added proximity area for Claw so that the animations play accordingly.

Created `Game.exe`

# Other Members

## Milo

![image](https://github.com/user-attachments/assets/45b54cf9-9b3d-44fb-9204-c2f3f9ffff77)

Provided Emotional Support and Technical Support throughout the project!

## Bruno

![WhatsApp Image 2024-12-13 at 22 57 22_e91f6eac](https://github.com/user-attachments/assets/88711644-88ad-419d-9d51-4335250fa77a)

Teamlead and provided financial support
