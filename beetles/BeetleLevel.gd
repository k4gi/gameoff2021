extends Node

onready var BeetleBox = $Margin/VBox/HBox

var beetle_selected = false
var beetle_name
var song_playing = false

var beetle_to_sound = {
	"Beetle1": "C4",
	"Beetle2": "D4",
	"Beetle3": "E4",
	"Beetle4": "F4",
	"Beetle5": "G4",
	"Beetle6": "A4",
	"Beetle7": "B4"
}


func _ready():
	new_beetle("Beetle1")
	new_beetle("Beetle2")
	new_beetle("Beetle3")
	new_beetle("Beetle4")
	new_beetle("Beetle5")
	new_beetle("Beetle6")
	new_beetle("Beetle7")


func new_beetle(name: String):
	var new_beetle = load("res://beetles/" + name + ".tscn").instance()
	new_beetle.connect("pressed_me", self, "on_beetle_pressed_me")
	new_beetle.connect("pressed", self, "on_beetle_pressed", [name])
	BeetleBox.add_child(new_beetle, true)


func on_beetle_pressed(n):
	if !song_playing:
		if beetle_selected:
			if n != beetle_name:
				var old_index = BeetleBox.get_node(beetle_name).get_index()
				var new_index = BeetleBox.get_node(n).get_index()
				BeetleBox.move_child(BeetleBox.get_node(beetle_name), new_index)
				BeetleBox.move_child(BeetleBox.get_node(n), old_index)
			
			beetle_selected = false
			BeetleBox.get_node(beetle_name + "/BeetleAnim").stop()
			BeetleBox.get_node(beetle_name).set_modulate(Color.white)
		
		else:
			beetle_selected = true
			beetle_name = n
			BeetleBox.get_node(beetle_name + "/BeetleAnim").play("flash")


func play_music():
	if !song_playing:
		song_playing = true
		
		if beetle_selected:
			beetle_selected = false
			BeetleBox.get_node(beetle_name + "/BeetleAnim").stop()
			BeetleBox.get_node(beetle_name).set_modulate(Color.white)
		
		for i in BeetleBox.get_child_count():
			var name = BeetleBox.get_child(i).get_name()
			BeetleBox.get_child(i).get_node("BeetleAnim").play("flash once")
			get_node("Sounds/" + beetle_to_sound[name]).play()
			yield(get_tree().create_timer(1, false), "timeout")
		song_playing = false


func _on_TextureButton_pressed():
	play_music()
