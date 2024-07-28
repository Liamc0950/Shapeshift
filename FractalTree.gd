@tool
extends Node2D

func _draw():
	#draw_line(Vector2.ZERO, Vector2.RIGHT * 300, Color.WHITE, 8.0)
	drawTree(0, 0, 45, 10)

func _ready():
	queue_redraw()

func drawTree(x1, y1, angle, depth):
	var fork_angle = 20
	var base_len = 10.0
	if depth > 0:
		var x2 = x1 + int(cos(deg_to_rad(angle)) * depth * base_len)
		var y2 = y1 + int(sin(deg_to_rad(angle)) * depth * base_len)
		draw_line(Vector2(x1, y1), Vector2(x2, y2), Color(220 / 255.0, 107 / 255.0, 173 / 255.0), 2.0)
		drawTree(x2, y2, angle - fork_angle, depth - 1)
		drawTree(x2, y2, angle + fork_angle, depth - 1)
