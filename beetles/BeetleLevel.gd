extends Node

onready var BeetleBox = $Margin/HBox


func _ready():
	new_beetle("Beetle1")
	new_beetle("Beetle2")
#	new_beetle("Beetle3")
#	new_beetle("Beetle4")


func new_beetle(name: String):
	var new_beetle = load("res://beetles/" + name + ".tscn").instance()
	new_beetle.connect("pressed_me", self, "on_beetle_pressed_me")
	BeetleBox.add_child(new_beetle)


func on_beetle_pressed_me(me):
	BeetleBox.move_child(me, 0)
