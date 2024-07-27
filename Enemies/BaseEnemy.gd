extends CharacterBody2D

@export var spriteTexture:Texture2D
@export var start_health = 50.0
@export var speed = 100.0
@export var damage = 5.0

@onready var anim_tree = $AnimationTree
@onready var ice_particles = $IceParticles
@onready var health_component = $HealthComponent
@onready var sprite = $Sprite2D



@onready var player = get_tree().get_nodes_in_group("Player")[0]  

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_position 
var target_position 

var attacking = false

func ready():
	$Sprite2D.texture = spriteTexture
	health_component.health = start_health

func _physics_process(delta):
	
	player_position = player.position
	target_position = (player_position - position).normalized()
	
	anim_tree.set("parameters/Move/blend_position", velocity)

	velocity = target_position * speed
	
	if(position.distance_to(player_position) > 3 && !attacking):
		look_at(player_position)
		move_and_slide()


	if attacking:
		anim_tree.set("parameters/conditions/attack", true)
	else:
		anim_tree.set("parameters/conditions/attack", false)

	anim_tree.set("parameters/Move/blend_position", velocity)
	
	if health_component.health <= 0.0:
		self.queue_free()
	


func hit():
	$HitDetector.monitoring = true
func end_of_hit():
	$HitDetector.monitoring = false



#func _attack():
	#player.health_component.remove_health(DAMAGE)
	##COLOR FX
	#player.sprite.modulate = (Color.RED)
	#await get_tree().create_timer(0.1).timeout
	#player.sprite.modulate = Color(1,1,1)
	#print("ATTACK")
	#await get_tree().create_timer(1).timeout


func take_damage(damage:int):
	health_component.remove_health(damage)
	##COLOR FX
	sprite.modulate = (Color.RED)
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color(1,1,1)
	
func _on_player_detector_body_entered(body):
	attacking = true
func _on_player_detector_body_exited(body):
	attacking = false

func _on_hit_detector_body_entered(body):
	if attacking:
		player.take_damage(damage)



