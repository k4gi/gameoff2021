var grid_x
var grid_y

var content

var heap_index

var g_cost = -1
var h_cost = -1
var parent = null


func _init(input, x, y):
	content = input
	grid_x = x
	grid_y = y


func get_f_cost():
	return g_cost + h_cost


func compare(rival):
	# if negative, higher priority for heap
	return self.get_f_cost() - rival.get_f_cost()
