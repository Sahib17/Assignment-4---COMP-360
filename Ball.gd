extends RigidBody3D

func _ready():
	# Set the ball's initial physics properties
	self.physics_material = PhysicsMaterial.new()
	self.physics_material.bounce = 0.4
	self.physics_material.friction = 0.6
