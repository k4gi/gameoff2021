extends Node2D


const PATH_GRID = preload("res://pathfind/path_grid.gd")

var test_grid


func _ready():
	test_grid = PATH_GRID.new( get_global_position(), Vector2(256, 128), 16 )
	show_grid()
	test_grid.grid[4][4].content = PATH_GRID.OBSTACLE
	refresh_grid()


func show_grid():
	for y in test_grid.grid.size():
		for x in test_grid.grid[y].size():
			add_child(test_grid.tile_textures[y][x])


func refresh_grid():
	for y in test_grid.grid.size():
		for x in test_grid.grid[y].size():
			if test_grid.grid[y][x].content == PATH_GRID.OBSTACLE:
				test_grid.tile_textures[y][x].set_modulate(Color("000000"))
			elif test_grid.tile_textures[y][x].get_modulate() != Color("ffffff"):
				test_grid.tile_textures[y][x].set_modulate(Color("ffffff"))
