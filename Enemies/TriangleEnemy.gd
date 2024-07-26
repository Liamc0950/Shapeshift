extends CharacterBody2D

@onready var anim_tree = $AnimationTree
@onready var ice_particles = $IceParticles

const SPEED = 100.0
const DAMAGE = 10.0
const JUMP_VELOCITY = -400.0

@onready var player = get_tree().get_nodes_in_group("Player")[0]  

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_position 
var target_position 

func _physics_process(delta):
	
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	anim_tree.set("parameters/Move/blend_position", velocity)

	velocity = target_position * SPEED
	
	if(position.distance_to(player_position) > SPEED / 1.5):
		look_at(player_position)
		move_and_slide()
	else:
		_attack()



	anim_tree.set("parameters/Move/blend_position", velocity)

	print(velocity)


func _attack():
	player.health_component.remove_health(DAMAGE)
	#COLOR FX
	player.sprite.modulate = (Color.RED)
	await get_tree().create_timer(0.1).timeout
	player.sprite.modulate = (Color(1,1,1)
	print("ATTACK")
