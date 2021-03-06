extends Node

onready var BeetleBox = $Margin/VBox/HBox
onready var ControlBox = $Margin/VBox/HBoxControls

var beetle_selected = false
var beetle_index
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
	make_beetle("Beetle1")
	make_beetle("Beetle2")
	make_beetle("Beetle3")
	make_beetle("Beetle4")
	make_beetle("Beetle5")
	make_beetle("Beetle6")
	make_beetle("Beetle7")


func make_beetle(type: String):
	var new_beetle = load("res://beetles/BeetleGeneric.tscn").instance()
	new_beetle.beetle_type = type
	new_beetle.set_normal_texture( load("res://beetles/" + type + ".png") )
	new_beetle.connect("pressed", self, "on_beetle_pressed", [new_beetle])
	BeetleBox.add_child(new_beetle, true)


func make_beetle_control(type: String):
	var new_beetle = load("res://beetles/BeetleGeneric.tscn").instance()
	new_beetle.beetle_type = type
	new_beetle.set_normal_texture( load("res://beetles/" + type + ".png") )
	new_beetle.connect("pressed", self, "on_beetle_control_pressed", [new_beetle])
	ControlBox.add_child(new_beetle, true)
	yield(get_tree(), "idle_frame")
	new_beetle.set_scale(Vector2(0.5, 0.5))


func on_beetle_pressed(n):
	if !song_playing:
		if beetle_selected:
			if n.get_index() != beetle_index:
				var old_index = beetle_index
				var new_index = n.get_index()
				BeetleBox.move_child(BeetleBox.get_child(beetle_index), new_index)
				BeetleBox.move_child(n, old_index)
				beetle_index = new_index
			
			cancel_selection()
		
		else:
			beetle_selected = true
			beetle_index = n.get_index()
			n.get_node("BeetleAnim").play("flash")


func on_beetle_control_pressed(n):
	#uhh idk
	pass


func play_music():
	if !song_playing:
		song_playing = true
		
		if beetle_selected:
			cancel_selection()
		
		for i in BeetleBox.get_child_count():
			var type = BeetleBox.get_child(i).beetle_type
			BeetleBox.get_child(i).get_node("BeetleAnim").play("flash once")
			get_node("Sounds/" + beetle_to_sound[type]).play()
			yield(get_tree().create_timer(1, false), "timeout")
		song_playing = false


func cancel_selection():
	beetle_selected = false
	BeetleBox.get_child(beetle_index).get_node("BeetleAnim").stop()
	BeetleBox.get_child(beetle_index).set_modulate(Color.white)


func _on_TextureButton_pressed():
	play_music()


func _unhandled_input(event):
	if event.is_action_pressed("print_screen"):
		# wait for frame to finish drawing
		yield(VisualServer, "frame_post_draw")
		# grab image
		var image = get_viewport().get_texture().get_data()
		# and flip on y axis because it's upside down for some reason
		image.flip_y()
		
		#get current date and time for filename
		var datetime = OS.get_datetime()
		var year = "%04d" % datetime["year"]
		var month = "%02d" % datetime["month"]
		var day = "%02d" % datetime["day"]
		var hour = "%02d" % datetime["hour"]
		var minute = "%02d" % datetime["minute"]
		var second = "%02d" % datetime["second"]
		var fulltime = year + "-" + month + "-" + day + " " + hour + "." + minute + "." + second
		
		# save to file
		image.save_png("user://" + fulltime + " " + ProjectSettings.get_setting("application/config/name") + " screenshot.png")
