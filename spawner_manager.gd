extends Node2D

class_name SpawnerManager

var deadEnemies = 0
var level = -1
var currentTotalEnemies = 1
var canSpawn = true
var baseEnemyPackedScene = preload("res://Enemies/BaseEnemy.tscn")

@export var baseEnemy:CharacterBody2D = null
@export var spawnPointLeft:Node2D = null
@export var spawnPointRight:Node2D = null
@export var spawnPointUp:Node2D = null
@export var spawnPointDown:Node2D = null


var levels = [
	Level.new(4, [[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2]
				]),
	Level.new(4, [
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2]
				]),
	Level.new(4, [
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2]
				]),
	Level.new(4, [
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2]
				]),
	Level.new(4, [
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2]
				]),
	Level.new(12, [
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 4],
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2],
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2],
				]),
	Level.new(16, [
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 4],
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2],
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2],
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2],
				]),
	Level.new(32, [
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 4],
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 2],
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 2],
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 2],
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 2], 
				[Level.ENEMY_TYPES.TRIANGLE, Level.SPAWN_POINTS.LEFT, 4],
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 1], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 1], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 1], 
				[Level.ENEMY_TYPES.SQUARE, Level.SPAWN_POINTS.RIGHT, 1],
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 1], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 1], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 1], 
				[Level.ENEMY_TYPES.CIRCLE, Level.SPAWN_POINTS.UP, 1],
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 1], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 1], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 1], 
				[Level.ENEMY_TYPES.DIAMOND, Level.SPAWN_POINTS.DOWN, 1]
				])
]

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("Level")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
	
func enemyKilled():
	deadEnemies += 1
	if deadEnemies>= currentTotalEnemies:
		$BetweenWaves.start()
		deadEnemies = 0

		
func spawnEnemies():
	if level < levels.size():
		var level:Level = levels[level]
		
		for i in level.enemyCount:

			var baseEnemy = baseEnemyPackedScene.instantiate()
			
			add_child(baseEnemy)
			
			baseEnemy.setType(level.enemyOrder[i][0])
			
			match level.enemyOrder[i][1]:
				level.SPAWN_POINTS.LEFT:
					baseEnemy.global_position = spawnPointLeft.global_position
				level.SPAWN_POINTS.RIGHT:
					baseEnemy.global_position = spawnPointRight.global_position
				level.SPAWN_POINTS.UP:
					baseEnemy.global_position = spawnPointUp.global_position
				level.SPAWN_POINTS.DOWN:
					baseEnemy.global_position = spawnPointDown.global_position
				

			await get_tree().create_timer(level.enemyOrder[i][2]).timeout
	else:
		print("GAME OVER")

		
			
func update_level(level):
	match level:
		0:
			print("LEVEL ONE")
		1:
			print("LEVEL TWO")
	spawnEnemies()
	
func _on_between_waves_timeout():
	level += 1
	update_level(level)


func _on_between_enemies_timeout():
	canSpawn = true
