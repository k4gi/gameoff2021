const PATH_NODE = preload("res://pathfind/path_node.gd")
const TILE_TEXTURE = preload("res://pathfind/Tile.tscn")

enum {
	EMPTY,
	OBSTACLE,
	OPEN,
	CLOSED,
	BEGINNING,
	DESTINATION
}

var grid = []
var tile_textures = []
var resolution = 0


func _init(top_left: Vector2, bottom_right: Vector2, res: int):
	resolution = res
	var grid_size = bottom_right - top_left
	
	if int(grid_size.x) % resolution > 0 or int(grid_size.y) % resolution > 0:
		print("HELP - grid size doesn't match resolution")
		return
	
	build_grid( grid_size.x / resolution, grid_size.y / resolution )
	build_textures( top_left, grid_size.x / resolution, grid_size.y / resolution )


func build_grid(size_x: int, size_y: int):
	for y in range(size_y):
		grid.append( [] )
		for x in range(size_x):
			grid[y].append( PATH_NODE.new( EMPTY, x, y ) )


func build_textures(top_left: Vector2, size_x: int, size_y: int):
	for y in range(size_y):
		tile_textures.append( [] )
		for x in range(size_x):
			tile_textures[y].append( TILE_TEXTURE.instance() )
			tile_textures[y][x].set_global_position(Vector2( top_left.x + x*resolution, top_left.y + y*resolution ) )


func solve_path(beginning: Vector2, destination: Vector2):
	var beginning_x = beginning.x / resolution
	var beginning_y = beginning.y / resolution
	var destination_x = destination.x / resolution
	var destination_y = destination.y / resolution
	
	grid[beginning_y][beginning_x].content = BEGINNING
	grid[destination_y][destination_x].content = DESTINATION
	
	var open_set = []
	var closed_set = []
	
	open_set.append( grid[beginning_y][beginning_x] )
	
	for n in find_neighbours( open_set[0] ):
		pass #to be continued


func find_cost( node_a: PATH_NODE, node_b: PATH_NODE ):
	var distance_x = abs( node_a.grid_x - node_b.grid_x )
	var distance_y = abs( node_a.grid_y - node_b.grid_y )
	
	if distance_y < distance_x:
		return distance_y * 14 + ( distance_x - distance_y ) * 10
	else:
		return distance_x * 14 + ( distance_y - distance_x ) * 10


func find_neighbours( current_node: PATH_NODE ):
	var neighbours = []
	
	var y = -1
	while y < 2:
		if current_node.grid_y + y < 0 or current_node.grid_y + y >= grid.size():
			pass
		else:
			var x = -1
			while x < 2:
				if current_node.grid_x + x < 0 or current_node.grid_x + x >= grid[y].size():
					pass
				elif y == 0 and x == 0:
					pass
				else:
					neighbours.append( grid[current_node.grid_y + y][current_node.grid_x + x] )
				x += 1
		y += 1
	return neighbours
