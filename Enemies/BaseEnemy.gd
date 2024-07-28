extends CharacterBody2D

class_name BaseEnemy

enum ENEMY_TYPES{TRIANGLE, SQUARE, DIAMOND, CIRCLE}
enum ATTACK_TYPE{AIR, EARTH, WATER, FIRE}

var receive_attack_type = null

var type: ENEMY_TYPES = 0

var start_health = 50.0
var speed = 100.0
var damage = 5.0


@onready var anim_tree = $AnimationTree
@onready var health_component = $HealthComponent
@onready var sprite = $Rotateable/Sprite2D
@onready var attackIcon = $AttackIcon


@onready var player = get_tree().get_first_node_in_group("Player")


# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var player_position 
var target_position 

var attacking = false
var canAttack = true
var spawnerManager:SpawnerManager = null
	
func _ready():
	
	#global_position = Vector2(-10000, 10000)
	
	spawnerManager = get_tree().get_first_node_in_group("Level")

	$ProgressBar.max_value = health_component.health


func _physics_process(delta):
	
	
	$ProgressBar.value = health_component.health
	if player != null:
		player_position = player.global_position
		target_position = (player_position - global_position).normalized()
		
		anim_tree.set("parameters/Move/blend_position", velocity)

		velocity = target_position * speed
		
		if(position.distance_to(player_position) > 3 && !attacking):
			$Rotateable.look_at(player_position)
			move_and_slide()


		if attacking and canAttack:
			anim_tree.set("parameters/conditions/attack", true)
		else:
			anim_tree.set("parameters/conditions/attack", false)

		anim_tree.set("parameters/Move/blend_position", velocity)
		
		if health_component.health <= 0.0:
			_die()



func hit():
	$Rotateable/HitDetector.monitoring = true
func end_of_hit():
	$Rotateable/HitDetector.monitoring = false

func _die():
	canAttack = false
	anim_tree.set("parameters/conditions/die", true)
	$ChromaticAberration.visible = true
	await get_tree().create_timer(0.3).timeout
	$ChromaticAberration.visible = false
	anim_tree.set("parameters/conditions/die", false)
	self.queue_free()
	spawnerManager.enemyKilled()

func _set_up_enemy():
	match self.type:
		ENEMY_TYPES.TRIANGLE:
			$Rotateable/Sprite2D.texture = ResourceLoader.load("res://Assets/Sprites/Air_Enemy.png")
			health_component.health = 10
			speed = 100
			damage = 20.0
			receive_attack_type = ATTACK_TYPE.EARTH
			attackIcon.rotation_degrees = 90
		ENEMY_TYPES.SQUARE:
			print("SQUARE")
			$Rotateable/Sprite2D.texture = ResourceLoader.load("res://Assets/Sprites/Earth_Enemy.png")
			health_component.health = 10
			speed = 120
			damage = 20.0
			receive_attack_type = ATTACK_TYPE.AIR
			attackIcon.rotation_degrees = -90
		ENEMY_TYPES.CIRCLE:
			$Rotateable/Sprite2D.texture = ResourceLoader.load("res://Assets/Sprites/Water_Enemy.png")
			health_component.health = 10
			speed = 125
			damage = 20.0
			receive_attack_type = ATTACK_TYPE.FIRE
		ENEMY_TYPES.DIAMOND:
			$Rotateable/Sprite2D.texture = ResourceLoader.load("res://Assets/Sprites/Fire_Enemy.png")
			health_component.health = 10
			speed = 120
			damage = 20.0
			receive_attack_type = ATTACK_TYPE.WATER
			attackIcon.rotation_degrees = 180
		
	print(speed)


func setType(type):
	self.type = type
	_set_up_enemy()
	print("SET TO " + str(type))

#func _attack():
	#player.health_component.remove_health(DAMAGE)
	##COLOR FX
	#player.sprite.modulate = (Color.RED)
	#await get_tree().create_timer(0.1).timeout
	#player.sprite.modulate = Color(1,1,1)
	#print("ATTACK")
	#await get_tree().create_timer(1).timeout


func take_damage(damage:int, attack_type:ATTACK_TYPE):
	if attack_type == receive_attack_type:
		await get_tree().create_timer(0.1).timeout
		health_component.remove_health(damage)
		##COLOR FX
		sprite.modulate = (Color.RED)
		await get_tree().create_timer(0.15).timeout
		sprite.modulate = Color(1,1,1)
	
func _on_player_detector_body_entered(body):
	await get_tree().create_timer(0.1).timeout
	attacking = true
func _on_player_detector_body_exited(body):
	attacking = false

func _on_hit_detector_body_entered(body):
	print(body)
	if attacking:
		if body.is_in_group("Player"):
			player.take_damage(damage)
