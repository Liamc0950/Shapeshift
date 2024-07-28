extends CharacterBody2D


enum ATTACK_TYPE{AIR, EARTH, WATER, FIRE}

const SPEED = 350.0
const JUMP_VELOCITY = -400.0
const DAMAGE = 10.0

@export var healthLabel:Label = null
@export var attackLabel:Label = null

@onready var anim_tree = $AnimationTree
@onready var ice_particles = $IceParticles
@onready var health_component = $HealthComponent
@onready var sprite = $Sprite2D

@onready var hitDetector = $HitDetector
@onready var healthBar = get_tree().get_first_node_in_group("HealthBar")
@onready var gameOverLabel = get_tree().get_first_node_in_group("GameOver")
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var canAttack = true
var currentAttackType = 0

func _physics_process(delta):
	
	healthBar.value = health_component.health
	
	#attackLabel.text = str(currentAttackType)

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
		#$AirParticles.rotation = deg_to_rad(rad_to_deg(desired_rotation_y) + 90)
		#$EarthParticles.rotation = deg_to_rad(rad_to_deg(desired_rotation_y) + 90)

		anim_tree.set("parameters/AirAttack/blend_position", rad_to_deg(desired_rotation_y))
		anim_tree.set("parameters/EarthAttack/blend_position", rad_to_deg(desired_rotation_y))

		
		if velocity.x <= 0:

			sprite.scale = -sprite.scale
		
		
	velocity = direction * SPEED
	anim_tree.set("parameters/Move/blend_position", velocity)
	
	#healthLabel.text = "HEALTH: " + str(health_component.health)
	
	if health_component.health <= 0:
		$Glitch.visible = true
		gameOverLabel.visible = true
		get_tree().paused = true

		#queue_free()
	
	move_and_slide()

func hit():
	print("HIT START")
	$HitDetector.monitoring = true
func end_of_hit():
	$HitDetector.monitoring = false

func _air_attack():
	print("AIR")
	
	_camera_attack()
	#SET ATTACK TYPE
	currentAttackType = ATTACK_TYPE.AIR

	#START ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", true)
		
	#START PARTICLES
	await get_tree().create_timer(0.1).timeout
	$Particles/AirParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.4).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", false)

func _earth_attack():
	print("EARTH")
	_camera_attack()
	#SET ATTACK TYPE
	currentAttackType = ATTACK_TYPE.EARTH
	
	#START ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", true)

		
	#START PARTICLES
	$Particles/EarthParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.5).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", false)
	
func _water_attack():
	print("WATER")
	_camera_attack()
	#SET ATTACK TYPE
	currentAttackType = ATTACK_TYPE.WATER

	#START ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", true)
		
	#START PARTICLES
	$Particles/WaterParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.5).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", false)
	
func _fire_attack():
	print("FIRE")
	_camera_attack()
	#SET ATTACK TYPE
	currentAttackType = ATTACK_TYPE.FIRE
	
	#START ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", true)

		
	#START PARTICLES
	$Particles/FireParticles.emitting = true
	
	#WAIT TO COMPLETE
	await get_tree().create_timer(0.5).timeout
	
	#END ANIMAITON
	anim_tree.set("parameters/conditions/airAttack", false)

func _camera_attack():
	$Camera2D/AnimationTree.set("parameters/conditions/cameraAttack", true)
func stop_camera_attack():
	$Camera2D/AnimationTree.set("parameters/conditions/cameraAttack", false)
	
func take_damage(damage:int):
	health_component.remove_health(damage)
	##COLOR FX
	sprite.modulate = (Color.RED)
	$Glitch.visible = true
	await get_tree().create_timer(0.15).timeout
	$Glitch.visible = false
	sprite.modulate = Color(1,1,1)
	_camera_attack()

func _on_hit_detector_body_entered(body):
	if body.is_in_group("Enemy"):
		body.take_damage(DAMAGE, currentAttackType)
