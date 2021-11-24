extends Node2D


const PATH_GRID = preload("res://pathfind/path_grid.gd")

var test_grid


func _ready():
	test_grid = PATH_GRID.new( get_global_position(), Vector2(256, 128), 16 )
	test_grid.grid[0][6].content = PATH_GRID.OBSTACLE
	test_grid.grid[1][6].content = PATH_GRID.OBSTACLE
	test_grid.grid[2][6].content = PATH_GRID.OBSTACLE
	test_grid.grid[3][6].content = PATH_GRID.OBSTACLE
	test_grid.grid[4][6].content = PATH_GRID.OBSTACLE
	test_grid.grid[5][6].content = PATH_GRID.OBSTACLE
	test_grid.grid[5][5].content = PATH_GRID.OBSTACLE
	test_grid.grid[5][4].content = PATH_GRID.OBSTACLE
	test_grid.grid[5][3].content = PATH_GRID.OBSTACLE
	test_grid.grid[5][2].content = PATH_GRID.OBSTACLE
	test_grid.grid[7][10].content = PATH_GRID.OBSTACLE
	test_grid.grid[6][10].content = PATH_GRID.OBSTACLE
	test_grid.grid[5][10].content = PATH_GRID.OBSTACLE
	test_grid.solve_path( Vector2(20,20), Vector2(250,120) )
	show_grid()
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
			elif test_grid.grid[y][x].content == PATH_GRID.OPEN:
				test_grid.tile_textures[y][x].set_modulate(Color("00ff00"))
			elif test_grid.grid[y][x].content == PATH_GRID.CLOSED:
				test_grid.tile_textures[y][x].set_modulate(Color("ff0000"))
			elif test_grid.grid[y][x].content == PATH_GRID.BEGINNING:
				test_grid.tile_textures[y][x].set_modulate(Color("ffff00"))
			elif test_grid.grid[y][x].content == PATH_GRID.DESTINATION:
				test_grid.tile_textures[y][x].set_modulate(Color("0000ff"))
			elif test_grid.grid[y][x].content == PATH_GRID.PATH:
				test_grid.tile_textures[y][x].set_modulate(Color("8c8cff"))
			elif test_grid.tile_textures[y][x].get_modulate() != Color("ffffff"):
				test_grid.tile_textures[y][x].set_modulate(Color("ffffff"))
