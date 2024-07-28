class_name Level

enum ENEMY_TYPES{TRIANGLE, SQUARE, DIAMOND, CIRCLE}
enum SPAWN_POINTS{LEFT, RIGHT, UP, DOWN}

var enemyCount:int
var enemyOrder:Array

func _init(count, order):
	enemyCount = count
	enemyOrder = order
