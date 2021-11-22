const PATH_NODE = preload("res://pathfind/path_node.gd")
const TILE_TEXTURE = preload("res://pathfind/Tile.tscn")

enum {
	EMPTY,
	OBSTACLE
}

var grid = []
var tile_textures = []


func _init(top_left: Vector2, bottom_right: Vector2, resolution: int):
	# i feel like i'm getting ahead of myself somehow
	#but thats ok. gotta start somewhere.
	var grid_size = bottom_right - top_left
	
	if int(grid_size.x) % resolution > 0 or int(grid_size.y) % resolution > 0:
		print("HELP - grid size doesn't match resolution")
		return
	
	build_grid( grid_size.x / resolution, grid_size.y / resolution )
	build_textures( top_left, resolution, grid_size.x / resolution, grid_size.y / resolution )


func build_grid(size_x: int, size_y: int):
	for y in range(size_y):
		grid.append( [] )
		for x in range(size_x):
			grid[y].append( PATH_NODE.new( EMPTY, x, y ) )


func build_textures(top_left: Vector2, resolution: int, size_x: int, size_y: int):
	for y in range(size_y):
		tile_textures.append( [] )
		for x in range(size_x):
			tile_textures[y].append( TILE_TEXTURE.instance() )
			tile_textures[y][x].set_global_position(Vector2( top_left.x + x*resolution, top_left.y + y*resolution ) )
