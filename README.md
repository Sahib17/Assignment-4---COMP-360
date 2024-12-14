# Ball Escape
Ball Escape is an exciting maze game where your goal is to escape through a blue portal while avoiding robot claws. These claws will throw you back to your starting position if they catch you, adding a layer of challenge to your escape!


**Winning Scene**

![FinalGame-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/f4043673-ce48-4a5b-bb19-af65a176ca39)


# How to run?
1. Download and extract the game files.
2. Run the Game.exe file to start the game.
3. Control the ball using the arrow keys: Up, Down, Left, Right.
4. Press the Space bar to make the ball jump.

# Claw movement

The robot claw in the game is responsible for grabbing and throwing the ball. The claw's movement was initially set up with a ramp, where the ball falls down and is caught by the robot arm.

**Key Variables**

`@export var ball:` RigidBody3D: The ball object to be detected, grabbed, and thrown.

`var has_ball = false:` Tracks whether the claw currently has the ball.

`@onready var animation_player = $AnimationPlayer:` Reference to the AnimationPlayer node for controlling animations.

`var is_ball_nearby = false:` Tracks if the ball is nearby.

**Functions**

`_ready():` Sets up the detection area and connects signals for ball detection.

`_on_ball_entered(body):` Triggered when the ball enters the detection area. If the object is the ball, the claw grabs it.

`_on_ball_exited(body):` Triggered when the ball leaves the detection area. Resets the state and returns to the idle animation.

`grab_ball():` Grabs the ball, disables physics, repositions it under the claw, and reparents it.

`throw_ball():` Throws the ball by re-enabling physics, applying an impulse, and reparenting it back to the main scene.

![RobotArmPhase1-ezgif com-animated-gif-maker](https://github.com/user-attachments/assets/e332f17a-cfb8-4f72-b21d-03bf5a48b4dd)


# Ball Controller

The ball controller handles player movement, physics interactions, and reset functionality for the game's main playable object.

## Components

- **RigidBody3D**: The main physics body for the ball
  
- **MeshInstance3D**: Visual representation of the ball
  
- **CollisionShape3D**: Physical collision shape for physics interactions

## Key Variables

`var destroyed_count = 0`: Tracks how many times the ball has been destroyed/reset

`var spawn_position = Vector3(-108.8, 46.571, 21.4)`: Initial spawn position

`var move_speed = 30.0`: Horizontal movement speed

`var jump_force = 5.0`: Vertical jump force

`var can_jump = true`: Controls jump availability

`var is_resetting = false`: Prevents multiple simultaneous resets

`var controls_locked = false`: Disables controls when true  

## Physics Properties

- **Friction**: 1.0
  
- **Bounce**: 0.2

## Key Functions

`_ready()`: 

- Initializes the ball
  
- Sets up screen exit detection
  
- Connects to wall signals
  
- Configures physics properties

`_physics_process()`:

- Handles movement input
  
- Applies forces for horizontal movement
  
- Controls jumping mechanics
  
- Checks for out-of-bounds reset

`reset_ball()`:

- Returns ball to spawn position
  
- Resets rotation and velocity
  
- Increments destroy counter
  
- Updates UI display

## Controls

- **Arrow Keys**: Horizontal movement
  
- **Spacebar**: Jump (with 1-second cooldown)

## Special Features

- Screen exit detection
  
- Automatic reset when falling below y=-30
  
- UI counter for ball resets
  
- Controls can be locked by wall signals

## Dependencies

- Requires a Label node for displaying reset count
  
- Connects to wall node for control locking functionality


# Contributions

## Samardeep Singh Sidhu

Developed the invisible wall and collision space (`Node 3D`, `Collision Space 3D`).

Updated ball code to include teleportation (in collaboration with Sahib).

Integrated the claw from the initial project file (Manpreet's claw) into the main game file.

Designed the revolving ramp, although it was not implemented due to alignment issues with the project.

![Ramp-ezgif com-video-to-gif-converter](https://github.com/user-attachments/assets/d3a4b026-9d88-4124-8793-ef1f7cf63673)


## Sahibjeet Singh

Created and implemented the ball and its associated physics.

Collaborated with Samardeep on the ball's teleportation functionality.

Added a ball destruction counter.

## Paramvir Singh Thind

Worked on ball and maze wall textures.

Collaborated with Shefreen on creating the maze.

## Shreyas Dutt

Added a custom font to the ball-destroyed counter.

Implemented the "Ball-destroyed" overlay.

Assisted with texture work.

Deployed the `Game.exe` on itch.io, [Comp 360 Final Project](https://shreyasdutt.itch.io/comp-360-final-project)

## Shefreen Kaur

Designed and created the maze layout.

Added a tree object and applied collision to it.

## Manpreet Singh

Created and implemented the claw functionality.

Added `Collision 3D` and `Area 3D` to the claw for collision detection.

Implemented proximity detection for the claw to trigger animations.

Created the `Game.exe` executable.

# Other Members

## Milo

![image](https://github.com/user-attachments/assets/45b54cf9-9b3d-44fb-9204-c2f3f9ffff77)

Provided Emotional Support and Technical Support throughout the project!

## Bruno

![WhatsApp Image 2024-12-13 at 22 57 22_e91f6eac](https://github.com/user-attachments/assets/88711644-88ad-419d-9d51-4335250fa77a)

Teamlead and provided financial support
