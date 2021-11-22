extends Node2D


const PATH_GRID = preload("res://pathfind/path_grid.gd")

var test_grid


func _ready():
	test_grid = PATH_GRID.new( get_global_position(), Vector2(256, 128), 16 )
	show_grid()


func show_grid():
	for y in test_grid.grid.size():
		for x in test_grid.grid[y].size():
			add_child(test_grid.tile_textures[y][x])
