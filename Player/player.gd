extends CharacterBody2D

enum DIRECTION{LEFT, RIGHT, UP, DOWN}


const SPEED = 350.0
const JUMP_VELOCITY = -400.0
const DAMAGE = 10.0

@export var healthLabel:Label = null

@onready var anim_tree = $AnimationTree
@onready var ice_particles = $IceParticles
@onready var health_component = $HealthComponent
@onready var sprite = $Sprite2D

@onready var hitDetector = $HitDetector


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var canAttack = true

func _physics_process(delta):


	var direction = Vector2(
				Input.get_action_strength("Right") - Input.get_action_strength("Left"),
				Input.get_action_strength("Down") - Input.get_action_strength("Up")
				).normalized()

	if Input.is_action_just_pressed("AirAttack"):
		_air_attack()
	if Input.is_action_just_pressed("EarthAttack"):
		_earth_attack()
	if Input.is_action_just_pressed("WaterAttack"):
		_water_attack()
	if Input.is_action_just_pressed("FireAttack"):
		_fire_attack()
		
	#Change rotatation
	if direction:
		var desired_rotation_y = atan2(-velocity.x, velocity.y)
		hitDetector.rotation = deg_to_rad(rad_to_deg(desired_rotation_y) + 90)
		print(velocity.x)
		
		if velocity.x <= 0:

			sprite.scale = -sprite.scale
		
		
	velocity = direction * SPEED
	anim_tree.set("parameters/Move/blend_position", velocity)
	
	healthLabel.text = "HEALTH: " + str(health_component.health)
	

	
	move_and_slide()

func hit():
	print("HIT START")
	$HitDetector.monitoring = true
func end_of_hit():
	$HitDetector.monitoring = false

func _air_attack():
	print("AIR")
	#START ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", true)
		
	#START PARTICLES
	$AirParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.5).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", false)

func _earth_attack():
	print("EARTH")
	#START ANIMAITON
	anim_tree.set("parameters/conditions/earthAttack", true)

		
	#START PARTICLES
	$EarthParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.5).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/earthAttack", false)
	
func _water_attack():
	print("WATER")
		
	#START ANIMAITON
	anim_tree.set("parameters/conditions/waterAttack", true)

		
	#START PARTICLES
	$WaterParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.5).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/waterAttack", false)
	
func _fire_attack():
	print("FIRE")
	#START ANIMAITON
	anim_tree.set("parameters/conditions/fireAttack", true)

		
	#START PARTICLES
	$FireParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.5).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/fireAttack", false)

func take_damage(damage:int):
	health_component.remove_health(damage)
	##COLOR FX
	sprite.modulate = (Color.RED)
	await get_tree().create_timer(0.1).timeout
	sprite.modulate = Color(1,1,1)

func _on_hit_detector_body_entered(body):
	if body.is_in_group("Enemy"):
		body.take_damage(DAMAGE)
