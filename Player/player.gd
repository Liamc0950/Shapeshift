extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -400.0

@onready var anim_tree = $AnimationTree

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _physics_process(delta):


	var direction = Vector2(
				Input.get_action_strength("Right") - Input.get_action_strength("Left"),
				Input.get_action_strength("Down") - Input.get_action_strength("Up")
				).normalized()

	if Input.is_action_just_pressed("IceAttack"):
		anim_tree.set("parameters/conditions/iceAttack", true)
		anim_tree.set("parameters/conditions/notIceAttack", false)
		await get_tree().create_timer(0.5).timeout
		anim_tree.set("parameters/conditions/iceAttack", false)
		anim_tree.set("parameters/conditions/notIceAttack", true)


	#Change rotatation
	if direction:
		var desired_rotation_y = atan2(-velocity.x, velocity.y)
		self.rotation = desired_rotation_y
		
	velocity = direction * SPEED
	anim_tree.set("parameters/Move/blend_position", abs(velocity))
	
	move_and_slide()